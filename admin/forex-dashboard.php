<?php
$ADMIN_PAGE_TITLE = 'Forex Dashboard';
$ADMIN_ACTIVE_NAV = 'forex-dashboard';
$ADMIN_BREADCRUMB = ['CRM', 'Forex', 'Dashboard'];
require __DIR__ . '/includes/layout-top.php';

$scopeSql = forex_can_view_all() ? '' : ' AND assigned_to = :me';
$scopeParams = forex_can_view_all() ? [] : ['me' => admin_name()];

function forex_count(PDO $pdo, string $where, array $params = []): int
{
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM forex_requests WHERE archived_at IS NULL $where");
    $stmt->execute($params);
    return (int) $stmt->fetchColumn();
}

$totalCount = forex_count($pdo, $scopeSql, $scopeParams);
$newCount = forex_count($pdo, "AND status = 'New Request'" . $scopeSql, $scopeParams);
$docsPendingCount = forex_count($pdo, "AND status IN ('Awaiting Documents','Documents Submitted','Documents Under Verification')" . $scopeSql, $scopeParams);
$quotationCount = forex_count($pdo, "AND status IN ('Quotation Preparing','Quotation Sent')" . $scopeSql, $scopeParams);
$paymentPendingCount = forex_count($pdo, "AND status IN ('Customer Accepted','Payment Pending')" . $scopeSql, $scopeParams);
$approvedCount = forex_count($pdo, "AND status IN ('Compliance Verification','Approved for Processing','Forex Procurement / Processing')" . $scopeSql, $scopeParams);
$readyCount = forex_count($pdo, "AND status = 'Ready for Delivery'" . $scopeSql, $scopeParams);
$deliveredCount = forex_count($pdo, "AND status = 'Delivered'" . $scopeSql, $scopeParams);

$monthStart = gmdate('Y-m-01');
$deliveredValueStmt = $pdo->prepare("SELECT COALESCE(SUM(approx_inr),0) FROM forex_requests WHERE status = 'Delivered' AND updated_at >= ?" . $scopeSql);
$deliveredValueStmt->execute(array_merge([$monthStart], $scopeParams));
$deliveredValueMonth = (float) $deliveredValueStmt->fetchColumn();
$deliveredValueDisplay = $deliveredValueMonth >= 100000 ? '₹' . round($deliveredValueMonth / 100000, 1) . 'L' : '₹' . number_format($deliveredValueMonth);

$kpis = [
    ['label' => 'Total Requests', 'value' => $totalCount, 'icon' => 'money-bill-transfer', 'filter' => ''],
    ['label' => 'New', 'value' => $newCount, 'icon' => 'sparkles', 'filter' => 'New Request'],
    ['label' => 'Documents Pending', 'value' => $docsPendingCount, 'icon' => 'file-circle-exclamation', 'filter' => 'Awaiting Documents'],
    ['label' => 'Quotation Stage', 'value' => $quotationCount, 'icon' => 'file-invoice-dollar', 'filter' => 'Quotation Sent'],
    ['label' => 'Payment Pending', 'value' => $paymentPendingCount, 'icon' => 'credit-card', 'filter' => 'Payment Pending'],
    ['label' => 'Approved / Processing', 'value' => $approvedCount, 'icon' => 'circle-check', 'filter' => 'Approved for Processing'],
    ['label' => 'Ready for Delivery', 'value' => $readyCount, 'icon' => 'box-open', 'filter' => 'Ready for Delivery'],
    ['label' => 'Delivered (All Time)', 'value' => $deliveredCount, 'icon' => 'hand-holding-dollar', 'filter' => 'Delivered'],
];

// ---- Filters ----
$fDateFrom = trim($_GET['date_from'] ?? '');
$fDateTo = trim($_GET['date_to'] ?? '');
$fCurrency = trim($_GET['currency'] ?? '');
$fCountry = trim($_GET['country'] ?? '');
$fEmployee = trim($_GET['employee'] ?? '');
$fStatus = trim($_GET['status'] ?? '');
$fQ = trim($_GET['q'] ?? '');

$where = ['archived_at IS NULL'];
$params = $scopeParams;
if ($fDateFrom !== '') { $where[] = 'date(created_at) >= :date_from'; $params['date_from'] = $fDateFrom; }
if ($fDateTo !== '') { $where[] = 'date(created_at) <= :date_to'; $params['date_to'] = $fDateTo; }
if ($fCurrency !== '') { $where[] = 'currency_code = :currency'; $params['currency'] = $fCurrency; }
if ($fCountry !== '') { $where[] = 'country_visit = :country'; $params['country'] = $fCountry; }
if ($fEmployee !== '') { $where[] = 'assigned_to = :employee'; $params['employee'] = $fEmployee; }
if ($fStatus !== '' && in_array($fStatus, FOREX_STATUSES, true)) { $where[] = 'status = :status'; $params['status'] = $fStatus; }
if ($fQ !== '') {
    $where[] = '(forex_ref LIKE :q OR full_name LIKE :q OR mobile LIKE :q OR email LIKE :q OR passport_number LIKE :q)';
    $params['q'] = '%' . $fQ . '%';
}
$whereSql = 'WHERE ' . implode(' AND ', $where) . $scopeSql;

$listStmt = $pdo->prepare("SELECT * FROM forex_requests $whereSql ORDER BY created_at DESC LIMIT 200");
$listStmt->execute($params);
$filteredRequests = $listStmt->fetchAll(PDO::FETCH_ASSOC);

