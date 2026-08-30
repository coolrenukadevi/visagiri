<?php
/**
 * Live exchange rates for the above-footer widget.
 *
 * Flow (never the browser -> API directly):
 *     XE Currency Data API  ->  this PHP module  ->  file cache  ->  page
 *
 * Credentials come from the environment (XE_ACCOUNT_ID / XE_API_KEY). They are
 * never emitted into HTML or JS, and .htaccess blocks /cache and /.env from
 * being served even if the files were somehow placed in the web root.
 *
 * Behaviour that matters:
 *  - Rates are cached; the API is NOT called on every page load.
 *  - A page render never waits on a slow API: if the cache is merely stale we
 *    serve the stale value immediately and let the next cron/refresh update it.
 *    (Set CURRENCY_REFRESH_ON_REQUEST=1 to allow one blocking refresh instead.)
 *  - If the API fails we keep showing the last good rate + its timestamp.
 *  - If no rate has EVER been fetched we show an honest "unavailable" state
 *    rather than inventing a number.
 */
declare(strict_types=1);

require_once __DIR__ . '/../includes/config.php';

const CURRENCY_PAIRS       = ['USD', 'EUR'];   // -> INR
const CURRENCY_QUOTE       = 'INR';
const CURRENCY_TTL         = 6 * 3600;         // 6h — well inside typical XE plan limits
const CURRENCY_HTTP_TIMEOUT = 4;               // seconds, hard cap
const CURRENCY_CACHE_FILE  = 'currency-rates.json';

function currency_cache_path(): string
{
    return CACHE_PATH . '/' . CURRENCY_CACHE_FILE;
}

function currency_read_cache(): ?array
{
    $path = currency_cache_path();
    if (!is_readable($path)) {
        return null;
    }
    $raw = @file_get_contents($path);
    if ($raw === false) {
        return null;
    }
    $data = json_decode($raw, true);
    if (!is_array($data) || !isset($data['rates'], $data['fetched_at']) || !is_array($data['rates'])) {
        return null;
    }
    return $data;
}

function currency_write_cache(array $rates): void
{
    if (!is_dir(CACHE_PATH)) {
        @mkdir(CACHE_PATH, 0775, true);
    }
    $payload = json_encode(
        ['rates' => $rates, 'fetched_at' => time()],
        JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES
    );
    // Atomic replace so a concurrent reader never sees a half-written file.
    $tmp = currency_cache_path() . '.' . getmypid() . '.tmp';
    if (@file_put_contents($tmp, $payload, LOCK_EX) !== false) {
        @rename($tmp, currency_cache_path());
    }
}

/**
 * Calls the XE Currency Data API (HTTP Basic auth, account id + API key).
 * Returns ['USD' => 83.12, ...] or null on any failure.
 */
function currency_fetch_remote(): ?array
{
    $account = env('XE_ACCOUNT_ID');
    $key     = env('XE_API_KEY');
    if (!$account || !$key) {
        log_error('currency: XE_ACCOUNT_ID / XE_API_KEY not configured');
        return null;
    }

    $endpoint = rtrim((string) env('XE_API_BASE', 'https://xecdapi.xe.com/v1'), '/')
        . '/convert_to.json/?to=' . rawurlencode(CURRENCY_QUOTE)
        . '&from=' . rawurlencode(implode(',', CURRENCY_PAIRS))
        . '&amount=1';

    $ch = curl_init($endpoint);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_USERPWD        => $account . ':' . $key,
        CURLOPT_HTTPAUTH       => CURLAUTH_BASIC,
        CURLOPT_TIMEOUT        => CURRENCY_HTTP_TIMEOUT,
        CURLOPT_CONNECTTIMEOUT => 3,
        CURLOPT_SSL_VERIFYPEER => true,
        CURLOPT_SSL_VERIFYHOST => 2,
        CURLOPT_USERAGENT      => 'Convercession/1.0',
        CURLOPT_FOLLOWLOCATION => false,
    ]);
    $body   = curl_exec($ch);
    $status = curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    $err    = curl_error($ch);
    curl_close($ch);

    if ($body === false || $status !== 200) {
        log_error(sprintf('currency: XE request failed (http=%d curl=%s)', $status, $err ?: 'none'));
        return null;
    }

    $json = json_decode((string) $body, true);
    if (!is_array($json) || empty($json['to']) || !is_array($json['to'])) {
        log_error('currency: XE response malformed');
        return null;
    }

    // convert_to returns: { to: [ { quotecurrency: "USD", mid: 0.012 }, ... ] }
    // "mid" there is QUOTE->INR inverted, so normalise carefully: we asked for
    // amount=1 of each `from` currency expressed in INR, so `mid` is the INR value.
    $rates = [];
    foreach ($json['to'] as $row) {
        $code = $row['quotecurrency'] ?? null;
        $mid  = $row['mid'] ?? null;
        if (is_string($code) && is_numeric($mid) && (float) $mid > 0) {
            $rates[strtoupper($code)] = round((float) $mid, 4);
        }
    }
    foreach (CURRENCY_PAIRS as $want) {
        if (!isset($rates[$want])) {
            log_error('currency: XE response missing pair ' . $want);
            return null;
        }
    }
    return $rates;
}

/**
 * Public entry point used by the widget.
 *
 * @return array{rates: array<string,float>, fetched_at: ?int, stale: bool, available: bool}
 */
function currency_rates(): array
{
    $cache   = currency_read_cache();
    $now     = time();
    $isFresh = $cache && ($now - (int) $cache['fetched_at']) < CURRENCY_TTL;

    if ($isFresh) {
        return ['rates' => $cache['rates'], 'fetched_at' => (int) $cache['fetched_at'], 'stale' => false, 'available' => true];
    }

    // Refreshing inside a page request is opt-in: by default a cron/CLI job
    // does it, so no visitor ever pays the API latency (spec §18 "do not allow
    // the currency API to delay page rendering").
    $mayRefresh = env('CURRENCY_REFRESH_ON_REQUEST', '0') === '1' || PHP_SAPI === 'cli';
    if ($mayRefresh) {
        $fresh = currency_fetch_remote();
        if ($fresh) {
            currency_write_cache($fresh);
            return ['rates' => $fresh, 'fetched_at' => time(), 'stale' => false, 'available' => true];
        }
    }

    if ($cache) {
        // API down or refresh deferred — keep showing the last good rate.
        return ['rates' => $cache['rates'], 'fetched_at' => (int) $cache['fetched_at'], 'stale' => true, 'available' => true];
    }

    // Never fetched successfully. Show an honest empty state; do NOT invent a rate.
    return ['rates' => [], 'fetched_at' => null, 'stale' => false, 'available' => false];
}

/** Formats a UTC timestamp in IST, matching the spec's example format. */
function currency_timestamp(?int $ts): string
{
    if (!$ts) {
        return '';
    }
    $dt = new DateTimeImmutable('@' . $ts);
    return $dt->setTimezone(new DateTimeZone('Asia/Kolkata'))->format('d M Y, H:i') . ' IST';
}
