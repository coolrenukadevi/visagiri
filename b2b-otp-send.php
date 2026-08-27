<?php
/**
 * POST-only endpoint: sends a fresh email OTP for B2B partner
 * registration/login/password-reset. Called via fetch() from
 * b2b-partner-register.php (and later b2b-login.php/b2b-forgot-password.php).
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

if (!$email || !in_array($purpose, B2B_OTP_PURPOSES, true)) {
    http_response_code(422);
    echo json_encode(['success' => false, 'message' => 'Please enter a valid email address.']);
    exit;
}

// Rate limit: max 3 OTP sends per IP per 5 minutes, and max 3 per email per 5 minutes.
$ip = $_SERVER['REMOTE_ADDR'] ?? '';
$since = gmdate('c', time() - 300);
if ($ip !== '') {
    $stmt = $pdo->prepare('SELECT COUNT(*) FROM b2b_otp_codes WHERE ip_address = ? AND created_at > ?');
    $stmt->execute([$ip, $since]);
    if ((int) $stmt->fetchColumn() >= 3) {
        http_response_code(429);
        echo json_encode(['success' => false, 'message' => 'Too many verification requests. Please wait a few minutes and try again.']);
        exit;
    }
}
$stmt = $pdo->prepare('SELECT COUNT(*) FROM b2b_otp_codes WHERE email = ? AND created_at > ?');
$stmt->execute([$email, $since]);
if ((int) $stmt->fetchColumn() >= 3) {
    http_response_code(429);
    echo json_encode(['success' => false, 'message' => 'Too many verification requests for this email. Please wait a few minutes and try again.']);
    exit;
}

// register purpose: refuse to send a code to an email already tied to an active partner login.
if ($purpose === 'register') {
    $stmt = $pdo->prepare('SELECT COUNT(*) FROM b2b_partner_users WHERE email = ?');
    $stmt->execute([$email]);
    if ((int) $stmt->fetchColumn() > 0) {
        http_response_code(422);
        echo json_encode(['success' => false, 'message' => 'An account already exists for this email. Please contact your Relationship Manager or use Partner Login.']);
        exit;
    }
}

$sent = b2b_send_otp($pdo, $email, $purpose);

if (!$sent) {
    http_response_code(502);
    echo json_encode(['success' => false, 'message' => 'We could not send the verification email right now. Please try again shortly.']);
    exit;
}

echo json_encode(['success' => true, 'message' => 'Verification code sent to ' . $email . '.']);
