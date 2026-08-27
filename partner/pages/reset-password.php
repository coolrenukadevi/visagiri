<?php
declare(strict_types=1);

$token = trim((string) ($_GET['token'] ?? $_POST['token'] ?? ''));
$errors = [];
$partner = $token !== '' ? verify_partner_password_reset_token($token) : null;

if ($token === '' || !$partner) {
    $pageTitle = 'Reset Link Invalid - Visagiri';
    $canonicalUrl = APP_URL . '/partner/reset-password/';
    $noindex = true;
    require __DIR__ . '/../../includes/header.php';
    ?>
    <section class="section" style="padding-top:var(--space-8)">
        <div class="container" style="max-width:420px;text-align:center">
            <h1>Reset Link Invalid or Expired</h1>
            <p>This password reset link is no longer valid. Reset links expire after 1 hour and can only be used once.</p>
            <a href="/partner/forgot-password/" class="btn btn-primary">Request a New Link</a>
        </div>
    </section>
    <?php
    require __DIR__ . '/../../includes/footer.php';
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
        reset_partner_password((int) $partner['id'], $password);
        flash_set('notice', 'Your password has been reset. Please sign in.');
        redirect('/partner/login/');
    }
}

$pageTitle = 'Reset Password - Visagiri';
$canonicalUrl = APP_URL . '/partner/reset-password/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:420px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Partner Program</span>
            <h1>Set a New Password</h1>
        </div>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <form method="post" action="/partner/reset-password/" class="card" style="padding:var(--space-6)">
            <?= csrf_field() ?>
            <input type="hidden" name="token" value="<?= e($token) ?>">
            <div class="form-group">
                <label class="form-label" for="password">New Password</label>
                <input class="form-input" type="password" id="password" name="password" required autofocus autocomplete="new-password">
                <span class="form-hint">At least 8 characters.</span>
            </div>
            <div class="form-group">
                <label class="form-label" for="confirm_password">Confirm New Password</label>
                <input class="form-input" type="password" id="confirm_password" name="confirm_password" required autocomplete="new-password">
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%">Reset Password</button>
        </form>
    </div>
</section>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
