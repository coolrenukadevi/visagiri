<?php
declare(strict_types=1);

/**
 * Minimal hand-rolled SMTP client — no PHPMailer/Composer, matching
 * this project's zero-dependency convention (see includes/encryption.php,
 * includes/currency-rate.php: everything hand-rolled against PHP's own
 * stdlib, no vendor/ directory anywhere in this codebase). Speaks just
 * enough SMTP (EHLO, STARTTLS, AUTH LOGIN, MAIL FROM/RCPT TO/DATA) to
 * work with a standard cPanel mailbox or any provider's SMTP relay
 * (SendGrid, SES, Postmark, etc. all support this exact same flow).
 *
 * Same defensive shape as get_usd_inr_rate() in currency-rate.php: a
 * connection failure, missing config, or SMTP error never throws —
 * send_mail() just returns false, and every caller already treats a
 * failed send as non-fatal (see the APP_DEBUG on-screen-link fallback
 * already used by the password-reset flows). This sandbox has no
 * outbound network access to any external host at all (confirmed
 * repeatedly elsewhere in this project's history), so the live-send
 * success path can't be exercised from here — only the "no config /
 * connection failed" fallback path is testable in this environment.
 */

/** Loads config/smtp.php, or null if it doesn't exist (not configured yet). */
function smtp_config(): ?array
{
    static $config = null;
    static $loaded = false;
    if ($loaded) {
        return $config;
    }
    $loaded = true;

    $path = __DIR__ . '/../config/smtp.php';
    if (!is_file($path)) {
        return null;
    }
    $config = require $path;
    return is_array($config) ? $config : null;
}

/**
 * Sends one HTML email. Returns true only on a confirmed successful
 * SMTP send; false for anything else (no config, connection failure,
 * auth failure, rejected recipient) — never throws.
 */
function send_mail(string $toEmail, string $subject, string $htmlBody, ?string $toName = null): bool
{
    $config = smtp_config();
    if ($config === null) {
        return false;
    }

    try {
        return smtp_send($config, $toEmail, $toName, $subject, $htmlBody);
    } catch (Throwable) {
        return false;
    }
}

function smtp_send(array $config, string $toEmail, ?string $toName, string $subject, string $htmlBody): bool
{
    $host = (string) ($config['host'] ?? '');
    $port = (int) ($config['port'] ?? 587);
    $encryption = (string) ($config['encryption'] ?? 'tls');
    $username = (string) ($config['username'] ?? '');
    $password = (string) ($config['password'] ?? '');
    $fromEmail = (string) ($config['from_email'] ?? ($username !== '' ? $username : 'noreply@' . (parse_url(APP_URL, PHP_URL_HOST) ?: 'localhost')));
    $fromName = (string) ($config['from_name'] ?? 'Visagiri');

    if ($host === '') {
        return false;
    }

    $remote = ($encryption === 'ssl' ? 'ssl://' : 'tcp://') . $host . ':' . $port;
    $context = stream_context_create(['ssl' => ['verify_peer' => true, 'verify_peer_name' => true]]);
    $socket = @stream_socket_client($remote, $errno, $errstr, 10, STREAM_CLIENT_CONNECT, $context);
    if ($socket === false) {
        return false;
    }

    try {
        if (!smtp_expect($socket, 220)) {
            return false;
        }

        $localHost = parse_url(APP_URL, PHP_URL_HOST) ?: 'localhost';
        smtp_command($socket, 'EHLO ' . $localHost);
        if (!smtp_expect($socket, 250)) {
            return false;
        }

        if ($encryption === 'tls') {
            smtp_command($socket, 'STARTTLS');
            if (!smtp_expect($socket, 220)) {
                return false;
            }
            if (!@stream_socket_enable_crypto($socket, true, STREAM_CRYPTO_METHOD_TLS_CLIENT)) {
                return false;
            }
            smtp_command($socket, 'EHLO ' . $localHost);
            if (!smtp_expect($socket, 250)) {
                return false;
            }
        }

        // Empty username = an unauthenticated relay (the common case
        // for cPanel's own local mail server on port 25, which most
        // shared-hosting deployments can use with zero credentials) —
        // skip AUTH entirely rather than sending an empty AUTH LOGIN
        // exchange a real server would reject anyway.
        if ($username !== '') {
            smtp_command($socket, 'AUTH LOGIN');
            if (!smtp_expect($socket, 334)) {
                return false;
            }
            smtp_command($socket, base64_encode($username));
            if (!smtp_expect($socket, 334)) {
                return false;
            }
            smtp_command($socket, base64_encode($password));
            if (!smtp_expect($socket, 235)) {
                return false;
            }
        }

        smtp_command($socket, 'MAIL FROM:<' . $fromEmail . '>');
        if (!smtp_expect($socket, 250)) {
            return false;
        }
        smtp_command($socket, 'RCPT TO:<' . $toEmail . '>');
        if (!smtp_expect($socket, 250)) {
            return false;
        }

        smtp_command($socket, 'DATA');
        if (!smtp_expect($socket, 354)) {
            return false;
        }

        $toHeader = $toName !== null && $toName !== '' ? smtp_encode_header_word($toName) . ' <' . $toEmail . '>' : $toEmail;
        $fromHeader = smtp_encode_header_word($fromName) . ' <' . $fromEmail . '>';
        $messageId = '<' . bin2hex(random_bytes(16)) . '@' . $localHost . '>';

        $headers = [
            'Date: ' . date('r'),
            'To: ' . $toHeader,
            'From: ' . $fromHeader,
            'Subject: ' . smtp_encode_header_word($subject),
            'Message-ID: ' . $messageId,
            'MIME-Version: 1.0',
            'Content-Type: text/html; charset=UTF-8',
            'Content-Transfer-Encoding: 8bit',
        ];

        // Per RFC 5321, a line consisting of just "." ends the DATA
        // block, so any body line starting with "." must be escaped
        // by doubling it — otherwise a coincidental leading dot in the
        // HTML would silently truncate the message.
        $escapedBody = preg_replace('/^\./m', '..', $htmlBody);

        $message = implode("\r\n", $headers) . "\r\n\r\n" . $escapedBody . "\r\n.";
        smtp_command($socket, $message);
        if (!smtp_expect($socket, 250)) {
            return false;
        }

        smtp_command($socket, 'QUIT');
        return true;
    } finally {
        fclose($socket);
    }
}

/** @param resource $socket */
function smtp_command($socket, string $line): void
{
    fwrite($socket, $line . "\r\n");
}

/**
 * Reads one (possibly multi-line) SMTP reply and checks its status
 * code matches $expectedCode. Multi-line replies use "250-" for every
 * line except the last, which uses "250 " — read until a line with a
 * space (not a dash) in the fourth column.
 * @param resource $socket
 */
function smtp_expect($socket, int $expectedCode): bool
{
    $code = null;
    while (($line = fgets($socket, 515)) !== false) {
        $code = (int) substr($line, 0, 3);
        if (($line[3] ?? '') === ' ') {
            break;
        }
    }
    return $code === $expectedCode;
}

/** Encodes a header value as RFC 2047 UTF-8 base64 if it contains any non-ASCII byte, otherwise leaves it plain. */
function smtp_encode_header_word(string $value): string
{
    if (preg_match('/[^\x20-\x7E]/', $value) !== 1) {
        return $value;
    }
    return '=?UTF-8?B?' . base64_encode($value) . '?=';
}
