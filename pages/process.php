<?php
declare(strict_types=1);

/**
 * "How it works" — describes the real, current process: a
 * consultant-led enquiry-to-application flow (WhatsApp/call/contact
 * form, document guidance, submission by our team), not a self-serve
 * online wizard. See AUDIT.md, "Single-folder no-database rebuild".
 */

$pageTitle = 'How Visagiri Works - Visa Process';
$pageDescription = 'See how the Visagiri visa process works, step by step — from your enquiry to document preparation and application submission.';
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
            Reach out with your destination and purpose of travel, and our team guides you through eligibility, documents, and submission.
        </p>

        <h2 class="country-directory__subheading" style="margin-top:var(--space-8)">Getting Started</h2>
        <div class="card-grid">
            <div class="card feature-card">
                <div class="feature-card__icon">1</div>
                <div class="card-title">Tell Us Your Destination &amp; Visa Type</div>
                <p>Reach out via WhatsApp, call, or the enquiry form with the country you're travelling to and your purpose of travel.</p>
            </div>
            <div class="card feature-card">
                <div class="feature-card__icon">2</div>
                <div class="card-title">Share Your Details</div>
                <p>We confirm eligibility and the exact documents your application needs based on your passport, nationality, and travel plans.</p>
            </div>
            <div class="card feature-card">
                <div class="feature-card__icon">3</div>
                <div class="card-title">We Prepare &amp; Submit</div>
                <p>Our team reviews your documents and application before submitting it to the relevant embassy, consulate, or authority.</p>
            </div>
        </div>

        <h2 class="country-directory__subheading" style="margin-top:var(--space-10)">After You Enquire</h2>
        <p>
            Service fees, government fees, and any appointment or biometrics scheduling are confirmed by your
            assigned consultant based on your specific requirements — nothing is charged automatically.
        </p>

        <div class="final-cta" style="margin-top:var(--space-10)">
            <h2>Ready to start your visa journey?</h2>
            <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to start my visa journey.")) ?>" class="btn btn-gold btn-lg" target="_blank" rel="noopener noreferrer">Enquire Now</a>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
