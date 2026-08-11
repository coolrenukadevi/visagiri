<?php
declare(strict_types=1);

/** GET /admin/documents/{id}/download/ — $id set by admin/index.php. Role already gated by the router. */

$pdo = db();
$doc = fetch_application_document($pdo, $id);

if (!$doc || !$doc['stored_filename']) {
    render_not_found("We couldn't find that document.");
}

$path = document_upload_dir($doc['application_id']) . '/' . basename($doc['stored_filename']);

if (!is_file($path)) {
    render_not_found('That file is no longer available.');
}

header('Content-Type: ' . ($doc['mime_type'] ?: 'application/octet-stream'));
header('Content-Disposition: attachment; filename="' . str_replace('"', '', $doc['original_filename']) . '"');
header('Content-Length: ' . (string) filesize($path));
header('X-Content-Type-Options: nosniff');
readfile($path);
exit;
