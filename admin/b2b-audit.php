<?php
ob_start();
$ADMIN_PAGE_TITLE = 'B2B Audit Log';
$ADMIN_ACTIVE_NAV = 'b2b-audit';
$ADMIN_BREADCRUMB = ['CRM', 'B2B Partners', 'Audit Log'];
require __DIR__ . '/includes/layout-top.php';

if (!b2b_can_export_audit()) {
    http_response_code(403);
    echo '<div class="crm-card">You do not have permission to view the B2B audit log.</div>';
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}

$entityType = trim($_GET['entity_type'] ?? '');
$q = trim($_GET['q'] ?? '');
$dateFrom = trim($_GET['from'] ?? '');
$dateTo = trim($_GET['to'] ?? '');

$where = [];
$params = [];
if ($entityType !== '') { $where[] = 'entity_type = :entity_type'; $params['entity_type'] = $entityType; }
if ($q !== '') {
    $where[] = '(action LIKE :q OR previous_value LIKE :q OR new_value LIKE :q OR user_name LIKE :q)';
    $params['q'] = '%' . $q . '%';
}
if ($dateFrom !== '') { $where[] = 'created_at >= :from'; $params['from'] = $dateFrom . 'T00:00:00+00:00'; }
if ($dateTo !== '') { $where[] = 'created_at <= :to'; $params['to'] = $dateTo . 'T23:59:59+00:00'; }
$whereSql = $where ? 'WHERE ' . implode(' AND ', $where) : '';

$stmt = $pdo->prepare("SELECT * FROM b2b_audit_logs $whereSql ORDER BY id DESC LIMIT 300");
$stmt->execute($params);
$logs = $stmt->fetchAll(PDO::FETCH_ASSOC);

$entityTypes = $pdo->query('SELECT DISTINCT entity_type FROM b2b_audit_logs WHERE entity_type IS NOT NULL ORDER BY entity_type')->fetchAll(PDO::FETCH_COLUMN);
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">B2B Audit Log</h1>
        <p class="crm-page-subtitle">Every status change, financial action and record change across the B2B module, most recent 300 shown.</p>
    </div>
    <div>
        <a href="b2b-export.php?type=audit&<?php echo http_build_query(['entity_type' => $entityType, 'q' => $q, 'from' => $dateFrom, 'to' => $dateTo]); ?>" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-download"></i> Export CSV</a>
    </div>
</div>

<form method="get" class="crm-filter-bar" style="margin-bottom:16px;flex-wrap:wrap;">
    <input type="text" name="q" value="<?php echo htmlspecialchars($q); ?>" placeholder="Search action, values, user..." style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;min-width:240px;">
    <select name="entity_type" onchange="this.form.submit()" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;">
        <option value="">All Entity Types</option>
        <?php foreach ($entityTypes as $et): ?><option value="<?php echo htmlspecialchars($et); ?>" <?php echo $entityType === $et ? 'selected' : ''; ?>><?php echo htmlspecialchars(ucfirst($et)); ?></option><?php endforeach; ?>
    </select>
    <input type="date" name="from" value="<?php echo htmlspecialchars($dateFrom); ?>" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;">
    <input type="date" name="to" value="<?php echo htmlspecialchars($dateTo); ?>" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;">
    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Filter</button>
    <?php if ($q || $entityType || $dateFrom || $dateTo): ?><a href="b2b-audit.php" class="crm-btn crm-btn-ghost crm-btn-sm">Clear</a><?php endif; ?>
</form>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>When</th><th>Entity</th><th>Action</th><th>Detail</th><th>By</th></tr></thead>
        <tbody>
        <?php foreach ($logs as $l): ?>
        <tr>
            <td class="crm-cell-sub"><?php echo htmlspecialchars(substr($l['created_at'], 0, 16)); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($l['entity_type'] ?: '—'); ?><?php echo $l['entity_id'] ? ' #' . (int) $l['entity_id'] : ''; ?></td>
            <td class="crm-cell-name"><?php echo htmlspecialchars($l['action']); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($l['new_value'] ?: ''); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($l['user_name']); ?> <?php echo $l['role'] ? '(' . htmlspecialchars($l['role']) . ')' : ''; ?></td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$logs): ?>
        <tr><td colspan="5" class="crm-empty">No audit entries match this filter.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
