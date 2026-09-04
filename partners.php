<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/seo.php';

$pageTitle = 'Partner With Videshia — Travel Agency & B2B Programme';
$pageDescription = 'Videshia\'s partner programme for travel agents and agencies: route your clients\' visa applications through our platform with dedicated support.';
$breadcrumbs = [['Home', url('index.php')], ['Company', null], ['Partners', null]];
$schemaBlocks = [breadcrumb_schema($breadcrumbs)];
require __DIR__ . '/includes/header.php';
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Partners</span>
        <h1>Run your clients' visa applications through Videshia.</h1>
        <p>For travel agents and agencies who want visa processing handled by specialists, with full visibility into every case.</p>
    </div>
</section>

<div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

<section class="section">
    <div class="container grid-3">
        <div class="card">
            <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="16" rx="2"/><path d="M3 9h18M8 3v4M16 3v4"/></svg></div>
            <h3>Bulk case handling</h3>
            <p>Submit multiple client applications and track them all from one place, without re-explaining requirements per case.</p>
        </div>
        <div class="card">
            <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/></svg></div>
            <h3>A dedicated point of contact</h3>
            <p>Partner accounts are assigned a consultant who understands your client base, not a generic support queue.</p>
        </div>
        <div class="card">
            <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 11l3 3L22 4"/><path d="M21 12v7a2 2 0 01-2 2H5a2 2 0 01-2-2V5a2 2 0 012-2h11"/></svg></div>
            <h3>Transparent status tracking</h3>
            <p>Every application gets a reference number your team and your clients can both track independently.</p>
        </div>
    </div>

    <div class="card" style="margin-top:32px;padding:36px;text-align:center">
        <h3>Interested in partnering with Videshia?</h3>
        <p>Tell us about your agency and your typical case volume — we'll follow up to discuss how the partnership works.</p>
        <a href="<?= url('contact/') ?>" class="btn btn-primary">Enquire about partnership</a>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
