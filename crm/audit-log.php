<?php
require __DIR__ . '/../includes/config.php';
require __DIR__ . '/../includes/functions.php';
require __DIR__ . '/../includes/crm-auth.php';

crm_require_login();
$user = crm_current_user();
if (!in_array($user['role_slug'], ['super_admin', 'admin'], true)) {
    header('Location: ' . url('crm/dashboard.php'));
    exit;
}

$pdo = db();
$logs = $pdo->query(
    'SELECT a.id, a.action, a.entity_type, a.entity_id, a.meta, a.created_at, u.name AS user_name
     FROM audit_logs a LEFT JOIN users u ON u.id = a.user_id
     ORDER BY a.created_at DESC LIMIT 200'
)->fetchAll();

$pageTitle = 'Audit Log';
$crmActive = 'audit';
require __DIR__ . '/includes/layout-top.php';
?>

<div class="crm-panel">
    <div style="overflow-x:auto">
        <table class="data-table">
            <thead><tr><th>When</th><th>User</th><th>Action</th><th>Entity</th><th>Details</th></tr></thead>
            <tbody>
                <?php foreach ($logs as $log): ?>
                <tr>
                    <td><?= e(date('d M Y, H:i:s', strtotime($log['created_at']))) ?></td>
                    <td><?= e($log['user_name'] ?: 'System') ?></td>
                    <td><span class="status-badge status-Contacted"><?= e($log['action']) ?></span></td>
                    <td><?= e($log['entity_type'] ? $log['entity_type'] . ' #' . $log['entity_id'] : '—') ?></td>
                    <td style="font-size:12.5px;color:var(--muted)"><?= e($log['meta'] ?: '') ?></td>
                </tr>
                <?php endforeach; ?>
                <?php if (!$logs): ?>
                <tr><td colspan="5" style="text-align:center;color:var(--muted);padding:32px">No activity recorded yet.</td></tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
