<?php
declare(strict_types=1);

/**
 * Partner referral-portal auth. Same shape as includes/customer-auth.php
 * (own $_SESSION key, own remember-me cookie, own reset-token columns)
 * so none of the three login systems (admin/customer/partner) can ever
 * collide through shared session state. The one real difference:
 * `partners.status` has a 'pending' state — a self-registered partner
 * can authenticate (proves they own the credentials) but is_partner_
 * active() gates them out of real referral/commission data until an
 * admin approves the account (admin/pages/partners.php).
 */

function current_partner_id(): ?int
{
    return $_SESSION['partner_id'] ?? null;
}

function current_partner(): ?array
{
    $partnerId = current_partner_id();
    if ($partnerId === null) {
        return null;
    }

    static $cached = null;
    if ($cached !== null && $cached['id'] === $partnerId) {
        return $cached;
    }

    $stmt = db()->prepare('SELECT * FROM partners WHERE id = :id AND deleted_at IS NULL');
    $stmt->execute(['id' => $partnerId]);
    $partner = $stmt->fetch();

    $cached = $partner ?: null;
    return $cached;
}

function is_partner_logged_in(): bool
{
    return current_partner() !== null;
}

function is_partner_active(): bool
{
    $partner = current_partner();
    return $partner !== null && $partner['status'] === 'active';
}

function require_partner_login(): void
{
    if (!is_partner_logged_in()) {
        $_SESSION['partner_redirect_after_login'] = $_SERVER['REQUEST_URI'] ?? '/partner/dashboard/';
        redirect('/partner/login/');
    }
}

function log_in_partner(int $partnerId): void
{
    session_regenerate_id(true);
    $_SESSION['partner_id'] = $partnerId;
}

function remember_partner(int $partnerId): void
{
    $token = bin2hex(random_bytes(32));
    $stmt = db()->prepare(
        'UPDATE partners SET remember_token_hash = :hash, remember_token_expires_at = :expires WHERE id = :id'
    );
    $stmt->execute([
        'hash' => hash('sha256', $token),
        'expires' => date('Y-m-d H:i:s', time() + 60 * 60 * 24 * 30),
        'id' => $partnerId,
    ]);

    setcookie('visagiri_partner_remember', $partnerId . ':' . $token, [
        'expires' => time() + 60 * 60 * 24 * 30,
        'path' => '/',
        'secure' => SESSION_SECURE_COOKIE,
        'httponly' => true,
        'samesite' => 'Lax',
    ]);
}

function resume_partner_session_from_remember_cookie(): void
{
    if (is_partner_logged_in()) {
        return;
    }

    $cookie = $_COOKIE['visagiri_partner_remember'] ?? '';
    if (!str_contains($cookie, ':')) {
        return;
    }

    [$partnerId, $token] = explode(':', $cookie, 2);
    if (!ctype_digit($partnerId)) {
        return;
    }

    $stmt = db()->prepare(
        'SELECT id, remember_token_hash FROM partners
         WHERE id = :id AND remember_token_expires_at IS NOT NULL AND remember_token_expires_at > NOW()
           AND deleted_at IS NULL'
    );
    $stmt->execute(['id' => (int) $partnerId]);
    $partner = $stmt->fetch();

    if ($partner && hash_equals($partner['remember_token_hash'], hash('sha256', $token))) {
        log_in_partner((int) $partner['id']);
    }
}

function forget_partner_remember_cookie(?int $partnerId): void
{
    if ($partnerId !== null) {
        $stmt = db()->prepare('UPDATE partners SET remember_token_hash = NULL, remember_token_expires_at = NULL WHERE id = :id');
        $stmt->execute(['id' => $partnerId]);
    }
    setcookie('visagiri_partner_remember', '', ['expires' => time() - 42000, 'path' => '/']);
}

function log_out_partner(): void
{
    forget_partner_remember_cookie(current_partner_id());
    unset($_SESSION['partner_id']);
}

function create_partner_password_reset_token(int $partnerId): string
{
    $token = bin2hex(random_bytes(32));
    $stmt = db()->prepare(
        'UPDATE partners SET password_reset_token_hash = :hash, password_reset_expires_at = :expires WHERE id = :id'
    );
    $stmt->execute([
        'hash' => hash('sha256', $token),
        'expires' => date('Y-m-d H:i:s', time() + 3600),
        'id' => $partnerId,
    ]);
    return $token;
}

function verify_partner_password_reset_token(string $token): ?array
{
    $stmt = db()->prepare(
        'SELECT * FROM partners
         WHERE password_reset_token_hash = :hash
           AND password_reset_expires_at IS NOT NULL
           AND password_reset_expires_at > NOW()
           AND deleted_at IS NULL'
    );
    $stmt->execute(['hash' => hash('sha256', $token)]);
    $partner = $stmt->fetch();
    return $partner ?: null;
}

function reset_partner_password(int $partnerId, string $newPlainPassword): void
{
    $stmt = db()->prepare(
        'UPDATE partners SET password_hash = :hash, password_reset_token_hash = NULL, password_reset_expires_at = NULL WHERE id = :id'
    );
    $stmt->execute(['hash' => hash_password($newPlainPassword), 'id' => $partnerId]);
}
