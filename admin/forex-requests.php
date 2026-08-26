<?php
$ADMIN_PAGE_TITLE = 'Forex Requests';
$ADMIN_ACTIVE_NAV = 'forex-all';
$ADMIN_BREADCRUMB = ['CRM', 'Forex', 'All Requests'];
require __DIR__ . '/includes/layout-top.php';

$q = trim($_GET['q'] ?? '');
$statusFilter = trim($_GET['status'] ?? '');
$scopeSql = forex_can_view_all() ? '' : ' AND assigned_to = :me';
$scopeParams = forex_can_view_all() ? [] : ['me' => admin_name()];

$where = ['archived_at IS NULL'];
$params = $scopeParams;
if ($q !== '') {
    $where[] = '(forex_ref LIKE :q OR full_name LIKE :q OR mobile LIKE :q OR email LIKE :q OR passport_number LIKE :q)';
    $params['q'] = '%' . $q . '%';
}
if ($statusFilter !== '' && in_array($statusFilter, FOREX_STATUSES, true)) {
    $where[] = 'status = :status';
    $params['status'] = $statusFilter;
}
$whereSql = 'WHERE ' . implode(' AND ', $where) . $scopeSql;

$stmt = $pdo->prepare("SELECT * FROM forex_requests $whereSql ORDER BY created_at DESC LIMIT 300");
$stmt->execute($params);
$requests = $stmt->fetchAll(PDO::FETCH_ASSOC);

$totalStmt = $pdo->prepare("SELECT COUNT(*) FROM forex_requests WHERE archived_at IS NULL $scopeSql");
$totalStmt->execute($scopeParams);
$total = (int) $totalStmt->fetchColumn();
$openStmt = $pdo->prepare("SELECT COUNT(*) FROM forex_requests WHERE archived_at IS NULL AND status IN ('" . implode("','", FOREX_OPEN_STATUSES) . "')$scopeSql");
$openStmt->execute($scopeParams);
$open = (int) $openStmt->fetchColumn();
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Forex Requests</h1>
        <p class="crm-page-subtitle">All foreign currency purchase requests<?php echo forex_can_view_all() ? '' : ' assigned to you'; ?>.</p>
    </div>
    <div class="crm-page-actions">
        <a href="forex-request-new.php" class="crm-btn crm-btn-primary"><i class="fa-solid fa-plus"></i> New Forex Request</a>
    </div>
</div>

<div class="crm-kpi-grid" style="grid-template-columns:repeat(3,1fr);">
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $total; ?></div><div class="crm-kpi-label">Total Requests</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $open; ?></div><div class="crm-kpi-label">Open</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $total - $open; ?></div><div class="crm-kpi-label">Closed</div></div>
</div>

<form method="get" class="crm-filter-bar" style="margin-bottom:16px;">
    <input type="text" name="q" value="<?php echo htmlspecialchars($q); ?>" placeholder="Search ref, name, mobile, email, passport..." style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;min-width:260px;">
    <select name="status" onchange="this.form.submit()" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;">
        <option value="">All Statuses</option>
        <?php foreach (FOREX_STATUSES as $s): ?><option value="<?php echo htmlspecialchars($s); ?>" <?php echo $statusFilter === $s ? 'selected' : ''; ?>><?php echo htmlspecialchars($s); ?></option><?php endforeach; ?>
    </select>
    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Filter</button>
    <?php if ($q || $statusFilter): ?><a href="forex-requests.php" class="crm-btn crm-btn-ghost crm-btn-sm">Clear</a><?php endif; ?>
</form>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Ref</th><th>Customer</th><th>Destination</th><th>Currency</th><th>Amount</th><th>Visa Status</th><th>Status</th><th>Assigned</th><th>Created</th></tr></thead>
        <tbody>
        <?php foreach ($requests as $r): ?>
        <tr>
            <td class="crm-cell-name"><a href="forex-request.php?ref=<?php echo urlencode($r['forex_ref']); ?>"><?php echo htmlspecialchars($r['forex_ref']); ?></a></td>
            <td><?php echo htmlspecialchars($r['full_name']); ?><div class="crm-cell-sub"><?php echo htmlspecialchars($r['mobile']); ?></div></td>
            <td><?php echo htmlspecialchars($r['country_visit'] ?: '—'); ?></td>
            <td><?php echo htmlspecialchars($r['currency_code'] ?: '—'); ?></td>
            <td><?php echo number_format((float) $r['amount_required'], 2); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($r['visa_status'] ?: '—'); ?></td>
            <td><span class="crm-status-badge <?php echo forex_status_class($r['status']); ?>"><?php echo htmlspecialchars($r['status']); ?></span></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($r['assigned_to'] ?: '—'); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars(substr($r['created_at'], 0, 10)); ?></td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$requests): ?>
        <tr><td colspan="9" class="crm-empty">No forex requests yet.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
