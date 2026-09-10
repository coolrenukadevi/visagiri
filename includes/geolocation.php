<?php
declare(strict_types=1);

/**
 * Best-effort IP -> approximate location lookup for the Login Audit
 * page (admin/pages/login-audit.php) only — never called from the
 * login request itself, so a slow/unreachable lookup can never add
 * latency to an actual sign-in. No API key, no vendor SDK: a single
 * short-timeout request to ip-api.com's free/keyless endpoint (same
 * zero-dependency, hand-rolled-over-stdlib approach as includes/mail.php's
 * SMTP client), with every result cached in ip_geolocation_cache so a
 * given IP is only ever looked up once. Like send_mail(), this can
 * never throw and never blocks a page render on failure — it degrades
 * to "Unknown" location, same non-fatal contract used everywhere else
 * outbound network calls appear in this project. This dev sandbox has
 * no outbound network access at all, so (also like SMTP) the live-fetch
 * success path is unverified here — only the "unreachable -> failed,
 * cached, page still renders" path is testable in this environment.
 */

/** True for loopback/private/link-local/reserved ranges — geolocation is meaningless for these, so they're never looked up. */
function ip_is_public(string $ip): bool
{
    return filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE) !== false;
}

/**
 * Resolves one IP to an approximate location, using the cache first.
 * Returns ['status' => 'resolved'|'failed'|'private', 'country' => ?string, 'region' => ?string, 'city' => ?string].
 * A 'failed' result is cached too (not retried on every page view) —
 * an admin re-opening the page later will still show "Unknown" for
 * that IP until the cache row is manually cleared, which is an
 * acceptable trade-off against re-attempting a slow timeout on every
 * single page load.
 */
function resolve_ip_location(?string $ip): array
{
    $unknown = ['status' => 'failed', 'country' => null, 'region' => null, 'city' => null];
    if ($ip === null || $ip === '') {
        return $unknown;
    }

    $pdo = db();
    $stmt = $pdo->prepare('SELECT country, region, city, lookup_status FROM ip_geolocation_cache WHERE ip_address = :ip');
    $stmt->execute(['ip' => $ip]);
    $cached = $stmt->fetch();
    if ($cached) {
        return ['status' => $cached['lookup_status'], 'country' => $cached['country'], 'region' => $cached['region'], 'city' => $cached['city']];
    }

    if (!ip_is_public($ip)) {
        $result = ['status' => 'private', 'country' => null, 'region' => null, 'city' => null];
        cache_ip_location($ip, $result);
        return $result;
    }

    $result = $unknown;
    try {
        $context = stream_context_create(['http' => ['timeout' => 2, 'ignore_errors' => true]]);
        $response = @file_get_contents('http://ip-api.com/json/' . urlencode($ip) . '?fields=status,country,regionName,city', false, $context);
        if ($response !== false) {
            $data = json_decode($response, true);
            if (is_array($data) && ($data['status'] ?? '') === 'success') {
                $result = [
                    'status' => 'resolved',
                    'country' => $data['country'] ?? null,
                    'region' => $data['regionName'] ?? null,
                    'city' => $data['city'] ?? null,
                ];
            }
        }
    } catch (Throwable $e) {
        error_log('IP geolocation lookup failed for ' . $ip . ': ' . $e->getMessage());
    }

    cache_ip_location($ip, $result);
    return $result;
}

function cache_ip_location(string $ip, array $result): void
{
    db()->prepare(
        'INSERT INTO ip_geolocation_cache (ip_address, country, region, city, lookup_status) VALUES (:ip, :country, :region, :city, :status)
         ON DUPLICATE KEY UPDATE country = VALUES(country), region = VALUES(region), city = VALUES(city), lookup_status = VALUES(lookup_status), resolved_at = NOW()'
    )->execute([
        'ip' => $ip,
        'country' => $result['country'],
        'region' => $result['region'],
        'city' => $result['city'],
        'status' => $result['status'],
    ]);
}

/** Formats a resolve_ip_location() result as a short display string for the audit table. */
function format_ip_location(array $result): string
{
    return match ($result['status']) {
        'private' => 'Local / Private Network',
        'resolved' => implode(', ', array_filter([$result['city'], $result['region'], $result['country']])) ?: 'Unknown',
        default => 'Unknown',
    };
}
