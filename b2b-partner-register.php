<?php
$page_title = "Become a B2B Partner &ndash; Visa Agency";
$page_description = "Register as a B2B visa partner with VisaAgency.in &ndash; travel agencies, tour operators, visa consultants and corporate travel desks.";
require_once __DIR__ . '/includes/b2b-db.php';
require_once __DIR__ . '/includes/countries-data.php';
include __DIR__ . '/includes/header.php';
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Become a B2B Partner</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="b2b-partners">B2B Partners</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Register</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="section-padding fix b2b-reg-section">
            <div class="container">
                <div class="b2b-reg-card">
                    <div class="b2b-reg-progress" id="b2bRegProgress">
                        <div class="b2b-reg-progress-label">Step <span id="b2bStepNum">1</span> of 4 &middot; <span id="b2bStepName">Business Information</span></div>
                        <div class="b2b-reg-progress-track"><div class="b2b-reg-progress-fill" id="b2bProgressFill" style="width:25%;"></div></div>
                        <div class="b2b-reg-progress-steps">
                            <span class="is-active" data-step-dot="1">1. Business</span>
                            <span data-step-dot="2">2. Contact</span>
                            <span data-step-dot="3">3. Profile</span>
                            <span data-step-dot="4">4. Declaration</span>
                        </div>
                    </div>

                    <form id="b2bRegForm" novalidate>
                        <div class="b2b-reg-honeypot" aria-hidden="true">
                            <label for="b2bWebsite">Leave this field empty</label>
                            <input type="text" id="b2bWebsiteHp" name="website_hp" tabindex="-1" autocomplete="off">
                        </div>

                        <!-- Step 1: Business Information -->
                        <div class="b2b-reg-step" data-step="1">
                            <h2>Business Information</h2>
                            <p class="b2b-reg-sub">Tell us about your agency or company.</p>
                            <div class="b2b-reg-grid">
                                <div class="b2b-field b2b-field-full">
                                    <label for="companyName">Agency / Company Name *</label>
                                    <input type="text" id="companyName" name="company_name" required maxlength="150">
                                    <span class="b2b-error" data-error-for="company_name"></span>
                                </div>
                                <div class="b2b-field">
                                    <label for="businessType">Business Type *</label>
                                    <select id="businessType" name="business_type" required>
                                        <option value="">Select business type</option>
                                        <?php foreach (B2B_BUSINESS_TYPES as $type): ?>
                                        <option value="<?php echo htmlspecialchars($type); ?>"><?php echo htmlspecialchars($type); ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                                <div class="b2b-field">
                                    <label for="yearEstablished">Year Established</label>
                                    <input type="number" id="yearEstablished" name="year_established" min="1900" max="2026" placeholder="e.g. 2015">
                                </div>
                                <div class="b2b-field">
                                    <label for="website">Website</label>
                                    <input type="url" id="website" name="website" placeholder="https://">
                                </div>
                                <div class="b2b-field">
                                    <label for="gstNumber">GST Number</label>
                                    <input type="text" id="gstNumber" name="gst_number" maxlength="15">
                                </div>
                                <div class="b2b-field">
                                    <label for="panNumber">PAN Number</label>
                                    <input type="text" id="panNumber" name="pan_number" maxlength="10">
                                </div>
                                <div class="b2b-field b2b-field-full">
                                    <label class="b2b-radio-label">IATA Registered?</label>
                                    <div class="b2b-radio-row">
                                        <label class="b2b-radio-pill"><input type="radio" name="iata_registered" value="1"> Yes</label>
                                        <label class="b2b-radio-pill"><input type="radio" name="iata_registered" value="0" checked> No</label>
                                    </div>
                                </div>
                                <div class="b2b-field" id="iataNumberField" hidden>
                                    <label for="iataNumber">IATA Number</label>
                                    <input type="text" id="iataNumber" name="iata_number">
                                </div>
                                <div class="b2b-field">
                                    <label for="tafiNumber">TAFI Number</label>
                                    <input type="text" id="tafiNumber" name="tafi_number">
                                </div>
                                <div class="b2b-field b2b-field-full">
                                    <label for="otherAssociation">Other Travel Association Membership</label>
                                    <input type="text" id="otherAssociation" name="other_association">
                                </div>
                                <div class="b2b-field b2b-field-full">
                                    <label for="address">Office Address *</label>
                                    <input type="text" id="address" name="address" required>
                                </div>
                                <div class="b2b-field">
                                    <label for="city">City *</label>
                                    <input type="text" id="city" name="city" required>
                                </div>
                                <div class="b2b-field">
                                    <label for="state">State *</label>
                                    <input type="text" id="state" name="state" required>
                                </div>
                                <div class="b2b-field">
                                    <label for="country">Country *</label>
                                    <select id="country" name="country" required>
                                        <option value="">Select country</option>
                                        <option value="India" selected>India</option>
                                        <?php foreach ($VISA_AGENCY_COUNTRIES as $c): if ($c['name'] === 'India') continue; ?>
                                        <option value="<?php echo htmlspecialchars($c['name']); ?>"><?php echo htmlspecialchars($c['name']); ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                                <div class="b2b-field">
                                    <label for="pinCode">PIN Code *</label>
                                    <input type="text" id="pinCode" name="pin_code" required maxlength="10">
                                </div>
                            </div>
                            <span class="b2b-error" id="b2bStep1Error" role="alert"></span>
                            <button type="button" class="b2b-continue-btn" data-b2b-next>Continue <i class="fa-solid fa-arrow-right" aria-hidden="true"></i></button>
                        </div>

                        <!-- Step 2: Primary Contact Details -->
                        <div class="b2b-reg-step" data-step="2" hidden>
                            <button type="button" class="b2b-back-btn" data-b2b-back><i class="fa-solid fa-arrow-left" aria-hidden="true"></i> Back</button>
                            <h2>Primary Contact Details</h2>
                            <p class="b2b-reg-sub">This person will be your primary account owner and can add team members later.</p>
                            <div class="b2b-reg-grid">
                                <div class="b2b-field">
                                    <label for="contactName">Contact Person Name *</label>
                                    <input type="text" id="contactName" name="contact_name" required>
                                </div>
                                <div class="b2b-field">
                                    <label for="contactDesignation">Designation</label>
                                    <input type="text" id="contactDesignation" name="contact_designation">
                                </div>
                                <div class="b2b-field b2b-field-full">
                                    <label for="contactEmail">Official Email *</label>
                                    <input type="email" id="contactEmail" name="contact_email" required>
                                    <span class="b2b-error" data-error-for="contact_email"></span>
                                </div>
                                <div class="b2b-field">
                                    <label for="contactMobile">Mobile Number *</label>
                                    <div class="b2b-phone-input"><span class="b2b-phone-prefix">+91</span><input type="tel" id="contactMobile" name="contact_mobile" required inputmode="numeric" maxlength="10"></div>
                                </div>
                                <div class="b2b-field">
                                    <label for="contactWhatsapp">WhatsApp Number</label>
                                    <div class="b2b-phone-input"><span class="b2b-phone-prefix">+91</span><input type="tel" id="contactWhatsapp" name="contact_whatsapp" inputmode="numeric" maxlength="10" placeholder="Same as mobile if blank"></div>
                                </div>
                                <div class="b2b-field">
                                    <label for="contactAltMobile">Alternate Mobile</label>
                                    <div class="b2b-phone-input"><span class="b2b-phone-prefix">+91</span><input type="tel" id="contactAltMobile" name="contact_alternate_mobile" inputmode="numeric" maxlength="10"></div>
                                </div>
                                <div class="b2b-field">
                                    <label for="regUsername">Username *</label>
                                    <input type="text" id="regUsername" name="username" required autocomplete="username">
                                    <span class="b2b-error" data-error-for="username"></span>
                                </div>
                                <div class="b2b-field">
                                    <label for="regPassword">Password *</label>
                                    <input type="password" id="regPassword" name="password" required minlength="8" autocomplete="new-password">
                                </div>
                                <div class="b2b-field">
                                    <label for="regPasswordConfirm">Confirm Password *</label>
                                    <input type="password" id="regPasswordConfirm" name="password_confirm" required minlength="8" autocomplete="new-password">
                                    <span class="b2b-error" data-error-for="password_confirm"></span>
                                </div>
                            </div>

                            <div class="b2b-otp-box" id="b2bOtpBox">
                                <div class="b2b-otp-head">
                                    <i class="fa-solid fa-envelope-circle-check" aria-hidden="true"></i>
                                    <div>
                                        <strong>Verify your email</strong>
                                        <p>We'll send a 6-digit code to your official email. Your application can't be submitted until it's verified.</p>
                                    </div>
                                </div>
                                <div class="b2b-otp-row" id="b2bOtpSendRow">
                                    <button type="button" class="b2b-otp-btn" id="b2bSendOtpBtn">Send Verification Code</button>
                                </div>
                                <div class="b2b-otp-row" id="b2bOtpEnterRow" hidden>
                                    <input type="text" id="b2bOtpCode" inputmode="numeric" maxlength="6" placeholder="6-digit code">
                                    <button type="button" class="b2b-otp-btn" id="b2bVerifyOtpBtn">Verify</button>
                                    <button type="button" class="b2b-otp-resend" id="b2bResendOtpBtn">Resend</button>
                                </div>
                                <div class="b2b-otp-status" id="b2bOtpStatus"></div>
                            </div>

                            <span class="b2b-error" id="b2bStep2Error" role="alert"></span>
                            <button type="button" class="b2b-continue-btn" data-b2b-next>Continue <i class="fa-solid fa-arrow-right" aria-hidden="true"></i></button>
                        </div>

                        <!-- Step 3: Business Profile -->
                        <div class="b2b-reg-step" data-step="3" hidden>
                            <button type="button" class="b2b-back-btn" data-b2b-back><i class="fa-solid fa-arrow-left" aria-hidden="true"></i> Back</button>
                            <h2>Business Profile</h2>
                            <p class="b2b-reg-sub">This helps us route your account to the right team.</p>

                            <label class="b2b-group-label">Services Currently Offered</label>
                            <div class="b2b-chip-grid">
                                <?php foreach (B2B_SERVICES_OFFERED as $svc): ?>
                                <label class="b2b-chip"><input type="checkbox" name="services_offered[]" value="<?php echo htmlspecialchars($svc); ?>"><span><?php echo htmlspecialchars($svc); ?></span></label>
                                <?php endforeach; ?>
                            </div>

                            <label class="b2b-group-label">Visa Specialization</label>
                            <div class="b2b-chip-grid">
                                <?php foreach (B2B_VISA_SPECIALIZATION as $v): ?>
                                <label class="b2b-chip"><input type="checkbox" name="visa_specialization[]" value="<?php echo htmlspecialchars($v); ?>"><span><?php echo htmlspecialchars($v); ?></span></label>
                                <?php endforeach; ?>
                            </div>

                            <label class="b2b-group-label" for="monthlyVolume">Approximate Monthly Visa Volume</label>
                            <select id="monthlyVolume" name="monthly_visa_volume" class="b2b-select-wide">
                                <option value="">Select a range</option>
                                <?php foreach (B2B_MONTHLY_VOLUME_BANDS as $band): ?>
                                <option value="<?php echo htmlspecialchars($band); ?>"><?php echo htmlspecialchars($band); ?></option>
                                <?php endforeach; ?>
                            </select>

                            <span class="b2b-error" id="b2bStep3Error" role="alert"></span>
                            <button type="button" class="b2b-continue-btn" data-b2b-next>Continue <i class="fa-solid fa-arrow-right" aria-hidden="true"></i></button>
                        </div>

                        <!-- Step 4: Terms & Declaration -->
                        <div class="b2b-reg-step" data-step="4" hidden>
                            <button type="button" class="b2b-back-btn" data-b2b-back><i class="fa-solid fa-arrow-left" aria-hidden="true"></i> Back</button>
                            <h2>Partner Terms &amp; Declaration</h2>
                            <p class="b2b-reg-sub">Please review before submitting. Document upload (PAN, GST, IATA certificate, etc.) opens right after submission.</p>

                            <div class="b2b-terms-list">
                                <label class="b2b-terms-item"><input type="checkbox" name="agree_terms" required> I agree to the <a href="terms-and-conditions" target="_blank" rel="noopener">Terms &amp; Conditions</a></label>
                                <label class="b2b-terms-item"><input type="checkbox" name="agree_privacy" required> I agree to the <a href="privacy-policy" target="_blank" rel="noopener">Privacy Policy</a></label>
                                <label class="b2b-terms-item"><input type="checkbox" name="agree_partner_agreement" required> I agree to the B2B Partner Agreement</label>
                                <label class="b2b-terms-item"><input type="checkbox" name="agree_commission" required> I agree to the Commission Terms</label>
                                <label class="b2b-terms-item"><input type="checkbox" name="agree_doc_policy" required> I agree to the Document Handling Policy</label>
                                <label class="b2b-terms-item"><input type="checkbox" name="agree_data_protection" required> I consent to the Data Protection Policy</label>
                            </div>

                            <div class="b2b-declaration-box">
                                <label class="b2b-terms-item"><input type="checkbox" name="declaration_confirmed" required> <strong>I confirm that the information and documents provided are genuine and accurate.</strong></label>
                            </div>

                            <div class="b2b-form-error" id="b2bFormError" role="alert" hidden></div>
                            <button type="submit" class="b2b-submit-btn" id="b2bSubmitBtn">
                                <span class="b2b-btn-label">Submit Partner Application</span>
                                <span class="b2b-btn-spinner" hidden></span>
                            </button>
                        </div>
                    </form>

                    <!-- Success -->
                    <div class="b2b-reg-success" id="b2bRegSuccess" hidden>
                        <div class="b2b-success-icon"><i class="fa-solid fa-circle-check" aria-hidden="true"></i></div>
                        <h2>Application Submitted!</h2>
                        <p>Thank you for applying to become a VisaAgency.in B2B Partner.</p>
                        <div class="b2b-ref-box">
                            <span>Application Number</span>
                            <strong id="b2bSuccessRef"></strong>
                        </div>
                        <div class="b2b-success-grid">
                            <div><label>Registration Date</label><span id="b2bSuccessDate"></span></div>
                            <div><label>Current Status</label><span id="b2bSuccessStatus"></span></div>
                        </div>
                        <p class="b2b-success-note">Our B2B team will review your application and reach out. You can check your status anytime from the confirmation email we've just sent you.</p>
                        <div class="b2b-success-actions">
                            <a href="b2b-partners" class="b2b-btn-secondary">Back to B2B Partners</a>
                            <a href="/" class="b2b-btn-ghost">Back to Website</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<script src="assets/js/b2b-partner-register.js"></script>
<?php include __DIR__ . '/includes/footer.php'; ?>
