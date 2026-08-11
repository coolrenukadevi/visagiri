<?php
declare(strict_types=1);

$user = current_user();
$stmt = db()->prepare(
    "SELECT m.*, su.full_name AS sender_name, ru.full_name AS recipient_name
     FROM messages m
     JOIN users su ON su.id = m.sender_id
     JOIN users ru ON ru.id = m.recipient_id
     WHERE m.sender_id = :id OR m.recipient_id = :id2
     ORDER BY m.created_at DESC"
);
$stmt->execute(['id' => $user['id'], 'id2' => $user['id']]);
$messages = $stmt->fetchAll();

render_dashboard_start('messages', 'Messages');
?>
<?php if ($messages): ?>
<?php foreach ($messages as $msg): $isFromMe = (int) $msg['sender_id'] === (int) $user['id']; ?>
<div class="list-row <?= (!$isFromMe && !$msg['is_read']) ? 'is-unread' : '' ?>">
    <span>
        <span class="list-row__title"><?= $isFromMe ? 'To ' . e($msg['recipient_name']) : 'From ' . e($msg['sender_name']) ?></span><br>
        <span class="list-row__meta"><?= e($msg['body']) ?></span>
    </span>
    <span class="list-row__meta"><?= e(date('d M Y, g:i A', strtotime((string) $msg['created_at']))) ?></span>
</div>
<?php endforeach; ?>
<?php else: ?>
<p class="empty-state">No messages yet. You can message your consultant once your application is being reviewed.</p>
<?php endif; ?>
<?php render_dashboard_end(); ?>
