<?php
declare(strict_types=1);

/** POST /dashboard/documents/{id}/delete/ — $id set by dashboard/index.php. */

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    redirect('/dashboard/documents/');
}

csrf_require();

$user = current_user();
$pdo = db();
$doc = fetch_owned_application_document($pdo, $id, (int) $user['id']);

if (!$doc) {
    render_not_found("We couldn't find that document.");
}

$backTo = '/dashboard/applications/' . $doc['application_id'] . '/';

if (!in_array($doc['status'], DOCUMENT_EDITABLE_STATUSES, true) || !$doc['stored_filename']) {
    flash_set('notice', 'This document can\'t be removed right now.');
    redirect($backTo);
}

$path = document_upload_dir($doc['application_id']) . '/' . basename($doc['stored_filename']);
if (is_file($path)) {
    unlink($path);
}

$update = $pdo->prepare(
    'UPDATE application_documents
     SET original_filename = NULL, stored_filename = NULL, mime_type = NULL, file_size = NULL,
         status = "required", uploaded_at = NULL, reviewer_comment = NULL, reviewed_by = NULL, reviewed_at = NULL
     WHERE id = :id'
);
$update->execute(['id' => $doc['id']]);

flash_set('notice', 'Document removed.');
redirect($backTo);
