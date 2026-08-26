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

        record_login_attempt($username, $admin && $passwordOk);

        if ($admin && $passwordOk) {
            log_in_admin((int) $admin['id']);
            log_action('login', 'auth', (int) $admin['id']);
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
    <div class="admin-login-brand">
        <div class="admin-login-brand__logo">VISA<span>GIRI</span></div>
        <p class="admin-login-brand__tagline">Seamless Visas. Limitless Journeys.</p>
        <div class="admin-login-brand__art" aria-hidden="true">
            <svg width="220" height="220" viewBox="0 0 220 220" fill="none">
                <circle cx="110" cy="110" r="86" stroke="#F4B400" stroke-width="1" opacity="0.35"/>
                <circle cx="110" cy="110" r="60" stroke="#F4B400" stroke-width="1" opacity="0.25"/>
                <ellipse cx="110" cy="110" rx="86" ry="34" stroke="#F4B400" stroke-width="1" opacity="0.25"/>
                <line x1="24" y1="110" x2="196" y2="110" stroke="#F4B400" stroke-width="1" opacity="0.25"/>
                <rect x="78" y="58" width="64" height="88" rx="6" fill="rgba(255,255,255,0.06)" stroke="#F4B400" stroke-width="1.6"/>
                <circle cx="110" cy="94" r="14" stroke="#F4B400" stroke-width="1.6"/>
                <path d="M104 94 108 98 118 86" stroke="#F4B400" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
                <line x1="90" y1="122" x2="130" y2="122" stroke="#FFFFFF" stroke-width="1.2" opacity="0.5"/>
                <line x1="90" y1="130" x2="118" y2="130" stroke="#FFFFFF" stroke-width="1.2" opacity="0.5"/>
            </svg>
        </div>
        <p class="admin-login-brand__note">Internal staff access only. Every sign-in and change is logged.</p>
    </div>
    <div class="admin-login-form-panel">
        <div class="admin-login-card">
            <span class="admin-login-card__eyebrow">Admin Panel</span>
            <h1>Welcome back</h1>
            <p>Sign in to manage countries, enquiries, applications, and site content.</p>
            <?php foreach ($errors as $error): ?>
            <div class="alert alert-danger"><?= e($error) ?></div>
            <?php endforeach; ?>
            <form method="post" action="/admin/login/">
                <?= csrf_field() ?>
                <div class="form-group admin-login-field">
                    <label class="form-label" for="username">Username</label>
                    <div class="admin-login-field__control">
                        <svg class="admin-login-field__icon" width="18" height="18" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="10" cy="7" r="3.2"/><path d="M3.5 16.5c1-3.3 3.6-5 6.5-5s5.5 1.7 6.5 5"/></svg>
                        <input class="form-input" type="text" id="username" name="username" value="<?= e($username) ?>" required autofocus autocomplete="username">
                    </div>
                </div>
                <div class="form-group admin-login-field">
                    <label class="form-label" for="password">Password</label>
                    <div class="admin-login-field__control">
                        <svg class="admin-login-field__icon" width="18" height="18" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="4.5" y="9" width="11" height="8" rx="1.6"/><path d="M6.5 9V6.5a3.5 3.5 0 0 1 7 0V9"/></svg>
                        <input class="form-input" type="password" id="password" name="password" required autocomplete="current-password">
                    </div>
                </div>
                <button type="submit" class="btn btn-primary admin-login-submit">Sign In</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
