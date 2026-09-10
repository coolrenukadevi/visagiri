<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/seo.php';

$pageTitle = 'Privacy Policy — Videshia';
$pageDescription = 'How Videshia collects, uses and protects the information you share through enquiry forms, the CRM, and document uploads.';
$breadcrumbs = [['Home', url('index.php')], ['Privacy Policy', null]];
$schemaBlocks = [breadcrumb_schema($breadcrumbs)];
require __DIR__ . '/includes/header.php';
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Legal</span>
        <h1>Privacy Policy</h1>
        <p>Last updated: <?= date('d F Y') ?></p>
    </div>
</section>

<div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

<section class="section">
    <div class="container" style="max-width:840px">
        <p>Videshia ("we", "us") collects the information you submit through our enquiry forms and CRM — including name, contact details, passport and travel details, and uploaded documents — solely to process your visa, travel, forex or insurance request.</p>
        <p>We do not sell your personal data. Information is shared only with the relevant embassy, consulate, airline, hotel, forex partner or insurer required to fulfil your specific request, and with Videshia staff assigned to your case.</p>
        <p>Documents you upload are stored securely and access-controlled; only staff assigned to your enquiry, or administrators for audit purposes, can view them. You may request a copy or deletion of your data by contacting <a href="mailto:info@tripgation.com" style="color:var(--teal-500)">info@tripgation.com</a>, subject to records we're legally required to retain.</p>
        <p>We use cookies for essential site functionality and to keep you signed in — see our <a href="<?= url('cookie-policy/') ?>" style="color:var(--teal-500)">Cookie Policy</a> for details. We do not use third-party advertising trackers.</p>
        <p style="font-size:13px;color:var(--muted-soft);margin-top:32px">This page is a general summary and not exhaustive legal advice. For questions about your specific data, contact our team directly.</p>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
