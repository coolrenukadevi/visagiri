<?php
declare(strict_types=1);

/**
 * B2B Partner CRM — Phase 1. Rebuilt on admin/pages/customers.php's
 * search/filter/pagination pattern (the old version of this file had
 * neither and piggybacked on customers.view/customers.manage instead
 * of its own permission namespace). See AUDIT.md for the full phasing
 * — this is deliberately just RBAC + a real list/profile view; no
 * Documents/Quotations/Invoices/Wallet/Team sections yet, since those
 * tables don't exist until later phases.
 */

require_permission('partners.view');

$pdo = db();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);
$scopedToAssigned = current_admin_b2b_scoped_to_assigned();

$partnerStatusBadgeMap = ['pending' => 'warning', 'active' => 'success', 'suspended' => 'danger'];

// Active admins eligible to be assigned as a partner's Relationship
// Manager — same unfiltered-by-role approach customers.php already
// uses for its own employee-assignment dropdown, not narrowed to a
// b2b-* role specifically (any active staff member can be assigned).
$admins = $pdo->query('SELECT id, full_name FROM admin_users WHERE status = "active" ORDER BY full_name')->fetchAll();

// --- Handle POST (approve, suspend, reactivate, assign manager) ---
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_permission('partners.manage');
    csrf_require();
    $postAction = $_POST['action'] ?? '';
    $targetId = (int) ($_POST['id'] ?? 0);

    // Shared by approve/suspend/reactivate: updates partners.status,
    // records the transition in partner_status_history, and audits it
    // — each caller supplies the SQL + params for its own extra
    // columns (approve also sets approved_by/approved_at). PDO's
    // non-emulated prepares reject an execute() array containing a
    // key with no matching placeholder in the query, so $updateParams
    // must exactly match $updateSql's own placeholders — no shared
    // "always pass :admin" shortcut.
    $transitionStatus = static function (int $partnerId, string $toStatus, string $updateSql, array $updateParams, string $logAction) use ($pdo): void {
        $fromStmt = $pdo->prepare('SELECT status FROM partners WHERE id = :id');
        $fromStmt->execute(['id' => $partnerId]);
        $from = $fromStmt->fetchColumn() ?: null;

        $pdo->prepare($updateSql)->execute($updateParams);
        $pdo->prepare('INSERT INTO partner_status_history (partner_id, from_status, to_status, changed_by) VALUES (:id, :from, :to, :admin)')
            ->execute(['id' => $partnerId, 'from' => $from, 'to' => $toStatus, 'admin' => current_admin_id()]);
        log_action($logAction, 'partners', $partnerId, $from, $toStatus);
    };

    if ($postAction === 'approve' && $targetId) {
        $transitionStatus(
            $targetId,
            'active',
            "UPDATE partners SET status = 'active', approved_by = :admin, approved_at = NOW() WHERE id = :id",
            ['admin' => current_admin_id(), 'id' => $targetId],
            'approve'
        );
        flash_set('admin_notice', 'Partner approved.');
    }

    if ($postAction === 'suspend' && $targetId) {
        $transitionStatus($targetId, 'suspended', "UPDATE partners SET status = 'suspended' WHERE id = :id", ['id' => $targetId], 'suspend');
        flash_set('admin_notice', 'Partner suspended.');
    }

    if ($postAction === 'reactivate' && $targetId) {
        $transitionStatus($targetId, 'active', "UPDATE partners SET status = 'active' WHERE id = :id", ['id' => $targetId], 'reactivate');
        flash_set('admin_notice', 'Partner reactivated.');
    }

    if ($postAction === 'assign_manager' && $targetId) {
        $newManagerId = ($_POST['assigned_admin_id'] ?? '') !== '' ? (int) $_POST['assigned_admin_id'] : null;
        $pdo->prepare('UPDATE partners SET assigned_admin_id = :manager WHERE id = :id')
            ->execute(['manager' => $newManagerId, 'id' => $targetId]);
        log_action('assign_manager', 'partners', $targetId, null, $newManagerId !== null ? (string) $newManagerId : 'unassigned');
        flash_set('admin_notice', 'Relationship Manager updated.');
    }

    redirect('/admin/partners/');
}

