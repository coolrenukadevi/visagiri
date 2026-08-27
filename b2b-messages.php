<?php
ob_start();
$PP_PAGE_TITLE = 'Messages';
$PP_ACTIVE_NAV = 'messages';
require __DIR__ . '/includes/partner-layout-top.php';

$pid = partner_id();
$actionError = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'send_message') {
    $body = trim($_POST['body'] ?? '');
    if ($body === '') {
        $actionError = 'Message cannot be empty.';
    } else {
        $pdo->prepare('INSERT INTO b2b_messages (partner_id, sender_type, sender_id, sender_name, subject, body, is_read, created_at) VALUES (?, ?, ?, ?, ?, ?, 0, ?)')
            ->execute([$pid, 'Partner', partner_user_id(), partner_name(), 'Message from ' . $ppPartner['company_name'], $body, gmdate('c')]);
        b2b_notify($pdo, null, 'b2b_message', "{$ppPartner['company_name']} ({$ppPartner['application_ref']}) sent a new message.", $pid);
    }
}

$msgStmt = $pdo->prepare('SELECT * FROM b2b_messages WHERE partner_id = ? ORDER BY created_at ASC');
$msgStmt->execute([$pid]);
$messages = $msgStmt->fetchAll(PDO::FETCH_ASSOC);

// Opening the thread implies the partner has now seen every staff message
// in it — mirrors the staff-side read on admin/b2b-partner.php's
// Communications tab. Never touches the staff-authored is_read semantics.
$pdo->prepare("UPDATE b2b_messages SET is_read = 1 WHERE partner_id = ? AND sender_type = 'Staff' AND is_read = 0")->execute([$pid]);
?>
<div class="pp-page-header">
    <div>
        <h1 class="pp-page-title">Messages</h1>
        <p class="pp-page-subtitle">Direct messages with your VisaAgency.in Relationship Manager.</p>
    </div>
</div>

<div class="pp-card">
    <div class="pp-chat-thread">
        <?php foreach ($messages as $m): ?>
        <div class="pp-chat-bubble <?php echo $m['sender_type'] === 'Partner' ? 'is-me' : 'is-staff'; ?>">
            <div class="pp-chat-meta"><?php echo htmlspecialchars($m['sender_name']); ?> &middot; <?php echo htmlspecialchars(substr($m['created_at'], 0, 16)); ?></div>
            <div class="pp-chat-body"><?php echo nl2br(htmlspecialchars($m['body'])); ?></div>
        </div>
        <?php endforeach; ?>
        <?php if (!$messages): ?><p class="pp-empty-note">No messages yet. Send a message to your Relationship Manager below.</p><?php endif; ?>
    </div>
    <?php if ($actionError): ?><p style="color:#E63946;font-size:12.5px;margin:0 0 8px;"><?php echo htmlspecialchars($actionError); ?></p><?php endif; ?>
    <form method="post" class="pp-chat-form">
        <input type="hidden" name="action" value="send_message">
        <textarea name="body" rows="3" placeholder="Write a message..." required style="width:100%;border:1px solid var(--border);border-radius:8px;padding:9px 12px;font-family:inherit;font-size:13px;"></textarea>
        <button type="submit" class="pp-filter-btn" style="margin-top:8px;">Send Message</button>
    </form>
</div>

<?php require __DIR__ . '/includes/partner-layout-bottom.php'; ?>
