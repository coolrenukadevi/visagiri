<?php
require_once __DIR__ . '/includes/admin-auth.php';
admin_require_login();

$pdo = enquiry_db();

$totalCount = (int) $pdo->query('SELECT COUNT(*) FROM enquiries')->fetchColumn();

$weekAgo = gmdate('c', time() - 7 * 86400);
$stmt = $pdo->prepare('SELECT COUNT(*) FROM enquiries WHERE created_at >= ?');
$stmt->execute([$weekAgo]);
$newThisWeek = (int) $stmt->fetchColumn();

$todayStart = gmdate('Y-m-d\T00:00:00\Z');
$stmt = $pdo->prepare('SELECT COUNT(*) FROM enquiries WHERE created_at >= ?');
$stmt->execute([$todayStart]);
$newToday = (int) $stmt->fetchColumn();

$convertedCount = (int) $pdo->query("SELECT COUNT(*) FROM enquiries WHERE status = 'Converted'")->fetchColumn();
$conversionRate = $totalCount > 0 ? round(($convertedCount / $totalCount) * 100, 1) : 0.0;

$statuses = ['New', 'Contacted', 'In Progress', 'Converted', 'Closed'];
$statusCounts = [];
foreach ($statuses as $s) {
    $stmt = $pdo->prepare('SELECT COUNT(*) FROM enquiries WHERE status = ?');
    $stmt->execute([$s]);
    $statusCounts[$s] = (int) $stmt->fetchColumn();
}
$statusMax = max(1, max($statusCounts));

