<?php
declare(strict_types=1);

/**
 * FEMA / Audit Documentation (section 19). Read-only in Phase A —
 * export is Phase B. This is a compliance record-management tool,
 * not a claim that the software itself guarantees FEMA/RBI legal
 * compliance; the company's authorized compliance/legal professional
 * should review the actual regulatory requirements.
 */

require_permission('forex.compliance.view');

$pdo = db();
$id = isset($_GET['id']) ? (int) $_GET['id'] : null;

if ($id) {
    $stmt = $pdo->prepare(
        'SELECT fr.*, c.first_name, c.last_name, c.passport_number_encrypted, c.pan_number_encrypted
         FROM forex_requests fr JOIN customers c ON c.id = fr.customer_id
         WHERE fr.id = :id'
    );
    $stmt->execute(['id' => $id]);
    $request = $stmt->fetch();
    if (!$request) {
        flash_set('admin_error', 'Forex request not found.');
        redirect('/admin/forex-fema-audit/');
    }

    $docsStmt = $pdo->prepare('SELECT * FROM forex_documents WHERE forex_request_id = :id AND is_current = 1');
    $docsStmt->execute(['id' => $id]);
    $documents = $docsStmt->fetchAll();

    $quotationsStmt = $pdo->prepare('SELECT * FROM forex_quotations WHERE forex_request_id = :id ORDER BY id');
    $quotationsStmt->execute(['id' => $id]);
    $quotations = $quotationsStmt->fetchAll();

    $paymentsStmt = $pdo->prepare('SELECT * FROM forex_payments WHERE forex_request_id = :id ORDER BY id');
    $paymentsStmt->execute(['id' => $id]);
    $payments = $paymentsStmt->fetchAll();

    $deliveryStmt = $pdo->prepare('SELECT d.*, u.full_name AS delivered_by_name FROM forex_deliveries d LEFT JOIN admin_users u ON u.id = d.delivered_by WHERE forex_request_id = :id LIMIT 1');
    $deliveryStmt->execute(['id' => $id]);
    $delivery = $deliveryStmt->fetch();

    $historyStmt = $pdo->prepare('SELECT h.*, u.full_name AS changed_by_name FROM forex_status_history h LEFT JOIN admin_users u ON u.id = h.changed_by WHERE forex_request_id = :id ORDER BY h.created_at');
    $historyStmt->execute(['id' => $id]);
    $history = $historyStmt->fetchAll();

    $approvalsStmt = $pdo->prepare('SELECT a.*, u.full_name AS approver_name FROM forex_approvals a LEFT JOIN admin_users u ON u.id = a.approver_id WHERE forex_request_id = :id ORDER BY a.created_at');
    $approvalsStmt->execute(['id' => $id]);
    $approvals = $approvalsStmt->fetchAll();

    admin_header_start('FEMA / Audit Record — ' . $request['forex_reference_no'], 'forex-fema-audit');
    ?>
    <div class="alert alert-info">This is a permanent compliance record-management view, not a legal determination of FEMA/RBI compliance. Final regulatory requirements should be reviewed by the company's authorized compliance/legal professional.</div>
    <div class="card" style="margin-bottom:var(--space-5)">
        <div class="card-title">Transaction Summary</div>
        <p><strong>Reference:</strong> <?= e($request['forex_reference_no']) ?> &middot; <strong>Status:</strong> <?= e(forex_status_labels()[$request['status']] ?? $request['status']) ?></p>
        <p><strong>Customer:</strong> <?= e(trim($request['first_name'] . ' ' . ($request['last_name'] ?? ''))) ?></p>
        <p><strong>Passport:</strong> <?= e(decrypt_value($request['passport_number_encrypted']) ?? 'Not on file') ?> &middot; <strong>PAN:</strong> <?= e(decrypt_value($request['pan_number_encrypted']) ?? 'Not on file') ?></p>
        <p><strong>Country:</strong> <?= e($request['country_of_visit']) ?> &middot; <strong>Purpose:</strong> <?= e(ucwords(str_replace('_', ' ', $request['purpose_of_travel']))) ?></p>
        <p><strong>Currency/Amount:</strong> <?= e($request['currency_code']) ?> <?= e(number_format((float) $request['amount_required'], 2)) ?></p>
    </div>

    <div class="card" style="margin-bottom:var(--space-5)">
        <div class="card-title">Documents</div>
        <?php foreach ($documents as $doc): ?>
        <p><?= e(FOREX_DOCUMENT_TYPE_LABELS[$doc['document_type']] ?? $doc['document_type']) ?> — <span class="badge <?= $doc['verification_status'] === 'verified' ? 'badge-success' : 'badge-warning' ?>"><?= e(ucfirst($doc['verification_status'])) ?></span> (uploaded <?= e(date('d M Y', strtotime((string) $doc['uploaded_at']))) ?>)</p>
        <?php endforeach; ?>
        <?php if (!$documents): ?><p class="empty-state">No documents on file.</p><?php endif; ?>
    </div>

    <div class="card" style="margin-bottom:var(--space-5)">
        <div class="card-title">Quotations</div>
        <?php foreach ($quotations as $q): ?>
        <p><?= e($q['currency_code']) ?> <?= e(number_format((float) $q['currency_amount'], 2)) ?> @ ₹<?= e(number_format((float) $q['exchange_rate'], 4)) ?> = ₹<?= e(number_format((float) $q['total_inr_amount'], 2)) ?> — <span class="badge badge-info"><?= e(ucfirst($q['status'])) ?></span></p>
        <?php endforeach; ?>
        <?php if (!$quotations): ?><p class="empty-state">No quotation on file.</p><?php endif; ?>
    </div>

    <div class="card" style="margin-bottom:var(--space-5)">
        <div class="card-title">Payments</div>
        <?php foreach ($payments as $p): ?>
        <p><?= e(ucwords(str_replace('_', ' ', $p['status']))) ?><?= $p['amount_paid'] ? ' — ₹' . e(number_format((float) $p['amount_paid'], 2)) : '' ?><?= $p['payment_date'] ? ' on ' . e(date('d M Y', strtotime((string) $p['payment_date']))) : '' ?></p>
        <?php endforeach; ?>
        <?php if (!$payments): ?><p class="empty-state">No payment on file.</p><?php endif; ?>
    </div>

    <div class="card" style="margin-bottom:var(--space-5)">
        <div class="card-title">Delivery</div>
        <?php if ($delivery): ?>
        <p>Delivered <?= e(date('d M Y H:i', strtotime((string) $delivery['delivered_at']))) ?> by <?= e($delivery['delivered_by_name'] ?? '—') ?> to <?= e($delivery['received_by']) ?> — acknowledged: <?= (int) $delivery['customer_acknowledged'] === 1 ? 'Yes' : 'No' ?></p>
        <?php else: ?>
        <p class="empty-state">Not yet delivered.</p>
        <?php endif; ?>
    </div>

    <div class="card">
        <div class="card-title">Status History &amp; Approvals</div>
        <ul class="hrms-timeline">
            <?php foreach ($history as $h): ?>
            <li><time><?= e(date('d M Y H:i', strtotime((string) $h['created_at']))) ?></time><?= e($h['from_status'] ?? 'none') ?> → <?= e($h['to_status']) ?> by <?= e($h['changed_by_name'] ?? 'System') ?><?= $h['remarks'] ? ' — ' . e($h['remarks']) : '' ?></li>
            <?php endforeach; ?>
            <?php foreach ($approvals as $a): ?>
            <li><time><?= e(date('d M Y H:i', strtotime((string) $a['created_at']))) ?></time><?= e(ucwords(str_replace('_', ' ', $a['action']))) ?> by <?= e($a['approver_name'] ?? 'System') ?><?= $a['remarks'] ? ' — ' . e($a['remarks']) : '' ?></li>
            <?php endforeach; ?>
        </ul>
    </div>
    <p style="margin-top:var(--space-4)"><a href="/admin/forex-fema-audit/">&larr; Back to all records</a></p>
    <?php
    admin_header_end();
    exit;
}

