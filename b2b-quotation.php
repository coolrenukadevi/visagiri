<?php
ob_start();
$PP_PAGE_TITLE = 'Quotation Detail';
$PP_ACTIVE_NAV = 'quotations';
require __DIR__ . '/includes/partner-layout-top.php';
partner_require_permission('view_quotations');

$ref = trim($_GET['ref'] ?? '');
$pid = partner_id();

// Tenant isolation + drafts hidden, same as the list page.
$stmt = $pdo->prepare("SELECT * FROM b2b_quotations WHERE quotation_ref = ? AND partner_id = ? AND status != 'Draft'");
$stmt->execute([$ref, $pid]);
$quotation = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$quotation) {
    http_response_code(404);
    ?>
    <div class="pp-card">Quotation not found.</div>
    <?php
    require __DIR__ . '/includes/partner-layout-bottom.php';
    exit;
}

$actionMessage = '';
$actionError = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $quotation['status'] === 'Sent') {
    b2b_csrf_require_or_403();
    $action = $_POST['action'] ?? '';
    $now = gmdate('c');

    if ($action === 'accept') {
        $pdo->prepare("UPDATE b2b_quotations SET status = 'Accepted' WHERE id = ?")->execute([$quotation['id']]);
        b2b_log_audit($pdo, 'quotation', $quotation['id'], partner_name(), 'Partner (' . partner_role() . ')', 'Quotation accepted by partner');
        b2b_notify($pdo, null, 'b2b_quotation_accepted', "{$quotation['quotation_ref']} was accepted by " . partner_company() . '.', $pid);
        $quotation['status'] = 'Accepted';
        $actionMessage = 'Quotation accepted. Our team will be in touch with next steps.';
    } elseif ($action === 'reject') {
        $reason = trim($_POST['reason'] ?? '');
        if ($reason === '') {
            $actionError = 'Please provide a reason for rejecting this quotation.';
        } else {
            $pdo->prepare("UPDATE b2b_quotations SET status = 'Rejected', revision_note = ? WHERE id = ?")->execute([$reason, $quotation['id']]);
            b2b_log_audit($pdo, 'quotation', $quotation['id'], partner_name(), 'Partner (' . partner_role() . ')', 'Quotation rejected by partner', '', $reason);
            b2b_notify($pdo, null, 'b2b_quotation_rejected', "{$quotation['quotation_ref']} was rejected by " . partner_company() . ": $reason", $pid);
            $quotation['status'] = 'Rejected';
            $quotation['revision_note'] = $reason;
            $actionMessage = 'Quotation rejected.';
        }
    } elseif ($action === 'request_revision') {
        $note = trim($_POST['note'] ?? '');
        if ($note === '') {
            $actionError = 'Please describe what you would like revised.';
        } else {
            $pdo->prepare("UPDATE b2b_quotations SET status = 'Revision Requested', revision_note = ? WHERE id = ?")->execute([$note, $quotation['id']]);
            b2b_log_audit($pdo, 'quotation', $quotation['id'], partner_name(), 'Partner (' . partner_role() . ')', 'Revision requested by partner', '', $note);
            b2b_notify($pdo, null, 'b2b_quotation_revision', "{$quotation['quotation_ref']}: revision requested by " . partner_company() . ": $note", $pid);
            $quotation['status'] = 'Revision Requested';
            $quotation['revision_note'] = $note;
            $actionMessage = 'Revision request sent to our team.';
        }
    }
}
?>
<div class="pp-page-header">
    <div>
        <h1 class="pp-page-title"><?php echo htmlspecialchars($quotation['quotation_ref']); ?></h1>
        <p class="pp-page-subtitle"><?php echo htmlspecialchars($quotation['service_category']); ?> &middot; <span class="pp-status-badge <?php echo b2b_quote_status_class($quotation['status']); ?>"><?php echo htmlspecialchars($quotation['status']); ?></span></p>
    </div>
    <a href="b2b-quotations.php" class="pp-filter-btn is-ghost">&larr; Back to Quotations</a>
</div>

<?php if ($actionMessage): ?><div class="b2b-form-error" style="background:#E7F6EC;color:#16A34A;"><?php echo htmlspecialchars($actionMessage); ?></div><?php endif; ?>
<?php if ($actionError): ?><div class="b2b-form-error"><?php echo htmlspecialchars($actionError); ?></div><?php endif; ?>

