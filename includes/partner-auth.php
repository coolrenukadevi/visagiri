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

function log_in_partner(int $partnerId, ?int $teamMemberId = null): void
{
    session_regenerate_id(true);
    $_SESSION['partner_id'] = $partnerId;
    if ($teamMemberId !== null) {
        $_SESSION['partner_team_member_id'] = $teamMemberId;
    } else {
        unset($_SESSION['partner_team_member_id']);
    }
}

function current_partner_team_member_id(): ?int
{
    return $_SESSION['partner_team_member_id'] ?? null;
}

/**
 * 'owner' for the primary partners-table login (the only identity
 * that existed before this phase); otherwise the logged-in team
 * member's own role. Never trust a role passed from the client —
 * always re-derived here from the session's team-member id.
 */
function current_partner_role(): string
{
    $teamMemberId = current_partner_team_member_id();
    if ($teamMemberId === null) {
        return 'owner';
    }

    static $cached = null;
    if ($cached !== null && $cached['id'] === $teamMemberId) {
        return $cached['role'];
    }

    $stmt = db()->prepare('SELECT role FROM partner_team_members WHERE id = :id');
    $stmt->execute(['id' => $teamMemberId]);
    $role = $stmt->fetchColumn();
    $cached = ['id' => $teamMemberId, 'role' => $role !== false ? $role : 'viewer'];
    return $cached['role'];
}

/** Only the owner (primary login) can invite/remove/reassign team members. */
function current_partner_can_manage_team(): bool
{
    return current_partner_role() === 'owner';
}

/** Viewers can look but not touch — no new applications, no team changes. Owner and manager both can. */
function current_partner_can_manage(): bool
{
    return current_partner_role() !== 'viewer';
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
    unset($_SESSION['partner_id'], $_SESSION['partner_team_member_id']);
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

/**
 * Email verification (enrollment wizard step 2) — same token shape as
 * the password-reset pair above (random 32-byte token, only its
 * SHA-256 hash stored, 1-hour expiry), a deliberately separate column
 * pair rather than reusing password_reset_token_hash since the two
 * flows can be in flight at once (e.g. a partner requests a password
 * reset before ever verifying their email).
 */
function create_partner_email_verification_token(int $partnerId): string
{
    $token = bin2hex(random_bytes(32));
    $stmt = db()->prepare(
        'UPDATE partners SET email_verification_token_hash = :hash, email_verification_expires_at = :expires WHERE id = :id'
    );
    $stmt->execute([
        'hash' => hash('sha256', $token),
        'expires' => date('Y-m-d H:i:s', time() + 3600),
        'id' => $partnerId,
    ]);
    return $token;
}

/**
 * Team-member invite token — same shape as the pairs above (random
 * 32-byte token, only its SHA-256 hash stored, 7-day expiry since
 * this one goes out over email and the recipient may not act on it
 * right away, unlike a same-session email-verification link).
 */
function create_partner_team_invite(int $partnerId, string $fullName, string $email, string $role, ?int $invitedBy): string
{
    $token = bin2hex(random_bytes(32));
    db()->prepare(
        'INSERT INTO partner_team_members (partner_id, full_name, email, role, status, invite_token_hash, invite_expires_at, invited_by)
         VALUES (:partner_id, :full_name, :email, :role, "invited", :hash, :expires, :invited_by)'
    )->execute([
        'partner_id' => $partnerId,
        'full_name' => $fullName,
        'email' => $email,
        'role' => $role,
        'hash' => hash('sha256', $token),
        'expires' => date('Y-m-d H:i:s', time() + 60 * 60 * 24 * 7),
        'invited_by' => $invitedBy,
    ]);
    return $token;
}

/** Returns the invited team-member row for a valid, unexpired token, or null. */
function verify_partner_team_invite_token(string $token): ?array
{
    $stmt = db()->prepare(
        "SELECT * FROM partner_team_members
         WHERE invite_token_hash = :hash AND status = 'invited'
           AND invite_expires_at IS NOT NULL AND invite_expires_at > NOW()"
    );
    $stmt->execute(['hash' => hash('sha256', $token)]);
    $member = $stmt->fetch();
    return $member ?: null;
}

/** Sets the invited member's password, activates them, and clears the token. */
function accept_partner_team_invite(int $teamMemberId, string $newPlainPassword): void
{
    db()->prepare(
        "UPDATE partner_team_members SET password_hash = :hash, status = 'active', invite_token_hash = NULL, invite_expires_at = NULL WHERE id = :id"
    )->execute(['hash' => hash_password($newPlainPassword), 'id' => $teamMemberId]);
}

/** Marks the matching partner's email verified and clears the token. Returns the partner row, or null if the token is invalid/expired. */
function verify_partner_email_verification_token(string $token): ?array
{
    $stmt = db()->prepare(
        'SELECT * FROM partners
         WHERE email_verification_token_hash = :hash
           AND email_verification_expires_at IS NOT NULL
           AND email_verification_expires_at > NOW()
           AND deleted_at IS NULL'
    );
    $stmt->execute(['hash' => hash('sha256', $token)]);
    $partner = $stmt->fetch();
    if (!$partner) {
        return null;
    }

    db()->prepare(
        'UPDATE partners SET email_verified_at = NOW(), email_verification_token_hash = NULL, email_verification_expires_at = NULL WHERE id = :id'
    )->execute(['id' => $partner['id']]);

    return $partner;
}