$search = trim((string) ($_GET['q'] ?? ''));
$where = [];
$params = [];
if ($search !== '') {
    // PDO with real (non-emulated) prepared statements does not
    // support the same named placeholder appearing more than once in
    // a query — each occurrence needs its own key bound to the same
    // value.
    $where[] = "(fr.forex_reference_no LIKE :search1 OR c.first_name LIKE :search2 OR c.last_name LIKE :search3)";
    $searchTerm = "%$search%";
    $params['search1'] = $params['search2'] = $params['search3'] = $searchTerm;
}
$whereSql = $where ? ('WHERE ' . implode(' AND ', $where)) : '';

$requests = $pdo->prepare(
    "SELECT fr.id, fr.forex_reference_no, fr.status, fr.country_of_visit, fr.currency_code, fr.amount_required, fr.created_at, c.first_name, c.last_name
     FROM forex_requests fr JOIN customers c ON c.id = fr.customer_id
     $whereSql ORDER BY fr.created_at DESC LIMIT 100"
);
$requests->execute($params);
$requests = $requests->fetchAll();

admin_header_start('FEMA / Audit Records', 'forex-fema-audit');
?>
<div class="alert alert-info">Permanent compliance records for every forex transaction. This is a record-management tool, not a legal determination of FEMA/RBI compliance.</div>
<form method="get" action="/admin/forex-fema-audit/" style="margin-bottom:var(--space-5)">
    <input class="form-input" type="search" name="q" value="<?= e($search) ?>" placeholder="Reference or customer name…" style="max-width:400px">
    <button type="submit" class="btn btn-outline">Search</button>
</form>
<table class="admin-table">
    <thead><tr><th>Reference</th><th>Customer</th><th>Country</th><th>Currency</th><th>Status</th><th>Date</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($requests as $r): ?>
        <tr>
            <td><?= e($r['forex_reference_no']) ?></td>
            <td><?= e(trim($r['first_name'] . ' ' . ($r['last_name'] ?? ''))) ?></td>
            <td><?= e($r['country_of_visit']) ?></td>
            <td><?= e($r['currency_code']) ?> <?= e(number_format((float) $r['amount_required'], 2)) ?></td>
            <td><span class="badge badge-info"><?= e(forex_status_labels()[$r['status']] ?? $r['status']) ?></span></td>
            <td><?= e(date('d M Y', strtotime((string) $r['created_at']))) ?></td>
            <td class="actions"><a href="/admin/forex-fema-audit/?id=<?= (int) $r['id'] ?>" class="btn btn-outline btn-sm">View Record</a></td>
        </tr>
    <?php endforeach; ?>
    <?php if (!$requests): ?><tr><td colspan="7"><p class="empty-state">No forex transactions yet.</p></td></tr><?php endif; ?>
    </tbody>
</table>
<?php
admin_header_end();
