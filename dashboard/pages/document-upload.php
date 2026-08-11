<?php
declare(strict_types=1);

/** POST /dashboard/documents/{id}/upload/ — $id set by dashboard/index.php. */

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

if (!in_array($doc['status'], DOCUMENT_EDITABLE_STATUSES, true)) {
    flash_set('notice', 'This document is under review and can\'t be replaced right now.');
    redirect($backTo);
}

$file = $_FILES['document'] ?? null;

if (!$file || $file['error'] === UPLOAD_ERR_NO_FILE) {
    flash_set('notice', 'Choose a file to upload.');
    redirect($backTo);
}

if ($file['error'] !== UPLOAD_ERR_OK) {
    flash_set('notice', 'Upload failed. Please try again.');
    redirect($backTo);
}

if ($file['size'] > DOCUMENT_MAX_BYTES || $file['size'] === 0) {
    flash_set('notice', 'File must be between 1 byte and 5 MB.');
    redirect($backTo);
}

$finfo = finfo_open(FILEINFO_MIME_TYPE);
$detectedMime = finfo_file($finfo, $file['tmp_name']);
finfo_close($finfo);

if (!isset(DOCUMENT_ALLOWED_MIME[$detectedMime])) {
    flash_set('notice', 'Only PDF, JPG, or PNG files are accepted.');
    redirect($backTo);
}

$extension = DOCUMENT_ALLOWED_MIME[$detectedMime];
$dir = document_upload_dir($doc['application_id']);

if (!is_dir($dir) && !mkdir($dir, 0750, true) && !is_dir($dir)) {
    flash_set('notice', 'Could not store the file. Please try again.');
    redirect($backTo);
}

$storedFilename = bin2hex(random_bytes(16)) . '.' . $extension;
$destination = "$dir/$storedFilename";

if (!move_uploaded_file($file['tmp_name'], $destination)) {
    flash_set('notice', 'Could not store the file. Please try again.');
    redirect($backTo);
}

$previousStoredFilename = $doc['stored_filename'];

$update = $pdo->prepare(
    'UPDATE application_documents
     SET original_filename = :original_filename, stored_filename = :stored_filename,
         mime_type = :mime_type, file_size = :file_size, status = "uploaded",
         uploaded_at = NOW(), reviewer_comment = NULL, reviewed_by = NULL, reviewed_at = NULL
     WHERE id = :id'
);
$update->execute([
    'original_filename' => mb_substr(basename($file['name']), 0, 255),
    'stored_filename' => $storedFilename,
    'mime_type' => $detectedMime,
    'file_size' => $file['size'],
    'id' => $doc['id'],
]);

if ($previousStoredFilename) {
    $oldPath = "$dir/$previousStoredFilename";
    if (is_file($oldPath)) {
        unlink($oldPath);
    }
}

flash_set('notice', 'Document uploaded successfully.');
redirect($backTo);
