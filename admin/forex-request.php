<?php
ob_start();
$ADMIN_PAGE_TITLE = 'Forex Request';
$ADMIN_ACTIVE_NAV = 'forex-all';
require __DIR__ . '/includes/layout-top.php';

$ref = trim($_GET['ref'] ?? '');
$stmt = $pdo->prepare('SELECT * FROM forex_requests WHERE forex_ref = ?');
$stmt->execute([$ref]);
$request = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$request) {
    http_response_code(404);
    echo '<div class="crm-card">Forex request not found.</div>';
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}
$requestId = (int) $request['id'];
$ADMIN_BREADCRUMB = ['CRM', 'Forex', $request['forex_ref']];

$statusMessage = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';
    if ($action === 'change_status' && forex_can_verify_documents()) {
        $newStatus = trim($_POST['status'] ?? '');
        if (in_array($newStatus, FOREX_STATUSES, true) && $newStatus !== $request['status']) {
            $pdo->prepare('UPDATE forex_requests SET status = ?, updated_at = ? WHERE id = ?')
                ->execute([$newStatus, gmdate('c'), $requestId]);
            forex_log_status_change($pdo, $requestId, $request['status'], $newStatus, admin_name(), trim($_POST['message'] ?? ''));
            forex_log_audit($pdo, $requestId, admin_name(), admin_role(), 'Changed status', $request['status'], $newStatus);
            $request['status'] = $newStatus;
        }
    }
}

$docsStmt = $pdo->prepare('SELECT * FROM forex_documents WHERE forex_request_id = ? ORDER BY doc_type, id DESC');
$docsStmt->execute([$requestId]);
$allDocRows = $docsStmt->fetchAll(PDO::FETCH_ASSOC);
$documents = [];
foreach ($allDocRows as $d) {
    if (!isset($documents[$d['doc_type']])) {
        $documents[$d['doc_type']] = $d; // first hit per type = highest id = current version
    }
}
$totalDocs = count($documents);
$verifiedDocs = count(array_filter($documents, function ($d) { return $d['status'] === 'Verified'; }));

$declStmt = $pdo->prepare('SELECT * FROM forex_declarations WHERE forex_request_id = ? ORDER BY id DESC LIMIT 1');
$declStmt->execute([$requestId]);
$declaration = $declStmt->fetch(PDO::FETCH_ASSOC);

$historyStmt = $pdo->prepare('SELECT * FROM forex_status_history WHERE forex_request_id = ? ORDER BY id DESC');
$historyStmt->execute([$requestId]);
$history = $historyStmt->fetchAll(PDO::FETCH_ASSOC);

$auditStmt = $pdo->prepare('SELECT * FROM forex_audit_logs WHERE forex_request_id = ? ORDER BY id DESC LIMIT 20');
$auditStmt->execute([$requestId]);
$auditLog = $auditStmt->fetchAll(PDO::FETCH_ASSOC);

function fx_fmt($v) { $v = trim((string) $v); return $v === '' ? '<span style="color:var(--c-muted);">—</span>' : htmlspecialchars($v); }
?>
<a href="forex-requests.php" style="font-size:12.5px;color:var(--c-text);display:inline-block;margin-bottom:14px;">&larr; Back to all forex requests</a>

