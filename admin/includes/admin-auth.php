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
    $stmt = $pdo->prepare('SELECT password_hash FROM admin_users WHERE username = ?');
    $stmt->execute([$username]);
    $hash = $stmt->fetchColumn();

    if ($hash && password_verify($password, $hash)) {
        $_SESSION['admin_user'] = $username;
        $_SESSION['admin_fail_count'] = 0;
        session_regenerate_id(true);
        return true;
    }

    $_SESSION['admin_fail_count'] = $failCount + 1;
    $_SESSION['admin_last_fail'] = time();
    return false;
}
