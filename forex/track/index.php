<?php
declare(strict_types=1);

/**
 * Public forex request tracking — /forex/track/. Reference number +
 * registered mobile must both match (the same non-enumerating pattern
 * used by this project's other public lookups): a mismatch on either
 * half always shows the same generic "not found" message, so a
 * visitor can't probe which reference numbers are real. Only a
 * customer-safe status label and timeline are shown — never internal
 * remarks, rates, charges, or staff notes.
 */

$submitted = false;
$request = null;
$errors = [];
$reference = trim((string) ($_POST['reference'] ?? ''));
$mobile = trim((string) ($_POST['mobile'] ?? ''));

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    if (!rate_limit_check('forex-track:' . ($_SERVER['REMOTE_ADDR'] ?? ''), 10, 900)) {
        $errors[] = 'Too many attempts. Please try again later.';
    } elseif ($reference === '' || $mobile === '') {
        $errors[] = 'Please enter both your Forex Reference Number and registered mobile number.';
    } else {
        $submitted = true;
        $stmt = db()->prepare(
            'SELECT fr.forex_reference_no, fr.status, fr.currency_code, fr.amount_required, fr.created_at
             FROM forex_requests fr JOIN customers c ON c.id = fr.customer_id
             WHERE fr.forex_reference_no = :ref AND c.mobile = :mobile AND fr.deleted_at IS NULL'
        );
        $stmt->execute(['ref' => $reference, 'mobile' => $mobile]);
        $request = $stmt->fetch() ?: null;
    }
}

if ($request) {
    $docsStmt = db()->prepare("SELECT document_type, verification_status FROM forex_documents WHERE forex_request_id = (SELECT id FROM forex_requests WHERE forex_reference_no = :ref) AND is_current = 1");
    $docsStmt->execute(['ref' => $reference]);
    $docStatuses = $docsStmt->fetchAll();
    $anyVerified = false;
    foreach ($docStatuses as $d) {
        if ($d['verification_status'] === 'verified') {
            $anyVerified = true;
            break;
        }
    }

    $quoteStmt = db()->prepare("SELECT id FROM forex_quotations WHERE forex_request_id = (SELECT id FROM forex_requests WHERE forex_reference_no = :ref) AND status IN ('sent','accepted') LIMIT 1");
    $quoteStmt->execute(['ref' => $reference]);
    $hasQuotation = (bool) $quoteStmt->fetchColumn();

    $paidStmt = db()->prepare("SELECT id FROM forex_payments WHERE forex_request_id = (SELECT id FROM forex_requests WHERE forex_reference_no = :ref) AND status = 'paid' LIMIT 1");
    $paidStmt->execute(['ref' => $reference]);
    $hasPaid = (bool) $paidStmt->fetchColumn();

    $timeline = [
        ['label' => 'Request Submitted', 'done' => true],
        ['label' => 'Documents Uploaded', 'done' => (bool) $docStatuses],
        ['label' => 'Documents Verified', 'done' => $anyVerified],
        ['label' => 'Forex Quotation Prepared', 'done' => $hasQuotation],
        ['label' => 'Payment', 'done' => $hasPaid],
        ['label' => 'Approval', 'done' => in_array($request['status'], ['approved_for_processing', 'forex_processing', 'ready_for_delivery', 'delivered'], true)],
        ['label' => 'Forex Ready', 'done' => in_array($request['status'], ['ready_for_delivery', 'delivered'], true)],
        ['label' => 'Delivered', 'done' => $request['status'] === 'delivered'],
    ];
}

$pageTitle = 'Track Your Forex Request - Visagiri';
$pageDescription = 'Check the status of your foreign currency purchase request with your Forex Reference Number.';
$canonicalUrl = APP_URL . '/forex/track/';
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:640px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Forex</span>
            <h1>Track Forex Request</h1>
            <p>Enter your Forex Reference Number and registered mobile number to check your request status.</p>
        </div>

        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>

        <div class="card" style="margin-bottom:var(--space-6)">
            <form method="post" action="/forex/track/">
                <?= csrf_field() ?>
                <div class="form-group"><label class="form-label" for="reference">Forex Reference Number</label><input class="form-input" type="text" id="reference" name="reference" value="<?= e($reference) ?>" placeholder="VG-FX-2026-000001" required></div>
                <div class="form-group"><label class="form-label" for="mobile">Registered Mobile Number</label><input class="form-input" type="text" id="mobile" name="mobile" value="<?= e($mobile) ?>" required></div>
                <button type="submit" class="btn btn-primary" style="width:100%">Track Request</button>
            </form>
        </div>

        <?php if ($submitted && $request): ?>
        <div class="card">
            <h2>Forex Request Status</h2>
            <p><strong>Reference:</strong> <?= e($request['forex_reference_no']) ?></p>
            <p><strong>Status:</strong> <span class="badge badge-info"><?= e(forex_customer_status_label($request['status'])) ?></span></p>
            <p><strong>Currency:</strong> <?= e($request['currency_code']) ?> <?= e(number_format((float) $request['amount_required'], 2)) ?></p>
            <p><strong>Submitted:</strong> <?= e(date('d M Y', strtotime((string) $request['created_at']))) ?></p>
            <ul class="hrms-timeline" style="margin-top:var(--space-4)">
                <?php foreach ($timeline as $step): ?>
                <li><?= $step['done'] ? '✓' : '○' ?> <?= e($step['label']) ?></li>
                <?php endforeach; ?>
            </ul>
        </div>
        <?php elseif ($submitted): ?>
        <div class="alert alert-danger">We couldn't find a matching forex request. Please check your reference number and registered mobile number, or contact us for assistance.</div>
        <?php endif; ?>

        <p style="margin-top:var(--space-6);text-align:center">
            Need help? <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like help tracking my forex request.")) ?>" target="_blank" rel="noopener noreferrer">WhatsApp us</a>
            or call <a href="tel:<?= e(setting('contact_phone_dial', '+917065819819')) ?>"><?= e(setting('contact_phone_display', '+91 7065 819 819')) ?></a>.
        </p>
    </div>
</section>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
