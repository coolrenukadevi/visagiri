<?php
/**
 * POST-only endpoint: sends a fresh email OTP for Forex customer-portal
 * login, called via fetch() from forex-login.php. Mirrors b2b-otp-send.php's
 * rate-limit and neutral-response shape, adapted for mobile-only lookup
 * (there is no forex customer "account" to enumerate the existence of via
 * email like the B2B flow does — the equivalent risk here is confirming
 * whether a given mobile number has ever submitted a forex request, so the
 * response is worded the same regardless of whether one was found).
 */
header('Content-Type: application/json');
require_once __DIR__ . '/includes/forex-db.php';
require_once __DIR__ . '/includes/forex-csrf.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed.']);
    exit;
}

forex_csrf_require_or_json403();

$pdo = forex_db();

$mobile = trim($_POST['mobile'] ?? '');
$digits = forex_normalize_mobile($mobile);

if (strlen($digits) !== 10) {
    http_response_code(422);
    echo json_encode(['success' => false, 'message' => 'Please enter a valid 10-digit mobile number.']);
    exit;
}

// Rate limit: max 3 OTP sends per IP per 5 minutes, and max 3 per mobile per 5 minutes.
$ip = $_SERVER['REMOTE_ADDR'] ?? '';
$since = gmdate('c', time() - 300);
if ($ip !== '') {
    $stmt = $pdo->prepare('SELECT COUNT(*) FROM forex_customer_otps WHERE ip_address = ? AND created_at > ?');
    $stmt->execute([$ip, $since]);
    if ((int) $stmt->fetchColumn() >= 3) {
        http_response_code(429);
        echo json_encode(['success' => false, 'message' => 'Too many login requests. Please wait a few minutes and try again.']);
        exit;
    }
}
$stmt = $pdo->prepare('SELECT COUNT(*) FROM forex_customer_otps WHERE mobile = ? AND created_at > ?');
$stmt->execute([$digits, $since]);
if ((int) $stmt->fetchColumn() >= 3) {
    http_response_code(429);
    echo json_encode(['success' => false, 'message' => 'Too many login requests for this mobile number. Please wait a few minutes and try again.']);
    exit;
}

$genericMessage = 'If a Forex request exists for this mobile number, we\'ve emailed a login code to the address on file.';

$email = forex_customer_email_for_mobile($pdo, $digits);
if ($email === null) {
    // Neutral response either way — do not reveal whether this mobile has any requests.
    echo json_encode(['success' => true, 'message' => $genericMessage, 'masked_email' => null]);
    exit;
}

$sent = forex_send_customer_otp($pdo, $digits, $email);
if (!$sent) {
    http_response_code(502);
    echo json_encode(['success' => false, 'message' => 'We could not send the login email right now. Please try again shortly.']);
    exit;
}

$atPos = strpos($email, '@');
$masked = $atPos !== false && $atPos > 1
    ? substr($email, 0, 1) . str_repeat('*', max(1, $atPos - 1)) . substr($email, $atPos)
    : null;

echo json_encode(['success' => true, 'message' => $genericMessage, 'masked_email' => $masked]);
