<?php
declare(strict_types=1);

$partner = current_partner();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    db()->prepare('UPDATE partner_notifications SET is_read = 1 WHERE partner_id = :id AND is_read = 0')
        ->execute(['id' => $partner['id']]);
    redirect('/partner/notifications/');
}

$stmt = db()->prepare('SELECT * FROM partner_notifications WHERE partner_id = :id ORDER BY created_at DESC LIMIT 50');
$stmt->execute(['id' => $partner['id']]);
$notifications = $stmt->fetchAll();

render_partner_start('notifications', 'Notifications');
?>
<?php if (!$notifications): ?>
<p class="empty-state">No notifications yet. You'll see updates here when your application status changes or a document is reviewed.</p>
<?php else: ?>
<form method="post" action="/partner/notifications/" style="margin-bottom:var(--space-4)">
    <?= csrf_field() ?>
    <button type="submit" class="btn btn-outline btn-sm">Mark All Read</button>
</form>
<?php foreach ($notifications as $n): ?>
<div class="card" style="margin-bottom:var(--space-3);<?= $n['is_read'] ? '' : 'border-left:3px solid var(--visa-gold)' ?>">
    <div class="card-title"><?= e($n['title']) ?></div>
    <?php if ($n['body']): ?><p style="margin:var(--space-1) 0"><?= e($n['body']) ?></p><?php endif; ?>
    <p style="font-size:var(--font-size-xs);color:var(--text-muted);margin:0">
        <?= e(date('d M Y, g:i A', strtotime((string) $n['created_at']))) ?>
        <?php if ($n['link']): ?> &middot; <a href="<?= e($n['link']) ?>">View</a><?php endif; ?>
    </p>
</div>
<?php endforeach; ?>
<?php endif; ?>
<?php render_partner_end(); ?>
