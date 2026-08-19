<?php
$ADMIN_PAGE_TITLE = 'Reports';
$ADMIN_ACTIVE_NAV = 'reports';
$ADMIN_BREADCRUMB = ['CRM', 'Reports'];
require __DIR__ . '/includes/layout-top.php';

if (!in_array(admin_role(), ['Super Admin', 'Admin', 'Sales Manager'], true)) {
    http_response_code(403);
    echo '<div class="crm-card">You do not have access to Reports.</div>';
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}

$range = trim($_GET['range'] ?? '30d');
$customFrom = trim($_GET['from'] ?? '');
$customTo = trim($_GET['to'] ?? '');

$today = gmdate('Y-m-d');
switch ($range) {
    case '7d': $from = gmdate('Y-m-d', strtotime('-7 days')); $to = $today; break;
    case '90d': $from = gmdate('Y-m-d', strtotime('-90 days')); $to = $today; break;
    case 'year': $from = gmdate('Y-01-01'); $to = $today; break;
    case 'custom': $from = $customFrom ?: gmdate('Y-m-d', strtotime('-30 days')); $to = $customTo ?: $today; break;
    default: $range = '30d'; $from = gmdate('Y-m-d', strtotime('-30 days')); $to = $today;
}

$dateCond = 'date(created_at) BETWEEN :from AND :to';
$dateParams = ['from' => $from, 'to' => $to];

