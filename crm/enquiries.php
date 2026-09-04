<?php
require __DIR__ . '/../includes/config.php';
require __DIR__ . '/../includes/functions.php';
require __DIR__ . '/../includes/crm-auth.php';

crm_require_login();
$user = crm_current_user();
$pdo = db();

$scopedTypes = crm_visible_service_types($user['role_slug']);

$where = ['1=1'];
$params = [];

if ($scopedTypes) {
    $where[] = 'e.service_type IN (' . implode(',', array_fill(0, count($scopedTypes), '?')) . ')';
    array_push($params, ...$scopedTypes);
}

$q = trim($_GET['q'] ?? '');
if ($q !== '') {
    $where[] = '(e.reference_no LIKE ? OR c.name LIKE ? OR c.email LIKE ? OR c.mobile LIKE ? OR e.destination LIKE ?)';
    $like = '%' . $q . '%';
    array_push($params, $like, $like, $like, $like, $like);
}

$statusFilter = $_GET['status'] ?? '';
if ($statusFilter !== '') {
    $where[] = 'e.status = ?';
    $params[] = $statusFilter;
}

$serviceFilter = $_GET['service'] ?? '';
if ($serviceFilter !== '' && (!$scopedTypes || in_array($serviceFilter, $scopedTypes, true))) {
    $where[] = 'e.service_type = ?';
    $params[] = $serviceFilter;
}

$priorityFilter = $_GET['priority'] ?? '';
if ($priorityFilter !== '') {
    $where[] = 'e.priority = ?';
    $params[] = $priorityFilter;
}

$whereSql = implode(' AND ', $where);

$perPage = 20;
$page = max(1, (int) ($_GET['page'] ?? 1));
$offset = ($page - 1) * $perPage;

$countStmt = $pdo->prepare("SELECT COUNT(*) FROM enquiries e JOIN customers c ON c.id = e.customer_id WHERE $whereSql");
$countStmt->execute($params);
$totalRows = (int) $countStmt->fetchColumn();
$totalPages = max(1, (int) ceil($totalRows / $perPage));

$listStmt = $pdo->prepare(
    "SELECT e.id, e.reference_no, e.service_type, e.destination, e.status, e.priority, e.created_at, c.name AS customer_name, u.name AS assigned_name
     FROM enquiries e JOIN customers c ON c.id = e.customer_id LEFT JOIN users u ON u.id = e.assigned_to
     WHERE $whereSql ORDER BY e.created_at DESC LIMIT $perPage OFFSET $offset"
);
$listStmt->execute($params);
$rows = $listStmt->fetchAll();

$serviceOptions = $scopedTypes ?: ['visa', 'hotel', 'flight', 'tour', 'insurance', 'forex', 'general'];

$pageTitle = 'Enquiries';
$crmActive = 'enquiries';
require __DIR__ . '/includes/layout-top.php';

$qs = static function (array $overrides) {
    return e('?' . http_build_query(array_merge($_GET, $overrides)));
};
?>

<form class="crm-filters" method="get" action="<?= url('crm/enquiries.php') ?>">
    <input type="text" name="q" placeholder="Search reference, customer, mobile..." value="<?= e($q) ?>" style="min-width:240px">
    <select name="service">
        <option value="">All services</option>
        <?php foreach ($serviceOptions as $s): ?>
        <option value="<?= e($s) ?>" <?= $serviceFilter === $s ? 'selected' : '' ?> style="text-transform:capitalize"><?= e(ucfirst($s)) ?></option>
        <?php endforeach; ?>
    </select>
    <select name="status">
        <option value="">All statuses</option>
        <?php foreach (['New', 'Contacted', 'In Progress', 'Converted', 'Lost'] as $s): ?>
        <option value="<?= e($s) ?>" <?= $statusFilter === $s ? 'selected' : '' ?>><?= e($s) ?></option>
        <?php endforeach; ?>
    </select>
    <select name="priority">
        <option value="">All priorities</option>
        <?php foreach (['High', 'Normal', 'Low'] as $p): ?>
        <option value="<?= e($p) ?>" <?= $priorityFilter === $p ? 'selected' : '' ?>><?= e($p) ?></option>
        <?php endforeach; ?>
    </select>
    <button type="submit" class="btn btn-primary" style="padding:9px 18px;font-size:13.5px">Filter</button>
    <?php if ($q || $statusFilter || $serviceFilter || $priorityFilter): ?>
    <a href="<?= url('crm/enquiries.php') ?>" class="btn btn-ghost" style="padding:9px 18px;font-size:13.5px">Clear</a>
    <?php endif; ?>
</form>

<div class="crm-panel">
    <div style="overflow-x:auto">
        <table class="data-table">
            <thead><tr><th>Ref</th><th>Customer</th><th>Service</th><th>Destination</th><th>Assigned</th><th>Status</th><th>Priority</th><th>Created</th></tr></thead>
            <tbody>
                <?php foreach ($rows as $r): ?>
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
                <?php if (!$rows): ?>
                <tr><td colspan="8" style="text-align:center;color:var(--muted);padding:32px">No enquiries match these filters.</td></tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>

    <?php if ($totalPages > 1): ?>
    <div class="pagination">
        <?php for ($p = 1; $p <= $totalPages; $p++): ?>
            <?php if ($p === $page): ?>
            <span class="current"><?= $p ?></span>
            <?php else: ?>
            <a href="<?= url('crm/enquiries.php') . $qs(['page' => $p]) ?>"><?= $p ?></a>
            <?php endif; ?>
        <?php endfor; ?>
    </div>
    <?php endif; ?>
    <p style="font-size:12.5px;color:var(--muted-soft);margin-top:10px"><?= $totalRows ?> enquir<?= $totalRows === 1 ? 'y' : 'ies' ?> found</p>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
