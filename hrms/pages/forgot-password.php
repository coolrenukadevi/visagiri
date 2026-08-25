<?php
declare(strict_types=1);

/**
 * Same non-enumerating discipline as this project's other reset
 * flows: always show the same generic confirmation regardless of
 * whether the email matched a real account, so a visitor can't probe
 * which HR emails exist. Sends via PHP's mail() (best-effort, same as
 * includes/google-sheets.php's notification mail — no SMTP relay is
 * configured yet anywhere in this project); in APP_DEBUG mode the
 * reset link is also printed directly so the flow is testable without
 * pretending mail delivery works when it might not be configured.
 */

$submitted = false;
$devResetLink = null;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $email = trim((string) ($_POST['email'] ?? ''));

    if (rate_limit_check('hrms-forgot-password:' . ($_SERVER['REMOTE_ADDR'] ?? ''), 5, 900) && is_valid_email($email)) {
        $stmt = db()->prepare('SELECT id, full_name FROM admin_users WHERE email = :email AND status = "active"');
        $stmt->execute(['email' => $email]);
        $admin = $stmt->fetch();

        if ($admin) {
            $token = create_admin_password_reset_token((int) $admin['id']);
            $resetLink = APP_URL . '/hrms/reset-password/?token=' . $token;

            $fromAddress = setting('mail_from_address', 'info@visagiri.com');
            $fromName = setting('mail_from_name', 'VisaGiri HRMS');
            $subject = 'VisaGiri HRMS — Password Reset Request';
            $body = "Hello {$admin['full_name']},\n\nA password reset was requested for your VisaGiri HRMS account.\n\nReset your password here (valid for 1 hour):\n{$resetLink}\n\nIf you did not request this, you can ignore this email.\n\n— VisaGiri HRMS";
            $headers = "From: {$fromName} <{$fromAddress}>\r\nReply-To: {$fromAddress}";
            @mail($email, $subject, $body, $headers);

            if (APP_DEBUG) {
                $devResetLink = $resetLink;
            }
        }
    }

    $submitted = true;
}
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Forgot Password · VisaGiri HRMS</title>
<meta name="robots" content="noindex, nofollow">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/tokens.css')) ?>">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/base.css')) ?>">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/components.css')) ?>">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/admin.css')) ?>">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/hrms.css')) ?>">
</head>
<body>
<div class="admin-login-page hrms-login-page">
    <div class="admin-login-card">
        <h1>Forgot Password</h1>
        <?php if ($submitted): ?>
        <div class="alert alert-success">If that email matches an authorized HR account, a password reset link has been sent from <?= e(setting('mail_from_address', 'info@visagiri.com')) ?>.</div>
        <?php if ($devResetLink): ?>
        <div class="alert alert-info">Development mode — no SMTP relay is configured yet, so here's the link directly: <a href="<?= e($devResetLink) ?>"><?= e($devResetLink) ?></a></div>
        <?php endif; ?>
        <p style="margin-top:var(--space-4);text-align:center"><a href="/hrms/login/">Back to Login</a></p>
        <?php else: ?>
        <p>Enter the email address on your HR account and we'll send a reset link.</p>
        <form method="post" action="/hrms/forgot-password/">
            <?= csrf_field() ?>
            <div class="form-group">
                <label class="form-label" for="email">Email</label>
                <input class="form-input" type="email" id="email" name="email" required autofocus>
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%">Send Reset Link</button>
        </form>
        <p style="margin-top:var(--space-4);text-align:center"><a href="/hrms/login/">Back to Login</a></p>
        <?php endif; ?>
    </div>
</div>
</body>
</html>
