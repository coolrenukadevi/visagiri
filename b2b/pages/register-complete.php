<?php
declare(strict_types=1);

/** B2B Travel Partner Portal — post-submission confirmation. */

$partner = current_b2b_partner();

if ($partner['status'] === 'draft') {
    redirect('/b2b/register-declaration/');
}

$pageTitle = 'Application Submitted - Visagiri B2B Travel Partner Portal';
$canonicalUrl = APP_URL . '/b2b/register-complete/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:640px">
        <?php render_b2b_enrollment_steps(6); ?>
        <div class="card" style="padding:var(--space-6);text-align:center">
            <h1>Application Submitted Successfully</h1>
            <p>Thank you for registering with Visagiri. Our B2B onboarding team will review your application and contact you after verification.</p>

            <div style="text-align:left;background:var(--bg-alt, #f7f8fa);border-radius:var(--radius-md);padding:var(--space-5);margin:var(--space-5) 0">
                <p><strong>Application ID:</strong> <?= e($partner['partner_reference_no']) ?></p>
                <p><strong>Submission Date:</strong> <?= e(date('d M Y', strtotime((string) $partner['submitted_at']))) ?></p>
                <p><strong>Registered Company:</strong> <?= e($partner['legal_business_name']) ?></p>
                <p><strong>Contact Person:</strong> <?= e(current_b2b_partner_user()['full_name']) ?></p>
                <p style="margin-bottom:0"><strong>Verification Status:</strong> <span class="badge badge-info"><?= e(B2B_STATUS_LABELS[$partner['status']] ?? $partner['status']) ?></span></p>
            </div>

            <p>You can sign in to your dashboard any time to check your application status, add documents, or update your details.</p>
            <a href="/b2b/dashboard/" class="btn btn-primary">Go to Dashboard</a>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
