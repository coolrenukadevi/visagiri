<?php
$ADMIN_PAGE_TITLE = 'B2B Partners';
$ADMIN_ACTIVE_NAV = 'b2b-partners';
$ADMIN_BREADCRUMB = ['CRM', 'B2B Partners', 'Applications'];
require __DIR__ . '/includes/layout-top.php';

[$scopeSql, $scopeParams] = b2b_scope_sql();

$q = trim($_GET['q'] ?? '');
$statusFilter = trim($_GET['status'] ?? '');
$businessTypeFilter = trim($_GET['business_type'] ?? '');
$iataFilter = trim($_GET['iata'] ?? '');
$cityFilter = trim($_GET['city'] ?? '');

$where = ['archived_at IS NULL'];
$params = $scopeParams;
if ($q !== '') {
    $where[] = '(application_ref LIKE :q OR company_name LIKE :q OR contact_name LIKE :q OR contact_email LIKE :q OR contact_mobile LIKE :q OR gst_number LIKE :q OR pan_number LIKE :q OR iata_number LIKE :q)';
    $params['q'] = '%' . $q . '%';
}
if ($statusFilter !== '' && in_array($statusFilter, B2B_PARTNER_STATUSES, true)) {
    $where[] = 'status = :status';
    $params['status'] = $statusFilter;
}
if ($businessTypeFilter !== '' && in_array($businessTypeFilter, B2B_BUSINESS_TYPES, true)) {
    $where[] = 'business_type = :business_type';
    $params['business_type'] = $businessTypeFilter;
}
if ($iataFilter === 'yes') { $where[] = 'iata_registered = 1'; }
elseif ($iataFilter === 'no') { $where[] = 'iata_registered = 0'; }
if ($cityFilter !== '') {
    $where[] = 'city LIKE :city';
    $params['city'] = '%' . $cityFilter . '%';
}
$whereSql = 'WHERE ' . implode(' AND ', $where) . $scopeSql;

