<?php
require_once __DIR__ . '/includes/admin-auth.php';
require_once __DIR__ . '/../includes/forex-db.php';
require_once __DIR__ . '/includes/forex-permissions.php';
admin_require_login();

if (!forex_can_export_audit()) {
    http_response_code(403);
    exit('You do not have permission to view FEMA/audit records.');
}

if (($_GET['export'] ?? '') === 'csv') {
    $pdo = enquiry_db();
    forex_db();
    $q = trim($_GET['q'] ?? '');
    $where = '';
    $params = [];
    if ($q !== '') {
        $where = 'WHERE forex_ref LIKE :q OR full_name LIKE :q OR passport_number LIKE :q OR pan_number LIKE :q';
        $params['q'] = '%' . $q . '%';
    }
    $stmt = $pdo->prepare("SELECT * FROM forex_requests $where ORDER BY created_at DESC LIMIT 300");
    $stmt->execute($params);
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="forex-audit-' . gmdate('Ymd-His') . '.csv"');
    $out = fopen('php://output', 'w');
    fputcsv($out, ['Forex Ref', 'Customer', 'Passport', 'PAN', 'Country', 'Currency', 'Amount', 'Status', 'Assigned', 'Created At']);
    foreach ($rows as $r) {
        fputcsv($out, [$r['forex_ref'], $r['full_name'], $r['passport_number'], $r['pan_number'], $r['country_visit'], $r['currency_code'], $r['amount_required'], $r['status'], $r['assigned_to'], $r['created_at']]);
    }
    fclose($out);
    exit;
}

ob_start();
$ADMIN_PAGE_TITLE = 'FEMA / Audit Records';
$ADMIN_ACTIVE_NAV = 'forex-audit';
$ADMIN_BREADCRUMB = ['CRM', 'Forex', 'FEMA / Audit Records'];
require __DIR__ . '/includes/layout-top.php';

$ref = trim($_GET['ref'] ?? '');

