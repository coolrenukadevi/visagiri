<?php
ob_start();
$ADMIN_PAGE_TITLE = 'Document Verification';
$ADMIN_ACTIVE_NAV = 'b2b-documents';
$ADMIN_BREADCRUMB = ['CRM', 'B2B Partners', 'Document Verification'];
require __DIR__ . '/includes/layout-top.php';

if (!b2b_can_verify_documents()) {
    http_response_code(403);
    echo '<div class="crm-card">You do not have permission to verify B2B partner documents.</div>';
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'run_expiry_check' && b2b_can_verify_documents()) {
    b2b_csrf_require_or_403();
    $expiryResult = b2b_check_document_expiries($pdo);
    header('Location: b2b-documents.php?expiry_ran=1' . (isset($_GET['status']) ? '&status=' . urlencode($_GET['status']) : ''));
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    b2b_csrf_require_or_403();
    $action = $_POST['action'] ?? '';
    $docId = (int) ($_POST['doc_id'] ?? 0);

    if (in_array($action, ['verify', 'reject', 'expired'], true) && $docId) {
        $docStmt = $pdo->prepare('SELECT d.*, p.application_ref, p.id AS partner_id, p.contact_email, p.contact_name, p.company_name FROM b2b_partner_documents d JOIN b2b_partners p ON p.id = d.partner_id WHERE d.id = ?');
        $docStmt->execute([$docId]);
        $doc = $docStmt->fetch(PDO::FETCH_ASSOC);

        if ($doc) {
            $now = gmdate('c');
            if ($action === 'verify') {
                $remarks = trim($_POST['remarks'] ?? '');
                $expiryDate = trim($_POST['expiry_date'] ?? '');
                $expiryDate = (in_array($doc['doc_type'], B2B_DOC_TYPES_WITH_EXPIRY, true) && preg_match('/^\d{4}-\d{2}-\d{2}$/', $expiryDate)) ? $expiryDate : null;
                $pdo->prepare("UPDATE b2b_partner_documents SET status = 'Verified', verification_remarks = ?, rejection_reason = NULL, expiry_date = ?, verified_by = ?, verified_at = ? WHERE id = ?")
                    ->execute([$remarks, $expiryDate, admin_name(), $now, $docId]);
                b2b_log_audit($pdo, 'document', $docId, admin_name(), admin_role(), 'Verified document: ' . B2B_DOC_TYPES[$doc['doc_type']], '', $remarks . ($expiryDate ? " (expires $expiryDate)" : ''));
            } elseif ($action === 'reject') {
                $reason = trim($_POST['reason'] ?? '');
                $pdo->prepare("UPDATE b2b_partner_documents SET status = 'Rejected', rejection_reason = ?, verified_by = ?, verified_at = ? WHERE id = ?")
                    ->execute([$reason, admin_name(), $now, $docId]);
                b2b_log_audit($pdo, 'document', $docId, admin_name(), admin_role(), 'Rejected document: ' . B2B_DOC_TYPES[$doc['doc_type']], '', $reason);
                b2b_notify($pdo, null, 'b2b_document_rejected', "Document rejected on {$doc['application_ref']}: " . B2B_DOC_TYPES[$doc['doc_type']] . ($reason ? " — $reason" : ''), $doc['partner_id']);
                b2b_notify_partner(
                    $pdo, $doc,
                    "Document Needs Attention — {$doc['application_ref']}",
                    "Dear {$doc['contact_name']},\n\nYour submitted document (" . B2B_DOC_TYPES[$doc['doc_type']] . ") for application {$doc['application_ref']} could not be verified" . ($reason ? ": $reason" : '.') . "\n\nPlease re-upload a valid copy using your original upload link, or contact your Relationship Manager.\n\nRegards,\nVisaAgency.in B2B Partner Team"
                );
            } else {
                $pdo->prepare("UPDATE b2b_partner_documents SET status = 'Expired', verified_by = ?, verified_at = ? WHERE id = ?")->execute([admin_name(), $now, $docId]);
                b2b_log_audit($pdo, 'document', $docId, admin_name(), admin_role(), 'Marked expired: ' . B2B_DOC_TYPES[$doc['doc_type']]);
            }
        }
        $returnUrl = trim($_POST['return_url'] ?? '');
        if ($returnUrl !== '' && preg_match('#^b2b-partner\.php\?ref=[A-Za-z0-9\-]+$#', $returnUrl)) {
            header('Location: ' . $returnUrl . '#documents');
        } else {
            header('Location: b2b-documents.php' . (isset($_GET['status']) ? '?status=' . urlencode($_GET['status']) : ''));
        }
        exit;
    }
}

