<?php
declare(strict_types=1);

/**
 * About page. Facts used here (founding date, parent company, CIN)
 * are client-confirmed — see AUDIT.md §1/§7 — not invented. The
 * "Why Visagiri" list is shared with the homepage via
 * why_visagiri_features() so the two never drift out of sync.
 */

$pageTitle = 'About Visagiri - Visa Consultancy Since April 2015';
$pageDescription = 'Visagiri is a visa consultancy brand under Tripgation Pvt Ltd, serving visa and travel-related requirements since April 2015.';
$canonicalUrl = APP_URL . '/about/';
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:840px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">About Us</span>
            <h1>About Visagiri</h1>
        </div>
        <p style="font-size:var(--font-size-lg);color:var(--text-dark)">
            Since April 2015, Visagiri has been shaping global journeys with trusted immigration expertise, personalised guidance, and seamless end-to-end support.
        </p>
        <p>
            Visagiri is a visa consultancy and document-attestation brand under <strong>Tripgation Pvt Ltd</strong>,
            offering visa consultancy, application-management assistance, and attestation services
            (apostille, MEA, embassy, and commercial attestation) for travellers, students, professionals, and businesses.
        </p>
        <p>
            Visa and immigration decisions are always made by the relevant embassy, consulate, or government
            immigration authority. Visagiri assists with preparation, documentation, and application management,
            and does not guarantee visa approval.
        </p>
    </div>
</section>

<section class="section" id="our-story">
    <div class="container" style="max-width:840px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Our Story</span>
            <h2>Our Journey</h2>
        </div>
        <p>
            Visagiri was founded in April 2015 as a visa consultancy and document-attestation brand under
            <strong>Tripgation Pvt Ltd</strong>, built to give travellers, students, professionals, and businesses
            a more organized, technology-enabled way to manage the visa and attestation process — from checking
            requirements through to tracking an application's status online, rather than relying on paperwork and
            phone calls alone.
        </p>
        <p>
            That approach — real digital tools paired with hands-on consultant support — remains the foundation
            Visagiri continues to build on today.
        </p>
    </div>
</section>

<section class="section" id="why-visagiri" style="background:var(--surface)">
    <div class="container">
        <div class="section-heading">
            <span class="section-eyebrow">Why Visagiri</span>
            <h2>Built for a Better Visa Experience</h2>
        </div>
        <div class="card-grid">
            <?php foreach (why_visagiri_features() as $f): ?>
            <div class="card feature-card">
                <div class="feature-card__icon">&#9679;</div>
                <div class="card-title"><?= e($f['title']) ?></div>
                <p><?= e($f['desc']) ?></p>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="final-cta">
            <h2>Ready to start your visa journey?</h2>
            <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to start my visa journey.")) ?>" class="btn btn-gold btn-lg" target="_blank" rel="noopener noreferrer">Enquire Now</a>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
