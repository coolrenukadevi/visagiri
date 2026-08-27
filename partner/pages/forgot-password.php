<?php
declare(strict_types=1);

$submitted = false;
$devResetLink = null;
$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $email = trim((string) ($_POST['email'] ?? ''));

    if (!rate_limit_check('partner-forgot-password:' . ($_SERVER['REMOTE_ADDR'] ?? ''), 5, 900)) {
        $errors[] = 'Too many attempts. Please try again later.';
    } elseif (!is_valid_email($email)) {
        $errors[] = 'Enter a valid email address.';
    } else {
        $stmt = db()->prepare('SELECT id FROM partners WHERE email = :email AND deleted_at IS NULL');
        $stmt->execute(['email' => $email]);
        $partner = $stmt->fetch();

        if ($partner) {
            $token = create_partner_password_reset_token((int) $partner['id']);
            $resetLink = APP_URL . '/partner/reset-password/?token=' . $token;
            $sent = send_mail(
                $email,
                'Reset your password — Visagiri B2B Partner Program',
                '<p>Click the link below to reset your Visagiri partner account password:</p><p><a href="' . e($resetLink) . '">' . e($resetLink) . '</a></p><p>This link expires in 1 hour. If you did not request this, you can ignore this email.</p>'
            );
            if (!$sent && APP_DEBUG) {
                $devResetLink = $resetLink;
            }
        }

        $submitted = true;
    }
}

$pageTitle = 'Forgot Password - Partner Portal - Visagiri';
$canonicalUrl = APP_URL . '/partner/forgot-password/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:420px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Partner Program</span>
            <h1>Forgot your password?</h1>
        </div>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <div class="card" style="padding:var(--space-6)">
            <?php if ($submitted): ?>
            <div class="alert alert-info">If an account exists for that email, password reset instructions have been sent.</div>
            <?php if ($devResetLink): ?>
            <div class="alert alert-warning">
                <strong>Development mode only</strong> (no email service is connected yet):<br>
                <a href="<?= e($devResetLink) ?>"><?= e($devResetLink) ?></a>
            </div>
            <?php endif; ?>
            <?php else: ?>
            <form method="post" action="/partner/forgot-password/">
                <?= csrf_field() ?>
                <div class="form-group">
                    <label class="form-label" for="email">Email</label>
                    <input class="form-input" type="email" id="email" name="email" required autofocus>
                </div>
                <button type="submit" class="btn btn-primary" style="width:100%">Send Reset Instructions</button>
            </form>
            <?php endif; ?>
            <p style="margin-top:var(--space-4);text-align:center;font-size:var(--font-size-sm)"><a href="/partner/login/">Back to login</a></p>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
