<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/db.php';
require __DIR__ . '/includes/seo.php';

$result = null;
$notFound = false;

if ($_SERVER['REQUEST_METHOD'] === 'POST' && csrf_verify($_POST['csrf_token'] ?? null)) {
    $ref = strtoupper(trim($_POST['reference'] ?? ''));
    $contact = trim($_POST['contact'] ?? '');

    if (preg_match('/^VDH-\d{4}-\d{6}$/', $ref) && $contact !== '') {
        $stmt = db()->prepare(
            'SELECT e.reference_no, e.service_type, e.status, e.destination, e.created_at, e.updated_at, c.name AS customer_name,
                    v.application_status AS visa_status
             FROM enquiries e JOIN customers c ON c.id = e.customer_id
             LEFT JOIN visa_enquiries v ON v.enquiry_id = e.id
             WHERE e.reference_no = ? AND (c.email = ? OR c.mobile = ?)'
        );
        $stmt->execute([$ref, $contact, $contact]);
        $result = $stmt->fetch();
        $notFound = !$result;
        if ($result) {
            $result['display_status'] = $result['visa_status'] ?: $result['status'];
        }
    } else {
        $notFound = true;
    }
}

$pageTitle = 'Track Your Application — Videshia';
$pageDescription = 'Check the status of your Videshia visa, travel or forex enquiry using your reference number.';
$breadcrumbs = [['Home', url('index.php')], ['Track Application', null]];
$schemaBlocks = [breadcrumb_schema($breadcrumbs)];
require __DIR__ . '/includes/header.php';
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Track Application</span>
        <h1>Check your application status</h1>
        <p>Enter your enquiry reference number along with the mobile or email you used to submit it.</p>
    </div>
</section>

<div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

<section class="section">
    <div class="container" style="max-width:520px">
        <div class="card" style="padding:32px">
            <form method="post" action="<?= url('track-application/') ?>" data-validate novalidate>
                <input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>">
                <div class="form-row">
                    <label for="reference">Enquiry reference number</label>
                    <input class="form-control" type="text" id="reference" name="reference" placeholder="VDH-2026-000001" value="<?= e($_POST['reference'] ?? '') ?>" required>
                </div>
                <div class="form-row">
                    <label for="contact">Mobile or email used at submission</label>
                    <input class="form-control" type="text" id="contact" name="contact" placeholder="you@example.com or mobile number" value="<?= e($_POST['contact'] ?? '') ?>" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block btn-lg">Track Application</button>
            </form>

            <?php if ($notFound): ?>
            <div class="alert alert-error" style="margin-top:20px">We couldn't find a matching application. Double-check your reference number and contact details, or <a href="<?= url('contact/') ?>" style="color:inherit;text-decoration:underline">contact us</a> for help.</div>
            <?php endif; ?>
        </div>

        <?php if ($result): ?>
        <div class="card" style="padding:32px;margin-top:20px">
            <span class="eyebrow" style="text-transform:capitalize"><?= e($result['service_type']) ?> Enquiry</span>
            <h3 style="margin-top:10px"><?= e($result['reference_no']) ?></h3>
            <p style="margin-bottom:4px"><strong style="color:var(--navy-900)"><?= e($result['customer_name']) ?></strong></p>
            <?php if ($result['destination']): ?><p style="margin-bottom:16px">Destination: <?= e($result['destination']) ?></p><?php endif; ?>

            <span class="status-badge status-<?= e(str_replace(' ', '-', $result['display_status'])) ?>" style="font-size:13px"><?= e($result['display_status']) ?></span>

            <p style="font-size:12.5px;color:var(--muted-soft);margin-top:20px">
                Submitted <?= e(date('d M Y', strtotime($result['created_at']))) ?> &middot; Last updated <?= e(date('d M Y', strtotime($result['updated_at']))) ?>
            </p>
        </div>
        <?php endif; ?>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
