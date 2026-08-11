<?php
declare(strict_types=1);

/**
 * Starts a session with hardened cookie params. Must run before any
 * output. Safe to call multiple times.
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

function current_user_id(): ?int
{
    return $_SESSION['user_id'] ?? null;
}

function current_user(): ?array
{
    $userId = current_user_id();
    if ($userId === null) {
        return null;
    }

    static $cached = null;
    if ($cached !== null && $cached['id'] === $userId) {
        return $cached;
    }

    $stmt = db()->prepare(
        'SELECT u.id, u.full_name, u.email, u.mobile, u.role_id, r.name AS role_name, u.status
         FROM users u JOIN roles r ON r.id = u.role_id
         WHERE u.id = :id AND u.deleted_at IS NULL AND u.status = "active"'
    );
    $stmt->execute(['id' => $userId]);
    $user = $stmt->fetch();

    $cached = $user ?: null;
    return $cached;
}

function is_logged_in(): bool
{
    return current_user() !== null;
}

/** Redirects to /login/ if there's no authenticated session. */
function require_login(): void
{
    if (!is_logged_in()) {
        $_SESSION['redirect_after_login'] = $_SERVER['REQUEST_URI'] ?? '/dashboard/';
        redirect('/login/');
    }
}

/** Redirects to the dashboard if the current user lacks one of the given roles. */
function require_role(array $allowedRoles): void
{
    require_login();
    $user = current_user();
    if (!in_array($user['role_name'], $allowedRoles, true)) {
        http_response_code(403);
        exit('You do not have permission to view this page.');
    }
}

function hash_password(string $plainPassword): string
{
    return password_hash($plainPassword, PASSWORD_DEFAULT);
}

function verify_password(string $plainPassword, string $hash): bool
{
    return password_verify($plainPassword, $hash);
}

/**
 * Login attempt limiter: 5 attempts per 15 minutes per identifier+IP,
 * independent of the general-purpose rate_limit_check() in
 * security.php so it survives session regeneration on success/failure.
 */
function login_rate_limited(string $identifier): bool
{
    return !rate_limit_check('login:' . $identifier . ':' . ($_SERVER['REMOTE_ADDR'] ?? ''), 5, 900);
}
