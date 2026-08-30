<?php
/**
 * GET /document?uid=... — the ONLY way a stored document is ever read back.
 * Ownership is re-checked here regardless of who linked to this URL; a
 * document_uid is unguessable but not treated as a secret on its own.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/customer_auth.php';
require_once __DIR__ . '/lib-php/enquiries.php';
require_once __DIR__ . '/lib-php/documents.php';

auth_session_start();
$customer = customer_current();
if (!$customer) {
    header('Location: ' . url('/customer-login') . '?next=' . rawurlencode(auth_safe_next($_SERVER['REQUEST_URI'] ?? '/')), true, 302);
    exit;
}

$uid = trim((string) ($_GET['uid'] ?? ''));
$document = $uid !== '' ? document_find_by_uid($uid) : null;
if (!$document || (int) $document['customer_id'] !== (int) $customer['id']) {
    http_response_code(404);
    exit('Not found.');
}

document_serve($document);
