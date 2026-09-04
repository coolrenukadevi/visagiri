<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/seo.php';

$pageTitle = 'Leadership — Videshia';
$pageDescription = 'The disciplines and operating principles behind Videshia\'s visa consultancy leadership team.';
$breadcrumbs = [['Home', url('index.php')], ['Company', null], ['Leadership', null]];
$schemaBlocks = [breadcrumb_schema($breadcrumbs)];
require __DIR__ . '/includes/header.php';
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Leadership</span>
        <h1>Led by people who've done the paperwork themselves.</h1>
        <p>Videshia is run by a small team spanning visa consulting, operations and technology — not a call centre with a script.</p>
    </div>
</section>

<div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

<section class="section">
    <div class="container grid-3">
        <div class="card">
            <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 11l3 3L22 4"/><path d="M21 12v7a2 2 0 01-2 2H5a2 2 0 01-2-2V5a2 2 0 012-2h11"/></svg></div>
            <h3>Visa Operations</h3>
            <p>Owns the day-to-day accuracy of every application — document review standards, embassy-specific process knowledge, and the consultant assignment workflow.</p>
        </div>
        <div class="card">
            <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="16" rx="2"/><path d="M3 9h18M8 3v4M16 3v4"/></svg></div>
            <h3>Technology &amp; Tracking</h3>
            <p>Builds and maintains the systems that match applicants to the right visa pathway and keep every case visible end-to-end.</p>
        </div>
        <div class="card">
            <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/></svg></div>
            <h3>Customer &amp; Partner Success</h3>
            <p>Responsible for the consultant relationship — response times, follow-up discipline, and the partner-agency onboarding experience.</p>
        </div>
    </div>

    <div class="card" style="margin-top:32px;padding:32px;text-align:center">
        <h3>Want to know who's handling your case?</h3>
        <p>Every enquiry is assigned to a named consultant, not a shared inbox — <a href="<?= url('contact/') ?>" style="color:var(--teal-500);font-weight:600">get in touch</a> and we'll introduce you.</p>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
