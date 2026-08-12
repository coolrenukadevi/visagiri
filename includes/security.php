<?php
declare(strict_types=1);

/**
 * Starts a session with hardened cookie params. Must run before any
 * output. Safe to call multiple times. Still needed without an
 * account system: CSRF tokens, flash messages, and the enquiry-form
 * rate limiter's per-request state all ride on the session.
 */
function start_secure_session(): void
{
    if (session_status() === PHP_SESSION_ACTIVE) {
        return;
    }

    session_set_cookie_params([
        'lifetime' => 0,
        'path' => '/',
        'domain' => '',
        'secure' => env('SESSION_SECURE_COOKIE', 'true') !== 'false',
        'httponly' => true,
        'samesite' => 'Lax',
    ]);

    session_name('visagiri_session');
    session_start();

    // Rotate the session ID periodically to limit fixation/hijack windows.
    if (empty($_SESSION['_started_at'])) {
        $_SESSION['_started_at'] = time();
    } elseif (time() - $_SESSION['_started_at'] > 900) {
        session_regenerate_id(true);
        $_SESSION['_started_at'] = time();
    }
}

/**
 * Sends the baseline security headers on every response. Called once
 * from the front controller before any output.
 */
function send_security_headers(): void
{
    header('X-Content-Type-Options: nosniff');
    header('X-Frame-Options: DENY');
    header('Referrer-Policy: strict-origin-when-cross-origin');
    header('Permissions-Policy: geolocation=(), microphone=(), camera=()');
    header("Content-Security-Policy: default-src 'self'; img-src 'self' data:; style-src 'self' 'unsafe-inline'; script-src 'self'; frame-ancestors 'none'");
    // Browsers ignore this entirely over plain HTTP (harmless in local
    // dev), and public/.htaccess already forces HTTP -> HTTPS, so this
    // just closes the one-request gap before that redirect lands and
    // pins HTTPS for a year once it does.
    header('Strict-Transport-Security: max-age=31536000; includeSubDomains');
}

/**
 * Returns the current request's CSRF token, generating one into the
 * session on first call.
 */
function csrf_token(): string
{
    if (empty($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }
    return $_SESSION['csrf_token'];
}

function csrf_field(): string
{
    return '<input type="hidden" name="csrf_token" value="' . e(csrf_token()) . '">';
}

/**
 * Verifies a submitted token against the session token using a
 * timing-safe comparison. Call at the top of every POST handler.
 */
function csrf_verify(?string $submittedToken): bool
{
    if (empty($_SESSION['csrf_token']) || $submittedToken === null) {
        return false;
    }
    return hash_equals($_SESSION['csrf_token'], $submittedToken);
}

function csrf_require(): void
{
    if (!csrf_verify($_POST['csrf_token'] ?? null)) {
        http_response_code(419);
        exit('Your session expired or the form was resubmitted. Please go back and try again.');
    }
}

/**
 * Per-key rate limiter backed by a single JSON file under storage/
 * (see includes/config.php's STORAGE_PATH) rather than a database —
 * this app has no database to back it with. Deliberately NOT
 * session-based: a session-backed limiter can be bypassed entirely by
 * an attacker who just doesn't send the session cookie back, which
 * defeats the point for exactly the enquiry-form abuse this exists to
 * stop. $key should already include the caller's IP.
 *
 * flock()'d read-modify-write on one shared file is fine at this
 * site's traffic volume (a handful of form submissions, not a
 * high-concurrency API) and needs nothing beyond a writable directory
 * — no cron, no separate service, no DB.
 */
function rate_limit_check(string $key, int $maxAttempts, int $windowSeconds): bool
{
    $file = STORAGE_PATH . '/rate-limits.json';
    $handle = fopen($file, 'c+');
    if ($handle === false) {
        // Can't persist state — fail open rather than blocking every
        // submission because a directory permission is wrong.
        return true;
    }

    flock($handle, LOCK_EX);
    $raw = stream_get_contents($handle);
    $data = $raw !== false && $raw !== '' ? json_decode($raw, true) : [];
    if (!is_array($data)) {
        $data = [];
    }

    $now = time();
    $entry = $data[$key] ?? ['count' => 0, 'started_at' => $now];
    if ($now - $entry['started_at'] > $windowSeconds) {
        $entry = ['count' => 1, 'started_at' => $now];
    } else {
        $entry['count']++;
    }
    $data[$key] = $entry;

    // Prune expired keys so the file doesn't grow forever.
    foreach ($data as $k => $v) {
        if ($now - $v['started_at'] > $windowSeconds) {
            unset($data[$k]);
        }
    }
    $data[$key] = $entry;

    ftruncate($handle, 0);
    rewind($handle);
    fwrite($handle, json_encode($data));
    fflush($handle);
    flock($handle, LOCK_UN);
    fclose($handle);

    return $entry['count'] <= $maxAttempts;
}
