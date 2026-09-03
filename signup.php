<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';

if (is_logged_in()) {
    header('Location: ' . url('dashboard.php'));
    exit;
}

$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!csrf_verify($_POST['csrf_token'] ?? null)) {
        $errors[] = 'Your session expired. Please try again.';
    } else {
        $name = trim($_POST['name'] ?? '');
        $email = trim($_POST['email'] ?? '');
        $password = (string) ($_POST['password'] ?? '');
        $confirm = (string) ($_POST['confirm'] ?? '');

        if ($name === '' || $email === '' || $password === '') {
            $errors[] = 'Please fill in every field.';
        } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $errors[] = 'Enter a valid email address.';
        } elseif (strlen($password) < 8) {
            $errors[] = 'Password must be at least 8 characters.';
        } elseif ($password !== $confirm) {
            $errors[] = 'Passwords do not match.';
        } elseif (empty($_POST['terms'])) {
            $errors[] = 'Please accept the Terms of Service to continue.';
        } else {
            flash_set('success', 'Account request received. This demo environment isn\'t wired to a live database yet — sign in below with the demo account.');
            header('Location: ' . url('login.php'));
            exit;
        }
    }
}

$pageTitle = 'Create your account — Videshia';
$authHeadline = 'Give your visa pipeline an AI co-pilot.';
$authSubtext = 'Create a free account to start routing applications through intelligent agents today.';
require __DIR__ . '/includes/auth-head.php';
?>

<div class="auth-shell">
    <?php require __DIR__ . '/includes/auth-panel.php'; ?>

    <div class="auth-panel">
        <div class="auth-card">
            <div class="auth-card-head">
                <h2>Create your account</h2>
                <p>Already with Videshia? <a href="<?= url('login.php') ?>">Sign in</a></p>
            </div>

            <?php foreach ($errors as $error): ?>
                <div class="alert alert-error"><?= e($error) ?></div>
            <?php endforeach; ?>

            <form method="post" action="<?= url('signup.php') ?>" data-validate novalidate>
                <input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>">

                <div class="form-row">
                    <label for="name">Full name</label>
                    <input class="form-control" type="text" id="name" name="name" placeholder="Your name" value="<?= e($_POST['name'] ?? '') ?>" required autofocus>
                </div>

                <div class="form-row">
                    <label for="email">Email address</label>
                    <input class="form-control" type="email" id="email" name="email" placeholder="you@company.com" value="<?= e($_POST['email'] ?? '') ?>" required>
                </div>

                <div class="form-row">
                    <label for="password">Password</label>
                    <div class="input-wrap">
                        <input class="form-control" type="password" id="password" name="password" placeholder="At least 8 characters" minlength="8" required>
                        <button type="button" class="input-toggle" data-toggle-password="password" aria-label="Show password">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7-11-7-11-7z"/><circle cx="12" cy="12" r="3"/></svg>
                        </button>
                    </div>
                </div>

                <div class="form-row">
                    <label for="confirm">Confirm password</label>
                    <div class="input-wrap">
                        <input class="form-control" type="password" id="confirm" name="confirm" placeholder="Re-enter your password" minlength="8" required>
                        <button type="button" class="input-toggle" data-toggle-password="confirm" aria-label="Show password">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7-11-7-11-7z"/><circle cx="12" cy="12" r="3"/></svg>
                        </button>
                    </div>
                </div>

                <div class="form-meta" style="margin-bottom:22px">
                    <label class="checkbox-row"><input type="checkbox" name="terms" required> I agree to the <a href="#">Terms</a> &amp; <a href="#">Privacy Policy</a></label>
                </div>

                <button type="submit" class="btn btn-primary btn-block btn-lg">Create account</button>
            </form>

            <div class="demo-hint">This is a design demo &mdash; new signups aren't persisted. Use <code>demo@videshia.com</code> / <code>Videshia@123</code> to explore the dashboard.</div>
        </div>
    </div>
</div>

<?php require __DIR__ . '/includes/auth-foot.php'; ?>
