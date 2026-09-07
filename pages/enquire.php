<?php
declare(strict_types=1);

/**
 * Unified Visa + Apostille enquiry wizard — replaces the old
 * single-step visa_enquiries form. One page, one final POST (all
 * fields live in the same DOM the whole time; step switching is
 * client-side only — see public/assets/js/enquiry-wizard.js — so
 * "go back without losing data" is trivially true and there's nothing
 * to resume server-side). Server-side validation is authoritative:
 * the frontend's required-document hints are convenience only, per
 * the client spec's own "never trust frontend validation alone."
 *
 * Historical /enquire/ submissions before this rebuild live in the
 * old visa_enquiries table (untouched, read-only) — this page now
 * writes to the new unified `enquiries` table instead.
 */

require_once __DIR__ . '/../includes/enquiry.php';
require_once __DIR__ . '/../includes/pdf.php';
require_once __DIR__ . '/../includes/google-sheets.php';

$prefillCountry = trim((string) ($_GET['country'] ?? ''));
$prefillVisaType = trim((string) ($_GET['visa_type'] ?? ''));

$visaTypes = visa_types_all();
$countries = countries_all();

// Step 5: confirmation, shown once via session flash after a
// successful POST (redirect-after-post — a page refresh here re-runs
// this GET, not a second submission).
$justSubmitted = flash_get('enquiry_just_submitted');
if ($justSubmitted !== null) {
    $confirmed = json_decode($justSubmitted, true);
}

$errors = [];
$values = [
    'name' => '', 'mobile_country_code' => '+91', 'mobile_number' => '', 'email' => '',
    'current_city' => '', 'current_state' => '',
    'service_category' => 'visa',
    'destination_country' => $prefillCountry, 'visa_type' => $prefillVisaType,
    'passport_number' => '', 'passport_issued_from' => '', 'journey_date' => '', 'pax_count' => '1',
    'apostille_service_type' => '', 'apostille_document_type' => '', 'apostille_document_count' => '1',
    'apostille_destination_country' => '', 'apostille_purpose' => '',
    'remarks' => '',
];