if ($ref !== '') {
    // ---- Single-record full audit view ----
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

    $allDocsStmt = $pdo->prepare('SELECT * FROM forex_documents WHERE forex_request_id = ? ORDER BY doc_type, id ASC');
    $allDocsStmt->execute([$requestId]);
    $allDocs = $allDocsStmt->fetchAll(PDO::FETCH_ASSOC);

    $declStmt = $pdo->prepare('SELECT * FROM forex_declarations WHERE forex_request_id = ? ORDER BY id DESC');
    $declStmt->execute([$requestId]);
    $declarations = $declStmt->fetchAll(PDO::FETCH_ASSOC);

    $quotStmt = $pdo->prepare('SELECT * FROM forex_quotations WHERE forex_request_id = ? ORDER BY id ASC');
    $quotStmt->execute([$requestId]);
    $quotations = $quotStmt->fetchAll(PDO::FETCH_ASSOC);

    $approvalsStmt = $pdo->prepare('SELECT * FROM forex_approvals WHERE forex_request_id = ? ORDER BY id ASC');
    $approvalsStmt->execute([$requestId]);
    $approvals = $approvalsStmt->fetchAll(PDO::FETCH_ASSOC);

    $paymentsStmt = $pdo->prepare('SELECT * FROM forex_payments WHERE forex_request_id = ? ORDER BY id ASC');
    $paymentsStmt->execute([$requestId]);
    $payments = $paymentsStmt->fetchAll(PDO::FETCH_ASSOC);

    $deliveryStmt = $pdo->prepare('SELECT * FROM forex_deliveries WHERE forex_request_id = ?');
    $deliveryStmt->execute([$requestId]);
    $delivery = $deliveryStmt->fetch(PDO::FETCH_ASSOC);
    $denominations = [];
    if ($delivery) {
        $dnStmt = $pdo->prepare('SELECT * FROM forex_denominations WHERE delivery_id = ?');
        $dnStmt->execute([$delivery['id']]);
        $denominations = $dnStmt->fetchAll(PDO::FETCH_ASSOC);
    }

    $historyStmt = $pdo->prepare('SELECT * FROM forex_status_history WHERE forex_request_id = ? ORDER BY id ASC');
    $historyStmt->execute([$requestId]);
    $history = $historyStmt->fetchAll(PDO::FETCH_ASSOC);

    $auditStmt = $pdo->prepare('SELECT * FROM forex_audit_logs WHERE forex_request_id = ? ORDER BY id ASC');
    $auditStmt->execute([$requestId]);
    $auditLog = $auditStmt->fetchAll(PDO::FETCH_ASSOC);

    function fa_fmt($v) { $v = trim((string) $v); return $v === '' ? '<span style="color:var(--c-muted);">—</span>' : htmlspecialchars($v); }
    ?>
    <a href="forex-audit.php" style="font-size:12.5px;color:var(--c-text);display:inline-block;margin-bottom:14px;">&larr; Back to FEMA / Audit Records</a>

    <div class="crm-page-header">
        <div>
            <h1 class="crm-page-title">FEMA / Audit Record — <?php echo htmlspecialchars($request['forex_ref']); ?></h1>
            <p class="crm-page-subtitle">Permanent compliance record. This page is a record-keeping tool and does not itself constitute FEMA/RBI legal compliance — final rules should be reviewed by an authorised compliance/legal professional.</p>
        </div>
    </div>

    <div class="crm-two-col">
        <div class="crm-card">
            <h3>Customer &amp; Transaction</h3>
            <div class="crm-panel-grid">
                <div class="crm-panel-item"><label>Forex Reference</label><div class="val"><?php echo fa_fmt($request['forex_ref']); ?></div></div>
                <div class="crm-panel-item"><label>Customer Name</label><div class="val"><?php echo fa_fmt($request['full_name']); ?></div></div>
                <div class="crm-panel-item"><label>Passport Number</label><div class="val"><?php echo fa_fmt($request['passport_number']); ?></div></div>
                <div class="crm-panel-item"><label>PAN</label><div class="val"><?php echo fa_fmt($request['pan_number']); ?></div></div>
                <div class="crm-panel-item"><label>Country</label><div class="val"><?php echo fa_fmt($request['country_visit']); ?></div></div>
                <div class="crm-panel-item"><label>Purpose of Travel</label><div class="val"><?php echo fa_fmt($request['purpose']); ?></div></div>
                <div class="crm-panel-item"><label>Currency</label><div class="val"><?php echo fa_fmt($request['currency_code']); ?></div></div>
                <div class="crm-panel-item"><label>Amount</label><div class="val"><?php echo fa_fmt(number_format((float) $request['amount_required'], 2)); ?></div></div>
                <div class="crm-panel-item"><label>Status</label><div class="val"><?php echo fa_fmt($request['status']); ?></div></div>
                <div class="crm-panel-item"><label>Staff Responsible</label><div class="val"><?php echo fa_fmt($request['assigned_to']); ?></div></div>
                <div class="crm-panel-item"><label>Created By</label><div class="val"><?php echo fa_fmt($request['created_by']); ?></div></div>
                <div class="crm-panel-item"><label>Created At</label><div class="val"><?php echo fa_fmt(substr($request['created_at'], 0, 16)); ?></div></div>
            </div>
        </div>
        <div class="crm-card">
            <h3>Delivery &amp; Acknowledgement</h3>
            <?php if ($delivery): ?>
            <div class="crm-panel-grid">
                <div class="crm-panel-item"><label>Delivery Date/Time</label><div class="val"><?php echo fa_fmt($delivery['delivery_date'] . ' ' . $delivery['delivery_time']); ?></div></div>
                <div class="crm-panel-item"><label>Delivered By</label><div class="val"><?php echo fa_fmt($delivery['delivered_by']); ?></div></div>
                <div class="crm-panel-item"><label>Received By</label><div class="val"><?php echo fa_fmt($delivery['received_by']); ?></div></div>
                <div class="crm-panel-item"><label>Amount Delivered</label><div class="val"><?php echo fa_fmt($delivery['currency_code'] . ' ' . number_format((float) $delivery['total_amount'], 2)); ?></div></div>
                <div class="crm-panel-item"><label>Customer Acknowledgement</label><div class="val"><?php echo $delivery['customer_ack'] ? '<span style="color:var(--c-green);">Confirmed</span>' : '<span style="color:var(--c-red);">Not confirmed</span>'; ?></div></div>
            </div>
            <?php if ($denominations): ?>
            <table class="crm-table" style="margin-top:12px;">
                <thead><tr><th>Denomination</th><th>Qty</th></tr></thead>
                <tbody><?php foreach ($denominations as $dn): ?><tr><td><?php echo htmlspecialchars($delivery['currency_code']); ?> <?php echo number_format((float) $dn['denomination_value'], 2); ?></td><td><?php echo (int) $dn['quantity']; ?></td></tr><?php endforeach; ?></tbody>
            </table>
            <?php endif; ?>
            <a href="forex-delivery-receipt.php?ref=<?php echo urlencode($request['forex_ref']); ?>" target="_blank" class="crm-btn crm-btn-ghost crm-btn-sm" style="margin-top:12px;"><i class="fa-solid fa-file-pdf"></i> Delivery Proof (PDF)</a>
            <?php else: ?>
            <div class="crm-empty">Not yet delivered.</div>
            <?php endif; ?>
        </div>
    </div>

    <div class="crm-card">
        <h3>Quotations (Rate Snapshots)</h3>
        <?php if (!$quotations): ?><div class="crm-empty">No quotations.</div><?php else: ?>
        <div class="crm-table-wrap">
        <table class="crm-table">
            <thead><tr><th>Currency</th><th>Amount</th><th>Rate</th><th>Rate Type</th><th>Total INR</th><th>Status</th><th>Created</th><th>Proof</th></tr></thead>
            <tbody>
            <?php foreach ($quotations as $q): ?>
            <tr>
                <td><?php echo htmlspecialchars($q['currency_code']); ?></td>
                <td><?php echo number_format((float) $q['currency_amount'], 2); ?></td>
                <td>₹<?php echo number_format((float) $q['exchange_rate'], 4); ?></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars($q['rate_type']); ?></td>
                <td>₹<?php echo number_format((float) $q['total_inr'], 2); ?></td>
                <td><?php echo htmlspecialchars($q['status']); ?></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars(substr($q['created_at'], 0, 16)); ?> by <?php echo htmlspecialchars($q['created_by']); ?></td>
                <td><a href="forex-quotation-pdf.php?id=<?php echo (int) $q['id']; ?>" target="_blank" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-file-pdf"></i></a></td>
            </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
        </div>
        <?php endif; ?>
    </div>

    <div class="crm-card">
        <h3>Documents (Full Version History)</h3>
        <?php if (!$allDocs): ?><div class="crm-empty">No documents.</div><?php else: ?>
        <div class="crm-table-wrap">
        <table class="crm-table">
            <thead><tr><th>Type</th><th>Filename</th><th>Status</th><th>Verified By</th><th>Uploaded</th><th></th></tr></thead>
            <tbody>
            <?php foreach ($allDocs as $d): ?>
            <tr>
                <td><?php echo htmlspecialchars(FOREX_DOC_TYPES[$d['doc_type']] ?? $d['doc_type']); ?><?php echo $d['replaces_document_id'] ? ' <span class="crm-cell-sub">(replaces #' . (int) $d['replaces_document_id'] . ')</span>' : ''; ?></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars($d['original_filename'] ?: '—'); ?></td>
                <td><span class="crm-status-badge <?php echo forex_doc_status_class($d['status']); ?>"><?php echo htmlspecialchars($d['status']); ?></span></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars($d['verified_by'] ?: '—'); ?></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars($d['uploaded_at'] ? substr($d['uploaded_at'], 0, 16) : '—'); ?></td>
                <td><?php if ($d['stored_filename']): ?><a href="forex-document.php?id=<?php echo (int) $d['id']; ?>" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-download"></i></a><?php endif; ?></td>
            </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
        </div>
        <?php endif; ?>
        <?php if ($declarations): ?>
        <h4 style="margin-top:18px;font-size:13px;">Declarations</h4>
        <?php foreach ($declarations as $decl): ?>
        <div style="font-size:12.5px;color:var(--c-text);padding:8px 0;border-top:1px solid var(--c-border);">
            Declaration for <?php echo htmlspecialchars($decl['customer_name']); ?>, passport <?php echo htmlspecialchars($decl['passport_number'] ?: '—'); ?>,
            dated <?php echo htmlspecialchars($decl['declaration_date']); ?>. Signed copy: <?php echo $decl['stored_filename'] ? 'Uploaded' : 'Not uploaded'; ?>.
            Verified: <?php echo $decl['verified_at'] ? htmlspecialchars($decl['verified_by'] . ' — ' . substr($decl['verified_at'], 0, 10)) : 'Pending'; ?>.
        </div>
        <?php endforeach; ?>
        <?php endif; ?>
    </div>

    <div class="crm-card">
        <h3>Payment Proof</h3>
        <?php if (!$payments): ?><div class="crm-empty">No payments recorded.</div><?php else: ?>
        <table class="crm-table">
            <thead><tr><th>Status</th><th>Method</th><th>Amount</th><th>Transaction ID</th><th>Date</th><th>Recorded By</th></tr></thead>
            <tbody>
            <?php foreach ($payments as $p): ?>
            <tr><td><?php echo htmlspecialchars($p['status']); ?></td><td><?php echo htmlspecialchars($p['method'] ?: '—'); ?></td><td>₹<?php echo number_format((float) $p['amount'], 2); ?></td><td class="crm-cell-sub"><?php echo htmlspecialchars($p['transaction_id'] ?: '—'); ?></td><td class="crm-cell-sub"><?php echo htmlspecialchars($p['payment_date']); ?></td><td class="crm-cell-sub"><?php echo htmlspecialchars($p['recorded_by']); ?></td></tr>
            <?php endforeach; ?>
            </tbody>
        </table>
        <?php endif; ?>
    </div>

    <div class="crm-card">
        <h3>Approvals &amp; Compliance Overrides</h3>
        <?php if (!$approvals): ?><div class="crm-empty">No approval/override actions recorded.</div><?php else: ?>
        <?php foreach ($approvals as $a): ?>
        <div style="border-top:1px solid var(--c-border);padding:10px 0;font-size:12.5px;">
            <strong><?php echo htmlspecialchars($a['action']); ?></strong> by <?php echo htmlspecialchars($a['approver']); ?> &middot; <?php echo htmlspecialchars(substr($a['created_at'], 0, 16)); ?> &middot; IP <?php echo htmlspecialchars($a['ip_address'] ?: '—'); ?>
            <?php if ($a['remarks']): ?><div style="color:var(--c-text);margin-top:4px;">Remarks: <?php echo htmlspecialchars($a['remarks']); ?></div><?php endif; ?>
            <?php if ($a['previous_value']): ?><div style="color:var(--c-red);margin-top:4px;font-size:11.5px;">Missing at time of action: <?php echo htmlspecialchars($a['previous_value']); ?></div><?php endif; ?>
        </div>
        <?php endforeach; ?>
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
                    <div class="crm-timeline-meta"><?php echo htmlspecialchars($h['changed_by']); ?> &middot; <?php echo htmlspecialchars(substr($h['created_at'], 0, 16)); ?></div>
                </div>
                <?php endforeach; ?>
            </div>
        </div>
        <div class="crm-card">
            <h3>Full Audit Trail</h3>
            <div class="crm-timeline">
                <?php foreach ($auditLog as $a): ?>
                <div class="crm-timeline-item">
                    <div class="crm-timeline-dot"></div>
                    <div class="crm-timeline-action"><?php echo htmlspecialchars($a['action']); ?></div>
                    <?php if ($a['new_value']): ?><div class="crm-timeline-notes"><?php echo htmlspecialchars($a['new_value']); ?></div><?php endif; ?>
                    <div class="crm-timeline-meta"><?php echo htmlspecialchars($a['user_name']); ?> (<?php echo htmlspecialchars($a['role']); ?>) &middot; <?php echo htmlspecialchars(substr($a['created_at'], 0, 16)); ?> &middot; IP <?php echo htmlspecialchars($a['ip_address'] ?: '—'); ?></div>
                </div>
                <?php endforeach; ?>
            </div>
        </div>
    </div>

    <?php
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}

