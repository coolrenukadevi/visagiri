<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/seo.php';

$pageTitle = 'About Us — Videshia Visa Consultancy';
$pageDescription = 'Videshia is a visa consultancy and documentation support service for Indian travellers, backed by real consultant oversight on every case.';
$breadcrumbs = [['Home', url('index.php')], ['Company', null], ['About Us', null]];
$schemaBlocks = [breadcrumb_schema($breadcrumbs)];
require __DIR__ . '/includes/header.php';
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">About Videshia</span>
        <h1>Built to make borders feel smaller.</h1>
        <p>Videshia pairs real visa consultancy expertise with a structured, trackable process — so your application moves with fewer surprises.</p>
    </div>
</section>

<div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

<section class="section">
    <div class="container grid-2" style="align-items:center">
        <div>
            <span class="eyebrow">Our story</span>
            <h2>From manual case files to a structured process</h2>
            <p>Videshia started with a simple observation: visa processing hasn't changed much in decades, even as the world got more mobile. Applicants and agencies alike were still cross-checking documents by hand and chasing embassies by phone.</p>
            <p>We built Videshia around a structured process that matches every application to the right visa category, checklist and embassy requirements — with a named consultant on every case, not a rotating support queue.</p>
            <p>Today, travellers and partner agencies use Videshia to move visa applications across 190+ destinations with far less friction and far fewer surprises.</p>
        </div>
        <div class="grid-2">
            <div class="card"><h3>190+</h3><p>Destination countries with visa guidance and support.</p></div>
            <div class="card"><h3>9</h3><p>Visa categories covered end-to-end.</p></div>
            <div class="card"><h3>24/7</h3><p>Support availability for active applications.</p></div>
            <div class="card"><h3>1:1</h3><p>A named consultant assigned to every enquiry.</p></div>
        </div>
    </div>
</section>

<section class="section section-alt">
    <div class="container">
        <div class="section-head center">
            <span class="eyebrow">What we stand for</span>
            <h2>The principles behind Videshia</h2>
        </div>
        <div class="grid-3">
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 2l3 7h7l-5.5 4.5L18 21l-6-4-6 4 1.5-7.5L2 9h7z"/></svg></div>
                <h3>Accuracy first</h3>
                <p>Every document review is explainable — we tell you why something was flagged, not just that it was.</p>
            </div>
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="10" rx="2"/><path d="M7 11V7a5 5 0 0110 0v4"/></svg></div>
                <h3>Privacy by design</h3>
                <p>Your information and documents are access-controlled and used only to process your case.</p>
            </div>
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/></svg></div>
                <h3>A named consultant, always</h3>
                <p>Every case is reviewed by your assigned consultant, who makes the judgement calls — not an automated queue.</p>
            </div>
        </div>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="cta-band">
            <div>
                <h2>Want to see Videshia in action?</h2>
                <p>Talk to our team about your visa application or your agency's visa pipeline.</p>
            </div>
            <div class="cta-actions">
                <a href="<?= url('contact/') ?>" class="btn btn-light btn-lg">Contact us</a>
            </div>
        </div>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