<div class="crm-detail-header">
    <div class="ref"><?php echo htmlspecialchars($request['forex_ref']); ?></div>
    <h1><?php echo htmlspecialchars($request['full_name']); ?></h1>
    <div class="sub"><?php echo htmlspecialchars($request['country_visit']); ?> &middot; <?php echo htmlspecialchars($request['currency_code']); ?> <?php echo number_format((float) $request['amount_required'], 2); ?></div>
    <div class="crm-detail-badges">
        <span class="crm-status-badge <?php echo forex_status_class($request['status']); ?>" style="background:rgba(255,255,255,0.15);color:#fff;"><?php echo htmlspecialchars($request['status']); ?></span>
        <span class="crm-status-badge" style="background:rgba(255,255,255,0.15);color:#fff;"><?php echo htmlspecialchars($request['visa_status']); ?></span>
        <?php if ($request['assigned_to']): ?><span class="crm-status-badge" style="background:rgba(255,255,255,0.15);color:#fff;">Assigned: <?php echo htmlspecialchars($request['assigned_to']); ?></span><?php endif; ?>
    </div>
    <div class="crm-quick-actions">
        <a class="crm-btn" href="tel:<?php echo htmlspecialchars($request['mobile']); ?>"><i class="fa-solid fa-phone"></i> Call</a>
        <a class="crm-btn" href="https://wa.me/<?php echo preg_replace('/\D/', '', $request['mobile']); ?>" target="_blank" rel="noopener"><i class="fa-brands fa-whatsapp"></i> WhatsApp</a>
        <?php if ($request['email']): ?><a class="crm-btn" href="mailto:<?php echo htmlspecialchars($request['email']); ?>"><i class="fa-solid fa-envelope"></i> Email</a><?php endif; ?>
        <a class="crm-btn" href="#status"><i class="fa-solid fa-pen"></i> Change Status</a>
        <a class="crm-btn" href="#documents"><i class="fa-solid fa-upload"></i> Documents</a>
    </div>
</div>

<div class="crm-card">
    <h3>Document Completion: <?php echo $verifiedDocs; ?>/<?php echo $totalDocs; ?></h3>
    <div class="forex-progress-bar" style="max-width:100%;margin-bottom:16px;"><div class="forex-progress-bar-fill" style="width:<?php echo $totalDocs ? round(($verifiedDocs / $totalDocs) * 100) : 0; ?>%;"></div></div>
    <div class="forex-doc-checklist" id="documents">
        <?php foreach ($documents as $docType => $d):
            $statusClass = forex_doc_status_class($d['status']);
            $icon = $d['status'] === 'Verified' ? 'circle-check' : ($d['status'] === 'Rejected' ? 'circle-xmark' : ($d['status'] === 'Not Uploaded' ? 'circle' : 'clock'));
        ?>
        <div class="forex-doc-row <?php echo $statusClass; ?>">
            <div class="forex-doc-row-label"><i class="fa-solid fa-<?php echo $icon; ?> forex-doc-row-icon"></i> <?php echo htmlspecialchars(FOREX_DOC_TYPES[$docType]); ?></div>
            <div style="display:flex;align-items:center;gap:10px;flex-wrap:wrap;">
                <span class="crm-status-badge forex-doc-status <?php echo $statusClass; ?>"><?php echo htmlspecialchars($d['status']); ?></span>
                <?php if ($d['stored_filename']): ?><a href="forex-document.php?id=<?php echo (int) $d['id']; ?>" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-download"></i></a><?php endif; ?>
                <?php if ($docType !== 'Declaration'): ?>
                <form method="post" action="forex-document-upload.php" enctype="multipart/form-data" style="display:flex;gap:6px;align-items:center;">
                    <input type="hidden" name="forex_request_id" value="<?php echo $requestId; ?>">
                    <input type="hidden" name="doc_type" value="<?php echo htmlspecialchars($docType); ?>">
                    <input type="file" name="document" accept=".pdf,.jpg,.jpeg,.png" required style="font-size:11.5px;max-width:150px;">
                    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm"><?php echo $d['stored_filename'] ? 'Replace' : 'Upload'; ?></button>
                </form>
                <?php endif; ?>
                <?php if (in_array($d['status'], ['Uploaded', 'Under Verification'], true) && forex_can_verify_documents()): ?>
                <form method="post" action="forex-documents.php" style="display:flex;gap:4px;align-items:center;">
                    <input type="hidden" name="action" value="verify">
                    <input type="hidden" name="doc_id" value="<?php echo (int) $d['id']; ?>">
                    <input type="hidden" name="return_url" value="forex-request.php?ref=<?php echo urlencode($request['forex_ref']); ?>">
                    <input type="text" name="remarks" placeholder="Remarks..." style="font-size:11.5px;padding:5px 8px;border:1px solid var(--c-border);border-radius:6px;width:120px;">
                    <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Verify</button>
                </form>
                <form method="post" action="forex-documents.php" style="display:flex;gap:4px;align-items:center;">
                    <input type="hidden" name="action" value="reject">
                    <input type="hidden" name="doc_id" value="<?php echo (int) $d['id']; ?>">
                    <input type="hidden" name="return_url" value="forex-request.php?ref=<?php echo urlencode($request['forex_ref']); ?>">
                    <input type="text" name="reason" placeholder="Reason..." required style="font-size:11.5px;padding:5px 8px;border:1px solid var(--c-border);border-radius:6px;width:120px;">
                    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm" style="color:var(--c-red);">Reject</button>
                </form>
                <?php endif; ?>
            </div>
        </div>
        <?php if ($d['rejection_reason']): ?><p style="font-size:11.5px;color:var(--c-red);margin:-4px 0 0;">Rejected: <?php echo htmlspecialchars($d['rejection_reason']); ?></p><?php endif; ?>
        <?php if ($d['verification_remarks']): ?><p style="font-size:11.5px;color:var(--c-green);margin:-4px 0 0;">Remarks: <?php echo htmlspecialchars($d['verification_remarks']); ?></p><?php endif; ?>
        <?php endforeach; ?>
        <?php if (!$documents): ?><div class="crm-empty">No document checklist yet.</div><?php endif; ?>
    </div>
    <p class="visa-info-note" style="font-size:12px;color:var(--c-muted);">PDF, JPG or PNG, max 5MB. Documents are only marked complete once staff verify them (Phase 4).</p>
