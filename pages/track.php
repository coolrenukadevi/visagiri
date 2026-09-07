<?php
declare(strict_types=1);

/**
 * Public enquiry tracking — /track/, for the unified Visa + Apostille
 * enquiry system (includes/enquiry.php). Same two-factor, non-
 * enumerating pattern as pages/track-visa.php: enquiry/tracking
 * number plus the registered mobile or email must both match in one
 * query, and any mismatch shows the identical generic message. Only
 * the customer-safe status label is shown (ENQUIRY_STATUS_MAP) —
 * never internal notes, assigned consultant, or document review
 * remarks.
 */

require_once __DIR__ . '/../includes/enquiry.php';

$noindex = true;

$submitted = false;
$enquiry = null;
$errors = [];
$reference = trim((string) ($_POST['reference'] ?? $_GET['ref'] ?? ''));
$contact = trim((string) ($_POST['contact'] ?? ''));

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    if (!rate_limit_check('enquiry-track:' . ($_SERVER['REMOTE_ADDR'] ?? ''), 10, 900)) {
        $errors[] = 'Too many attempts. Please try again later.';
    } elseif ($reference === '' || $contact === '') {
        $errors[] = 'Please enter your Enquiry/Tracking Number and your registered mobile number or email.';
    } else {
        $submitted = true;
        $stmt = db()->prepare(
            'SELECT * FROM enquiries
             WHERE (enquiry_number = :ref1 OR tracking_token = :ref2)
               AND (mobile_normalized = :contact1 OR email = :contact2 OR mobile_number = :contact3)
               AND deleted_at IS NULL'
        );
        $stmt->execute([
            'ref1' => $reference, 'ref2' => $reference,
            'contact1' => $contact, 'contact2' => $contact, 'contact3' => $contact,
        ]);
        $enquiry = $stmt->fetch() ?: null;
    }
}

if ($enquiry) {
    $docsStmt = db()->prepare('SELECT document_category, review_status FROM enquiry_documents WHERE enquiry_id = :id');
    $docsStmt->execute(['id' => $enquiry['id']]);
    $documents = $docsStmt->fetchAll();

    $historyStmt = db()->prepare('SELECT new_status, created_at FROM enquiry_status_history WHERE enquiry_id = :id ORDER BY created_at ASC');
    $historyStmt->execute(['id' => $enquiry['id']]);
    $history = $historyStmt->fetchAll();
}

$pageTitle = 'Track Your Enquiry - Visagiri';
$pageDescription = 'Check the status of your Visa or Apostille enquiry with your Enquiry/Tracking Number.';
$canonicalUrl = APP_URL . '/track/';
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:640px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Track Enquiry</span>
            <h1>Track Your Enquiry</h1>
            <p>Enter your Enquiry Number or Tracking Number, and your registered mobile number or email, to check your status.</p>
        </div>

        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>

        <div class="card" style="margin-bottom:var(--space-6)">
            <form method="post" action="/track/">
                <?= csrf_field() ?>
                <div class="form-group"><label class="form-label" for="reference">Enquiry Number or Tracking Number</label><input class="form-input" type="text" id="reference" name="reference" value="<?= e($reference) ?>" placeholder="VG-ENQ-2026-000001 or VGTRK-XXXXXXXX" required></div>
                <div class="form-group"><label class="form-label" for="contact">Registered Mobile Number or Email</label><input class="form-input" type="text" id="contact" name="contact" value="<?= e($contact) ?>" required></div>
                <button type="submit" class="btn btn-primary" style="width:100%">Track Enquiry</button>
            </form>
        </div>

        <?php if ($submitted && $enquiry): ?>
        <div class="card">
            <h2>Enquiry Status</h2>
            <p><strong>Enquiry No.:</strong> <?= e($enquiry['enquiry_number']) ?></p>
            <p><strong>Tracking No.:</strong> <?= e($enquiry['tracking_token']) ?></p>
            <p><strong>Service:</strong> <?= $enquiry['service_category'] === 'visa' ? 'Visa Enquiry' : 'Apostille / Document Legalisation' ?></p>
            <p><strong>Status:</strong> <span class="badge badge-info"><?= e(enquiry_customer_status_label($enquiry['status'])) ?></span></p>
            <p><strong>Submitted:</strong> <?= e(date('d M Y', strtotime((string) $enquiry['created_at']))) ?></p>

            <?php if ($documents): ?>
            <h3 style="margin-top:var(--space-5)">Documents</h3>
            <ul class="hrms-timeline">
                <?php foreach ($documents as $doc): ?>
                <li><?= $doc['review_status'] === 'verified' ? '✓' : '○' ?> <?= e(ENQUIRY_DOCUMENT_CATEGORIES[$doc['document_category']] ?? $doc['document_category']) ?> — <?= e(ucwords(str_replace('_', ' ', $doc['review_status']))) ?></li>
                <?php endforeach; ?>
            </ul>
            <?php endif; ?>

            <div class="button-group" style="margin-top:var(--space-5)">
                <a href="/enquire/pdf/?ref=<?= e(urlencode($enquiry['enquiry_number'])) ?>&amp;token=<?= e(urlencode($enquiry['tracking_token'])) ?>" class="btn btn-outline">Download Enquiry PDF</a>
            </div>
        </div>
        <?php elseif ($submitted): ?>
        <div class="alert alert-danger">We couldn't find a matching enquiry. Please check your enquiry/tracking number and registered mobile number or email, or contact us for assistance.</div>
        <?php endif; ?>

        <p style="margin-top:var(--space-6);text-align:center">
            Need help? <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like help tracking my enquiry.")) ?>" target="_blank" rel="noopener noreferrer">WhatsApp us</a>
            or call <a href="tel:<?= e(setting('contact_phone_dial', '+917065819819')) ?>"><?= e(setting('contact_phone_display', '+91 7065 819 819')) ?></a>.
        </p>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
