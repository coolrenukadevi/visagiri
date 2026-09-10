<?php
declare(strict_types=1);

/**
 * Affiliations & Accreditations. No real accrediting-body data exists
 * yet — rather than a bare "coming soon" scaffold, this explains what
 * will be published here and why nothing is listed today, without
 * inventing memberships, certifications, or logos. Stays noindexed
 * until real, verified affiliations exist to publish.
 */

$pageTitle = 'Affiliations & Accreditations - Visagiri';
$pageDescription = "Visagiri's professional affiliations and accreditations, published as they are formally verified.";
$canonicalUrl = APP_URL . '/affiliations/';
$noindex = true;
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:760px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Company</span>
            <h1>Affiliations &amp; Accreditations</h1>
        </div>
        <p style="font-size:var(--font-size-lg);color:var(--text-dark)">
            We only publish memberships, certifications, and professional affiliations once they've been formally
            confirmed — we won't list a body we can't verify or that hasn't approved being named. This page will be
            updated as those confirmations come through.
        </p>
        <p>
            This applies equally to industry bodies, regulatory affiliations, and accreditation programs relevant
            to visa consultancy and document attestation. Rather than list a credential provisionally, we keep
            this page limited to what's been formally verified.
        </p>
        <p>
            Looking to verify a specific credential, or want to know how we're regulated? <a href="/contact/">Contact our team</a> directly, and we'll point you to what applies.
        </p>
        <div style="display:flex;gap:var(--space-3);flex-wrap:wrap;margin-top:var(--space-4)">
            <a href="/about/" class="btn btn-outline">About Us &rarr;</a>
            <a href="/contact/" class="btn btn-outline">Contact Us &rarr;</a>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
