<?php
declare(strict_types=1);

/**
 * Sends a submitted enquiry to the Google Apps Script Web App bridge
 * (see docs/google-sheets-setup.md + google-apps-script/Code.gs),
 * which appends a row to a Google Sheet and saves a copy to Google
 * Drive. This app has no database of its own to log enquiries in —
 * Sheets/Drive are the actual system of record, not a nice-to-have.
 *
 * Returns true only if the script actually confirmed it wrote the
 * row — a network error, a wrong URL, a script exception, or Google
 * returning its login/permission-error HTML all count as failure so
 * the caller knows to fall back to email rather than silently
 * reporting success.
 */
function submit_enquiry_to_google(array $data): bool
{
    $url = GOOGLE_APPS_SCRIPT_URL;
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
 * Full enquiry submission: tries the Google Sheets/Drive bridge first
 * (the actual record-keeping system), then always also emails the
 * team as a live notification — and, if the Google bridge failed or
 * hasn't been set up yet, as the only surviving copy of the enquiry.
 * Returns true if at least one channel succeeded, so the caller shows
 * an honest error only when the enquiry was genuinely lost.
 */
function submit_enquiry(array $data): bool
{
    $sentToGoogle = submit_enquiry_to_google($data);

    $subject = 'New enquiry from ' . ($data['name'] !== '' ? $data['name'] : 'website visitor');
    $lines = [
        'Name: ' . $data['name'],
        'Email: ' . $data['email'],
        'Phone: ' . ($data['phone'] !== '' ? $data['phone'] : 'Not provided'),
        'Destination: ' . ($data['destination'] !== '' ? $data['destination'] : 'Not specified'),
        'Submitted: ' . $data['submitted_at'],
        '',
        'Message:',
        $data['message'],
    ];
    if (!$sentToGoogle) {
        array_unshift($lines, '(Google Sheets/Drive delivery failed or is not yet configured — this email is the only record of this enquiry.)', '');
    }
    $body = implode("\n", $lines);

    $headers = 'From: ' . MAIL_FROM_NAME . ' <' . MAIL_FROM_ADDRESS . '>' . "\r\n"
        . 'Reply-To: ' . $data['email'] . "\r\n";

    $sentByEmail = @mail(MAIL_ENQUIRY_RECIPIENTS, $subject, $body, $headers);

    return $sentToGoogle || $sentByEmail;
}
