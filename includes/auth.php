<?php
declare(strict_types=1);

/**
 * Admin authentication + RBAC identity. Single account table
 * (admin_users) with a role_id FK into roles/permissions — there is
 * no public-facing customer account system in this project, only the
 * CRM admin panel at /admin/.
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

    $stmt = db()->prepare(
        'SELECT a.id, a.username, a.email, a.full_name, a.status, a.role_id, r.name AS role_name, r.slug AS role_slug
         FROM admin_users a
         LEFT JOIN roles r ON r.id = a.role_id
         WHERE a.id = :id AND a.status = "active"'
    );
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

/** Records every login attempt (success or fail) to the audit trail — separate from the rate_limits throttle counter. */
function record_login_attempt(string $username, bool $success): void
{
    db()->prepare(
        'INSERT INTO login_attempts (username, ip_address, user_agent, success) VALUES (:username, :ip, :ua, :success)'
    )->execute([
        'username' => $username,
        'ip' => $_SERVER['REMOTE_ADDR'] ?? null,
        'ua' => substr((string) ($_SERVER['HTTP_USER_AGENT'] ?? ''), 0, 255),
        'success' => $success ? 1 : 0,
    ]);
}

function log_in_admin(int $adminId): void
{
    session_regenerate_id(true);
    $_SESSION['admin_id'] = $adminId;
    $_SESSION['_started_at'] = time();
    db()->prepare('UPDATE admin_users SET last_login_at = NOW() WHERE id = :id')->execute(['id' => $adminId]);

    db()->prepare(
        'INSERT INTO user_sessions (admin_user_id, session_token_hash, ip_address, user_agent)
         VALUES (:admin_id, :token_hash, :ip, :ua)'
    )->execute([
        'admin_id' => $adminId,
        'token_hash' => hash('sha256', session_id()),
        'ip' => $_SERVER['REMOTE_ADDR'] ?? null,
        'ua' => substr((string) ($_SERVER['HTTP_USER_AGENT'] ?? ''), 0, 255),
    ]);
}

function log_out_admin(): void
{
    if (current_admin_id() !== null) {
        db()->prepare(
            'UPDATE user_sessions SET expired_at = NOW() WHERE session_token_hash = :hash AND expired_at IS NULL'
        )->execute(['hash' => hash('sha256', session_id())]);
    }
    unset($_SESSION['admin_id']);
    session_regenerate_id(true);
}

/** Generates a password reset token for the given admin, stores only its hash, returns the plaintext token. Expires in 1 hour. */
function create_admin_password_reset_token(int $adminId): string
{
    $token = bin2hex(random_bytes(32));
    db()->prepare(
        'INSERT INTO password_resets (admin_user_id, token_hash, expires_at) VALUES (:admin_id, :hash, :expires)'
    )->execute([
        'admin_id' => $adminId,
        'hash' => hash('sha256', $token),
        'expires' => date('Y-m-d H:i:s', time() + 3600),
    ]);
    return $token;
}

/** Returns the matching admin_user id if the reset token is valid, unexpired, and unused, else null. */
function verify_admin_password_reset_token(string $token): ?int
{
    $stmt = db()->prepare(
        'SELECT admin_user_id FROM password_resets
         WHERE token_hash = :hash AND expires_at > NOW() AND used_at IS NULL
         ORDER BY id DESC LIMIT 1'
    );
    $stmt->execute(['hash' => hash('sha256', $token)]);
    $adminId = $stmt->fetchColumn();
    return $adminId !== false ? (int) $adminId : null;
}

/** Sets a new password and marks every outstanding reset token for this admin as used (single-use). */
function reset_admin_password(int $adminId, string $newPlainPassword): void
{
    $pdo = db();
    $pdo->prepare('UPDATE admin_users SET password_hash = :hash WHERE id = :id')
        ->execute(['hash' => hash_password($newPlainPassword), 'id' => $adminId]);
    $pdo->prepare('UPDATE password_resets SET used_at = NOW() WHERE admin_user_id = :id AND used_at IS NULL')
        ->execute(['id' => $adminId]);
}
