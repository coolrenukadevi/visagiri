<?php
$page_noindex = true;
$page_title = "B2B Partner Login &ndash; Visa Agency";
$page_description = "Log in to your VisaAgency.in B2B Partner Portal to manage visa applications, quotations, invoices and documents.";
require_once __DIR__ . '/includes/partner-auth.php';
require_once __DIR__ . '/includes/b2b-csrf.php';
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
                    <h1 class="breadcrumb-title">B2B Partner Login</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="b2b-partners">B2B Partners</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Partner Login</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="section-padding fix b2b-reg-section">
            <div class="container">
                <div class="b2b-reg-card b2b-auth-card">
                    <h2 class="b2b-auth-title">Partner Login</h2>
                    <p class="b2b-reg-sub">Log in with the username/email and password you registered with.</p>

                    <div class="b2b-form-error" id="b2bLoginAlert" role="alert" hidden></div>

                    <form id="b2bLoginForm" novalidate>
                        <input type="hidden" name="b2b_csrf" value="<?php echo htmlspecialchars(b2b_csrf_token()); ?>">
                        <div class="b2b-field b2b-field-full">
                            <label for="loginIdentifier">Username or Email *</label>
                            <input type="text" id="loginIdentifier" name="identifier" required autocomplete="username">
                            <span class="b2b-error" data-error-for="identifier"></span>
                        </div>
                        <div class="b2b-field b2b-field-full">
                            <label for="loginPassword">Password *</label>
                            <input type="password" id="loginPassword" name="password" required autocomplete="current-password">
                            <span class="b2b-error" data-error-for="password"></span>
                        </div>
                        <div class="b2b-auth-links">
                            <a href="b2b-forgot-password">Forgot password?</a>
                        </div>
                        <button type="submit" class="b2b-submit-btn" id="b2bLoginSubmit">
                            <span class="b2b-btn-label">Log In</span>
                            <span class="b2b-btn-spinner" hidden></span>
                        </button>
                    </form>

                    <p class="b2b-auth-footer">Not a partner yet? <a href="b2b-partner-register">Apply to become a B2B Partner</a>.</p>
                </div>
            </div>
        </section>

<script src="assets/js/b2b-login.js"></script>
<?php include __DIR__ . '/includes/footer.php'; ?>
