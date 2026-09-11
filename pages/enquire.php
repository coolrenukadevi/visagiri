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
$checklistReference = trim((string) ($_GET['checklist_ref'] ?? ''));

$visaTypes = visa_types_all();
$countries = countries_all();

// Step 5: confirmation, shown once via session flash after a
// successful POST (redirect-after-post — a page refresh here re-runs
// this GET, not a second submission).
$justSubmitted = flash_get('enquiry_just_submitted');
if ($justSubmitted !== null) {
    $confirmed = json_decode($justSubmitted, true);
}

// Set by enquiry-wizard.js when this form is submitted from inside the
// sitewide "Enquire Now" modal (fetch + FormData) instead of the
// standalone page's normal browser POST — see includes/enquiry-modal.php.
$isAjax = ($_SERVER['HTTP_X_REQUESTED_WITH'] ?? '') === 'fetch';

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

    // Present only when this enquiry was opened from a
    // /visa/{country}/{type}/ page's "Enquire Now & Unlock Full
    // Checklist" button (see includes/enquiry-wizard-fields.php) —
    // never trusted blindly: the checklist actually unlocked below is
    // looked up fresh by this reference, joined against the country
    // and visa type the enquiry itself resolves to, not just taken
    // from POST data as-is.
    $unlockChecklistRequested = ($_POST['unlock_checklist'] ?? '') === '1';
    $checklistReference = trim((string) ($_POST['checklist_reference'] ?? ''));

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
                             apostille_destination_country_id, apostille_purpose, remarks, declaration_accepted_at, ip_address, source_page, sla_due_at)
                         VALUES
                            (:enq_num, :track, :category, :name, :cc, :mobile, :mobile_norm, :email,
                             :city, :state, :country_id, :visa_type_id, :passport_enc, :passport_hash,
                             :passport_from, :journey_date, :pax, :apo_service, :apo_doc_type, :apo_doc_count,
                             :apo_country_id, :apo_purpose, :remarks, NOW(), :ip, :source, DATE_ADD(NOW(), INTERVAL :sla_hours HOUR))'
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
                        // Lets admin/CRM reporting see which visa checklist page an
                        // enquiry originated from — the exact traceability the
                        // Checklist Engine spec asks for, without adding new
                        // enquiries columns for a value that's really just "where
                        // did this come from".
                        'source' => ($unlockChecklistRequested && $checklistReference !== '')
                            ? "/visa-checklist/{$checklistReference}/"
                            : '/enquire/',
                        'sla_hours' => enquiry_sla_hours_for_priority('normal'),
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
            notify_admins_by_permission(
                'enquiries.view',
                'new_enquiry',
                'New ' . ($values['service_category'] === 'visa' ? 'Visa' : 'Apostille') . ' Enquiry — ' . $values['name'],
                'Reference: ' . $enquiryNumber,
                '/admin/enquiries/?id=' . $enquiryId
            );
            notify_enquiry_channels([
                'reference_number' => $enquiryNumber,
                'name' => $values['name'],
                'email' => $values['email'],
                'phone' => $mobileNormalized,
                'destination' => $country['name'] ?? $apostilleCountry['name'] ?? 'N/A',
                'message' => ($values['service_category'] === 'visa' ? ($visaType['name'] ?? 'Visa') : 'Apostille/' . (APOSTILLE_DOCUMENT_TYPES[$values['apostille_document_type']] ?? '')),
                'submitted_at' => date('c'),
            ]);

            // Checklist unlock — only when the enquiry actually resolved
            // to a real country+visa-type (visa enquiries only) AND a
            // published checklist genuinely exists for that exact pair.
            // A stale/tampered checklist_reference that doesn't match
            // the enquiry's own country+type simply doesn't unlock
            // anything; it's never trusted to pick the checklist itself.
            $checklistUnlocked = false;
            $checklistUrl = null;
            if ($unlockChecklistRequested && $checklistReference !== '' && $country !== null && $visaType !== null) {
                $checklist = fetch_visa_checklist((int) $country['id'], (int) $visaType['id']);
                if ($checklist !== null && $checklist['reference'] === $checklistReference) {
                    $accessToken = generate_checklist_access_token((int) $checklist['id'], (int) $country['id'], (int) $visaType['id'], $enquiryId);
                    $cookieName = checklist_access_cookie_name((int) $country['id'], (int) $visaType['id']);
                    $checklistUrl = "/visa/{$country['slug']}/{$visaType['slug']}/";
                    setcookie($cookieName, $accessToken, [
                        'expires' => time() + (CHECKLIST_ACCESS_TTL_DAYS * 86400),
                        'path' => $checklistUrl,
                        'secure' => SESSION_SECURE_COOKIE,
                        'httponly' => true,
                        'samesite' => 'Lax',
                    ]);
                    $checklistUnlocked = true;
                }
            }

            if ($isAjax) {
                header('Content-Type: application/json');
                echo json_encode([
                    'success' => true,
                    'reference' => $enquiryNumber,
                    'tracking_token' => $trackingToken,
                    'pdf_url' => '/enquire/pdf/?ref=' . urlencode($enquiryNumber) . '&token=' . urlencode($trackingToken),
                    'track_url' => '/track/?ref=' . urlencode($enquiryNumber),
                    'checklist_unlocked' => $checklistUnlocked,
                    'checklist_url' => $checklistUrl,
                ]);
                exit;
            }

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

    if ($isAjax) {
        header('Content-Type: application/json');
        echo json_encode(['success' => false, 'errors' => $errors]);
        exit;
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

        <?php require __DIR__ . '/../includes/enquiry-wizard-fields.php'; ?>
        <?php endif; ?>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
