<?php
declare(strict_types=1);

$user = current_user();
$pdo = db();
$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $subject = trim((string) ($_POST['subject'] ?? ''));
    $message = trim((string) ($_POST['message'] ?? ''));

    if ($subject === '' || mb_strlen($subject) > 191) {
        $errors[] = 'Enter a subject.';
    }
    if ($message === '') {
        $errors[] = 'Enter a message.';
    }

    if (!$errors) {
        $pdo->prepare('INSERT INTO support_tickets (user_id, subject, message) VALUES (:user_id, :subject, :message)')
            ->execute(['user_id' => $user['id'], 'subject' => $subject, 'message' => $message]);
        flash_set('notice', 'Your support request has been submitted. We\'ll get back to you soon.');
        redirect('/dashboard/support/');
    }
}

$stmt = $pdo->prepare('SELECT * FROM support_tickets WHERE user_id = :id ORDER BY created_at DESC');
$stmt->execute(['id' => $user['id']]);
$tickets = $stmt->fetchAll();

render_dashboard_start('support', 'Support');
?>
<div class="card" style="max-width:600px;margin-bottom:var(--space-8)">
    <div class="card-title">Submit a request</div>
    <?php foreach ($errors as $error): ?>
    <div class="alert alert-danger"><?= e($error) ?></div>
    <?php endforeach; ?>
    <form method="post" action="/dashboard/support/">
        <?= csrf_field() ?>
        <div class="form-group">
            <label class="form-label" for="subject">Subject</label>
            <input class="form-input" type="text" id="subject" name="subject" required>
        </div>
        <div class="form-group">
            <label class="form-label" for="message">Message</label>
            <textarea class="form-textarea" id="message" name="message" rows="5" required></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Submit Request</button>
    </form>
</div>

<h2 class="country-directory__subheading">Your Requests</h2>
<?php if ($tickets): ?>
<?php foreach ($tickets as $ticket): ?>
<div class="list-row">
    <span>
        <span class="list-row__title"><?= e($ticket['subject']) ?></span><br>
        <span class="list-row__meta"><?= e(date('d M Y, g:i A', strtotime((string) $ticket['created_at']))) ?></span>
    </span>
    <span class="badge badge-<?= match ($ticket['status']) { 'resolved' => 'success', 'closed' => 'neutral', 'in_progress' => 'warning', default => 'info' } ?>"><?= e(str_replace('_', ' ', $ticket['status'])) ?></span>
</div>
<?php endforeach; ?>
<?php else: ?>
<p class="empty-state">No support requests yet.</p>
<?php endif; ?>
<?php render_dashboard_end(); ?>
