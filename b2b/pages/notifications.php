<?php
declare(strict_types=1);

/** B2B Travel Partner Portal — notification centre. Opening the list marks everything read, same convention as the old partner system's notifications page. */

$partner = current_b2b_partner();
$pdo = db();

$pdo->prepare('UPDATE b2b_partner_notifications SET is_read = 1 WHERE b2b_partner_id = :id AND is_read = 0')->execute(['id' => $partner['id']]);

$stmt = $pdo->prepare('SELECT * FROM b2b_partner_notifications WHERE b2b_partner_id = :id ORDER BY created_at DESC LIMIT 50');
$stmt->execute(['id' => $partner['id']]);
$notifications = $stmt->fetchAll();

render_b2b_partner_start('notifications', 'Notifications');
?>
<?php if (!$notifications): ?>
<p class="empty-state">No notifications yet.</p>
<?php else: ?>
<table class="admin-table">
    <thead><tr><th>Title</th><th>Details</th><th>When</th></tr></thead>
    <tbody>
    <?php foreach ($notifications as $n): ?>
        <tr>
            <td><?= $n['link'] ? '<a href="' . e($n['link']) . '">' . e($n['title']) . '</a>' : e($n['title']) ?></td>
            <td><?= e($n['body'] ?? '—') ?></td>
            <td><?= e(date('d M Y H:i', strtotime((string) $n['created_at']))) ?></td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php endif; ?>
<?php render_b2b_partner_end(); ?>
