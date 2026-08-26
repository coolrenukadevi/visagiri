<?php
ob_start();
$ADMIN_PAGE_TITLE = 'Pending Documents';
$ADMIN_ACTIVE_NAV = 'forex-pending-docs';
$ADMIN_BREADCRUMB = ['CRM', 'Forex', 'Pending Documents'];
require __DIR__ . '/includes/layout-top.php';

if (!forex_can_verify_documents()) {
    http_response_code(403);
    echo '<div class="crm-card">You do not have permission to verify forex documents.</div>';
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';
    $docId = (int) ($_POST['doc_id'] ?? 0);

    if (in_array($action, ['verify', 'reject', 'under_review'], true) && $docId) {
        $docStmt = $pdo->prepare('SELECT d.*, r.forex_ref, r.id AS request_id FROM forex_documents d JOIN forex_requests r ON r.id = d.forex_request_id WHERE d.id = ?');
        $docStmt->execute([$docId]);
        $doc = $docStmt->fetch(PDO::FETCH_ASSOC);

        if ($doc) {
            $now = gmdate('c');
            if ($action === 'verify') {
                $remarks = trim($_POST['remarks'] ?? '');
                $pdo->prepare("UPDATE forex_documents SET status = 'Verified', verification_remarks = ?, rejection_reason = NULL, verified_by = ?, verified_at = ? WHERE id = ?")
                    ->execute([$remarks, admin_name(), $now, $docId]);
                forex_log_audit($pdo, $doc['request_id'], admin_name(), admin_role(), 'Verified document: ' . FOREX_DOC_TYPES[$doc['doc_type']], '', $remarks);
                if ($doc['doc_type'] === 'Declaration') {
                    $pdo->prepare('UPDATE forex_declarations SET verified_by = ?, verified_at = ? WHERE forex_request_id = ?')
                        ->execute([admin_name(), $now, $doc['request_id']]);
                }
            } elseif ($action === 'reject') {
                $reason = trim($_POST['reason'] ?? '');
                $pdo->prepare("UPDATE forex_documents SET status = 'Rejected', rejection_reason = ?, verified_by = ?, verified_at = ? WHERE id = ?")
                    ->execute([$reason, admin_name(), $now, $docId]);
                forex_log_audit($pdo, $doc['request_id'], admin_name(), admin_role(), 'Rejected document: ' . FOREX_DOC_TYPES[$doc['doc_type']], '', $reason);
                forex_notify($pdo, null, 'forex_document_rejected', "Document rejected on {$doc['forex_ref']}: " . FOREX_DOC_TYPES[$doc['doc_type']] . ($reason ? " — $reason" : ''), $doc['request_id']);
                $rejReqStmt = $pdo->prepare('SELECT * FROM forex_requests WHERE id = ?');
                $rejReqStmt->execute([$doc['request_id']]);
                $rejRequest = $rejReqStmt->fetch(PDO::FETCH_ASSOC);
                if ($rejRequest) {
                    forex_notify_customer(
                        $pdo, $rejRequest, "Document Rejected — {$doc['forex_ref']}",
                        "Dear {$rejRequest['full_name']},\n\nYour submitted document (" . FOREX_DOC_TYPES[$doc['doc_type']] . ") for forex request {$doc['forex_ref']} could not be verified" . ($reason ? ": $reason" : '.') . "\n\nPlease re-upload a valid copy so we can proceed. Track your request at https://visaagency.in/forex-track\n\nRegards,\nVisaAgency.in"
                    );
                }
            } else {
                $pdo->prepare("UPDATE forex_documents SET status = 'Under Verification' WHERE id = ?")->execute([$docId]);
                forex_log_audit($pdo, $doc['request_id'], admin_name(), admin_role(), 'Marked under verification: ' . FOREX_DOC_TYPES[$doc['doc_type']]);
            }
        }
        $returnUrl = trim($_POST['return_url'] ?? '');
        if ($returnUrl !== '' && preg_match('#^forex-request\.php\?ref=[A-Za-z0-9\-]+$#', $returnUrl)) {
            header('Location: ' . $returnUrl . '#documents');
        } else {
            header('Location: forex-documents.php' . (isset($_GET['status']) ? '?status=' . urlencode($_GET['status']) : ''));
        }
        exit;
    }
}

