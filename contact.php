<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';

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

$pageTitle = 'Contact — Videshia';
require __DIR__ . '/includes/header.php';
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Contact</span>
        <h1>Talk to the Videshia team.</h1>
        <p>Questions about a case, a partnership, or the platform itself — we usually reply within one business day.</p>
    </div>
</section>

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

            <form method="post" action="<?= url('contact.php') ?>" data-validate novalidate>
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
                <p><a href="mailto:hello@videshia.com" style="color:var(--teal-500);font-weight:600">hello@videshia.com</a></p>
            </div>
            <div class="card" style="margin-bottom:20px">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.9v3a2 2 0 01-2.2 2 19.8 19.8 0 01-8.6-3.1 19.5 19.5 0 01-6-6 19.8 19.8 0 01-3.1-8.7A2 2 0 014.1 2h3a2 2 0 012 1.7c.1 1 .3 2 .6 2.9a2 2 0 01-.5 2.1L8 10a16 16 0 006 6l1.3-1.2a2 2 0 012.1-.5c.9.3 1.9.5 2.9.6a2 2 0 011.7 2z"/></svg></div>
                <h3>Phone</h3>
                <p><a href="tel:+911140840000" style="color:var(--teal-500);font-weight:600">+91 11 4084 0000</a></p>
            </div>
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0118 0z"/><circle cx="12" cy="10" r="3"/></svg></div>
                <h3>Office</h3>
                <p>Videshia Technologies, Cyber Hub, Gurugram, India</p>
            </div>
        </div>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
