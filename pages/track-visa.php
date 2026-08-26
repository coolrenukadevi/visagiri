<?php
declare(strict_types=1);

/**
 * Public visa application tracking — /track-visa/. Same
 * non-enumerating pattern as /forex/track/: reference number +
 * registered mobile must both match, and a mismatch on either always
 * shows the identical generic "not found" message. Only a
 * customer-safe status label and timeline are shown — never internal
 * notes, assigned consultant, or quote/payment amounts.
 */

$submitted = false;
$application = null;
$errors = [];
$reference = trim((string) ($_POST['reference'] ?? ''));
$mobile = trim((string) ($_POST['mobile'] ?? ''));

$statusLabels = [
    'draft' => 'Draft',
    'documents_pending' => 'Documents Pending',
    'submitted' => 'Submitted',
    'under_review' => 'Under Review',
    'approved' => 'Approved',
    'rejected' => 'Rejected',
    'completed' => 'Completed',
    'cancelled' => 'Cancelled',
];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    if (!rate_limit_check('visa-track:' . ($_SERVER['REMOTE_ADDR'] ?? ''), 10, 900)) {
        $errors[] = 'Too many attempts. Please try again later.';
    } elseif ($reference === '' || $mobile === '') {
        $errors[] = 'Please enter both your Application Reference Number and registered mobile number.';
    } else {
        $submitted = true;
        $stmt = db()->prepare(
            'SELECT va.application_reference_no, va.status, va.travel_date, va.created_at,
                    co.name AS country_name, vt.name AS visa_type_name
             FROM visa_applications va
             JOIN customers c ON c.id = va.customer_id
             JOIN countries co ON co.id = va.country_id
             JOIN visa_types vt ON vt.id = va.visa_type_id
             WHERE va.application_reference_no = :ref AND c.mobile = :mobile AND va.deleted_at IS NULL'
        );
        $stmt->execute(['ref' => $reference, 'mobile' => $mobile]);
        $application = $stmt->fetch() ?: null;
    }
}

if ($application) {
    $docsStmt = db()->prepare(
        "SELECT verification_status FROM documents
         WHERE visa_application_id = (SELECT id FROM visa_applications WHERE application_reference_no = :ref) AND deleted_at IS NULL"
    );
    $docsStmt->execute(['ref' => $reference]);
    $docs = $docsStmt->fetchAll();
    $anyVerified = false;
    foreach ($docs as $d) {
        if ($d['verification_status'] === 'verified') {
            $anyVerified = true;
            break;
        }
    }

    $quoteStmt = db()->prepare(
        "SELECT id FROM visa_quotes WHERE visa_application_id = (SELECT id FROM visa_applications WHERE application_reference_no = :ref) AND status IN ('sent','accepted') LIMIT 1"
    );
    $quoteStmt->execute(['ref' => $reference]);
    $hasQuotation = (bool) $quoteStmt->fetchColumn();

    $paidStmt = db()->prepare(
        "SELECT id FROM visa_payments WHERE visa_application_id = (SELECT id FROM visa_applications WHERE application_reference_no = :ref) AND status = 'received' LIMIT 1"
    );
    $paidStmt->execute(['ref' => $reference]);
    $hasPaid = (bool) $paidStmt->fetchColumn();

    $timeline = [
        ['label' => 'Application Submitted', 'done' => true],
        ['label' => 'Documents Uploaded', 'done' => (bool) $docs],
        ['label' => 'Documents Verified', 'done' => $anyVerified],
        ['label' => 'Quotation Prepared', 'done' => $hasQuotation],
        ['label' => 'Payment Received', 'done' => $hasPaid],
        ['label' => 'Under Review', 'done' => in_array($application['status'], ['under_review', 'approved', 'completed'], true)],
        ['label' => 'Approved', 'done' => in_array($application['status'], ['approved', 'completed'], true)],
        ['label' => 'Completed', 'done' => $application['status'] === 'completed'],
    ];
}

$pageTitle = 'Track Your Visa Application - Visagiri';
$pageDescription = 'Check the status of your visa application with your Application Reference Number.';
$canonicalUrl = APP_URL . '/track-visa/';
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:640px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Track Application</span>
            <h1>Track Your Visa Application</h1>
            <p>Enter your Application Reference Number and registered mobile number to check your application status.</p>
        </div>

        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>

        <div class="card" style="margin-bottom:var(--space-6)">
            <form method="post" action="/track-visa/">
                <?= csrf_field() ?>
                <div class="form-group"><label class="form-label" for="reference">Application Reference Number</label><input class="form-input" type="text" id="reference" name="reference" value="<?= e($reference) ?>" placeholder="VG-VISA-2026-000001" required></div>
                <div class="form-group"><label class="form-label" for="mobile">Registered Mobile Number</label><input class="form-input" type="text" id="mobile" name="mobile" value="<?= e($mobile) ?>" required></div>
                <button type="submit" class="btn btn-primary" style="width:100%">Track Application</button>
            </form>
        </div>

        <?php if ($submitted && $application): ?>
        <div class="card">
            <h2>Application Status</h2>
            <p><strong>Reference:</strong> <?= e($application['application_reference_no']) ?></p>
            <p><strong>Destination:</strong> <?= e($application['country_name']) ?> &mdash; <?= e($application['visa_type_name']) ?></p>
            <p><strong>Status:</strong> <span class="badge badge-info"><?= e($statusLabels[$application['status']] ?? ucfirst($application['status'])) ?></span></p>
            <p><strong>Submitted:</strong> <?= e(date('d M Y', strtotime((string) $application['created_at']))) ?></p>
            <ul class="hrms-timeline" style="margin-top:var(--space-4)">
                <?php foreach ($timeline as $step): ?>
                <li><?= $step['done'] ? '✓' : '○' ?> <?= e($step['label']) ?></li>
                <?php endforeach; ?>
            </ul>
        </div>
        <?php elseif ($submitted): ?>
        <div class="alert alert-danger">We couldn't find a matching visa application. Please check your reference number and registered mobile number, or contact us for assistance.</div>
        <?php endif; ?>

        <p style="margin-top:var(--space-6);text-align:center">
            Need help? <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like help tracking my visa application.")) ?>" target="_blank" rel="noopener noreferrer">WhatsApp us</a>
            or call <a href="tel:<?= e(setting('contact_phone_dial', '+917065819819')) ?>"><?= e(setting('contact_phone_display', '+91 7065 819 819')) ?></a>.
        </p>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
