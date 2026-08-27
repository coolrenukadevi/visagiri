<?php
/**
 * POST-only document upload handler for the pre-login B2B partner
 * documents page (b2b-partner-documents.php). Mirrors
 * forex-document-upload.php's exact validation pattern (extension +
 * MIME whitelist via finfo, size cap, human-traceable filenames,
 * versioning via replaces_document_id) but is gated by the partner's
 * upload_token instead of admin_require_login(), since no partner
 * login exists yet (that's Phase 5).
 */
header('Content-Type: application/json');
require_once __DIR__ . '/includes/b2b-db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed.']);
    exit;
}

$pdo = b2b_db();

$ref = trim($_POST['ref'] ?? '');
$token = trim($_POST['token'] ?? '');
$partner = b2b_partner_by_token($pdo, $ref, $token);
if (!$partner) {
    http_response_code(403);
    echo json_encode(['success' => false, 'message' => 'This upload link is invalid or has expired.']);
    exit;
}

$docType = trim($_POST['doc_type'] ?? '');
if (!array_key_exists($docType, B2B_DOC_TYPES)) {
    http_response_code(422);
    echo json_encode(['success' => false, 'message' => 'Unknown document type.']);
    exit;
}
if ($docType === 'IATA' && !$partner['iata_registered']) {
    http_response_code(422);
    echo json_encode(['success' => false, 'message' => 'IATA certificate is only applicable for IATA-registered partners.']);
    exit;
}

if (empty($_FILES['file']) || $_FILES['file']['error'] !== UPLOAD_ERR_OK) {
    http_response_code(422);
    echo json_encode(['success' => false, 'message' => 'Please choose a file to upload.']);
    exit;
}

$allowedExtensions = json_decode(b2b_setting($pdo, 'allowed_file_types', '["pdf","jpg","jpeg","png","doc","docx"]'), true) ?: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'];
$maxSizeMb = (int) b2b_setting($pdo, 'max_upload_size_mb', '10');
$maxSizeBytes = $maxSizeMb * 1024 * 1024;

$originalName = $_FILES['file']['name'];
$tmpPath = $_FILES['file']['tmp_name'];
$size = (int) $_FILES['file']['size'];

if ($size > $maxSizeBytes) {
    http_response_code(422);
    echo json_encode(['success' => false, 'message' => "File is too large. Maximum size is {$maxSizeMb} MB."]);
    exit;
}

$ext = strtolower(pathinfo($originalName, PATHINFO_EXTENSION));
if (!in_array($ext, $allowedExtensions, true)) {
    http_response_code(422);
    echo json_encode(['success' => false, 'message' => 'Unsupported file type. Allowed: ' . strtoupper(implode(', ', $allowedExtensions)) . '.']);
    exit;
}

$mimeAllowlist = [
    'pdf' => ['application/pdf'],
    'jpg' => ['image/jpeg'], 'jpeg' => ['image/jpeg'],
    'png' => ['image/png'],
    'doc' => ['application/msword'],
    'docx' => ['application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/zip'],
];
$finfo = new finfo(FILEINFO_MIME_TYPE);
$detectedMime = $finfo->file($tmpPath);
$expectedMimes = $mimeAllowlist[$ext] ?? [];
if (!in_array($detectedMime, $expectedMimes, true)) {
    http_response_code(422);
    echo json_encode(['success' => false, 'message' => 'The file content does not match its extension. Please upload a genuine ' . strtoupper($ext) . ' file.']);
    exit;
}

$targetDir = __DIR__ . '/uploads/b2b-partners/' . $partner['application_ref'];
if (!is_dir($targetDir)) {
    mkdir($targetDir, 0770, true);
}
$storedFilename = $partner['application_ref'] . '-' . $docType . '-' . time() . '.' . $ext;
$targetPath = $targetDir . '/' . $storedFilename;

if (!move_uploaded_file($tmpPath, $targetPath)) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Could not save the uploaded file. Please try again.']);
    exit;
}

// Versioning: find the current row for this doc_type (if any) so the new upload supersedes it.
$existingStmt = $pdo->prepare('SELECT id FROM b2b_partner_documents WHERE partner_id = ? AND doc_type = ? ORDER BY id DESC LIMIT 1');
$existingStmt->execute([$partner['id'], $docType]);
$replacesId = $existingStmt->fetchColumn() ?: null;

$now = gmdate('c');
$insert = $pdo->prepare('INSERT INTO b2b_partner_documents (
    partner_id, doc_type, original_filename, stored_filename, mime, size, status, replaces_document_id, uploaded_at
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)');
$insert->execute([$partner['id'], $docType, $originalName, $storedFilename, $detectedMime, $size, 'Pending', $replacesId ?: null, $now]);
$docId = (int) $pdo->lastInsertId();

b2b_log_audit($pdo, 'document', $docId, 'Website', 'System', 'Document uploaded: ' . B2B_DOC_TYPES[$docType], '', $originalName);
b2b_notify($pdo, null, 'b2b_document_uploaded', "{$partner['company_name']} uploaded {$docType} for {$partner['application_ref']}.", $partner['id']);

echo json_encode([
    'success' => true,
    'doc_id' => $docId,
    'filename' => $originalName,
    'status' => 'Pending',
    'view_url' => 'b2b-document-view.php?id=' . $docId . '&token=' . rawurlencode($token),
]);
