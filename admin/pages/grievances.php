<?php
declare(strict_types=1);

/**
 * Grievance CRM — same list/detail/status/assignment/soft-delete/
 * audit-logged shape as admin/pages/general-enquiries.php (the closest
 * existing pattern), plus the two things a grievance needs that a
 * general enquiry doesn't: a real, render-time-computed SLA-breach
 * badge (sla_due_at < NOW() and not yet resolved/closed — no cron
 * anywhere in this project, so this is never a stored flag, always
 * computed fresh) and a manual Escalate action that reassigns to any
 * other admin holding grievances.manage and logs it via the existing
 * log_action() audit pattern. No new roles, no automatic multi-level
 * escalation — see AUDIT.md's Legal & Support Centre entry.
 */

require_permission('grievances.view');

$pdo = db();
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);
$employees = $pdo->query('SELECT id, full_name FROM admin_users WHERE status = "active" ORDER BY full_name')->fetchAll();
$statuses = ['new', 'in_progress', 'resolved', 'closed'];

/** @return array<int,string> id => full_name, for admins holding grievances.manage */
function grievance_eligible_admins(PDO $pdo): array
{
    $rows = $pdo->query(
        "SELECT DISTINCT au.id, au.full_name FROM admin_users au
         JOIN role_permissions rp ON rp.role_id = au.role_id
         JOIN permissions p ON p.id = rp.permission_id
         WHERE p.permission_key = 'grievances.manage' AND au.status = 'active'
         ORDER BY au.full_name"
    )->fetchAll();
    $out = [];
    foreach ($rows as $row) {
        $out[(int) $row['id']] = $row['full_name'];
    }
    return $out;
}

function grievance_is_breached(array $grievance): bool
{
    return $grievance['sla_due_at'] !== null
        && strtotime((string) $grievance['sla_due_at']) < time()
        && !in_array($grievance['status'], ['resolved', 'closed'], true);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_permission('grievances.manage');
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'update' && $id) {
        $before = $pdo->prepare('SELECT status, priority, assigned_user FROM grievances WHERE id = :id');
        $before->execute(['id' => $id]);
        $prev = $before->fetch();

        $status = $_POST['status'] ?? '';
        $priority = in_array($_POST['priority'] ?? '', ['low', 'normal', 'high', 'urgent'], true) ? $_POST['priority'] : 'normal';
        $assignedUser = (int) ($_POST['assigned_user'] ?? 0) ?: null;

        if (in_array($status, $statuses, true)) {
            $sql = 'UPDATE grievances SET status = :status, priority = :priority, assigned_user = :assigned'
                . ($status === 'resolved' && $prev && $prev['status'] !== 'resolved' ? ', resolved_at = NOW()' : '')
                . ' WHERE id = :id';
            $pdo->prepare($sql)->execute([
                'status' => $status,
                'priority' => $priority,
                'assigned' => $assignedUser,
                'id' => $id,
            ]);
            if ($prev && $prev['status'] !== $status) {
                log_action('status_change', 'grievances', $id, $prev['status'], $status);
            }
            if ($prev && (int) ($prev['assigned_user'] ?? 0) !== ($assignedUser ?? 0)) {
                log_action('assignment', 'grievances', $id, (string) $prev['assigned_user'], (string) $assignedUser);
            }
            flash_set('admin_notice', 'Grievance updated.');
        }
        redirect('/admin/grievances/?id=' . $id);
    }

    if ($postAction === 'escalate' && $id) {
        $before = $pdo->prepare('SELECT assigned_user FROM grievances WHERE id = :id');
        $before->execute(['id' => $id]);
        $prev = $before->fetch();

        $newAssignee = (int) ($_POST['escalate_to'] ?? 0);
        $reason = trim((string) ($_POST['escalation_reason'] ?? ''));
        $eligible = grievance_eligible_admins($pdo);

        if ($newAssignee && isset($eligible[$newAssignee]) && $reason !== '') {
            $pdo->prepare(
                'UPDATE grievances SET assigned_user = :new_assignee, escalated_at = NOW(), escalated_from_user = :prev_assignee, escalation_reason = :reason WHERE id = :id'
            )->execute([
                'new_assignee' => $newAssignee,
                'prev_assignee' => $prev['assigned_user'] ?? null,
                'reason' => $reason,
                'id' => $id,
            ]);
            log_action('escalation', 'grievances', $id, (string) ($prev['assigned_user'] ?? ''), (string) $newAssignee);
            flash_set('admin_notice', 'Grievance escalated.');
        } else {
            flash_set('admin_error', 'Select who to escalate to and provide a reason.');
        }
        redirect('/admin/grievances/?id=' . $id);
    }

    if ($postAction === 'delete' && $id) {
        $pdo->prepare('UPDATE grievances SET deleted_at = NOW(), deleted_by = :admin WHERE id = :id')
            ->execute(['admin' => current_admin_id(), 'id' => $id]);
        log_action('delete', 'grievances', $id);
        flash_set('admin_notice', 'Grievance removed (soft delete).');
        redirect('/admin/grievances/');
    }
}

