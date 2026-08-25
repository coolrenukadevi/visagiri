<?php
declare(strict_types=1);

/**
 * Authenticated CV/document download — the only way an hr_documents
 * row is ever reachable. Every access (view or download) is logged to
 * hr_document_access_log per section 14's explicit requirement, not
 * just gated.
 */

require_permission('hrms.documents.download');

$id = (int) ($_GET['id'] ?? 0);
if (!$id) {
    http_response_code(404);
    exit('Document not found.');
}

$stmt = db()->prepare(
    'SELECT d.*, a.assigned_hr FROM hr_documents d
     JOIN hr_applications a ON a.id = d.application_id
     WHERE d.id = :id AND d.deleted_at IS NULL AND a.deleted_at IS NULL'
);
$stmt->execute(['id' => $id]);
$document = $stmt->fetch();

if (!$document) {
    http_response_code(404);
    exit('Document not found.');
}

if (current_admin_hrms_scoped_to_assigned() && (int) $document['assigned_hr'] !== current_admin_id()) {
    http_response_code(403);
    exit('This document is on a candidate not assigned to you.');
}

$path = __DIR__ . '/../../' . $document['storage_path'];
if (!is_file($path)) {
    http_response_code(404);
    exit('File is missing from storage.');
}

log_hrms_document_access($id, 'download');

header('Content-Type: ' . $document['mime_type']);
header('Content-Disposition: attachment; filename="' . rawurlencode($document['original_filename']) . '"');
header('Content-Length: ' . (string) filesize($path));
header('X-Content-Type-Options: nosniff');
readfile($path);
exit;
