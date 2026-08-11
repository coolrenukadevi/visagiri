<?php
declare(strict_types=1);

$user = current_user();
$stmt = db()->prepare(
    "SELECT ad.*, d.name AS document_name, a.application_number, a.id AS application_id,
            c.name AS country_name, vt.name AS visa_type_name
     FROM application_documents ad
     JOIN documents d ON d.id = ad.document_id
     JOIN applications a ON a.id = ad.application_id
     JOIN countries c ON c.id = a.country_id
     JOIN visa_types vt ON vt.id = a.visa_type_id
     WHERE a.user_id = :id AND ad.deleted_at IS NULL AND a.deleted_at IS NULL
     ORDER BY ad.created_at DESC"
);
$stmt->execute(['id' => $user['id']]);
$documents = $stmt->fetchAll();

render_dashboard_start('documents', 'Documents');
?>
<?php if ($documents): ?>
<?php foreach ($documents as $doc): ?>
<div class="card" style="margin-bottom:var(--space-4)">
    <p class="list-row__meta" style="margin-bottom:var(--space-2)">
        <a href="/dashboard/applications/<?= (int) $doc['application_id'] ?>/"><?= e($doc['visa_type_name']) ?> &mdash; <?= e($doc['country_name']) ?></a>
    </p>
    <?php render_document_row($doc, true); ?>
</div>
<?php endforeach; ?>
<?php else: ?>
<p class="empty-state">No documents requested yet. Documents appear here once you start a visa application.</p>
<?php endif; ?>
<?php render_dashboard_end(); ?>