if ($id) {
    $stmt = $pdo->prepare(
        'SELECT g.*, a.full_name AS assigned_name, e.full_name AS escalated_from_name
         FROM grievances g
         LEFT JOIN admin_users a ON a.id = g.assigned_user
         LEFT JOIN admin_users e ON e.id = g.escalated_from_user
         WHERE g.id = :id AND g.deleted_at IS NULL'
    );
    $stmt->execute(['id' => $id]);
    $grievance = $stmt->fetch();
    if (!$grievance) {
        flash_set('admin_error', 'Grievance not found.');
        redirect('/admin/grievances/');
    }

    $documents = $pdo->prepare('SELECT * FROM documents WHERE grievance_id = :id AND deleted_at IS NULL ORDER BY uploaded_at DESC');
    $documents->execute(['id' => $id]);
    $documentRows = $documents->fetchAll();

    $isBreached = grievance_is_breached($grievance);
    $eligibleAdmins = grievance_eligible_admins($pdo);

    admin_header_start('Grievance ' . $grievance['grievance_reference_no'], 'grievances');
    ?>
    <div class="admin-form-card">
        <p><strong>Reference:</strong> <?= e($grievance['grievance_reference_no']) ?></p>
        <p><strong>Category:</strong> <?= e(GRIEVANCE_CATEGORIES[$grievance['category']] ?? ucfirst(str_replace('_', ' ', $grievance['category']))) ?></p>
        <p><strong>Name:</strong> <?= e($grievance['name']) ?></p>
        <p><strong>Email:</strong> <?= e($grievance['email']) ?> &middot; <strong>Phone:</strong> <?= e($grievance['phone'] ?? 'Not provided') ?></p>
        <?php if ($grievance['related_reference_no']): ?><p><strong>Related Reference:</strong> <?= e($grievance['related_reference_no']) ?></p><?php endif; ?>
        <p><strong>Preferred Contact:</strong> <?= e(ucfirst((string) $grievance['preferred_contact_method'])) ?></p>
        <p><strong>Description:</strong><br><?= nl2br(e($grievance['description'])) ?></p>
        <p><strong>Received:</strong> <?= e(date('d M Y H:i', strtotime((string) $grievance['created_at']))) ?></p>
        <p>
            <strong>SLA Due:</strong>
            <?php if ($grievance['sla_due_at'] === null): ?>
            <span class="badge badge-neutral">Not set</span>
            <?php elseif ($isBreached): ?>
            <span class="badge badge-danger">SLA Breached &mdash; was due <?= e(date('d M Y H:i', strtotime((string) $grievance['sla_due_at']))) ?></span>
            <?php else: ?>
            <span class="badge badge-info">Due <?= e(date('d M Y H:i', strtotime((string) $grievance['sla_due_at']))) ?></span>
            <?php endif; ?>
        </p>
        <?php if ($grievance['escalated_at']): ?>
        <p><strong>Escalated:</strong> from <?= e($grievance['escalated_from_name'] ?? 'Unassigned') ?> on <?= e(date('d M Y H:i', strtotime((string) $grievance['escalated_at']))) ?> &mdash; <?= e($grievance['escalation_reason']) ?></p>
        <?php endif; ?>

        <?php if (has_permission('grievances.manage')): ?>
        <form method="post" action="/admin/grievances/?id=<?= (int) $grievance['id'] ?>" style="margin-top:var(--space-5)">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="update">
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="status">Status</label>
                    <select class="form-select" id="status" name="status">
                        <?php foreach ($statuses as $s): ?>
                        <option value="<?= $s ?>"<?= $grievance['status'] === $s ? ' selected' : '' ?>><?= ucwords(str_replace('_', ' ', $s)) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="priority">Priority</label>
                    <select class="form-select" id="priority" name="priority">
                        <?php foreach (['low', 'normal', 'high', 'urgent'] as $p): ?>
                        <option value="<?= $p ?>"<?= $grievance['priority'] === $p ? ' selected' : '' ?>><?= ucfirst($p) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="assigned_user">Assigned To</label>
                    <select class="form-select" id="assigned_user" name="assigned_user">
                        <option value="">— Unassigned —</option>
                        <?php foreach ($employees as $emp): ?>
                        <option value="<?= (int) $emp['id'] ?>"<?= (int) ($grievance['assigned_user'] ?? 0) === (int) $emp['id'] ? ' selected' : '' ?>><?= e($emp['full_name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Update</button>
        </form>

        <form method="post" action="/admin/grievances/?id=<?= (int) $grievance['id'] ?>" style="margin-top:var(--space-4)">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="escalate">
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="escalate_to">Escalate To</label>
                    <select class="form-select" id="escalate_to" name="escalate_to" required>
                        <option value="">Select an admin</option>
                        <?php foreach ($eligibleAdmins as $adminId => $adminName): ?>
                        <option value="<?= (int) $adminId ?>"><?= e($adminName) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="escalation_reason">Reason</label>
                    <input class="form-input" type="text" id="escalation_reason" name="escalation_reason" placeholder="Why this needs more senior attention" required>
                </div>
            </div>
            <button type="submit" class="btn btn-outline">Escalate</button>
        </form>

        <form method="post" action="/admin/grievances/" style="margin-top:var(--space-3)" onsubmit="return confirm('Remove this grievance?');">
            <?= csrf_field() ?><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<?= $id ?>">
            <button type="submit" class="btn btn-outline btn-sm">Delete</button>
        </form>
        <?php endif; ?>
    </div>

    <?php if ($documentRows): ?>
    <h2 class="country-directory__subheading">Attachments</h2>
    <table class="admin-table"><thead><tr><th>File</th><th>Type</th><th></th></tr></thead><tbody>
        <?php foreach ($documentRows as $r): ?>
        <tr>
            <td><?= e($r['original_filename']) ?></td>
            <td><?= e($r['document_type'] ?? '—') ?></td>
            <td class="actions"><a href="/admin/document-download/?id=<?= (int) $r['id'] ?>" class="btn btn-outline btn-sm">Download</a></td>
        </tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php endif; ?>

    <p style="margin-top:var(--space-6)"><a href="/admin/grievances/">&larr; Back to all grievances</a></p>
    <?php
    admin_header_end();
    exit;
}

$statusFilter = in_array($_GET['status'] ?? '', $statuses, true) ? $_GET['status'] : null;
$slaFilter = ($_GET['sla'] ?? '') === 'breached';
$where = ['deleted_at IS NULL'];
$params = [];
if ($statusFilter) {
    $where[] = 'status = :status';
    $params['status'] = $statusFilter;
}
if ($slaFilter) {
    $where[] = "sla_due_at IS NOT NULL AND sla_due_at < NOW() AND status NOT IN ('resolved', 'closed')";
}
$whereSql = 'WHERE ' . implode(' AND ', $where);

$stmt = $pdo->prepare("SELECT * FROM grievances $whereSql ORDER BY created_at DESC LIMIT 100");
$stmt->execute($params);
$grievances = $stmt->fetchAll();

admin_header_start('Grievances', 'grievances');
?>
<div class="admin-toolbar">
    <div class="button-group">
        <a href="/admin/grievances/" class="btn btn-sm <?= !$statusFilter && !$slaFilter ? 'btn-primary' : 'btn-outline' ?>">All</a>
        <?php foreach ($statuses as $s): ?>
        <a href="/admin/grievances/?status=<?= $s ?>" class="btn btn-sm <?= $statusFilter === $s ? 'btn-primary' : 'btn-outline' ?>"><?= ucwords(str_replace('_', ' ', $s)) ?></a>
        <?php endforeach; ?>
        <a href="/admin/grievances/?sla=breached" class="btn btn-sm <?= $slaFilter ? 'btn-danger' : 'btn-outline' ?>">SLA Breached</a>
    </div>
</div>
<?php if ($grievances): ?>
<table class="admin-table">
    <thead><tr><th>Reference</th><th>Category</th><th>Name</th><th>Status</th><th>SLA</th><th>Received</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($grievances as $g): ?>
        <tr>
            <td><?= e($g['grievance_reference_no']) ?></td>
            <td><?= e(GRIEVANCE_CATEGORIES[$g['category']] ?? ucfirst(str_replace('_', ' ', $g['category']))) ?></td>
            <td><?= e($g['name']) ?></td>
            <td><span class="badge badge-info"><?= e(ucwords(str_replace('_', ' ', $g['status']))) ?></span></td>
            <td>
                <?php if (grievance_is_breached($g)): ?>
                <span class="badge badge-danger">Breached</span>
                <?php elseif ($g['sla_due_at'] !== null): ?>
                <span class="badge badge-neutral">On track</span>
                <?php endif; ?>
            </td>
            <td><?= e(date('d M Y H:i', strtotime((string) $g['created_at']))) ?></td>
            <td class="actions"><a href="/admin/grievances/?id=<?= (int) $g['id'] ?>" class="btn btn-outline btn-sm">View</a></td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php else: ?>
<p class="empty-state">No grievances<?= $slaFilter ? ' breaching SLA' : '' ?> yet.</p>
<?php endif; ?>
<?php
admin_header_end();