if (!isset($confirmed) && $_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    if (trim((string) ($_POST['website'] ?? '')) !== '') {
        redirect('/enquire/');
    }

    if (!rate_limit_check('enquire:' . ($_SERVER['REMOTE_ADDR'] ?? ''), 5, 900)) {
        $errors[] = 'Too many submissions. Please try again later, or reach us directly on WhatsApp.';
    }

    foreach (array_keys($values) as $key) {
        if ($key === 'service_category') {
            $values[$key] = in_array($_POST[$key] ?? '', ['visa', 'apostille'], true) ? $_POST[$key] : 'visa';
            continue;
        }
        $values[$key] = trim((string) ($_POST[$key] ?? ''));
    }

    if ($values['name'] === '' || mb_strlen($values['name']) < 2) {
        $errors[] = 'Please enter your full name.';
    }
    $mobileNormalized = normalize_mobile_number($values['mobile_country_code'], $values['mobile_number']);
    if ($mobileNormalized === null) {
        $errors[] = 'Please enter a valid mobile number with country code.';
    }
    if (!is_valid_email($values['email'])) {
        $errors[] = 'Please enter a valid email address.';
    }
    if ($values['current_city'] === '') {
        $errors[] = 'Please enter your current city.';
    }
    if ($values['current_state'] === '') {
        $errors[] = 'Please enter your current state.';
    }

    $country = null;
    $visaType = null;
    $apostilleCountry = null;
    $passportNormalized = null;
    $journeyDate = null;
    $paxCount = 1;

    if ($values['service_category'] === 'visa') {
        $country = $values['destination_country'] !== '' ? country_by_slug($values['destination_country']) : null;
        if ($country === null) {
            $errors[] = 'Please select your destination country.';
        }
        $visaType = $values['visa_type'] !== '' ? visa_type_by_slug($values['visa_type']) : null;
        if ($visaType === null) {
            $errors[] = 'Please select a visa type.';
        }
        $passportNormalized = normalize_passport_number($values['passport_number']);
        if ($passportNormalized === null) {
            $errors[] = 'Please enter a valid passport number.';
        }
        if ($values['passport_issued_from'] === '') {
            $errors[] = 'Please enter where your passport was issued from.';
        }
        if ($values['journey_date'] === '') {
            $errors[] = 'Please enter your date of journey.';
        } else {
            $ts = strtotime($values['journey_date']);
            if ($ts === false) {
                $errors[] = 'Please enter a valid date of journey.';
            } else {
                $journeyDate = date('Y-m-d', $ts);
            }
        }
        $paxCount = max(1, (int) $values['pax_count']);
    } else {
        if (!array_key_exists($values['apostille_service_type'], APOSTILLE_SERVICE_TYPES)) {
            $errors[] = 'Please select the Apostille/legalisation service you need.';
        }
        if (!array_key_exists($values['apostille_document_type'], APOSTILLE_DOCUMENT_TYPES)) {
            $errors[] = 'Please select the document type.';
        }
        $apostilleDocCount = max(1, (int) $values['apostille_document_count']);
        if ($values['apostille_destination_country'] !== '') {
            $apostilleCountry = country_by_slug($values['apostille_destination_country']);
        }
    }

    // Passport document: Option A (first + last separately) OR Option B
    // (one combined file). Only enforced for visa enquiries.
    $uploadedCategories = array_filter(
        array_keys(ENQUIRY_DOCUMENT_CATEGORIES),
        static fn($cat) => isset($_FILES['documents']['name'][$cat]) && $_FILES['documents']['name'][$cat] !== ''
    );
    if ($values['service_category'] === 'visa') {
        $hasSplitPassport = in_array('passport_first', $uploadedCategories, true) && in_array('passport_last', $uploadedCategories, true);
        $hasCombinedPassport = in_array('passport_combined', $uploadedCategories, true);
        if (!$hasSplitPassport && !$hasCombinedPassport) {
            $errors[] = 'Please upload your passport — either the First & Last pages separately, or one combined file.';
        }
    } else {
        if (!in_array('apostille_document', $uploadedCategories, true)) {
            $errors[] = 'Please upload the document(s) you need apostilled/legalised.';
        }
    }
    if (count($uploadedCategories) > 10) {
        $errors[] = 'You can attach a maximum of 10 files.';
    }

    // Backend-driven mandatory-document rules (e.g. Business Visa ->
    // Invitation Letter) — the authoritative check; the frontend's
    // required-mark hints are convenience only, never trusted alone.
    if ($values['service_category'] === 'visa' && $visaType !== null) {
        $mandatoryDocs = enquiry_document_requirements_for('visa', (int) $visaType['id'], $country['id'] ?? null, $values['visa_type']);
        foreach ($mandatoryDocs as $cat => $isMandatory) {
            if ($isMandatory && !in_array($cat, $uploadedCategories, true)) {
                $label = ENQUIRY_DOCUMENT_CATEGORIES[$cat] ?? $cat;
                $errors[] = "$label is mandatory for {$visaType['name']} applicants.";
            }
        }
    }

    // Validate every attached file individually (MIME/size/type), never trusting the client.
    $fileErrors = [];
    foreach ($uploadedCategories as $cat) {
        $file = [
            'name' => $_FILES['documents']['name'][$cat],
            'type' => $_FILES['documents']['type'][$cat],
            'tmp_name' => $_FILES['documents']['tmp_name'][$cat],
            'error' => $_FILES['documents']['error'][$cat],
            'size' => $_FILES['documents']['size'][$cat],
        ];
        $fileError = validate_document_upload($file);
        if ($fileError !== null) {
            $fileErrors[] = (ENQUIRY_DOCUMENT_CATEGORIES[$cat] ?? $cat) . ': ' . $fileError;
        }
    }
    $errors = array_merge($errors, $fileErrors);

    if (($_POST['declaration'] ?? '') !== 'accepted') {
        $errors[] = 'Please confirm the declaration to submit your enquiry.';
    }

    if (!$errors) {
        try {
            db()->beginTransaction();

            $enquiryNumber = null;
            $trackingToken = null;
            for ($attempt = 0; $attempt < 2; $attempt++) {
                $enquiryNumber = generate_reference_number('ENQ', 'enquiries', 'enquiry_number');
                $trackingToken = generate_tracking_token();
                try {
                    $stmt = db()->prepare(
                        'INSERT INTO enquiries
                            (enquiry_number, tracking_token, service_category, name, mobile_country_code, mobile_number, mobile_normalized, email,
                             current_city, current_state, destination_country_id, visa_type_id, passport_number_encrypted, passport_number_hash,
                             passport_issued_from, journey_date, pax_count, apostille_service_type, apostille_document_type, apostille_document_count,
                             apostille_destination_country_id, apostille_purpose, remarks, declaration_accepted_at, ip_address, source_page)
                         VALUES
                            (:enq_num, :track, :category, :name, :cc, :mobile, :mobile_norm, :email,
                             :city, :state, :country_id, :visa_type_id, :passport_enc, :passport_hash,
                             :passport_from, :journey_date, :pax, :apo_service, :apo_doc_type, :apo_doc_count,
                             :apo_country_id, :apo_purpose, :remarks, NOW(), :ip, :source)'
                    );
                    $stmt->execute([
                        'enq_num' => $enquiryNumber,
                        'track' => $trackingToken,
                        'category' => $values['service_category'],
                        'name' => $values['name'],
                        'cc' => $values['mobile_country_code'],
                        'mobile' => $values['mobile_number'],
                        'mobile_norm' => $mobileNormalized,
                        'email' => $values['email'],
                        'city' => $values['current_city'],
                        'state' => $values['current_state'],
                        'country_id' => $country['id'] ?? null,
                        'visa_type_id' => $visaType['id'] ?? null,
                        'passport_enc' => $passportNormalized !== null ? encrypt_value($passportNormalized) : null,
                        'passport_hash' => $passportNormalized !== null ? searchable_hash($passportNormalized) : null,
                        'passport_from' => $values['passport_issued_from'] !== '' ? $values['passport_issued_from'] : null,
                        'journey_date' => $journeyDate,
                        'pax' => $paxCount,
                        'apo_service' => $values['service_category'] === 'apostille' ? $values['apostille_service_type'] : null,
                        'apo_doc_type' => $values['service_category'] === 'apostille' ? $values['apostille_document_type'] : null,
                        'apo_doc_count' => $values['service_category'] === 'apostille' ? ($apostilleDocCount ?? 1) : null,
                        'apo_country_id' => $apostilleCountry['id'] ?? null,
                        'apo_purpose' => $values['apostille_purpose'] !== '' ? $values['apostille_purpose'] : null,
                        'remarks' => $values['remarks'] !== '' ? $values['remarks'] : null,
                        'ip' => $_SERVER['REMOTE_ADDR'] ?? null,
                        'source' => '/enquire/',
                    ]);
                    break;
                } catch (PDOException $e) {
                    if ($e->getCode() === '23000' && $attempt === 0) {
                        continue;
                    }
                    throw $e;
                }
            }

            $enquiryId = (int) db()->lastInsertId();

            foreach ($uploadedCategories as $cat) {
                $file = [
                    'name' => $_FILES['documents']['name'][$cat],
                    'tmp_name' => $_FILES['documents']['tmp_name'][$cat],
                    'size' => $_FILES['documents']['size'][$cat],
                ];
                store_enquiry_document_upload($file, $cat, $enquiryId);
            }

            db()->prepare(
                'INSERT INTO enquiry_status_history (enquiry_id, old_status, new_status, remarks) VALUES (:id, NULL, :status, :remarks)'
            )->execute(['id' => $enquiryId, 'status' => 'new_enquiry', 'remarks' => 'Enquiry submitted by customer.']);

            db()->commit();

            // Best-effort PDF + email, outside the transaction — the
            // enquiry itself is already durably saved either way.
            $enquiryRow = fetch_enquiry_full($enquiryId);
            try {
                $pdfPath = build_enquiry_pdf($enquiryRow, fetch_enquiry_documents($enquiryId));
                db()->prepare('UPDATE enquiries SET pdf_path = :path, pdf_generated_at = NOW() WHERE id = :id')
                    ->execute(['path' => $pdfPath, 'id' => $enquiryId]);
            } catch (Throwable $e) {
                mail_log('[PDF] enquiry ' . $enquiryNumber . ' generation failed: ' . $e->getMessage());
            }

            send_enquiry_confirmation_email($enquiryRow);
            notify_enquiry_channels([
                'reference_number' => $enquiryNumber,
                'name' => $values['name'],
                'email' => $values['email'],
                'phone' => $mobileNormalized,
                'destination' => $country['name'] ?? $apostilleCountry['name'] ?? 'N/A',
                'message' => ($values['service_category'] === 'visa' ? ($visaType['name'] ?? 'Visa') : 'Apostille/' . (APOSTILLE_DOCUMENT_TYPES[$values['apostille_document_type']] ?? '')),
                'submitted_at' => date('c'),
            ]);

            flash_set('enquiry_just_submitted', json_encode([
                'enquiry_number' => $enquiryNumber,
                'tracking_token' => $trackingToken,
            ]));
            redirect('/enquire/');
        } catch (Throwable $e) {
            if (db()->inTransaction()) {
                db()->rollBack();
            }
            if (APP_DEBUG) {
                error_log('[enquire.php] failed to save enquiry: ' . $e->getMessage());
            }
            $errors[] = 'Something went wrong submitting your enquiry. Please try again, or reach us on WhatsApp.';
        }
    }
}

