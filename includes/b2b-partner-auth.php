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

/** partner_agent/partner_finance can view enquiries but only these roles can act on them (create, cancel, respond to quotations). */
function current_b2b_partner_can_manage_enquiries(): bool
{
    return in_array(current_b2b_partner_role(), ['partner_admin', 'partner_manager', 'partner_agent'], true);
}

/**
 * B2B team invitations (Phase B9). Unlike the old partner system,
 * which stores an invited-but-unaccepted member in a separate
 * partner_team_members table, B2B_partner_users already models every
 * team member as a first-class row from the start — so an invite is
 * just a row created immediately with an unusable random password and
 * the existing reset_token_hash/reset_token_expires_at columns
 * repurposed as the accept-invite token (same random-32-byte,
 * SHA-256-hashed, only-the-hash-stored shape as
 * create_partner_password_reset_token()). The account is functionally
 * inert until the invitee sets a real password via the link.
 */
function b2b_create_user_invite(int $b2bPartnerId, string $fullName, string $designation, string $email, string $mobileNumber, string $role, int $invitedByUserId): string
{
    $token = bin2hex(random_bytes(32));
    db()->prepare(
        'INSERT INTO b2b_partner_users (b2b_partner_id, full_name, designation, email, password_hash, mobile_number, role, reset_token_hash, reset_token_expires_at)
         VALUES (:partner_id, :name, :designation, :email, :password_hash, :mobile, :role, :hash, :expires)'
    )->execute([
        'partner_id' => $b2bPartnerId,
        'name' => $fullName,
        'designation' => $designation,
        'email' => $email,
        'password_hash' => hash_password(bin2hex(random_bytes(32))),
        'mobile' => $mobileNumber,
        'role' => $role,
        'hash' => hash('sha256', $token),
        'expires' => date('Y-m-d H:i:s', time() + 60 * 60 * 24 * 7),
    ]);
    return $token;
}

function b2b_verify_invite_token(string $token): ?array
{
    $stmt = db()->prepare(
        'SELECT * FROM b2b_partner_users
         WHERE reset_token_hash = :hash AND reset_token_expires_at IS NOT NULL AND reset_token_expires_at > NOW() AND deleted_at IS NULL'
    );
    $stmt->execute(['hash' => hash('sha256', $token)]);
    $user = $stmt->fetch();
    return $user ?: null;
}

function b2b_complete_invite(int $userId, string $newPlainPassword): void
{
    db()->prepare('UPDATE b2b_partner_users SET password_hash = :hash, reset_token_hash = NULL, reset_token_expires_at = NULL WHERE id = :id')
        ->execute(['hash' => hash_password($newPlainPassword), 'id' => $userId]);
}
