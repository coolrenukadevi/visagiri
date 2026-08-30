<?php
/** POST /document-delete — AJAX target for the "Remove" action on an
 *  uploaded document. Ownership checked the same way document.php does. */
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

$uid = trim((string) ($_POST['uid'] ?? ''));
$document = $uid !== '' ? document_find_by_uid($uid) : null;
if (!$document || (int) $document['customer_id'] !== (int) $customer['id']) {
    $respond(['ok' => false, 'error' => 'Document not found.'], 404);
}

document_delete($document);
$totals = documents_for_enquiry((int) $document['enquiry_id']);
$respond([
    'ok' => true,
    'count_non_passport' => count(array_filter($totals, static fn($d) => !$d['is_passport'])),
    'total_bytes' => array_sum(array_column($totals, 'size_bytes')),
    'has_passport' => (bool) array_filter($totals, static fn($d) => $d['is_passport']),
]);
