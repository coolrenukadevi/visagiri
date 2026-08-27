<?php
$page_title = "Forgot Password &ndash; B2B Partner Portal &ndash; Visa Agency";
$page_description = "Reset the password for your VisaAgency.in B2B Partner Portal account.";
require_once __DIR__ . '/includes/partner-auth.php';
if (!empty($_SESSION['partner_user'])) {
    header('Location: b2b-dashboard.php');
    exit;
}
include __DIR__ . '/includes/header.php';
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Reset Your Password</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="b2b-login">Partner Login</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Forgot Password</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="section-padding fix b2b-reg-section">
            <div class="container">
                <div class="b2b-reg-card b2b-auth-card">
                    <h2 class="b2b-auth-title">Forgot Password</h2>

                    <form id="b2bForgotForm" novalidate>
                        <!-- Step A: request a code -->
                        <div class="b2b-auth-step" data-fp-step="1">
                            <p class="b2b-reg-sub">Enter the email address registered with your partner account. If it matches an account, we'll email you a 6-digit reset code.</p>
                            <div class="b2b-field b2b-field-full">
                                <label for="fpEmail">Registered Email *</label>
                                <input type="email" id="fpEmail" name="email" required autocomplete="email">
                                <span class="b2b-error" data-error-for="email"></span>
                            </div>
                            <div class="b2b-form-error" id="fpStep1Error" role="alert" hidden></div>
                            <button type="button" class="b2b-submit-btn" id="fpSendBtn">
                                <span class="b2b-btn-label">Send Reset Code</span>
                                <span class="b2b-btn-spinner" hidden></span>
                            </button>
                        </div>

                        <!-- Step B: enter code + new password -->
                        <div class="b2b-auth-step" data-fp-step="2" hidden>
                            <p class="b2b-reg-sub">Enter the 6-digit code we emailed you and choose a new password.</p>
                            <div class="b2b-field b2b-field-full">
                                <label for="fpCode">6-Digit Code *</label>
                                <input type="text" id="fpCode" name="code" inputmode="numeric" maxlength="6" required>
                                <span class="b2b-error" data-error-for="code"></span>
                            </div>
                            <div class="b2b-field b2b-field-full">
                                <label for="fpPassword">New Password *</label>
                                <input type="password" id="fpPassword" name="new_password" required minlength="8" autocomplete="new-password">
                                <span class="b2b-error" data-error-for="new_password"></span>
                            </div>
                            <div class="b2b-field b2b-field-full">
                                <label for="fpPasswordConfirm">Confirm New Password *</label>
                                <input type="password" id="fpPasswordConfirm" name="new_password_confirm" required minlength="8" autocomplete="new-password">
                                <span class="b2b-error" data-error-for="new_password_confirm"></span>
                            </div>
                            <div class="b2b-auth-links">
                                <button type="button" class="b2b-otp-resend" id="fpResendBtn">Resend code</button>
                            </div>
                            <div class="b2b-form-error" id="fpStep2Error" role="alert" hidden></div>
                            <button type="submit" class="b2b-submit-btn" id="fpResetBtn">
                                <span class="b2b-btn-label">Reset Password</span>
                                <span class="b2b-btn-spinner" hidden></span>
                            </button>
                        </div>

                        <!-- Step C: success -->
                        <div class="b2b-auth-step b2b-auth-success" data-fp-step="3" hidden>
                            <i class="fa-solid fa-circle-check" aria-hidden="true"></i>
                            <h2>Password Reset</h2>
                            <p>Your password has been changed. You can now log in with your new password.</p>
                            <a href="b2b-login" class="b2b-submit-btn" style="text-decoration:none;">Go to Partner Login</a>
                        </div>
                    </form>

                    <p class="b2b-auth-footer">Remembered your password? <a href="b2b-login">Back to Partner Login</a>.</p>
                </div>
            </div>
        </section>

<script src="assets/js/b2b-forgot-password.js"></script>
<?php include __DIR__ . '/includes/footer.php'; ?>
