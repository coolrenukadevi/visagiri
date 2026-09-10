<?php
declare(strict_types=1);

/**
 * Corporate Services. There's no separate corporate-enquiry workflow
 * or dedicated account-management tier built yet — this describes
 * corporate/group visa support as a real extension of the existing
 * consultancy process (the same document review, eligibility guidance,
 * and submission assistance every enquiry gets), routed through the
 * existing Contact form and B2B portal, rather than inventing a
 * distinct corporate product that doesn't exist. Stays noindexed —
 * it's a real page but a thin one relative to what a fuller corporate
 * offering page would eventually need.
 */

$pageTitle = 'Corporate Visa Services - Visagiri';
$pageDescription = 'Visa consultancy and application-management support for corporate travel, group applications, and business travel partners.';
$canonicalUrl = APP_URL . '/corporate-services/';
$noindex = true;
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:760px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Company</span>
            <h1>Corporate Visa Services</h1>
        </div>
        <p style="font-size:var(--font-size-lg);color:var(--text-dark)">
            Businesses sending employees on work travel, or coordinating visas for a group, get the same consultant-led
            process every applicant does — eligibility guidance, document review, and submission assistance — coordinated
            across everyone travelling together, with one point of contact managing the group.
        </p>
        <p>
            Running a travel agency or business that regularly refers visa clients? Our
            <a href="/b2b-partner/">B2B Travel Partner Portal</a> is built specifically for that relationship.
        </p>

        <div class="final-cta" style="margin-top:var(--space-8)">
            <h2>Coordinating visas for your team?</h2>
            <a href="/contact/" class="btn btn-gold btn-lg">Get Visa Assistance</a>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
