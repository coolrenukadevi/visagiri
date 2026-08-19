<?php
$ADMIN_PAGE_TITLE = 'Payments';
$ADMIN_ACTIVE_NAV = 'payments';
$ADMIN_BREADCRUMB = ['CRM', 'Payments'];
require __DIR__ . '/includes/layout-top.php';

if (!in_array(admin_role(), ['Super Admin', 'Admin', 'Accounts'], true)) {
    http_response_code(403);
    echo '<div class="crm-card">You do not have access to Payments.</div>';
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}

$dateFrom = trim($_GET['date_from'] ?? '');
$dateTo = trim($_GET['date_to'] ?? '');

$sql = "SELECT p.*, e.enquiry_ref, e.full_name, e.destination_country FROM payments p
    JOIN enquiries e ON e.id = p.enquiry_id WHERE 1=1";
$params = [];
if ($dateFrom !== '') { $sql .= ' AND p.payment_date >= :from'; $params['from'] = $dateFrom; }
if ($dateTo !== '') { $sql .= ' AND p.payment_date <= :to'; $params['to'] = $dateTo; }
$sql .= ' ORDER BY p.payment_date DESC, p.id DESC LIMIT 300';
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$payments = $stmt->fetchAll(PDO::FETCH_ASSOC);

$totalStmt = $pdo->prepare("SELECT COALESCE(SUM(p.amount),0) FROM payments p WHERE 1=1" .
    ($dateFrom !== '' ? ' AND p.payment_date >= :from' : '') . ($dateTo !== '' ? ' AND p.payment_date <= :to' : ''));
$totalStmt->execute($params);
$total = (float) $totalStmt->fetchColumn();

$pendingStmt = $pdo->query("SELECT COALESCE(SUM(MAX(quoted_amount - COALESCE(discount_amount,0) - COALESCE(paid_amount,0), 0)),0)
    FROM enquiries WHERE archived_at IS NULL AND quoted_amount IS NOT NULL");
$pendingTotal = (float) $pendingStmt->fetchColumn();
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Payments</h1>
        <p class="crm-page-subtitle">Every payment recorded against a visa enquiry.</p>
    </div>
</div>

<div class="crm-kpi-grid" style="grid-template-columns:repeat(2,1fr);">
    <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value">₹<?php echo number_format($total, 2); ?></div><div class="crm-kpi-label">Total Collected<?php echo ($dateFrom || $dateTo) ? ' (filtered)' : ''; ?></div></div>
    <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value" style="color:var(--c-amber);">₹<?php echo number_format($pendingTotal, 2); ?></div><div class="crm-kpi-label">Total Pending (all quoted enquiries)</div></div>
</div>

<form class="crm-card" method="get">
    <div class="crm-filter-bar">
        <label style="font-size:12.5px;color:var(--c-text);">From <input type="date" name="date_from" value="<?php echo htmlspecialchars($dateFrom); ?>"></label>
        <label style="font-size:12.5px;color:var(--c-text);">To <input type="date" name="date_to" value="<?php echo htmlspecialchars($dateTo); ?>"></label>
        <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Apply</button>
        <a href="payments.php" class="crm-btn crm-btn-ghost crm-btn-sm">Reset</a>
    </div>
</form>

<div class="crm-card" style="padding:0;">
    <?php if (empty($payments)): ?>
    <div class="crm-empty">No payments recorded yet.</div>
    <?php else: ?>
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Date</th><th>Customer</th><th>Enquiry</th><th>Amount</th><th>Method</th><th>Reference</th><th>Recorded By</th><th>Invoice</th></tr></thead>
        <tbody>
        <?php foreach ($payments as $p): ?>
        <tr>
            <td><?php echo htmlspecialchars($p['payment_date']); ?></td>
            <td class="crm-cell-name"><?php echo htmlspecialchars($p['full_name']); ?></td>
            <td><a href="enquiry.php?ref=<?php echo urlencode($p['enquiry_ref']); ?>"><?php echo htmlspecialchars($p['enquiry_ref']); ?></a></td>
            <td>₹<?php echo number_format((float) $p['amount'], 2); ?></td>
            <td><?php echo htmlspecialchars($p['payment_method'] ?: '—'); ?></td>
            <td><?php echo htmlspecialchars($p['reference_number'] ?: '—'); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($p['recorded_by']); ?></td>
            <td><a href="invoice.php?payment_id=<?php echo (int) $p['id']; ?>" target="_blank" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-file-invoice"></i> Invoice</a></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>
    <?php endif; ?>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
