<?php
/**
 * Payment — Visa Agency (design preview)
 *
 * Real payments go through the Paytm Payment Link below — clicking it
 * leaves this site and completes on Paytm's own hosted checkout, so no
 * fake "paid" confirmation is ever shown here.
 */

$sitePhoneDisplay = '+91 78448 19819';
$sitePhoneE164    = '+917844819819';
$siteWhatsappUrl  = 'https://wa.me/917844819819';
$siteEmail        = 'info@visaagency.in';
$sitePaymentLink  = 'https://pmny.in/qIyJENrpxkqM';

$pageTitle       = 'Payment — Visa Agency (Design Preview)';
$pageDescription = 'Design concept preview of the payment page — arrange payment by contacting the team directly.';
$activeNav       = 'payment';
include __DIR__ . '/header.php';
?>

  <!-- INTRO -->
  <section class="hero" style="padding:64px 0 56px;">
    <div class="wrap">
      <span class="badge">Payment</span>
      <h1 style="max-width:20ch;">Pay your filing fee, referenced to your application.</h1>
      <p class="hero-lead">
        Consulate and government charges are billed separately. Our filing fee
        is quoted before you commit, and shared with you along with the ways
        to pay it.
      </p>
    </div>
  </section>

  <!-- PAYMENT -->
  <section class="alt">
    <div class="wrap">
      <div class="section-head">
        <span class="kicker">Make a payment</span>
        <h2>Pay online, or reach us to arrange another way.</h2>
        <p>Paying online takes you to our secure Paytm payment page. Include your application or invoice reference in the note field so we can match it quickly.</p>
      </div>

      <div class="ticket" style="grid-template-columns:1fr;">
        <div class="ticket-main" style="border-right:none;">
          <div class="alert">
            <strong>Note.</strong>
            We never ask for your card number, CVV, UPI PIN or online banking password over phone, WhatsApp or email. Only pay through the button below or account/UPI details shared directly by our team in an official invoice.
          </div>
          <div class="hero-actions">
            <a class="btn btn-solid" href="<?php echo htmlspecialchars($sitePaymentLink); ?>" target="_blank" rel="noopener">Pay Online Now</a>
          </div>
          <div class="hero-actions" style="margin-bottom:0;">
            <a class="btn btn-ghost" href="tel:<?php echo htmlspecialchars($sitePhoneE164); ?>">Call <?php echo htmlspecialchars($sitePhoneDisplay); ?></a>
            <a class="btn btn-ghost" href="<?php echo htmlspecialchars($siteWhatsappUrl); ?>" target="_blank" rel="noopener">WhatsApp Us</a>
            <a class="btn btn-ghost" href="mailto:<?php echo htmlspecialchars($siteEmail); ?>">Email Us</a>
          </div>
        </div>
      </div>
    </div>
  </section>

<?php include __DIR__ . '/footer.php'; ?>
