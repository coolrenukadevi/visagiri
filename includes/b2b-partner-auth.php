<?php
declare(strict_types=1);

/**
 * B2B Travel Partner Portal auth — own $_SESSION key
 * (b2b_partner_user_id), fully independent of the existing partner
 * referral portal's session (partner_id, includes/partner-auth.php)
 * and the admin session (admin_id). One organisation
 * (b2b_partners) has one or more individual logins
 * (b2b_partner_users); the session identifies the logged-in user,
 * and current_b2b_partner() resolves their parent organisation.
 */

function current_b2b_partner_user_id(): ?int
{
    return $_SESSION['b2b_partner_user_id'] ?? null;
}

function current_b2b_partner_user(): ?array
{
    $userId = current_b2b_partner_user_id();
    if ($userId === null) {
        return null;
    }

    static $cached = null;
    if ($cached !== null && $cached['id'] === $userId) {
        return $cached;
    }

    $stmt = db()->prepare('SELECT * FROM b2b_partner_users WHERE id = :id AND deleted_at IS NULL AND status = "active"');
    $stmt->execute(['id' => $userId]);
    $user = $stmt->fetch();

    $cached = $user ?: null;
    return $cached;
}

function current_b2b_partner(): ?array
{
    $user = current_b2b_partner_user();
    if ($user === null) {
        return null;
    }

    static $cachedPartner = null;
    if ($cachedPartner !== null && $cachedPartner['id'] === (int) $user['b2b_partner_id']) {
        return $cachedPartner;
    }

    $stmt = db()->prepare('SELECT * FROM b2b_partners WHERE id = :id AND deleted_at IS NULL');
    $stmt->execute(['id' => $user['b2b_partner_id']]);
    $partner = $stmt->fetch();

    $cachedPartner = $partner ?: null;
    return $cachedPartner;
}

function is_b2b_partner_logged_in(): bool
{
    return current_b2b_partner_user() !== null;
}

function is_b2b_partner_active(): bool
{
    $partner = current_b2b_partner();
    return $partner !== null && $partner['status'] === 'active';
}

function require_b2b_partner_login(): void
{
    if (!is_b2b_partner_logged_in()) {
        $_SESSION['b2b_redirect_after_login'] = $_SERVER['REQUEST_URI'] ?? '/b2b/dashboard/';
        redirect('/b2b/login/');
    }
}

function log_in_b2b_partner_user(int $userId): void
{
    session_regenerate_id(true);
    $_SESSION['b2b_partner_user_id'] = $userId;
    db()->prepare('UPDATE b2b_partner_users SET last_login_at = NOW(), last_login_ip = :ip WHERE id = :id')
        ->execute(['ip' => $_SERVER['REMOTE_ADDR'] ?? null, 'id' => $userId]);
}

function log_out_b2b_partner_user(): void
{
    unset($_SESSION['b2b_partner_user_id']);
    session_regenerate_id(true);
}

/** Same role-hierarchy pattern as current_partner_can_manage() (includes/partner-auth.php). */
function current_b2b_partner_role(): string
{
    $user = current_b2b_partner_user();
    return $user['role'] ?? 'partner_agent';
}

function current_b2b_partner_can_manage_team(): bool
{
    return current_b2b_partner_role() === 'partner_admin';
}

function current_b2b_partner_can_view_billing(): bool
{
    return in_array(current_b2b_partner_role(), ['partner_admin', 'partner_finance'], true);
}
