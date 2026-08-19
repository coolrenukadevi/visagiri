<?php
$ADMIN_PAGE_TITLE = 'Customers';
$ADMIN_ACTIVE_NAV = 'customers';
$ADMIN_BREADCRUMB = ['CRM', 'Customers'];
require __DIR__ . '/includes/layout-top.php';

$search = trim($_GET['q'] ?? '');
$scopeSql = admin_can_view_all() ? '' : ' AND assigned_to = :me';
$scopeParams = admin_can_view_all() ? [] : ['me' => admin_name()];

$sql = "SELECT email, MAX(full_name) AS full_name, MAX(mobile) AS mobile, MAX(nationality) AS nationality,
        COUNT(*) AS enquiry_count, MAX(created_at) AS last_enquiry, SUM(COALESCE(paid_amount,0)) AS total_paid
    FROM enquiries WHERE archived_at IS NULL $scopeSql";
$params = $scopeParams;
if ($search !== '') {
    $sql .= ' AND (full_name LIKE :q OR email LIKE :q OR mobile LIKE :q)';
    $params['q'] = '%' . $search . '%';
}
$sql .= ' GROUP BY email ORDER BY last_enquiry DESC LIMIT 300';
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$customers = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Customers</h1>
        <p class="crm-page-subtitle">Every customer derived from their enquiry history, with a running total of visits and spend.</p>
    </div>
</div>

<form class="crm-card" method="get">
    <div class="crm-filter-bar">
        <input type="text" name="q" placeholder="Search name, email, mobile..." value="<?php echo htmlspecialchars($search); ?>" style="min-width:260px;">
        <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Search</button>
    </div>
</form>

<div class="crm-card" style="padding:0;">
    <?php if (empty($customers)): ?>
    <div class="crm-empty">No customers yet.</div>
    <?php else: ?>
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Name</th><th>Email</th><th>Mobile</th><th>Nationality</th><th>Enquiries</th><th>Total Paid</th><th>Last Enquiry</th></tr></thead>
        <tbody>
        <?php foreach ($customers as $c): ?>
        <tr>
            <td class="crm-cell-name"><?php echo htmlspecialchars($c['full_name']); ?></td>
            <td><?php echo htmlspecialchars($c['email']); ?></td>
            <td><?php echo htmlspecialchars($c['mobile']); ?></td>
            <td><?php echo htmlspecialchars($c['nationality'] ?: '—'); ?></td>
            <td><a href="enquiries.php?q=<?php echo urlencode($c['email']); ?>"><?php echo (int) $c['enquiry_count']; ?></a></td>
            <td>₹<?php echo number_format((float) $c['total_paid'], 2); ?></td>
            <td class="crm-cell-sub"><?php echo substr($c['last_enquiry'], 0, 10); ?></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>
    <?php endif; ?>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
