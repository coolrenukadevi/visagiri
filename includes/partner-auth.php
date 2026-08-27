<?php
/**
 * Session-based auth for the B2B partner portal. Mirrors the shape of
 * admin/includes/admin-auth.php (attempt/require/session helpers,
 * fail-count lockout, session_regenerate_id on success) but uses a
 * separate set of session keys ($_SESSION['partner_user'] etc., distinct
 * from $_SESSION['admin_user']) so a staff member and a partner can never
 * collide in the same browser session.
 *
 * A partner user can only log in once their company's application status
 * is in B2B_PARTNER_ACTIVE_STATUSES (Approved) — the account row itself is
 * created at registration time (see b2b-partner-register-handler.php) but
 * stays unusable for login until then.
 */
require_once __DIR__ . '/b2b-db.php';

session_start();

function partner_require_login(): void
{
    if (empty($_SESSION['partner_user'])) {
        header('Location: b2b-login.php');
        exit;
    }
}

/** @return array{success:bool,message:string} */
function partner_attempt_login(string $identifier, string $password): array
{
    $failCount = $_SESSION['partner_fail_count'] ?? 0;
    $lastFail = $_SESSION['partner_last_fail'] ?? 0;
    if ($failCount >= 5 && (time() - $lastFail) < 30) {
        return ['success' => false, 'message' => 'Too many failed attempts. Please wait 30 seconds and try again.'];
    }

    $pdo = b2b_db();
    $stmt = $pdo->prepare('SELECT u.*, p.status AS partner_status, p.application_ref, p.company_name
        FROM b2b_partner_users u JOIN b2b_partners p ON p.id = u.partner_id
        WHERE u.username = :id OR u.email = :id');
    $stmt->execute(['id' => $identifier]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$user || !password_verify($password, $user['password_hash'])) {
        $_SESSION['partner_fail_count'] = $failCount + 1;
        $_SESSION['partner_last_fail'] = time();
        return ['success' => false, 'message' => 'Incorrect username/email or password.'];
    }

    if ($user['status'] !== 'Active') {
        return ['success' => false, 'message' => 'Your login has been suspended. Please contact your Relationship Manager.'];
    }
    if (!in_array($user['partner_status'], B2B_PARTNER_ACTIVE_STATUSES, true)) {
        return ['success' => false, 'message' => 'Your partner application is not approved yet, so partner login is not available. We will notify you by email once it is approved.'];
    }

    $_SESSION['partner_fail_count'] = 0;
    $_SESSION['partner_user'] = $user['username'];
    $_SESSION['partner_user_id'] = (int) $user['id'];
    $_SESSION['partner_id'] = (int) $user['partner_id'];
    $_SESSION['partner_name'] = $user['name'];
    $_SESSION['partner_role'] = $user['role'];
    $_SESSION['partner_company'] = $user['company_name'];
    $_SESSION['partner_application_ref'] = $user['application_ref'];
    session_regenerate_id(true);

    $pdo->prepare('UPDATE b2b_partner_users SET last_login_at = ? WHERE id = ?')->execute([gmdate('c'), $user['id']]);
    b2b_log_audit($pdo, 'partner', (int) $user['partner_id'], $user['name'], 'Partner (' . $user['role'] . ')', 'Partner user logged in');

    return ['success' => true, 'message' => 'Logged in.'];
}

function partner_logout(): void
{
    if (!empty($_SESSION['partner_id'])) {
        b2b_log_audit(b2b_db(), 'partner', (int) $_SESSION['partner_id'], partner_name(), 'Partner (' . partner_role() . ')', 'Partner user logged out');
    }
    unset(
        $_SESSION['partner_user'], $_SESSION['partner_user_id'], $_SESSION['partner_id'],
        $_SESSION['partner_name'], $_SESSION['partner_role'], $_SESSION['partner_company'],
        $_SESSION['partner_application_ref']
    );
    session_regenerate_id(true);
}

function partner_user_id(): int
{
    return (int) ($_SESSION['partner_user_id'] ?? 0);
}

/** The b2b_partners.id for the logged-in partner user — every tenant-scoped query filters on this. */
function partner_id(): int
{
    return (int) ($_SESSION['partner_id'] ?? 0);
}

function partner_name(): string
{
    return $_SESSION['partner_name'] ?? 'Partner';
}

function partner_role(): string
{
    return $_SESSION['partner_role'] ?? 'Owner';
}

function partner_company(): string
{
    return $_SESSION['partner_company'] ?? '';
}

function partner_application_ref(): string
{
    return $_SESSION['partner_application_ref'] ?? '';
}

/** Owner always has every permission; sub-users are gated by their stored permissions JSON (enforced fully from Phase 11 onward). */
function partner_has_permission(string $key): bool
{
    if (partner_role() === 'Owner') {
        return true;
    }
    $pdo = b2b_db();
    $stmt = $pdo->prepare('SELECT permissions FROM b2b_partner_users WHERE id = ?');
    $stmt->execute([partner_user_id()]);
    $perms = json_decode((string) $stmt->fetchColumn(), true) ?: [];
    return in_array($key, $perms, true);
}
