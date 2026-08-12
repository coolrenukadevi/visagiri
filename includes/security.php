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
        'secure' => SESSION_SECURE_COOKIE,
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
 * Per-key rate limiter backed by the `rate_limits` table — deliberately
 * NOT session-based. A session-backed limiter can be bypassed entirely
 * by an attacker who just doesn't send the session cookie back (a
 * fresh session means a fresh, empty counter), which defeats the point
 * for exactly the login/enquiry-form abuse this exists to stop. $key
 * should already include the caller's IP.
 */
function rate_limit_check(string $key, int $maxAttempts, int $windowSeconds): bool
{
    $pdo = db();

    // The whole expiry comparison happens in MySQL's own clock domain
    // (NOW() vs. the stored window_started_at) rather than in PHP —
    // comparing a MySQL-generated timestamp string via PHP's
    // strtotime() against PHP's time() silently breaks the moment the
    // DB server and PHP process disagree on default timezone. Doing it
    // in SQL sidesteps that entirely.
    $stmt = $pdo->prepare(
        'INSERT INTO rate_limits (rate_key, attempt_count, window_started_at)
         VALUES (:key, 1, NOW())
         ON DUPLICATE KEY UPDATE
             attempt_count = IF(window_started_at + INTERVAL :window1 SECOND < NOW(), 1, attempt_count + 1),
             window_started_at = IF(window_started_at + INTERVAL :window2 SECOND < NOW(), NOW(), window_started_at)'
    );
    $stmt->execute(['key' => $key, 'window1' => $windowSeconds, 'window2' => $windowSeconds]);

    $select = $pdo->prepare('SELECT attempt_count FROM rate_limits WHERE rate_key = :key');
    $select->execute(['key' => $key]);
    $attemptCount = (int) $select->fetchColumn();

    return $attemptCount <= $maxAttempts;
}
