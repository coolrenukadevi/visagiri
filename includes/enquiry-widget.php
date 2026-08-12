<?php
declare(strict_types=1);

/**
 * Floating enquiry widget — WhatsApp, Call, Email in one expandable
 * button, sitewide on every public marketing page (included from
 * footer.php, so it doesn't appear inside the dashboard/admin/
 * consultant app shells, which close differently).
 *
 * Phone number is real, not invented: +91 7065 819 819 appears
 * consistently across 8+ pages of the preserved legacy site
 * (grievance.html, career.html, partner.html, testimonial.html,
 * support.html, country-details.html) alongside the already-reused
 * info@visagiri.com address — confirmed with the client before use
 * here. Same number used for both Call and WhatsApp.
 */

$enquiryPhoneDisplay = setting('contact_phone_display', '+91 7065 819 819');
$enquiryPhoneDial = setting('contact_phone_dial', '+917065819819');
$enquiryEmail = setting('contact_email', 'info@visagiri.com');
?>
<div class="enquiry-widget" id="enquiry-widget">
    <div class="enquiry-widget__actions" id="enquiry-widget-actions">
        <a
            href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to know more about your visa services.")) ?>"
            class="enquiry-widget__action enquiry-widget__action--whatsapp"
            target="_blank" rel="noopener noreferrer"
            aria-label="Chat with Visagiri on WhatsApp"
        >
            <svg width="22" height="22" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M12.01 2C6.48 2 2 6.48 2 12c0 1.85.5 3.58 1.36 5.07L2 22l5.08-1.33A9.94 9.94 0 0 0 12.01 22C17.53 22 22 17.52 22 12S17.53 2 12.01 2Zm0 18.13c-1.66 0-3.2-.48-4.5-1.31l-.32-.2-3.02.79.8-2.95-.21-.31A8.11 8.11 0 0 1 3.87 12c0-4.49 3.65-8.13 8.14-8.13 4.48 0 8.13 3.64 8.13 8.13 0 4.48-3.65 8.13-8.13 8.13Zm4.47-6.09c-.24-.12-1.44-.71-1.67-.79-.22-.08-.38-.12-.55.12-.16.24-.63.79-.77.95-.14.16-.28.18-.53.06-.24-.12-1.02-.38-1.94-1.2-.72-.64-1.2-1.43-1.35-1.67-.14-.24-.02-.37.11-.49.11-.11.24-.28.36-.42.12-.14.16-.24.24-.4.08-.16.04-.3-.02-.42-.06-.12-.55-1.33-.76-1.82-.2-.48-.4-.42-.55-.42h-.47c-.16 0-.42.06-.64.3-.22.24-.84.82-.84 2s.86 2.32.98 2.48c.12.16 1.7 2.6 4.13 3.64.58.25 1.03.4 1.38.51.58.18 1.11.16 1.53.1.47-.07 1.44-.59 1.64-1.15.2-.57.2-1.05.14-1.15-.06-.1-.22-.16-.46-.28Z"/></svg>
        </a>
        <a
            href="tel:<?= e($enquiryPhoneDial) ?>"
            class="enquiry-widget__action enquiry-widget__action--call"
            aria-label="Call Visagiri at <?= e($enquiryPhoneDisplay) ?>"
        >
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92Z"/></svg>
        </a>
        <a
            href="mailto:<?= e($enquiryEmail) ?>"
            class="enquiry-widget__action enquiry-widget__action--email"
            aria-label="Email Visagiri at <?= e($enquiryEmail) ?>"
        >
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 4h16v16H4z" opacity="0"/><path d="M22 6c0-1.1-.9-2-2-2H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V6Z"/><path d="m2 7 8.97 6.28a2 2 0 0 0 2.06 0L22 7"/></svg>
        </a>
    </div>
    <button
        type="button"
        class="enquiry-widget__toggle"
        id="enquiry-widget-toggle"
        aria-expanded="false"
        aria-controls="enquiry-widget-actions"
        aria-label="Contact Visagiri"
    >
        <svg class="enquiry-widget__icon-open" width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5Z"/></svg>
        <svg class="enquiry-widget__icon-close" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M18 6 6 18M6 6l12 12"/></svg>
    </button>
</div>
