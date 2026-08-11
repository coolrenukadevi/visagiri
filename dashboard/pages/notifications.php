<?php
declare(strict_types=1);

$user = current_user();
$pdo = db();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    if (($_POST['action'] ?? '') === 'mark_all_read') {
        $pdo->prepare('UPDATE notifications SET is_read = 1 WHERE user_id = :id')->execute(['id' => $user['id']]);
        flash_set('notice', 'All notifications marked as read.');
    }
    redirect('/dashboard/notifications/');
}

$stmt = $pdo->prepare('SELECT * FROM notifications WHERE user_id = :id ORDER BY created_at DESC');
$stmt->execute(['id' => $user['id']]);
$notifications = $stmt->fetchAll();

render_dashboard_start('notifications', 'Notifications');
?>
<?php if ($notifications): ?>
<form method="post" action="/dashboard/notifications/" style="margin-bottom:var(--space-5)">
    <?= csrf_field() ?>
    <input type="hidden" name="action" value="mark_all_read">
    <button type="submit" class="btn btn-outline btn-sm">Mark all as read</button>
</form>
<?php foreach ($notifications as $n): ?>
<div class="list-row <?= !$n['is_read'] ? 'is-unread' : '' ?>">
    <span>
        <span class="list-row__title"><?= e($n['title']) ?></span><br>
        <span class="list-row__meta"><?= e($n['message'] ?? '') ?></span>
    </span>
    <span class="list-row__meta"><?= e(date('d M Y, g:i A', strtotime((string) $n['created_at']))) ?></span>
</div>
<?php endforeach; ?>
<?php else: ?>
<p class="empty-state">No notifications yet.</p>
<?php endif; ?>
<?php render_dashboard_end(); ?>