$today = gmdate('Y-m-d');
$overdueStmt = $pdo->prepare("SELECT * FROM enquiries WHERE follow_up_date IS NOT NULL AND follow_up_date != ''
    AND follow_up_date < ? AND status NOT IN ('Converted', 'Closed') ORDER BY follow_up_date ASC LIMIT 8");
$overdueStmt->execute([$today]);
$overdueFollowUps = $overdueStmt->fetchAll(PDO::FETCH_ASSOC);

$upcomingStmt = $pdo->prepare("SELECT * FROM enquiries WHERE follow_up_date IS NOT NULL AND follow_up_date != ''
    AND follow_up_date >= ? AND status NOT IN ('Converted', 'Closed') ORDER BY follow_up_date ASC LIMIT 8");
$upcomingStmt->execute([$today]);
$upcomingFollowUps = $upcomingStmt->fetchAll(PDO::FETCH_ASSOC);

$topDestinations = $pdo->query('SELECT destination_country, COUNT(*) as c FROM enquiries
    GROUP BY destination_country ORDER BY c DESC LIMIT 6')->fetchAll(PDO::FETCH_ASSOC);
$topDestMax = 1;
foreach ($topDestinations as $d) { $topDestMax = max($topDestMax, (int) $d['c']); }

$recentStmt = $pdo->query('SELECT * FROM enquiries ORDER BY created_at DESC LIMIT 8');
$recentEnquiries = $recentStmt->fetchAll(PDO::FETCH_ASSOC);

function admin_status_class(string $status): string
{
    return 'status-' . strtolower(str_replace(' ', '-', $status));
}
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="robots" content="noindex, nofollow">
<title>CRM Dashboard &ndash; Visa Agency Admin</title>
<link rel="stylesheet" href="../assets/css/all.min.css">
<link rel="stylesheet" href="assets/admin.css">
</head>
<body>
<div class="admin-shell">
    <div class="admin-sidebar">
        <span class="brand">VISA AGENCY CRM</span>
        <a href="index.php" class="active"><i class="fa-solid fa-gauge-high"></i> Dashboard</a>
        <a href="dashboard.php"><i class="fa-solid fa-inbox"></i> Enquiries</a>
        <a href="logout.php">Log Out</a>
    </div>
    <div class="admin-main">
        <div class="admin-topbar">
            <h1>Visa Enquiry CRM</h1>
            <span class="who">Signed in as <?php echo htmlspecialchars($_SESSION['admin_user']); ?></span>
        </div>

        <div class="admin-kpi-grid">
            <div class="admin-kpi">
                <div class="kpi-label">Total Enquiries</div>
                <div class="kpi-value"><?php echo $totalCount; ?></div>
            </div>
            <div class="admin-kpi">
                <div class="kpi-label">New Today</div>
                <div class="kpi-value"><?php echo $newToday; ?></div>
            </div>
            <div class="admin-kpi">
                <div class="kpi-label">New This Week</div>
                <div class="kpi-value"><?php echo $newThisWeek; ?></div>
            </div>
            <div class="admin-kpi">
                <div class="kpi-label">Conversion Rate</div>
                <div class="kpi-value"><?php echo $conversionRate; ?>%</div>
            </div>
            <div class="admin-kpi kpi-warn">
                <div class="kpi-label">Overdue Follow-ups</div>
                <div class="kpi-value"><?php echo count($overdueFollowUps); ?></div>
            </div>
        </div>

        <div class="admin-two-col">
            <div class="admin-card">
                <h3 style="margin-top:0;">Pipeline by Status</h3>
                <div class="admin-bar-chart">
                    <?php foreach ($statusCounts as $s => $c): ?>
                    <div class="admin-bar-row">
                        <span class="bar-label"><?php echo htmlspecialchars($s); ?></span>
                        <div class="bar-track">
                            <div class="bar-fill <?php echo admin_status_class($s); ?>" style="width: <?php echo round(($c / $statusMax) * 100); ?>%;"></div>
                        </div>
                        <span class="bar-count"><?php echo $c; ?></span>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>

            <div class="admin-card">
                <h3 style="margin-top:0;">Top Destinations</h3>
                <?php if (empty($topDestinations)): ?>
                <p style="color:#94A0BD;font-size:13px;">No enquiries yet.</p>
                <?php else: ?>
                <div class="admin-bar-chart">
                    <?php foreach ($topDestinations as $d): ?>
                    <div class="admin-bar-row">
                        <span class="bar-label"><?php echo htmlspecialchars($d['destination_country']); ?></span>
                        <div class="bar-track">
                            <div class="bar-fill status-converted" style="width: <?php echo round(((int) $d['c'] / $topDestMax) * 100); ?>%;"></div>
                        </div>
                        <span class="bar-count"><?php echo (int) $d['c']; ?></span>
                    </div>
                    <?php endforeach; ?>
                </div>
                <?php endif; ?>
            </div>
        </div>

        <div class="admin-two-col">
            <div class="admin-card">
                <h3 style="margin-top:0;">Follow-ups Due</h3>
                <?php if (empty($overdueFollowUps) && empty($upcomingFollowUps)): ?>
                <p style="color:#94A0BD;font-size:13px;">No follow-ups scheduled.</p>
                <?php else: ?>
                <div class="admin-followup-list">
                    <?php foreach ($overdueFollowUps as $row): ?>
                    <a href="enquiry.php?ref=<?php echo urlencode($row['enquiry_ref']); ?>" class="admin-followup-item is-overdue">
                        <span class="fu-date"><?php echo htmlspecialchars($row['follow_up_date']); ?> <em>overdue</em></span>
                        <span class="fu-name"><?php echo htmlspecialchars($row['full_name']); ?></span>
                        <span class="admin-status <?php echo admin_status_class($row['status']); ?>"><?php echo htmlspecialchars($row['status']); ?></span>
                    </a>
                    <?php endforeach; ?>
                    <?php foreach ($upcomingFollowUps as $row): ?>
                    <a href="enquiry.php?ref=<?php echo urlencode($row['enquiry_ref']); ?>" class="admin-followup-item">
                        <span class="fu-date"><?php echo htmlspecialchars($row['follow_up_date']); ?></span>
                        <span class="fu-name"><?php echo htmlspecialchars($row['full_name']); ?></span>
                        <span class="admin-status <?php echo admin_status_class($row['status']); ?>"><?php echo htmlspecialchars($row['status']); ?></span>
                    </a>
                    <?php endforeach; ?>
                </div>
                <?php endif; ?>
            </div>

            <div class="admin-card">
                <h3 style="margin-top:0;">Recent Enquiries</h3>
                <?php if (empty($recentEnquiries)): ?>
                <p style="color:#94A0BD;font-size:13px;">No enquiries yet.</p>
                <?php else: ?>
                <div class="admin-recent-list">
                    <?php foreach ($recentEnquiries as $row): ?>
                    <a href="enquiry.php?ref=<?php echo urlencode($row['enquiry_ref']); ?>" class="admin-recent-item">
                        <span class="ri-name"><?php echo htmlspecialchars($row['full_name']); ?></span>
                        <span class="ri-dest"><?php echo htmlspecialchars($row['destination_country']); ?> &middot; <?php echo htmlspecialchars($row['service_required']); ?></span>
                        <span class="admin-status <?php echo admin_status_class($row['status']); ?>"><?php echo htmlspecialchars($row['status']); ?></span>
                    </a>
                    <?php endforeach; ?>
                </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</div>
</body>
</html>
