<?php
declare(strict_types=1);

$pdo = db();
$id = isset($_GET['id']) ? (int) $_GET['id'] : null;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $status = $_POST['status'] ?? '';
    if ($id && in_array($status, ['unread', 'read', 'replied'], true)) {
        $pdo->prepare('UPDATE contact_messages SET status = :status WHERE id = :id')->execute(['status' => $status, 'id' => $id]);
        flash_set('admin_notice', 'Message status updated.');
    }
    redirect('/admin/contact-messages/?id=' . $id);
}

if ($id) {
    $stmt = $pdo->prepare('SELECT * FROM contact_messages WHERE id = :id');
    $stmt->execute(['id' => $id]);
    $message = $stmt->fetch();
    if (!$message) {
        flash_set('admin_error', 'Message not found.');
        redirect('/admin/contact-messages/');
    }

    if ($message['status'] === 'unread') {
        $pdo->prepare("UPDATE contact_messages SET status = 'read' WHERE id = :id")->execute(['id' => $id]);
        $message['status'] = 'read';
    }

    admin_header_start('Contact Message', 'contact-messages');
    ?>
    <div class="admin-form-card">
        <p><strong>Name:</strong> <?= e($message['name']) ?></p>
        <p><strong>Email:</strong> <?= e($message['email']) ?></p>
        <p><strong>Phone:</strong> <?= e($message['phone'] ?? 'Not provided') ?></p>
        <p><strong>Destination:</strong> <?= e($message['destination'] ?? 'Not specified') ?></p>
        <p><strong>Message:</strong><br><?= nl2br(e($message['message'])) ?></p>
        <p><strong>Received:</strong> <?= e(date('d M Y H:i', strtotime((string) $message['created_at']))) ?></p>

        <form method="post" action="/admin/contact-messages/?id=<?= (int) $message['id'] ?>" style="margin-top:var(--space-5)">
            <?= csrf_field() ?>
            <div class="form-group">
                <label class="form-label" for="status">Status</label>
                <select class="form-select" id="status" name="status">
                    <?php foreach (['unread', 'read', 'replied'] as $s): ?>
                    <option value="<?= $s ?>"<?= $message['status'] === $s ? ' selected' : '' ?>><?= e(ucfirst($s)) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Update Status</button>
        </form>
    </div>
    <p style="margin-top:var(--space-4)"><a href="/admin/contact-messages/">&larr; Back to all messages</a></p>
    <?php
    admin_header_end();
    exit;
}

$messages = $pdo->query('SELECT * FROM contact_messages ORDER BY created_at DESC LIMIT 100')->fetchAll();

admin_header_start('Contact Messages', 'contact-messages');
?>
<?php if ($messages): ?>
<table class="admin-table">
    <thead><tr><th>Name</th><th>Email</th><th>Status</th><th>Received</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($messages as $m): ?>
        <tr>
            <td><?= e($m['name']) ?></td>
            <td><?= e($m['email']) ?></td>
            <td><span class="badge <?= $m['status'] === 'unread' ? 'badge-warning' : 'badge-info' ?>"><?= e(ucfirst($m['status'])) ?></span></td>
            <td><?= e(date('d M Y H:i', strtotime((string) $m['created_at']))) ?></td>
            <td class="actions"><a href="/admin/contact-messages/?id=<?= (int) $m['id'] ?>" class="btn btn-outline btn-sm">View</a></td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php else: ?>
<p class="empty-state">No contact messages yet.</p>
<?php endif; ?>
<?php
admin_header_end();
