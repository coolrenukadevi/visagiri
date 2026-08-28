<?php
declare(strict_types=1);

/**
 * /refund-policy/ — Refund & Cancellation Policy. Part of the Legal &
 * Support Centre. No blanket refund promise anywhere on this page —
 * per the spec's own instruction — and no fixed refund-timeline
 * number invented; the process steps mirror the real, generic
 * "submit -> staff review -> resolution" shape every enquiry/grievance
 * pipeline in this codebase already uses (see admin/pages/
 * general-enquiries.php), described here at policy level rather than
 * as a fabricated numbered SLA.
 */


$pageTitle = 'Refund & Cancellation Policy | Visagiri';
$pageDescription = 'How refunds and cancellations work across Visagiri\'s visa, flight, hotel, travel package, apostille/attestation and forex services.';
$canonicalUrl = APP_URL . '/refund-policy/';
$structuredData = [[
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Legal & Support', 'item' => $canonicalUrl],
        ['@type' => 'ListItem', 'position' => 3, 'name' => 'Refund & Cancellation Policy', 'item' => $canonicalUrl],
    ],
]];
require __DIR__ . '/../includes/header.php';

$sections = [
    'visa-services' => 'Visa Services',
    'flight' => 'Flight',
    'hotel' => 'Hotel',
    'travel-packages' => 'Travel Packages',
    'apostille-attestation' => 'Apostille / Attestation',
    'forex' => 'Forex',
    'refund-process' => 'Refund Process',
    'refund-timeline' => 'Refund Timeline',
    'contact' => 'Contact',
];

render_legal_hero(
    'refund-policy',
    'Refund & Cancellation Policy',
    'A transparent look at how refunds and cancellations work, service by service.',
    'legal_refund_policy_updated_at',
    $sections
);
?>
<section id="visa-services">
    <h2>Visa Services</h2>
    <p>Our own service fee for work already carried out on your case — consultancy time, document review, application preparation — is generally not refundable once that work has started, since it reflects effort we've already delivered. Government, embassy and appointment fees that have already been paid to the relevant authority are subject to that authority's own refund rules, which are typically non-refundable once submitted — we did not set these fees and cannot control their refund policy. Where a refund is genuinely due (for example, if we haven't yet started work on your case), we'll process the portion that's refundable.</p>
</section>

<section id="flight">
    <h2>Flight</h2>
    <p>Flight refunds depend entirely on the operating airline's fare rules for the ticket you purchased. Some fares are non-refundable; others carry a cancellation fee. We'll pass on exactly what the airline confirms for your specific booking.</p>
</section>

<section id="hotel">
    <h2>Hotel</h2>
    <p>Hotel refunds depend on the individual property's own booking and cancellation terms, communicated to you at the time of booking. Free-cancellation windows, non-refundable rates, and no-show charges are all set by the hotel, not by Visagiri.</p>
</section>

<section id="travel-packages">
    <h2>Travel Packages</h2>
    <p>Where a travel package involves a third-party supplier, that supplier's own cancellation and refund rules apply. We'll confirm these to you before you commit to the package.</p>
</section>

<section id="apostille-attestation">
    <h2>Apostille / Attestation</h2>
    <p>If you cancel before we've submitted your documents to the Ministry of External Affairs, an embassy, or another attesting authority, we can refund the portion of your payment not yet spent on third-party charges. Once documents have been submitted and any government or authority fee has been paid on your behalf, that portion is no longer refundable — the same constraint that applies to visa government fees above.</p>
</section>

<section id="forex">
    <h2>Forex</h2>
    <p>Forex service cancellations and refunds depend on the stage your currency-exchange request has reached and any applicable regulatory requirement at the time. We do not offer a blanket refund guarantee on forex transactions; our team will confirm the specific refund position for your request based on its status when you ask to cancel.</p>
</section>

<section id="refund-process">
    <h2>Refund Process</h2>
    <ol>
        <li>Submit your refund request — through <a href="/contact/">Contact Us</a> or our <a href="/grievance/">Grievance Redressal</a> page if it relates to a complaint</li>
        <li>We verify your request against your service record</li>
        <li>We review your eligibility under this policy</li>
        <li>An eligible refund is approved</li>
        <li>The approved amount is processed back to you</li>
        <li>We notify you once the refund has been processed</li>
    </ol>
</section>

<section id="refund-timeline">
    <h2>Refund Timeline</h2>
    <p>Refund timelines vary by service, payment method, and — for third-party charges — the refunding party's own processing time, so we don't publish a single fixed number of days here. Our team will give you a realistic estimate for your specific case once your refund is approved.</p>
</section>

<section id="contact">
    <h2>Contact</h2>
    <p>To request a refund or ask about a cancellation, contact us at <a href="mailto:<?= e(setting('contact_email', 'info@visagiri.com')) ?>"><?= e(setting('contact_email', 'info@visagiri.com')) ?></a> or through our <a href="/contact/">Contact Us</a> page.</p>
</section>
<?php
render_legal_hero_close();
require __DIR__ . '/../includes/footer.php';
