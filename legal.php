<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';

$pageTitle = 'Privacy Policy, Terms & Refund Policy — Videshia';
$pageDescription = 'Videshia\'s privacy policy, terms of service and refund policy for visa, travel, forex and insurance services.';
require __DIR__ . '/includes/header.php';
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Legal</span>
        <h1>Policies &amp; Terms</h1>
        <p>Last updated: <?= date('d F Y') ?></p>
    </div>
</section>

<section class="section">
    <div class="container" style="max-width:840px">

        <div id="privacy" style="margin-bottom:56px">
            <h2>Privacy Policy</h2>
            <p>Videshia ("we", "us") collects the information you submit through our enquiry forms and CRM — including name, contact details, passport and travel details, and uploaded documents — solely to process your visa, travel, forex or insurance request.</p>
            <p>We do not sell your personal data. Information is shared only with the relevant embassy, consulate, airline, hotel, forex partner or insurer required to fulfil your specific request, and with Videshia staff assigned to your case.</p>
            <p>Documents you upload are stored securely and access-controlled; only staff assigned to your enquiry, or administrators for audit purposes, can view them. You may request a copy or deletion of your data by contacting <a href="mailto:hello@videshia.com" style="color:var(--teal-500)">hello@videshia.com</a>, subject to records we're legally required to retain.</p>
            <p>We use cookies for essential site functionality and to keep you signed in. We do not use third-party advertising trackers.</p>
        </div>

        <div id="terms" style="margin-bottom:56px">
            <h2>Terms of Service</h2>
            <p>Videshia acts as a facilitator for visa applications, travel bookings, forex transactions and insurance policies. Final approval decisions rest entirely with the relevant embassy, consulate, government authority, airline, hotel, forex provider or insurer — Videshia cannot guarantee approval, booking confirmation, or exchange rates beyond what our partners commit to at the time of transaction.</p>
            <p>You are responsible for the accuracy of the information and documents you provide. Submitting false or incomplete information may result in application rejection, for which Videshia is not liable.</p>
            <p>Service fees charged by Videshia are separate from government visa fees, airline/hotel charges, forex margins, or insurance premiums, and are disclosed to you before you confirm an order.</p>
        </div>

        <div id="refund" style="margin-bottom:24px">
            <h2>Refund Policy</h2>
            <p>Videshia's service fee is refundable in full if we have not yet begun work on your case (document review, appointment booking, or submission). Once an application has been submitted to an embassy, airline, hotel, forex partner or insurer, our service fee is non-refundable, though any refundable third-party amount (e.g. a cancellable hotel booking) will be passed on per that partner's own policy.</p>
            <p>Government visa fees, once paid to an embassy or consulate, are governed by that authority's own refund policy and are typically non-refundable regardless of application outcome.</p>
            <p>For a refund request, contact <a href="mailto:hello@videshia.com" style="color:var(--teal-500)">hello@videshia.com</a> with your enquiry reference number.</p>
        </div>

        <p style="font-size:13px;color:var(--muted-soft)">This page is a general summary and not exhaustive legal advice. For questions about a specific case, contact our team directly.</p>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
