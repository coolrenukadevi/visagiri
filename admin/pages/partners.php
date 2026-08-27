<?php
declare(strict_types=1);

require_permission('customers.view');

$pdo = db();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : null;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_permission('customers.manage');
    csrf_require();
    $postAction = $_POST['action'] ?? '';
    $targetId = (int) ($_POST['id'] ?? 0);

    if ($postAction === 'approve' && $targetId) {
        $pdo->prepare("UPDATE partners SET status = 'active', approved_by = :admin, approved_at = NOW() WHERE id = :id")
            ->execute(['admin' => current_admin_id(), 'id' => $targetId]);
        log_action('approve', 'partners', $targetId, null, 'active');
        flash_set('admin_notice', 'Partner approved.');
    }

    if ($postAction === 'suspend' && $targetId) {
        $pdo->prepare("UPDATE partners SET status = 'suspended' WHERE id = :id")->execute(['id' => $targetId]);
        log_action('suspend', 'partners', $targetId, null, 'suspended');
        flash_set('admin_notice', 'Partner suspended.');
    }

    if ($postAction === 'reactivate' && $targetId) {
        $pdo->prepare("UPDATE partners SET status = 'active' WHERE id = :id")->execute(['id' => $targetId]);
        log_action('reactivate', 'partners', $targetId, null, 'active');
        flash_set('admin_notice', 'Partner reactivated.');
    }

    redirect('/admin/partners/');
}

if ($action === 'view' && $id) {
    $stmt = $pdo->prepare('SELECT * FROM partners WHERE id = :id AND deleted_at IS NULL');
    $stmt->execute(['id' => $id]);
    $partner = $stmt->fetch();
    if (!$partner) {
        flash_set('admin_error', 'Partner not found.');
        redirect('/admin/partners/');
    }

    $referredStmt = $pdo->prepare(
        "SELECT c.id, c.customer_reference_no, c.first_name, c.last_name, c.created_at,
                (SELECT COUNT(*) FROM visa_applications va WHERE va.customer_id = c.id AND va.deleted_at IS NULL) AS application_count
         FROM customers c WHERE c.referred_by_partner_id = :id ORDER BY c.created_at DESC"
    );
    $referredStmt->execute(['id' => $id]);
    $referred = $referredStmt->fetchAll();

    admin_header_start($partner['company_name'], 'partners');
    ?>
    <div class="admin-form-card" style="margin-bottom:var(--space-6)">
        <p><strong>Reference:</strong> <?= e($partner['partner_reference_no']) ?></p>
        <p><strong>Contact:</strong> <?= e($partner['contact_name']) ?> &middot; <?= e($partner['email']) ?><?= $partner['mobile'] ? ' · ' . e($partner['mobile']) : '' ?></p>
        <p><strong>Status:</strong> <span class="badge <?= $partner['status'] === 'active' ? 'badge-success' : ($partner['status'] === 'suspended' ? 'badge-danger' : 'badge-warning') ?>"><?= e($partner['status']) ?></span></p>
        <p><strong>Registered:</strong> <?= e(date('d M Y', strtotime((string) $partner['created_at']))) ?></p>
        <?php if (has_permission('customers.manage')): ?>
        <form method="post" action="/admin/partners/" style="margin-top:var(--space-3)">
            <?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>">
            <?php if ($partner['status'] === 'pending'): ?>
            <button type="submit" name="action" value="approve" class="btn btn-primary btn-sm">Approve</button>
            <?php elseif ($partner['status'] === 'active'): ?>
            <button type="submit" name="action" value="suspend" class="btn btn-outline btn-sm">Suspend</button>
            <?php else: ?>
            <button type="submit" name="action" value="reactivate" class="btn btn-outline btn-sm">Reactivate</button>
            <?php endif; ?>
        </form>
        <?php endif; ?>
    </div>

    <h2 class="country-directory__subheading">Referred Customers (<?= count($referred) ?>)</h2>
    <?php if (!$referred): ?>
    <p class="empty-state">No referrals yet.</p>
    <?php else: ?>
    <table class="admin-table"><thead><tr><th>Customer</th><th>Applications</th><th>Referred</th></tr></thead><tbody>
        <?php foreach ($referred as $c): ?>
        <tr>
            <td><a href="/admin/customers/?action=view&id=<?= (int) $c['id'] ?>"><?= e($c['first_name'] . ' ' . ($c['last_name'] ?? '')) ?> (<?= e($c['customer_reference_no']) ?>)</a></td>
            <td><?= (int) $c['application_count'] ?></td>
            <td><?= e(date('d M Y', strtotime((string) $c['created_at']))) ?></td>
        </tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php endif; ?>
    <p style="margin-top:var(--space-6)"><a href="/admin/partners/">&larr; Back to all partners</a></p>
    <?php
    admin_header_end();
    exit;
}