</div>

<?php if ($declaration): ?>
<div class="crm-card" id="declaration">
    <h3><i class="fa-solid fa-file-signature"></i> Visa on Arrival / Visa-Free Declaration</h3>
    <div class="compliance-note" style="margin-bottom:14px;">
        Visa Not Applicable — Customer Declaration Required. The customer must read, hand-sign and upload this declaration. A typed name does not satisfy this requirement.
    </div>
    <div class="crm-panel-grid" style="margin-bottom:16px;">
        <div class="crm-panel-item"><label>Customer Name</label><div class="val"><?php echo fx_fmt($declaration['customer_name']); ?></div></div>
        <div class="crm-panel-item"><label>Passport Number</label><div class="val"><?php echo fx_fmt($declaration['passport_number']); ?></div></div>
        <div class="crm-panel-item"><label>Destination</label><div class="val"><?php echo fx_fmt($declaration['destination_country']); ?></div></div>
        <div class="crm-panel-item"><label>Declaration Date</label><div class="val"><?php echo fx_fmt($declaration['declaration_date']); ?></div></div>
        <div class="crm-panel-item"><label>Signed Copy</label><div class="val"><?php echo $declaration['stored_filename'] ? '<span style="color:var(--c-green);">Uploaded</span>' : '<span style="color:var(--c-red);">Not yet uploaded</span>'; ?></div></div>
        <div class="crm-panel-item"><label>Verified</label><div class="val"><?php echo $declaration['verified_at'] ? fx_fmt($declaration['verified_by'] . ' — ' . substr($declaration['verified_at'], 0, 10)) : '<span style="color:var(--c-amber);">Pending</span>'; ?></div></div>
    </div>
    <div style="display:flex;gap:10px;flex-wrap:wrap;">
        <a href="forex-declaration-print.php?ref=<?php echo urlencode($request['forex_ref']); ?>" target="_blank" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-print"></i> Print / Download for Signature</a>
        <?php if (isset($documents['Declaration']) && $documents['Declaration']['stored_filename']): ?>
        <a href="forex-document.php?id=<?php echo (int) $documents['Declaration']['id']; ?>" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-download"></i> Download Signed Copy</a>
        <?php endif; ?>
    </div>
    <form method="post" action="forex-document-upload.php" enctype="multipart/form-data" style="display:flex;gap:10px;align-items:center;margin-top:14px;">
        <input type="hidden" name="forex_request_id" value="<?php echo $requestId; ?>">
        <input type="hidden" name="doc_type" value="Declaration">
        <input type="file" name="document" accept=".pdf,.jpg,.jpeg,.png" required>
        <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Upload Signed Declaration</button>
    </form>
