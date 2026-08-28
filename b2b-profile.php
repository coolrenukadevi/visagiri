<?php
ob_start();
$PP_PAGE_TITLE = 'Company Profile';
$PP_ACTIVE_NAV = 'profile';
require __DIR__ . '/includes/partner-layout-top.php';

$pid = partner_id();
$pStmt = $pdo->prepare('SELECT * FROM b2b_partners WHERE id = ?');
$pStmt->execute([$pid]);
$partner = $pStmt->fetch(PDO::FETCH_ASSOC);

$docsStmt = $pdo->prepare("SELECT * FROM b2b_partner_documents d WHERE partner_id = ? AND deleted_at IS NULL AND stored_filename IS NOT NULL AND id = (
    SELECT MAX(id) FROM b2b_partner_documents WHERE partner_id = ? AND doc_type = d.doc_type AND deleted_at IS NULL
) ORDER BY doc_type");
$docsStmt->execute([$pid, $pid]);
$myDocuments = $docsStmt->fetchAll(PDO::FETCH_ASSOC);

$actionMessage = '';
$actionError = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    b2b_csrf_require_or_403();
    $action = $_POST['action'] ?? '';

    if ($action === 'submit_correction') {
        $fieldType = trim($_POST['field_type'] ?? '');
        $newValue = trim($_POST['new_value'] ?? '');
        $reason = trim($_POST['reason'] ?? '');
        $targetDocId = (int) ($_POST['target_document_id'] ?? 0) ?: null;

        if (!array_key_exists($fieldType, B2B_CORRECTION_FIELD_TYPES) || $newValue === '') {
            $actionError = 'Please choose a field and enter the corrected value.';
        } else {
            $oldValue = '';
            if ($fieldType === 'company_name') {
                $oldValue = $partner['company_name'];
            } elseif ($fieldType === 'contact_name') {
                $oldValue = $partner['contact_name'];
            } elseif ($fieldType === 'document_name') {
                $docMatch = null;
                foreach ($myDocuments as $d) { if ((int) $d['id'] === $targetDocId) { $docMatch = $d; break; } }
                if (!$docMatch) {
                    $actionError = 'Please choose which document needs the name correction.';
                } else {
                    $oldValue = $docMatch['original_filename'];
                }
            }

            if ($actionError === '') {
                $pdo->prepare('INSERT INTO b2b_correction_requests (partner_id, field_type, target_document_id, old_value, new_value, reason, status, requested_by, requested_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)')
                    ->execute([$pid, $fieldType, $fieldType === 'document_name' ? $targetDocId : null, $oldValue, $newValue, $reason ?: null, 'Pending', partner_name(), gmdate('c')]);
                $requestId = (int) $pdo->lastInsertId();

                b2b_log_audit($pdo, 'partner', $pid, partner_name(), 'Partner (' . partner_role() . ')', 'Submitted correction request', $oldValue, $newValue);
                b2b_notify($pdo, null, 'b2b_correction_requested', "{$partner['company_name']} requested a correction: " . B2B_CORRECTION_FIELD_TYPES[$fieldType] . " \"$oldValue\" -> \"$newValue\".", $pid);
                $actionMessage = 'Your correction request has been submitted for review. You\'ll be notified once our team responds.';
            }
        }
    }
}

$myRequestsStmt = $pdo->prepare('SELECT * FROM b2b_correction_requests WHERE partner_id = ? ORDER BY requested_at DESC');
$myRequestsStmt->execute([$pid]);
$myRequests = $myRequestsStmt->fetchAll(PDO::FETCH_ASSOC);
?>
<div class="pp-page-header">
    <div>
        <h1 class="pp-page-title">Company Profile</h1>
        <p class="pp-page-subtitle">Your registered company details. Spotted a typo? Request a correction below — our team reviews every change before it takes effect.</p>
    </div>
</div>

<?php if ($actionMessage): ?><div class="b2b-form-error" style="background:#E7F6EC;color:#16A34A;"><?php echo htmlspecialchars($actionMessage); ?></div><?php endif; ?>
<?php if ($actionError): ?><div class="b2b-form-error"><?php echo htmlspecialchars($actionError); ?></div><?php endif; ?>

