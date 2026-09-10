<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/seo.php';

$pageTitle = 'Careers at Videshia';
$pageDescription = 'Join Videshia\'s visa consultancy team — roles in visa operations, customer success and technology.';
$breadcrumbs = [['Home', url('index.php')], ['Company', null], ['Careers', null]];
$schemaBlocks = [breadcrumb_schema($breadcrumbs)];
require __DIR__ . '/includes/header.php';
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Careers</span>
        <h1>Help us make visa applications less painful.</h1>
        <p>We're a small, growing team working across visa operations, customer success and technology.</p>
    </div>
</section>

<div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

<section class="section">
    <div class="container grid-2" style="align-items:center">
        <div>
            <span class="eyebrow">What we look for</span>
            <h2>People who sweat the details</h2>
            <p>Visa consulting rewards precision — a missed document or an inconsistent date can cost an applicant weeks. We look for people who take that seriously, communicate clearly with clients under time pressure, and are comfortable with process and documentation.</p>
            <p>We hire across visa operations (document review, embassy liaison), customer-facing consulting roles, and technology (the platform that routes and tracks every case).</p>
        </div>
        <div class="grid-2">
            <div class="card"><h3>Operations</h3><p>Document review, embassy coordination, case processing.</p></div>
            <div class="card"><h3>Consulting</h3><p>Client-facing advisory across visa categories.</p></div>
            <div class="card"><h3>Technology</h3><p>The routing, tracking and CRM systems behind every case.</p></div>
            <div class="card"><h3>Operations Support</h3><p>Scheduling, follow-ups, and partner-agency coordination.</p></div>
        </div>
    </div>
</section>

<section class="section section-alt">
    <div class="container" style="max-width:640px;text-align:center">
        <div class="card" style="padding:36px">
            <h3>Don't see an open role listed?</h3>
            <p>We don't always have live postings up, but we're happy to hear from people who'd be a strong fit. Send us a note about what you'd bring to the team.</p>
            <a href="<?= url('contact/') ?>" class="btn btn-primary">Get in touch</a>
        </div>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
