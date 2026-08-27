<?php
/**
 * Real email OTP for B2B partner registration/login/password-reset.
 * Sent via the existing crm_send_applicant_email() (PHP mail(), same as
 * every other applicant-facing email on this site) — no SMS/WhatsApp OTP,
 * since no gateway credential exists anywhere in this codebase (confirmed
 * by grep before this module was built). Mobile OTP is not faked.
 */
require_once __DIR__ . '/b2b-db.php';

/**
 * Generates a 6-digit code, stores its hash (never the plaintext) with a
 * 10-minute expiry, and emails it. Returns true if the email send
 * succeeded. Rate-limited by the caller (see b2b-otp-send.php) — this
 * function itself always issues a fresh code.
 */
function b2b_send_otp(PDO $pdo, string $email, string $purpose, ?int $partnerUserId = null): bool
{
    $code = str_pad((string) random_int(0, 999999), 6, '0', STR_PAD_LEFT);
    $codeHash = password_hash($code, PASSWORD_DEFAULT);
    $expiresAt = gmdate('c', time() + B2B_OTP_TTL_SECONDS);

    $pdo->prepare('INSERT INTO b2b_otp_codes (partner_user_id, email, purpose, code_hash, expires_at, created_at, ip_address) VALUES (?, ?, ?, ?, ?, ?, ?)')
        ->execute([$partnerUserId, $email, $purpose, $codeHash, $expiresAt, gmdate('c'), $_SERVER['REMOTE_ADDR'] ?? null]);

    $subjects = [
        'register' => 'Your VisaAgency.in B2B Partner Verification Code',
        'login' => 'Your VisaAgency.in B2B Partner Login Code',
        'password_reset' => 'Your VisaAgency.in B2B Partner Password Reset Code',
    ];
    $subject = $subjects[$purpose] ?? 'Your VisaAgency.in Verification Code';

    return crm_send_applicant_email(
        $email,
        $subject,
        "Your verification code is: $code\n\nThis code expires in " . (B2B_OTP_TTL_SECONDS / 60) . " minutes. If you did not request this, you can safely ignore this email.\n\nRegards,\nVisaAgency.in B2B Partner Team"
    );
}

/**
 * Verifies a submitted code against the most recent unconsumed code for
 * this email+purpose. Enforces expiry and a max-attempts cap (locks the
 * code out after B2B_OTP_MAX_ATTEMPTS wrong tries, matching how
 * track-application.php rate-limits lookups). On success marks the row
 * consumed so it can't be replayed.
 */
function b2b_verify_otp(PDO $pdo, string $email, string $purpose, string $code): bool
{
    $stmt = $pdo->prepare('SELECT * FROM b2b_otp_codes WHERE email = ? AND purpose = ? AND consumed_at IS NULL ORDER BY id DESC LIMIT 1');
    $stmt->execute([$email, $purpose]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$row) {
        return false;
    }
    if (strtotime($row['expires_at']) < time()) {
        return false;
    }
    if ((int) $row['attempts'] >= B2B_OTP_MAX_ATTEMPTS) {
        return false;
    }

    $pdo->prepare('UPDATE b2b_otp_codes SET attempts = attempts + 1 WHERE id = ?')->execute([$row['id']]);

    if (!password_verify($code, $row['code_hash'])) {
        return false;
    }

    $pdo->prepare('UPDATE b2b_otp_codes SET consumed_at = ? WHERE id = ?')->execute([gmdate('c'), $row['id']]);
    return true;
}

/** True if this email has a consumed (verified) OTP for the given purpose within the last hour — used to gate final submission on a prior successful verify. */
function b2b_email_recently_verified(PDO $pdo, string $email, string $purpose): bool
{
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM b2b_otp_codes WHERE email = ? AND purpose = ? AND consumed_at IS NOT NULL AND consumed_at > ?");
    $stmt->execute([$email, $purpose, gmdate('c', time() - 3600)]);
    return (int) $stmt->fetchColumn() > 0;
}
