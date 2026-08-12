<?php
declare(strict_types=1);

if (is_admin_logged_in()) {
    redirect('/admin/dashboard/');
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

        // Always run a password_verify(), even with no matching user, so
        // "no such account" and "wrong password" take the same amount of
        // time and can't be told apart by an attacker measuring responses.
        $hashToCheck = $admin['password_hash'] ?? DUMMY_PASSWORD_HASH;
        $passwordOk = verify_password($password, $hashToCheck);

        if ($admin && $passwordOk) {
            log_in_admin((int) $admin['id']);
            $redirectTo = $_SESSION['admin_redirect_after_login'] ?? '/admin/dashboard/';
            unset($_SESSION['admin_redirect_after_login']);
            redirect($redirectTo);
        }

        $errors[] = 'Invalid username or password.';
    }
}
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Admin Login · Visagiri</title>
<meta name="robots" content="noindex, nofollow">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/tokens.css')) ?>">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/base.css')) ?>">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/components.css')) ?>">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/admin.css')) ?>">
</head>
<body>
<div class="admin-login-page">
    <div class="admin-login-card">
        <h1>Visagiri Admin</h1>
        <p>Sign in to manage site content.</p>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <form method="post" action="/admin/login/">
            <?= csrf_field() ?>
            <div class="form-group">
                <label class="form-label" for="username">Username</label>
                <input class="form-input" type="text" id="username" name="username" value="<?= e($username) ?>" required autofocus>
            </div>
            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <input class="form-input" type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%">Sign In</button>
        </form>
    </div>
</div>
</body>
</html>