$stmt = $pdo->prepare("SELECT p.*, u.name AS manager_name,
        (SELECT COUNT(*) FROM enquiries e WHERE e.partner_id = p.id) AS visa_case_count,
        (SELECT MAX(created_at) FROM b2b_audit_logs a WHERE a.entity_type='partner' AND a.entity_id = p.id) AS last_activity
    FROM b2b_partners p LEFT JOIN users u ON u.id = p.assigned_manager_id
    $whereSql ORDER BY p.created_at DESC LIMIT 300");
$stmt->execute($params);
$partners = $stmt->fetchAll(PDO::FETCH_ASSOC);

function b2bKpi(PDO $pdo, string $sql, array $params = []): int
{
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    return (int) $stmt->fetchColumn();
}
$baseScope = "archived_at IS NULL" . $scopeSql;
$total = b2bKpi($pdo, "SELECT COUNT(*) FROM b2b_partners WHERE $baseScope", $scopeParams);
$newApps = b2bKpi($pdo, "SELECT COUNT(*) FROM b2b_partners WHERE status = 'Submitted' AND $baseScope", $scopeParams);
$pendingVerification = b2bKpi($pdo, "SELECT COUNT(*) FROM b2b_partners WHERE status IN ('Under Review','Verification') AND $baseScope", $scopeParams);
$approved = b2bKpi($pdo, "SELECT COUNT(*) FROM b2b_partners WHERE status = 'Approved' AND $baseScope", $scopeParams);
$docsRequired = b2bKpi($pdo, "SELECT COUNT(*) FROM b2b_partners WHERE status = 'Documents Required' AND $baseScope", $scopeParams);
$suspended = b2bKpi($pdo, "SELECT COUNT(*) FROM b2b_partners WHERE status = 'Suspended' AND $baseScope", $scopeParams);
$rejected = b2bKpi($pdo, "SELECT COUNT(*) FROM b2b_partners WHERE status = 'Rejected' AND $baseScope", $scopeParams);
$monthStart = gmdate('Y-m-01');
$addedThisMonth = b2bKpi($pdo, "SELECT COUNT(*) FROM b2b_partners WHERE created_at >= :month_start AND $baseScope", array_merge(['month_start' => $monthStart], $scopeParams));
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">B2B Partners</h1>
        <p class="crm-page-subtitle">Partner applications and accounts<?php echo b2b_can_view_all() ? '' : ' assigned to you'; ?>.</p>
    </div>
</div>

<div class="crm-kpi-grid" style="grid-template-columns:repeat(4,1fr);">
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $total; ?></div><div class="crm-kpi-label">Total Partners</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $newApps; ?></div><div class="crm-kpi-label">New Applications</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $pendingVerification; ?></div><div class="crm-kpi-label">Pending Verification</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $approved; ?></div><div class="crm-kpi-label">Approved Partners</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $docsRequired; ?></div><div class="crm-kpi-label">Documents Required</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $suspended; ?></div><div class="crm-kpi-label">Suspended Partners</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $rejected; ?></div><div class="crm-kpi-label">Rejected Applications</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $addedThisMonth; ?></div><div class="crm-kpi-label">Added This Month</div></div>
</div>

<form method="get" class="crm-filter-bar" style="margin-bottom:16px; flex-wrap:wrap;">
    <input type="text" name="q" value="<?php echo htmlspecialchars($q); ?>" placeholder="Search ref, company, contact, email, GST, PAN, IATA..." style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;min-width:260px;">
    <select name="status" onchange="this.form.submit()" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;">
        <option value="">All Statuses</option>
        <?php foreach (B2B_PARTNER_STATUSES as $s): ?><option value="<?php echo htmlspecialchars($s); ?>" <?php echo $statusFilter === $s ? 'selected' : ''; ?>><?php echo htmlspecialchars($s); ?></option><?php endforeach; ?>
    </select>
    <select name="business_type" onchange="this.form.submit()" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;">
        <option value="">All Business Types</option>
        <?php foreach (B2B_BUSINESS_TYPES as $bt): ?><option value="<?php echo htmlspecialchars($bt); ?>" <?php echo $businessTypeFilter === $bt ? 'selected' : ''; ?>><?php echo htmlspecialchars($bt); ?></option><?php endforeach; ?>
    </select>
    <select name="iata" onchange="this.form.submit()" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;">
        <option value="">IATA: All</option>
        <option value="yes" <?php echo $iataFilter === 'yes' ? 'selected' : ''; ?>>IATA Registered</option>
        <option value="no" <?php echo $iataFilter === 'no' ? 'selected' : ''; ?>>Non-IATA</option>
    </select>
    <input type="text" name="city" value="<?php echo htmlspecialchars($cityFilter); ?>" placeholder="City" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;width:120px;">
    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Filter</button>
    <?php if ($q || $statusFilter || $businessTypeFilter || $iataFilter || $cityFilter): ?><a href="b2b-partners.php" class="crm-btn crm-btn-ghost crm-btn-sm">Clear</a><?php endif; ?>
</form>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Partner ID</th><th>Company</th><th>Contact</th><th>City</th><th>Business Type</th><th>IATA</th><th>Registered</th><th>Manager</th><th>Status</th><th>Visa Cases</th><th>Last Activity</th><th>Actions</th></tr></thead>
        <tbody>
        <?php foreach ($partners as $p): ?>
        <tr>
            <td class="crm-cell-name"><a href="b2b-partner.php?ref=<?php echo urlencode($p['application_ref']); ?>"><?php echo htmlspecialchars($p['application_ref']); ?></a></td>
            <td><?php echo htmlspecialchars($p['company_name']); ?></td>
            <td><?php echo htmlspecialchars($p['contact_name']); ?><div class="crm-cell-sub"><?php echo htmlspecialchars($p['contact_email']); ?> &middot; <?php echo htmlspecialchars($p['contact_mobile']); ?></div></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($p['city'] ?: '—'); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($p['business_type'] ?: '—'); ?></td>
            <td class="crm-cell-sub"><?php echo $p['iata_registered'] ? 'Yes' : 'No'; ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars(substr($p['created_at'], 0, 10)); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($p['manager_name'] ?: 'Unassigned'); ?></td>
            <td><span class="crm-status-badge <?php echo b2b_status_class($p['status']); ?>"><?php echo htmlspecialchars($p['status']); ?></span></td>
            <td class="crm-cell-sub"><?php echo (int) $p['visa_case_count']; ?></td>
            <td class="crm-cell-sub"><?php echo $p['last_activity'] ? htmlspecialchars(substr($p['last_activity'], 0, 10)) : '—'; ?></td>
            <td><a href="b2b-partner.php?ref=<?php echo urlencode($p['application_ref']); ?>" class="crm-btn crm-btn-ghost crm-btn-sm">View</a></td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$partners): ?>
        <tr><td colspan="12" class="crm-empty">No B2B partner applications match this filter.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
    <div style="padding:16px;">
    <?php foreach ($partners as $p): ?>
    <div class="crm-row-card">
        <div class="rc-top">
            <div><div class="rc-name"><?php echo htmlspecialchars($p['company_name']); ?></div><div class="rc-ref"><?php echo htmlspecialchars($p['application_ref']); ?></div></div>
            <span class="crm-status-badge <?php echo b2b_status_class($p['status']); ?>"><?php echo htmlspecialchars($p['status']); ?></span>
        </div>
        <div class="rc-meta"><?php echo htmlspecialchars($p['contact_name']); ?> &middot; <?php echo htmlspecialchars($p['city'] ?: '—'); ?> &middot; <?php echo (int) $p['visa_case_count']; ?> visa case<?php echo (int) $p['visa_case_count'] === 1 ? '' : 's'; ?></div>
        <div class="rc-actions">
            <a href="tel:<?php echo htmlspecialchars($p['contact_mobile']); ?>"><i class="fa-solid fa-phone"></i></a>
            <a href="mailto:<?php echo htmlspecialchars($p['contact_email']); ?>"><i class="fa-solid fa-envelope"></i></a>
            <a href="b2b-partner.php?ref=<?php echo urlencode($p['application_ref']); ?>"><i class="fa-solid fa-eye"></i> View</a>
        </div>
    </div>
    <?php endforeach; ?>
    <?php if (!$partners): ?>
    <div class="crm-empty">No B2B partner applications match this filter.</div>
    <?php endif; ?>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
