<?php
declare(strict_types=1);

/**
 * Live-ish USD -> INR indicative rate for the header widget. Not the
 * Forex module's real quote engine (forex_rates, admin-maintained,
 * used for actual currency-buy transactions) — this is a
 * publicity/informational number only, explicitly labeled
 * "indicative" wherever it's shown, per the client's own instruction
 * not to present it as a final buy/sell rate.
 *
 * Frankfurter (frankfurter.app) is used because it needs no API key —
 * nothing to leak, nothing to keep server-side-only by policy, since
 * there's no secret to begin with. Cached to storage/cache/ with a
 * 1-hour TTL so normal traffic doesn't hit the upstream API on every
 * request; a stale cache is served (clearly marked) if the upstream
 * is unreachable, and the widget degrades to hiding the number
 * entirely if there's never been a successful fetch. Every failure
 * path is caught — a currency API outage must never break the header.
 */

const CURRENCY_RATE_CACHE_FILE = __DIR__ . '/../storage/cache/usd-inr-rate.json';
const CURRENCY_RATE_TTL_SECONDS = 3600;
const CURRENCY_RATE_FETCH_TIMEOUT_SECONDS = 4;

/**
 * @return array{rate: ?float, as_of: ?int, stale: bool}
 */
function get_usd_inr_rate(): array
{
    $cached = currency_rate_read_cache();

    if ($cached !== null && (time() - $cached['as_of']) < CURRENCY_RATE_TTL_SECONDS) {
        return ['rate' => $cached['rate'], 'as_of' => $cached['as_of'], 'stale' => false];
    }

    $fetched = currency_rate_fetch_live();
    if ($fetched !== null) {
        currency_rate_write_cache($fetched);
        return ['rate' => $fetched, 'as_of' => time(), 'stale' => false];
    }

    if ($cached !== null) {
        return ['rate' => $cached['rate'], 'as_of' => $cached['as_of'], 'stale' => true];
    }

    return ['rate' => null, 'as_of' => null, 'stale' => false];
}

function currency_rate_read_cache(): ?array
{
    if (!is_file(CURRENCY_RATE_CACHE_FILE)) {
        return null;
    }
    $raw = @file_get_contents(CURRENCY_RATE_CACHE_FILE);
    if ($raw === false) {
        return null;
    }
    $data = json_decode($raw, true);
    if (!is_array($data) || !isset($data['rate'], $data['as_of'])) {
        return null;
    }
    return ['rate' => (float) $data['rate'], 'as_of' => (int) $data['as_of']];
}

function currency_rate_write_cache(float $rate): void
{
    $dir = dirname(CURRENCY_RATE_CACHE_FILE);
    if (!is_dir($dir)) {
        @mkdir($dir, 0755, true);
    }
    @file_put_contents(CURRENCY_RATE_CACHE_FILE, json_encode(['rate' => $rate, 'as_of' => time()]));
}

function currency_rate_fetch_live(): ?float
{
    try {
        if (!function_exists('curl_init')) {
            return null;
        }
        $ch = curl_init('https://api.frankfurter.app/latest?from=USD&to=INR');
        curl_setopt_array($ch, [
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_TIMEOUT => CURRENCY_RATE_FETCH_TIMEOUT_SECONDS,
            CURLOPT_CONNECTTIMEOUT => CURRENCY_RATE_FETCH_TIMEOUT_SECONDS,
            CURLOPT_SSL_VERIFYPEER => true,
            CURLOPT_FOLLOWLOCATION => false,
            CURLOPT_PROTOCOLS => CURLPROTO_HTTPS,
        ]);
        $body = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        if ($body === false || $httpCode !== 200) {
            return null;
        }

        $data = json_decode($body, true);
        $rate = $data['rates']['INR'] ?? null;
        if (!is_numeric($rate) || $rate <= 0 || $rate > 1000) {
            // Sanity-bound: a currency API returning something wildly
            // outside plausible USD/INR territory is more likely a
            // malformed response than a real rate — safer to treat it
            // as unavailable than to display it as fact.
            return null;
        }
        return (float) $rate;
    } catch (Throwable $e) {
        return null;
    }
}
