<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';

$ref = $_GET['ref'] ?? '';
if (!preg_match('/^VDH-\d{4}-\d{6}$/', $ref)) {
    header('Location: ' . url('index.php'));
    exit;
}

$pageTitle = 'Enquiry received — Videshia';
$robotsMeta = 'noindex, follow';
require __DIR__ . '/includes/header.php';
?>

<section class="section" style="padding-top:80px;padding-bottom:100px">
    <div class="container" style="max-width:600px;text-align:center">
        <div style="width:64px;height:64px;border-radius:50%;background:var(--teal-100);display:flex;align-items:center;justify-content:center;margin:0 auto 24px">
            <svg width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="#0b7a7e" stroke-width="3"><path d="M4 12l5 5L20 6"/></svg>
        </div>
        <h1>Thanks — we've got your enquiry.</h1>
        <p style="font-size:16px">A Videshia consultant will reach out shortly. Keep this reference number handy for any follow-up.</p>
        <div class="card" style="display:inline-block;padding:18px 28px;margin:20px 0">
            <p style="margin:0;font-size:12px;color:var(--muted);text-transform:uppercase;letter-spacing:.06em">Enquiry reference</p>
            <p style="margin:4px 0 0;font-size:22px;font-weight:700;font-family:var(--font-head);color:var(--navy-900)"><?= e($ref) ?></p>
        </div>
        <div class="hero-actions" style="justify-content:center">
            <a href="<?= url('index.php') ?>" class="btn btn-ghost">Back to home</a>
            <a href="<?= url('visa-services/') ?>" class="btn btn-primary">Explore visa services</a>
        </div>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
