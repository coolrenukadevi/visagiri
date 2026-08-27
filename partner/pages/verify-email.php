<?php
declare(strict_types=1);

/**
 * Handles the emailed verification link from register-contact.php.
 * Doesn't require login — the link may be opened on a different
 * device/browser than the one mid-wizard — so it just marks the
 * email verified and tells the visitor to log in if they aren't
 * already. If they are logged in as this same partner, it sends them
 * straight back into the wizard.
 */

$token = trim((string) ($_GET['token'] ?? ''));
$verifiedPartner = $token !== '' ? verify_partner_email_verification_token($token) : null;

if ($verifiedPartner !== null && is_partner_logged_in() && current_partner_id() === (int) $verifiedPartner['id']) {
    flash_set('notice', 'Email verified!');
    redirect(partner_enrollment_next_route(current_partner(), current_partner_business_profile()));
}

$pageTitle = 'Verify Email - Visagiri B2B Partner Program';
$canonicalUrl = APP_URL . '/partner/verify-email/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:480px;text-align:center">
        <div class="card" style="padding:var(--space-8)">
            <?php if ($verifiedPartner !== null): ?>
            <div style="font-size:48px;line-height:1;margin-bottom:var(--space-4)">&#9989;</div>
            <h1>Email Verified</h1>
            <p style="color:var(--text-muted)">Thanks — your email address is confirmed.</p>
            <a href="/partner/login/" class="btn btn-primary" style="margin-top:var(--space-4)">Log In to Continue</a>
            <?php else: ?>
            <h1>Link Invalid or Expired</h1>
            <p style="color:var(--text-muted)">This verification link is no longer valid. Log in and use "Resend verification email" from your dashboard to get a new one.</p>
            <a href="/partner/login/" class="btn btn-outline" style="margin-top:var(--space-4)">Go to Login</a>
            <?php endif; ?>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
