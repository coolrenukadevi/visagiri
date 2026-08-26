<?php
declare(strict_types=1);

/**
 * Messages are visa_application_notes rows marked visible_to_customer
 * = 1 — the same table staff already use for internal notes
 * (admin/pages/visa-applications.php), extended rather than
 * duplicated. A staff note with visible_to_customer = 0 (the default,
 * unchanged for every pre-existing row) never appears here.
 */

$customer = current_customer();
$applicationId = isset($_GET['application_id']) ? (int) $_GET['application_id'] : null;

if ($applicationId === null) {
    $stmt = db()->prepare(
        "SELECT va.id, va.application_reference_no, c.name AS country_name, c.iso2, vt.name AS visa_type_name
         FROM visa_applications va
         JOIN countries c ON c.id = va.country_id JOIN visa_types vt ON vt.id = va.visa_type_id
         WHERE va.customer_id = :id AND va.deleted_at IS NULL ORDER BY va.created_at DESC"
    );
    $stmt->execute(['id' => $customer['id']]);
    $applications = $stmt->fetchAll();

    render_dashboard_start('messages', 'Messages');
    ?>
    <?php if (!$applications): ?>
    <p class="empty-state">Messages appear here once you have an application. <a href="/enquire/">Submit an enquiry</a> to get started.</p>
    <?php else: ?>
    <p style="color:var(--text-muted)">Select an application to view its message thread.</p>
    <div class="card-grid">
        <?php foreach ($applications as $app): ?>
        <a href="/dashboard/messages/?application_id=<?= (int) $app['id'] ?>" class="card service-card">
            <div class="card-title"><?= flag_emoji($app['iso2']) ?> <?= e($app['visa_type_name']) ?> — <?= e($app['country_name']) ?></div>
            <p><?= e($app['application_reference_no']) ?></p>
        </a>
        <?php endforeach; ?>
    </div>
    <?php endif; ?>
    <?php render_dashboard_end(); ?>
    <?php
    exit;
}

$appStmt = db()->prepare(
    "SELECT va.*, c.name AS country_name, vt.name AS visa_type_name FROM visa_applications va
     JOIN countries c ON c.id = va.country_id JOIN visa_types vt ON vt.id = va.visa_type_id
     WHERE va.id = :id AND va.customer_id = :customer_id AND va.deleted_at IS NULL"
);
$appStmt->execute(['id' => $applicationId, 'customer_id' => $customer['id']]);
$application = $appStmt->fetch();

if (!$application) {
    render_dashboard_start('messages', 'Messages');
    echo '<p class="empty-state">We couldn\'t find that application, or it doesn\'t belong to your account.</p>';
    render_dashboard_end();
    exit;
}

$errors = [];
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $body = trim((string) ($_POST['message'] ?? ''));
    if ($body === '') {
        $errors[] = 'Enter a message.';
    } elseif (mb_strlen($body) > 2000) {
        $errors[] = 'Message is too long (max 2000 characters).';
    } else {
        db()->prepare(
            'INSERT INTO visa_application_notes (visa_application_id, customer_id, note, visible_to_customer) VALUES (:app_id, :customer_id, :note, 1)'
        )->execute(['app_id' => $applicationId, 'customer_id' => $customer['id'], 'note' => $body]);
        redirect('/dashboard/messages/?application_id=' . $applicationId);
    }
}

$msgStmt = db()->prepare(
    "SELECT n.*, a.username AS admin_username FROM visa_application_notes n
     LEFT JOIN admin_users a ON a.id = n.admin_user_id
     WHERE n.visa_application_id = :id AND n.visible_to_customer = 1
     ORDER BY n.created_at ASC"
);
$msgStmt->execute(['id' => $applicationId]);
$messages = $msgStmt->fetchAll();

render_dashboard_start('messages', $application['visa_type_name'] . ' — ' . $application['country_name']);
?>
<p><a href="/dashboard/messages/">&larr; All Conversations</a></p>
<div class="card" style="max-width:640px;padding:var(--space-5);margin-top:var(--space-4)">
    <?php if (!$messages): ?>
    <p class="empty-state">No messages yet. Send a message below and your consultant will reply here.</p>
    <?php else: ?>
    <div style="display:flex;flex-direction:column;gap:var(--space-3);margin-bottom:var(--space-5)">
        <?php foreach ($messages as $m): ?>
        <div style="align-self:<?= $m['customer_id'] ? 'flex-end' : 'flex-start' ?>;max-width:80%">
            <div style="background:<?= $m['customer_id'] ? 'var(--visa-blue)' : 'var(--surface-2, #f0f2f5)' ?>;color:<?= $m['customer_id'] ? 'var(--white)' : 'var(--text-dark)' ?>;padding:var(--space-3) var(--space-4);border-radius:var(--radius-md)">
                <?= nl2br(e($m['note'])) ?>
            </div>
            <div style="font-size:var(--font-size-xs);color:var(--text-muted);margin-top:2px">
                <?= $m['customer_id'] ? 'You' : 'Visagiri Team' ?> &middot; <?= e(date('d M, g:i A', strtotime((string) $m['created_at']))) ?>
            </div>
        </div>
        <?php endforeach; ?>
    </div>
    <?php endif; ?>
    <?php foreach ($errors as $error): ?>
    <div class="alert alert-danger"><?= e($error) ?></div>
    <?php endforeach; ?>
    <form method="post" action="/dashboard/messages/?application_id=<?= (int) $applicationId ?>">
        <?= csrf_field() ?>
        <div class="form-group">
            <textarea class="form-input" name="message" rows="3" placeholder="Type a message…" required></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Send</button>
    </form>
</div>
<?php render_dashboard_end(); ?>
