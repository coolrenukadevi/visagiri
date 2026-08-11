<?php
declare(strict_types=1);

/** $id is set by dashboard/index.php from the URL segment. */

$user = current_user();
$pdo = db();

$stmt = $pdo->prepare(
    "SELECT a.*, c.name AS country_name, c.iso2, vt.name AS visa_type_name
     FROM applications a
     JOIN countries c ON c.id = a.country_id
     JOIN visa_types vt ON vt.id = a.visa_type_id
     WHERE a.id = :id AND a.user_id = :user_id AND a.deleted_at IS NULL"
);
$stmt->execute(['id' => $id, 'user_id' => $user['id']]);
$app = $stmt->fetch();

if (!$app) {
    render_not_found("We couldn't find that application.");
}

$historyStmt = $pdo->prepare(
    'SELECT * FROM application_status_history WHERE application_id = :id ORDER BY created_at ASC'
);
$historyStmt->execute(['id' => $app['id']]);
$historyByStatus = [];
foreach ($historyStmt->fetchAll() as $row) {
    $historyByStatus[$row['status']] = $row;
}

$docsStmt = $pdo->prepare(
    'SELECT ad.*, d.name AS document_name FROM application_documents ad
     JOIN documents d ON d.id = ad.document_id
     WHERE ad.application_id = :id AND ad.deleted_at IS NULL
     ORDER BY d.name'
);
$docsStmt->execute(['id' => $app['id']]);
$documents = $docsStmt->fetchAll();

$paymentsStmt = $pdo->prepare('SELECT * FROM payments WHERE application_id = :id ORDER BY created_at DESC');
$paymentsStmt->execute(['id' => $app['id']]);
$payments = $paymentsStmt->fetchAll();

$stages = application_status_stages();
$stageKeys = array_keys($stages);
$currentIndex = array_search($app['status'], $stageKeys, true);

render_dashboard_start('applications', $app['visa_type_name'] . ' — ' . $app['country_name']);
?>
<p class="application-card__id"><?= e($app['application_number']) ?></p>

<h2 class="country-directory__subheading">Status</h2>
<ul class="status-timeline">
    <?php foreach ($stages as $key => $label): $i = array_search($key, $stageKeys, true); ?>
    <li class="<?= $i < $currentIndex ? 'is-complete' : ($i === $currentIndex ? 'is-current' : '') ?>">
        <div class="status-title"><?= e($label) ?></div>
        <?php if (isset($historyByStatus[$key])): ?>
        <div class="status-meta">
            <?= e(date('d M Y, g:i A', strtotime((string) $historyByStatus[$key]['created_at']))) ?>
            <?php if (!empty($historyByStatus[$key]['comment'])): ?> &mdash; <?= e($historyByStatus[$key]['comment']) ?><?php endif; ?>
        </div>
        <?php elseif ($i === $currentIndex): ?>
        <div class="status-meta">In progress</div>
        <?php endif; ?>
    </li>
    <?php endforeach; ?>
</ul>

<h2 class="country-directory__subheading" style="margin-top:var(--space-8)">Documents</h2>
<?php if ($documents): ?>
<?php foreach ($documents as $doc): ?>
<div class="list-row">
    <span class="list-row__title"><?= e($doc['document_name']) ?></span>
    <span class="badge badge-<?= match ($doc['status']) { 'approved' => 'success', 'rejected' => 'danger', 'under_review' => 'warning', default => 'neutral' } ?>"><?= e(str_replace('_', ' ', $doc['status'])) ?></span>
</div>
<?php endforeach; ?>
<?php else: ?>
<p class="empty-state">No documents requested yet.</p>
<?php endif; ?>

<h2 class="country-directory__subheading" style="margin-top:var(--space-8)">Payments</h2>
<?php if ($payments): ?>
<?php foreach ($payments as $payment): ?>
<div class="list-row">
    <span class="list-row__title"><?= e(format_money((float) $payment['amount'], $payment['currency'])) ?> &mdash; <?= e(ucfirst(str_replace('_', ' ', $payment['purpose']))) ?></span>
    <span class="badge badge-<?= match ($payment['status']) { 'paid' => 'success', 'failed' => 'danger', default => 'warning' } ?>"><?= e($payment['status']) ?></span>
</div>
<?php endforeach; ?>
<?php else: ?>
<p class="empty-state">No payments recorded yet.</p>
<?php endif; ?>
<?php render_dashboard_end(); ?>