// --- Detail view ---
if ($action === 'view' && $id) {
    $where = 'p.id = :id AND p.deleted_at IS NULL';
    $params = ['id' => $id];
    if ($scopedToAssigned) {
        $where .= ' AND p.assigned_admin_id = :current_admin';
        $params['current_admin'] = current_admin_id();
    }
    $stmt = $pdo->prepare(
        "SELECT p.*, m.full_name AS manager_name, a.full_name AS approved_by_name
         FROM partners p
         LEFT JOIN admin_users m ON m.id = p.assigned_admin_id
         LEFT JOIN admin_users a ON a.id = p.approved_by
         WHERE $where"
    );
    $stmt->execute($params);
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

    $commissionsStmt = $pdo->prepare(
        "SELECT pc.*, va.application_reference_no, c.first_name, c.last_name
         FROM partner_commissions pc
         JOIN visa_applications va ON va.id = pc.visa_application_id
         JOIN customers c ON c.id = va.customer_id
         WHERE pc.partner_id = :id ORDER BY pc.created_at DESC"
    );
    $commissionsStmt->execute(['id' => $id]);
    $commissions = $commissionsStmt->fetchAll();

    $historyStmt = $pdo->prepare(
        'SELECT h.*, a.full_name AS changed_by_name FROM partner_status_history h
         LEFT JOIN admin_users a ON a.id = h.changed_by
         WHERE h.partner_id = :id ORDER BY h.created_at DESC'
    );
    $historyStmt->execute(['id' => $id]);
    $history = $historyStmt->fetchAll();

    admin_header_start($partner['company_name'], 'partners');
    ?>
    <div class="admin-form-card" style="max-width:900px;margin-bottom:var(--space-6)">
        <p><strong>Reference:</strong> <?= e($partner['partner_reference_no']) ?></p>
        <p><strong>Contact:</strong> <?= e($partner['contact_name']) ?> &middot; <?= e($partner['email']) ?><?= $partner['mobile'] ? ' · ' . e($partner['mobile']) : '' ?></p>
        <p><strong>Status:</strong> <?= status_badge((string) $partner['status'], $partnerStatusBadgeMap) ?></p>
        <p><strong>Registered:</strong> <?= e(date('d M Y', strtotime((string) $partner['created_at']))) ?><?php if ($partner['approved_at']): ?> &middot; <strong>Approved:</strong> <?= e(date('d M Y', strtotime((string) $partner['approved_at']))) ?><?= $partner['approved_by_name'] ? ' by ' . e($partner['approved_by_name']) : '' ?><?php endif; ?></p>
        <p><strong>Relationship Manager:</strong> <?= e($partner['manager_name'] ?? 'Unassigned') ?></p>

        <?php if (has_permission('partners.manage')): ?>
        <div style="display:flex;gap:var(--space-4);flex-wrap:wrap;margin-top:var(--space-4)">
            <form method="post" action="/admin/partners/">
                <?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>">
                <?php if ($partner['status'] === 'pending'): ?>
                <button type="submit" name="action" value="approve" class="btn btn-primary btn-sm">Approve</button>
                <?php elseif ($partner['status'] === 'active'): ?>
                <button type="submit" name="action" value="suspend" class="btn btn-outline btn-sm">Suspend</button>
                <?php else: ?>
                <button type="submit" name="action" value="reactivate" class="btn btn-outline btn-sm">Reactivate</button>
                <?php endif; ?>
            </form>
            <form method="post" action="/admin/partners/" style="display:flex;gap:var(--space-2);align-items:center">
                <?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="action" value="assign_manager">
                <select name="assigned_admin_id" class="form-select">
                    <option value="">Unassigned</option>
                    <?php foreach ($admins as $a): ?>
                    <option value="<?= (int) $a['id'] ?>"<?= (int) $a['id'] === (int) ($partner['assigned_admin_id'] ?? 0) ? ' selected' : '' ?>><?= e($a['full_name']) ?></option>
                    <?php endforeach; ?>
                </select>
                <button type="submit" class="btn btn-outline btn-sm">Set Manager</button>
            </form>
        </div>
        <?php endif; ?>
    </div>

    <h2 class="country-directory__subheading">Referred Customers &amp; Applications (<?= count($referred) ?>)</h2>
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

    <h2 class="country-directory__subheading">Commissions</h2>
    <?php if (!$commissions): ?>
    <p class="empty-state">No commissions recorded yet.</p>
    <?php else: ?>
    <table class="admin-table"><thead><tr><th>Customer</th><th>Application</th><th>Amount</th><th>Status</th></tr></thead><tbody>
        <?php foreach ($commissions as $c): ?>
        <tr>
            <td><?= e($c['first_name'] . ' ' . ($c['last_name'] ?? '')) ?></td>
            <td><?= e($c['application_reference_no']) ?></td>
            <td><?= $c['amount_due'] !== null ? e(format_money((float) $c['amount_due'], (string) $c['currency'])) : 'Pending review' ?></td>
            <td><span class="badge <?= $c['status'] === 'paid' ? 'badge-success' : ($c['status'] === 'approved' ? 'badge-info' : 'badge-warning') ?>"><?= e($c['status']) ?></span></td>
        </tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php endif; ?>

    <h2 class="country-directory__subheading">Status History</h2>
    <?php if (!$history): ?>
    <p class="empty-state">No status changes recorded yet.</p>
    <?php else: ?>
    <table class="admin-table"><thead><tr><th>From</th><th>To</th><th>Changed By</th><th>When</th></tr></thead><tbody>
        <?php foreach ($history as $h): ?>
        <tr>
            <td><?= e($h['from_status'] !== null ? ucfirst((string) $h['from_status']) : '—') ?></td>
            <td><?= e(ucfirst((string) $h['to_status'])) ?></td>
            <td><?= e($h['changed_by_name'] ?? '—') ?></td>
            <td><?= e(date('d M Y H:i', strtotime((string) $h['created_at']))) ?></td>
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
$statusFilter = in_array($_GET['status'] ?? '', ['pending', 'active', 'suspended'], true) ? $_GET['status'] : null;
$page = max(1, (int) ($_GET['page'] ?? 1));
$perPage = 25;
$offset = ($page - 1) * $perPage;

$where = ['p.deleted_at IS NULL'];
$params = [];
if ($search !== '') {
    $where[] = '(p.company_name LIKE :search1 OR p.contact_name LIKE :search2 OR p.email LIKE :search3 OR p.partner_reference_no LIKE :search4 OR p.mobile LIKE :search5)';
    $searchTerm = "%$search%";
    $params['search1'] = $params['search2'] = $params['search3'] = $params['search4'] = $params['search5'] = $searchTerm;
}
if ($statusFilter) {
    $where[] = 'p.status = :status';
    $params['status'] = $statusFilter;
}
if ($scopedToAssigned) {
    $where[] = 'p.assigned_admin_id = :current_admin';
    $params['current_admin'] = current_admin_id();
}
$whereSql = implode(' AND ', $where);

$countStmt = $pdo->prepare("SELECT COUNT(*) FROM partners p WHERE $whereSql");
$countStmt->execute($params);
$total = (int) $countStmt->fetchColumn();
$totalPages = max(1, (int) ceil($total / $perPage));

$stmt = $pdo->prepare(
    "SELECT p.*, m.full_name AS manager_name FROM partners p
     LEFT JOIN admin_users m ON m.id = p.assigned_admin_id
     WHERE $whereSql ORDER BY (p.status = 'pending') DESC, p.created_at DESC LIMIT $perPage OFFSET $offset"
);
$stmt->execute($params);
$partners = $stmt->fetchAll();

$pendingCountStmt = $pdo->query("SELECT COUNT(*) FROM partners WHERE status = 'pending' AND deleted_at IS NULL");
$pendingCount = (int) $pendingCountStmt->fetchColumn();

admin_header_start('Partners', 'partners');
?>
<?php if ($pendingCount > 0): ?>
<div class="alert alert-warning"><?= $pendingCount ?> partner<?= $pendingCount === 1 ? '' : 's' ?> awaiting approval.</div>
<?php endif; ?>
<div class="admin-toolbar">
    <form method="get" action="/admin/partners/" style="display:flex;gap:var(--space-2);flex-wrap:wrap">
        <input class="form-input" type="search" name="q" value="<?= e($search) ?>" placeholder="Search company, contact, email, reference, mobile…">
        <select class="form-select" name="status">
            <option value="">All statuses</option>
            <?php foreach (['pending', 'active', 'suspended'] as $s): ?>
            <option value="<?= $s ?>"<?= $statusFilter === $s ? ' selected' : '' ?>><?= ucfirst($s) ?></option>
            <?php endforeach; ?>
        </select>
        <button type="submit" class="btn btn-outline">Search</button>
    </form>
</div>
<table class="admin-table">
    <thead><tr><th>Company</th><th>Contact</th><th>Reference</th><th>Manager</th><th>Status</th><th>Registered</th></tr></thead>
    <tbody>
    <?php foreach ($partners as $p): ?>
        <tr>
            <td><a href="/admin/partners/?action=view&id=<?= (int) $p['id'] ?>"><?= e($p['company_name']) ?></a></td>
            <td><?= e($p['contact_name']) ?> &middot; <?= e($p['email']) ?></td>
            <td><?= e($p['partner_reference_no']) ?></td>
            <td><?= e($p['manager_name'] ?? '—') ?></td>
            <td><?= status_badge((string) $p['status'], $partnerStatusBadgeMap) ?></td>
            <td><?= e(date('d M Y', strtotime((string) $p['created_at']))) ?></td>
        </tr>
    <?php endforeach; ?>
    <?php if (!$partners): ?>
        <tr><td colspan="6"><p class="empty-state">No partners found.</p></td></tr>
    <?php endif; ?>
    </tbody>
</table>
<?php if ($totalPages > 1): ?>
<div class="button-group" style="margin-top:var(--space-5)">
    <?php for ($p = 1; $p <= $totalPages; $p++): ?>
    <a href="/admin/partners/?page=<?= $p ?><?= $search !== '' ? '&q=' . urlencode($search) : '' ?><?= $statusFilter ? '&status=' . urlencode($statusFilter) : '' ?>" class="btn btn-sm <?= $p === $page ? 'btn-primary' : 'btn-outline' ?>"><?= $p ?></a>
    <?php endfor; ?>
</div>
<?php endif; ?>
<?php
admin_header_end();
