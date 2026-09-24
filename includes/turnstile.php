<?php
declare(strict_types=1);

/**
 * Cloudflare Turnstile anti-spam challenge for the site's public lead
 * forms (/contact/, /enquire/ — including the sitewide "Enquire Now"
 * modal, which reuses the same markup — and /partners/). Added after
 * real spam got through the existing honeypot + rate_limit_check()
 * pair: a honeypot only stops bots that blindly fill every field, not
 * ones using a headless browser that can see a field is hidden via CSS
 * and correctly skip it. See AUDIT.md for the incident this responds to.
 *
 * Configured via two site_settings keys (admin/pages/settings.php):
 * turnstile_site_key (public, embedded in the page) and
 * turnstile_secret_key (private, used server-side only, never sent to
 * the browser). Until an admin sets both, every function here is a
 * no-op: turnstile_enabled() is false, the widget renders nothing, and
 * turnstile_verify() returns true — forms keep working exactly as
 * before, honeypot + rate limiting only, so this ships safely ahead of
 * the client actually creating a Cloudflare Turnstile site and pasting
 * in the keys.
 */

function turnstile_enabled(): bool
{
    return setting('turnstile_site_key') !== '' && setting('turnstile_secret_key') !== '';
}

/**
 * The widget markup for one form: a container div Turnstile's script
 * replaces with the actual challenge. Safe to call more than once per
 * page — every call after the first skips the containing <script> tag
 * (the sitewide "Enquire Now" modal and a standalone page's own form
 * can both be present in the DOM at once, e.g. /contact/, and each
 * needs its own div, but the loader script itself only needs loading
 * once; Turnstile's script auto-renders every .cf-turnstile div on the
 * page, including ones added later, e.g. the modal's lazy-loaded
 * wizard fragment).
 */
function turnstile_widget_html(): string
{
    if (!turnstile_enabled()) {
        return '';
    }

    static $scriptEmitted = false;

    $siteKey = e(setting('turnstile_site_key'));
    $html = "<div class=\"cf-turnstile\" data-sitekey=\"{$siteKey}\"></div>";
    if (!$scriptEmitted) {
        $html .= "\n<script src=\"https://challenges.cloudflare.com/turnstile/v0/api.js\" async defer></script>";
        $scriptEmitted = true;
    }
    return $html;
}

/**
 * Verifies a submitted form's Turnstile response token server-side.
 * Returns true when Turnstile isn't configured yet (see docblock
 * above), so callers can unconditionally gate on this without an extra
 * turnstile_enabled() check of their own.
 */
function turnstile_verify(string $token): bool
{
    if (!turnstile_enabled()) {
        return true;
    }
    if ($token === '') {
        return false;
    }

    $payload = [
        'secret' => setting('turnstile_secret_key'),
        'response' => $token,
        'remoteip' => $_SERVER['REMOTE_ADDR'] ?? '',
    ];

    $body = null;
    $url = 'https://challenges.cloudflare.com/turnstile/v0/siteverify';

    if (function_exists('curl_init')) {
        $ch = curl_init($url);
        curl_setopt_array($ch, [
            CURLOPT_POST => true,
            CURLOPT_POSTFIELDS => http_build_query($payload),
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_TIMEOUT => 8,
            CURLOPT_SSL_VERIFYPEER => true,
        ]);
        $result = curl_exec($ch);
        curl_close($ch);
        $body = $result !== false ? $result : null;
    } else {
        // Fallback for hosts without curl — mirrors
        // submit_enquiry_to_google()'s same fallback in google-sheets.php.
        $context = stream_context_create([
            'http' => [
                'method' => 'POST',
                'header' => "Content-Type: application/x-www-form-urlencoded\r\n",
                'content' => http_build_query($payload),
                'timeout' => 8,
                'ignore_errors' => true,
            ],
        ]);
        $result = @file_get_contents($url, false, $context);
        $body = $result !== false ? $result : null;
    }

    if ($body === null) {
        // Network/Cloudflare failure, not a real visitor failing the
        // challenge — fail open rather than blocking every legitimate
        // submission because of a transient outage on Cloudflare's end.
        return true;
    }

    $decoded = json_decode($body, true);
    return is_array($decoded) && !empty($decoded['success']);
}
