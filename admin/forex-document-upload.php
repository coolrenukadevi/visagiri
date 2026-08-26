<?php
ob_start();
require_once __DIR__ . '/includes/admin-auth.php';
require_once __DIR__ . '/../includes/forex-db.php';
require_once __DIR__ . '/includes/forex-permissions.php';
admin_require_login();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    exit('Method not allowed.');
}

$pdo = forex_db();

$requestId = (int) ($_POST['forex_request_id'] ?? 0);
$docType = trim($_POST['doc_type'] ?? '');
if (!$requestId || !array_key_exists($docType, FOREX_DOC_TYPES)) {
    http_response_code(400);
    exit('Invalid request.');
}

$reqStmt = $pdo->prepare('SELECT * FROM forex_requests WHERE id = ?');
$reqStmt->execute([$requestId]);
$request = $reqStmt->fetch(PDO::FETCH_ASSOC);
if (!$request) {
    http_response_code(404);
    exit('Forex request not found.');
}

if (empty($_FILES['document']) || $_FILES['document']['error'] === UPLOAD_ERR_NO_FILE) {
    header('Location: forex-request.php?ref=' . urlencode($request['forex_ref']) . '&upload_error=1');
    exit;
}

$file = $_FILES['document'];
$allowedExt = ['pdf', 'jpg', 'jpeg', 'png'];
$allowedMime = ['application/pdf', 'image/jpeg', 'image/png'];
$maxBytes = 5 * 1024 * 1024;

if ($file['error'] !== UPLOAD_ERR_OK) {
    header('Location: forex-request.php?ref=' . urlencode($request['forex_ref']) . '&upload_error=1');
    exit;
}
if ($file['size'] > $maxBytes) {
    header('Location: forex-request.php?ref=' . urlencode($request['forex_ref']) . '&upload_error=size');
    exit;
}
$ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
$finfo = new finfo(FILEINFO_MIME_TYPE);
$mime = $finfo->file($file['tmp_name']) ?: '';
if (!in_array($ext, $allowedExt, true) || !in_array($mime, $allowedMime, true)) {
    header('Location: forex-request.php?ref=' . urlencode($request['forex_ref']) . '&upload_error=type');
    exit;
}

$targetDir = __DIR__ . '/../uploads/forex/' . $request['forex_ref'];
if (!is_dir($targetDir)) {
    mkdir($targetDir, 0770, true);
}
// Human-traceable filenames for compliance review, per spec — not the
// random-hex naming the enquiry system uses.
$storedName = $request['forex_ref'] . '-' . strtoupper($docType) . '-' . time() . '.' . $ext;
if (!move_uploaded_file($file['tmp_name'], $targetDir . '/' . $storedName)) {
    header('Location: forex-request.php?ref=' . urlencode($request['forex_ref']) . '&upload_error=1');
    exit;
}

$now = gmdate('c');
$existingStmt = $pdo->prepare('SELECT id, stored_filename, status FROM forex_documents WHERE forex_request_id = ? AND doc_type = ? ORDER BY id DESC LIMIT 1');
$existingStmt->execute([$requestId, $docType]);
$existing = $existingStmt->fetch(PDO::FETCH_ASSOC);

if ($existing && $existing['stored_filename'] === null) {
    // First upload against a placeholder checklist row created at request creation — fill it in.
    $pdo->prepare("UPDATE forex_documents SET original_filename = ?, stored_filename = ?, mime = ?, size = ?, status = 'Uploaded', rejection_reason = NULL, uploaded_at = ? WHERE id = ?")
        ->execute([$file['name'], $storedName, $mime, $file['size'], $now, $existing['id']]);
    $docId = (int) $existing['id'];
} else {
    // Replacing an already-uploaded document — insert a new version, keep the old row as history.
    $pdo->prepare("INSERT INTO forex_documents (forex_request_id, doc_type, original_filename, stored_filename, mime, size, status, replaces_document_id, uploaded_at) VALUES (?, ?, ?, ?, ?, ?, 'Uploaded', ?, ?)")
        ->execute([$requestId, $docType, $file['name'], $storedName, $mime, $file['size'], $existing['id'] ?? null, $now]);
    $docId = (int) $pdo->lastInsertId();
}

if ($docType === 'Declaration') {
    $pdo->prepare('UPDATE forex_declarations SET stored_filename = ?, uploaded_at = ? WHERE forex_request_id = ?')
        ->execute([$storedName, $now, $requestId]);
}

forex_log_audit($pdo, $requestId, admin_name(), admin_role(), 'Uploaded document: ' . FOREX_DOC_TYPES[$docType], '', $file['name']);

header('Location: forex-request.php?ref=' . urlencode($request['forex_ref']) . '&uploaded=1');
exit;
