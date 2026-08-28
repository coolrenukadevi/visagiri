<?php
declare(strict_types=1);

/**
 * B2B partner-program lead capture — mirrors admin/pages/general-
 * enquiries.php's list/detail/status pattern exactly (this is the
 * same kind of "public form -> staff follow-up" record), scoped to
 * the partners.* permission namespace since these leads are
 * specifically prospective partners, not a general enquiry type.
 */

require_permission('partners.view');

$pdo = db();
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);
$employees = $pdo->query('SELECT id, full_name FROM admin_users WHERE status = "active" ORDER BY full_name')->fetchAll();
$statuses = ['new', 'contacted', 'converted', 'closed'];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_permission('partners.manage');
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'update' && $id) {
        $before = $pdo->prepare('SELECT status, assigned_admin_id FROM partner_enquiries WHERE id = :id');
        $before->execute(['id' => $id]);
        $prev = $before->fetch();

        $status = $_POST['status'] ?? '';
        $assignedAdmin = (int) ($_POST['assigned_admin_id'] ?? 0) ?: null;
        if (in_array($status, $statuses, true)) {
            $pdo->prepare('UPDATE partner_enquiries SET status = :status, assigned_admin_id = :assigned WHERE id = :id')
                ->execute(['status' => $status, 'assigned' => $assignedAdmin, 'id' => $id]);
            if ($prev && $prev['status'] !== $status) {
                log_action('status_change', 'partner_enquiries', $id, $prev['status'], $status);
            }
            if ($prev && (int) ($prev['assigned_admin_id'] ?? 0) !== ($assignedAdmin ?? 0)) {
                log_action('assignment', 'partner_enquiries', $id, (string) $prev['assigned_admin_id'], (string) $assignedAdmin);
            }
            flash_set('admin_notice', 'Enquiry updated.');
        }
        redirect('/admin/partner-enquiries/?id=' . $id);
    }

    if ($postAction === 'delete' && $id) {
        $pdo->prepare('UPDATE partner_enquiries SET deleted_at = NOW(), deleted_by = :admin WHERE id = :id')
            ->execute(['admin' => current_admin_id(), 'id' => $id]);
        log_action('delete', 'partner_enquiries', $id);
        flash_set('admin_notice', 'Enquiry removed (soft delete).');
        redirect('/admin/partner-enquiries/');
    }
}

