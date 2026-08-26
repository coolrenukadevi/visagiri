<?php
require_once __DIR__ . '/includes/admin-auth.php';
require_once __DIR__ . '/../includes/enquiry-db.php';
admin_require_login();

if (!in_array(admin_role(), ['Super Admin', 'Admin', 'Sales Manager'], true)) {
    http_response_code(403);
    exit('You do not have permission to view newsletter subscribers.');
}

if (($_GET['export'] ?? '') === 'csv') {
    $pdo = enquiry_db();
    $rows = $pdo->query('SELECT email, source_url, is_active, created_at FROM newsletter_subscribers ORDER BY created_at DESC')->fetchAll(PDO::FETCH_ASSOC);
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="newsletter-subscribers-' . gmdate('Ymd-His') . '.csv"');
    $out = fopen('php://output', 'w');
    fputcsv($out, ['Email', 'Signed Up From', 'Status', 'Subscribed At']);
    foreach ($rows as $r) {
        fputcsv($out, [$r['email'], $r['source_url'], $r['is_active'] ? 'Active' : 'Unsubscribed', $r['created_at']]);
    }
    fclose($out);
    exit;
}

$ADMIN_PAGE_TITLE = 'Newsletter Subscribers';
$ADMIN_ACTIVE_NAV = 'newsletter';
$ADMIN_BREADCRUMB = ['CRM', 'Newsletter Subscribers'];
require __DIR__ . '/includes/layout-top.php';

$q = trim($_GET['q'] ?? '');
$where = 'WHERE is_active = 1';
$params = [];
if ($q !== '') {
    $where .= ' AND email LIKE :q';
    $params['q'] = '%' . $q . '%';
}
$stmt = $pdo->prepare("SELECT * FROM newsletter_subscribers $where ORDER BY created_at DESC LIMIT 500");
$stmt->execute($params);
$subscribers = $stmt->fetchAll(PDO::FETCH_ASSOC);
$totalActive = (int) $pdo->query('SELECT COUNT(*) FROM newsletter_subscribers WHERE is_active = 1')->fetchColumn();
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Newsletter Subscribers</h1>
        <p class="crm-page-subtitle">Everyone who subscribed to visa &amp; travel updates from the footer newsletter form.</p>
    </div>
    <div class="crm-page-actions">
        <a href="newsletter.php?export=csv" class="crm-btn crm-btn-ghost"><i class="fa-solid fa-file-csv"></i> Export CSV</a>
    </div>
</div>

<div class="crm-kpi-grid" style="grid-template-columns:repeat(1,1fr);max-width:260px;">
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $totalActive; ?></div><div class="crm-kpi-label">Active Subscribers</div></div>
</div>

<form method="get" class="crm-filter-bar" style="margin-bottom:16px;">
    <input type="text" name="q" value="<?php echo htmlspecialchars($q); ?>" placeholder="Search email..." style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;min-width:260px;">
    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Search</button>
    <?php if ($q): ?><a href="newsletter.php" class="crm-btn crm-btn-ghost crm-btn-sm">Clear</a><?php endif; ?>
</form>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Email</th><th>Signed Up From</th><th>Subscribed</th></tr></thead>
        <tbody>
        <?php foreach ($subscribers as $s): ?>
        <tr>
            <td class="crm-cell-name"><?php echo htmlspecialchars($s['email']); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($s['source_url'] ?: '—'); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars(substr($s['created_at'], 0, 10)); ?></td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$subscribers): ?>
        <tr><td colspan="3" class="crm-empty">No subscribers yet.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
