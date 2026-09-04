<?php
require __DIR__ . '/../includes/config.php';
require __DIR__ . '/../includes/functions.php';
require __DIR__ . '/../includes/crm-auth.php';

crm_require_login();
$user = crm_current_user();
$pdo = db();

$scopedTypes = crm_visible_service_types($user['role_slug']);
$scopeSql = '';
$scopeParams = [];
if ($scopedTypes) {
    $placeholders = implode(',', array_fill(0, count($scopedTypes), '?'));
    $scopeSql = " AND service_type IN ($placeholders)";
    $scopeParams = $scopedTypes;
}

function count_where(PDO $pdo, string $where, array $params): int
{
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM enquiries WHERE 1=1 $where");
    $stmt->execute($params);
    return (int) $stmt->fetchColumn();
}

$total = count_where($pdo, $scopeSql, $scopeParams);
$new = count_where($pdo, "$scopeSql AND status = 'New'", $scopeParams);
$inProgress = count_where($pdo, "$scopeSql AND status IN ('Contacted','In Progress')", $scopeParams);
$converted = count_where($pdo, "$scopeSql AND status = 'Converted'", $scopeParams);
$today = count_where($pdo, "$scopeSql AND date(created_at) = date('now')", $scopeParams);
$thisWeek = count_where($pdo, "$scopeSql AND date(created_at) >= date('now', '-7 days')", $scopeParams);

$followupsDueStmt = $pdo->prepare(
    "SELECT COUNT(*) FROM followups f JOIN enquiries e ON e.id = f.enquiry_id
     WHERE f.status = 'Pending' AND f.follow_up_date <= date('now') $scopeSql"
);
$followupsDueStmt->execute($scopeParams);
$followupsDue = (int) $followupsDueStmt->fetchColumn();

$byServiceStmt = $pdo->prepare("SELECT service_type, COUNT(*) c FROM enquiries WHERE 1=1 $scopeSql GROUP BY service_type ORDER BY c DESC");
$byServiceStmt->execute($scopeParams);
$byService = $byServiceStmt->fetchAll();
$maxService = max(array_column($byService, 'c') ?: [1]);

$byStatusStmt = $pdo->prepare("SELECT status, COUNT(*) c FROM enquiries WHERE 1=1 $scopeSql GROUP BY status ORDER BY c DESC");
$byStatusStmt->execute($scopeParams);
$byStatus = $byStatusStmt->fetchAll();
$maxStatus = max(array_column($byStatus, 'c') ?: [1]);

$recentStmt = $pdo->prepare(
    "SELECT e.id, e.reference_no, e.service_type, e.destination, e.status, e.priority, e.created_at, c.name AS customer_name, u.name AS assigned_name
     FROM enquiries e JOIN customers c ON c.id = e.customer_id LEFT JOIN users u ON u.id = e.assigned_to
     WHERE 1=1 $scopeSql ORDER BY e.created_at DESC LIMIT 8"
);
$recentStmt->execute($scopeParams);
$recent = $recentStmt->fetchAll();

$pageTitle = 'Dashboard';
$crmActive = 'dashboard';
require __DIR__ . '/includes/layout-top.php';
?>

<div class="kpi-grid">
    <div class="kpi-card"><span>Total Enquiries</span><strong><?= $total ?></strong></div>
    <div class="kpi-card"><span>New</span><strong><?= $new ?></strong></div>
    <div class="kpi-card"><span>In Progress</span><strong><?= $inProgress ?></strong></div>
    <div class="kpi-card accent"><span>Converted</span><strong><?= $converted ?></strong></div>
    <div class="kpi-card"><span>Today</span><strong><?= $today ?></strong></div>
    <div class="kpi-card"><span>Follow-ups Due</span><strong style="color:<?= $followupsDue ? '#b3261e' : 'inherit' ?>"><?= $followupsDue ?></strong></div>
</div>

<div class="grid-2" style="align-items:start;margin-bottom:0">
    <div class="crm-panel">
        <h3>Enquiries by Service</h3>
        <div class="bar-chart">
            <?php foreach ($byService as $row): ?>
            <div class="bar-row">
                <span style="text-transform:capitalize"><?= e($row['service_type']) ?></span>
                <div class="bar-track"><div class="bar-fill" style="width:<?= max(4, round($row['c'] / $maxService * 100)) ?>%"></div></div>
                <span><?= (int) $row['c'] ?></span>
            </div>
            <?php endforeach; ?>
            <?php if (!$byService): ?><p style="color:var(--muted);font-size:13.5px">No enquiries yet.</p><?php endif; ?>
        </div>
    </div>

    <div class="crm-panel">
        <h3>Enquiries by Status</h3>
        <div class="bar-chart">
            <?php foreach ($byStatus as $row): ?>
            <div class="bar-row">
                <span><?= e($row['status']) ?></span>
                <div class="bar-track"><div class="bar-fill" style="width:<?= max(4, round($row['c'] / $maxStatus * 100)) ?>%"></div></div>
                <span><?= (int) $row['c'] ?></span>
            </div>
            <?php endforeach; ?>
            <?php if (!$byStatus): ?><p style="color:var(--muted);font-size:13.5px">No enquiries yet.</p><?php endif; ?>
        </div>
    </div>
</div>

<div class="crm-panel">
    <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:16px">
        <h3 style="margin:0">Recent Enquiries</h3>
        <a href="<?= url('crm/enquiries.php') ?>" class="btn btn-ghost" style="padding:8px 14px;font-size:13px">View all &rarr;</a>
    </div>
    <div style="overflow-x:auto">
        <table class="data-table">
            <thead><tr><th>Ref</th><th>Customer</th><th>Service</th><th>Destination</th><th>Assigned</th><th>Status</th><th>Priority</th><th>Created</th></tr></thead>
            <tbody>
                <?php foreach ($recent as $r): ?>
                <tr onclick="location.href='<?= url('crm/enquiry.php?id=' . $r['id']) ?>'" style="cursor:pointer">
                    <td style="font-family:var(--font-head);font-weight:600"><?= e($r['reference_no']) ?></td>
                    <td><?= e($r['customer_name']) ?></td>
                    <td style="text-transform:capitalize"><?= e($r['service_type']) ?></td>
                    <td><?= e($r['destination'] ?: '—') ?></td>
                    <td><?= e($r['assigned_name'] ?: 'Unassigned') ?></td>
                    <td><span class="status-badge status-<?= e(str_replace(' ', '-', $r['status'])) ?>"><?= e($r['status']) ?></span></td>
                    <td class="priority-<?= e($r['priority']) ?>"><?= e($r['priority']) ?></td>
                    <td><?= e(date('d M, H:i', strtotime($r['created_at']))) ?></td>
                </tr>
                <?php endforeach; ?>
                <?php if (!$recent): ?>
                <tr><td colspan="8" style="text-align:center;color:var(--muted);padding:32px">No enquiries yet — they'll appear here as soon as the website receives one.</td></tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