// ---- List view ----
$q = trim($_GET['q'] ?? '');
$where = '';
$params = [];
if ($q !== '') {
    $where = 'WHERE forex_ref LIKE :q OR full_name LIKE :q OR passport_number LIKE :q OR pan_number LIKE :q';
    $params['q'] = '%' . $q . '%';
}
$stmt = $pdo->prepare("SELECT * FROM forex_requests $where ORDER BY created_at DESC LIMIT 300");
$stmt->execute($params);
$requests = $stmt->fetchAll(PDO::FETCH_ASSOC);
$deliveredCount = (int) $pdo->query("SELECT COUNT(*) FROM forex_requests WHERE status = 'Delivered'")->fetchColumn();
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">FEMA / Audit Records</h1>
        <p class="crm-page-subtitle">Permanent compliance records for every forex transaction. This is a record-keeping tool, not a guarantee of FEMA/RBI legal compliance — final rules should be reviewed by an authorised compliance/legal professional. Completed transactions are never deletable from this CRM.</p>
    </div>
    <div class="crm-page-actions">
        <a href="forex-audit.php?export=csv<?php echo $q ? '&q=' . urlencode($q) : ''; ?>" class="crm-btn crm-btn-ghost"><i class="fa-solid fa-file-csv"></i> Export CSV</a>
    </div>
