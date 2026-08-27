<?php
/**
 * POST-only endpoint for the header "Get Assistance" Quick Enquiry
 * dialogue. Reuses the same enquiries table, ref/tracking-code
 * generation and notification helpers as the sitewide enquiry popup
 * (enquiry-handler.php) — this is an additional intake channel into the
 * same CRM, not a parallel system. See includes/quick-enquiry-config.php
 * for the single source of truth on services/purposes/fields.
 */

session_start();
header('Content-Type: application/json');

require_once __DIR__ . '/includes/enquiry-db.php';
require_once __DIR__ . '/includes/quick-enquiry-config.php';

function qe_fail(string $message, array $fieldErrors = [], int $code = 422): void
{
    http_response_code($code);
    echo json_encode(['success' => false, 'message' => $message, 'errors' => $fieldErrors]);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    qe_fail('Method not allowed.', [], 405);
}

// Honeypot: real visitors never fill this hidden field.
if (!empty($_POST['website'])) {
    echo json_encode(['success' => true, 'enquiry_ref' => 'VG-VOID-0000-000000', 'tracking_code' => 'VISA-0000-000000']);
    exit;
}

$submissionToken = trim($_POST['submission_token'] ?? '');
if ($submissionToken === '' || !preg_match('/^[a-f0-9-]{16,64}$/i', $submissionToken)) {
    qe_fail('Invalid submission. Please reopen the dialogue and try again.');
}

$pdo = enquiry_db();

// Idempotency: a resubmit with the same token (double-click, retry) returns
// the enquiry already created instead of creating a duplicate.
$tokenStmt = $pdo->prepare('SELECT enquiry_ref FROM submission_tokens WHERE token = ?');
$tokenStmt->execute([$submissionToken]);
$existingRef = $tokenStmt->fetchColumn();
if ($existingRef) {
    $existingStmt = $pdo->prepare('SELECT * FROM enquiries WHERE enquiry_ref = ?');
    $existingStmt->execute([$existingRef]);
    $existing = $existingStmt->fetch(PDO::FETCH_ASSOC);
    echo json_encode([
        'success' => true,
        'duplicate' => true,
        'enquiry_ref' => $existing['enquiry_ref'] ?? $existingRef,
        'tracking_code' => $existing['tracking_code'] ?? '',
        'service' => $existing['service_required'] ?? '',
        'purpose' => $existing['purpose'] ?? '',
    ]);
    exit;
}

// Basic anti-spam throttle: no more than 3 enquiries per IP per minute.
$ip = $_SERVER['REMOTE_ADDR'] ?? '';
if ($ip !== '') {
    $rateStmt = $pdo->prepare('SELECT COUNT(*) FROM enquiries WHERE ip_address = ? AND created_at > ?');
    $rateStmt->execute([$ip, gmdate('c', time() - 60)]);
    if ((int) $rateStmt->fetchColumn() >= 3) {
        qe_fail('Too many enquiries submitted recently. Please wait a minute and try again.', [], 429);
    }
}

$fieldErrors = [];

$serviceKey = trim($_POST['service'] ?? '');
if (!array_key_exists($serviceKey, QUICK_ENQUIRY_SERVICES)) {
    qe_fail('Invalid service selection. Please reopen the dialogue and try again.');
}
$svc = QUICK_ENQUIRY_SERVICES[$serviceKey];
$purpose = trim($_POST['purpose'] ?? '');

if (empty($svc['is_freeform']) && $purpose === '') {
    qe_fail('Please choose an option for your service. Reopen the dialogue and try again.');
}
if (!empty($svc['is_freeform']) && $purpose === '') {
    $purpose = 'General';
}

// ---- Derive CRM fields from the service config (single source of truth) ----
if ($serviceKey === 'visa') {
    $serviceRequired = $svc['category_map'][$purpose] ?? 'Other';
    $visaType = $purpose;
} else {
    $serviceRequired = $svc['service_required_map'][$purpose] ?? ($svc['service_required'] ?? 'Other Services');
    $visaType = 'Not Applicable';
}

$destinationCountry = trim($_POST['field_country'] ?? '') ?: 'Not Applicable';
$travelDate = trim($_POST['field_travel_date'] ?? '') ?: 'Not Applicable';

