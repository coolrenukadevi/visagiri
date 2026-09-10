<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/seo.php';

$pageTitle = 'Terms and Conditions — Videshia';
$pageDescription = 'The terms governing use of Videshia\'s visa consultancy services.';
$breadcrumbs = [['Home', url('index.php')], ['Terms and Conditions', null]];
$schemaBlocks = [breadcrumb_schema($breadcrumbs)];
require __DIR__ . '/includes/header.php';
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Legal</span>
        <h1>Terms and Conditions</h1>
        <p>Last updated: <?= date('d F Y') ?></p>
    </div>
</section>

<div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

<section class="section">
    <div class="container" style="max-width:840px">
        <p>Videshia acts as a facilitator for visa applications, travel bookings, forex transactions and insurance policies. Final approval decisions rest entirely with the relevant embassy, consulate, government authority, airline, hotel, forex provider or insurer — Videshia cannot guarantee approval, booking confirmation, or exchange rates beyond what our partners commit to at the time of transaction.</p>
        <p>You are responsible for the accuracy of the information and documents you provide. Submitting false or incomplete information may result in application rejection, for which Videshia is not liable.</p>
        <p>Service fees charged by Videshia are separate from government visa fees, airline/hotel charges, forex margins, or insurance premiums, and are disclosed to you before you confirm an order.</p>
        <p>By submitting an enquiry or engaging Videshia's services, you agree to these terms. We may update them from time to time; continued use of our services after an update constitutes acceptance of the revised terms.</p>
        <p style="font-size:13px;color:var(--muted-soft);margin-top:32px">This page is a general summary and not exhaustive legal advice. For questions about a specific case, contact our team directly.</p>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