</div>

<div class="crm-kpi-grid" style="grid-template-columns:repeat(2,1fr);">
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo count($requests); ?></div><div class="crm-kpi-label">Total Records</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $deliveredCount; ?></div><div class="crm-kpi-label">Completed (Delivered)</div></div>
</div>

<form method="get" class="crm-filter-bar" style="margin-bottom:16px;">
    <input type="text" name="q" value="<?php echo htmlspecialchars($q); ?>" placeholder="Search ref, name, passport, PAN..." style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;min-width:260px;">
    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Search</button>
    <?php if ($q): ?><a href="forex-audit.php" class="crm-btn crm-btn-ghost crm-btn-sm">Clear</a><?php endif; ?>
</form>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Ref</th><th>Customer</th><th>Passport</th><th>PAN</th><th>Country</th><th>Amount</th><th>Status</th><th>Created</th></tr></thead>
        <tbody>
        <?php foreach ($requests as $r): ?>
        <tr>
            <td class="crm-cell-name"><a href="forex-audit.php?ref=<?php echo urlencode($r['forex_ref']); ?>"><?php echo htmlspecialchars($r['forex_ref']); ?></a></td>
            <td><?php echo htmlspecialchars($r['full_name']); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($r['passport_number'] ?: '—'); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($r['pan_number'] ?: '—'); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($r['country_visit'] ?: '—'); ?></td>
            <td><?php echo htmlspecialchars($r['currency_code']); ?> <?php echo number_format((float) $r['amount_required'], 2); ?></td>
            <td><span class="crm-status-badge <?php echo forex_status_class($r['status']); ?>"><?php echo htmlspecialchars($r['status']); ?></span></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars(substr($r['created_at'], 0, 10)); ?></td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$requests): ?><tr><td colspan="8" class="crm-empty">No records match this search.</td></tr><?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
