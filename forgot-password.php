<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';

$errors = [];
$sent = false;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!csrf_verify($_POST['csrf_token'] ?? null)) {
        $errors[] = 'Your session expired. Please try again.';
    } else {
        $email = trim($_POST['email'] ?? '');
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $errors[] = 'Enter a valid email address.';
        } else {
            // Always report success, regardless of whether the address exists, to avoid leaking account data.
            $sent = true;
        }
    }
}

$pageTitle = 'Reset your password — Videshia';
$authHeadline = 'Back in, in under a minute.';
$authSubtext = 'We\'ll send a secure reset link so you can get straight back to your visa pipeline.';
require __DIR__ . '/includes/auth-head.php';
?>

<div class="auth-shell">
    <?php require __DIR__ . '/includes/auth-panel.php'; ?>

    <div class="auth-panel">
        <div class="auth-card">
            <a href="<?= url('login.php') ?>" class="auth-back">&larr; Back to sign in</a>
            <div class="auth-card-head">
                <h2>Forgot your password?</h2>
                <p>Enter your email and we'll send you a reset link.</p>
            </div>

            <?php foreach ($errors as $error): ?>
                <div class="alert alert-error"><?= e($error) ?></div>
            <?php endforeach; ?>

            <?php if ($sent): ?>
                <div class="alert alert-success">If an account exists for that address, a reset link is on its way.</div>
            <?php endif; ?>

            <form method="post" action="<?= url('forgot-password.php') ?>" data-validate novalidate>
                <input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>">

                <div class="form-row">
                    <label for="email">Email address</label>
                    <input class="form-control" type="email" id="email" name="email" placeholder="you@company.com" value="<?= e($_POST['email'] ?? '') ?>" required autofocus>
                </div>

                <button type="submit" class="btn btn-primary btn-block btn-lg">Send reset link</button>
            </form>
        </div>
    </div>
</div>

<?php require __DIR__ . '/includes/auth-foot.php'; ?>
