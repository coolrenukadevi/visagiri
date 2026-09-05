<?php
$page_title = "Make a Payment &ndash; Visa Agency";
$page_description = "Pay your Visa Agency invoice by bank transfer or UPI. Reference your enquiry or application number so we can match your payment quickly.";
include __DIR__ . '/includes/header.php';

$hasBankDetails = $site_bank_account_number !== '' && $site_bank_ifsc !== '';
$hasUpi = $site_upi_id !== '';
$hasPaymentLink = !empty($site_payment_link);
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Make a Payment</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Make a Payment</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="console-intro">
            <div class="console-intro-inner">
                <div class="console-tag"><span class="blink"></span> payment.reference() &middot; Bank Transfer &middot; UPI</div>
                <p class="lede">Use the details below to pay an invoice or quotation raised by our team. Always include your Enquiry, Application or Forex Reference Number so we can match your payment without delay.</p>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <?php if ($hasPaymentLink): ?>
                <div class="console-tool-panel" style="margin-bottom:24px;">
                    <div class="console-tool-panel-bar"><span class="dot"></span><span class="dot"></span><span class="dot"></span><span class="path">payment / pay-online</span></div>
                    <div class="console-tool-panel-body">
                        <p style="margin:0 0 14px; font-size:14.5px;">Pay securely online now. Add your Enquiry, Application or Forex Reference Number in the payment note so we can match it to your file.</p>
                        <div class="console-cta-row">
                            <a class="console-btn console-btn-primary" href="<?php echo htmlspecialchars($site_payment_link); ?>" target="_blank" rel="noopener">Pay Online Now</a>
                        </div>
                    </div>
                </div>
                <?php endif; ?>

                <?php if ($hasBankDetails || $hasUpi): ?>
                <div class="row g-4 align-items-stretch">
                    <?php if ($hasBankDetails): ?>
                    <div class="col-lg-6">
                        <div class="console-tool-panel" style="height:100%;">
                            <div class="console-tool-panel-bar"><span class="dot"></span><span class="dot"></span><span class="dot"></span><span class="path">payment / bank-transfer</span></div>
                            <div class="console-tool-panel-body" style="display:grid; gap:16px;">
                                <div>
                                    <p style="font-family:monospace; font-size:11px; text-transform:uppercase; letter-spacing:0.08em; color:var(--text); margin:0 0 6px;">Account Name</p>
                                    <p style="margin:0; font-size:14.5px;"><?php echo htmlspecialchars($site_bank_account_name); ?></p>
                                </div>
                                <div>
                                    <p style="font-family:monospace; font-size:11px; text-transform:uppercase; letter-spacing:0.08em; color:var(--text); margin:0 0 6px;">Account Number</p>
                                    <p style="margin:0; font-size:14.5px;"><?php echo htmlspecialchars($site_bank_account_number); ?></p>
                                </div>
                                <div>
                                    <p style="font-family:monospace; font-size:11px; text-transform:uppercase; letter-spacing:0.08em; color:var(--text); margin:0 0 6px;">IFSC Code</p>
                                    <p style="margin:0; font-size:14.5px;"><?php echo htmlspecialchars($site_bank_ifsc); ?></p>
                                </div>
                                <div>
                                    <p style="font-family:monospace; font-size:11px; text-transform:uppercase; letter-spacing:0.08em; color:var(--text); margin:0 0 6px;">Bank &amp; Branch</p>
                                    <p style="margin:0; font-size:14.5px;"><?php echo htmlspecialchars($site_bank_name); ?><?php echo $site_bank_branch ? ', ' . htmlspecialchars($site_bank_branch) : ''; ?></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <?php endif; ?>

                    <?php if ($hasUpi): ?>
                    <div class="col-lg-6">
                        <div class="console-tool-panel" style="height:100%;">
                            <div class="console-tool-panel-bar"><span class="dot"></span><span class="dot"></span><span class="dot"></span><span class="path">payment / upi</span></div>
                            <div class="console-tool-panel-body" style="display:grid; gap:16px;">
                                <div>
                                    <p style="font-family:monospace; font-size:11px; text-transform:uppercase; letter-spacing:0.08em; color:var(--text); margin:0 0 6px;">UPI ID</p>
                                    <p style="margin:0; font-size:16px; font-weight:600;"><?php echo htmlspecialchars($site_upi_id); ?></p>
                                </div>
                                <p style="margin:0; font-size:13.5px; color:var(--text);">Open any UPI app (Google Pay, PhonePe, Paytm, BHIM) and pay to the UPI ID above.</p>
                                <a class="console-btn console-btn-primary" href="upi://pay?pa=<?php echo rawurlencode($site_upi_id); ?>&pn=<?php echo rawurlencode('Visa Agency'); ?>&cu=INR">Pay via UPI App</a>
                                <p style="margin:0; font-size:12px; color:var(--text);">On desktop, the button above won't open a UPI app &mdash; just copy the UPI ID into your phone's app instead.</p>
                            </div>
                        </div>
                    </div>
                    <?php endif; ?>
                </div>

                <div class="console-tool-panel" style="margin-top:24px;">
                    <div class="console-tool-panel-bar"><span class="dot"></span><span class="dot"></span><span class="dot"></span><span class="path">payment / after-you-pay</span></div>
                    <div class="console-tool-panel-body">
                        <p style="margin:0 0 14px; font-size:14.5px;">After paying, send us a screenshot or transaction reference along with your Enquiry, Application or Forex Reference Number so we can confirm it against your account.</p>
                        <div class="console-cta-row">
                            <a class="console-btn console-btn-primary" href="<?php echo $site_whatsapp_url; ?>" target="_blank" rel="noopener">Send Payment Proof on WhatsApp</a>
                            <a class="console-btn console-btn-outline-dark" href="mailto:<?php echo htmlspecialchars($site_email); ?>?subject=Payment%20Confirmation">Email Payment Proof</a>
                        </div>
                    </div>
                </div>
                <?php else: ?>
                <div class="console-tool-panel">
                    <div class="console-tool-panel-bar"><span class="dot"></span><span class="dot"></span><span class="dot"></span><span class="path">payment / contact-us</span></div>
                    <div class="console-tool-panel-body">
                        <p style="margin:0 0 14px; font-size:14.5px;">Prefer bank transfer or UPI instead? Contact us directly and our team will share those details along with your invoice.</p>
                        <div class="console-cta-row">
                            <a class="console-btn console-btn-primary" href="tel:<?php echo $site_phone_e164; ?>">Call <?php echo $site_phone_display; ?></a>
                            <a class="console-btn console-btn-outline-dark" href="<?php echo $site_whatsapp_url; ?>" target="_blank" rel="noopener">WhatsApp Us</a>
                            <a class="console-btn console-btn-outline-dark" href="mailto:<?php echo htmlspecialchars($site_email); ?>">Email Us</a>
                        </div>
                    </div>
                </div>
                <?php endif; ?>

                <p style="margin-top:24px; font-size:12.5px; color:var(--text);">
                    <i class="fa-solid fa-shield-alt"></i>
                    We never ask for your card number, CVV, UPI PIN or online banking password over phone, WhatsApp or email. Only use the account/UPI details published on this page or shared directly by our team in an official invoice.
                </p>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
