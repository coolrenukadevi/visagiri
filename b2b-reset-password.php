<?php
/**
 * POST-only handler: completes a partner password reset after a
 * password_reset-purpose OTP has been verified. Mirrors the
 * verify-then-consume shape of b2b_verify_otp() used elsewhere — the code
 * is checked and consumed here in one step (no separate "verify" click for
 * this flow, unlike registration, since there's nothing else to gate on
 * the email besides the reset itself).
 */
header('Content-Type: application/json');
require_once __DIR__ . '/includes/b2b-otp.php';
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

$pdo = b2b_db();

$email = filter_var(trim($_POST['email'] ?? ''), FILTER_VALIDATE_EMAIL);
$code = trim($_POST['code'] ?? '');
$password = (string) ($_POST['new_password'] ?? '');
$passwordConfirm = (string) ($_POST['new_password_confirm'] ?? '');

if (!$email || $code === '') {
    http_response_code(422);
    echo json_encode(['success' => false, 'message' => 'Please enter the code sent to your email.']);
    exit;
}
if (strlen($password) < 8) {
    http_response_code(422);
    echo json_encode(['success' => false, 'message' => 'Password must be at least 8 characters.']);
    exit;
}
if ($password !== $passwordConfirm) {
    http_response_code(422);
    echo json_encode(['success' => false, 'message' => 'Passwords do not match.']);
    exit;
}

if (!b2b_verify_otp($pdo, $email, 'password_reset', $code)) {
    http_response_code(422);
    echo json_encode(['success' => false, 'message' => 'That code is incorrect or has expired. Please request a new one.']);
    exit;
}

$stmt = $pdo->prepare("SELECT id, partner_id, name FROM b2b_partner_users WHERE email = ? AND status = 'Active'");
$stmt->execute([$email]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$user) {
    http_response_code(422);
    echo json_encode(['success' => false, 'message' => 'This account could not be found. Please contact your Relationship Manager.']);
    exit;
}

$pdo->prepare('UPDATE b2b_partner_users SET password_hash = ? WHERE id = ?')
    ->execute([password_hash($password, PASSWORD_DEFAULT), $user['id']]);

b2b_log_audit($pdo, 'partner', (int) $user['partner_id'], $user['name'], 'Partner', 'Partner password reset via forgot-password flow');

echo json_encode(['success' => true, 'message' => 'Password reset.']);
