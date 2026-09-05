<?php
/**
 * Payment — Visa Agency (design preview)
 *
 * This preview does not process payments or generate confirmations —
 * doing so without a real gateway would show visitors a fake "paid"
 * state. It mirrors the live site's honest fallback instead: real
 * contact details, and a note that bank/UPI details are shared per
 * invoice. Once real payment link(s) are supplied, wire the "Pay Online"
 * button below to them.
 */

$sitePhoneDisplay = '+91 78448 19819';
$sitePhoneE164    = '+917844819819';
$siteWhatsappUrl  = 'https://wa.me/917844819819';
$siteEmail        = 'info@visaagency.in';

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
        <h2>Online payment details aren't published yet.</h2>
        <p>Contact us and our team will share bank transfer or UPI details along with your invoice, referenced to your application.</p>
      </div>

      <div class="ticket" style="grid-template-columns:1fr;">
        <div class="ticket-main" style="border-right:none;">
          <div class="alert">
            <strong>Note.</strong>
            We never ask for your card number, CVV, UPI PIN or online banking password over phone, WhatsApp or email. Only use account/UPI details shared directly by our team in an official invoice.
          </div>
          <div class="hero-actions" style="margin-bottom:0;">
            <a class="btn btn-solid" href="tel:<?php echo htmlspecialchars($sitePhoneE164); ?>">Call <?php echo htmlspecialchars($sitePhoneDisplay); ?></a>
            <a class="btn btn-ghost" href="<?php echo htmlspecialchars($siteWhatsappUrl); ?>" target="_blank" rel="noopener">WhatsApp Us</a>
            <a class="btn btn-ghost" href="mailto:<?php echo htmlspecialchars($siteEmail); ?>">Email Us</a>
          </div>
        </div>
      </div>
    </div>
  </section>

<?php include __DIR__ . '/footer.php'; ?>
