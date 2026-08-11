<?php
declare(strict_types=1);

/** POST /admin/documents/{id}/reject/ — $id set by admin/index.php. */

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    redirect('/admin/documents/');
}

csrf_require();

$admin = current_user();
$pdo = db();
$doc = fetch_application_document($pdo, $id);

if (!$doc) {
    render_not_found("We couldn't find that document.");
}

$backTo = filter_var($_POST['redirect_to'] ?? '', FILTER_VALIDATE_REGEXP, ['options' => ['regexp' => '#^/admin/#']])
    ?: '/admin/documents/';

$comment = trim((string) ($_POST['comment'] ?? ''));

if (!$doc['stored_filename'] || !in_array($doc['status'], ['uploaded', 'under_review'], true)) {
    flash_set('notice', 'This document is not awaiting review.');
    redirect($backTo);
}

if ($comment === '') {
    flash_set('notice', 'A reason is required to reject a document.');
    redirect($backTo);
}

$pdo->prepare(
    'UPDATE application_documents
     SET status = "rejected", reviewer_comment = :comment, reviewed_by = :reviewed_by, reviewed_at = NOW()
     WHERE id = :id'
)->execute(['comment' => $comment, 'reviewed_by' => $admin['id'], 'id' => $doc['id']]);

flash_set('notice', "{$doc['document_name']} rejected.");
redirect($backTo);
