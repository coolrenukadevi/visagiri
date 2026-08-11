<?php
declare(strict_types=1);

$pdo = db();
$statusFilter = $_GET['status'] ?? '';
$validStatuses = ['open', 'in_progress', 'resolved', 'closed'];

$sql = "SELECT t.*, u.full_name, u.email, s.full_name AS assignee_name
        FROM support_tickets t
        JOIN users u ON u.id = t.user_id
        LEFT JOIN users s ON s.id = t.assigned_to
        WHERE 1 = 1";
$params = [];
if (in_array($statusFilter, $validStatuses, true)) {
    $sql .= ' AND t.status = :status';
    $params['status'] = $statusFilter;
}
$sql .= ' ORDER BY t.created_at DESC';

$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$tickets = $stmt->fetchAll();

$staff = $pdo->query(
    "SELECT u.id, u.full_name FROM users u JOIN roles r ON r.id = u.role_id
     WHERE r.name IN ('super_admin', 'admin', 'support', 'consultant') AND u.deleted_at IS NULL AND u.status = 'active'
     ORDER BY u.full_name"
)->fetchAll();

render_admin_start('support', 'Support Tickets');
?>
<div class="button-group" style="margin-bottom:var(--space-6);flex-wrap:wrap">
    <a href="/admin/support/" class="btn btn-sm <?= $statusFilter === '' ? 'btn-primary' : 'btn-outline' ?>">All</a>
    <?php foreach ($validStatuses as $s): ?>
    <a href="/admin/support/?status=<?= e($s) ?>" class="btn btn-sm <?= $statusFilter === $s ? 'btn-primary' : 'btn-outline' ?>"><?= e(str_replace('_', ' ', $s)) ?></a>
    <?php endforeach; ?>
</div>

<?php if ($tickets): ?>
<?php foreach ($tickets as $ticket): ?>
<div class="card" style="margin-bottom:var(--space-4)">
    <div class="document-row__top">
        <div>
            <span class="list-row__title"><?= e($ticket['subject']) ?></span>
            <div class="list-row__meta"><?= e($ticket['full_name']) ?> (<?= e($ticket['email']) ?>) &middot; <?= e(date('d M Y, g:i A', strtotime((string) $ticket['created_at']))) ?></div>
        </div>
        <span class="badge badge-<?= match ($ticket['status']) { 'resolved' => 'success', 'closed' => 'neutral', 'in_progress' => 'warning', default => 'info' } ?>"><?= e(str_replace('_', ' ', $ticket['status'])) ?></span>
    </div>
    <p style="margin:var(--space-3) 0"><?= nl2br(e($ticket['message'])) ?></p>
    <form method="post" action="/admin/support/<?= (int) $ticket['id'] ?>/" class="document-row__upload">
        <?= csrf_field() ?>
        <select class="form-select" name="status" style="max-width:180px">
            <?php foreach ($validStatuses as $s): ?>
            <option value="<?= e($s) ?>" <?= $ticket['status'] === $s ? 'selected' : '' ?>><?= e(str_replace('_', ' ', $s)) ?></option>
            <?php endforeach; ?>
        </select>
        <select class="form-select" name="assigned_to" style="max-width:220px">
            <option value="">Unassigned</option>
            <?php foreach ($staff as $member): ?>
            <option value="<?= (int) $member['id'] ?>" <?= (int) ($ticket['assigned_to'] ?? 0) === (int) $member['id'] ? 'selected' : '' ?>><?= e($member['full_name']) ?></option>
            <?php endforeach; ?>
        </select>
        <button type="submit" class="btn btn-sm btn-primary">Save</button>
    </form>
</div>
<?php endforeach; ?>
<?php else: ?>
<p class="empty-state">No support tickets match this filter.</p>
<?php endif; ?>
<?php render_admin_end(); ?>
