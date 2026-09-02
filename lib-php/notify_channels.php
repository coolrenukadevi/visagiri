<?php
/**
 * Outbound notification channels beyond in-app: email, SMS, WhatsApp.
 *
 * Same honesty rule as OTP delivery (see customer_auth.php's docblock): no
 * email/SMS/WhatsApp provider is configured anywhere in this repo —
 * .env.example has no SMTP or SMS/WhatsApp block, so there is nothing to
 * actually call. Each function checks for real configuration via
 * environment variables and, finding none, records that plainly instead of
 * pretending to send. This is a real hook, not dead code nobody calls: it
 * IS wired into notification_create() below, so every real in-app
 * notification genuinely exercises this path and genuinely logs its
 * honest "not configured" outcome — the same way OTP genuinely generates
 * and checks a code even though delivery is unwired.
 *
 * An administrator finishes this by setting the env vars AND replacing the
 * marked TODO with a real call to their chosen provider's API. Deliberately
 * not guessing a provider (Twilio? MSG91? SendGrid?) and writing untested
 * integration code against it — that would be exactly the kind of invented
 * specificity this project avoids everywhere else (see the FEMA/RBI
 * placeholders in compliance.php for the same principle).
 *
 * notify_customer()/notify_employee_by_name() below are the one entry
 * point enquiries.php/documents.php/support.php actually call: create the
 * real in-app notification, then best-effort attempt email through the
 * (currently unconfigured) hook above. This file requires both
 * notifications.php and customer_auth.php, which is exactly why the
 * email-attempt logic lives here and not in notifications.php — that file
 * is required BY customer_auth.php's dependents (enquiries.php etc.), so
 * putting a customer_auth.php dependency the other way around would be a
 * require_once cycle.
 */
declare(strict_types=1);

require_once __DIR__ . '/notifications.php';
require_once __DIR__ . '/customer_auth.php';

function notify_email_configured(): bool { return (bool) getenv('SMTP_HOST'); }
function notify_sms_configured(): bool { return (bool) getenv('SMS_PROVIDER_API_KEY'); }
function notify_whatsapp_configured(): bool { return (bool) getenv('WHATSAPP_PROVIDER_API_KEY'); }

function notify_email_send(string $to, string $subject, string $body): bool
{
    if ($to === '' || !notify_email_configured()) {
        log_error("notify: email to '{$to}' not sent — SMTP_HOST is not configured. Subject: {$subject}");
        return false;
    }
    // TODO(administrator): SMTP_HOST is set — call your provider's real
    // send API here (or PHPMailer/similar if you add one) and return
    // whether it actually succeeded. Nothing below this line is real yet.
    log_error("notify: SMTP_HOST is configured but no send implementation is wired up yet (to={$to})");
    return false;
}

function notify_sms_send(string $toMobile, string $message): bool
{
    if ($toMobile === '' || !notify_sms_configured()) {
        log_error("notify: SMS to '{$toMobile}' not sent — SMS_PROVIDER_API_KEY is not configured.");
        return false;
    }
    // TODO(administrator): call your SMS provider's real send API here.
    log_error("notify: SMS_PROVIDER_API_KEY is configured but no send implementation is wired up yet (to={$toMobile})");
    return false;
}

function notify_whatsapp_send(string $toMobile, string $message): bool
{
    if ($toMobile === '' || !notify_whatsapp_configured()) {
        log_error("notify: WhatsApp to '{$toMobile}' not sent — WHATSAPP_PROVIDER_API_KEY is not configured.");
        return false;
    }
    // TODO(administrator): call your WhatsApp Business provider's real send API here.
    log_error("notify: WHATSAPP_PROVIDER_API_KEY is configured but no send implementation is wired up yet (to={$toMobile})");
    return false;
}

/** In-app (guaranteed) + best-effort email — the "in-app first" pattern
 *  this whole phase is named for. A failed/unconfigured email never
 *  blocks or undoes the in-app notification, which is why it's created
 *  first and this function has no return value to check. */
function notify_customer(int $customerId, string $type, string $title, string $body, ?string $link = null): void
{
    notification_create('customer', $customerId, $type, $title, $body, $link);
    $customer = customer_find($customerId);
    if ($customer) {
        notify_email_send($customer['email'], $title, $body);
    }
}

function notify_employee_by_name(string $employeeName, string $type, string $title, string $body, ?string $link = null): void
{
    notification_notify_employee_by_name($employeeName, $type, $title, $body, $link);
    $employee = employee_find_by_name($employeeName);
    if ($employee) {
        notify_email_send($employee['email'], $title, $body);
    }
}