$statusFilter = trim($_GET['status'] ?? 'Pending');
$where = "d.stored_filename IS NOT NULL";
$params = [];
if ($statusFilter !== '' && in_array($statusFilter, B2B_DOC_STATUSES, true)) {
    $where .= ' AND d.status = :status';
    $params['status'] = $statusFilter;
}
$sql = "SELECT d.*, p.application_ref, p.company_name, p.city
    FROM b2b_partner_documents d
    JOIN b2b_partners p ON p.id = d.partner_id
    WHERE $where AND d.id = (SELECT MAX(id) FROM b2b_partner_documents d2 WHERE d2.partner_id = d.partner_id AND d2.doc_type = d.doc_type)
    ORDER BY d.uploaded_at ASC";
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$documents = $stmt->fetchAll(PDO::FETCH_ASSOC);

$pendingCount = (int) $pdo->query("SELECT COUNT(*) FROM b2b_partner_documents WHERE status = 'Pending' AND stored_filename IS NOT NULL")->fetchColumn();
$verifiedCount = (int) $pdo->query("SELECT COUNT(*) FROM b2b_partner_documents WHERE status = 'Verified'")->fetchColumn();
$rejectedCount = (int) $pdo->query("SELECT COUNT(*) FROM b2b_partner_documents WHERE status = 'Rejected'")->fetchColumn();

