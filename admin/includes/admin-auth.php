<?php
require_once __DIR__ . '/../../includes/enquiry-db.php';

session_start();

function admin_require_login(): void
{
    if (empty($_SESSION['admin_user'])) {
        header('Location: login.php');
        exit;
    }
}

function admin_attempt_login(string $username, string $password): bool
{
    $failCount = $_SESSION['admin_fail_count'] ?? 0;
    $lastFail = $_SESSION['admin_last_fail'] ?? 0;
    if ($failCount >= 5 && (time() - $lastFail) < 30) {
        return false;
    }

    $pdo = enquiry_db();
    $stmt = $pdo->prepare('SELECT id, name, password_hash, role FROM users WHERE username = ?');
    $stmt->execute([$username]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user && password_verify($password, $user['password_hash'])) {
        $_SESSION['admin_user'] = $username;
        $_SESSION['admin_user_id'] = (int) $user['id'];
        $_SESSION['admin_name'] = $user['name'];
        $_SESSION['admin_role'] = $user['role'];
        $_SESSION['admin_fail_count'] = 0;
        session_regenerate_id(true);
        return true;
    }

    $_SESSION['admin_fail_count'] = $failCount + 1;
    $_SESSION['admin_last_fail'] = time();
    return false;
}

function admin_role(): string
{
    return $_SESSION['admin_role'] ?? 'Admin';
}

function admin_name(): string
{
    return $_SESSION['admin_name'] ?? ($_SESSION['admin_user'] ?? 'Admin');
}

function admin_user_id(): int
{
    return (int) ($_SESSION['admin_user_id'] ?? 0);
}

/** True for roles that can see and manage every enquiry, not just their own. */
function admin_can_view_all(): bool
{
    return in_array(admin_role(), ['Super Admin', 'Admin', 'Sales Manager', 'Accounts'], true);
}

function admin_can_manage_users(): bool
{
    return admin_role() === 'Super Admin';
}
