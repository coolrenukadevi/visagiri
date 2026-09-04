<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/seo.php';

$pageTitle = 'Accessibility — Videshia';
$pageDescription = 'Videshia\'s commitment to an accessible website, and how to report an accessibility issue.';
$breadcrumbs = [['Home', url('index.php')], ['Accessibility', null]];
$schemaBlocks = [breadcrumb_schema($breadcrumbs)];
require __DIR__ . '/includes/header.php';
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Legal</span>
        <h1>Accessibility</h1>
        <p>Last updated: <?= date('d F Y') ?></p>
    </div>
</section>

<div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

<section class="section">
    <div class="container" style="max-width:840px">
        <p>Videshia is built with semantic HTML, keyboard-navigable menus and forms, sufficient colour contrast, and descriptive labels throughout — so the site works whether you're using a mouse, a keyboard, or a screen reader.</p>
        <p>We're continuing to improve accessibility across the site. If you encounter a page, form, or feature that's difficult to use with assistive technology, please tell us — specifics (the page, what you were trying to do, and what happened) help us fix it faster.</p>
        <p>Contact <a href="mailto:info@tripgation.com" style="color:var(--teal-500)">info@tripgation.com</a> or reach us via <a href="<?= url('contact/') ?>" style="color:var(--teal-500)">our contact page</a> to report an accessibility issue.</p>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
