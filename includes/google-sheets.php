<?php
declare(strict_types=1);

/**
 * Sends a submitted enquiry to the Google Apps Script Web App bridge
 * (see docs/google-sheets-setup.md + google-apps-script/Code.gs),
 * which appends a row to a Google Sheet and saves a copy to Google
 * Drive. Now that MySQL is back, the database is the canonical,
 * admin-manageable record (enquiries/contact_messages tables) — this
 * is a secondary channel for whoever prefers checking a spreadsheet.
 *
 * Returns true only if the script actually confirmed it wrote the
 * row — a network error, a wrong URL, a script exception, or Google
 * returning its login/permission-error HTML all count as failure.
 */
function submit_enquiry_to_google(array $data): bool
{
    $url = setting('google_apps_script_url');
    if ($url === '') {
        return false;
    }

    $payload = json_encode($data, JSON_UNESCAPED_SLASHES);
    if ($payload === false) {
        return false;
    }

    $body = null;

    if (function_exists('curl_init')) {
        $ch = curl_init($url);
        curl_setopt_array($ch, [
            CURLOPT_POST => true,
            CURLOPT_POSTFIELDS => $payload,
            CURLOPT_HTTPHEADER => ['Content-Type: application/json'],
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_MAXREDIRS => 5,
            CURLOPT_TIMEOUT => 8,
            CURLOPT_SSL_VERIFYPEER => true,
        ]);
        $result = curl_exec($ch);
        curl_close($ch);
        $body = $result !== false ? $result : null;
    } else {
        // Fallback for hosts without the curl extension enabled —
        // needs allow_url_fopen, on by default on virtually all
        // shared-hosting PHP builds.
        $context = stream_context_create([
            'http' => [
                'method' => 'POST',
                'header' => "Content-Type: application/json\r\n",
                'content' => $payload,
                'timeout' => 8,
                'ignore_errors' => true,
                'follow_location' => 1,
            ],
        ]);
        $result = @file_get_contents($url, false, $context);
        $body = $result !== false ? $result : null;
    }

    if ($body === null) {
        return false;
    }

    $decoded = json_decode($body, true);
    return is_array($decoded) && !empty($decoded['ok']);
}

/**
 * Best-effort side channels for a submission already safely stored in
 * MySQL: an optional copy to Google Sheets/Drive, and an email ping to
 * the team. Neither failing is treated as the submission failing —
 * the database row (and its reference number, for enquiries) is
 * already the durable record; these are just convenience notifications.
 *
 * The email goes through includes/mail.php's real SMTP client (via
 * config/smtp.php) rather than PHP's own mail(), which relies on
 * whatever local mail transport the server happens to have and is
 * prone to landing in spam without the sending domain's own SPF/DKIM
 * set up. If config/smtp.php isn't set up, send_mail() just returns
 * false per recipient — same "notification silently doesn't go out,
 * the DB row is still the real record" behavior as before.
 */
function notify_enquiry_channels(array $data): void
{
    submit_enquiry_to_google($data);

    $subject = 'New enquiry from ' . ($data['name'] !== '' ? $data['name'] : 'website visitor');
    $lines = [
        'Reference: ' . ($data['reference_number'] ?? 'N/A'),
        'Name: ' . $data['name'],
        'Email: ' . $data['email'],
        'Phone: ' . ($data['phone'] !== '' ? $data['phone'] : 'Not provided'),
        'Destination: ' . ($data['destination'] !== '' ? $data['destination'] : 'Not specified'),
        'Submitted: ' . $data['submitted_at'],
        '',
        'Message:',
        $data['message'],
    ];
    $htmlBody = '<p>' . implode('<br>', array_map(static fn(string $line): string => e($line) !== '' ? e($line) : '&nbsp;', $lines)) . '</p>';

    $recipients = setting('mail_enquiry_recipients', 'info@tripgation.com');
    // is_valid_email() at submission time already guarantees $data['email']
    // has no control characters, so it's safe to use directly as a header value.
    $replyTo = is_valid_email($data['email']) ? $data['email'] : null;

    foreach (array_filter(array_map('trim', explode(',', $recipients))) as $recipient) {
        if (is_valid_email($recipient)) {
            send_mail($recipient, $subject, $htmlBody, null, $replyTo);
        }
    }
}
