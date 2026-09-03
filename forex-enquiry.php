<?php
$page_title = "Forex Enquiry &ndash; Visa Agency";
$page_description = "Start a foreign currency, forex card or travel forex enquiry with VisaAgency.in &ndash; get a quotation before you commit.";
require_once __DIR__ . '/includes/forex-db.php';
require_once __DIR__ . '/includes/countries-data.php';
$pdo = forex_db();
$currencies = forex_currencies($pdo);
include __DIR__ . '/includes/header.php';
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Forex Enquiry</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="forex">Forex Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Enquiry</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="section-padding fix b2b-reg-section">
            <div class="container">
                <div class="b2b-reg-card">
                    <div class="b2b-reg-progress" id="fxRegProgress">
                        <div class="b2b-reg-progress-label">Step <span id="fxStepNum">1</span> of 2 &middot; <span id="fxStepName">Your Details</span></div>
                        <div class="b2b-reg-progress-track"><div class="b2b-reg-progress-fill" id="fxProgressFill" style="width:50%;"></div></div>
                        <div class="b2b-reg-progress-steps">
                            <span class="is-active" data-step-dot="1">1. Your Details</span>
                            <span data-step-dot="2">2. Forex Requirement</span>
                        </div>
                    </div>

                    <form id="fxEnquiryForm" novalidate>
                        <div class="b2b-reg-honeypot" aria-hidden="true">
                            <label for="fxWebsiteHp">Leave this field empty</label>
                            <input type="text" id="fxWebsiteHp" name="website_hp" tabindex="-1" autocomplete="off">
                        </div>

                        <!-- Step 1: Customer Information -->
                        <div class="b2b-reg-step" data-step="1">
                            <h2>Your Details</h2>
                            <p class="b2b-reg-sub">Tell us who we're speaking with.</p>
                            <div class="b2b-reg-grid">
                                <div class="b2b-field b2b-field-full">
                                    <label for="fxFullName">Full Name *</label>
                                    <input type="text" id="fxFullName" name="full_name" required maxlength="150">
                                    <span class="b2b-error" data-error-for="full_name"></span>
                                </div>
                                <div class="b2b-field">
                                    <label for="fxMobile">Mobile Number *</label>
                                    <div class="b2b-phone-input"><span class="b2b-phone-prefix">+91</span><input type="tel" id="fxMobile" name="mobile" required inputmode="numeric" maxlength="10"></div>
                                    <span class="b2b-error" data-error-for="mobile"></span>
                                </div>
                                <div class="b2b-field">
                                    <label for="fxEmail">Email *</label>
                                    <input type="email" id="fxEmail" name="email" required>
                                    <span class="b2b-error" data-error-for="email"></span>
                                </div>
                                <div class="b2b-field">
                                    <label for="fxNationality">Nationality</label>
                                    <input type="text" id="fxNationality" name="nationality" value="Indian">
                                </div>
                                <div class="b2b-field">
                                    <label for="fxCity">Current City *</label>
                                    <input type="text" id="fxCity" name="city" required>
                                </div>
                                <div class="b2b-field">
                                    <label for="fxState">State</label>
                                    <input type="text" id="fxState" name="state">
                                </div>
                                <div class="b2b-field">
                                    <label for="fxDob">Date of Birth</label>
                                    <input type="date" id="fxDob" name="date_of_birth">
                                </div>
                            </div>
                            <span class="b2b-error" id="fxStep1Error" role="alert"></span>
                            <button type="button" class="b2b-continue-btn" data-fx-next>Continue <i class="fa-solid fa-arrow-right" aria-hidden="true"></i></button>
                        </div>

                        <!-- Step 2: Forex Requirement -->
                        <div class="b2b-reg-step" data-step="2" hidden>
                            <button type="button" class="b2b-back-btn" data-fx-back><i class="fa-solid fa-arrow-left" aria-hidden="true"></i> Back</button>
                            <h2>Forex Requirement</h2>
                            <p class="b2b-reg-sub">We'll confirm a quotation before anything is charged.</p>
                            <div class="b2b-reg-grid">
                                <div class="b2b-field">
                                    <label for="fxServiceType">Forex Service *</label>
                                    <select id="fxServiceType" name="service_type" required>
                                        <option value="">Select a service</option>
                                        <?php foreach (FOREX_SERVICE_TYPES as $svc): ?>
                                        <option value="<?php echo htmlspecialchars($svc); ?>"><?php echo htmlspecialchars($svc); ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                                <div class="b2b-field">
                                    <label for="fxPurpose">Purpose *</label>
                                    <select id="fxPurpose" name="purpose" required>
                                        <option value="">Select purpose</option>
                                        <?php foreach (FOREX_TRAVEL_PURPOSES as $p): ?>
                                        <option value="<?php echo htmlspecialchars($p); ?>"><?php echo htmlspecialchars($p); ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                                <div class="b2b-field">
                                    <label for="fxCurrency">Currency Required *</label>
                                    <select id="fxCurrency" name="currency_code" required>
                                        <option value="">Select currency</option>
                                        <?php foreach ($currencies as $cur): ?>
                                        <option value="<?php echo htmlspecialchars($cur); ?>"><?php echo htmlspecialchars($cur); ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                                <div class="b2b-field">
                                    <label for="fxAmount">Amount Required *</label>
                                    <input type="number" id="fxAmount" name="amount_required" required min="1" step="0.01" placeholder="e.g. 2000">
                                </div>
                                <div class="b2b-field b2b-field-full">
                                    <label for="fxCountry">Destination / Country *</label>
                                    <select id="fxCountry" name="country_visit" required>
                                        <option value="">Select destination</option>
                                        <?php foreach ($VISA_AGENCY_COUNTRIES as $c): ?>
                                        <option value="<?php echo htmlspecialchars($c['name']); ?>"><?php echo htmlspecialchars($c['name']); ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                                <div class="b2b-field">
                                    <label for="fxDeparture">Travel Date</label>
                                    <input type="date" id="fxDeparture" name="departure_date">
                                </div>
                                <div class="b2b-field">
                                    <label for="fxReturn">Return Date</label>
                                    <input type="date" id="fxReturn" name="return_date">
                                </div>
                                <div class="b2b-field b2b-field-full">
                                    <label for="fxDelivery">Preferred Collection / Delivery Option</label>
                                    <select id="fxDelivery" name="delivery_method">
                                        <option value="">Select an option</option>
                                        <?php foreach (FOREX_DELIVERY_METHODS as $dm): ?>
                                        <option value="<?php echo htmlspecialchars($dm); ?>"><?php echo htmlspecialchars($dm); ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                                <div class="b2b-field b2b-field-full">
                                    <label for="fxSpecial">Special Requirement</label>
                                    <textarea id="fxSpecial" name="special_requirement" rows="3" placeholder="Anything else we should know?"></textarea>
                                </div>
                            </div>

                            <div class="b2b-form-error" id="fxFormError" role="alert" hidden></div>
                            <button type="submit" class="b2b-submit-btn" id="fxSubmitBtn">
                                <span class="b2b-btn-label">Submit Forex Enquiry</span>
                                <span class="b2b-btn-spinner" hidden></span>
                            </button>
                        </div>
                    </form>

                    <!-- Success -->
                    <div class="b2b-reg-success" id="fxRegSuccess" hidden>
                        <div class="b2b-success-icon"><i class="fa-solid fa-circle-check" aria-hidden="true"></i></div>
                        <h2>Enquiry Submitted!</h2>
                        <p>Thank you &mdash; our forex team will confirm a quotation shortly.</p>
                        <div class="b2b-ref-box">
                            <span>Forex Reference</span>
                            <strong id="fxSuccessRef"></strong>
                        </div>
                        <div class="b2b-success-grid">
                            <div><label>Submitted</label><span id="fxSuccessDate"></span></div>
                            <div><label>Current Status</label><span id="fxSuccessStatus"></span></div>
                        </div>
                        <p class="b2b-success-note">Next: upload your supporting documents (passport, PAN, etc.) so our team can begin processing. We've also emailed you this link.</p>
                        <div class="b2b-success-actions">
                            <a href="#" id="fxUploadDocsLink" class="qe-btn-primary">Upload Documents Now <i class="fa-solid fa-arrow-right" aria-hidden="true"></i></a>
                        </div>
                        <div class="b2b-success-actions" style="margin-top:10px;">
                            <a href="forex-track" class="b2b-btn-secondary">Track This Request</a>
                            <a href="/" class="b2b-btn-ghost">Back to Website</a>
                        </div>
                        <p class="fx-login-hint">Submitted a Forex request before? <a href="forex-login">Log in with your mobile number</a> to see all your requests in one place.</p>
                    </div>
                </div>
            </div>
        </section>

<script src="assets/js/forex-enquiry.js"></script>
<?php include __DIR__ . '/includes/footer.php'; ?>
