<?php
declare(strict_types=1);

/**
 * /payment-policy/ — Payment Policy. Part of the Legal & Support
 * Centre. Confirmed by reading the schema before writing this: there
 * is no online payment gateway anywhere in this codebase
 * (visa_payments/forex_payments both record payment_method as free
 * text, staff-entered after the fact) — so "Accepted Payment Methods"
 * describes the real offline/staff-coordinated flow, not a fabricated
 * card/UPI checkout. visa_quotes genuinely splits government_fee from
 * service_fee, and forex_payments genuinely supports a
 * 'partially_paid' status, both cited accurately below.
 */


$pageTitle = 'Payment Policy | Visagiri';
$pageDescription = 'Simple, secure and transparent payments — how Visagiri\'s service fees, government/embassy charges, and third-party costs are billed.';
$canonicalUrl = APP_URL . '/payment-policy/';
$structuredData = [[
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Legal & Support', 'item' => $canonicalUrl],
        ['@type' => 'ListItem', 'position' => 3, 'name' => 'Payment Policy', 'item' => $canonicalUrl],
    ],
]];
require __DIR__ . '/../includes/header.php';

$sections = [
    'payment-methods' => 'Accepted Payment Methods',
    'service-fee' => 'Service Fee',
    'payment-confirmation' => 'Payment Confirmation',
    'failed-payments' => 'Failed Payments',
    'partial-payments' => 'Partial Payments',
    'currency' => 'Currency',
    'payment-security' => 'Payment Security',
    'contact' => 'Contact',
];

render_legal_hero(
    'payment-policy',
    'Payment Policy',
    'Simple, secure and transparent payments.',
    'legal_payment_policy_updated_at',
    $sections
);
?>
<section id="payment-methods">
    <h2>Accepted Payment Methods</h2>
    <p>Payments for our services are coordinated directly with our team rather than through an automated online checkout — our staff will confirm the accepted payment method (such as bank transfer or another mutually agreed method) with you when your service is confirmed. We will always tell you the exact amount and method before any payment is due.</p>
</section>

<section id="service-fee">
    <h2>Service Fee</h2>
    <p>We keep our fees transparent by separating them into distinct categories, so you always know what you're paying for:</p>
    <ul>
        <li><strong>Visagiri service fee</strong> — our fee for consultancy, application preparation and case management</li>
        <li><strong>Government/embassy fee</strong> — the fee charged directly by the relevant embassy, consulate or immigration authority, passed through to you at the amount they set</li>
        <li><strong>Appointment fee</strong> — where an embassy or visa centre charges a separate appointment-booking fee</li>
        <li><strong>Courier fee</strong> — where physical document delivery is required</li>
        <li><strong>Travel supplier, airline or hotel charges</strong> — where applicable, set by that supplier</li>
        <li><strong>Other third-party charges</strong> — any other cost genuinely incurred on your behalf, disclosed to you before it's charged</li>
    </ul>
    <p>A written quote showing your government fee and service fee separately is provided before you're asked to pay.</p>
</section>

<section id="payment-confirmation">
    <h2>Payment Confirmation</h2>
    <p>Your booking or service is confirmed once payment has been received and verified by our team, and you'll receive confirmation once that happens. Work on an application, attestation request or forex service does not proceed on an unpaid quote.</p>
</section>

<section id="failed-payments">
    <h2>Failed Payments</h2>
    <p>If a payment fails or is reversed for any reason, we'll contact you to arrange payment again before continuing with your service. Any delay this causes to your application, attestation, or forex request is outside our control.</p>
</section>

<section id="partial-payments">
    <h2>Partial Payments</h2>
    <p>For some services, we can accept a partial payment upfront with the remaining balance due before completion — our team will confirm whether this is available for your specific service and the schedule that applies.</p>
</section>

<section id="currency">
    <h2>Currency</h2>
    <p>Our fees are quoted in Indian Rupees (INR) unless stated otherwise. Where a payment involves a foreign-currency transaction, it may be subject to the applicable exchange rate at the time, your bank or payment provider's own charges, and any applicable taxes — none of which are set or controlled by Visagiri.</p>
</section>

<section id="payment-security">
    <h2>Payment Security</h2>
    <p>We do not store full card details, and we never ask for your card PIN, CVV or online banking password over phone, email or WhatsApp. Any payment-related information you share with us is used only to process and record the specific transaction it relates to.</p>
</section>

<section id="contact">
    <h2>Contact</h2>
    <p>Questions about a payment or invoice? Contact us at <a href="mailto:<?= e(setting('contact_email', 'info@visagiri.com')) ?>"><?= e(setting('contact_email', 'info@visagiri.com')) ?></a> or through our <a href="/contact/">Contact Us</a> page.</p>
</section>
<?php
render_legal_hero_close();
require __DIR__ . '/../includes/footer.php';
