<?php
declare(strict_types=1);

/** Authenticated download of a partner-uploaded document (partner_documents, not the shared documents table). */

require_permission('partners.view');

$id = (int) ($_GET['id'] ?? 0);
if (!$id) {
    http_response_code(404);
    exit('Document not found.');
}

$stmt = db()->prepare('SELECT * FROM partner_documents WHERE id = :id AND deleted_at IS NULL');
$stmt->execute(['id' => $id]);
$document = $stmt->fetch();

if (!$document) {
    http_response_code(404);
    exit('Document not found.');
}

if (current_admin_b2b_scoped_to_assigned()) {
    $ownerStmt = db()->prepare('SELECT assigned_admin_id FROM partners WHERE id = :id');
    $ownerStmt->execute(['id' => $document['partner_id']]);
    if ((int) $ownerStmt->fetchColumn() !== current_admin_id()) {
        http_response_code(403);
        exit('This document is not on a partner assigned to you.');
    }
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
