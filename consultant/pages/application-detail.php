<?php
declare(strict_types=1);

/** $id is set by consultant/index.php from the URL segment. */

$consultant = current_user();
$pdo = db();

$stmt = $pdo->prepare(
    'SELECT a.*, u.full_name, u.email, u.mobile, c.name AS country_name, c.iso2, vt.name AS visa_type_name
     FROM applications a
     JOIN users u ON u.id = a.user_id
     JOIN countries c ON c.id = a.country_id
     JOIN visa_types vt ON vt.id = a.visa_type_id
     WHERE a.id = :id AND a.assigned_consultant_id = :consultant_id AND a.deleted_at IS NULL'
);
$stmt->execute(['id' => $id, 'consultant_id' => $consultant['id']]);
$app = $stmt->fetch();

if (!$app) {
    render_not_found("We couldn't find that application.");
}

$stages = application_status_stages();
$stageKeys = array_keys($stages);
$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $newStatus = (string) ($_POST['status'] ?? '');
    $comment = trim((string) ($_POST['comment'] ?? ''));

    if (!in_array($newStatus, $stageKeys, true)) {
        $errors[] = 'Select a valid status.';
    } else {
        $newIndex = array_search($newStatus, $stageKeys, true);
        $progress = (int) round((($newIndex + 1) / count($stageKeys)) * 100);

        $updateFields = 'status = :status, progress_percent = :progress';
        $updateParams = ['status' => $newStatus, 'progress' => $progress, 'id' => $app['id']];
        if ($newStatus === 'submitted' && $app['submitted_at'] === null) {
            $updateFields .= ', submitted_at = NOW()';
        }
        if ($newStatus === 'decision_received' && $app['decision_at'] === null) {
            $updateFields .= ', decision_at = NOW()';
        }

        $pdo->prepare("UPDATE applications SET $updateFields WHERE id = :id")->execute($updateParams);
        $pdo->prepare(
            'INSERT INTO application_status_history (application_id, status, comment, changed_by) VALUES (:id, :status, :comment, :changed_by)'
        )->execute([
            'id' => $app['id'],
            'status' => $newStatus,
            'comment' => $comment !== '' ? $comment : null,
            'changed_by' => $consultant['id'],
        ]);

        flash_set('notice', 'Application status updated.');
        redirect("/consultant/applications/{$app['id']}/");
    }
}

$historyStmt = $pdo->prepare('SELECT * FROM application_status_history WHERE application_id = :id ORDER BY created_at ASC');
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

$currentIndex = array_search($app['status'], $stageKeys, true);

render_consultant_start('applications', $app['application_number']);
?>
<?php foreach ($errors as $error): ?>
<div class="alert alert-danger"><?= e($error) ?></div>
<?php endforeach; ?>

<h2 class="country-directory__subheading"><?= flag_emoji($app['iso2']) ?> <?= e($app['visa_type_name']) ?> &mdash; <?= e($app['country_name']) ?></h2>

<div class="apply-review__row">
    <span class="apply-review__label">Applicant</span>
    <span class="apply-review__value"><?= e($app['full_name']) ?> (<?= e($app['email']) ?>, <?= e($app['mobile'] ?? 'no mobile on file') ?>)</span>
</div>
<div class="apply-review__row">
    <span class="apply-review__label">Passport number</span>
    <span class="apply-review__value"><?= e($app['applicant_passport_number'] ?? '—') ?></span>
</div>
<div class="apply-review__row">
    <span class="apply-review__label">Date of birth</span>
    <span class="apply-review__value"><?= $app['applicant_dob'] ? e(date('d M Y', strtotime((string) $app['applicant_dob']))) : '—' ?></span>
</div>
<div class="apply-review__row">
    <span class="apply-review__label">Nationality</span>
    <span class="apply-review__value"><?= e($app['applicant_nationality'] ?? '—') ?></span>
</div>

