<?php
declare(strict_types=1);

/**
 * Forgot password — Phase 9. No email-sending integration exists yet
 * in this project (see AUDIT.md), so the reset link can't actually be
 * delivered to the user's inbox. The token generation/verification
 * logic is fully real and secure (random 32-byte token, only its
 * SHA-256 hash stored, 1-hour expiry, single-use); this page shows the
 * generic "if that email is registered..." message either way so it
 * never confirms which emails have accounts, and — only when
 * APP_DEBUG is on, i.e. never in production — also prints the reset
 * link directly so the flow can be tested end-to-end without mail.
 */

$submitted = false;
$devResetLink = null;
$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $email = trim((string) ($_POST['email'] ?? ''));

    if (!rate_limit_check('forgot-password:' . ($_SERVER['REMOTE_ADDR'] ?? ''), 5, 900)) {
        $errors[] = 'Too many attempts. Please try again later.';
    } elseif (!is_valid_email($email)) {
        $errors[] = 'Enter a valid email address.';
    } else {
        $pdo = db();
        $stmt = $pdo->prepare('SELECT id FROM users WHERE email = :email AND deleted_at IS NULL');
        $stmt->execute(['email' => $email]);
        $user = $stmt->fetch();

        if ($user) {
            $token = create_password_reset_token((int) $user['id']);
            if (APP_DEBUG) {
                $devResetLink = APP_URL . '/reset-password/?token=' . $token;
            }
        }

        $submitted = true;
    }
}

$pageTitle = 'Forgot Password';
$pageDescription = 'Reset the password for your Visagiri account.';
$canonicalUrl = APP_URL . '/forgot-password/';
$noindex = true;
require __DIR__ . '/../includes/header.php';
?>
<div class="auth-wrap">
    <div class="auth-card card">
        <h1>Forgot your password?</h1>
        <p class="auth-card__subtitle">Enter your email and we'll help you reset it.</p>

        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>

        <?php if ($submitted): ?>
        <div class="alert alert-info">If an account exists for that email, password reset instructions have been sent.</div>
        <?php if ($devResetLink): ?>
        <div class="alert alert-warning">
            <div>
                <strong>Development mode only</strong> (no email service is connected yet):
                <a href="<?= e($devResetLink) ?>"><?= e($devResetLink) ?></a>
            </div>
        </div>
        <?php endif; ?>
        <?php else: ?>
        <form method="post" action="/forgot-password/" novalidate>
            <?= csrf_field() ?>
            <div class="form-group">
                <label class="form-label" for="email">Email</label>
                <input class="form-input" type="email" id="email" name="email" required autofocus>
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%">Send Reset Instructions</button>
        </form>
        <?php endif; ?>

        <p class="auth-card__footer"><a href="/login/">Back to login</a></p>
    </div>
</div>
<?php require __DIR__ . '/../includes/footer.php'; ?>