$pageTitle = 'Submit a Visa or Apostille Enquiry - Visagiri';
$pageDescription = 'Tell us your destination, visa type, and travel plans, or your apostille/document legalisation needs — our team will confirm eligibility, documents, and next steps.';
$canonicalUrl = APP_URL . '/enquire/';
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:760px">

        <?php if (isset($confirmed)): ?>
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Visa &amp; Apostille Enquiry</span>
            <h1>Enquiry Submitted Successfully</h1>
        </div>
        <?php render_enquiry_steps(5); ?>
        <div class="card" style="text-align:center;padding:var(--space-8) var(--space-6)">
            <div class="alert alert-success" role="status" style="text-align:left">
                <strong>Thank you for contacting Visagiri.</strong> Your enquiry has been successfully received. A confirmation has been sent to your registered email address.
            </div>
            <p style="font-size:var(--font-size-lg);margin-top:var(--space-5)">
                <strong>Enquiry No.:</strong> <?= e($confirmed['enquiry_number']) ?><br>
                <strong>Tracking No.:</strong> <?= e($confirmed['tracking_token']) ?>
            </p>
            <div class="button-group" style="justify-content:center;margin-top:var(--space-6)">
                <a href="/enquire/pdf/?ref=<?= e(urlencode($confirmed['enquiry_number'])) ?>&amp;token=<?= e(urlencode($confirmed['tracking_token'])) ?>" class="btn btn-gold">Download Enquiry PDF</a>
                <a href="/track/?ref=<?= e(urlencode($confirmed['enquiry_number'])) ?>" class="btn btn-outline">Track Enquiry</a>
                <a href="/" class="btn btn-outline">Back to Visagiri</a>
            </div>
        </div>

        <?php else: ?>

        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Visa &amp; Apostille Enquiry</span>
            <h1>Submit an Enquiry</h1>
            <p>Tell us about your Visa or Apostille/document legalisation needs — our team will confirm eligibility, documents, and next steps.</p>
        </div>

        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>

        <div id="enquiry-wizard" data-enquiry-wizard>
            <?php render_enquiry_steps(1); ?>

            <form method="post" action="/enquire/" enctype="multipart/form-data" novalidate id="enquiry-form">
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
        <?php endif; ?>
    </div>
</section>
<script type="application/json" id="enquiry-document-rules-data"><?= json_encode(enquiry_document_rules_for_js($visaTypes), JSON_UNESCAPED_SLASHES | JSON_HEX_TAG | JSON_HEX_AMP) ?></script>
<script src="<?= e(asset_url('/assets/js/enquiry-wizard.js')) ?>"></script>
<?php require __DIR__ . '/../includes/footer.php'; ?>