</div>
<?php endif; ?>

<div class="crm-two-col">
    <div class="crm-card">
        <h3>Customer Information</h3>
        <div class="crm-panel-grid">
            <div class="crm-panel-item"><label>Full Name</label><div class="val"><?php echo fx_fmt($request['full_name']); ?></div></div>
            <div class="crm-panel-item"><label>Date of Birth</label><div class="val"><?php echo fx_fmt($request['date_of_birth']); ?></div></div>
            <div class="crm-panel-item"><label>Mobile</label><div class="val"><?php echo fx_fmt($request['mobile']); ?></div></div>
            <div class="crm-panel-item"><label>Email</label><div class="val"><?php echo fx_fmt($request['email']); ?></div></div>
            <div class="crm-panel-item"><label>Address</label><div class="val"><?php echo fx_fmt($request['address']); ?></div></div>
            <div class="crm-panel-item"><label>City</label><div class="val"><?php echo fx_fmt($request['city']); ?></div></div>
            <div class="crm-panel-item"><label>State</label><div class="val"><?php echo fx_fmt($request['state']); ?></div></div>
            <div class="crm-panel-item"><label>PIN Code</label><div class="val"><?php echo fx_fmt($request['pin_code']); ?></div></div>
            <div class="crm-panel-item"><label>Nationality</label><div class="val"><?php echo fx_fmt($request['nationality']); ?></div></div>
            <div class="crm-panel-item"><label>PAN Number</label><div class="val"><?php echo fx_fmt($request['pan_number']); ?></div></div>
            <div class="crm-panel-item"><label>Passport Number</label><div class="val"><?php echo fx_fmt($request['passport_number']); ?></div></div>
            <div class="crm-panel-item"><label>Passport Expiry</label><div class="val"><?php echo fx_fmt($request['passport_expiry']); ?></div></div>
        </div>
    </div>
    <div class="crm-card">
        <h3>Travel Details</h3>
        <div class="crm-panel-grid">
            <div class="crm-panel-item"><label>Country of Visit</label><div class="val"><?php echo fx_fmt($request['country_visit']); ?></div></div>
            <div class="crm-panel-item"><label>Cities to Visit</label><div class="val"><?php echo fx_fmt($request['cities_visit']); ?></div></div>
            <div class="crm-panel-item"><label>Purpose</label><div class="val"><?php echo fx_fmt($request['purpose']); ?></div></div>
            <div class="crm-panel-item"><label>Traveller Type</label><div class="val"><?php echo fx_fmt($request['traveller_type']); ?></div></div>
            <div class="crm-panel-item"><label>Departure Date</label><div class="val"><?php echo fx_fmt($request['departure_date']); ?></div></div>
            <div class="crm-panel-item"><label>Return Date</label><div class="val"><?php echo fx_fmt($request['return_date']); ?></div></div>
            <div class="crm-panel-item"><label>Duration</label><div class="val"><?php echo fx_fmt($request['duration_of_stay']); ?></div></div>
            <div class="crm-panel-item"><label>Airline</label><div class="val"><?php echo fx_fmt($request['airline']); ?></div></div>
            <div class="crm-panel-item"><label>Flight Number</label><div class="val"><?php echo fx_fmt($request['flight_number']); ?></div></div>
            <div class="crm-panel-item"><label>Hotel</label><div class="val"><?php echo fx_fmt($request['hotel_name']); ?></div></div>
        </div>
    </div>
</div>

