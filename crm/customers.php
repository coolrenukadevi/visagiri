<?php
require __DIR__ . '/../includes/config.php';
require __DIR__ . '/../includes/functions.php';
require __DIR__ . '/../includes/crm-auth.php';

crm_require_login();
$pdo = db();

$q = trim($_GET['q'] ?? '');
$where = '1=1';
$params = [];
if ($q !== '') {
    $where = '(c.name LIKE ? OR c.email LIKE ? OR c.mobile LIKE ?)';
    $like = '%' . $q . '%';
    $params = [$like, $like, $like];
}

$stmt = $pdo->prepare(
    "SELECT c.id, c.name, c.email, c.mobile, c.nationality, c.source, c.created_at,
            COUNT(e.id) AS enquiry_count, MAX(e.created_at) AS last_enquiry_at
     FROM customers c LEFT JOIN enquiries e ON e.customer_id = c.id
     WHERE $where GROUP BY c.id ORDER BY last_enquiry_at DESC LIMIT 100"
);
$stmt->execute($params);
$customers = $stmt->fetchAll();

$pageTitle = 'Customers';
$crmActive = 'customers';
require __DIR__ . '/includes/layout-top.php';
?>

<form class="crm-filters" method="get" action="<?= url('crm/customers.php') ?>">
    <input type="text" name="q" placeholder="Search name, email, mobile..." value="<?= e($q) ?>" style="min-width:280px">
    <button type="submit" class="btn btn-primary" style="padding:9px 18px;font-size:13.5px">Search</button>
</form>

<div class="crm-panel">
    <div style="overflow-x:auto">
        <table class="data-table">
            <thead><tr><th>Name</th><th>Email</th><th>Mobile</th><th>Nationality</th><th>Source</th><th>Enquiries</th><th>Customer Since</th></tr></thead>
            <tbody>
                <?php foreach ($customers as $c): ?>
                <tr>
                    <td style="font-weight:600;color:var(--navy-900)"><?= e($c['name']) ?></td>
                    <td><?= e($c['email'] ?: '—') ?></td>
                    <td><?= e($c['mobile'] ?: '—') ?></td>
                    <td><?= e($c['nationality'] ?: '—') ?></td>
                    <td><?= e($c['source']) ?></td>
                    <td><span class="status-badge status-Contacted"><?= (int) $c['enquiry_count'] ?></span></td>
                    <td><?= e(date('d M Y', strtotime($c['created_at']))) ?></td>
                </tr>
                <?php endforeach; ?>
                <?php if (!$customers): ?>
                <tr><td colspan="7" style="text-align:center;color:var(--muted);padding:32px">No customers yet.</td></tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