$messageParts = [];
if (!empty($svc['is_freeform'])) {
    $freeformMessage = trim($_POST['qe_message'] ?? '');
    if ($freeformMessage === '') {
        $fieldErrors['message'] = 'Please tell us what you need help with.';
    }
    $messageParts[] = $freeformMessage;
} else {
    foreach ($svc['extra_fields'] ?? [] as $f) {
        if (in_array($f['key'], ['country', 'travel_date'], true)) {
            continue; // already mapped to dedicated columns above
        }
        $val = trim($_POST['field_' . $f['key']] ?? '');
        if (!empty($f['required']) && $val === '') {
            $fieldErrors['field_' . $f['key']] = $f['label'] . ' is required.';
        }
        if ($val !== '') {
            $messageParts[] = $f['label'] . ': ' . $val;
        }
    }
    if (!empty($svc['extra_fields'])) {
        foreach ($svc['extra_fields'] as $f) {
            if ($f['key'] === 'country' && !empty($f['required']) && $destinationCountry === 'Not Applicable') {
                $fieldErrors['field_country'] = $f['label'] . ' is required.';
            }
            if ($f['key'] === 'travel_date' && !empty($f['required']) && $travelDate === 'Not Applicable') {
                $fieldErrors['field_travel_date'] = $f['label'] . ' is required.';
            }
        }
    }
}
$message = implode("\n", array_filter($messageParts, fn($p) => $p !== ''));

$fullName = trim($_POST['full_name'] ?? '');
if ($fullName === '' || mb_strlen($fullName) > 150) {
    $fieldErrors['full_name'] = 'Please enter your full name.';
}

$email = trim($_POST['email'] ?? '');
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $fieldErrors['email'] = 'Please enter a valid email address.';
}

$mobile = preg_replace('/\D/', '', $_POST['mobile'] ?? '');
if (!preg_match('/^[6-9]\d{9}$/', $mobile)) {
    $fieldErrors['mobile'] = 'Please enter a valid 10-digit Indian mobile number.';
}

$whatsapp = preg_replace('/\D/', '', $_POST['whatsapp_number'] ?? '');
if ($whatsapp !== '' && !preg_match('/^[6-9]\d{9}$/', $whatsapp)) {
    $fieldErrors['whatsapp_number'] = 'Please enter a valid 10-digit WhatsApp number, or leave it blank.';
}
$whatsappFull = $whatsapp !== '' ? '+91' . $whatsapp : '+91' . $mobile;

if (!empty($fieldErrors)) {
    qe_fail('Please correct the highlighted fields.', $fieldErrors);
}

$sourceUrl = substr(trim($_POST['source_url'] ?? ''), 0, 500);
$referrer = substr(trim($_POST['referrer'] ?? ''), 0, 500);
$utmSource = substr(trim($_POST['utm_source'] ?? ''), 0, 100);
$utmMedium = substr(trim($_POST['utm_medium'] ?? ''), 0, 100);
$utmCampaign = substr(trim($_POST['utm_campaign'] ?? ''), 0, 100);
$utmTerm = substr(trim($_POST['utm_term'] ?? ''), 0, 100);
$utmContent = substr(trim($_POST['utm_content'] ?? ''), 0, 100);
$device = substr(trim($_POST['device'] ?? ''), 0, 20);

$enquiryRef = enquiry_generate_ref($pdo, $serviceRequired);
$trackingCode = crm_generate_tracking_code($pdo);
$assignment = enquiry_auto_assign($pdo, $serviceRequired);
$now = gmdate('c');

