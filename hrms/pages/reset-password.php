<?php
declare(strict_types=1);

$token = trim((string) ($_GET['token'] ?? $_POST['token'] ?? ''));
$adminId = $token !== '' ? verify_admin_password_reset_token($token) : null;
$errors = [];
$done = false;

if ($token === '' || $adminId === null) {
    $invalid = true;
} else {
    $invalid = false;

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        csrf_require();
        $password = (string) ($_POST['password'] ?? '');
        $confirm = (string) ($_POST['password_confirm'] ?? '');

        if (strlen($password) < 10) {
            $errors[] = 'Password must be at least 10 characters.';
        }
        if ($password !== $confirm) {
            $errors[] = 'Passwords do not match.';
        }

        if (!$errors) {
            reset_admin_password($adminId, $password);
            log_action('password_reset', 'admin_users', $adminId);
            $done = true;
        }
    }
}
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Reset Password · VisaGiri HRMS</title>
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
        <h1>Reset Password</h1>
        <?php if ($invalid): ?>
        <div class="alert alert-danger">This reset link is invalid or has expired. Reset links are valid for 1 hour and can only be used once.</div>
        <p style="margin-top:var(--space-4);text-align:center"><a href="/hrms/forgot-password/">Request a new link</a></p>
        <?php elseif ($done): ?>
        <div class="alert alert-success">Your password has been reset. You can now log in with your new password.</div>
        <p style="margin-top:var(--space-4);text-align:center"><a href="/hrms/login/" class="btn btn-primary">Go to Login</a></p>
        <?php else: ?>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <form method="post" action="/hrms/reset-password/">
            <?= csrf_field() ?>
            <input type="hidden" name="token" value="<?= e($token) ?>">
            <div class="form-group">
                <label class="form-label" for="password">New Password</label>
                <input class="form-input" type="password" id="password" name="password" required autofocus placeholder="At least 10 characters">
            </div>
            <div class="form-group">
                <label class="form-label" for="password_confirm">Confirm New Password</label>
                <input class="form-input" type="password" id="password_confirm" name="password_confirm" required>
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%">Reset Password</button>
        </form>
        <?php endif; ?>
    </div>
</div>
</body>
</html>
