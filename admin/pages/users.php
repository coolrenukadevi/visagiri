<?php
declare(strict_types=1);

$pdo = db();
$stmt = $pdo->query(
    "SELECT u.id, u.full_name, u.email, u.mobile, u.status, u.created_at,
            (SELECT COUNT(*) FROM applications a WHERE a.user_id = u.id AND a.deleted_at IS NULL) AS application_count
     FROM users u JOIN roles r ON r.id = u.role_id
     WHERE r.name = 'customer' AND u.deleted_at IS NULL
     ORDER BY u.created_at DESC"
);
$users = $stmt->fetchAll();

render_admin_start('users', 'Customers');
?>
<?php if ($users): ?>
<?php foreach ($users as $u): ?>
<div class="list-row">
    <span>
        <span class="list-row__title"><?= e($u['full_name']) ?></span><br>
        <span class="list-row__meta"><?= e($u['email']) ?> &middot; <?= e($u['mobile'] ?? 'no mobile on file') ?> &middot; <?= (int) $u['application_count'] ?> application(s) &middot; Joined <?= e(date('d M Y', strtotime((string) $u['created_at']))) ?></span>
    </span>
    <span style="display:flex;align-items:center;gap:var(--space-3)">
        <span class="badge badge-<?= $u['status'] === 'active' ? 'success' : 'danger' ?>"><?= e($u['status']) ?></span>
        <form method="post" action="/admin/users/<?= (int) $u['id'] ?>/toggle-status/" data-confirm="<?= $u['status'] === 'active' ? 'Suspend' : 'Reactivate' ?> this account?">
            <?= csrf_field() ?>
            <button type="submit" class="btn btn-sm btn-outline"><?= $u['status'] === 'active' ? 'Suspend' : 'Reactivate' ?></button>
        </form>
    </span>
</div>
<?php endforeach; ?>
<?php else: ?>
<p class="empty-state">No customer accounts yet.</p>
<?php endif; ?>
<?php render_admin_end(); ?>
