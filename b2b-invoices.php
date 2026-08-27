<?php
$PP_PAGE_TITLE = 'Invoices & Payments';
$PP_ACTIVE_NAV = 'invoices';
require __DIR__ . '/includes/partner-layout-top.php';

$pid = partner_id();

$stmt = $pdo->prepare('SELECT i.*, (SELECT COALESCE(SUM(amount), 0) FROM b2b_invoice_payments WHERE invoice_id = i.id) AS paid_to_date
    FROM b2b_invoices i WHERE i.partner_id = ? ORDER BY i.created_at DESC');
$stmt->execute([$pid]);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

$outstandingTotal = 0;
$paidTotal = 0;
foreach ($rows as $r) {
    $balance = max(0, (float) $r['total'] - (float) $r['paid_to_date']);
    $outstandingTotal += $balance;
    $paidTotal += (float) $r['paid_to_date'];
}
?>
<div class="pp-page-header">
    <div>
        <h1 class="pp-page-title">Invoices &amp; Payments</h1>
        <p class="pp-page-subtitle">Invoices issued against your accepted quotations.</p>
    </div>
</div>

<div class="pp-kpi-grid" style="grid-template-columns:repeat(3,1fr);">
    <div class="pp-kpi"><div class="pp-kpi-value"><?php echo count($rows); ?></div><div class="pp-kpi-label">Total Invoices</div></div>
    <div class="pp-kpi"><div class="pp-kpi-value">&#8377;<?php echo number_format($outstandingTotal, 2); ?></div><div class="pp-kpi-label">Outstanding Balance</div></div>
    <div class="pp-kpi"><div class="pp-kpi-value">&#8377;<?php echo number_format($paidTotal, 2); ?></div><div class="pp-kpi-label">Paid to Date</div></div>
</div>

<div class="pp-card" style="padding:0;">
    <div class="pp-table-wrap">
    <table class="pp-table">
        <thead><tr><th>Invoice #</th><th>Total</th><th>Balance Due</th><th>Due Date</th><th>Status</th></tr></thead>
        <tbody>
        <?php foreach ($rows as $r): $balance = max(0, (float) $r['total'] - (float) $r['paid_to_date']); ?>
        <tr>
            <td class="pp-cell-name"><a href="b2b-invoice.php?id=<?php echo (int) $r['id']; ?>"><?php echo htmlspecialchars($r['invoice_number']); ?></a></td>
            <td>&#8377;<?php echo number_format((float) $r['total'], 2); ?></td>
            <td class="pp-cell-sub">&#8377;<?php echo number_format($balance, 2); ?></td>
            <td class="pp-cell-sub"><?php echo $r['due_date'] ? htmlspecialchars(substr($r['due_date'], 0, 10)) : '—'; ?></td>
            <td><span class="pp-status-badge <?php echo b2b_invoice_status_class($r['status']); ?>"><?php echo htmlspecialchars($r['status']); ?></span></td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$rows): ?>
        <tr><td colspan="5" class="pp-empty">No invoices yet.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/partner-layout-bottom.php'; ?>