$statusFilter = trim($_GET['status'] ?? 'Uploaded');
$where = "d.stored_filename IS NOT NULL";
$params = [];
if ($statusFilter !== '' && in_array($statusFilter, FOREX_DOC_STATUSES, true)) {
    $where .= ' AND d.status = :status';
    $params['status'] = $statusFilter;
}
// Only the current (highest-id) row per (request, doc_type) — older
// versions are history, not part of the active checklist.
$sql = "SELECT d.*, r.forex_ref, r.full_name, r.country_visit
    FROM forex_documents d
    JOIN forex_requests r ON r.id = d.forex_request_id
    WHERE $where AND d.id = (SELECT MAX(id) FROM forex_documents d2 WHERE d2.forex_request_id = d.forex_request_id AND d2.doc_type = d.doc_type)
    ORDER BY d.uploaded_at ASC";
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$documents = $stmt->fetchAll(PDO::FETCH_ASSOC);

$pendingCount = (int) $pdo->query("SELECT COUNT(*) FROM forex_documents WHERE status IN ('Uploaded','Under Verification') AND stored_filename IS NOT NULL")->fetchColumn();
$verifiedCount = (int) $pdo->query("SELECT COUNT(*) FROM forex_documents WHERE status = 'Verified'")->fetchColumn();
$rejectedCount = (int) $pdo->query("SELECT COUNT(*) FROM forex_documents WHERE status = 'Rejected'")->fetchColumn();
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Pending Documents</h1>
        <p class="crm-page-subtitle">Every document must be verified, not merely uploaded, before a request can proceed to delivery.</p>
    </div>
</div>

<div class="crm-kpi-grid" style="grid-template-columns:repeat(3,1fr);">
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $pendingCount; ?></div><div class="crm-kpi-label">Awaiting Verification</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $verifiedCount; ?></div><div class="crm-kpi-label">Verified</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $rejectedCount; ?></div><div class="crm-kpi-label">Rejected</div></div>
</div>

<div class="crm-filter-bar" style="margin-bottom:16px;">
    <?php foreach (['' => 'All', 'Uploaded' => 'Uploaded', 'Under Verification' => 'Under Verification', 'Verified' => 'Verified', 'Rejected' => 'Rejected'] as $val => $label): ?>
    <a href="forex-documents.php<?php echo $val !== '' ? '?status=' . urlencode($val) : ''; ?>" class="crm-btn crm-btn-sm <?php echo $statusFilter === $val ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>"><?php echo htmlspecialchars($label); ?></a>
    <?php endforeach; ?>
</div>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Request</th><th>Customer</th><th>Destination</th><th>Document</th><th>Status</th><th>Uploaded</th><th style="min-width:340px;">Action</th></tr></thead>
        <tbody>
        <?php foreach ($documents as $d): ?>
        <tr>
            <td class="crm-cell-name"><a href="forex-request.php?ref=<?php echo urlencode($d['forex_ref']); ?>#documents"><?php echo htmlspecialchars($d['forex_ref']); ?></a></td>
            <td><?php echo htmlspecialchars($d['full_name']); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($d['country_visit'] ?: '—'); ?></td>
            <td>
                <?php echo htmlspecialchars(FOREX_DOC_TYPES[$d['doc_type']] ?? $d['doc_type']); ?>
                <div class="crm-cell-sub"><a href="forex-document.php?id=<?php echo (int) $d['id']; ?>"><i class="fa-solid fa-download"></i> <?php echo htmlspecialchars($d['original_filename']); ?></a></div>
                <?php if ($d['rejection_reason']): ?><div class="crm-cell-sub" style="color:var(--c-red);">Rejected: <?php echo htmlspecialchars($d['rejection_reason']); ?></div><?php endif; ?>
                <?php if ($d['verification_remarks']): ?><div class="crm-cell-sub" style="color:var(--c-green);">Remarks: <?php echo htmlspecialchars($d['verification_remarks']); ?></div><?php endif; ?>
            </td>
            <td><span class="crm-status-badge <?php echo forex_doc_status_class($d['status']); ?>"><?php echo htmlspecialchars($d['status']); ?></span></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars(substr((string) $d['uploaded_at'], 0, 16)); ?></td>
            <td>
                <?php if (in_array($d['status'], ['Uploaded', 'Under Verification'], true)): ?>
                <div style="display:flex;gap:6px;flex-wrap:wrap;align-items:center;">
                    <form method="post" style="display:flex;gap:6px;align-items:center;">
                        <input type="hidden" name="action" value="verify">
                        <input type="hidden" name="doc_id" value="<?php echo (int) $d['id']; ?>">
                        <input type="text" name="remarks" placeholder="Verification remarks..." style="font-size:11.5px;padding:5px 8px;border:1px solid var(--c-border);border-radius:6px;width:150px;">
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
