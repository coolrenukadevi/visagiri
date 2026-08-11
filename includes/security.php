<?php
declare(strict_types=1);

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
 * Very small per-key rate limiter backed by the session, good enough
 * for login/contact-form abuse until a shared store (Redis/DB) is
 * introduced. $key should already include the caller's IP.
 */
function rate_limit_check(string $key, int $maxAttempts, int $windowSeconds): bool
{
    $now = time();
    $bucket = $_SESSION['rate_limits'][$key] ?? ['count' => 0, 'reset_at' => $now + $windowSeconds];

    if ($now > $bucket['reset_at']) {
        $bucket = ['count' => 0, 'reset_at' => $now + $windowSeconds];
    }

    $bucket['count']++;
    $_SESSION['rate_limits'][$key] = $bucket;

    return $bucket['count'] <= $maxAttempts;
}
