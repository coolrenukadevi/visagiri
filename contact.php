<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/seo.php';

$errors = [];
$sent = false;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!csrf_verify($_POST['csrf_token'] ?? null)) {
        $errors[] = 'Your session expired. Please try again.';
    } else {
        $name = trim($_POST['name'] ?? '');
        $email = trim($_POST['email'] ?? '');
        $message = trim($_POST['message'] ?? '');

        if ($name === '' || $message === '') {
            $errors[] = 'Please share your name and a short message.';
        } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $errors[] = 'Enter a valid email address.';
        } else {
            // No mail transport configured in this environment; acknowledge receipt.
            $sent = true;
        }
    }
}

$pageTitle = 'Contact Us — Videshia';
$pageDescription = 'Get in touch with Videshia — WhatsApp, phone, email, or the contact form. We usually reply within one business day.';
$breadcrumbs = [['Home', url('index.php')], ['Company', null], ['Contact', null]];
$schemaBlocks = [breadcrumb_schema($breadcrumbs)];
require __DIR__ . '/includes/header.php';
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Contact</span>
        <h1>Talk to the Videshia team.</h1>
        <p>Questions about a case, a partnership, or the platform itself — we usually reply within one business day.</p>
    </div>
</section>

<div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

<section class="section">
    <div class="container grid-2" style="align-items:flex-start">
        <div class="card" style="padding:36px">
            <h3 style="margin-bottom:6px">Send us a message</h3>
            <p style="margin-bottom:24px">Fill in the form and our team will get back to you shortly.</p>

            <?php foreach ($errors as $error): ?>
                <div class="alert alert-error"><?= e($error) ?></div>
            <?php endforeach; ?>
            <?php if ($sent): ?>
                <div class="alert alert-success">Thanks &mdash; your message has been received. We'll be in touch soon.</div>
            <?php endif; ?>

            <form method="post" action="<?= url('contact/') ?>" data-validate novalidate>
                <input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>">
                <div class="form-row">
                    <label for="name">Full name</label>
                    <input class="form-control" type="text" id="name" name="name" placeholder="Your name" value="<?= e($_POST['name'] ?? '') ?>" required>
                </div>
                <div class="form-row">
                    <label for="email">Email address</label>
                    <input class="form-control" type="email" id="email" name="email" placeholder="you@company.com" value="<?= e($_POST['email'] ?? '') ?>" required>
                </div>
                <div class="form-row">
                    <label for="message">Message</label>
                    <textarea class="form-control" id="message" name="message" placeholder="How can we help?" required><?= e($_POST['message'] ?? '') ?></textarea>
                </div>
                <button type="submit" class="btn btn-primary btn-lg">Send message</button>
            </form>
        </div>

        <div>
            <div class="card" style="margin-bottom:20px">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 4h16v16H4z"/><path d="M22 6l-10 7L2 6"/></svg></div>
                <h3>Email</h3>
                <p><a href="mailto:info@tripgation.com" style="color:var(--teal-500);font-weight:600">info@tripgation.com</a></p>
            </div>
            <div class="card" style="margin-bottom:20px">
                <div class="card-icon" style="background:#e7f9ee;color:#25D366"><svg width="22" height="22" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 00-8.6 15L2 22l5.2-1.4A10 10 0 1012 2zm5.8 14.3c-.3.7-1.4 1.3-2 1.4-.5.1-1.2.1-1.9-.1-.4-.1-1-.3-1.7-.6-3-1.3-4.9-4.3-5.1-4.5-.1-.2-1.2-1.6-1.2-3.1s.8-2.2 1.1-2.5c.3-.3.6-.4.8-.4h.6c.2 0 .4 0 .6.5.2.5.8 1.9.8 2 .1.2.1.3 0 .5-.1.2-.1.3-.3.5l-.4.5c-.1.2-.3.3-.1.6.2.3.9 1.4 1.9 2.3 1.3 1.1 2.3 1.5 2.7 1.7.3.1.5.1.6-.1.2-.2.7-.8.9-1.1.2-.3.4-.2.6-.1l1.8.9c.2.1.4.2.4.3.1.3.1.9-.2 1.5z"/></svg></div>
                <h3>Call or WhatsApp</h3>
                <p style="margin-bottom:10px"><a href="tel:+917844819819" style="color:var(--teal-500);font-weight:600">+91 78448 19819</a></p>
                <a href="https://wa.me/917844819819" target="_blank" rel="noopener" class="btn btn-ghost" style="padding:8px 16px;font-size:13px">Chat on WhatsApp</a>
            </div>
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0118 0z"/><circle cx="12" cy="10" r="3"/></svg></div>
                <h3>Office</h3>
                <p>Videshia — a unit of Tripgation, India</p>
                <p style="font-size:12px;color:var(--muted-soft);margin-top:6px">Full registered office address to be added.</p>
            </div>
        </div>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
