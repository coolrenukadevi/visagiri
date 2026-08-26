<?php
declare(strict_types=1);

$customer = current_customer();

$stmt = db()->prepare(
    "SELECT d.*, va.application_reference_no FROM documents d
     LEFT JOIN visa_applications va ON va.id = d.visa_application_id
     WHERE d.customer_id = :id AND d.deleted_at IS NULL
     ORDER BY d.uploaded_at DESC"
);
$stmt->execute(['id' => $customer['id']]);
$documents = $stmt->fetchAll();

render_dashboard_start('documents', 'Documents');
?>
<?php if (!$documents): ?>
<p class="empty-state">No documents on file yet. Documents you or your consultant add to an application will appear here.</p>
<?php else: ?>
<div class="table-wrap">
    <table class="admin-table">
        <thead><tr><th>Document</th><th>Application</th><th>Status</th><th>Uploaded</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($documents as $doc): ?>
        <tr>
            <td><?= e($doc['document_type'] ?? $doc['original_filename']) ?></td>
            <td><?= $doc['application_reference_no'] ? '<a href="/dashboard/applications/?id=' . (int) $doc['visa_application_id'] . '">' . e($doc['application_reference_no']) . '</a>' : '—' ?></td>
            <td><span class="badge <?= $doc['verification_status'] === 'verified' ? 'badge-success' : ($doc['verification_status'] === 'rejected' ? 'badge-danger' : 'badge-warning') ?>"><?= e($doc['verification_status']) ?></span></td>
            <td><?= e(date('d M Y', strtotime((string) $doc['uploaded_at']))) ?></td>
            <td><a href="/dashboard/document-download/?id=<?= (int) $doc['id'] ?>">Download</a></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</div>
<?php endif; ?>
<?php render_dashboard_end(); ?>
