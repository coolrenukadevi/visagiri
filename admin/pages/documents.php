<?php
declare(strict_types=1);

/** Cross-application document review queue — everything awaiting a decision. */

$pdo = db();
$stmt = $pdo->query(
    "SELECT ad.*, d.name AS document_name, a.application_number, a.id AS application_id,
            u.full_name, u.email
     FROM application_documents ad
     JOIN documents d ON d.id = ad.document_id
     JOIN applications a ON a.id = ad.application_id
     JOIN users u ON u.id = a.user_id
     WHERE ad.status IN ('uploaded', 'under_review') AND ad.deleted_at IS NULL AND a.deleted_at IS NULL
     ORDER BY ad.uploaded_at ASC"
);
$documents = $stmt->fetchAll();

render_admin_start('documents', 'Document Review Queue');
?>
<?php if ($documents): ?>
<?php foreach ($documents as $doc): ?>
<div class="card" style="margin-bottom:var(--space-4)">
    <div class="document-row__top">
        <div>
            <span class="list-row__title"><?= e($doc['document_name']) ?></span>
            <div class="list-row__meta">
                <a href="/admin/applications/<?= (int) $doc['application_id'] ?>/"><?= e($doc['application_number']) ?></a>
                &middot; <?= e($doc['full_name']) ?> (<?= e($doc['email']) ?>)
            </div>
        </div>
        <span class="badge badge-<?= $doc['status'] === 'under_review' ? 'warning' : 'neutral' ?>"><?= e(str_replace('_', ' ', $doc['status'])) ?></span>
    </div>
    <p class="document-row__file">
        <?= e($doc['original_filename']) ?> &middot; <a href="/admin/documents/<?= (int) $doc['id'] ?>/download/">Download</a>
        &middot; Uploaded <?= e(date('d M Y', strtotime((string) $doc['uploaded_at']))) ?>
    </p>
    <div class="button-group">
        <form method="post" action="/admin/documents/<?= (int) $doc['id'] ?>/approve/"><?= csrf_field() ?><input type="hidden" name="redirect_to" value="/admin/documents/"><button type="submit" class="btn btn-sm btn-primary">Approve</button></form>
        <form method="post" action="/admin/documents/<?= (int) $doc['id'] ?>/reject/" class="document-reject-form"><?= csrf_field() ?><input type="hidden" name="redirect_to" value="/admin/documents/"><input class="form-input" type="text" name="comment" placeholder="Reason for rejection" required><button type="submit" class="btn btn-sm btn-outline">Reject</button></form>
    </div>
</div>
<?php endforeach; ?>
<?php else: ?>
<p class="empty-state">Nothing awaiting review right now.</p>
<?php endif; ?>
<?php render_admin_end(); ?>
