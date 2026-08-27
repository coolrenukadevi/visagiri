<?php
/**
 * POST-only endpoint: verifies a submitted email OTP code.
 */
header('Content-Type: application/json');
require_once __DIR__ . '/includes/b2b-otp.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed.']);
    exit;
}

$pdo = b2b_db();

$email = filter_var(trim($_POST['email'] ?? ''), FILTER_VALIDATE_EMAIL);
$purpose = trim($_POST['purpose'] ?? '');
$code = preg_replace('/\D/', '', $_POST['code'] ?? '');

if (!$email || !in_array($purpose, B2B_OTP_PURPOSES, true) || strlen($code) !== 6) {
    http_response_code(422);
    echo json_encode(['success' => false, 'message' => 'Please enter the 6-digit code.']);
    exit;
}

$verified = b2b_verify_otp($pdo, $email, $purpose, $code);

if (!$verified) {
    http_response_code(422);
    echo json_encode(['success' => false, 'message' => 'That code is incorrect or has expired. Please request a new one.']);
    exit;
}

echo json_encode(['success' => true, 'message' => 'Email verified.']);