$currencies = $pdo->query("SELECT DISTINCT currency_code FROM forex_requests WHERE currency_code IS NOT NULL AND currency_code != '' ORDER BY currency_code")->fetchAll(PDO::FETCH_COLUMN);
$countries = $pdo->query("SELECT DISTINCT country_visit FROM forex_requests WHERE country_visit IS NOT NULL AND country_visit != '' ORDER BY country_visit")->fetchAll(PDO::FETCH_COLUMN);
$employees = $pdo->query("SELECT DISTINCT assigned_to FROM forex_requests WHERE assigned_to IS NOT NULL AND assigned_to != '' ORDER BY assigned_to")->fetchAll(PDO::FETCH_COLUMN);
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Forex Dashboard</h1>
        <p class="crm-page-subtitle">Overview of all foreign currency purchase requests<?php echo forex_can_view_all() ? '' : ' assigned to you'; ?>.</p>
    </div>
    <div class="crm-page-actions">
        <a href="forex-request-new.php" class="crm-btn crm-btn-primary"><i class="fa-solid fa-plus"></i> New Forex Request</a>
    </div>
</div>

<div class="crm-kpi-grid">
    <?php foreach ($kpis as $k): ?>
    <a class="crm-kpi" href="forex-requests.php<?php echo $k['filter'] ? '?status=' . urlencode($k['filter']) : ''; ?>">
        <div class="crm-kpi-top">
            <div class="crm-kpi-icon"><i class="fa-solid fa-<?php echo $k['icon']; ?>"></i></div>
        </div>
        <div class="crm-kpi-value"><?php echo $k['value']; ?></div>
        <div class="crm-kpi-label"><?php echo $k['label']; ?></div>
    </a>
    <?php endforeach; ?>
    <div class="crm-kpi">
        <div class="crm-kpi-top"><div class="crm-kpi-icon"><i class="fa-solid fa-sack-dollar"></i></div></div>
        <div class="crm-kpi-value"><?php echo $deliveredValueDisplay; ?></div>
        <div class="crm-kpi-label">Delivered This Month (Approx INR)</div>
    </div>
</div>

<form method="get" class="crm-filter-bar" style="margin-bottom:16px;flex-wrap:wrap;gap:8px;">
    <input type="text" name="q" value="<?php echo htmlspecialchars($fQ); ?>" placeholder="Search ref, name, mobile, email, passport..." style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;min-width:220px;">
    <input type="date" name="date_from" value="<?php echo htmlspecialchars($fDateFrom); ?>" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;" title="Created from">
    <input type="date" name="date_to" value="<?php echo htmlspecialchars($fDateTo); ?>" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;" title="Created to">
    <select name="currency" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;">
        <option value="">All Currencies</option>
        <?php foreach ($currencies as $c): ?><option value="<?php echo htmlspecialchars($c); ?>" <?php echo $fCurrency === $c ? 'selected' : ''; ?>><?php echo htmlspecialchars($c); ?></option><?php endforeach; ?>
    </select>
    <select name="country" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;">
        <option value="">All Countries</option>
        <?php foreach ($countries as $c): ?><option value="<?php echo htmlspecialchars($c); ?>" <?php echo $fCountry === $c ? 'selected' : ''; ?>><?php echo htmlspecialchars($c); ?></option><?php endforeach; ?>
    </select>
    <select name="employee" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;">
        <option value="">All Employees</option>
        <?php foreach ($employees as $e): ?><option value="<?php echo htmlspecialchars($e); ?>" <?php echo $fEmployee === $e ? 'selected' : ''; ?>><?php echo htmlspecialchars($e); ?></option><?php endforeach; ?>
    </select>
    <select name="status" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;">
        <option value="">All Statuses</option>
        <?php foreach (FOREX_STATUSES as $s): ?><option value="<?php echo htmlspecialchars($s); ?>" <?php echo $fStatus === $s ? 'selected' : ''; ?>><?php echo htmlspecialchars($s); ?></option><?php endforeach; ?>
    </select>
    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Filter</button>
    <?php if ($fQ || $fDateFrom || $fDateTo || $fCurrency || $fCountry || $fEmployee || $fStatus): ?><a href="forex-dashboard.php" class="crm-btn crm-btn-ghost crm-btn-sm">Clear</a><?php endif; ?>
</form>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Ref</th><th>Customer</th><th>Destination</th><th>Currency</th><th>Amount</th><th>Status</th><th>Assigned</th><th>Created</th></tr></thead>
        <tbody>
        <?php foreach ($filteredRequests as $r): ?>
        <tr>
            <td class="crm-cell-name"><a href="forex-request.php?ref=<?php echo urlencode($r['forex_ref']); ?>"><?php echo htmlspecialchars($r['forex_ref']); ?></a></td>
            <td><?php echo htmlspecialchars($r['full_name']); ?><div class="crm-cell-sub"><?php echo htmlspecialchars($r['mobile']); ?></div></td>
            <td><?php echo htmlspecialchars($r['country_visit'] ?: '—'); ?></td>
            <td><?php echo htmlspecialchars($r['currency_code'] ?: '—'); ?></td>
            <td><?php echo number_format((float) $r['amount_required'], 2); ?></td>
            <td><span class="crm-status-badge <?php echo forex_status_class($r['status']); ?>"><?php echo htmlspecialchars($r['status']); ?></span></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($r['assigned_to'] ?: '—'); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars(substr($r['created_at'], 0, 10)); ?></td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$filteredRequests): ?>
        <tr><td colspan="8" class="crm-empty">No forex requests match these filters.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
