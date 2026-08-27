<?php
ob_start();
$PP_PAGE_TITLE = 'Visa Applications';
$PP_ACTIVE_NAV = 'applications';
require __DIR__ . '/includes/partner-layout-top.php';
partner_require_permission('view_applications');

// Tenant isolation: every row is scoped to the logged-in partner's own id.
$pid = partner_id();

$q = trim($_GET['q'] ?? '');
$statusFilter = trim($_GET['status'] ?? '');

$where = ['partner_id = :pid', 'archived_at IS NULL'];
$params = ['pid' => $pid];
if ($q !== '') {
    $where[] = '(enquiry_ref LIKE :q OR full_name LIKE :q OR destination_country LIKE :q OR passport_number LIKE :q)';
    $params['q'] = '%' . $q . '%';
}
if ($statusFilter !== '' && in_array($statusFilter, CRM_STATUSES, true)) {
    $where[] = 'status = :status';
    $params['status'] = $statusFilter;
}
$whereSql = 'WHERE ' . implode(' AND ', $where);

$stmt = $pdo->prepare("SELECT * FROM enquiries $whereSql ORDER BY created_at DESC LIMIT 300");
$stmt->execute($params);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

$totalStmt = $pdo->prepare('SELECT COUNT(*) FROM enquiries WHERE partner_id = ? AND archived_at IS NULL');
$totalStmt->execute([$pid]);
$total = (int) $totalStmt->fetchColumn();

$openStmt = $pdo->prepare('SELECT COUNT(*) FROM enquiries WHERE partner_id = ? AND archived_at IS NULL AND status IN (' . implode(',', array_fill(0, count(CRM_OPEN_STATUSES), '?')) . ')');
$openStmt->execute(array_merge([$pid], CRM_OPEN_STATUSES));
$openCount = (int) $openStmt->fetchColumn();

$approvedStmt = $pdo->prepare("SELECT COUNT(*) FROM enquiries WHERE partner_id = ? AND archived_at IS NULL AND status = 'Visa Approved'");
$approvedStmt->execute([$pid]);
$approvedCount = (int) $approvedStmt->fetchColumn();
?>
<div class="pp-page-header">
    <div>
        <h1 class="pp-page-title">Visa Applications</h1>
        <p class="pp-page-subtitle">Every case your team has submitted through the Partner Portal.</p>
    </div>
    <a href="b2b-new-application.php" class="b2b-submit-btn" style="text-decoration:none;display:inline-flex;width:auto;padding:12px 22px;">New Application</a>
</div>

<div class="pp-kpi-grid" style="grid-template-columns:repeat(3,1fr);">
    <div class="pp-kpi"><div class="pp-kpi-value"><?php echo $total; ?></div><div class="pp-kpi-label">Total Applications</div></div>
    <div class="pp-kpi"><div class="pp-kpi-value"><?php echo $openCount; ?></div><div class="pp-kpi-label">In Progress</div></div>
    <div class="pp-kpi"><div class="pp-kpi-value"><?php echo $approvedCount; ?></div><div class="pp-kpi-label">Visas Approved</div></div>
</div>

<form method="get" class="pp-filter-bar">
    <input type="text" name="q" value="<?php echo htmlspecialchars($q); ?>" placeholder="Search reference, traveller, destination, passport...">
    <select name="status" onchange="this.form.submit()">
        <option value="">All Statuses</option>
        <?php foreach (CRM_STATUSES as $s): ?><option value="<?php echo htmlspecialchars($s); ?>" <?php echo $statusFilter === $s ? 'selected' : ''; ?>><?php echo htmlspecialchars($s); ?></option><?php endforeach; ?>
    </select>
    <button type="submit" class="pp-filter-btn">Filter</button>
    <?php if ($q || $statusFilter): ?><a href="b2b-applications.php" class="pp-filter-btn is-ghost">Clear</a><?php endif; ?>
</form>

<div class="pp-card" style="padding:0;">
    <div class="pp-table-wrap">
    <table class="pp-table">
        <thead><tr><th>Reference</th><th>Traveller</th><th>Destination</th><th>Visa Type</th><th>Travel Date</th><th>Status</th><th>Submitted</th></tr></thead>
        <tbody>
        <?php foreach ($rows as $r): ?>
        <tr>
            <td class="pp-cell-name"><a href="b2b-application.php?ref=<?php echo urlencode($r['enquiry_ref']); ?>"><?php echo htmlspecialchars($r['enquiry_ref']); ?></a></td>
            <td><?php echo htmlspecialchars($r['full_name']); ?></td>
            <td><?php echo htmlspecialchars($r['destination_country']); ?></td>
            <td class="pp-cell-sub"><?php echo htmlspecialchars($r['visa_type']); ?></td>
            <td class="pp-cell-sub"><?php echo htmlspecialchars(substr((string) $r['travel_date'], 0, 10)); ?></td>
            <td><span class="pp-status-badge <?php echo crm_status_class($r['status']); ?>"><?php echo htmlspecialchars($r['status']); ?></span></td>
            <td class="pp-cell-sub"><?php echo htmlspecialchars(substr($r['created_at'], 0, 10)); ?></td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$rows): ?>
        <tr><td colspan="7" class="pp-empty">No applications match this filter yet.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/partner-layout-bottom.php'; ?>
