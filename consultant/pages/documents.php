<?php
declare(strict_types=1);

/** Document review queue scoped to applications assigned to this consultant. */

$consultant = current_user();
$pdo = db();
$stmt = $pdo->prepare(
    "SELECT ad.*, d.name AS document_name, a.application_number, a.id AS application_id,
            u.full_name, u.email
     FROM application_documents ad
     JOIN documents d ON d.id = ad.document_id
     JOIN applications a ON a.id = ad.application_id
     JOIN users u ON u.id = a.user_id
     WHERE a.assigned_consultant_id = :consultant_id
           AND ad.status IN ('uploaded', 'under_review') AND ad.deleted_at IS NULL AND a.deleted_at IS NULL
     ORDER BY ad.uploaded_at ASC"
);
$stmt->execute(['consultant_id' => $consultant['id']]);
$documents = $stmt->fetchAll();

render_consultant_start('documents', 'Document Review Queue');
?>
<?php if ($documents): ?>
<?php foreach ($documents as $doc): ?>
<div class="card" style="margin-bottom:var(--space-4)">
    <div class="document-row__top">
        <div>
            <span class="list-row__title"><?= e($doc['document_name']) ?></span>
            <div class="list-row__meta">
                <a href="/consultant/applications/<?= (int) $doc['application_id'] ?>/"><?= e($doc['application_number']) ?></a>
                &middot; <?= e($doc['full_name']) ?> (<?= e($doc['email']) ?>)
            </div>
        </div>
        <span class="badge badge-<?= $doc['status'] === 'under_review' ? 'warning' : 'neutral' ?>"><?= e(str_replace('_', ' ', $doc['status'])) ?></span>
    </div>
    <p class="document-row__file">
        <?= e($doc['original_filename']) ?> &middot; <a href="/consultant/documents/<?= (int) $doc['id'] ?>/download/">Download</a>
        &middot; Uploaded <?= e(date('d M Y', strtotime((string) $doc['uploaded_at']))) ?>
    </p>
    <div class="button-group">
        <form method="post" action="/consultant/documents/<?= (int) $doc['id'] ?>/approve/"><?= csrf_field() ?><input type="hidden" name="redirect_to" value="/consultant/documents/"><button type="submit" class="btn btn-sm btn-primary">Approve</button></form>
        <form method="post" action="/consultant/documents/<?= (int) $doc['id'] ?>/reject/"><?= csrf_field() ?><input type="hidden" name="redirect_to" value="/consultant/documents/"><input class="form-input" type="text" name="comment" placeholder="Reason for rejection" required><button type="submit" class="btn btn-sm btn-outline">Reject</button></form>
    </div>
</div>
<?php endforeach; ?>
<?php else: ?>
<p class="empty-state">Nothing awaiting review right now.</p>
<?php endif; ?>
<?php render_consultant_end(); ?>
