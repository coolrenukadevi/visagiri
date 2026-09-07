<?php
declare(strict_types=1);

/**
 * Admin management of B2B Travel Partner Portal support tickets
 * (b2b_support_tickets) — Phase B8. Same list+detail pattern as the
 * other B2B admin pages, reusing the same b2b_travel_partners.* RBAC
 * namespace since this is still a B2B-portal-scoped concern.
 */

require_permission('b2b_travel_partners.view');

$pdo = db();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);

$admins = $pdo->query('SELECT id, full_name FROM admin_users WHERE status = "active" ORDER BY full_name')->fetchAll();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_permission('b2b_travel_partners.manage');
    csrf_require();
    $postAction = $_POST['action'] ?? '';
    $targetId = (int) ($_POST['id'] ?? 0);

    if ($postAction === 'post_message' && $targetId) {
        $message = trim((string) ($_POST['message'] ?? ''));
        if ($message === '') {
            flash_set('admin_error', 'Enter a message.');
        } else {
            $pdo->prepare('INSERT INTO b2b_support_ticket_messages (b2b_support_ticket_id, sender_admin_id, message) VALUES (:id, :admin, :message)')
                ->execute(['id' => $targetId, 'admin' => current_admin_id(), 'message' => $message]);
            $pdo->prepare("UPDATE b2b_support_tickets SET status = 'in_progress' WHERE id = :id AND status = 'open'")->execute(['id' => $targetId]);

            $ticketRefStmt = $pdo->prepare('SELECT b2b_partner_id, ticket_reference_no FROM b2b_support_tickets WHERE id = :id');
            $ticketRefStmt->execute(['id' => $targetId]);
            if ($ticketRow = $ticketRefStmt->fetch()) {
                notify_b2b_partner((int) $ticketRow['b2b_partner_id'], 'ticket_reply', 'New reply on ' . $ticketRow['ticket_reference_no'], mb_substr($message, 0, 200), '/b2b/support/?action=view&id=' . $targetId);
            }
            flash_set('admin_notice', 'Reply sent.');
        }
        redirect('/admin/b2b-support-tickets/?action=view&id=' . $targetId);
    }

    if ($postAction === 'set_status' && $targetId) {
        $newStatus = $_POST['status'] ?? '';
        if (array_key_exists($newStatus, B2B_TICKET_STATUS_LABELS)) {
            $resolvedAt = $newStatus === 'resolved' ? ', resolved_at = NOW()' : '';
            $pdo->prepare("UPDATE b2b_support_tickets SET status = :status $resolvedAt WHERE id = :id")->execute(['status' => $newStatus, 'id' => $targetId]);
            log_action('b2b_ticket_status', 'b2b_support_tickets', $targetId, null, $newStatus);
            flash_set('admin_notice', 'Status updated.');
        }
        redirect('/admin/b2b-support-tickets/?action=view&id=' . $targetId);
    }

    if ($postAction === 'assign_manager' && $targetId) {
        $newManagerId = ($_POST['assigned_admin_id'] ?? '') !== '' ? (int) $_POST['assigned_admin_id'] : null;
        $pdo->prepare('UPDATE b2b_support_tickets SET assigned_admin_id = :manager WHERE id = :id')
            ->execute(['manager' => $newManagerId, 'id' => $targetId]);
        log_action('assign_manager', 'b2b_support_tickets', $targetId, null, $newManagerId !== null ? (string) $newManagerId : 'unassigned');
        flash_set('admin_notice', 'Assignee updated.');
        redirect('/admin/b2b-support-tickets/?action=view&id=' . $targetId);
    }

    redirect('/admin/b2b-support-tickets/');
}

