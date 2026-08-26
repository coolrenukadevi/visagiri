<?php
ob_start();
$ADMIN_PAGE_TITLE = 'Forex Quotations';
$ADMIN_ACTIVE_NAV = 'forex-quotations';
$ADMIN_BREADCRUMB = ['CRM', 'Forex', 'Quotations'];
require __DIR__ . '/includes/layout-top.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';
    $quotationId = (int) ($_POST['quotation_id'] ?? 0);

    if ($quotationId) {
        $qStmt = $pdo->prepare('SELECT q.*, r.forex_ref FROM forex_quotations q JOIN forex_requests r ON r.id = q.forex_request_id WHERE q.id = ?');
        $qStmt->execute([$quotationId]);
        $quotation = $qStmt->fetch(PDO::FETCH_ASSOC);

        if ($quotation) {
            $now = gmdate('c');
            if ($action === 'approve' && forex_can_approve_quotation() && $quotation['status'] === 'Draft') {
                $remarks = trim($_POST['remarks'] ?? '');
                $pdo->prepare("UPDATE forex_quotations SET status = 'Sent' WHERE id = ?")->execute([$quotationId]);
                $pdo->prepare("UPDATE forex_requests SET status = 'Quotation Sent', updated_at = ? WHERE id = ?")->execute([$now, $quotation['forex_request_id']]);
                $pdo->prepare('INSERT INTO forex_approvals (forex_request_id, quotation_id, action, approver, previous_value, new_value, remarks, ip_address, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)')
                    ->execute([$quotation['forex_request_id'], $quotationId, 'Quotation Approved', admin_name(), 'Draft', 'Sent', $remarks, $_SERVER['REMOTE_ADDR'] ?? null, $now]);
                forex_log_status_change($pdo, $quotation['forex_request_id'], 'Quotation Preparing', 'Quotation Sent', admin_name(), 'Quotation approved and sent.');
                forex_log_audit($pdo, $quotation['forex_request_id'], admin_name(), admin_role(), 'Approved quotation', 'Draft', 'Sent');
                forex_notify($pdo, null, 'forex_quotation_ready', "Forex quotation approved and sent on {$quotation['forex_ref']}: ₹" . number_format((float) $quotation['total_inr'], 2) . '.', $quotation['forex_request_id']);
                $qReqStmt = $pdo->prepare('SELECT * FROM forex_requests WHERE id = ?');
                $qReqStmt->execute([$quotation['forex_request_id']]);
                $qRequest = $qReqStmt->fetch(PDO::FETCH_ASSOC);
                if ($qRequest) {
                    forex_notify_customer(
                        $pdo, $qRequest, "Your Forex Quotation is Ready — {$quotation['forex_ref']}",
                        "Dear {$qRequest['full_name']},\n\nYour forex quotation has been approved and is ready:\n{$quotation['currency_code']} " . number_format((float) $quotation['currency_amount'], 2) . " for Rs. " . number_format((float) $quotation['total_inr'], 2) . "\n\nReference: {$quotation['forex_ref']}\n\nOur team will share the detailed quotation with you shortly. Track your request at https://visaagency.in/forex-track\n\nRegards,\nVisaAgency.in"
                    );
                }
            } elseif ($action === 'mark_accepted' && forex_can_verify_documents() && $quotation['status'] === 'Sent') {
                $pdo->prepare("UPDATE forex_quotations SET status = 'Accepted' WHERE id = ?")->execute([$quotationId]);
                $pdo->prepare("UPDATE forex_requests SET status = 'Customer Accepted', updated_at = ? WHERE id = ?")->execute([$now, $quotation['forex_request_id']]);
                forex_log_status_change($pdo, $quotation['forex_request_id'], $quotation['status'], 'Customer Accepted', admin_name(), 'Customer accepted the quotation.');
                forex_log_audit($pdo, $quotation['forex_request_id'], admin_name(), admin_role(), 'Marked quotation accepted by customer');
            }
        }
        $returnUrl = trim($_POST['return_url'] ?? '');
        if ($returnUrl !== '' && preg_match('#^forex-request\.php\?ref=[A-Za-z0-9\-]+$#', $returnUrl)) {
            header('Location: ' . $returnUrl . '#quotations');
            exit;
        }
    }
    header('Location: forex-quotations.php');
    exit;
}

