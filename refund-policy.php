<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/seo.php';

$pageTitle = 'Refund Policy — Videshia';
$pageDescription = 'When Videshia\'s service fee is refundable, and how government visa fees are handled.';
$breadcrumbs = [['Home', url('index.php')], ['Refund Policy', null]];
$schemaBlocks = [breadcrumb_schema($breadcrumbs)];
require __DIR__ . '/includes/header.php';
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Legal</span>
        <h1>Refund Policy</h1>
        <p>Last updated: <?= date('d F Y') ?></p>
    </div>
</section>

<div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

<section class="section">
    <div class="container" style="max-width:840px">
        <p>Videshia's service fee is refundable in full if we have not yet begun work on your case (document review, appointment booking, or submission). Once an application has been submitted to an embassy, airline, hotel, forex partner or insurer, our service fee is non-refundable, though any refundable third-party amount (e.g. a cancellable hotel booking) will be passed on per that partner's own policy.</p>
        <p>Government visa fees, once paid to an embassy or consulate, are governed by that authority's own refund policy and are typically non-refundable regardless of application outcome.</p>
        <p>For a refund request, contact <a href="mailto:info@tripgation.com" style="color:var(--teal-500)">info@tripgation.com</a> with your enquiry reference number.</p>
        <p style="font-size:13px;color:var(--muted-soft);margin-top:32px">This page is a general summary and not exhaustive legal advice. For questions about a specific case, contact our team directly.</p>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