if ($action === 'view' && $id) {
    $stmt = $pdo->prepare(
        'SELECT t.*, p.legal_business_name, p.partner_reference_no, m.full_name AS manager_name, u.full_name AS created_by_name
         FROM b2b_support_tickets t
         JOIN b2b_partners p ON p.id = t.b2b_partner_id
         JOIN b2b_partner_users u ON u.id = t.created_by_user_id
         LEFT JOIN admin_users m ON m.id = t.assigned_admin_id
         WHERE t.id = :id'
    );
    $stmt->execute(['id' => $id]);
    $ticket = $stmt->fetch();
    if (!$ticket) {
        flash_set('admin_error', 'Ticket not found.');
        redirect('/admin/b2b-support-tickets/');
    }

    $messagesStmt = $pdo->prepare(
        'SELECT m.*, a.full_name AS admin_name, u.full_name AS partner_user_name FROM b2b_support_ticket_messages m
         LEFT JOIN admin_users a ON a.id = m.sender_admin_id
         LEFT JOIN b2b_partner_users u ON u.id = m.sender_partner_user_id
         WHERE m.b2b_support_ticket_id = :id ORDER BY m.created_at ASC'
    );
    $messagesStmt->execute(['id' => $id]);
    $messages = $messagesStmt->fetchAll();

    $canManage = has_permission('b2b_travel_partners.manage');

    admin_header_start($ticket['ticket_reference_no'], 'b2b-support-tickets');
    admin_subnav('b2b', 'b2b-support-tickets');
    ?>
    <div class="admin-form-card" style="max-width:900px;margin-bottom:var(--space-6)">
        <p><strong>Partner:</strong> <a href="/admin/b2b-partners/?action=view&id=<?= (int) $ticket['b2b_partner_id'] ?>"><?= e($ticket['legal_business_name']) ?></a> (<?= e($ticket['partner_reference_no']) ?>)</p>
        <p><strong>Raised By:</strong> <?= e($ticket['created_by_name']) ?></p>
        <p><strong>Subject:</strong> <?= e($ticket['subject']) ?></p>
        <p><strong>Category:</strong> <?= e(B2B_TICKET_CATEGORIES[$ticket['category']] ?? $ticket['category']) ?> &middot; <strong>Priority:</strong> <?= e(B2B_TICKET_PRIORITY_LABELS[$ticket['priority']]) ?></p>
        <p><strong>Status:</strong> <span class="badge <?= $ticket['status'] === 'resolved' || $ticket['status'] === 'closed' ? 'badge-success' : 'badge-warning' ?>"><?= e(B2B_TICKET_STATUS_LABELS[$ticket['status']]) ?></span></p>

        <?php if ($canManage): ?>
        <form method="post" action="/admin/b2b-support-tickets/" style="display:flex;gap:var(--space-2);align-items:center;margin-top:var(--space-4)">
            <?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="action" value="set_status">
            <select name="status" class="form-select">
                <?php foreach (B2B_TICKET_STATUS_LABELS as $key => $label): ?>
                <option value="<?= e($key) ?>"<?= $ticket['status'] === $key ? ' selected' : '' ?>><?= e($label) ?></option>
                <?php endforeach; ?>
            </select>
            <button type="submit" class="btn btn-outline btn-sm">Update Status</button>
        </form>
        <form method="post" action="/admin/b2b-support-tickets/" style="display:flex;gap:var(--space-2);align-items:center;margin-top:var(--space-2)">
            <?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="action" value="assign_manager">
            <select name="assigned_admin_id" class="form-select">
                <option value="">Unassigned</option>
                <?php foreach ($admins as $a): ?>
                <option value="<?= (int) $a['id'] ?>"<?= (int) $a['id'] === (int) ($ticket['assigned_admin_id'] ?? 0) ? ' selected' : '' ?>><?= e($a['full_name']) ?></option>
                <?php endforeach; ?>
            </select>
            <button type="submit" class="btn btn-outline btn-sm">Assign</button>
        </form>
        <?php endif; ?>
    </div>

    <h2 class="country-directory__subheading">Conversation</h2>
    <div class="admin-form-card" style="margin-bottom:var(--space-4);max-height:400px;overflow-y:auto">
        <?php foreach ($messages as $m): ?>
        <p style="margin-bottom:var(--space-3)"><strong><?= $m['sender_admin_id'] ? e($m['admin_name'] ?? 'Admin') : e($m['partner_user_name'] ?? 'Partner') ?>:</strong> <?= nl2br(e($m['message'])) ?><br><span style="color:var(--text-muted);font-size:var(--font-size-sm)"><?= e(date('d M Y H:i', strtotime((string) $m['created_at']))) ?></span></p>
        <?php endforeach; ?>
    </div>
    <?php if ($canManage): ?>
    <form method="post" action="/admin/b2b-support-tickets/" style="margin-bottom:var(--space-6)">
        <?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="action" value="post_message">
        <textarea class="form-textarea" name="message" rows="3" placeholder="Reply…" required style="width:100%;max-width:520px"></textarea>
        <button type="submit" class="btn btn-outline btn-sm" style="margin-top:var(--space-2)">Reply</button>
    </form>
    <?php endif; ?>

    <p style="margin-top:var(--space-6)"><a href="/admin/b2b-support-tickets/">&larr; Back to all tickets</a></p>
    <?php
    admin_header_end();
    exit;
}

