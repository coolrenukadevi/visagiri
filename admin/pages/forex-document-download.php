<?php
declare(strict_types=1);

/**
 * Authenticated forex document download. Every access is logged to
 * the shared audit_logs table (module = forex_documents) — section
 * 26's "secure download authorization" requirement, without a
 * separate access-log table since audit_logs already answers "who
 * accessed which document, when."
 */

require_permission('forex.requests.view');

$id = (int) ($_GET['id'] ?? 0);
if (!$id) {
    http_response_code(404);
    exit('Document not found.');
}

$stmt = db()->prepare(
    'SELECT d.*, r.assigned_employee FROM forex_documents d
     JOIN forex_requests r ON r.id = d.forex_request_id
     WHERE d.id = :id AND d.deleted_at IS NULL AND r.deleted_at IS NULL'
);
$stmt->execute(['id' => $id]);
$document = $stmt->fetch();

if (!$document) {
    http_response_code(404);
    exit('Document not found.');
}

if (current_admin_forex_scoped_to_assigned() && (int) $document['assigned_employee'] !== current_admin_id()) {
    http_response_code(403);
    exit('This document is on a forex request not assigned to you.');
}

$path = __DIR__ . '/../../' . $document['storage_path'];
if (!is_file($path)) {
    http_response_code(404);
    exit('File is missing from storage.');
}

log_action('document_download', 'forex_documents', $id, null, $document['document_type']);

header('Content-Type: ' . $document['mime_type']);
header('Content-Disposition: attachment; filename="' . rawurlencode($document['original_filename']) . '"');
header('Content-Length: ' . (string) filesize($path));
header('X-Content-Type-Options: nosniff');
readfile($path);
exit;
