<?php
/**
 * /enquiry/{code} — a single enquiry's detail + status timeline.
 *
 * Owner-only: an enquiry belongs to exactly one customer, and this checks
 * that the signed-in customer_id matches rather than trusting the code alone
 * — the code is unique but not secret (it's shown in the URL and probably
 * emailed/printed), so it must never double as an access token.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/customer_auth.php';
require_once __DIR__ . '/lib-php/enquiries.php';
require_once __DIR__ . '/lib-php/visa_enquiries.php';
require_once __DIR__ . '/lib-php/forex_enquiries.php';
require_once __DIR__ . '/lib-php/documents.php';
require_once __DIR__ . '/lib-php/compliance.php';

header('Cache-Control: no-store, private');
auth_session_start();

$code = trim((string) ($_GET['code'] ?? ''));
$customer = customer_current();
if (!$customer) {
    header('Location: ' . url('/customer-login') . '?next=' . rawurlencode(auth_safe_next('/enquiry/' . $code)), true, 302);
    exit;
}

$enquiry = $code !== '' ? enquiry_find_by_code($code) : null;
if (!$enquiry || (int) $enquiry['customer_id'] !== (int) $customer['id']) {
    http_response_code(404);
    require __DIR__ . '/404.php';
    exit;
}
$isVisa = $enquiry['service_code'] === 'visa';
$isForex = $enquiry['service_code'] === 'forex';

$notesSaved = false;
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'save_notes') {
    if (auth_csrf_valid($_POST['csrf'] ?? null)) {
        $notes = trim((string) ($_POST['customer_notes'] ?? ''));
        if (strlen($notes) <= 2000) {
            enquiry_set_customer_notes((int) $enquiry['id'], $notes);
            $enquiry['customer_notes'] = $notes;
            $notesSaved = true;
        }
    }
}

$visaErrors = [];
$visaSaved = false;
$countries = json_decode((string) file_get_contents(ROOT_PATH . '/data/all-countries.json'), true) ?: [];
$visaTypeOptions = $isVisa ? visa_types_for_country($enquiry['country']) : [];

if ($isVisa && $_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'save_visa_details') {
    if (!auth_csrf_valid($_POST['csrf'] ?? null)) {
        $visaErrors['form'] = 'Your session expired — please try again.';
    } else {
        $vp = [];
        foreach (['applicant_name' => 'Applicant name', 'passport_number' => 'Passport number',
                  'country_of_residence' => 'Country of residence'] as $k => $label) {
            $v = trim((string) ($_POST[$k] ?? ''));
            if ($v === '') $visaErrors[$k] = "$label is required.";
            $vp[$k] = $v;
        }
        $vp['destination_city'] = trim((string) ($_POST['destination_city'] ?? ''));
        $vp['visa_type'] = trim((string) ($_POST['visa_type'] ?? ''));
        if (!in_array($vp['visa_type'], $visaTypeOptions, true)) $visaErrors['visa_type'] = 'Choose a visa type from the list.';
        if ($vp['country_of_residence'] !== '' && !in_array($vp['country_of_residence'], $countries, true)) {
            $visaErrors['country_of_residence'] = 'Choose a country from the list.';
        }
        $vp['expected_return_date'] = trim((string) ($_POST['expected_return_date'] ?? ''));
        $vp['traveller_count'] = max(1, (int) ($_POST['traveller_count'] ?? 1));
        $vp['applicant_type'] = in_array($_POST['applicant_type'] ?? '', ['Single', 'Multiple'], true) ? $_POST['applicant_type'] : 'Single';
        $vp['previous_refusal'] = ($_POST['previous_refusal'] ?? '') === 'yes';
        $vp['current_visa_status'] = trim((string) ($_POST['current_visa_status'] ?? ''));
        $vp['previous_visa_history'] = trim((string) ($_POST['previous_visa_history'] ?? ''));

        if (!$visaErrors) {
            visa_enquiry_save((int) $enquiry['id'], $vp);
            $visaSaved = true;
        }
    }
}
$visaDetails = $isVisa ? (visa_enquiry_for((int) $enquiry['id']) ?? []) : [];
// Sticky values: what was just submitted (if it had errors) beats what's saved.
$vv = static fn($k, $d = '') => e((string) ($_POST[$k] ?? $visaDetails[$k] ?? $d));

$forexErrors = [];
$forexSaved = false;
if ($isForex && $_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'save_forex_details') {
    if (!auth_csrf_valid($_POST['csrf'] ?? null)) {
        $forexErrors['form'] = 'Your session expired — please try again.';
    } else {
        $fp = [];
        foreach (['pan_number' => 'PAN number', 'passport_number' => 'Passport number', 'nationality' => 'Nationality',
                  'residential_address' => 'Residential address', 'city_of_visit' => 'City of visit',
                  'departure_city' => 'Departure city'] as $k => $label) {
            $v = trim((string) ($_POST[$k] ?? ''));
            if ($v === '') $forexErrors[$k] = "$label is required.";
            $fp[$k] = $v;
        }
        if ($fp['pan_number'] !== '' && !preg_match('/^[A-Z]{5}[0-9]{4}[A-Z]$/', strtoupper($fp['pan_number']))) {
            $forexErrors['pan_number'] = 'Enter a valid 10-character PAN (e.g. ABCDE1234F).';
        }
        $fp['travel_start_date'] = trim((string) ($_POST['travel_start_date'] ?? ''));
        $fp['travel_end_date'] = trim((string) ($_POST['travel_end_date'] ?? ''));
        $fp['traveller_count'] = max(1, (int) ($_POST['traveller_count'] ?? 1));
        $fp['forex_type'] = trim((string) ($_POST['forex_type'] ?? ''));
        if (!in_array($fp['forex_type'], FOREX_TYPES, true)) $forexErrors['forex_type'] = 'Choose a forex type.';
        $fp['currency_code'] = trim((string) ($_POST['currency_code'] ?? ''));
        if (!isset(FOREX_CURRENCIES[$fp['currency_code']])) $forexErrors['currency_code'] = 'Choose a currency.';
        $fp['amount_required'] = max(0, (float) ($_POST['amount_required'] ?? 0));
        $fp['approx_inr_value'] = max(0, (float) ($_POST['approx_inr_value'] ?? 0));
        $fp['delivery_method'] = in_array($_POST['delivery_method'] ?? '', FOREX_DELIVERY_METHODS, true) ? $_POST['delivery_method'] : 'Branch Pickup';

        if (!$forexErrors) {
            forex_enquiry_save((int) $enquiry['id'], $fp);
            $forexSaved = true;
        }
    }
}
$forexDetails = $isForex ? (forex_enquiry_for((int) $enquiry['id']) ?? []) : [];
$fv = static fn($k, $d = '') => e((string) ($_POST[$k] ?? $forexDetails[$k] ?? $d));

$documents = documents_for_enquiry((int) $enquiry['id']);
$documentTypes = document_types_all();
$docNonPassportCount = count(array_filter($documents, static fn($d) => !$d['is_passport']));
$docTotalBytes = array_sum(array_column($documents, 'size_bytes'));
$docHasPassport = (bool) array_filter($documents, static fn($d) => $d['is_passport']);

$forexChecklist = $isForex ? forex_checklist_status($documents) : [];
$forexTransaction = $isForex ? forex_transaction_ensure((int) $enquiry['id']) : null;
$forexReadyForDelivery = $isForex ? forex_ready_for_delivery($forexChecklist, $documents) : false;

$history = enquiry_status_history_for((int) $enquiry['id']);

// Customer-facing labels only — see includes/enquire-now.php's note on why
// there's no internal-notes/assignment UI yet. Everything shown here is a
// real column on a real row; nothing is invented for display.
$statusLabels = [
    'New' => 'Received',
    'In Progress' => 'In Progress',
    'Completed' => 'Completed',
    'Cancelled' => 'Cancelled',
];
$statusLabel = $statusLabels[$enquiry['status']] ?? $enquiry['status'];

$crumb = [
    ['label' => 'Home', 'href' => url('/')],
    ['label' => 'My account', 'href' => url('/account')],
    ['label' => $enquiry['enquiry_code']],
];
$page = [
    'title'       => $enquiry['enquiry_code'] . ' | Convercession',
    'short_title' => $enquiry['enquiry_code'],
    'description' => 'Track your Convercession enquiry.',
    'path'        => '/enquiry/' . $enquiry['enquiry_code'],
    'noindex'     => true,
    'jsonld'      => [breadcrumb_schema($crumb)],
];
?><!DOCTYPE html>
<html lang="en">
<head><?php include __DIR__ . '/includes/head.php'; ?></head>
<body>
<?php include __DIR__ . '/includes/header.php'; ?>

<main>
  <section class="section auth-section">
    <div class="container"><?= breadcrumbs($crumb) ?></div>
    <div class="container">
      <div class="auth-card auth-card-wide">
        <div class="enq-detail-head">
          <div>
            <span class="mono enq-detail-code"><?= e($enquiry['enquiry_code']) ?></span>
            <h1><?= e($enquiry['service_label']) ?> — <?= e($enquiry['country']) ?></h1>
          </div>
          <span class="enq-status-badge status-<?= e(strtolower(str_replace(' ', '-', $enquiry['status']))) ?>"><?= e($statusLabel) ?></span>
        </div>

        <div class="enq-detail-grid">
          <div><span class="enq-detail-label">Travel Purpose</span><span><?= e($enquiry['travel_purpose']) ?></span></div>
          <div><span class="enq-detail-label">Preferred Travel Date</span><span><?= $enquiry['travel_date'] ? e(date('j F Y', strtotime($enquiry['travel_date']))) : 'Not specified' ?></span></div>
          <div><span class="enq-detail-label">Submitted</span><span><?= e(date('j F Y, g:i a', (int) $enquiry['created_at'])) ?></span></div>
          <div><span class="enq-detail-label">Assigned Consultant</span><span><?= $enquiry['assigned_employee'] ? e($enquiry['assigned_employee']) : 'Not yet assigned' ?></span></div>
        </div>

        <?php if ($enquiry['message']): ?>
        <div class="enq-detail-message"><span class="enq-detail-label">Your message</span><p><?= nl2br(e($enquiry['message'])) ?></p></div>
        <?php endif; ?>

        <?php if ($isVisa): ?>
        <h2 class="account-section-title" style="margin-top:32px">Visa Details</h2>
        <p class="auth-note" style="margin-top:-10px">
          <?= $visaDetails ? 'Update these any time before your consultant reviews the enquiry.' : 'A few more details help your consultant get started — this only takes a minute.' ?>
        </p>
        <?php if ($visaSaved): ?><p class="notice-inline">Visa details saved.</p><?php endif; ?>
        <?php if (isset($visaErrors['form'])): ?><p class="auth-error" role="alert"><?= e($visaErrors['form']) ?></p><?php endif; ?>
        <form method="post" action="<?= url('/enquiry/' . $enquiry['enquiry_code']) ?>">
          <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
          <input type="hidden" name="action" value="save_visa_details">
          <div class="enquiry-grid">
            <div class="enquiry-field"><label for="applicant_name">Applicant Name *</label><input type="text" id="applicant_name" name="applicant_name" value="<?= $vv('applicant_name') ?>" required>
              <?php if (isset($visaErrors['applicant_name'])): ?><span class="field-error"><?= e($visaErrors['applicant_name']) ?></span><?php endif; ?>
            </div>
            <div class="enquiry-field"><label for="passport_number">Passport Number *</label><input type="text" id="passport_number" name="passport_number" value="<?= $vv('passport_number') ?>" required>
              <?php if (isset($visaErrors['passport_number'])): ?><span class="field-error"><?= e($visaErrors['passport_number']) ?></span><?php endif; ?>
            </div>
            <div class="enquiry-field"><label for="country_of_residence">Country of Residence *</label>
              <select id="country_of_residence" name="country_of_residence" required>
                <option value="">Select&hellip;</option>
                <?php foreach ($countries as $c): ?><option value="<?= e($c) ?>" <?= ($visaDetails['country_of_residence'] ?? '') === $c ? 'selected' : '' ?>><?= e($c) ?></option><?php endforeach; ?>
              </select>
              <?php if (isset($visaErrors['country_of_residence'])): ?><span class="field-error"><?= e($visaErrors['country_of_residence']) ?></span><?php endif; ?>
            </div>
            <div class="enquiry-field"><label for="destination_city">Destination City</label><input type="text" id="destination_city" name="destination_city" value="<?= $vv('destination_city') ?>"></div>
            <div class="enquiry-field"><label for="visa_type">Visa Type *</label>
              <select id="visa_type" name="visa_type" required>
                <option value="">Select&hellip;</option>
                <?php foreach ($visaTypeOptions as $vt): ?><option value="<?= e($vt) ?>" <?= ($visaDetails['visa_type'] ?? '') === $vt ? 'selected' : '' ?>><?= e($vt) ?></option><?php endforeach; ?>
              </select>
              <span class="auth-note" style="margin:4px 0 0">Only visa types <?= e($enquiry['country']) ?> actually offers — see <a href="<?= url('/visa/' . cv_slug($enquiry['country'])) ?>" target="_blank">the full guide</a>.</span>
              <?php if (isset($visaErrors['visa_type'])): ?><span class="field-error"><?= e($visaErrors['visa_type']) ?></span><?php endif; ?>
            </div>
            <div class="enquiry-field"><label for="expected_return_date">Expected Return Date</label><input type="date" id="expected_return_date" name="expected_return_date" value="<?= $vv('expected_return_date') ?>"></div>
            <div class="enquiry-field"><label for="traveller_count">Number of Travellers *</label><input type="number" id="traveller_count" name="traveller_count" min="1" value="<?= $vv('traveller_count', '1') ?>" required></div>
            <div class="enquiry-field"><label for="applicant_type">Single / Multiple Applicant *</label>
              <select id="applicant_type" name="applicant_type">
                <option value="Single" <?= ($visaDetails['applicant_type'] ?? 'Single') === 'Single' ? 'selected' : '' ?>>Single Applicant</option>
                <option value="Multiple" <?= ($visaDetails['applicant_type'] ?? '') === 'Multiple' ? 'selected' : '' ?>>Multiple Applicants</option>
              </select>
            </div>
            <div class="enquiry-field"><label for="previous_refusal">Previous Visa Refusal? *</label>
              <select id="previous_refusal" name="previous_refusal">
                <option value="no" <?= empty($visaDetails['previous_refusal']) ? 'selected' : '' ?>>No</option>
                <option value="yes" <?= !empty($visaDetails['previous_refusal']) ? 'selected' : '' ?>>Yes</option>
              </select>
            </div>
            <div class="enquiry-field"><label for="current_visa_status">Current Visa Status</label><input type="text" id="current_visa_status" name="current_visa_status" value="<?= $vv('current_visa_status') ?>" placeholder="e.g. None, or a currently valid visa"></div>
            <div class="enquiry-field full"><label for="previous_visa_history">Previous Visa History</label><textarea id="previous_visa_history" name="previous_visa_history" rows="2" placeholder="Countries and visa types you've held before, if any"><?= $vv('previous_visa_history') ?></textarea></div>
          </div>
          <div class="wizard-actions"><span></span><button type="submit" class="btn btn-primary btn-sm"><?= $visaDetails ? 'Update Visa Details' : 'Save Visa Details' ?></button></div>
        </form>
        <?php endif; ?>

        <?php if ($isForex): ?>
        <h2 class="account-section-title" style="margin-top:32px">Forex Details</h2>
        <p class="auth-note" style="margin-top:-10px">
          <?= $forexDetails ? 'Update these any time before your consultant reviews the enquiry.' : 'A few more details help your consultant prepare a quotation.' ?>
        </p>
        <?php if ($forexSaved): ?><p class="notice-inline">Forex details saved.</p><?php endif; ?>
        <?php if (isset($forexErrors['form'])): ?><p class="auth-error" role="alert"><?= e($forexErrors['form']) ?></p><?php endif; ?>
        <form method="post" action="<?= url('/enquiry/' . $enquiry['enquiry_code']) ?>">
          <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
          <input type="hidden" name="action" value="save_forex_details">
          <div class="enquiry-grid">
            <div class="enquiry-field"><label for="pan_number">PAN Number *</label><input type="text" id="pan_number" name="pan_number" value="<?= $fv('pan_number') ?>" placeholder="ABCDE1234F" maxlength="10" required>
              <?php if (isset($forexErrors['pan_number'])): ?><span class="field-error"><?= e($forexErrors['pan_number']) ?></span><?php endif; ?>
            </div>
            <div class="enquiry-field"><label for="forex_passport_number">Passport Number *</label><input type="text" id="forex_passport_number" name="passport_number" value="<?= $fv('passport_number') ?>" required>
              <?php if (isset($forexErrors['passport_number'])): ?><span class="field-error"><?= e($forexErrors['passport_number']) ?></span><?php endif; ?>
            </div>
            <div class="enquiry-field"><label for="nationality">Nationality *</label><input type="text" id="nationality" name="nationality" value="<?= $fv('nationality') ?>" required>
              <?php if (isset($forexErrors['nationality'])): ?><span class="field-error"><?= e($forexErrors['nationality']) ?></span><?php endif; ?>
            </div>
            <div class="enquiry-field full"><label for="residential_address">Residential Address *</label><input type="text" id="residential_address" name="residential_address" value="<?= $fv('residential_address') ?>" required>
              <?php if (isset($forexErrors['residential_address'])): ?><span class="field-error"><?= e($forexErrors['residential_address']) ?></span><?php endif; ?>
            </div>
            <div class="enquiry-field"><label for="city_of_visit">City of Visit *</label><input type="text" id="city_of_visit" name="city_of_visit" value="<?= $fv('city_of_visit') ?>" required>
              <?php if (isset($forexErrors['city_of_visit'])): ?><span class="field-error"><?= e($forexErrors['city_of_visit']) ?></span><?php endif; ?>
            </div>
            <div class="enquiry-field"><label for="departure_city">Departure City *</label><input type="text" id="departure_city" name="departure_city" value="<?= $fv('departure_city') ?>" required>
              <?php if (isset($forexErrors['departure_city'])): ?><span class="field-error"><?= e($forexErrors['departure_city']) ?></span><?php endif; ?>
            </div>
            <div class="enquiry-field"><label for="travel_start_date">Travel Start Date</label><input type="date" id="travel_start_date" name="travel_start_date" value="<?= $fv('travel_start_date') ?>"></div>
            <div class="enquiry-field"><label for="travel_end_date">Travel End Date</label><input type="date" id="travel_end_date" name="travel_end_date" value="<?= $fv('travel_end_date') ?>"></div>
            <div class="enquiry-field"><label for="forex_traveller_count">Number of Travellers</label><input type="number" id="forex_traveller_count" name="traveller_count" min="1" value="<?= $fv('traveller_count', '1') ?>"></div>
            <div class="enquiry-field"><label for="forex_type">Forex Type *</label>
              <select id="forex_type" name="forex_type" required>
                <option value="">Select&hellip;</option>
                <?php foreach (FOREX_TYPES as $ft): ?><option value="<?= e($ft) ?>" <?= ($forexDetails['forex_type'] ?? '') === $ft ? 'selected' : '' ?>><?= e($ft) ?></option><?php endforeach; ?>
              </select>
              <?php if (isset($forexErrors['forex_type'])): ?><span class="field-error"><?= e($forexErrors['forex_type']) ?></span><?php endif; ?>
            </div>
            <div class="enquiry-field"><label for="currency_code">Currency Required *</label>
              <select id="currency_code" name="currency_code" required>
                <option value="">Select&hellip;</option>
                <?php foreach (FOREX_CURRENCIES as $code => $label): ?><option value="<?= e($code) ?>" <?= ($forexDetails['currency_code'] ?? '') === $code ? 'selected' : '' ?>><?= e($code . ' — ' . $label) ?></option><?php endforeach; ?>
              </select>
              <?php if (isset($forexErrors['currency_code'])): ?><span class="field-error"><?= e($forexErrors['currency_code']) ?></span><?php endif; ?>
            </div>
            <div class="enquiry-field"><label for="amount_required">Amount Required</label><input type="number" id="amount_required" name="amount_required" min="0" step="0.01" value="<?= $fv('amount_required', '0') ?>"></div>
            <div class="enquiry-field"><label for="approx_inr_value">Approximate INR Value</label><input type="number" id="approx_inr_value" name="approx_inr_value" min="0" step="0.01" value="<?= $fv('approx_inr_value', '0') ?>">
              <span class="auth-note" style="margin:4px 0 0">For an indicative rate, see the <a href="<?= url('/') ?>#fx">live exchange rate strip</a> — this figure isn't a quotation.</span>
            </div>
            <div class="enquiry-field"><label for="delivery_method">Delivery Method *</label>
              <select id="delivery_method" name="delivery_method">
                <?php foreach (FOREX_DELIVERY_METHODS as $dm): ?><option value="<?= e($dm) ?>" <?= ($forexDetails['delivery_method'] ?? 'Branch Pickup') === $dm ? 'selected' : '' ?>><?= e($dm) ?></option><?php endforeach; ?>
              </select>
            </div>
          </div>
          <div class="wizard-actions"><span></span><button type="submit" class="btn btn-primary btn-sm"><?= $forexDetails ? 'Update Forex Details' : 'Save Forex Details' ?></button></div>
        </form>

        <h2 class="account-section-title" style="margin-top:32px">Forex Document Checklist</h2>
        <p class="auth-note" style="margin-top:-10px">Mandatory items are required for every forex transaction. Conditional items apply depending on your specific transaction — your consultant will confirm which ones you need. See the <a href="<?= url('/forex-guidelines') ?>" target="_blank">FEMA &amp; RBI Forex Guidelines</a> for general rules.</p>
        <div class="forex-checklist">
          <?php foreach ($forexChecklist as $item): ?>
          <div class="forex-checklist-item <?= $item['uploaded'] ? 'is-done' : '' ?>">
            <span class="forex-checklist-check"><?= $item['uploaded'] ? '&check;' : '' ?></span>
            <span class="forex-checklist-label"><?= e($item['label']) ?></span>
            <span class="forex-checklist-tag <?= $item['mandatory'] ? 'is-mandatory' : 'is-conditional' ?>"><?= $item['mandatory'] ? 'Mandatory' : 'Conditional' ?></span>
          </div>
          <?php endforeach; ?>
        </div>
        <p class="auth-note">Upload these in the Documents section below, tagged with the matching document type.</p>

        <h2 class="account-section-title" style="margin-top:32px">Delivery Pipeline</h2>
        <div class="forex-pipeline">
          <?php foreach (FOREX_PIPELINE_STAGES as $i => $stage): $reached = $stage === $forexTransaction['stage']; $done = array_search($forexTransaction['stage'], FOREX_PIPELINE_STAGES, true) > $i; ?>
          <div class="forex-pipeline-stage <?= $done ? 'is-done' : ($reached ? 'is-current' : '') ?>">
            <span class="forex-pipeline-dot"></span><span><?= e($stage) ?></span>
          </div>
          <?php endforeach; ?>
        </div>
        <?php if (!$forexReadyForDelivery): ?>
        <p class="doc-passport-status is-missing" style="margin-top:14px">
          &#128274; <strong>Ready for Delivery</strong> and <strong>Delivered</strong> are locked until every mandatory document above is uploaded and verified by a consultant — home delivery never ships on an unverified transaction.
        </p>
        <?php endif; ?>
        <?php endif; ?>

        <h2 class="account-section-title" style="margin-top:32px">Documents</h2>
        <div class="doc-upload" data-enquiry-code="<?= e($enquiry['enquiry_code']) ?>" data-csrf="<?= e(auth_csrf_token()) ?>">
          <div class="doc-passport-status <?= $docHasPassport ? 'is-ok' : 'is-missing' ?>">
            <?php if ($docHasPassport): ?>
            &check; Passport uploaded
            <?php else: ?>
            &#9888; Passport required — upload the first &amp; last page, or a combined copy
            <?php endif; ?>
          </div>

          <div class="doc-drop" id="docDropZone">
            <p><strong>Drag &amp; drop a file</strong> or tap to choose &middot; PDF, JPG, PNG</p>
            <select id="docTypeSelect">
              <?php foreach ($documentTypes as $dt): ?>
              <option value="<?= (int) $dt['id'] ?>"><?= e($dt['label']) ?></option>
              <?php endforeach; ?>
            </select>
            <input type="file" id="docFileInput" accept=".pdf,.jpg,.jpeg,.png" hidden>
            <button type="button" class="btn btn-outline-brand btn-sm" id="docChooseBtn">Choose File</button>
          </div>
          <div id="docUploadMsg" role="alert"></div>

          <div class="doc-counter">
            <span>Documents: <b id="docCount"><?= $docNonPassportCount ?></b> / <?= DOCUMENT_MAX_COUNT ?></span>
            <span>Total size: <b id="docSize"><?= number_format($docTotalBytes / 1048576, 1) ?></b> MB / <?= DOCUMENT_MAX_TOTAL_MB ?> MB</span>
          </div>
          <div class="doc-progress-track"><div class="doc-progress-fill" id="docProgressFill" style="width:<?= min(100, $docTotalBytes / DOCUMENT_MAX_TOTAL_BYTES * 100) ?>%"></div></div>

          <div class="doc-list" id="docList">
            <?php foreach ($documents as $doc): ?>
            <div class="doc-item" data-uid="<?= e($doc['document_uid']) ?>">
              <div class="doc-item-main">
                <a href="<?= url('/document?uid=' . $doc['document_uid']) ?>" target="_blank" rel="noopener"><?= e($doc['original_filename']) ?></a>
                <span class="doc-item-meta"><?= e($doc['type_label']) ?> &middot; <?= number_format($doc['size_bytes'] / 1024, 0) ?> KB</span>
                <?php if ($doc['status'] === 'Replacement Required' && $doc['rejection_reason']): ?>
                <p class="doc-item-reason">Reason: <?= e($doc['rejection_reason']) ?></p>
                <?php endif; ?>
              </div>
              <span class="enq-status-badge status-<?= e(strtolower(str_replace(' ', '-', $doc['status']))) ?>"><?= e($doc['status']) ?></span>
              <button type="button" class="doc-item-remove" data-uid="<?= e($doc['document_uid']) ?>" aria-label="Remove <?= e($doc['original_filename']) ?>">&times;</button>
            </div>
            <?php endforeach; ?>
          </div>
        </div>

        <h2 class="account-section-title" style="margin-top:32px">Status</h2>
        <div class="enq-timeline">
          <?php foreach ($history as $h): ?>
          <div class="enq-tl-item"><span class="enq-tl-dot"></span>
            <div class="enq-tl-body"><b><?= e($h['status']) ?></b><?= $h['note'] ? '<p>' . e($h['note']) . '</p>' : '' ?><span><?= e(date('j M Y, g:i a', (int) $h['created_at'])) ?></span></div>
          </div>
          <?php endforeach; ?>
          <div class="enq-tl-item"><span class="enq-tl-dot is-pending"></span>
            <div class="enq-tl-body"><b class="is-pending">Consultant review</b><span>Once a consultant is assigned, further updates appear here.</span></div>
          </div>
        </div>

        <h2 class="account-section-title" style="margin-top:32px">Your notes</h2>
        <?php if ($notesSaved): ?><p class="notice-inline">Saved.</p><?php endif; ?>
        <form method="post" action="<?= url('/enquiry/' . $enquiry['enquiry_code']) ?>">
          <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
          <input type="hidden" name="action" value="save_notes">
          <div class="field">
            <label for="customer_notes">Add anything else the consultant should know — this is visible to you and your consultant, not a public comment.</label>
            <textarea id="customer_notes" name="customer_notes" rows="3"><?= e($enquiry['customer_notes']) ?></textarea>
          </div>
          <button type="submit" class="btn btn-sm btn-outline-brand" style="margin-top:10px">Save note</button>
        </form>

        <p class="auth-note account-note-wide" style="margin-top:28px">
          Having an issue with this enquiry? <a href="<?= url('/support') ?>?enquiry=<?= rawurlencode($enquiry['enquiry_code']) ?>">Raise a support ticket</a> about it.
        </p>
        <p class="auth-note account-note-wide" style="margin-top:8px">
          <a href="<?= url('/account') ?>">&larr; Back to My Account</a>
        </p>
      </div>
    </div>
  </section>
</main>

<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
