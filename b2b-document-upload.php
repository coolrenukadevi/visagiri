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

$result = b2b_save_uploaded_document($pdo, $partner, $docType, $_FILES['file'] ?? [], 'Website', 'System');
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
    'view_url' => 'b2b-document-view.php?id=' . $result['doc_id'] . '&token=' . rawurlencode($token),
]);
