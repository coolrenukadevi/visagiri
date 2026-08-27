<?php
/**
 * POST-only handler for b2b-login.php. Delegates the actual credential
 * check + session setup to partner_attempt_login() in
 * includes/partner-auth.php.
 */
header('Content-Type: application/json');
require_once __DIR__ . '/includes/partner-auth.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed.']);
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
