<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/seo.php';

$pageTitle = 'Disclaimer — Videshia';
$pageDescription = 'Videshia is an independent visa consultancy, not a government body or embassy. Read our full disclaimer.';
$breadcrumbs = [['Home', url('index.php')], ['Disclaimer', null]];
$schemaBlocks = [breadcrumb_schema($breadcrumbs)];
require __DIR__ . '/includes/header.php';
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Legal</span>
        <h1>Disclaimer</h1>
        <p>Last updated: <?= date('d F Y') ?></p>
    </div>
</section>

<div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

<section class="section">
    <div class="container" style="max-width:840px">
        <p>Videshia is an independent visa consultancy and documentation assistance service. We are not a government body, embassy, consulate, or immigration authority, and we are not affiliated with or endorsed by any government or embassy.</p>
        <p>Visa approval, rejection, processing times and fees are determined solely by the relevant embassy, consulate or government authority — not by Videshia. Information on this website about requirements, fees and processing times is indicative, reviewed regularly, and can change without notice at the discretion of the issuing authority. Always confirm current details with your assigned consultant before applying.</p>
        <p>Nothing on this website constitutes legal or immigration law advice. For complex immigration matters, we recommend consulting a licensed immigration attorney in addition to our visa application support.</p>
        <p>You can apply for most visas directly with the relevant embassy or consulate without using a consultancy service. Videshia's fee is for the documentation review, application preparation and case-tracking support we provide.</p>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
