<?php
declare(strict_types=1);

/**
 * "How it works" — Phase 15. Describes the actual application system
 * built in Phases 11/12 (the real 3-step /apply/ wizard and the real
 * 9-stage status sequence from application_status_stages()), not
 * invented marketing steps.
 */

require_once __DIR__ . '/../includes/dashboard-layout.php';

$pageTitle = 'How Visagiri Works - Visa Process';
$pageDescription = 'See how the Visagiri visa application process works, step by step — from choosing your destination to uploading documents and tracking your status online.';
$canonicalUrl = APP_URL . '/visa-process/';
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:840px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Visa Process</span>
            <h1>How Visagiri Works</h1>
        </div>
        <p style="font-size:var(--font-size-lg);color:var(--text-dark)">
            Start your application online, upload documents securely, and track every stage from your dashboard.
        </p>

        <h2 class="country-directory__subheading" style="margin-top:var(--space-8)">Starting an Application</h2>
        <div class="card-grid">
            <div class="card feature-card">
                <div class="feature-card__icon">1</div>
                <div class="card-title">Choose Destination &amp; Visa Type</div>
                <p>Select the country you're travelling to and the visa type that matches your purpose of travel.</p>
            </div>
            <div class="card feature-card">
                <div class="feature-card__icon">2</div>
                <div class="card-title">Enter Applicant Details</div>
                <p>Provide your passport number, date of birth, and nationality.</p>
            </div>
            <div class="card feature-card">
                <div class="feature-card__icon">3</div>
                <div class="card-title">Review &amp; Submit</div>
                <p>Review your details and the document checklist, then submit your application online.</p>
            </div>
        </div>

        <h2 class="country-directory__subheading" style="margin-top:var(--space-10)">After You Apply</h2>
        <p>Once submitted, your application moves through the following stages, visible anytime from your dashboard or via <a href="/track-visa/">application tracking</a>:</p>
        <ol style="padding-left:var(--space-5);line-height:2">
            <?php foreach (application_status_stages() as $label): ?>
            <li><?= e($label) ?></li>
            <?php endforeach; ?>
        </ol>
        <p>
            Service fees, government fees, and any appointment or biometrics scheduling are confirmed by your
            assigned consultant based on your specific requirements — nothing is charged automatically.
        </p>

        <div class="final-cta" style="margin-top:var(--space-10)">
            <h2>Ready to start your visa journey?</h2>
            <a href="/apply/" class="btn btn-gold btn-lg">Start Your Application</a>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