$statusFilter = trim($_GET['status'] ?? '');
$where = '1=1';
$params = [];
if ($statusFilter !== '' && in_array($statusFilter, FOREX_QUOTATION_STATUSES, true)) {
    $where = 'q.status = :status';
    $params['status'] = $statusFilter;
}
$stmt = $pdo->prepare("SELECT q.*, r.forex_ref, r.full_name FROM forex_quotations q JOIN forex_requests r ON r.id = q.forex_request_id WHERE $where ORDER BY q.created_at DESC LIMIT 300");
$stmt->execute($params);
$quotations = $stmt->fetchAll(PDO::FETCH_ASSOC);

$draftCount = (int) $pdo->query("SELECT COUNT(*) FROM forex_quotations WHERE status = 'Draft'")->fetchColumn();
$sentCount = (int) $pdo->query("SELECT COUNT(*) FROM forex_quotations WHERE status = 'Sent'")->fetchColumn();
$acceptedCount = (int) $pdo->query("SELECT COUNT(*) FROM forex_quotations WHERE status = 'Accepted'")->fetchColumn();
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Forex Quotations</h1>
        <p class="crm-page-subtitle">Every quotation preserves the exact rate and charges used at creation — updating master rates never changes an existing quotation.</p>
    </div>
</div>

<div class="crm-kpi-grid" style="grid-template-columns:repeat(3,1fr);">
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $draftCount; ?></div><div class="crm-kpi-label">Awaiting Approval</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $sentCount; ?></div><div class="crm-kpi-label">Sent</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $acceptedCount; ?></div><div class="crm-kpi-label">Accepted</div></div>
</div>

<div class="crm-filter-bar" style="margin-bottom:16px;">
    <?php foreach (['' => 'All'] + array_combine(FOREX_QUOTATION_STATUSES, FOREX_QUOTATION_STATUSES) as $val => $label): ?>
    <a href="forex-quotations.php<?php echo $val !== '' ? '?status=' . urlencode($val) : ''; ?>" class="crm-btn crm-btn-sm <?php echo $statusFilter === $val ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>"><?php echo htmlspecialchars($label); ?></a>
    <?php endforeach; ?>
</div>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Request</th><th>Customer</th><th>Currency</th><th>Rate</th><th>Total</th><th>Rate Type</th><th>Status</th><th>Created</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($quotations as $q): ?>
        <tr>
            <td class="crm-cell-name"><a href="forex-request.php?ref=<?php echo urlencode($q['forex_ref']); ?>#quotations"><?php echo htmlspecialchars($q['forex_ref']); ?></a></td>
            <td><?php echo htmlspecialchars($q['full_name']); ?></td>
            <td><?php echo htmlspecialchars($q['currency_code']); ?> <?php echo number_format((float) $q['currency_amount'], 2); ?></td>
            <td class="crm-cell-sub">₹<?php echo number_format((float) $q['exchange_rate'], 4); ?></td>
            <td>₹<?php echo number_format((float) $q['total_inr'], 2); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($q['rate_type']); ?></td>
            <td><span class="crm-status-badge" style="background:var(--c-bg);color:var(--c-text);"><?php echo htmlspecialchars($q['status']); ?></span></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars(substr($q['created_at'], 0, 10)); ?></td>
            <td>
                <?php if ($q['status'] === 'Draft' && forex_can_approve_quotation()): ?>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="action" value="approve">
                    <input type="hidden" name="quotation_id" value="<?php echo (int) $q['id']; ?>">
                    <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Approve</button>
                </form>
                <?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$quotations): ?>
        <tr><td colspan="9" class="crm-empty">No quotations match this filter.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
