<?php
require_once __DIR__ . '/includes/admin-auth.php';
require_once __DIR__ . '/../includes/forex-db.php';
admin_require_login();

$id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);
if (!$id) {
    http_response_code(400);
    exit('Invalid document id.');
}

$pdo = forex_db();
$stmt = $pdo->prepare('SELECT d.*, r.forex_ref FROM forex_documents d
    JOIN forex_requests r ON r.id = d.forex_request_id WHERE d.id = ?');
$stmt->execute([$id]);
$doc = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$doc || !$doc['stored_filename']) {
    http_response_code(404);
    exit('Document not found.');
}

$path = __DIR__ . '/../uploads/forex/' . $doc['forex_ref'] . '/' . $doc['stored_filename'];
if (!is_file($path)) {
    http_response_code(404);
    exit('File missing on disk.');
}

header('Content-Type: ' . $doc['mime']);
header('Content-Disposition: attachment; filename="' . preg_replace('/[^A-Za-z0-9._-]/', '_', $doc['original_filename']) . '"');
header('Content-Length: ' . filesize($path));
header('X-Content-Type-Options: nosniff');
readfile($path);
