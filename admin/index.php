<?php
$ADMIN_PAGE_TITLE = 'Dashboard';
$ADMIN_ACTIVE_NAV = 'dashboard';
$ADMIN_BREADCRUMB = ['CRM', 'Dashboard'];
require __DIR__ . '/includes/layout-top.php';

$scopeSql = admin_can_view_all() ? '' : ' AND assigned_to = :me';
$scopeParams = admin_can_view_all() ? [] : ['me' => admin_name()];

function crm_count(PDO $pdo, string $where, array $params = []): int
{
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM enquiries WHERE archived_at IS NULL $where");
    $stmt->execute($params);
    return (int) $stmt->fetchColumn();
}

$totalCount = crm_count($pdo, '1=1' . $scopeSql, $scopeParams);
$newCount = crm_count($pdo, "AND status = 'New Enquiry'" . $scopeSql, $scopeParams);
$inProgressCount = crm_count($pdo, "AND status IN ('Contacted','Documents Pending','Documents Under Review','Documents Approved','Payment Pending','Application Preparation','Application Submitted','Under Embassy Processing','Additional Documents Required','Decision Received')" . $scopeSql, $scopeParams);
$docsPendingCount = crm_count($pdo, "AND status IN ('Documents Pending','Documents Under Review','Additional Documents Required')" . $scopeSql, $scopeParams);
$convertedCount = crm_count($pdo, "AND status IN ('Visa Approved','Passport Ready','Completed')" . $scopeSql, $scopeParams);
$lostCount = crm_count($pdo, "AND status = 'Cancelled'" . $scopeSql, $scopeParams);

