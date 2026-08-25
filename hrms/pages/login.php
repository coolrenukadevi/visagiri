<?php
declare(strict_types=1);

if (is_admin_logged_in()) {
    redirect('/hrms/dashboard/');
}

$errors = [];
$username = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $username = trim((string) ($_POST['username'] ?? ''));
    $password = (string) ($_POST['password'] ?? '');

    if (login_rate_limited($username)) {
        $errors[] = 'Too many login attempts. Please try again later.';
    } else {
        $stmt = db()->prepare('SELECT * FROM admin_users WHERE username = :username AND status = "active"');
        $stmt->execute(['username' => $username]);
        $admin = $stmt->fetch();

        // Same timing-safe check as /admin/login/ — always verify against
        // something, even with no matching user.
        $hashToCheck = $admin['password_hash'] ?? DUMMY_PASSWORD_HASH;
        $passwordOk = verify_password($password, $hashToCheck);

        record_login_attempt($username, $admin && $passwordOk);

        if ($admin && $passwordOk) {
            log_in_admin((int) $admin['id']);
            log_action('login', 'auth', (int) $admin['id']);
            $redirectTo = $_SESSION['hrms_redirect_after_login'] ?? '/hrms/dashboard/';
            unset($_SESSION['hrms_redirect_after_login']);
            redirect($redirectTo);
        }

        $errors[] = 'Invalid User ID/Email or password.';
    }
}
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>HRMS Login · VisaGiri</title>
<meta name="robots" content="noindex, nofollow">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/tokens.css')) ?>">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/base.css')) ?>">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/components.css')) ?>">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/admin.css')) ?>">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/hrms.css')) ?>">
</head>
<body>
<div class="admin-login-page hrms-login-page">
    <div class="admin-login-card">
        <h1>VisaGiri HRMS</h1>
        <p>Recruitment CRM — authorized HR staff only.</p>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <form method="post" action="/hrms/login/">
            <?= csrf_field() ?>
            <div class="form-group">
                <label class="form-label" for="username">User ID / Email</label>
                <input class="form-input" type="text" id="username" name="username" value="<?= e($username) ?>" required autofocus>
            </div>
            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <input class="form-input" type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%">Sign In</button>
        </form>
        <p style="margin-top:var(--space-4);text-align:center"><a href="/hrms/forgot-password/">Forgot Password?</a></p>
    </div>
</div>
</body>
</html>
