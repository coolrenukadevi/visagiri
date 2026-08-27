<?php
/**
 * Live currency-rate widget: fetch, cache and serve indicative FX rates
 * for the header ticker. Pairs are config-driven so EUR->INR, GBP->INR
 * etc. can be added later by extending EXCHANGE_RATE_PAIRS below — no
 * other code (endpoint, header markup, JS) needs to change.
 *
 * Data source: Frankfurter (api.frankfurter.app) — a free, no-API-key
 * service built on European Central Bank reference rates. Not scraped
 * HTML; a proper JSON API.
 *
 * Rates are cached to a local JSON file and only re-fetched from the
 * live API when the cache is older than EXCHANGE_RATE_MAX_AGE. If the
 * live fetch fails for any reason (network, timeout, malformed
 * response), the last cached rate is returned instead — the header
 * never breaks or shows nothing just because the upstream API had a
 * bad moment.
 */

const EXCHANGE_RATE_PAIRS = [
    'USD_INR' => ['from' => 'USD', 'to' => 'INR', 'label' => 'USD &rarr; INR'],
    // Add more pairs here later — nothing else needs to change:
    // 'EUR_INR' => ['from' => 'EUR', 'to' => 'INR', 'label' => 'EUR &rarr; INR'],
    // 'GBP_INR' => ['from' => 'GBP', 'to' => 'INR', 'label' => 'GBP &rarr; INR'],
];

const EXCHANGE_RATE_MAX_AGE = 1800; // re-check the live API at most every 30 minutes
const EXCHANGE_RATE_FETCH_TIMEOUT = 4; // seconds — never let a slow upstream hang a page

function exchange_rate_cache_path(): string
{
    return __DIR__ . '/../data/exchange-rates-cache.json';
}

function exchange_rate_read_cache(): array
{
    $path = exchange_rate_cache_path();
    if (!is_file($path)) {
        return [];
    }
    $raw = @file_get_contents($path);
    if ($raw === false || $raw === '') {
        return [];
    }
    $data = json_decode($raw, true);
    return is_array($data) ? $data : [];
}

function exchange_rate_write_cache(array $data): void
{
    $path = exchange_rate_cache_path();
    $tmp = $path . '.' . uniqid('', true) . '.tmp';
    if (@file_put_contents($tmp, json_encode($data, JSON_PRETTY_PRINT)) !== false) {
        @rename($tmp, $path);
    }
}

/**
 * Calls the exchange-rate API for one currency pair. Returns a float
 * rate, or null on any failure — callers fall back to the cache rather
 * than letting a flaky upstream break the page.
 */
function exchange_rate_fetch_live(string $from, string $to): ?float
{
    $url = 'https://api.frankfurter.app/latest?from=' . rawurlencode($from) . '&to=' . rawurlencode($to);
    $raw = false;

    if (function_exists('curl_init')) {
        $ch = curl_init($url);
        curl_setopt_array($ch, [
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_CONNECTTIMEOUT => EXCHANGE_RATE_FETCH_TIMEOUT,
            CURLOPT_TIMEOUT => EXCHANGE_RATE_FETCH_TIMEOUT,
            CURLOPT_USERAGENT => 'VisaAgency.in/1.0',
            CURLOPT_SSL_VERIFYPEER => true,
            CURLOPT_SSL_VERIFYHOST => 2,
        ]);
        $raw = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        if ($raw === false || $httpCode !== 200) {
            $raw = false;
        }
    }

    if ($raw === false && ini_get('allow_url_fopen')) {
        $context = stream_context_create([
            'http' => [
                'method' => 'GET',
                'timeout' => EXCHANGE_RATE_FETCH_TIMEOUT,
                'header' => "User-Agent: VisaAgency.in/1.0\r\n",
                'ignore_errors' => true,
            ],
        ]);
        $raw = @file_get_contents($url, false, $context);
    }

    if ($raw === false || $raw === '') {
        return null;
    }

    $data = json_decode($raw, true);
    $rate = $data['rates'][$to] ?? null;
    return is_numeric($rate) ? (float) $rate : null;
}

/**
 * Fast, network-free read for use directly in page templates (the
 * header renders on every single page load, so it must never wait on
 * an outbound HTTP call). Only ever touches the local cache file.
 * Returns null if no cache row exists yet for this pair — the header
 * then simply omits the widget until the client-side poll in
 * currency-rate.js fills it in a moment after the page has loaded.
 */
function exchange_rate_get_cached_only(string $pairKey): ?array
{
    if (!isset(EXCHANGE_RATE_PAIRS[$pairKey])) {
        return null;
    }
    $pair = EXCHANGE_RATE_PAIRS[$pairKey];
    $cached = exchange_rate_read_cache()[$pairKey] ?? null;
    if (!$cached) {
        return null;
    }
    $isFresh = (time() - strtotime($cached['updated_at'])) < EXCHANGE_RATE_MAX_AGE;
    return [
        'pair' => $pairKey,
        'label' => $pair['label'],
        'rate' => $cached['rate'],
        'updated_at' => $cached['updated_at'],
        'stale' => !$isFresh,
    ];
}

/**
 * Full cache-aside lookup: reads the cache, and — only when it is
 * missing or stale — makes a live outbound call to refresh it. This is
 * deliberately NOT used by the header template itself (a slow or
 * unreachable upstream must never delay a page render); it backs the
 * exchange-rate.php endpoint instead, which the header polls
 * asynchronously via currency-rate.js after the page has already
 * painted. Returns null only if a live fetch has never succeeded and
 * no cache exists at all yet.
 */
function exchange_rate_get(string $pairKey): ?array
{
    if (!isset(EXCHANGE_RATE_PAIRS[$pairKey])) {
        return null;
    }
    $pair = EXCHANGE_RATE_PAIRS[$pairKey];
    $cache = exchange_rate_read_cache();
    $cached = $cache[$pairKey] ?? null;

    $isFresh = $cached && (time() - strtotime($cached['updated_at'])) < EXCHANGE_RATE_MAX_AGE;
    if ($isFresh) {
        return [
            'pair' => $pairKey,
            'label' => $pair['label'],
            'rate' => $cached['rate'],
            'updated_at' => $cached['updated_at'],
            'stale' => false,
        ];
    }

    $liveRate = exchange_rate_fetch_live($pair['from'], $pair['to']);
    if ($liveRate !== null) {
        $now = gmdate('c');
        $cache[$pairKey] = ['rate' => $liveRate, 'updated_at' => $now];
        exchange_rate_write_cache($cache);
        return [
            'pair' => $pairKey,
            'label' => $pair['label'],
            'rate' => $liveRate,
            'updated_at' => $now,
            'stale' => false,
        ];
    }

    // Live fetch failed — serve the last known cached rate rather than
    // breaking the header, even if it's now older than the refresh window.
    if ($cached) {
        return [
            'pair' => $pairKey,
            'label' => $pair['label'],
            'rate' => $cached['rate'],
            'updated_at' => $cached['updated_at'],
            'stale' => true,
        ];
    }

    return null;
}