// --- List ---
$statusFilter = array_key_exists($_GET['status'] ?? '', B2B_TICKET_STATUS_LABELS) ? $_GET['status'] : null;
$where = ['1 = 1'];
$params = [];
if ($statusFilter) {
    $where[] = 't.status = :status';
    $params['status'] = $statusFilter;
}
$whereSql = implode(' AND ', $where);

$stmt = $pdo->prepare(
    "SELECT t.*, p.legal_business_name, m.full_name AS manager_name FROM b2b_support_tickets t
     JOIN b2b_partners p ON p.id = t.b2b_partner_id
     LEFT JOIN admin_users m ON m.id = t.assigned_admin_id
     WHERE $whereSql ORDER BY (t.status = 'open') DESC, t.created_at DESC"
);
$stmt->execute($params);
$tickets = $stmt->fetchAll();

$openCount = (int) $pdo->query("SELECT COUNT(*) FROM b2b_support_tickets WHERE status = 'open'")->fetchColumn();

admin_header_start('B2B Support Tickets', 'b2b-support-tickets');
admin_subnav('b2b', 'b2b-support-tickets');
?>
<?php if ($openCount > 0): ?>
<div class="alert alert-warning"><?= $openCount ?> open ticket<?= $openCount === 1 ? '' : 's' ?> awaiting a response.</div>
<?php endif; ?>
<div class="admin-toolbar">
    <form method="get" action="/admin/b2b-support-tickets/">
        <select class="form-select" name="status" onchange="this.form.submit()">
            <option value="">All statuses</option>
            <?php foreach (B2B_TICKET_STATUS_LABELS as $key => $label): ?>
            <option value="<?= e($key) ?>"<?= $statusFilter === $key ? ' selected' : '' ?>><?= e($label) ?></option>
            <?php endforeach; ?>
        </select>
    </form>
</div>
<table class="admin-table">
    <thead><tr><th>Reference</th><th>Partner</th><th>Subject</th><th>Category</th><th>Priority</th><th>Assigned</th><th>Status</th><th>Created</th></tr></thead>
    <tbody>
    <?php foreach ($tickets as $t): ?>
        <tr>
            <td><a href="/admin/b2b-support-tickets/?action=view&id=<?= (int) $t['id'] ?>"><?= e($t['ticket_reference_no']) ?></a></td>
            <td><?= e($t['legal_business_name']) ?></td>
            <td><?= e($t['subject']) ?></td>
            <td><?= e(B2B_TICKET_CATEGORIES[$t['category']] ?? $t['category']) ?></td>
            <td><?= e(B2B_TICKET_PRIORITY_LABELS[$t['priority']]) ?></td>
            <td><?= e($t['manager_name'] ?? '—') ?></td>
            <td><span class="badge <?= $t['status'] === 'resolved' || $t['status'] === 'closed' ? 'badge-success' : 'badge-warning' ?>"><?= e(B2B_TICKET_STATUS_LABELS[$t['status']]) ?></span></td>
            <td><?= e(date('d M Y', strtotime((string) $t['created_at']))) ?></td>
        </tr>
    <?php endforeach; ?>
    <?php if (!$tickets): ?>
        <tr><td colspan="8"><p class="empty-state">No support tickets found.</p></td></tr>
    <?php endif; ?>
    </tbody>
</table>
<?php
admin_header_end();
