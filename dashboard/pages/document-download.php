<?php
declare(strict_types=1);

/**
 * Customer document download. Same streaming pattern as
 * admin/pages/document-download.php, but ownership-scoped: a customer
 * may only download a document tied to their own customer_id, whoever
 * uploaded it (staff or self).
 */

$customer = current_customer();
$id = (int) ($_GET['id'] ?? 0);

$stmt = db()->prepare('SELECT * FROM documents WHERE id = :id AND customer_id = :customer_id AND deleted_at IS NULL');
$stmt->execute(['id' => $id, 'customer_id' => $customer['id']]);
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
