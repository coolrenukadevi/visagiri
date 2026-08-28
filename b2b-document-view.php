<?php
/**
 * Token-gated document streaming for the partner's own pre-login preview
 * (b2b-partner-documents.php's "View" links). Mirrors admin/forex-document.php's
 * security properties exactly: opaque numeric id, path resolved server-side
 * from the DB, sanitized Content-Disposition, X-Content-Type-Options: nosniff
 * — except the auth check here is "does this token match the document's
 * owning partner" instead of an admin session.
 */
require_once __DIR__ . '/includes/b2b-db.php';

$id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);
$token = trim($_GET['token'] ?? '');
if (!$id || $token === '') {
    http_response_code(400);
    exit('Invalid request.');
}

$pdo = b2b_db();
$stmt = $pdo->prepare('SELECT d.*, p.application_ref, p.upload_token FROM b2b_partner_documents d
    JOIN b2b_partners p ON p.id = d.partner_id WHERE d.id = ?');
$stmt->execute([$id]);
$doc = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$doc || !$doc['stored_filename'] || $doc['deleted_at'] || !$doc['upload_token'] || !hash_equals($doc['upload_token'], $token)) {
    http_response_code(404);
    exit('Document not found.');
}

$path = __DIR__ . '/uploads/b2b-partners/' . $doc['application_ref'] . '/' . $doc['stored_filename'];
if (!is_file($path)) {
    http_response_code(404);
    exit('File missing on disk.');
}

header('Content-Type: ' . $doc['mime']);
header('Content-Disposition: inline; filename="' . preg_replace('/[^A-Za-z0-9._-]/', '_', $doc['original_filename']) . '"');
header('Content-Length: ' . filesize($path));
header('X-Content-Type-Options: nosniff');
readfile($path);
