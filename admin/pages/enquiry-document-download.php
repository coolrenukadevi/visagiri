<?php
declare(strict_types=1);

/**
 * Authenticated download for a document attached to a unified
 * enquiry (enquiry_documents, not the generic documents table used by
 * visa_applications/general_enquiries). Same read-only shape as
 * document-download.php: verification status changes happen via
 * admin/pages/enquiries.php's CSRF-protected POST handler, not here.
 */

require_permission('enquiries.view');

$id = (int) ($_GET['id'] ?? 0);
if (!$id) {
    http_response_code(404);
    exit('Document not found.');
}

$stmt = db()->prepare(
    'SELECT d.*, e.assigned_user, e.deleted_at AS enquiry_deleted_at FROM enquiry_documents d
     JOIN enquiries e ON e.id = d.enquiry_id WHERE d.id = :id'
);
$stmt->execute(['id' => $id]);
$document = $stmt->fetch();

if (!$document || $document['enquiry_deleted_at'] !== null) {
    http_response_code(404);
    exit('Document not found.');
}
if (current_admin_scoped_to_assigned() && (int) $document['assigned_user'] !== current_admin_id()) {
    http_response_code(403);
    exit('This document is not on an enquiry assigned to you.');
}

$path = __DIR__ . '/../../' . $document['storage_path'];
if (!is_file($path)) {
    http_response_code(404);
    exit('File is missing from storage.');
}

header('Content-Type: ' . $document['mime_type']);
header('Content-Disposition: attachment; filename="' . rawurlencode($document['original_filename']) . '"');
header('Content-Length: ' . (string) filesize($path));
header('X-Content-Type-Options: nosniff');
readfile($path);
exit;