<h2 class="country-directory__subheading" style="margin-top:var(--space-8)">Update Status</h2>
<form method="post" action="/consultant/applications/<?= (int) $app['id'] ?>/" class="card" style="padding:var(--space-5)">
    <?= csrf_field() ?>
    <div class="form-group">
        <label class="form-label" for="status">Status</label>
        <select class="form-select" id="status" name="status">
            <?php foreach ($stages as $key => $label): ?>
            <option value="<?= e($key) ?>" <?= $app['status'] === $key ? 'selected' : '' ?>><?= e($label) ?></option>
            <?php endforeach; ?>
        </select>
    </div>
    <div class="form-group">
        <label class="form-label" for="comment">Comment (optional, shown to the applicant)</label>
        <textarea class="form-input" id="comment" name="comment" rows="2"></textarea>
    </div>
    <button type="submit" class="btn btn-primary">Update Status</button>
</form>

<h2 class="country-directory__subheading" style="margin-top:var(--space-8)">Status History</h2>
<ul class="status-timeline">
    <?php foreach ($stages as $key => $label): $i = array_search($key, $stageKeys, true); ?>
    <li class="<?= $i < $currentIndex ? 'is-complete' : ($i === $currentIndex ? 'is-current' : '') ?>">
        <div class="status-title"><?= e($label) ?></div>
        <?php if (isset($historyByStatus[$key])): ?>
        <div class="status-meta">
            <?= e(date('d M Y, g:i A', strtotime((string) $historyByStatus[$key]['created_at']))) ?>
            <?php if (!empty($historyByStatus[$key]['comment'])): ?> &mdash; <?= e($historyByStatus[$key]['comment']) ?><?php endif; ?>
        </div>
        <?php endif; ?>
    </li>
    <?php endforeach; ?>
</ul>

<h2 class="country-directory__subheading" style="margin-top:var(--space-8)">Documents</h2>
<?php if ($documents): ?>
<?php foreach ($documents as $doc): ?>
<div class="card" style="margin-bottom:var(--space-4)">
    <div class="document-row__top">
        <span class="list-row__title"><?= e($doc['document_name']) ?></span>
        <span class="badge badge-<?= match ($doc['status']) { 'approved' => 'success', 'rejected' => 'danger', 'under_review' => 'warning', default => 'neutral' } ?>"><?= e(str_replace('_', ' ', $doc['status'])) ?></span>
    </div>
    <?php if (!empty($doc['reviewer_comment'])): ?>
    <p class="form-hint"><strong>Reviewer note:</strong> <?= e($doc['reviewer_comment']) ?></p>
    <?php endif; ?>
    <?php if ($doc['stored_filename']): ?>
    <p class="document-row__file">
        <?= e($doc['original_filename']) ?> &middot; <a href="/consultant/documents/<?= (int) $doc['id'] ?>/download/">Download</a>
        <?php if (!empty($doc['uploaded_at'])): ?> &middot; Uploaded <?= e(date('d M Y', strtotime((string) $doc['uploaded_at']))) ?><?php endif; ?>
    </p>
    <?php if (in_array($doc['status'], ['uploaded', 'under_review'], true)): ?>
    <div class="button-group">
        <form method="post" action="/consultant/documents/<?= (int) $doc['id'] ?>/approve/"><?= csrf_field() ?><input type="hidden" name="redirect_to" value="/consultant/applications/<?= (int) $app['id'] ?>/"><button type="submit" class="btn btn-sm btn-primary">Approve</button></form>
        <form method="post" action="/consultant/documents/<?= (int) $doc['id'] ?>/reject/"><?= csrf_field() ?><input type="hidden" name="redirect_to" value="/consultant/applications/<?= (int) $app['id'] ?>/"><input class="form-input" type="text" name="comment" placeholder="Reason for rejection" required><button type="submit" class="btn btn-sm btn-outline">Reject</button></form>
    </div>
    <?php endif; ?>
    <?php else: ?>
    <p class="form-hint">Not uploaded yet.</p>
    <?php endif; ?>
</div>
<?php endforeach; ?>
<?php else: ?>
<p class="empty-state">No documents requested yet.</p>
<?php endif; ?>
<?php render_consultant_end(); ?>
