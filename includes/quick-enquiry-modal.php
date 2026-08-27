<?php
require_once __DIR__ . '/countries-data.php';
require_once __DIR__ . '/quick-enquiry-config.php';
?>
<div class="qe-modal" id="qeModal" role="dialog" aria-modal="true" aria-labelledby="qeModalTitle" hidden>
    <div class="qe-modal-backdrop" data-qe-close></div>
    <div class="qe-modal-dialog">
        <button type="button" class="qe-modal-close" data-qe-close aria-label="Close enquiry dialogue">
            <i class="fa-solid fa-xmark" aria-hidden="true"></i>
        </button>

        <div class="qe-progress" id="qeProgress">
            <span class="qe-progress-label">Step <span id="qeStepNum">1</span> of 3 &middot; <span id="qeStepName">Service</span></span>
            <div class="qe-progress-track"><div class="qe-progress-fill" id="qeProgressFill" style="width:33.33%;"></div></div>
        </div>

        <form id="qeForm" novalidate>
            <div class="qe-honeypot" aria-hidden="true">
                <label for="qeWebsite">Leave this field empty</label>
                <input type="text" id="qeWebsite" name="website" tabindex="-1" autocomplete="off">
            </div>
            <input type="hidden" name="service" id="qeService">
            <input type="hidden" name="purpose" id="qePurpose">
            <input type="hidden" name="submission_token" id="qeSubmissionToken">
            <input type="hidden" name="source_url" id="qeSourceUrl">
            <input type="hidden" name="referrer" id="qeReferrer">
            <input type="hidden" name="utm_source" id="qeUtmSource">
            <input type="hidden" name="utm_medium" id="qeUtmMedium">
            <input type="hidden" name="utm_campaign" id="qeUtmCampaign">
            <input type="hidden" name="utm_term" id="qeUtmTerm">
            <input type="hidden" name="utm_content" id="qeUtmContent">
            <input type="hidden" name="device" id="qeDevice">

            <!-- Step 1: service selection -->
            <div class="qe-step" data-step="1">
                <h2 id="qeModalTitle">How can we help you?</h2>
                <p class="qe-sub">Select a service and our team will assist you.</p>
                <div class="qe-service-grid">
                    <?php foreach (QUICK_ENQUIRY_SERVICES as $svc): ?>
                    <button type="button" class="qe-service-card" data-service="<?php echo htmlspecialchars($svc['key']); ?>">
                        <span class="qe-service-icon" aria-hidden="true"><?php echo $svc['icon']; ?></span>
                        <span class="qe-service-label"><?php echo htmlspecialchars($svc['label']); ?></span>
                        <span class="qe-service-subtitle"><?php echo htmlspecialchars($svc['subtitle']); ?></span>
                    </button>
                    <?php endforeach; ?>
                </div>
            </div>

            <!-- Step 2: dynamic purpose/requirement panel per service -->
            <div class="qe-step" data-step="2" hidden>
                <button type="button" class="qe-back" data-qe-back><i class="fa-solid fa-arrow-left" aria-hidden="true"></i> Back</button>
                <?php foreach (QUICK_ENQUIRY_SERVICES as $svc): ?>
                <div class="qe-step2-panel" data-step2-for="<?php echo htmlspecialchars($svc['key']); ?>" hidden>
                    <?php if (!empty($svc['is_freeform'])): ?>
                        <h2>Tell us what you need help with</h2>
                        <p class="qe-sub">A short description helps our team respond faster.</p>
                        <textarea name="qe_message" class="qe-textarea" rows="4" placeholder="Describe your enquiry&hellip;" aria-label="Describe your enquiry"></textarea>
                    <?php else: ?>
                        <h2><?php echo htmlspecialchars($svc['step2_question']); ?></h2>
                        <div class="qe-option-grid" role="group" aria-label="<?php echo htmlspecialchars($svc['step2_question']); ?>">
                            <?php foreach ($svc['step2_options'] as $opt): ?>
                            <button type="button" class="qe-option-btn" data-purpose="<?php echo htmlspecialchars($opt); ?>"><?php echo htmlspecialchars($opt); ?></button>
                            <?php endforeach; ?>
                        </div>
                        <?php if (!empty($svc['extra_fields'])): ?>
                        <div class="qe-extra-fields">
                            <?php foreach ($svc['extra_fields'] as $f): ?>
                            <div class="qe-field">
                                <label for="qe_<?php echo $svc['key']; ?>_<?php echo $f['key']; ?>"><?php echo htmlspecialchars($f['label']); ?><?php echo !empty($f['required']) ? ' *' : ' (optional)'; ?></label>
                                <?php if ($f['type'] === 'country'): ?>
                                <select id="qe_<?php echo $svc['key']; ?>_<?php echo $f['key']; ?>" class="qe-dynamic-field" data-field="<?php echo $f['key']; ?>" <?php echo !empty($f['required']) ? 'required' : ''; ?>>
                                    <option value="">Select country</option>
                                    <?php foreach ($VISA_AGENCY_COUNTRIES as $c): ?><option value="<?php echo htmlspecialchars($c['name']); ?>"><?php echo htmlspecialchars($c['name']); ?></option><?php endforeach; ?>
                                </select>
                                <?php elseif ($f['type'] === 'date'): ?>
                                <input type="date" id="qe_<?php echo $svc['key']; ?>_<?php echo $f['key']; ?>" class="qe-dynamic-field" data-field="<?php echo $f['key']; ?>" <?php echo !empty($f['required']) ? 'required' : ''; ?>>
                                <?php else: ?>
                                <input type="text" id="qe_<?php echo $svc['key']; ?>_<?php echo $f['key']; ?>" class="qe-dynamic-field" data-field="<?php echo $f['key']; ?>" placeholder="<?php echo htmlspecialchars($f['placeholder'] ?? ''); ?>" <?php echo !empty($f['required']) ? 'required' : ''; ?>>
                                <?php endif; ?>
                            </div>
                            <?php endforeach; ?>
                        </div>
                        <?php endif; ?>
                    <?php endif; ?>
                </div>
                <?php endforeach; ?>
                <span class="qe-error" id="qeStep2Error" role="alert"></span>
                <button type="button" class="qe-continue-btn" id="qeContinueBtn">Continue <i class="fa-solid fa-arrow-right" aria-hidden="true"></i></button>
            </div>

            <!-- Step 3: contact details -->
            <div class="qe-step" data-step="3" hidden>
                <button type="button" class="qe-back" data-qe-back><i class="fa-solid fa-arrow-left" aria-hidden="true"></i> Back</button>
                <h2>Almost done</h2>
                <p class="qe-sub">Just a few details so our team can reach you.</p>
                <div class="qe-contact-fields">
                    <div class="qe-field">
                        <label for="qeFullName">Full Name *</label>
                        <input type="text" id="qeFullName" name="full_name" required maxlength="150">
                        <span class="qe-error" data-error-for="full_name"></span>
                    </div>
                    <div class="qe-field">
                        <label for="qeMobile">Mobile Number *</label>
                        <div class="qe-phone-input"><span class="qe-phone-prefix">+91</span><input type="tel" id="qeMobile" name="mobile" required inputmode="numeric" maxlength="10" placeholder="10-digit mobile number"></div>
                        <span class="qe-error" data-error-for="mobile"></span>
                    </div>
                    <div class="qe-field">
                        <label for="qeWhatsApp">WhatsApp Number</label>
                        <div class="qe-phone-input"><span class="qe-phone-prefix">+91</span><input type="tel" id="qeWhatsApp" name="whatsapp_number" inputmode="numeric" maxlength="10" placeholder="Same as mobile if left blank"></div>
                    </div>
                    <div class="qe-field">
                        <label for="qeEmail">Email Address *</label>
                        <input type="email" id="qeEmail" name="email" required>
                        <span class="qe-error" data-error-for="email"></span>
                    </div>
                </div>
                <div class="qe-form-error" id="qeFormError" role="alert" hidden></div>
                <button type="submit" class="qe-submit-btn" id="qeSubmitBtn">
                    <span class="qe-btn-label">Submit Enquiry</span>
                    <span class="qe-btn-spinner" hidden></span>
                </button>
            </div>
        </form>

        <!-- Success -->
        <div class="qe-success" id="qeSuccess" hidden>
            <div class="qe-success-icon"><i class="fa-solid fa-circle-check" aria-hidden="true"></i></div>
            <h2>Thank You!</h2>
            <p>Your enquiry has been received successfully.</p>
            <div class="qe-ref-box">
                <span>Reference Number</span>
                <strong id="qeSuccessRef"></strong>
            </div>
            <p class="qe-success-note">Our team will review your request and contact you shortly.</p>
            <div class="qe-success-actions">
                <a href="track-application" target="_blank" rel="noopener" class="qe-btn-primary" id="qeTrackBtn">Track Enquiry</a>
                <a href="#" target="_blank" rel="noopener" class="qe-btn-secondary" id="qeWhatsAppBtn"><i class="fa-brands fa-whatsapp" aria-hidden="true"></i> WhatsApp Us</a>
                <button type="button" class="qe-btn-ghost" data-qe-close>Back to Website</button>
            </div>
        </div>
    </div>
</div>
<script>
var QE_SERVICES = <?php
    $qeJsConfig = [];
    foreach (QUICK_ENQUIRY_SERVICES as $k => $svc) {
        $qeJsConfig[$k] = ['is_freeform' => !empty($svc['is_freeform'])];
    }
    echo json_encode($qeJsConfig, JSON_UNESCAPED_SLASHES);
?>;
</script>