function crmAgg(PDO $pdo, string $groupCol, string $dateCond, array $params): array
{
    $stmt = $pdo->prepare("SELECT $groupCol AS k, COUNT(*) AS c FROM enquiries
        WHERE archived_at IS NULL AND $dateCond GROUP BY $groupCol ORDER BY c DESC LIMIT 10");
    $stmt->execute($params);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

$byCountry = crmAgg($pdo, 'destination_country', $dateCond, $dateParams);
$byVisaType = crmAgg($pdo, 'visa_category', $dateCond, $dateParams);
$bySource = crmAgg($pdo, 'source', $dateCond, $dateParams);

$totalStmt = $pdo->prepare("SELECT COUNT(*) FROM enquiries WHERE archived_at IS NULL AND $dateCond");
$totalStmt->execute($dateParams);
$totalInRange = (int) $totalStmt->fetchColumn();

$approvedStmt = $pdo->prepare("SELECT COUNT(*) FROM enquiries WHERE archived_at IS NULL AND status = 'Visa Approved' AND $dateCond");
$approvedStmt->execute($dateParams);
$approvedInRange = (int) $approvedStmt->fetchColumn();

$rejectedStmt = $pdo->prepare("SELECT COUNT(*) FROM enquiries WHERE archived_at IS NULL AND status = 'Visa Rejected' AND $dateCond");
$rejectedStmt->execute($dateParams);
$rejectedInRange = (int) $rejectedStmt->fetchColumn();

$lostStmt = $pdo->prepare("SELECT COUNT(*) FROM enquiries WHERE archived_at IS NULL AND status = 'Lost' AND $dateCond");
$lostStmt->execute($dateParams);
$lostInRange = (int) $lostStmt->fetchColumn();

$conversionRate = $totalInRange > 0 ? round(($approvedInRange / $totalInRange) * 100, 1) : 0.0;

$revenueStmt = $pdo->prepare('SELECT COALESCE(SUM(amount),0) FROM payments WHERE payment_date BETWEEN :from AND :to');
$revenueStmt->execute($dateParams);
$revenueInRange = (float) $revenueStmt->fetchColumn();

$pendingDocsStmt = $pdo->prepare("SELECT COUNT(*) FROM enquiry_documents d JOIN enquiries e ON e.id = d.enquiry_id
    WHERE d.status IN ('Pending','Uploaded') AND e.archived_at IS NULL");
$pendingDocsStmt->execute();
$pendingDocsCount = (int) $pendingDocsStmt->fetchColumn();

$fuCompletedStmt = $pdo->prepare("SELECT COUNT(*) FROM follow_ups WHERE completed_at IS NOT NULL AND date(created_at) BETWEEN :from AND :to");
$fuCompletedStmt->execute($dateParams);
$fuCompleted = (int) $fuCompletedStmt->fetchColumn();
$fuOverdueStmt = $pdo->prepare("SELECT COUNT(*) FROM follow_ups f JOIN enquiries e ON e.id = f.enquiry_id
    WHERE f.completed_at IS NULL AND f.follow_up_date < :today AND e.archived_at IS NULL");
$fuOverdueStmt->execute(['today' => $today]);
$fuOverdue = (int) $fuOverdueStmt->fetchColumn();

$empStmt = $pdo->prepare("SELECT assigned_to AS name, COUNT(*) AS total,
        SUM(CASE WHEN status = 'Visa Approved' THEN 1 ELSE 0 END) AS converted
    FROM enquiries WHERE archived_at IS NULL AND assigned_to IS NOT NULL AND assigned_to != '' AND $dateCond
    GROUP BY assigned_to ORDER BY total DESC");
$empStmt->execute($dateParams);
$employeePerformance = $empStmt->fetchAll(PDO::FETCH_ASSOC);

$monthlyStmt = $pdo->prepare("SELECT strftime('%Y-%m', created_at) AS ym, COUNT(*) AS c FROM enquiries
    WHERE archived_at IS NULL AND created_at >= :monthsAgo GROUP BY ym ORDER BY ym ASC");
$monthlyStmt->execute(['monthsAgo' => gmdate('Y-m-d', strtotime('-11 months'))]);
$monthly = $monthlyStmt->fetchAll(PDO::FETCH_ASSOC);
$monthlyMax = 1;
foreach ($monthly as $m) { $monthlyMax = max($monthlyMax, (int) $m['c']); }

function crmBarBlock(array $rows, string $color = 'var(--c-blue)'): void
{
    if (empty($rows)) { echo '<div class="crm-empty">No data in this range.</div>'; return; }
    $max = 1;
    foreach ($rows as $r) { $max = max($max, (int) $r['c']); }
    foreach ($rows as $r) {
        $label = $r['k'] ?: 'Unspecified';
        echo '<div style="display:flex;align-items:center;gap:10px;margin-bottom:10px;">';
        echo '<span style="width:150px;flex-shrink:0;font-size:12.5px;color:var(--c-text);overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">' . htmlspecialchars($label) . '</span>';
        echo '<div style="flex:1;background:var(--c-bg);border-radius:20px;height:9px;overflow:hidden;"><div style="height:100%;border-radius:20px;width:' . round(((int) $r['c'] / $max) * 100) . '%;background:' . $color . ';"></div></div>';
        echo '<span style="width:26px;text-align:right;font-size:12px;font-weight:700;">' . (int) $r['c'] . '</span>';
        echo '</div>';
    }
}
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Reports</h1>
        <p class="crm-page-subtitle">Analytics across enquiries, conversions, revenue and team performance.</p>
    </div>
</div>

<form class="crm-card" method="get">
    <div class="crm-filter-bar">
        <a href="reports.php?range=7d" class="crm-btn crm-btn-sm <?php echo $range === '7d' ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>">7 Days</a>
        <a href="reports.php?range=30d" class="crm-btn crm-btn-sm <?php echo $range === '30d' ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>">30 Days</a>
        <a href="reports.php?range=90d" class="crm-btn crm-btn-sm <?php echo $range === '90d' ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>">90 Days</a>
        <a href="reports.php?range=year" class="crm-btn crm-btn-sm <?php echo $range === 'year' ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>">This Year</a>
        <span style="color:var(--c-border);">|</span>
        <input type="hidden" name="range" value="custom">
        <input type="date" name="from" value="<?php echo htmlspecialchars($range === 'custom' ? $from : ''); ?>">
        <input type="date" name="to" value="<?php echo htmlspecialchars($range === 'custom' ? $to : ''); ?>">
        <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Custom Range</button>
    </div>
</form>

<div class="crm-kpi-grid">
    <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value"><?php echo $totalInRange; ?></div><div class="crm-kpi-label">Enquiries in Range</div></div>
    <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value" style="color:var(--c-green);"><?php echo $conversionRate; ?>%</div><div class="crm-kpi-label">Conversion Rate</div></div>
    <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value">₹<?php echo number_format($revenueInRange, 2); ?></div><div class="crm-kpi-label">Revenue Generated</div></div>
    <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value" style="color:var(--c-amber);"><?php echo $pendingDocsCount; ?></div><div class="crm-kpi-label">Documents Pending Review</div></div>
</div>

<div class="crm-two-col">
    <div class="crm-card"><h3>Enquiries by Country</h3><?php crmBarBlock($byCountry); ?></div>
    <div class="crm-card"><h3>Enquiries by Visa Type</h3><?php crmBarBlock($byVisaType, 'var(--c-indigo)'); ?></div>
</div>

<div class="crm-two-col">
    <div class="crm-card"><h3>Enquiries by Source</h3><?php crmBarBlock($bySource, 'var(--c-teal)'); ?></div>
    <div class="crm-card">
        <h3>Approved vs Rejected</h3>
        <div style="display:flex;align-items:center;gap:10px;margin-bottom:10px;">
            <span style="width:150px;flex-shrink:0;font-size:12.5px;">Visa Approved</span>
            <div style="flex:1;background:var(--c-bg);border-radius:20px;height:9px;overflow:hidden;"><div style="height:100%;border-radius:20px;width:<?php echo $approvedInRange + $rejectedInRange > 0 ? round(($approvedInRange / max(1, $approvedInRange + $rejectedInRange)) * 100) : 0; ?>%;background:var(--c-green);"></div></div>
            <span style="width:26px;text-align:right;font-weight:700;font-size:12px;"><?php echo $approvedInRange; ?></span>
        </div>
        <div style="display:flex;align-items:center;gap:10px;margin-bottom:10px;">
            <span style="width:150px;flex-shrink:0;font-size:12.5px;">Visa Rejected</span>
            <div style="flex:1;background:var(--c-bg);border-radius:20px;height:9px;overflow:hidden;"><div style="height:100%;border-radius:20px;width:<?php echo $approvedInRange + $rejectedInRange > 0 ? round(($rejectedInRange / max(1, $approvedInRange + $rejectedInRange)) * 100) : 0; ?>%;background:var(--c-red);"></div></div>
            <span style="width:26px;text-align:right;font-weight:700;font-size:12px;"><?php echo $rejectedInRange; ?></span>
        </div>
        <div style="display:flex;align-items:center;gap:10px;">
            <span style="width:150px;flex-shrink:0;font-size:12.5px;">Lost</span>
            <div style="flex:1;background:var(--c-bg);border-radius:20px;height:9px;overflow:hidden;"><div style="height:100%;border-radius:20px;width:<?php echo $lostInRange > 0 ? round(($lostInRange / max(1, $totalInRange)) * 100) : 0; ?>%;background:var(--c-deep-red);"></div></div>
            <span style="width:26px;text-align:right;font-weight:700;font-size:12px;"><?php echo $lostInRange; ?></span>
        </div>
    </div>
</div>

<div class="crm-card">
    <h3>Monthly Enquiries (last 12 months)</h3>
    <?php if (empty($monthly)): ?><div class="crm-empty">No data yet.</div><?php else: ?>
    <div style="display:flex;align-items:flex-end;gap:8px;height:140px;">
        <?php foreach ($monthly as $m): ?>
        <div style="flex:1;display:flex;flex-direction:column;align-items:center;justify-content:flex-end;height:100%;">
            <div style="font-size:10.5px;color:var(--c-text);margin-bottom:4px;"><?php echo (int) $m['c']; ?></div>
            <div style="width:70%;background:var(--c-blue);border-radius:4px 4px 0 0;height:<?php echo round(((int) $m['c'] / $monthlyMax) * 100); ?>%;min-height:2px;"></div>
            <div style="font-size:10px;color:var(--c-muted);margin-top:6px;"><?php echo date('M', strtotime($m['ym'] . '-01')); ?></div>
        </div>
        <?php endforeach; ?>
    </div>
    <?php endif; ?>
</div>

<div class="crm-two-col">
    <div class="crm-card">
        <h3>Employee Performance</h3>
        <?php if (empty($employeePerformance)): ?><div class="crm-empty">No assigned enquiries in this range.</div><?php else: ?>
        <table class="crm-table">
            <thead><tr><th>Employee</th><th>Enquiries</th><th>Converted</th><th>Rate</th></tr></thead>
            <tbody>
            <?php foreach ($employeePerformance as $e): $rate = $e['total'] > 0 ? round(($e['converted'] / $e['total']) * 100) : 0; ?>
            <tr>
                <td class="crm-cell-name"><?php echo htmlspecialchars($e['name']); ?></td>
                <td><?php echo (int) $e['total']; ?></td>
                <td><?php echo (int) $e['converted']; ?></td>
                <td><?php echo $rate; ?>%</td>
            </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
        <?php endif; ?>
    </div>
    <div class="crm-card">
        <h3>Follow-up Performance</h3>
        <div class="crm-kpi-grid" style="grid-template-columns:1fr 1fr;margin-bottom:0;">
            <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value" style="color:var(--c-green);"><?php echo $fuCompleted; ?></div><div class="crm-kpi-label">Completed in range</div></div>
            <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value" style="color:var(--c-red);"><?php echo $fuOverdue; ?></div><div class="crm-kpi-label">Currently overdue</div></div>
        </div>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