<div class="pp-card">
    <h3>Quotation Details</h3>
    <div class="pp-panel-grid">
        <div class="pp-panel-item"><label>Destination</label><div class="val"><?php echo htmlspecialchars($quotation['country']); ?></div></div>
        <div class="pp-panel-item"><label>Visa Type</label><div class="val"><?php echo htmlspecialchars($quotation['visa_type']); ?></div></div>
        <div class="pp-panel-item"><label>Applicants</label><div class="val"><?php echo (int) $quotation['applicants_count']; ?></div></div>
        <div class="pp-panel-item"><label>Valid Until</label><div class="val"><?php echo $quotation['valid_until'] ? htmlspecialchars(substr($quotation['valid_until'], 0, 10)) : '—'; ?></div></div>
    </div>
</div>

<div class="pp-card">
    <h3>Fee Breakdown</h3>
    <div class="pp-panel-grid">
        <div class="pp-panel-item"><label>Visa Fee</label><div class="val">&#8377;<?php echo number_format((float) $quotation['visa_fee'], 2); ?></div></div>
        <div class="pp-panel-item"><label>Service Fee</label><div class="val">&#8377;<?php echo number_format((float) $quotation['service_fee'], 2); ?></div></div>
        <div class="pp-panel-item"><label>Embassy Fee</label><div class="val">&#8377;<?php echo number_format((float) $quotation['embassy_fee'], 2); ?></div></div>
        <div class="pp-panel-item"><label>Appointment Fee</label><div class="val">&#8377;<?php echo number_format((float) $quotation['appointment_fee'], 2); ?></div></div>
        <div class="pp-panel-item"><label>Courier Fee</label><div class="val">&#8377;<?php echo number_format((float) $quotation['courier_fee'], 2); ?></div></div>
        <div class="pp-panel-item"><label>Other Charges</label><div class="val">&#8377;<?php echo number_format((float) $quotation['other_charges'], 2); ?></div></div>
        <div class="pp-panel-item"><label>Discount</label><div class="val">-&#8377;<?php echo number_format((float) $quotation['discount'], 2); ?></div></div>
        <div class="pp-panel-item"><label>GST</label><div class="val">&#8377;<?php echo number_format((float) $quotation['gst'], 2); ?></div></div>
    </div>
    <div class="pp-quote-total">Total Payable: &#8377;<?php echo number_format((float) $quotation['total'], 2); ?></div>
    <a href="b2b-quotation-pdf.php?ref=<?php echo urlencode($quotation['quotation_ref']); ?>" target="_blank" class="pp-filter-btn is-ghost" style="margin-top:14px;display:inline-flex;"><i class="fa-solid fa-file-pdf"></i>&nbsp; Download PDF</a>
</div>

<?php if ($quotation['revision_note']): ?>
<div class="pp-card">
    <h3>Your Note</h3>
    <p class="pp-empty-note"><?php echo htmlspecialchars($quotation['revision_note']); ?></p>
</div>
<?php endif; ?>

<?php if ($quotation['status'] === 'Sent'): ?>
<div class="pp-card">
    <h3>Respond to this Quotation</h3>
    <div style="display:flex;gap:12px;flex-wrap:wrap;">
        <form method="post">
            <input type="hidden" name="action" value="accept">
            <button type="submit" class="b2b-submit-btn" style="width:auto;padding:12px 26px;">Accept Quotation</button>
        </form>
    </div>
    <div class="pp-quote-response-grid">
        <form method="post" class="pp-quote-response-form">
            <input type="hidden" name="action" value="request_revision">
            <label>Request a Revision</label>
            <textarea name="note" rows="3" placeholder="Describe what you'd like changed..." required></textarea>
            <button type="submit" class="pp-filter-btn is-ghost">Send Revision Request</button>
        </form>
        <form method="post" class="pp-quote-response-form">
            <input type="hidden" name="action" value="reject">
            <label>Reject Quotation</label>
            <textarea name="reason" rows="3" placeholder="Reason for rejecting..." required></textarea>
            <button type="submit" class="pp-filter-btn is-ghost" style="color:#C0392B;border-color:#C0392B;">Reject</button>
        </form>
    </div>
</div>
<?php endif; ?>

<?php require __DIR__ . '/includes/partner-layout-bottom.php'; ?>
