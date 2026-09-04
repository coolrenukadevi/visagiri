<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/seo.php';

$pageTitle = '24x7 Support — Videshia';
$pageDescription = 'How to reach Videshia support any time — WhatsApp, phone, email, and application tracking for active cases.';
$breadcrumbs = [['Home', url('index.php')], ['Company', null], ['Support 24×7', null]];
$schemaBlocks = [breadcrumb_schema($breadcrumbs)];
require __DIR__ . '/includes/header.php';
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Support</span>
        <h1>Help, whenever your application needs it.</h1>
        <p>Visa deadlines don't keep office hours — once your case is active, neither do we.</p>
    </div>
</section>

<div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

<section class="section">
    <div class="container grid-3">
        <div class="card">
            <div class="card-icon" style="background:#e7f9ee;color:#25D366"><svg width="22" height="22" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 00-8.6 15L2 22l5.2-1.4A10 10 0 1012 2zm5.8 14.3c-.3.7-1.4 1.3-2 1.4-.5.1-1.2.1-1.9-.1-.4-.1-1-.3-1.7-.6-3-1.3-4.9-4.3-5.1-4.5-.1-.2-1.2-1.6-1.2-3.1s.8-2.2 1.1-2.5c.3-.3.6-.4.8-.4h.6c.2 0 .4 0 .6.5.2.5.8 1.9.8 2 .1.2.1.3 0 .5-.1.2-.1.3-.3.5l-.4.5c-.1.2-.3.3-.1.6.2.3.9 1.4 1.9 2.3 1.3 1.1 2.3 1.5 2.7 1.7.3.1.5.1.6-.1.2-.2.7-.8.9-1.1.2-.3.4-.2.6-.1l1.8.9c.2.1.4.2.4.3.1.3.1.9-.2 1.5z"/></svg></div>
            <h3>WhatsApp</h3>
            <p>The fastest way to reach us — message us any time.</p>
            <a href="https://wa.me/917844819819" target="_blank" rel="noopener" class="btn btn-ghost" style="margin-top:10px">Chat on WhatsApp</a>
        </div>
        <div class="card">
            <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.9v3a2 2 0 01-2.2 2 19.8 19.8 0 01-8.6-3.1 19.5 19.5 0 01-6-6 19.8 19.8 0 01-3.1-8.7A2 2 0 014.1 2h3a2 2 0 012 1.7c.1 1 .3 2 .6 2.9a2 2 0 01-.5 2.1L8 10a16 16 0 006 6l1.3-1.2a2 2 0 012.1-.5c.9.3 1.9.5 2.9.6a2 2 0 011.7 2z"/></svg></div>
            <h3>Call</h3>
            <p>Speak directly with a consultant for urgent, time-sensitive queries.</p>
            <a href="tel:+917844819819" class="btn btn-ghost" style="margin-top:10px">+91 78448 19819</a>
        </div>
        <div class="card">
            <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg></div>
            <h3>Track your application</h3>
            <p>Check your case status any time with your enquiry reference number.</p>
            <a href="<?= url('track-application/') ?>" class="btn btn-ghost" style="margin-top:10px">Track Application</a>
        </div>
    </div>

    <div class="section-head center" style="margin-top:56px">
        <span class="eyebrow">How it works</span>
        <h2>What "24×7" means in practice</h2>
    </div>
    <div class="grid-2" style="max-width:820px;margin:0 auto">
        <div class="card">
            <h3>Active applications</h3>
            <p>Once your enquiry becomes an active case with an assigned consultant, you can reach the team any time via WhatsApp or phone for updates and urgent questions.</p>
        </div>
        <div class="card">
            <h3>New enquiries</h3>
            <p>New enquiries submitted outside business hours are picked up first thing the next business day — your reference number and confirmation are generated instantly regardless of when you submit.</p>
        </div>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