<div class="pp-card">
    <h3>Company Details</h3>
    <div class="pp-panel-grid">
        <div class="pp-panel-item"><label>Partner ID</label><div class="val"><?php echo htmlspecialchars($partner['application_ref']); ?></div></div>
        <div class="pp-panel-item"><label>Company Name</label><div class="val"><?php echo htmlspecialchars($partner['company_name']); ?></div></div>
        <div class="pp-panel-item"><label>Contact Person</label><div class="val"><?php echo htmlspecialchars($partner['contact_name']); ?></div></div>
        <div class="pp-panel-item"><label>Email</label><div class="val"><?php echo htmlspecialchars($partner['contact_email']); ?></div></div>
        <div class="pp-panel-item"><label>Mobile</label><div class="val"><?php echo htmlspecialchars($partner['contact_mobile']); ?></div></div>
        <div class="pp-panel-item"><label>Status</label><div class="val"><span class="pp-status-badge <?php echo b2b_status_class($partner['status']); ?>"><?php echo htmlspecialchars($partner['status']); ?></span></div></div>
    </div>
</div>

<div class="pp-card">
    <h3>Request a Correction</h3>
    <p class="pp-page-subtitle" style="margin:-4px 0 14px;">Use this for typos only — e.g. your company name was misspelled during registration, or a document was uploaded under the wrong label. A Super Admin reviews and approves every request before anything changes.</p>
    <form method="post" class="pp-panel-grid" id="correctionForm">
        <input type="hidden" name="action" value="submit_correction">
        <div class="pp-panel-item">
            <label>What needs correcting?</label>
            <select name="field_type" id="correctionFieldType" required style="width:100%;border:1px solid var(--border);border-radius:8px;padding:8px 10px;">
                <option value="">Select field</option>
                <?php foreach (B2B_CORRECTION_FIELD_TYPES as $key => $label): ?>
                <option value="<?php echo htmlspecialchars($key); ?>"><?php echo htmlspecialchars($label); ?></option>
                <?php endforeach; ?>
            </select>
        </div>
        <div class="pp-panel-item" id="correctionDocWrap" style="display:none;">
            <label>Which document?</label>
            <select name="target_document_id" style="width:100%;border:1px solid var(--border);border-radius:8px;padding:8px 10px;">
                <option value="">Select document</option>
                <?php foreach ($myDocuments as $d): ?>
                <option value="<?php echo (int) $d['id']; ?>"><?php echo htmlspecialchars((B2B_DOC_TYPES[$d['doc_type']] ?? $d['doc_type']) . ' — ' . $d['original_filename']); ?></option>
                <?php endforeach; ?>
            </select>
        </div>
        <div class="pp-panel-item"><label>Corrected Value</label><input type="text" name="new_value" required style="width:100%;border:1px solid var(--border);border-radius:8px;padding:8px 10px;"></div>
        <div class="pp-panel-item full"><label>Reason (optional)</label><input type="text" name="reason" placeholder="e.g. Typo during registration" style="width:100%;border:1px solid var(--border);border-radius:8px;padding:8px 10px;"></div>
        <div class="pp-panel-item full"><button type="submit" class="b2b-submit-btn" style="width:auto;padding:12px 26px;">Submit Request</button></div>
    </form>
</div>
<script>
(function () {
    var sel = document.getElementById('correctionFieldType');
    var wrap = document.getElementById('correctionDocWrap');
    if (!sel || !wrap) { return; }
    sel.addEventListener('change', function () {
        wrap.style.display = sel.value === 'document_name' ? '' : 'none';
        wrap.querySelector('select').required = sel.value === 'document_name';
    });
})();
</script>

<div class="pp-card">
    <h3>Your Correction Requests</h3>
    <div class="pp-table-wrap">
    <table class="pp-table">
        <thead><tr><th>Field</th><th>Current → Requested</th><th>Status</th><th>Submitted</th></tr></thead>
        <tbody>
        <?php foreach ($myRequests as $r): ?>
        <tr>
            <td class="pp-cell-name"><?php echo htmlspecialchars(B2B_CORRECTION_FIELD_TYPES[$r['field_type']] ?? $r['field_type']); ?></td>
            <td class="pp-cell-sub"><?php echo htmlspecialchars($r['old_value']); ?> &rarr; <strong><?php echo htmlspecialchars($r['new_value']); ?></strong></td>
            <td>
                <span class="pp-status-badge <?php echo $r['status'] === 'Approved' ? 'status-visa-approved' : ($r['status'] === 'Rejected' ? 'status-cancelled' : 'status-documents-pending'); ?>"><?php echo htmlspecialchars($r['status']); ?></span>
                <?php if ($r['review_note']): ?><div class="pp-cell-sub">Note: <?php echo htmlspecialchars($r['review_note']); ?></div><?php endif; ?>
            </td>
            <td class="pp-cell-sub"><?php echo htmlspecialchars(substr($r['requested_at'], 0, 10)); ?></td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$myRequests): ?>
        <tr><td colspan="4" class="pp-empty">No correction requests submitted yet.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/partner-layout-bottom.php'; ?>
