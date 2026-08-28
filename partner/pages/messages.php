<?php
declare(strict_types=1);

/**
 * Partner communication centre — mirrors dashboard/pages/messages.php
 * exactly, reusing the same visa_application_notes table (now with a
 * partner_id/visible_to_partner pair alongside the existing customer_
 * id/visible_to_customer one) rather than a separate partner_messages
 * table. A partner only ever sees notes flagged visible_to_partner —
 * the customer-facing thread on the same application is a completely
 * separate, invisible channel.
 */

$partner = current_partner();
$applicationId = isset($_GET['application_id']) ? (int) $_GET['application_id'] : null;

if ($applicationId === null) {
    $stmt = db()->prepare(
        "SELECT va.id, va.application_reference_no, c.name AS country_name, c.iso2, vt.name AS visa_type_name
         FROM visa_applications va
         JOIN countries c ON c.id = va.country_id JOIN visa_types vt ON vt.id = va.visa_type_id
         JOIN customers cust ON cust.id = va.customer_id
         WHERE cust.referred_by_partner_id = :id AND va.deleted_at IS NULL ORDER BY va.created_at DESC"
    );
    $stmt->execute(['id' => $partner['id']]);
    $applications = $stmt->fetchAll();

    render_partner_start('messages', 'Messages');
    ?>
    <?php if (!$applications): ?>
    <p class="empty-state">Messages appear here once you have a referred application.</p>
    <?php else: ?>
    <p style="color:var(--text-muted)">Select an application to view its message thread.</p>
    <div class="card-grid">
        <?php foreach ($applications as $app): ?>
        <a href="/partner/messages/?application_id=<?= (int) $app['id'] ?>" class="card service-card">
            <div class="card-title"><?= flag_emoji($app['iso2']) ?> <?= e($app['visa_type_name']) ?> — <?= e($app['country_name']) ?></div>
            <p><?= e($app['application_reference_no']) ?></p>
        </a>
        <?php endforeach; ?>
    </div>
    <?php endif; ?>
    <?php render_partner_end(); ?>
    <?php
    exit;
}

$appStmt = db()->prepare(
    "SELECT va.*, c.name AS country_name, vt.name AS visa_type_name FROM visa_applications va
     JOIN countries c ON c.id = va.country_id JOIN visa_types vt ON vt.id = va.visa_type_id
     JOIN customers cust ON cust.id = va.customer_id
     WHERE va.id = :id AND cust.referred_by_partner_id = :partner_id AND va.deleted_at IS NULL"
);
$appStmt->execute(['id' => $applicationId, 'partner_id' => $partner['id']]);
$application = $appStmt->fetch();

if (!$application) {
    render_partner_start('messages', 'Messages');
    echo '<p class="empty-state">We couldn\'t find that application, or it isn\'t linked to one of your referrals.</p>';
    render_partner_end();
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
            'INSERT INTO visa_application_notes (visa_application_id, partner_id, note, visible_to_partner) VALUES (:app_id, :partner_id, :note, 1)'
        )->execute(['app_id' => $applicationId, 'partner_id' => $partner['id'], 'note' => $body]);
        redirect('/partner/messages/?application_id=' . $applicationId);
    }
}

$msgStmt = db()->prepare(
    "SELECT n.* FROM visa_application_notes n
     WHERE n.visa_application_id = :id AND n.visible_to_partner = 1
     ORDER BY n.created_at ASC"
);
$msgStmt->execute(['id' => $applicationId]);
$messages = $msgStmt->fetchAll();

render_partner_start('messages', $application['visa_type_name'] . ' — ' . $application['country_name']);
?>
<p><a href="/partner/messages/">&larr; All Conversations</a></p>
<div class="card" style="max-width:640px;padding:var(--space-5);margin-top:var(--space-4)">
    <?php if (!$messages): ?>
    <p class="empty-state">No messages yet. Send a message below and our team will reply here.</p>
    <?php else: ?>
    <div style="display:flex;flex-direction:column;gap:var(--space-3);margin-bottom:var(--space-5)">
        <?php foreach ($messages as $m): ?>
        <div style="align-self:<?= $m['partner_id'] ? 'flex-end' : 'flex-start' ?>;max-width:80%">
            <div style="background:<?= $m['partner_id'] ? 'var(--visa-blue)' : 'var(--surface-2, #f0f2f5)' ?>;color:<?= $m['partner_id'] ? 'var(--white)' : 'var(--text-dark)' ?>;padding:var(--space-3) var(--space-4);border-radius:var(--radius-md)">
                <?= nl2br(e($m['note'])) ?>
            </div>
            <div style="font-size:var(--font-size-xs);color:var(--text-muted);margin-top:2px">
                <?= $m['partner_id'] ? 'You' : 'Visagiri Team' ?> &middot; <?= e(date('d M, g:i A', strtotime((string) $m['created_at']))) ?>
            </div>
        </div>
        <?php endforeach; ?>
    </div>
    <?php endif; ?>
    <?php foreach ($errors as $error): ?>
    <div class="alert alert-danger"><?= e($error) ?></div>
    <?php endforeach; ?>
    <form method="post" action="/partner/messages/?application_id=<?= (int) $applicationId ?>">
        <?= csrf_field() ?>
        <div class="form-group">
            <textarea class="form-input" name="message" rows="3" placeholder="Type a message…" required></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Send</button>
    </form>
</div>
<?php render_partner_end(); ?>