$insert = $pdo->prepare('INSERT INTO enquiries (
    enquiry_ref, tracking_code, full_name, email, mobile, whatsapp_number,
    visa_category, service_required, destination_country, visa_type, travel_date, travellers,
    purpose, message, source, source_url, utm_source, utm_medium, utm_campaign, utm_term,
    utm_content, status, assigned_to, ip_address, user_agent, created_at
) VALUES (
    :ref, :tracking_code, :full_name, :email, :mobile, :whatsapp,
    :visa_category, :service_required, :destination_country, :visa_type, :travel_date, :travellers,
    :purpose, :message, :source, :source_url, :utm_source, :utm_medium, :utm_campaign, :utm_term,
    :utm_content, :status, :assigned_to, :ip, :ua, :created_at
)');
$insert->execute([
    'ref' => $enquiryRef,
    'tracking_code' => $trackingCode,
    'full_name' => $fullName,
    'email' => $email,
    'mobile' => '+91' . $mobile,
    'whatsapp' => $whatsappFull,
    'visa_category' => $serviceRequired,
    'service_required' => $serviceRequired,
    'destination_country' => $destinationCountry,
    'visa_type' => $visaType,
    'travel_date' => $travelDate,
    'travellers' => 1,
    'purpose' => $purpose,
    'message' => $message . ($referrer !== '' ? "\nReferrer: $referrer" : '') . ($device !== '' ? "\nDevice: $device" : ''),
    'source' => 'Website — Get Assistance',
    'source_url' => $sourceUrl,
    'utm_source' => $utmSource,
    'utm_medium' => $utmMedium,
    'utm_campaign' => $utmCampaign,
    'utm_term' => $utmTerm,
    'utm_content' => $utmContent,
    'status' => 'New Enquiry',
    'assigned_to' => $assignment['name'] ?? null,
    'ip' => $ip,
    'ua' => substr($_SERVER['HTTP_USER_AGENT'] ?? '', 0, 300),
    'created_at' => $now,
]);
$enquiryId = (int) $pdo->lastInsertId();

$tokenInsert = $pdo->prepare('INSERT INTO submission_tokens (token, enquiry_ref, created_at) VALUES (?, ?, ?)');
$tokenInsert->execute([$submissionToken, $enquiryRef, $now]);

crm_log_activity($pdo, $enquiryId, 'Website', 'created this enquiry', "Submitted via the Get Assistance dialogue ({$svc['label']} → $purpose).");
crm_log_status_change($pdo, $enquiryId, null, 'New Enquiry', 'Website', 'Your enquiry has been received and registered with our team.');
if ($assignment) {
    crm_log_activity($pdo, $enquiryId, 'System', 'auto-assigned to ' . $assignment['name'], $assignment['role']);
    $assigneeStmt = $pdo->prepare('SELECT id FROM users WHERE name = ?');
    $assigneeStmt->execute([$assignment['name']]);
    $assigneeId = $assigneeStmt->fetchColumn();
    if ($assigneeId) {
        crm_notify($pdo, (int) $assigneeId, 'assignment', "New enquiry $enquiryRef ({$svc['label']}) auto-assigned to you.", $enquiryId);
    }
}
crm_notify($pdo, null, 'new_enquiry', "New enquiry $enquiryRef created for $fullName via Get Assistance ({$svc['label']}).", $enquiryId);

crm_send_applicant_email(
    $email,
    "Your Enquiry is Registered — $trackingCode",
    "Dear $fullName,\n\nThank you for reaching out to VisaAgency.in. Your enquiry has been successfully registered with our team.\n\n" .
    "Reference Number: $enquiryRef\nTracking Code: $trackingCode\nService: {$svc['label']}\n\n" .
    "Please save this reference. You can track your enquiry anytime using your Tracking Code and registered Mobile Number or Email Address:\n" .
    (($_SERVER['HTTPS'] ?? '') === 'on' ? 'https://' : 'http://') . ($_SERVER['HTTP_HOST'] ?? 'visaagency.in') . "/track-application\n\n" .
    "Our team will review your request and contact you shortly.\n\nRegards,\nVisaAgency.in"
);

crm_send_staff_email(
    "New Enquiry Received — $enquiryRef",
    "A new enquiry was submitted via the Get Assistance dialogue on VisaAgency.in.\n\n" .
    "Enquiry Ref: $enquiryRef\nName: $fullName\nEmail: $email\nMobile: +91$mobile\nWhatsApp: $whatsappFull\n\n" .
    "Service: {$svc['label']}\nPurpose: $purpose\nDestination: $destinationCountry\nTravel Date: $travelDate\n" .
    "Auto-assigned to: " . ($assignment['name'] ?? 'Unassigned') . " (" . ($assignment['role'] ?? '-') . ")\n\n" .
    "Details:\n" . ($message !== '' ? $message : '(none)') . "\n\n" .
    "View in CRM: " . (($_SERVER['HTTPS'] ?? '') === 'on' ? 'https://' : 'http://') . ($_SERVER['HTTP_HOST'] ?? 'visaagency.in') . "/admin/enquiry.php?ref=$enquiryRef"
);

echo json_encode([
    'success' => true,
    'enquiry_ref' => $enquiryRef,
    'tracking_code' => $trackingCode,
    'service' => $serviceRequired,
    'purpose' => $purpose,
    'whatsapp_url' => 'https://wa.me/917844819819',
]);
