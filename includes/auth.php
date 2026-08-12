<?php
declare(strict_types=1);

/**
 * Admin authentication. Single role (admin_users) — there is no
 * public-facing account system in this rebuild, only the CMS admin
 * panel at /admin/.
 */

function current_admin_id(): ?int
{
    return $_SESSION['admin_id'] ?? null;
}

function current_admin(): ?array
{
    $adminId = current_admin_id();
    if ($adminId === null) {
        return null;
    }

    static $cached = null;
    if ($cached !== null && $cached['id'] === $adminId) {
        return $cached;
    }

    $stmt = db()->prepare('SELECT id, username, email, full_name, status FROM admin_users WHERE id = :id AND status = "active"');
    $stmt->execute(['id' => $adminId]);
    $admin = $stmt->fetch();

    $cached = $admin ?: null;
    return $cached;
}

function is_admin_logged_in(): bool
{
    return current_admin() !== null;
}

function require_admin_login(): void
{
    if (!is_admin_logged_in()) {
        $_SESSION['admin_redirect_after_login'] = $_SERVER['REQUEST_URI'] ?? '/admin/';
        redirect('/admin/login/');
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
 * A precomputed bcrypt hash with no corresponding real password —
 * used to keep login's response time constant when no matching admin
 * exists, so "no such account" and "wrong password" aren't
 * distinguishable by timing.
 */
const DUMMY_PASSWORD_HASH = '$2y$12$fd5G7zkjbudoZUB5IgqZO.JuRuCKGyLlRGwZIOW9OfYKEmziAq7NO';

function login_rate_limited(string $identifier): bool
{
    return !rate_limit_check('admin-login:' . $identifier . ':' . ($_SERVER['REMOTE_ADDR'] ?? ''), 5, 900);
}

function log_in_admin(int $adminId): void
{
    session_regenerate_id(true);
    $_SESSION['admin_id'] = $adminId;
    $_SESSION['_started_at'] = time();
    db()->prepare('UPDATE admin_users SET last_login_at = NOW() WHERE id = :id')->execute(['id' => $adminId]);
}

function log_out_admin(): void
{
    unset($_SESSION['admin_id']);
    session_regenerate_id(true);
}
