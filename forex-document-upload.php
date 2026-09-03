<?php
/**
 * POST-only public document upload handler for forex-documents.php.
 * Mirrors b2b-document-upload.php exactly — gated by the request's
 * upload_token instead of admin_require_login(), since a forex enquiry
 * doesn't create a login account.
 */
header('Content-Type: application/json');
require_once __DIR__ . '/includes/forex-db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed.']);
    exit;
}

$pdo = forex_db();

$ref = trim($_POST['ref'] ?? '');
$token = trim($_POST['token'] ?? '');
$request = forex_request_by_token($pdo, $ref, $token);
if (!$request) {
    http_response_code(403);
    echo json_encode(['success' => false, 'message' => 'This upload link is invalid or has expired.']);
    exit;
}

$docType = trim($_POST['doc_type'] ?? '');

$result = forex_save_uploaded_document($pdo, $request, $docType, $_FILES['document'] ?? []);
if (!$result['success']) {
    http_response_code($result['code'] ?? 422);
    echo json_encode(['success' => false, 'message' => $result['message']]);
    exit;
}

echo json_encode([
    'success' => true,
    'doc_id' => $result['doc_id'],
    'filename' => $result['filename'],
    'status' => $result['status'],
]);
