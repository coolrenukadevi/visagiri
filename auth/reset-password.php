<?php
declare(strict_types=1);

/** Reset password — the destination of the link from forgot-password.php. */

$token = (string) ($_GET['token'] ?? $_POST['token'] ?? '');
$user = $token !== '' ? verify_password_reset_token($token) : null;
$errors = [];

if (!$user) {
    $pageTitle = 'Reset Password';
    $pageDescription = 'Reset the password for your Visagiri account.';
    $canonicalUrl = APP_URL . '/reset-password/';
    require __DIR__ . '/../includes/header.php';
    ?>
    <div class="auth-wrap">
        <div class="auth-card card">
            <h1>Link expired or invalid</h1>
            <p>This password reset link is invalid or has expired. Request a new one below.</p>
            <a href="/forgot-password/" class="btn btn-primary" style="width:100%;text-align:center">Request New Link</a>
        </div>
    </div>
    <?php
    require __DIR__ . '/../includes/footer.php';
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $password = (string) ($_POST['password'] ?? '');
    $confirmPassword = (string) ($_POST['confirm_password'] ?? '');

    if (mb_strlen($password) < 8) {
        $errors[] = 'Password must be at least 8 characters.';
    } elseif ($password !== $confirmPassword) {
        $errors[] = 'Passwords do not match.';
    } else {
        reset_user_password((int) $user['id'], $password);
        flash_set('notice', 'Your password has been reset. Please log in.');
        redirect('/login/');
    }
}

$pageTitle = 'Reset Password';
$pageDescription = 'Set a new password for your Visagiri account.';
$canonicalUrl = APP_URL . '/reset-password/';
require __DIR__ . '/../includes/header.php';
?>
<div class="auth-wrap">
    <div class="auth-card card">
        <h1>Set a new password</h1>

        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>

        <form method="post" action="/reset-password/" novalidate>
            <?= csrf_field() ?>
            <input type="hidden" name="token" value="<?= e($token) ?>">
            <div class="form-group">
                <label class="form-label" for="password">New password</label>
                <input class="form-input" type="password" id="password" name="password" minlength="8" required autofocus>
                <span class="form-hint">At least 8 characters.</span>
            </div>
            <div class="form-group">
                <label class="form-label" for="confirm_password">Confirm new password</label>
                <input class="form-input" type="password" id="confirm_password" name="confirm_password" minlength="8" required>
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%">Reset Password</button>
        </form>
    </div>
</div>
<?php require __DIR__ . '/../includes/footer.php'; ?>
