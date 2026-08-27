<?php
declare(strict_types=1);

/** Enrollment wizard confirmation page — shown once, after step 5 finishes. */

$partner = current_partner();

if ($partner['enrollment_completed_at'] === null) {
    redirect(partner_enrollment_next_route($partner, current_partner_business_profile()));
}

$pageTitle = 'Application Submitted - Visagiri B2B Partner Program';
$canonicalUrl = APP_URL . '/partner/register-complete/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:560px;text-align:center">
        <div class="card" style="padding:var(--space-8)">
            <div style="font-size:48px;line-height:1;margin-bottom:var(--space-4)">&#9989;</div>
            <h1>Application Submitted</h1>
            <p style="color:var(--text-muted)">Thanks, <?= e($partner['contact_name']) ?> — your B2B partner application for <strong><?= e($partner['company_name']) ?></strong> is in.</p>

            <div class="card" style="background:var(--visa-blue-light);text-align:left;margin:var(--space-6) 0">
                <p><strong>Application Number:</strong> <?= e($partner['partner_reference_no']) ?></p>
                <p><strong>Registration Date:</strong> <?= e(date('d M Y', strtotime((string) $partner['created_at']))) ?></p>
                <p><strong>Current Status:</strong> <span class="badge badge-warning">Pending Review</span></p>
                <p><strong>Assigned Relationship Manager:</strong> To be assigned during review</p>
            </div>

            <h2 style="text-align:left">Next Steps</h2>
            <ul style="text-align:left;color:var(--text-muted)">
                <li>Our team reviews your application and any documents you uploaded.</li>
                <li>You'll be able to sign in anytime to check your status from your partner dashboard.</li>
                <li>Once approved, you'll get a referral link and access to commission tracking.</li>
            </ul>

            <div style="display:flex;gap:var(--space-3);justify-content:center;margin-top:var(--space-6);flex-wrap:wrap">
                <a href="/partner/dashboard/" class="btn btn-primary">Go to Dashboard</a>
                <a href="<?= e(whatsapp_enquiry_href('Hi Visagiri, I just submitted a B2B partner application (' . $partner['partner_reference_no'] . ') and have a question.')) ?>" class="btn btn-outline" target="_blank" rel="noopener noreferrer">Chat with us on WhatsApp</a>
            </div>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
