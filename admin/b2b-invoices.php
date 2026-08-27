<?php
$ADMIN_PAGE_TITLE = 'B2B Invoices';
$ADMIN_ACTIVE_NAV = 'b2b-invoices';
$ADMIN_BREADCRUMB = ['CRM', 'B2B Partners', 'Invoices & Payments'];
require __DIR__ . '/includes/layout-top.php';

$statusFilter = trim($_GET['status'] ?? '');
$where = '1=1';
$params = [];
if ($statusFilter !== '' && in_array($statusFilter, B2B_INVOICE_STATUSES, true)) {
    $where = 'i.status = :status';
    $params['status'] = $statusFilter;
}
$stmt = $pdo->prepare("SELECT i.*, p.application_ref, p.company_name,
        (SELECT COALESCE(SUM(amount), 0) FROM b2b_invoice_payments WHERE invoice_id = i.id) AS paid_to_date
    FROM b2b_invoices i JOIN b2b_partners p ON p.id = i.partner_id WHERE $where ORDER BY i.created_at DESC LIMIT 300");
$stmt->execute($params);
$invoices = $stmt->fetchAll(PDO::FETCH_ASSOC);

$issuedCount = (int) $pdo->query("SELECT COUNT(*) FROM b2b_invoices WHERE status = 'Issued'")->fetchColumn();
$partialCount = (int) $pdo->query("SELECT COUNT(*) FROM b2b_invoices WHERE status = 'Partially Paid'")->fetchColumn();
$paidCount = (int) $pdo->query("SELECT COUNT(*) FROM b2b_invoices WHERE status = 'Paid'")->fetchColumn();
$outstandingTotal = (float) $pdo->query("SELECT COALESCE(SUM(total), 0) FROM b2b_invoices WHERE status IN ('Issued','Partially Paid','Overdue')")->fetchColumn();
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">B2B Invoices &amp; Payments</h1>
        <p class="crm-page-subtitle">Every invoice generated from an accepted quotation, across all partners.</p>
    </div>
</div>

<div class="crm-kpi-grid" style="grid-template-columns:repeat(4,1fr);">
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $issuedCount; ?></div><div class="crm-kpi-label">Issued</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $partialCount; ?></div><div class="crm-kpi-label">Partially Paid</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $paidCount; ?></div><div class="crm-kpi-label">Paid</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value">₹<?php echo number_format($outstandingTotal, 2); ?></div><div class="crm-kpi-label">Outstanding</div></div>
</div>

<div class="crm-filter-bar" style="margin-bottom:16px;">
    <?php foreach (['' => 'All'] + array_combine(B2B_INVOICE_STATUSES, B2B_INVOICE_STATUSES) as $val => $label): ?>
    <a href="b2b-invoices.php<?php echo $val !== '' ? '?status=' . urlencode($val) : ''; ?>" class="crm-btn crm-btn-sm <?php echo $statusFilter === $val ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>"><?php echo htmlspecialchars($label); ?></a>
    <?php endforeach; ?>
</div>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Invoice #</th><th>Partner</th><th>Total</th><th>Paid</th><th>Balance</th><th>Due Date</th><th>Status</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($invoices as $inv): $balance = max(0, (float) $inv['total'] - (float) $inv['paid_to_date']); ?>
        <tr>
            <td class="crm-cell-name"><a href="b2b-partner.php?ref=<?php echo urlencode($inv['application_ref']); ?>&tab=invoices"><?php echo htmlspecialchars($inv['invoice_number']); ?></a></td>
            <td><?php echo htmlspecialchars($inv['company_name']); ?></td>
            <td>₹<?php echo number_format((float) $inv['total'], 2); ?></td>
            <td class="crm-cell-sub">₹<?php echo number_format((float) $inv['paid_to_date'], 2); ?></td>
            <td class="crm-cell-sub">₹<?php echo number_format($balance, 2); ?></td>
            <td class="crm-cell-sub"><?php echo $inv['due_date'] ? htmlspecialchars(substr($inv['due_date'], 0, 10)) : '—'; ?></td>
            <td><span class="crm-status-badge <?php echo b2b_invoice_status_class($inv['status']); ?>"><?php echo htmlspecialchars($inv['status']); ?></span></td>
            <td><a href="b2b-invoice-pdf.php?id=<?php echo (int) $inv['id']; ?>" target="_blank" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-file-pdf"></i></a></td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$invoices): ?>
        <tr><td colspan="8" class="crm-empty">No invoices match this filter.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