$today = gmdate('Y-m-d');
$fuStmt = $pdo->prepare("SELECT COUNT(*) FROM follow_ups f JOIN enquiries e ON e.id = f.enquiry_id
    WHERE f.completed_at IS NULL AND f.follow_up_date <= ? AND e.archived_at IS NULL" . $scopeSql);
$fuParams = array_merge([$today], $scopeParams);
$fuStmt->execute($fuParams);
$followUpDueCount = (int) $fuStmt->fetchColumn();

$revenueStmt = $pdo->prepare("SELECT COALESCE(SUM(paid_amount),0) FROM enquiries WHERE archived_at IS NULL" . $scopeSql);
$revenueStmt->execute($scopeParams);
$revenue = (float) $revenueStmt->fetchColumn();
$revenueDisplay = $revenue >= 100000 ? '₹' . round($revenue / 100000, 1) . 'L' : '₹' . number_format($revenue);

$weekAgo = gmdate('Y-m-d\TH:i:s\Z', time() - 7 * 86400);
$twoWeeksAgo = gmdate('Y-m-d\TH:i:s\Z', time() - 14 * 86400);
$thisWeekStmt = $pdo->prepare("SELECT COUNT(*) FROM enquiries WHERE created_at >= ? AND archived_at IS NULL" . $scopeSql);
$thisWeekStmt->execute(array_merge([$weekAgo], $scopeParams));
$thisWeek = (int) $thisWeekStmt->fetchColumn();
$lastWeekStmt = $pdo->prepare("SELECT COUNT(*) FROM enquiries WHERE created_at >= ? AND created_at < ? AND archived_at IS NULL" . $scopeSql);
$lastWeekStmt->execute(array_merge([$twoWeeksAgo, $weekAgo], $scopeParams));
$lastWeek = (int) $lastWeekStmt->fetchColumn();
$weekTrend = $lastWeek > 0 ? round((($thisWeek - $lastWeek) / $lastWeek) * 100) : ($thisWeek > 0 ? 100 : 0);

$kpis = [
    ['label' => 'Total Enquiries', 'value' => $totalCount, 'icon' => 'inbox', 'trend' => $weekTrend, 'filter' => ''],
    ['label' => 'New', 'value' => $newCount, 'icon' => 'sparkles', 'trend' => null, 'filter' => 'New Enquiry'],
    ['label' => 'In Progress', 'value' => $inProgressCount, 'icon' => 'spinner', 'trend' => null, 'filter' => ''],
    ['label' => 'Follow-up Due', 'value' => $followUpDueCount, 'icon' => 'phone-volume', 'trend' => null, 'filter' => ''],
    ['label' => 'Documents Pending', 'value' => $docsPendingCount, 'icon' => 'folder-open', 'trend' => null, 'filter' => 'Documents Pending'],
    ['label' => 'Converted', 'value' => $convertedCount, 'icon' => 'circle-check', 'trend' => null, 'filter' => 'Visa Approved'],
    ['label' => 'Lost', 'value' => $lostCount, 'icon' => 'circle-xmark', 'trend' => null, 'filter' => 'Cancelled'],
    ['label' => 'Revenue', 'value' => $revenueDisplay, 'icon' => 'sack-dollar', 'trend' => null, 'filter' => ''],
];

$statusCounts = [];
foreach (CRM_STATUSES as $s) {
    $statusCounts[$s] = crm_count($pdo, 'AND status = :s' . $scopeSql, array_merge(['s' => $s], $scopeParams));
}
$statusMax = max(1, max($statusCounts));

$today10 = gmdate('Y-m-d');
$overdueSql = "SELECT f.*, e.enquiry_ref, e.full_name, e.status FROM follow_ups f JOIN enquiries e ON e.id = f.enquiry_id
    WHERE f.completed_at IS NULL AND f.follow_up_date < ? AND e.archived_at IS NULL" . $scopeSql . " ORDER BY f.follow_up_date ASC LIMIT 6";
$overdueStmt = $pdo->prepare($overdueSql);
$overdueStmt->execute(array_merge([$today10], $scopeParams));
$overdueFollowUps = $overdueStmt->fetchAll(PDO::FETCH_ASSOC);

$upcomingSql = "SELECT f.*, e.enquiry_ref, e.full_name, e.status FROM follow_ups f JOIN enquiries e ON e.id = f.enquiry_id
    WHERE f.completed_at IS NULL AND f.follow_up_date >= ? AND e.archived_at IS NULL" . $scopeSql . " ORDER BY f.follow_up_date ASC LIMIT 6";
$upcomingStmt = $pdo->prepare($upcomingSql);
$upcomingStmt->execute(array_merge([$today10], $scopeParams));
$upcomingFollowUps = $upcomingStmt->fetchAll(PDO::FETCH_ASSOC);

$topDestStmt = $pdo->prepare("SELECT destination_country, COUNT(*) as c FROM enquiries WHERE archived_at IS NULL" . $scopeSql . "
    GROUP BY destination_country ORDER BY c DESC LIMIT 6");
$topDestStmt->execute($scopeParams);
$topDestinations = $topDestStmt->fetchAll(PDO::FETCH_ASSOC);
$topDestMax = 1;
foreach ($topDestinations as $d) { $topDestMax = max($topDestMax, (int) $d['c']); }

$recentStmt = $pdo->prepare("SELECT * FROM enquiries WHERE archived_at IS NULL" . $scopeSql . " ORDER BY created_at DESC LIMIT 8");
$recentStmt->execute($scopeParams);
$recentEnquiries = $recentStmt->fetchAll(PDO::FETCH_ASSOC);
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Visa Enquiry CRM</h1>
        <p class="crm-page-subtitle">Overview of all visa service enquiries<?php echo admin_can_view_all() ? '' : ' assigned to you'; ?>.</p>
    </div>
</div>

<div class="crm-kpi-grid">
    <?php foreach ($kpis as $k): ?>
    <a class="crm-kpi" href="enquiries.php<?php echo $k['filter'] ? '?status=' . urlencode($k['filter']) : ''; ?>">
        <div class="crm-kpi-top">
            <div class="crm-kpi-icon"><i class="fa-solid fa-<?php echo $k['icon']; ?>"></i></div>
            <?php if ($k['trend'] !== null): ?>
            <div class="crm-kpi-trend <?php echo $k['trend'] >= 0 ? 'up' : 'down'; ?>">
                <i class="fa-solid fa-arrow-<?php echo $k['trend'] >= 0 ? 'up' : 'down'; ?>"></i> <?php echo abs($k['trend']); ?>%
            </div>
            <?php endif; ?>
        </div>
        <div class="crm-kpi-value"><?php echo $k['value']; ?></div>
        <div class="crm-kpi-label"><?php echo $k['label']; ?></div>
    </a>
    <?php endforeach; ?>
</div>

<div class="crm-two-col">
    <div class="crm-card">
        <h3>Pipeline by Status</h3>
        <?php foreach ($statusCounts as $s => $c): ?>
        <a href="enquiries.php?status=<?php echo urlencode($s); ?>" style="display:flex;align-items:center;gap:10px;margin-bottom:10px;color:inherit;">
            <span style="width:150px;flex-shrink:0;font-size:12.5px;color:var(--c-text);overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"><?php echo htmlspecialchars($s); ?></span>
            <div style="flex:1;background:var(--c-bg);border-radius:20px;height:9px;overflow:hidden;">
                <div style="height:100%;border-radius:20px;width:<?php echo round(($c / $statusMax) * 100); ?>%;background:var(--c-blue);"></div>
            </div>
            <span style="width:24px;text-align:right;font-size:12px;font-weight:700;"><?php echo $c; ?></span>
        </a>
        <?php endforeach; ?>
    </div>
    <div class="crm-card">
        <h3>Top Destinations</h3>
        <?php if (empty($topDestinations)): ?>
        <div class="crm-empty">No enquiries yet.</div>
        <?php else: foreach ($topDestinations as $d): ?>
        <a href="enquiries.php?country=<?php echo urlencode($d['destination_country']); ?>" style="display:flex;align-items:center;gap:10px;margin-bottom:10px;color:inherit;">
            <span style="width:150px;flex-shrink:0;font-size:12.5px;color:var(--c-text);overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"><?php echo htmlspecialchars($d['destination_country']); ?></span>
            <div style="flex:1;background:var(--c-bg);border-radius:20px;height:9px;overflow:hidden;">
                <div style="height:100%;border-radius:20px;width:<?php echo round(((int) $d['c'] / $topDestMax) * 100); ?>%;background:var(--c-green);"></div>
            </div>
            <span style="width:24px;text-align:right;font-size:12px;font-weight:700;"><?php echo (int) $d['c']; ?></span>
        </a>
        <?php endforeach; endif; ?>
    </div>
</div>

<div class="crm-two-col">
    <div class="crm-card">
        <h3>Follow-ups Due</h3>
        <?php if (empty($overdueFollowUps) && empty($upcomingFollowUps)): ?>
        <div class="crm-empty">No follow-ups scheduled.</div>
        <?php else: ?>
        <?php foreach ($overdueFollowUps as $f): ?>
        <a href="enquiry.php?ref=<?php echo urlencode($f['enquiry_ref']); ?>" class="crm-followup-item">
            <span class="fu-when"><?php echo htmlspecialchars($f['follow_up_date']); ?></span>
            <span class="fu-notes"><?php echo htmlspecialchars($f['full_name']); ?></span>
            <span class="crm-fu-state state-overdue">Overdue</span>
        </a>
        <?php endforeach; ?>
        <?php foreach ($upcomingFollowUps as $f): ?>
        <a href="enquiry.php?ref=<?php echo urlencode($f['enquiry_ref']); ?>" class="crm-followup-item">
            <span class="fu-when"><?php echo htmlspecialchars($f['follow_up_date']); ?></span>
            <span class="fu-notes"><?php echo htmlspecialchars($f['full_name']); ?></span>
            <span class="crm-fu-state <?php echo $f['follow_up_date'] === $today10 ? 'state-due-today' : 'state-upcoming'; ?>"><?php echo $f['follow_up_date'] === $today10 ? 'Due Today' : 'Upcoming'; ?></span>
        </a>
        <?php endforeach; ?>
        <?php endif; ?>
    </div>
    <div class="crm-card">
        <h3>Recent Enquiries</h3>
        <?php if (empty($recentEnquiries)): ?>
        <div class="crm-empty">No enquiries yet.</div>
        <?php else: foreach ($recentEnquiries as $row): ?>
        <a href="enquiry.php?ref=<?php echo urlencode($row['enquiry_ref']); ?>" class="crm-followup-item">
            <span class="fu-when" style="width:130px;"><?php echo htmlspecialchars($row['full_name']); ?></span>
            <span class="fu-notes"><?php echo htmlspecialchars($row['destination_country']); ?> &middot; <?php echo htmlspecialchars($row['visa_type']); ?></span>
            <span class="crm-status-badge <?php echo crm_status_class($row['status']); ?>"><?php echo htmlspecialchars($row['status']); ?></span>
        </a>
        <?php endforeach; endif; ?>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
