<?php
/**
 * Session-based auth for the Forex customer portal. Mirrors the shape of
 * includes/partner-auth.php (require/session helpers, session_regenerate_id
 * on success) but there is no separate account/password — a "login" is
 * just a mobile number verified by a fresh email OTP each time (see
 * includes/forex-otp.php-equivalent helpers in forex-db.php), scoped to a
 * distinct $_SESSION['forex_customer_mobile'] key so it can never collide
 * with $_SESSION['admin_user'] or $_SESSION['partner_user'] in the same
 * browser session.
 */
require_once __DIR__ . '/forex-db.php';

session_start();

function forex_customer_require_login(): void
{
    if (empty($_SESSION['forex_customer_mobile'])) {
        header('Location: forex-login');
        exit;
    }
}

function forex_customer_logged_in(): bool
{
    return !empty($_SESSION['forex_customer_mobile']);
}

/** The normalized (last-10-digit) mobile number every portal query is scoped to. */
function forex_customer_mobile(): string
{
    return $_SESSION['forex_customer_mobile'] ?? '';
}

function forex_customer_name(): string
{
    return $_SESSION['forex_customer_name'] ?? 'Customer';
}

/** Called once forex_verify_customer_otp() has already succeeded. */
function forex_customer_login_session(PDO $pdo, string $mobile): void
{
    $digits = forex_normalize_mobile($mobile);
    $_SESSION['forex_customer_mobile'] = $digits;
    $_SESSION['forex_customer_name'] = forex_customer_display_name($pdo, $digits);
    session_regenerate_id(true);
}

function forex_customer_logout(): void
{
    unset($_SESSION['forex_customer_mobile'], $_SESSION['forex_customer_name']);
    session_regenerate_id(true);
}
