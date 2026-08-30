<?php
/**
 * POST /document-upload — AJAX target for the drag-and-drop uploader on
 * /enquiry/{code}. JSON in the response either way, so the page can update
 * the live counter and document list without a reload.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/customer_auth.php';
require_once __DIR__ . '/lib-php/enquiries.php';
require_once __DIR__ . '/lib-php/documents.php';

header('Content-Type: application/json');
header('Cache-Control: no-store, private');

$respond = static function (array $body, int $status = 200): never {
    http_response_code($status);
    echo json_encode($body);
    exit;
};

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    $respond(['ok' => false, 'error' => 'Invalid request.'], 405);
}

auth_session_start();
$customer = customer_current();
if (!$customer) {
    $respond(['ok' => false, 'error' => 'Please sign in first.'], 401);
}
if (!auth_csrf_valid($_POST['csrf'] ?? null)) {
    $respond(['ok' => false, 'error' => 'Your session expired — please refresh the page and try again.'], 419);
}

$enquiryCode = trim((string) ($_POST['enquiry_code'] ?? ''));
$enquiry = $enquiryCode !== '' ? enquiry_find_by_code($enquiryCode) : null;
if (!$enquiry || (int) $enquiry['customer_id'] !== (int) $customer['id']) {
    $respond(['ok' => false, 'error' => 'Enquiry not found.'], 404);
}

$documentTypeId = (int) ($_POST['document_type_id'] ?? 0);
if (!isset($_FILES['file'])) {
    $respond(['ok' => false, 'error' => 'Choose a file to upload.']);
}

[$document, $err] = document_upload((int) $enquiry['id'], (int) $customer['id'], $documentTypeId, $_FILES['file']);
if (!$document) {
    $respond(['ok' => false, 'error' => $err], 422);
}

$totals = documents_for_enquiry((int) $enquiry['id']);
$respond([
    'ok' => true,
    'document' => [
        'uid' => $document['document_uid'],
        'type_label' => $document['type_label'],
        'original_filename' => $document['original_filename'],
        'size_bytes' => (int) $document['size_bytes'],
        'status' => $document['status'],
        'is_passport' => (bool) $document['is_passport'],
        'url' => url('/document?uid=' . $document['document_uid']),
    ],
    'count_non_passport' => count(array_filter($totals, static fn($d) => !$d['is_passport'])),
    'total_bytes' => array_sum(array_column($totals, 'size_bytes')),
    'has_passport' => (bool) array_filter($totals, static fn($d) => $d['is_passport']),
]);
