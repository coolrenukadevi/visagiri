<?php
/**
 * POST-only handler for b2b-login.php. Delegates the actual credential
 * check + session setup to partner_attempt_login() in
 * includes/partner-auth.php.
 */
header('Content-Type: application/json');
require_once __DIR__ . '/includes/partner-auth.php';
require_once __DIR__ . '/includes/b2b-csrf.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed.']);
    exit;
}

if (!b2b_csrf_valid()) {
    http_response_code(403);
    echo json_encode(['success' => false, 'message' => 'Security check failed. Please refresh the page and try again.']);
    exit;
}

$identifier = trim($_POST['identifier'] ?? '');
$password = (string) ($_POST['password'] ?? '');

if ($identifier === '' || $password === '') {
    http_response_code(422);
    echo json_encode(['success' => false, 'message' => 'Please enter your username/email and password.']);
    exit;
}

$result = partner_attempt_login($identifier, $password);

if (!$result['success']) {
    http_response_code(401);
    echo json_encode($result);
    exit;
}

echo json_encode(['success' => true, 'redirect' => 'b2b-dashboard.php']);
