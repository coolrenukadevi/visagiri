<?php
declare(strict_types=1);

/**
 * Notification Center — every admin's own notifications (fan-out rows
 * from notify_admins_by_permission(), see includes/admin-notifications.php),
 * newest first. Clicking one marks it read and opens its linked record;
 * read notifications are never deleted, only flagged — same "keep the
 * history" rule the client's own spec asked for.
 */

$pdo = db();
$admin = current_admin();
$adminId = (int) $admin['id'];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    if (($_POST['form'] ?? '') === 'mark_all_read') {
        mark_all_admin_notifications_read($adminId);
        flash_set('admin_notice', 'All notifications marked as read.');
        redirect('/admin/notifications/');
    }

    if (($_POST['form'] ?? '') === 'open') {
        $notificationId = (int) ($_POST['notification_id'] ?? 0);
        $link = mark_admin_notification_read($notificationId, $adminId);
        redirect($link ?? '/admin/notifications/');
    }
}

$filter = in_array($_GET['filter'] ?? '', ['unread', 'read'], true) ? $_GET['filter'] : 'all';
$where = 'admin_user_id = :id' . match ($filter) {
    'unread' => ' AND is_read = 0',
    'read' => ' AND is_read = 1',
    default => '',
};
$stmt = $pdo->prepare("SELECT * FROM admin_notifications WHERE $where ORDER BY created_at DESC LIMIT 100");
$stmt->execute(['id' => $adminId]);
$notifications = $stmt->fetchAll();

$unreadCount = admin_unread_notification_count($adminId);

admin_header_start('Notifications', 'notifications');
?>
<div class="admin-toolbar">
    <div class="admin-tabs">
        <a href="/admin/notifications/" class="btn btn-sm <?= $filter === 'all' ? 'btn-primary' : 'btn-outline' ?>">All</a>
        <a href="/admin/notifications/?filter=unread" class="btn btn-sm <?= $filter === 'unread' ? 'btn-primary' : 'btn-outline' ?>">Unread<?= $unreadCount > 0 ? " ($unreadCount)" : '' ?></a>
        <a href="/admin/notifications/?filter=read" class="btn btn-sm <?= $filter === 'read' ? 'btn-primary' : 'btn-outline' ?>">Read</a>
    </div>
    <?php if ($unreadCount > 0): ?>
    <form method="post"><?= csrf_field() ?><input type="hidden" name="form" value="mark_all_read"><button type="submit" class="btn btn-outline btn-sm">Mark All as Read</button></form>
    <?php endif; ?>
</div>

<?php if (!$notifications): ?>
<p class="admin-empty-state">No notifications<?= $filter !== 'all' ? ' in this view' : '' ?>.</p>
<?php else: ?>
<div class="admin-notification-list">
    <?php foreach ($notifications as $n): ?>
    <form method="post" class="admin-notification-item<?= $n['is_read'] ? '' : ' is-unread' ?>">
        <?= csrf_field() ?>
        <input type="hidden" name="form" value="open">
        <input type="hidden" name="notification_id" value="<?= (int) $n['id'] ?>">
        <button type="submit" class="admin-notification-item__button">
            <span class="admin-notification-item__dot" aria-hidden="true"></span>
            <span class="admin-notification-item__body">
                <span class="admin-notification-item__title"><?= e($n['title']) ?></span>
                <?php if ($n['body']): ?><span class="admin-notification-item__desc"><?= e($n['body']) ?></span><?php endif; ?>
            </span>
            <span class="admin-notification-item__time"><?= e(date('d M, H:i', strtotime($n['created_at']))) ?></span>
        </button>
    </form>
    <?php endforeach; ?>
</div>
<?php endif; ?>
<?php
admin_header_end();
