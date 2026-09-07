<?php
declare(strict_types=1);

/** Authenticated download of a B2B visa enquiry document (b2b_enquiry_documents). */

require_permission('b2b_travel_partners.view');

$id = (int) ($_GET['id'] ?? 0);
if (!$id) {
    http_response_code(404);
    exit('Document not found.');
}

$stmt = db()->prepare('SELECT * FROM b2b_enquiry_documents WHERE id = :id AND deleted_at IS NULL');
$stmt->execute(['id' => $id]);
$document = $stmt->fetch();

if (!$document) {
    http_response_code(404);
    exit('Document not found.');
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
