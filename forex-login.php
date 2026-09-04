<?php
require_once __DIR__ . '/includes/forex-customer-auth.php';
require_once __DIR__ . '/includes/forex-csrf.php';

if (forex_customer_logged_in()) {
    header('Location: forex-my-requests');
    exit;
}

$page_noindex = true;
$page_title = "Forex Customer Login &ndash; Visa Agency";
$page_description = "Log in with your registered mobile number to view all your Forex requests, quotations and documents in one place.";
include __DIR__ . '/includes/header.php';
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Forex Customer Login</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Forex Login</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="track-form-wrap">
                    <div class="track-form-card" id="fxLoginCard">
                        <h2>My Forex Requests</h2>
                        <p class="track-sub">Log in with your registered mobile number &mdash; we'll email a one-time code to verify it's you.</p>

                        <div class="b2b-error" id="fxLoginError" role="alert"></div>

                        <form id="fxLoginMobileForm" class="track-form" novalidate>
                            <?php echo forex_csrf_field(); ?>
                            <div class="track-field">
                                <label for="fxLoginMobile">Registered Mobile Number *</label>
                                <input type="tel" id="fxLoginMobile" name="mobile" placeholder="10-digit mobile number" required autocomplete="tel">
                            </div>
                            <button type="submit" class="theme-btn track-submit-btn" id="fxLoginSendBtn">
                                <span class="b2b-btn-label">Send Login Code</span>
                                <span class="b2b-btn-spinner" hidden></span>
                            </button>
                        </form>

                        <form id="fxLoginOtpForm" class="track-form" novalidate hidden>
                            <?php echo forex_csrf_field(); ?>
                            <input type="hidden" id="fxLoginOtpMobile" name="mobile">
                            <p class="track-sub" id="fxLoginOtpSub">Enter the 6-digit code we emailed you.</p>
                            <div class="track-field">
                                <label for="fxLoginOtp">Verification Code *</label>
                                <input type="text" id="fxLoginOtp" name="code" inputmode="numeric" pattern="[0-9]*" maxlength="6" placeholder="000000" required autocomplete="one-time-code">
                            </div>
                            <button type="submit" class="theme-btn track-submit-btn" id="fxLoginVerifyBtn">
                                <span class="b2b-btn-label">Verify &amp; Log In</span>
                                <span class="b2b-btn-spinner" hidden></span>
                            </button>
                            <div class="fx-login-otp-actions">
                                <button type="button" class="fx-login-link-btn" id="fxLoginResendBtn">Resend Code</button>
                                <button type="button" class="fx-login-link-btn" id="fxLoginBackBtn">Change Mobile Number</button>
                            </div>
                        </form>

                        <p class="fx-login-hint">Just submitted an enquiry? Use the link emailed to you, or <a href="forex-enquiry">start a new Forex enquiry</a>.</p>
                    </div>
                </div>
            </div>
        </section>

<script>var FX_CSRF = <?php echo json_encode(forex_csrf_token()); ?>;</script>
<script src="assets/js/forex-login.js"></script>
<?php include __DIR__ . '/includes/footer.php'; ?>
