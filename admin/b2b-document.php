<?php
/**
 * Staff-side document streaming — mirrors admin/forex-document.php exactly.
 */
require_once __DIR__ . '/includes/admin-auth.php';
require_once __DIR__ . '/includes/b2b-permissions.php';
require_once __DIR__ . '/../includes/b2b-db.php';
admin_require_login();

$id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);
if (!$id) {
    http_response_code(400);
    exit('Invalid document id.');
}

$pdo = b2b_db();
$stmt = $pdo->prepare('SELECT d.*, p.application_ref, p.assigned_manager_id FROM b2b_partner_documents d
    JOIN b2b_partners p ON p.id = d.partner_id WHERE d.id = ?');
$stmt->execute([$id]);
$doc = $stmt->fetch(PDO::FETCH_ASSOC);

// KYC documents (PAN, GST, IATA certs, etc.) are sensitive — a staff member
// with no B2B visibility into this partner (not on b2b_can_view_all() and
// not the partner's assigned manager) must not be able to pull them just by
// guessing/incrementing the numeric id, even though they're logged in.
if (!$doc || !$doc['stored_filename'] || (!b2b_can_view_all() && (int) $doc['assigned_manager_id'] !== admin_user_id())) {
    http_response_code(404);
    exit('Document not found.');
}

$path = __DIR__ . '/../uploads/b2b-partners/' . $doc['application_ref'] . '/' . $doc['stored_filename'];
if (!is_file($path)) {
    http_response_code(404);
    exit('File missing on disk.');
}

header('Content-Type: ' . $doc['mime']);
header('Content-Disposition: attachment; filename="' . preg_replace('/[^A-Za-z0-9._-]/', '_', $doc['original_filename']) . '"');
header('Content-Length: ' . filesize($path));
header('X-Content-Type-Options: nosniff');
readfile($path);
