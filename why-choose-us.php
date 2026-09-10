<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/seo.php';

$pageTitle = 'Why Choose Videshia — Visa Consultancy';
$pageDescription = 'What makes Videshia different from a generic visa agency: a named consultant per case, transparent process, and real document review before submission.';
$breadcrumbs = [['Home', url('index.php')], ['Company', null], ['Why Choose Us?', null]];
$schemaBlocks = [breadcrumb_schema($breadcrumbs)];
require __DIR__ . '/includes/header.php';
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Why Choose Us</span>
        <h1>What you get that a search engine can't offer</h1>
        <p>Videshia does not guarantee visa approval or specific processing times — no consultancy honestly can. Here's what we do commit to.</p>
    </div>
</section>

<div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

<section class="section">
    <div class="container grid-2">
        <div class="card">
            <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/></svg></div>
            <h3>A named consultant, not a queue</h3>
            <p>Every enquiry is assigned to a consultant who owns your case end-to-end, so you're never re-explaining your situation to someone new.</p>
        </div>
        <div class="card">
            <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 11l3 3L22 4"/><path d="M21 12v7a2 2 0 01-2 2H5a2 2 0 01-2-2V5a2 2 0 012-2h11"/></svg></div>
            <h3>A checklist before you apply, not after rejection</h3>
            <p>Documents are reviewed against the destination's actual requirements before submission, to catch gaps early — not after an embassy flags them.</p>
        </div>
        <div class="card">
            <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="16" rx="2"/><path d="M3 9h18M8 3v4M16 3v4"/></svg></div>
            <h3>One reference number, full visibility</h3>
            <p>Every enquiry gets a tracked reference number the moment you submit it, with status updates you can check any time.</p>
        </div>
        <div class="card">
            <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12h13M13 6l6 6-6 6"/></svg></div>
            <h3>190+ destinations, one process</h3>
            <p>Whether it's a first-time tourist visa or a recurring business travel pattern, the same disciplined process applies across every destination we support.</p>
        </div>
        <div class="card">
            <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="10" rx="2"/><path d="M7 11V7a5 5 0 0110 0v4"/></svg></div>
            <h3>Transparent, upfront fees</h3>
            <p>Our service fee is disclosed before you confirm — separate from government visa fees, which we never mark up.</p>
        </div>
        <div class="card">
            <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg></div>
            <h3>24×7 support on active cases</h3>
            <p>Once your application is underway, you can reach us any time — not just during business hours.</p>
        </div>
    </div>
</section>

<section class="section section-alt">
    <div class="container">
        <div class="cta-band">
            <div>
                <h2>Ready to get started?</h2>
                <p>Tell us your destination and purpose — we'll route you to the right visa pathway.</p>
            </div>
            <div class="cta-actions">
                <a href="<?= url('enquiry/') ?>" class="btn btn-light btn-lg">Start Your Visa Enquiry</a>
            </div>
        </div>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