$expiringPlaceholders = implode(',', array_fill(0, count(B2B_DOC_TYPES_WITH_EXPIRY), '?'));
$expiringStmt = $pdo->prepare("SELECT d.*, p.application_ref, p.company_name FROM b2b_partner_documents d JOIN b2b_partners p ON p.id = d.partner_id
    WHERE d.status = 'Verified' AND d.doc_type IN ($expiringPlaceholders) AND d.expiry_date IS NOT NULL AND d.expiry_date != ''
    AND d.expiry_date <= ? ORDER BY d.expiry_date ASC");
$expiringStmt->execute(array_merge(B2B_DOC_TYPES_WITH_EXPIRY, [gmdate('Y-m-d', strtotime('+30 days'))]));
$expiringDocuments = $expiringStmt->fetchAll(PDO::FETCH_ASSOC);
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Document Verification</h1>
        <p class="crm-page-subtitle">Review documents uploaded with B2B partner applications.</p>
    </div>
    <form method="post">
        <input type="hidden" name="action" value="run_expiry_check">
        <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-clock-rotate-left"></i> Run Expiry Check Now</button>
    </form>
</div>

<?php if (isset($_GET['expiry_ran'])): ?>
<div class="crm-alert crm-alert-success">Expiry check complete — expired and expiring-soon documents have been flagged and notified.</div>
<?php endif; ?>

<div class="crm-kpi-grid" style="grid-template-columns:repeat(4,1fr);">
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $pendingCount; ?></div><div class="crm-kpi-label">Awaiting Verification</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $verifiedCount; ?></div><div class="crm-kpi-label">Verified</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $rejectedCount; ?></div><div class="crm-kpi-label">Rejected</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo count($expiringDocuments); ?></div><div class="crm-kpi-label">Expiring Within 30 Days</div></div>
</div>

<?php if ($expiringDocuments): ?>
<div class="crm-card">
    <h3 style="margin:0 0 14px;font-size:14px;">Documents Expiring Soon</h3>
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Application</th><th>Company</th><th>Document</th><th>Expiry Date</th><th>Days Left</th></tr></thead>
        <tbody>
        <?php foreach ($expiringDocuments as $ed): $daysLeft = (int) floor((strtotime($ed['expiry_date']) - strtotime(gmdate('Y-m-d'))) / 86400); ?>
        <tr>
            <td class="crm-cell-name"><a href="b2b-partner.php?ref=<?php echo urlencode($ed['application_ref']); ?>#documents"><?php echo htmlspecialchars($ed['application_ref']); ?></a></td>
            <td><?php echo htmlspecialchars($ed['company_name']); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars(B2B_DOC_TYPES[$ed['doc_type']] ?? $ed['doc_type']); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars(substr($ed['expiry_date'], 0, 10)); ?></td>
            <td><span class="crm-status-badge" style="background:<?php echo $daysLeft < 0 ? 'var(--c-red-bg);color:var(--c-red)' : ($daysLeft <= 7 ? 'var(--c-red-bg);color:var(--c-red)' : ($daysLeft <= 15 ? 'var(--c-amber-bg);color:var(--c-amber)' : 'var(--c-blue-dim);color:var(--c-blue)')); ?>;"><?php echo $daysLeft < 0 ? 'Expired' : "$daysLeft days"; ?></span></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>
</div>
<?php endif; ?>

<div class="crm-filter-bar" style="margin-bottom:16px;">
    <?php foreach (['' => 'All', 'Pending' => 'Pending', 'Verified' => 'Verified', 'Rejected' => 'Rejected', 'Expired' => 'Expired'] as $val => $label): ?>
    <a href="b2b-documents.php<?php echo $val !== '' ? '?status=' . urlencode($val) : ''; ?>" class="crm-btn crm-btn-sm <?php echo $statusFilter === $val ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>"><?php echo htmlspecialchars($label); ?></a>
    <?php endforeach; ?>
</div>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Application</th><th>Company</th><th>City</th><th>Document</th><th>Status</th><th>Uploaded</th><th style="min-width:340px;">Action</th></tr></thead>
        <tbody>
        <?php foreach ($documents as $d): ?>
        <tr>
            <td class="crm-cell-name"><a href="b2b-partner.php?ref=<?php echo urlencode($d['application_ref']); ?>#documents"><?php echo htmlspecialchars($d['application_ref']); ?></a></td>
            <td><?php echo htmlspecialchars($d['company_name']); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($d['city'] ?: '—'); ?></td>
            <td>
                <?php echo htmlspecialchars(B2B_DOC_TYPES[$d['doc_type']] ?? $d['doc_type']); ?>
                <div class="crm-cell-sub"><a href="b2b-document.php?id=<?php echo (int) $d['id']; ?>"><i class="fa-solid fa-download"></i> <?php echo htmlspecialchars($d['original_filename']); ?></a></div>
                <?php if ($d['rejection_reason']): ?><div class="crm-cell-sub" style="color:var(--c-red);">Rejected: <?php echo htmlspecialchars($d['rejection_reason']); ?></div><?php endif; ?>
                <?php if ($d['verification_remarks']): ?><div class="crm-cell-sub" style="color:var(--c-green);">Remarks: <?php echo htmlspecialchars($d['verification_remarks']); ?></div><?php endif; ?>
            </td>
            <td><span class="crm-status-badge <?php echo b2b_doc_status_class($d['status']); ?>"><?php echo htmlspecialchars($d['status']); ?></span></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars(substr((string) $d['uploaded_at'], 0, 16)); ?></td>
            <td>
                <?php if ($d['status'] === 'Pending'): ?>
                <div style="display:flex;gap:6px;flex-wrap:wrap;align-items:center;">
                    <form method="post" style="display:flex;gap:6px;align-items:center;">
                        <input type="hidden" name="action" value="verify">
                        <input type="hidden" name="doc_id" value="<?php echo (int) $d['id']; ?>">
                        <input type="text" name="remarks" placeholder="Verification remarks..." style="font-size:11.5px;padding:5px 8px;border:1px solid var(--c-border);border-radius:6px;width:150px;">
                        <?php if (in_array($d['doc_type'], B2B_DOC_TYPES_WITH_EXPIRY, true)): ?>
                        <input type="date" name="expiry_date" title="Expiry date (for monitoring)" style="font-size:11.5px;padding:5px 8px;border:1px solid var(--c-border);border-radius:6px;">
                        <?php endif; ?>
                        <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Verify</button>
                    </form>
                    <form method="post" style="display:flex;gap:6px;align-items:center;">
                        <input type="hidden" name="action" value="reject">
                        <input type="hidden" name="doc_id" value="<?php echo (int) $d['id']; ?>">
                        <input type="text" name="reason" placeholder="Rejection reason..." required style="font-size:11.5px;padding:5px 8px;border:1px solid var(--c-border);border-radius:6px;width:150px;">
                        <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm" style="color:var(--c-red);">Reject</button>
                    </form>
                </div>
                <?php else: ?>
                <span class="crm-cell-sub"><?php echo htmlspecialchars($d['verified_by'] ?: ''); ?> <?php echo $d['verified_at'] ? '· ' . substr($d['verified_at'], 0, 10) : ''; ?></span>
                <?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$documents): ?>
        <tr><td colspan="7" class="crm-empty">No documents match this filter.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
