<?php
declare(strict_types=1);

/**
 * B2B Travel Partner Portal — support tickets. List + create + detail
 * (with a message thread) in one file, same query-string
 * ?action=view&id= pattern as enquiries.php.
 */

$partner = current_b2b_partner();
$user = current_b2b_partner_user();
$pdo = db();
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'create') {
        $subject = trim((string) ($_POST['subject'] ?? ''));
        $category = array_key_exists($_POST['category'] ?? '', B2B_TICKET_CATEGORIES) ? $_POST['category'] : 'general';
        $priority = array_key_exists($_POST['priority'] ?? '', B2B_TICKET_PRIORITY_LABELS) ? $_POST['priority'] : 'normal';
        $message = trim((string) ($_POST['message'] ?? ''));

        if ($subject === '' || $message === '') {
            flash_set('b2b_error', 'Enter a subject and a message.');
            redirect('/b2b/support/');
        }

        $pdo->beginTransaction();
        $reference = b2b_generate_ticket_reference();
        $pdo->prepare(
            'INSERT INTO b2b_support_tickets (ticket_reference_no, b2b_partner_id, created_by_user_id, subject, category, priority)
             VALUES (:ref, :partner_id, :user_id, :subject, :category, :priority)'
        )->execute(['ref' => $reference, 'partner_id' => $partner['id'], 'user_id' => $user['id'], 'subject' => $subject, 'category' => $category, 'priority' => $priority]);
        $ticketId = (int) $pdo->lastInsertId();
        $pdo->prepare('INSERT INTO b2b_support_ticket_messages (b2b_support_ticket_id, sender_partner_user_id, message) VALUES (:id, :user, :message)')
            ->execute(['id' => $ticketId, 'user' => $user['id'], 'message' => $message]);
        $pdo->commit();

        flash_set('b2b_notice', 'Support ticket ' . $reference . ' created.');
        redirect('/b2b/support/?action=view&id=' . $ticketId);
    }

    if ($postAction === 'post_message' && $id) {
        $ownerStmt = $pdo->prepare('SELECT id FROM b2b_support_tickets WHERE id = :id AND b2b_partner_id = :partner_id');
        $ownerStmt->execute(['id' => $id, 'partner_id' => $partner['id']]);
        if (!$ownerStmt->fetchColumn()) {
            flash_set('b2b_error', 'Ticket not found.');
            redirect('/b2b/support/');
        }
        $message = trim((string) ($_POST['message'] ?? ''));
        if ($message === '') {
            flash_set('b2b_error', 'Enter a message.');
        } else {
            $pdo->prepare('INSERT INTO b2b_support_ticket_messages (b2b_support_ticket_id, sender_partner_user_id, message) VALUES (:id, :user, :message)')
                ->execute(['id' => $id, 'user' => $user['id'], 'message' => $message]);
            $pdo->prepare("UPDATE b2b_support_tickets SET status = 'open' WHERE id = :id AND status = 'resolved'")->execute(['id' => $id]);
            flash_set('b2b_notice', 'Message sent.');
        }
        redirect('/b2b/support/?action=view&id=' . $id);
    }

    redirect('/b2b/support/');
}