// --- List ---
$search = trim((string) ($_GET['q'] ?? ''));
$statusFilter = $_GET['status'] ?? '';
$where = ['deleted_at IS NULL'];
$params = [];
if ($search !== '') {
    $where[] = '(company_name LIKE :search1 OR contact_name LIKE :search2 OR email LIKE :search3 OR partner_reference_no LIKE :search4)';
    $params['search1'] = $params['search2'] = $params['search3'] = $params['search4'] = "%$search%";
}
if (in_array($statusFilter, ['pending', 'active', 'suspended'], true)) {
    $where[] = 'status = :status';
    $params['status'] = $statusFilter;
}
$sql = 'SELECT * FROM partners WHERE ' . implode(' AND ', $where) . ' ORDER BY (status = "pending") DESC, created_at DESC';
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$partners = $stmt->fetchAll();

$pendingCountStmt = $pdo->query("SELECT COUNT(*) FROM partners WHERE status = 'pending' AND deleted_at IS NULL");
$pendingCount = (int) $pendingCountStmt->fetchColumn();

admin_header_start('Partners', 'partners');
?>
<?php if ($pendingCount > 0): ?>
<div class="alert alert-warning"><?= $pendingCount ?> partner<?= $pendingCount === 1 ? '' : 's' ?> awaiting approval.</div>
<?php endif; ?>
<form method="get" action="/admin/partners/" style="margin-bottom:var(--space-4);display:flex;gap:var(--space-3)">
    <input class="form-input" type="search" name="q" value="<?= e($search) ?>" placeholder="Search company, contact, email, reference…">
    <select class="form-select" name="status">
        <option value="">All Statuses</option>
        <?php foreach (['pending', 'active', 'suspended'] as $s): ?>
        <option value="<?= $s ?>"<?= $statusFilter === $s ? ' selected' : '' ?>><?= ucfirst($s) ?></option>
        <?php endforeach; ?>
    </select>
    <button type="submit" class="btn btn-outline btn-sm">Filter</button>
</form>
<?php if (!$partners): ?>
<p class="empty-state">No partners found.</p>
<?php else: ?>
<table class="admin-table"><thead><tr><th>Company</th><th>Contact</th><th>Reference</th><th>Status</th><th>Registered</th></tr></thead><tbody>
    <?php foreach ($partners as $p): ?>
    <tr>
        <td><a href="/admin/partners/?action=view&id=<?= (int) $p['id'] ?>"><?= e($p['company_name']) ?></a></td>
        <td><?= e($p['contact_name']) ?> &middot; <?= e($p['email']) ?></td>
        <td><?= e($p['partner_reference_no']) ?></td>
        <td><span class="badge <?= $p['status'] === 'active' ? 'badge-success' : ($p['status'] === 'suspended' ? 'badge-danger' : 'badge-warning') ?>"><?= e($p['status']) ?></span></td>
        <td><?= e(date('d M Y', strtotime((string) $p['created_at']))) ?></td>
    </tr>
    <?php endforeach; ?>
</tbody></table>
<?php endif; ?>
<?php admin_header_end(); ?>