if ($id) {
    $stmt = $pdo->prepare(
        'SELECT pe.*, a.full_name AS assigned_name FROM partner_enquiries pe
         LEFT JOIN admin_users a ON a.id = pe.assigned_admin_id
         WHERE pe.id = :id AND pe.deleted_at IS NULL'
    );
    $stmt->execute(['id' => $id]);
    $enquiry = $stmt->fetch();
    if (!$enquiry) {
        flash_set('admin_error', 'Enquiry not found.');
        redirect('/admin/partner-enquiries/');
    }

    admin_header_start('Enquiry ' . $enquiry['reference_number'], 'partner-enquiries');
    ?>
    <div class="admin-form-card">
        <p><strong>Reference:</strong> <?= e($enquiry['reference_number']) ?></p>
        <p><strong>Company:</strong> <?= e($enquiry['company_name']) ?><?= $enquiry['business_type'] ? ' (' . e(PARTNER_BUSINESS_TYPES[$enquiry['business_type']] ?? $enquiry['business_type']) . ')' : '' ?></p>
        <p><strong>Contact:</strong> <?= e($enquiry['contact_name']) ?></p>
        <p><strong>Email:</strong> <?= e($enquiry['email']) ?> &middot; <strong>Mobile:</strong> <?= e($enquiry['mobile']) ?></p>
        <?php if ($enquiry['message']): ?><p><strong>Message:</strong><br><?= nl2br(e($enquiry['message'])) ?></p><?php endif; ?>
        <p><strong>Received:</strong> <?= e(date('d M Y H:i', strtotime((string) $enquiry['created_at']))) ?></p>

        <?php if (has_permission('partners.manage')): ?>
        <form method="post" action="/admin/partner-enquiries/?id=<?= (int) $enquiry['id'] ?>" style="margin-top:var(--space-5)">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="update">
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="status">Status</label>
                    <select class="form-select" id="status" name="status">
                        <?php foreach ($statuses as $s): ?>
                        <option value="<?= $s ?>"<?= $enquiry['status'] === $s ? ' selected' : '' ?>><?= ucfirst($s) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="assigned_admin_id">Assigned To</label>
                    <select class="form-select" id="assigned_admin_id" name="assigned_admin_id">
                        <option value="">— Unassigned —</option>
                        <?php foreach ($employees as $emp): ?>
                        <option value="<?= (int) $emp['id'] ?>"<?= (int) ($enquiry['assigned_admin_id'] ?? 0) === (int) $emp['id'] ? ' selected' : '' ?>><?= e($emp['full_name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Update</button>
        </form>
        <p style="color:var(--text-muted);font-size:var(--font-size-sm);margin-top:var(--space-2)">"Converted" is a status only — this doesn't automatically create a partner account. Help the prospect through <a href="/partner/register/" target="_blank" rel="noopener noreferrer">the registration wizard</a> or point them to it directly.</p>
        <form method="post" action="/admin/partner-enquiries/" style="margin-top:var(--space-3)" onsubmit="return confirm('Remove this enquiry?');">
            <?= csrf_field() ?><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<?= $id ?>">
            <button type="submit" class="btn btn-outline btn-sm">Delete</button>
        </form>
        <?php endif; ?>
    </div>
    <p style="margin-top:var(--space-6)"><a href="/admin/partner-enquiries/">&larr; Back to all enquiries</a></p>
    <?php
    admin_header_end();
    exit;
}

$statusFilter = in_array($_GET['status'] ?? '', $statuses, true) ? $_GET['status'] : null;
$where = ['deleted_at IS NULL'];
$params = [];
if ($statusFilter) {
    $where[] = 'status = :status';
    $params['status'] = $statusFilter;
}
$whereSql = 'WHERE ' . implode(' AND ', $where);

$stmt = $pdo->prepare("SELECT * FROM partner_enquiries $whereSql ORDER BY created_at DESC LIMIT 100");
$stmt->execute($params);
$enquiries = $stmt->fetchAll();

admin_header_start('Partner Enquiries', 'partner-enquiries');
?>
<div class="admin-toolbar">
    <div class="button-group">
        <a href="/admin/partner-enquiries/" class="btn btn-sm <?= !$statusFilter ? 'btn-primary' : 'btn-outline' ?>">All</a>
        <?php foreach ($statuses as $s): ?>
        <a href="/admin/partner-enquiries/?status=<?= $s ?>" class="btn btn-sm <?= $statusFilter === $s ? 'btn-primary' : 'btn-outline' ?>"><?= ucfirst($s) ?></a>
        <?php endforeach; ?>
    </div>
</div>
<?php if ($enquiries): ?>
<table class="admin-table">
    <thead><tr><th>Reference</th><th>Company</th><th>Contact</th><th>Status</th><th>Received</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($enquiries as $enq): ?>
        <tr>
            <td><?= e($enq['reference_number']) ?></td>
            <td><?= e($enq['company_name']) ?></td>
            <td><?= e($enq['contact_name']) ?></td>
            <td><span class="badge badge-info"><?= e(ucfirst($enq['status'])) ?></span></td>
            <td><?= e(date('d M Y H:i', strtotime((string) $enq['created_at']))) ?></td>
            <td class="actions"><a href="/admin/partner-enquiries/?id=<?= (int) $enq['id'] ?>" class="btn btn-outline btn-sm">View</a></td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php else: ?>
<p class="empty-state">No partner enquiries yet.</p>
<?php endif; ?>
<?php
admin_header_end();
