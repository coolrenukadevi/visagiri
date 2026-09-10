<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/seo.php';

$pageTitle = 'Cookie Policy — Videshia';
$pageDescription = 'What cookies Videshia uses and why — essential site functionality only, no third-party advertising trackers.';
$breadcrumbs = [['Home', url('index.php')], ['Cookie Policy', null]];
$schemaBlocks = [breadcrumb_schema($breadcrumbs)];
require __DIR__ . '/includes/header.php';
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Legal</span>
        <h1>Cookie Policy</h1>
        <p>Last updated: <?= date('d F Y') ?></p>
    </div>
</section>

<div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

<section class="section">
    <div class="container" style="max-width:840px">
        <p>Videshia uses a small number of cookies, all limited to making the site work properly:</p>
        <ul style="display:flex;flex-direction:column;gap:10px;margin:20px 0">
            <li style="display:flex;gap:10px;font-size:14.5px;color:var(--navy-800)"><svg style="flex-shrink:0;margin-top:3px" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#17c3c9" stroke-width="3"><path d="M4 12l5 5L20 6"/></svg><span><strong>Session cookies</strong> — keep you signed in to the customer portal or CRM while you're using it.</span></li>
            <li style="display:flex;gap:10px;font-size:14.5px;color:var(--navy-800)"><svg style="flex-shrink:0;margin-top:3px" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#17c3c9" stroke-width="3"><path d="M4 12l5 5L20 6"/></svg><span><strong>Security cookies</strong> — protect forms against cross-site request forgery.</span></li>
        </ul>
        <p>We do not use third-party advertising or tracking cookies, and we do not sell data collected via cookies. You can disable cookies in your browser settings, but doing so will prevent you from signing in to the customer portal or CRM.</p>
        <p style="font-size:13px;color:var(--muted-soft);margin-top:32px">See our <a href="<?= url('privacy-policy/') ?>" style="color:var(--teal-500)">Privacy Policy</a> for how we handle the personal data you submit through forms.</p>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
