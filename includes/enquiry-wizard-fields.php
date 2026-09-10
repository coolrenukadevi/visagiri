<?php
declare(strict_types=1);

/**
 * The Visa + Apostille enquiry wizard's actual form markup (steps 1-4),
 * extracted out of pages/enquire.php so it can be rendered in two
 * places with zero duplication: the standalone /enquire/ page (full
 * page, normal browser POST — the no-JS/SEO-safe fallback), and the
 * sitewide "Enquire Now" modal (includes/enquiry-modal.php), which
 * lazy-loads this same markup via pages/enquire-wizard-fragment.php
 * and submits it with fetch() instead of a full page navigation.
 *
 * Expects $values, $errors, $countries, $visaTypes already set by the
 * caller. $ajaxMode (optional, default false) marks the form with
 * data-ajax-submit so enquiry-wizard.js's init() knows to intercept
 * the submit and POST via fetch rather than letting the browser
 * navigate — set by the fragment endpoint, left off by the standalone
 * page so it keeps its existing redirect-after-post behavior.
 */

$ajaxMode = $ajaxMode ?? false;
?>
<?php foreach ($errors as $error): ?>
<div class="alert alert-danger"><?= e($error) ?></div>
<?php endforeach; ?>

<div id="enquiry-wizard" data-enquiry-wizard>
    <?php render_enquiry_steps(1); ?>

    <form method="post" action="/enquire/" enctype="multipart/form-data" novalidate id="enquiry-form"<?= $ajaxMode ? ' data-ajax-submit="1"' : '' ?>>
        <?= csrf_field() ?>
        <div class="form-group" style="position:absolute;left:-9999px" aria-hidden="true">
            <label for="website">Leave this field blank</label>
            <input type="text" id="website" name="website" tabindex="-1" autocomplete="off">
        </div>

        <!-- Step 1: Customer Information -->
        <div class="card enquiry-step" data-step="1">
            <h2 class="card-title">Customer Information</h2>
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="name">Customer Name <span class="required-mark">*</span></label>
                    <input class="form-input" type="text" id="name" name="name" value="<?= e($values['name']) ?>" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="mobile_number">Mobile Number <span class="required-mark">*</span></label>
                    <div style="display:flex;gap:var(--space-2)">
                        <select class="form-select" name="mobile_country_code" style="max-width:110px" aria-label="Country code">
                            <?php foreach (['+91' => 'IN +91', '+971' => 'UAE +971', '+1' => 'US/CA +1', '+44' => 'UK +44', '+61' => 'AU +61', '+65' => 'SG +65', '+966' => 'SA +966'] as $code => $label): ?>
                            <option value="<?= e($code) ?>"<?= $values['mobile_country_code'] === $code ? ' selected' : '' ?>><?= e($label) ?></option>
                            <?php endforeach; ?>
                        </select>
                        <input class="form-input" type="tel" id="mobile_number" name="mobile_number" value="<?= e($values['mobile_number']) ?>" placeholder="9876543210" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label" for="email">Email Address <span class="required-mark">*</span></label>
                    <input class="form-input" type="email" id="email" name="email" value="<?= e($values['email']) ?>" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="current_city">Current City <span class="required-mark">*</span></label>
                    <input class="form-input" type="text" id="current_city" name="current_city" value="<?= e($values['current_city']) ?>" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="current_state">Current State <span class="required-mark">*</span></label>
                    <input class="form-input" type="text" id="current_state" name="current_state" value="<?= e($values['current_state']) ?>" required>
                </div>
            </div>
            <div class="button-group" style="justify-content:flex-end;margin-top:var(--space-5)">
                <button type="button" class="btn btn-primary" data-step-next>Next: Enquiry Details &rarr;</button>
            </div>
        </div>

        <!-- Step 2: Service & Details -->
        <div class="card enquiry-step" data-step="2" hidden>
            <h2 class="card-title">Service &amp; Travel Information</h2>

            <div class="form-group">
                <label class="form-label">What do you need help with? <span class="required-mark">*</span></label>
                <div class="service-toggle">
                    <label class="service-toggle__option">
                        <input type="radio" name="service_category" value="visa"<?= $values['service_category'] === 'visa' ? ' checked' : '' ?> data-service-toggle>
                        <span>Visa Services</span>
                    </label>
                    <label class="service-toggle__option">
                        <input type="radio" name="service_category" value="apostille"<?= $values['service_category'] === 'apostille' ? ' checked' : '' ?> data-service-toggle>
                        <span>Apostille / Document Legalisation</span>
                    </label>
                </div>
            </div>

            <div data-service-panel="visa" class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="destination_country">Country of Travel <span class="required-mark">*</span></label>
                    <select class="form-select" id="destination_country" name="destination_country">
                        <option value="">Select country</option>
                        <?php foreach ($countries as $c): ?>
                        <option value="<?= e($c['slug']) ?>"<?= $values['destination_country'] === $c['slug'] ? ' selected' : '' ?>><?= e($c['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="visa_type">Visa Type <span class="required-mark">*</span></label>
                    <select class="form-select" id="visa_type" name="visa_type" data-visa-type-select>
                        <option value="">Select visa type</option>
                        <?php foreach ($visaTypes as $t): ?>
                        <option value="<?= e($t['slug']) ?>"<?= $values['visa_type'] === $t['slug'] ? ' selected' : '' ?>><?= e($t['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="passport_number">Passport Number <span class="required-mark">*</span></label>
                    <input class="form-input" type="text" id="passport_number" name="passport_number" value="<?= e($values['passport_number']) ?>" placeholder="e.g. N1234567">
                </div>
                <div class="form-group">
                    <label class="form-label" for="passport_issued_from">Passport Issued From <span class="required-mark">*</span></label>
                    <input class="form-input" type="text" id="passport_issued_from" name="passport_issued_from" value="<?= e($values['passport_issued_from']) ?>" placeholder="e.g. India">
                </div>
                <div class="form-group">
                    <label class="form-label" for="journey_date">Date of Journey <span class="required-mark">*</span></label>
                    <input class="form-input" type="date" id="journey_date" name="journey_date" value="<?= e($values['journey_date']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="pax_count">Number of Pax <span class="required-mark">*</span></label>
                    <input class="form-input" type="number" id="pax_count" name="pax_count" min="1" max="20" value="<?= e($values['pax_count']) ?>">
                </div>
            </div>

            <div data-service-panel="apostille" class="admin-form-grid" hidden>
                <div class="form-group">
                    <label class="form-label" for="apostille_service_type">Apostille Service <span class="required-mark">*</span></label>
                    <select class="form-select" id="apostille_service_type" name="apostille_service_type">
                        <option value="">Select service</option>
                        <?php foreach (APOSTILLE_SERVICE_TYPES as $key => $label): ?>
                        <option value="<?= e($key) ?>"<?= $values['apostille_service_type'] === $key ? ' selected' : '' ?>><?= e($label) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="apostille_document_type">Document Type <span class="required-mark">*</span></label>
                    <select class="form-select" id="apostille_document_type" name="apostille_document_type">
                        <option value="">Select document type</option>
                        <?php foreach (APOSTILLE_DOCUMENT_TYPES as $key => $label): ?>
                        <option value="<?= e($key) ?>"<?= $values['apostille_document_type'] === $key ? ' selected' : '' ?>><?= e($label) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="apostille_document_count">Number of Documents <span class="required-mark">*</span></label>
                    <input class="form-input" type="number" id="apostille_document_count" name="apostille_document_count" min="1" max="20" value="<?= e($values['apostille_document_count']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="apostille_destination_country">Destination Country</label>
                    <select class="form-select" id="apostille_destination_country" name="apostille_destination_country">
                        <option value="">Select country (if applicable)</option>
                        <?php foreach ($countries as $c): ?>
                        <option value="<?= e($c['slug']) ?>"<?= $values['apostille_destination_country'] === $c['slug'] ? ' selected' : '' ?>><?= e($c['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group" style="grid-column:1/-1">
                    <label class="form-label" for="apostille_purpose">Purpose</label>
                    <input class="form-input" type="text" id="apostille_purpose" name="apostille_purpose" value="<?= e($values['apostille_purpose']) ?>" placeholder="e.g. Employment abroad, higher education">
                </div>
            </div>

            <div class="form-group" style="margin-top:var(--space-4)">
                <label class="form-label" for="remarks">Additional Requirements / Remarks</label>
                <textarea class="form-input" id="remarks" name="remarks" rows="4" maxlength="2000"><?= e($values['remarks']) ?></textarea>
            </div>

            <div class="button-group" style="justify-content:space-between;margin-top:var(--space-5)">
                <button type="button" class="btn btn-outline" data-step-back>&larr; Back</button>
                <button type="button" class="btn btn-primary" data-step-next>Next: Documents &rarr;</button>
            </div>
        </div>

        <!-- Step 3: Document Upload -->
        <div class="card enquiry-step" data-step="3" hidden>
            <h2 class="card-title">Document Upload</h2>
            <p style="color:var(--text-muted)">Maximum 10 files, up to 10 MB each. Accepted formats: PDF, JPG, PNG, DOC, DOCX.</p>

            <div data-service-panel="visa">
                <div class="form-group">
                    <label class="form-label">Passport Document <span class="required-mark">*</span></label>
                    <p style="font-size:var(--font-size-sm);color:var(--text-muted);margin-top:-4px">Upload either the First &amp; Last pages separately, or one combined file.</p>
                    <div class="document-upload-grid">
                        <?php foreach (['passport_first' => 'Passport First Page', 'passport_last' => 'Passport Last Page', 'passport_combined' => 'Combined First + Last Page'] as $cat => $label): ?>
                        <div class="document-upload-item">
                            <label class="form-label" for="doc_<?= e($cat) ?>"><?= e($label) ?></label>
                            <input type="file" id="doc_<?= e($cat) ?>" name="documents[<?= e($cat) ?>]" accept=".pdf,.jpg,.jpeg,.png,.doc,.docx" data-doc-input="<?= e($cat) ?>">
                        </div>
                        <?php endforeach; ?>
                    </div>
                </div>
                <div class="document-upload-grid">
                    <?php
                    $visaOtherDocs = [
                        'invitation_letter' => 'Invitation Letter',
                        'cover_letter' => 'Cover Letter',
                        'hotel_reservation' => 'Hotel Reservation',
                        'flight_reservation' => 'Flight Reservation',
                        'travel_insurance' => 'Travel Insurance',
                        'photograph' => 'Photograph',
                        'previous_visa' => 'Previous Visa',
                        'financial_documents' => 'Supporting Financial Documents',
                        'employment_documents' => 'Employment Documents',
                        'other' => 'Other Supporting Documents',
                    ];
                    foreach ($visaOtherDocs as $cat => $label): ?>
                    <div class="document-upload-item">
                        <label class="form-label" for="doc_<?= e($cat) ?>" data-doc-label="<?= e($cat) ?>"><?= e($label) ?></label>
                        <input type="file" id="doc_<?= e($cat) ?>" name="documents[<?= e($cat) ?>]" accept=".pdf,.jpg,.jpeg,.png,.doc,.docx" data-doc-input="<?= e($cat) ?>">
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>

            <div data-service-panel="apostille" hidden>
                <div class="form-group">
                    <label class="form-label" for="doc_apostille_document">Document(s) for Apostille/Legalisation <span class="required-mark">*</span></label>
                    <input type="file" id="doc_apostille_document" name="documents[apostille_document]" accept=".pdf,.jpg,.jpeg,.png,.doc,.docx">
                </div>
                <div class="document-upload-grid">
                    <div class="document-upload-item">
                        <label class="form-label" for="doc_other_apostille">Other Supporting Documents</label>
                        <input type="file" id="doc_other_apostille" name="documents[other]" accept=".pdf,.jpg,.jpeg,.png,.doc,.docx">
                    </div>
                </div>
            </div>

            <div class="button-group" style="justify-content:space-between;margin-top:var(--space-5)">
                <button type="button" class="btn btn-outline" data-step-back>&larr; Back</button>
                <button type="button" class="btn btn-primary" data-step-next>Next: Review &rarr;</button>
            </div>
        </div>

        <!-- Step 4: Review & Declaration -->
        <div class="card enquiry-step" data-step="4" hidden>
            <h2 class="card-title">Review &amp; Declaration</h2>
            <div id="enquiry-review-summary" class="enquiry-review-summary"></div>

            <div class="alert alert-info" style="margin-top:var(--space-5)"><?= e(enquiry_disclaimer_text()) ?></div>

            <div class="form-group" style="margin-top:var(--space-4)">
                <label style="display:flex;align-items:flex-start;gap:var(--space-2);font-weight:var(--font-weight-regular)">
                    <input type="checkbox" name="declaration" value="accepted" required>
                    <span>I confirm that the information and documents provided by me are accurate to the best of my knowledge.</span>
                </label>
            </div>

            <div class="button-group" style="justify-content:space-between;margin-top:var(--space-5)">
                <button type="button" class="btn btn-outline" data-step-back>&larr; Back / Edit Details</button>
                <button type="submit" class="btn btn-gold" id="enquiry-submit-btn">Submit Enquiry</button>
            </div>
        </div>
    </form>
</div>
<script type="application/json" class="enquiry-document-rules-data"><?= json_encode(enquiry_document_rules_for_js($visaTypes), JSON_UNESCAPED_SLASHES | JSON_HEX_TAG | JSON_HEX_AMP) ?></script>
