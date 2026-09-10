<?php
require __DIR__ . '/../includes/config.php';
require __DIR__ . '/../includes/functions.php';
require __DIR__ . '/../includes/auth.php';
require __DIR__ . '/../includes/crm-auth.php';

if (crm_current_user()) {
    header('Location: ' . url('crm/dashboard.php'));
    exit;
}

$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!csrf_verify($_POST['csrf_token'] ?? null)) {
        $errors[] = 'Your session expired. Please try again.';
    } elseif (crm_login(trim($_POST['email'] ?? ''), (string) ($_POST['password'] ?? ''))) {
        header('Location: ' . url('crm/dashboard.php'));
        exit;
    } else {
        $errors[] = 'Those credentials don\'t match our records, or this account is inactive.';
    }
}

$pageTitle = 'Sign in — Videshia CRM';
$robotsMeta = 'noindex, nofollow';
require __DIR__ . '/../includes/auth-head.php';
?>

<div class="auth-shell">
    <aside class="auth-brand">
        <div class="auth-brand-top">
            <a href="<?= url('index.php') ?>"><?= videshia_logo('sm', 'dark', true) ?></a>
        </div>
        <div class="auth-brand-body">
            <h1>Run the whole desk from one console.</h1>
            <p>Enquiries, documents, follow-ups and reporting for every visa, hotel, flight, tour, forex and insurance case — assigned, tracked, and auditable.</p>
        </div>
        <p class="auth-brand-quote">Staff and partner access only. Contact your administrator if you need an account.</p>
    </aside>

    <div class="auth-panel">
        <div class="auth-card">
            <div class="auth-card-head">
                <h2>CRM sign in</h2>
                <p>Internal access for Videshia staff and consultants.</p>
            </div>

            <?php foreach ($errors as $error): ?>
                <div class="alert alert-error"><?= e($error) ?></div>
            <?php endforeach; ?>

            <form method="post" action="<?= url('crm/login.php') ?>" data-validate novalidate>
                <input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>">
                <div class="form-row">
                    <label for="email">Work email</label>
                    <input class="form-control" type="email" id="email" name="email" required autofocus>
                </div>
                <div class="form-row">
                    <label for="password">Password</label>
                    <div class="input-wrap">
                        <input class="form-control" type="password" id="password" name="password" required>
                        <button type="button" class="input-toggle" data-toggle-password="password" aria-label="Show password">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7-11-7-11-7z"/><circle cx="12" cy="12" r="3"/></svg>
                        </button>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary btn-block btn-lg">Sign in</button>
            </form>

            <div class="demo-hint">Demo access &mdash; <code>admin@videshia.com</code> / <code>Videshia@123</code> (Super Admin), or <code>visa.consultant@videshia.com</code> / <code>Videshia@123</code> (Visa Consultant)</div>
        </div>
    </div>
</div>

<?php require __DIR__ . '/../includes/auth-foot.php'; ?>