if (($_GET['action'] ?? '') === 'view' && $id) {
    $stmt = $pdo->prepare(
        'SELECT t.*, m.full_name AS assigned_admin_name FROM b2b_support_tickets t
         LEFT JOIN admin_users m ON m.id = t.assigned_admin_id
         WHERE t.id = :id AND t.b2b_partner_id = :partner_id'
    );
    $stmt->execute(['id' => $id, 'partner_id' => $partner['id']]);
    $ticket = $stmt->fetch();

    if (!$ticket) {
        flash_set('b2b_error', 'Ticket not found.');
        redirect('/b2b/support/');
    }

    $messagesStmt = $pdo->prepare(
        'SELECT m.*, a.full_name AS admin_name, u.full_name AS partner_user_name FROM b2b_support_ticket_messages m
         LEFT JOIN admin_users a ON a.id = m.sender_admin_id
         LEFT JOIN b2b_partner_users u ON u.id = m.sender_partner_user_id
         WHERE m.b2b_support_ticket_id = :id ORDER BY m.created_at ASC'
    );
    $messagesStmt->execute(['id' => $id]);
    $messages = $messagesStmt->fetchAll();

    render_b2b_partner_start('support', $ticket['ticket_reference_no']);
    ?>
    <div class="admin-form-card" style="margin-bottom:var(--space-6)">
        <p><strong>Subject:</strong> <?= e($ticket['subject']) ?></p>
        <p><strong>Category:</strong> <?= e(B2B_TICKET_CATEGORIES[$ticket['category']] ?? $ticket['category']) ?> &middot; <strong>Priority:</strong> <?= e(B2B_TICKET_PRIORITY_LABELS[$ticket['priority']]) ?></p>
        <p><strong>Status:</strong> <span class="badge <?= $ticket['status'] === 'resolved' || $ticket['status'] === 'closed' ? 'badge-success' : 'badge-warning' ?>"><?= e(B2B_TICKET_STATUS_LABELS[$ticket['status']]) ?></span></p>
        <p><strong>Handled By:</strong> <?= e($ticket['assigned_admin_name'] ?? 'Not yet assigned') ?></p>
    </div>

    <div class="admin-form-card" style="margin-bottom:var(--space-4);max-height:400px;overflow-y:auto">
        <?php foreach ($messages as $m): ?>
        <p style="margin-bottom:var(--space-3)"><strong><?= $m['sender_admin_id'] ? e($m['admin_name'] ?? 'Visagiri Support') : e($m['partner_user_name'] ?? 'You') ?>:</strong> <?= nl2br(e($m['message'])) ?><br><span style="color:var(--text-muted);font-size:var(--font-size-sm)"><?= e(date('d M Y H:i', strtotime((string) $m['created_at']))) ?></span></p>
        <?php endforeach; ?>
    </div>
    <?php if ($ticket['status'] !== 'closed'): ?>
    <form method="post" action="/b2b/support/" style="margin-bottom:var(--space-6)">
        <?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="action" value="post_message">
        <textarea class="form-textarea" name="message" rows="3" placeholder="Type a message…" required style="width:100%;max-width:520px"></textarea>
        <button type="submit" class="btn btn-outline btn-sm" style="margin-top:var(--space-2)">Send</button>
    </form>
    <?php else: ?>
    <p class="empty-state">This ticket is closed. Open a new one if you need further help.</p>
    <?php endif; ?>

    <p><a href="/b2b/support/">&larr; Back to all tickets</a></p>
    <?php
    render_b2b_partner_end();
    exit;
}

// --- List + create ---
$stmt = $pdo->prepare('SELECT * FROM b2b_support_tickets WHERE b2b_partner_id = :id ORDER BY created_at DESC');
$stmt->execute(['id' => $partner['id']]);
$tickets = $stmt->fetchAll();

render_b2b_partner_start('support', 'Support');
?>
<h2 class="country-directory__subheading" style="margin-top:0">Your Tickets</h2>
<?php if (!$tickets): ?>
<p class="empty-state">No support tickets yet.</p>
<?php else: ?>
<table class="admin-table" style="margin-bottom:var(--space-6)">
    <thead><tr><th>Reference</th><th>Subject</th><th>Category</th><th>Status</th><th>Created</th></tr></thead>
    <tbody>
    <?php foreach ($tickets as $t): ?>
        <tr>
            <td><a href="/b2b/support/?action=view&id=<?= (int) $t['id'] ?>"><?= e($t['ticket_reference_no']) ?></a></td>
            <td><?= e($t['subject']) ?></td>
            <td><?= e(B2B_TICKET_CATEGORIES[$t['category']] ?? $t['category']) ?></td>
            <td><span class="badge <?= $t['status'] === 'resolved' || $t['status'] === 'closed' ? 'badge-success' : 'badge-warning' ?>"><?= e(B2B_TICKET_STATUS_LABELS[$t['status']]) ?></span></td>
            <td><?= e(date('d M Y', strtotime((string) $t['created_at']))) ?></td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php endif; ?>

<h2 class="country-directory__subheading">New Ticket</h2>
<form method="post" action="/b2b/support/" class="card" style="padding:var(--space-6);max-width:600px">
    <?= csrf_field() ?><input type="hidden" name="action" value="create">
    <div class="form-group">
        <label class="form-label" for="subject">Subject</label>
        <input class="form-input" type="text" id="subject" name="subject" required>
    </div>
    <div class="form-group">
        <label class="form-label" for="category">Category</label>
        <select class="form-select" id="category" name="category">
            <?php foreach (B2B_TICKET_CATEGORIES as $key => $label): ?>
            <option value="<?= e($key) ?>"><?= e($label) ?></option>
            <?php endforeach; ?>
        </select>
    </div>
    <div class="form-group">
        <label class="form-label" for="priority">Priority</label>
        <select class="form-select" id="priority" name="priority">
            <?php foreach (B2B_TICKET_PRIORITY_LABELS as $key => $label): ?>
            <option value="<?= e($key) ?>"<?= $key === 'normal' ? ' selected' : '' ?>><?= e($label) ?></option>
            <?php endforeach; ?>
        </select>
    </div>
    <div class="form-group">
        <label class="form-label" for="message">Message</label>
        <textarea class="form-textarea" id="message" name="message" rows="4" required></textarea>
    </div>
    <button type="submit" class="btn btn-primary">Submit Ticket</button>
</form>
<?php render_b2b_partner_end(); ?>