<div class="crm-card">
    <h3>Forex Requirement</h3>
    <div class="crm-panel-grid">
        <div class="crm-panel-item"><label>Currency</label><div class="val"><?php echo fx_fmt($request['currency_code']); ?></div></div>
        <div class="crm-panel-item"><label>Amount Required</label><div class="val"><?php echo fx_fmt(number_format((float) $request['amount_required'], 2)); ?></div></div>
        <div class="crm-panel-item"><label>Approx. INR</label><div class="val"><?php echo $request['approx_inr'] ? fx_fmt('₹' . number_format((float) $request['approx_inr'], 2)) : fx_fmt(''); ?></div></div>
        <div class="crm-panel-item"><label>Preferred Date</label><div class="val"><?php echo fx_fmt($request['preferred_delivery_date']); ?></div></div>
        <div class="crm-panel-item"><label>Collection Location</label><div class="val"><?php echo fx_fmt($request['collection_location']); ?></div></div>
        <div class="crm-panel-item"><label>Delivery Method</label><div class="val"><?php echo fx_fmt($request['delivery_method']); ?></div></div>
    </div>
</div>

<div class="crm-card" id="status">
    <h3>Change Status</h3>
    <?php if (forex_can_verify_documents()): ?>
    <form method="post" style="display:flex;gap:10px;flex-wrap:wrap;align-items:flex-end;">
        <input type="hidden" name="action" value="change_status">
        <div class="crm-form-field" style="margin:0;min-width:220px;">
            <label>New Status</label>
            <select name="status">
                <?php foreach (FOREX_STATUSES as $s): ?><option value="<?php echo htmlspecialchars($s); ?>" <?php echo $s === $request['status'] ? 'selected' : ''; ?>><?php echo htmlspecialchars($s); ?></option><?php endforeach; ?>
            </select>
        </div>
        <div class="crm-form-field" style="margin:0;flex:1;min-width:220px;">
            <label>Note (optional)</label>
            <input type="text" name="message" placeholder="Reason for the change...">
        </div>
        <button type="submit" class="crm-btn crm-btn-primary">Update Status</button>
    </form>
    <?php else: ?>
    <p class="crm-empty">You don't have permission to change this request's status.</p>
    <?php endif; ?>
</div>

<div class="crm-two-col">
    <div class="crm-card">
        <h3>Status History</h3>
        <div class="crm-timeline">
            <?php foreach ($history as $h): ?>
            <div class="crm-timeline-item">
                <div class="crm-timeline-dot"></div>
                <div class="crm-timeline-action"><?php echo htmlspecialchars($h['previous_status'] ? $h['previous_status'] . ' → ' . $h['new_status'] : $h['new_status']); ?></div>
                <?php if ($h['message']): ?><div class="crm-timeline-notes"><?php echo htmlspecialchars($h['message']); ?></div><?php endif; ?>
                <div class="crm-timeline-meta"><?php echo htmlspecialchars($h['changed_by']); ?> &middot; <?php echo htmlspecialchars(substr($h['created_at'], 0, 16)); ?></div>
            </div>
            <?php endforeach; ?>
            <?php if (!$history): ?><div class="crm-empty">No status changes yet.</div><?php endif; ?>
        </div>
    </div>
    <div class="crm-card">
        <h3>Audit Log</h3>
        <div class="crm-timeline">
            <?php foreach ($auditLog as $a): ?>
            <div class="crm-timeline-item">
                <div class="crm-timeline-dot"></div>
                <div class="crm-timeline-action"><?php echo htmlspecialchars($a['action']); ?></div>
                <?php if ($a['new_value']): ?><div class="crm-timeline-notes"><?php echo htmlspecialchars($a['new_value']); ?></div><?php endif; ?>
                <div class="crm-timeline-meta"><?php echo htmlspecialchars($a['user_name']); ?> &middot; <?php echo htmlspecialchars(substr($a['created_at'], 0, 16)); ?></div>
            </div>
            <?php endforeach; ?>
            <?php if (!$auditLog): ?><div class="crm-empty">No audit entries yet.</div><?php endif; ?>
        </div>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
