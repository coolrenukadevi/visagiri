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
        $email = trim($_POST['email'] ?? '');
        $password = (string) ($_POST['password'] ?? '');

        if ($email === '' || $password === '') {
            $errors[] = 'Enter both your email and password.';
        } elseif (attempt_login($email, $password)) {
            header('Location: ' . url('dashboard.php'));
            exit;
        } else {
            $errors[] = 'Those credentials don\'t match our records.';
        }
    }
}

$pageTitle = 'Sign in — Videshia';
require __DIR__ . '/includes/auth-head.php';
?>

<div class="auth-shell">
    <?php require __DIR__ . '/includes/auth-panel.php'; ?>

    <div class="auth-panel">
        <div class="auth-card">
            <div class="auth-card-head">
                <h2>Welcome back</h2>
                <p>New to Videshia? <a href="<?= url('signup.php') ?>">Create an account</a></p>
            </div>

            <?php foreach ($errors as $error): ?>
                <div class="alert alert-error"><?= e($error) ?></div>
            <?php endforeach; ?>
            <?php if ($success = flash_get('success')): ?>
                <div class="alert alert-success"><?= e($success) ?></div>
            <?php endif; ?>

            <form method="post" action="<?= url('login.php') ?>" data-validate novalidate>
                <input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>">

                <div class="form-row">
                    <label for="email">Email address</label>
                    <input class="form-control" type="email" id="email" name="email" placeholder="you@company.com" value="<?= e($_POST['email'] ?? '') ?>" required autofocus>
                </div>

                <div class="form-row">
                    <label for="password">Password</label>
                    <div class="input-wrap">
                        <input class="form-control" type="password" id="password" name="password" placeholder="Enter your password" required>
                        <button type="button" class="input-toggle" data-toggle-password="password" aria-label="Show password">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7-11-7-11-7z"/><circle cx="12" cy="12" r="3"/></svg>
                        </button>
                    </div>
                </div>

                <div class="form-meta">
                    <label class="checkbox-row"><input type="checkbox" name="remember"> Remember me</label>
                    <a href="<?= url('forgot-password.php') ?>">Forgot password?</a>
                </div>

                <button type="submit" class="btn btn-primary btn-block btn-lg">Sign in</button>
            </form>

            <div class="auth-divider">or continue with</div>
            <div class="oauth-row">
                <button type="button" class="oauth-btn"><svg width="16" height="16" viewBox="0 0 24 24"><path fill="#4285F4" d="M23.5 12.27c0-.79-.07-1.54-.2-2.27H12v4.3h6.47a5.53 5.53 0 01-2.4 3.63v3h3.87c2.27-2.09 3.56-5.17 3.56-8.66z"/><path fill="#34A853" d="M12 24c3.24 0 5.96-1.07 7.94-2.9l-3.87-3a7.4 7.4 0 01-11-3.9H1.1v3.1A12 12 0 0012 24z"/><path fill="#FBBC05" d="M5.07 14.2a7.2 7.2 0 010-4.4V6.7H1.1a12 12 0 000 10.6l3.97-3.1z"/><path fill="#EA4335" d="M12 4.75c1.76 0 3.35.6 4.6 1.8l3.44-3.44C17.95 1.19 15.24 0 12 0 7.31 0 3.26 2.7 1.1 6.7l3.97 3.1A7.15 7.15 0 0112 4.75z"/></svg> Google</button>
                <button type="button" class="oauth-btn"><svg width="16" height="16" viewBox="0 0 24 24"><path fill="#F35325" d="M1 1h10v10H1z"/><path fill="#81BC06" d="M13 1h10v10H13z"/><path fill="#05A6F0" d="M1 13h10v10H1z"/><path fill="#FFBA08" d="M13 13h10v10H13z"/></svg> Microsoft</button>
            </div>

            <div class="demo-hint">Demo access &mdash; email <code>demo@videshia.com</code>, password <code>Videshia@123</code></div>
        </div>
    </div>
</div>

<?php require __DIR__ . '/includes/auth-foot.php'; ?>
