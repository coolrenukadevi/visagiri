<?php
/**
 * POST-only endpoint: verifies a Forex customer-portal login OTP and, on
 * success, establishes the forex_customer_* session. Called via fetch()
 * from forex-login.php.
 */
header('Content-Type: application/json');
require_once __DIR__ . '/includes/forex-customer-auth.php';
require_once __DIR__ . '/includes/forex-csrf.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed.']);
    exit;
}

forex_csrf_require_or_json403();

$pdo = forex_db();

$mobile = trim($_POST['mobile'] ?? '');
$code = trim($_POST['code'] ?? '');
$digits = forex_normalize_mobile($mobile);

if (strlen($digits) !== 10 || !preg_match('/^\d{6}$/', $code)) {
    http_response_code(422);
    echo json_encode(['success' => false, 'message' => 'Please enter the 6-digit code.']);
    exit;
}

if (!forex_verify_customer_otp($pdo, $digits, $code)) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'That code is incorrect or has expired. Please request a new one.']);
    exit;
}

forex_customer_login_session($pdo, $digits);

echo json_encode(['success' => true, 'redirect' => 'forex-my-requests']);
