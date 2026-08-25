<?php
declare(strict_types=1);

/**
 * Read-only audit trail viewer. Every sensitive mutation across the
 * CRM writes here via log_action() (includes/audit.php) — this page
 * never writes to audit_logs itself.
 */

require_permission('audit.view');

$pdo = db();

$moduleFilter = trim((string) ($_GET['module'] ?? ''));
$adminFilter = (int) ($_GET['admin'] ?? 0);
$page = max(1, (int) ($_GET['page'] ?? 1));
$perPage = 50;
$offset = ($page - 1) * $perPage;

$where = [];
$params = [];
if ($moduleFilter !== '') {
    $where[] = 'al.module = :module';
    $params['module'] = $moduleFilter;
}
if ($adminFilter) {
    $where[] = 'al.admin_user_id = :admin';
    $params['admin'] = $adminFilter;
}
$whereSql = $where ? ('WHERE ' . implode(' AND ', $where)) : '';

$countStmt = $pdo->prepare("SELECT COUNT(*) FROM audit_logs al $whereSql");
$countStmt->execute($params);
$total = (int) $countStmt->fetchColumn();
$totalPages = max(1, (int) ceil($total / $perPage));

$stmt = $pdo->prepare(
    "SELECT al.*, u.full_name AS admin_name FROM audit_logs al
     LEFT JOIN admin_users u ON u.id = al.admin_user_id
     $whereSql ORDER BY al.created_at DESC LIMIT $perPage OFFSET $offset"
);
$stmt->execute($params);
$logs = $stmt->fetchAll();

$modules = $pdo->query('SELECT DISTINCT module FROM audit_logs ORDER BY module')->fetchAll(PDO::FETCH_COLUMN);
$admins = $pdo->query('SELECT id, full_name FROM admin_users ORDER BY full_name')->fetchAll();

admin_header_start('Audit Log', 'audit-log');
?>
<div class="admin-toolbar">
    <form method="get" action="/admin/audit-log/" style="display:flex;gap:var(--space-2);flex-wrap:wrap">
        <select class="form-select" name="module">
            <option value="">All modules</option>
            <?php foreach ($modules as $m): ?>
            <option value="<?= e($m) ?>"<?= $moduleFilter === $m ? ' selected' : '' ?>><?= e($m) ?></option>
            <?php endforeach; ?>
        </select>
        <select class="form-select" name="admin">
            <option value="">All users</option>
            <?php foreach ($admins as $a): ?>
            <option value="<?= (int) $a['id'] ?>"<?= $adminFilter === (int) $a['id'] ? ' selected' : '' ?>><?= e($a['full_name']) ?></option>
            <?php endforeach; ?>
        </select>
        <button type="submit" class="btn btn-outline">Filter</button>
    </form>
</div>
<table class="admin-table">
    <thead><tr><th>When</th><th>User</th><th>Action</th><th>Module</th><th>Record</th><th>Change</th><th>IP</th></tr></thead>
    <tbody>
    <?php foreach ($logs as $log): ?>
        <tr>
            <td><?= e(date('d M Y H:i:s', strtotime((string) $log['created_at']))) ?></td>
            <td><?= e($log['admin_name'] ?? 'System') ?></td>
            <td><span class="badge badge-info"><?= e($log['action']) ?></span></td>
            <td><?= e($log['module']) ?></td>
            <td><?= $log['record_id'] ? '#' . (int) $log['record_id'] : '—' ?></td>
            <td>
                <?php if ($log['old_value'] !== null || $log['new_value'] !== null): ?>
                <?= e($log['old_value'] ?? '—') ?> &rarr; <?= e($log['new_value'] ?? '—') ?>
                <?php else: ?>—<?php endif; ?>
            </td>
            <td><?= e($log['ip_address'] ?? '—') ?></td>
        </tr>
    <?php endforeach; ?>
    <?php if (!$logs): ?>
        <tr><td colspan="7"><p class="empty-state">No audit log entries yet.</p></td></tr>
    <?php endif; ?>
    </tbody>
</table>
<?php if ($totalPages > 1): ?>
<div class="button-group" style="margin-top:var(--space-5)">
    <?php for ($p = 1; $p <= $totalPages; $p++): ?>
    <a href="/admin/audit-log/?page=<?= $p ?><?= $moduleFilter !== '' ? '&module=' . urlencode($moduleFilter) : '' ?><?= $adminFilter ? '&admin=' . $adminFilter : '' ?>" class="btn btn-sm <?= $p === $page ? 'btn-primary' : 'btn-outline' ?>"><?= $p ?></a>
    <?php endfor; ?>
</div>
<?php endif; ?>
<?php
admin_header_end();
