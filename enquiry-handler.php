<?php
/**
 * POST-only endpoint for the site-wide Enquiry Now popup. Validates input,
 * stores the enquiry + any uploaded documents in the local SQLite database,
 * and returns JSON. Not a browsable page — see .htaccess.
 */

session_start();
header('Content-Type: application/json');

require_once __DIR__ . '/includes/enquiry-db.php';

function enquiry_fail(string $message, array $fieldErrors = [], int $code = 422): void
{
    http_response_code($code);
    echo json_encode(['success' => false, 'message' => $message, 'errors' => $fieldErrors]);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    enquiry_fail('Method not allowed.', [], 405);
}

// Honeypot: real visitors never fill this hidden field.
if (!empty($_POST['website'])) {
    echo json_encode(['success' => true, 'tracking_code' => 'VISA-0000-000000']);
    exit;
}

$submissionToken = trim($_POST['submission_token'] ?? '');
if ($submissionToken === '' || !preg_match('/^[a-f0-9-]{16,64}$/i', $submissionToken)) {
    enquiry_fail('Invalid submission. Please reopen the form and try again.');
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
        'tracking_code' => $existing['tracking_code'] ?? '',
        'full_name' => $existing['full_name'] ?? '',
        'passport_masked' => crm_mask_passport($existing['passport_number'] ?? ''),
        'mobile_masked' => crm_mask_mobile($existing['mobile'] ?? ''),
        'email_masked' => crm_mask_email($existing['email'] ?? ''),
        'destination_country' => $existing['destination_country'] ?? '',
        'visa_type' => $existing['visa_type'] ?? '',
        'submitted_at' => $existing['created_at'] ?? '',
        'warnings' => [],
    ]);
    exit;
}

// Basic anti-spam throttle: no more than 3 enquiries per IP per minute.
$ip = $_SERVER['REMOTE_ADDR'] ?? '';
if ($ip !== '') {
    $rateStmt = $pdo->prepare("SELECT COUNT(*) FROM enquiries WHERE ip_address = ? AND created_at > ?");
    $rateStmt->execute([$ip, gmdate('c', time() - 60)]);
    if ((int) $rateStmt->fetchColumn() >= 3) {
        enquiry_fail('Too many enquiries submitted recently. Please wait a minute and try again.', [], 429);
    }
}

$fieldErrors = [];

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

$passportNumber = strtoupper(trim($_POST['passport_number'] ?? ''));
if (!preg_match('/^[A-Z0-9]{6,12}$/', $passportNumber)) {
    $fieldErrors['passport_number'] = 'Please enter a valid passport number.';
}

$countryResidence = trim($_POST['country_residence'] ?? '');
$currentCity = substr(trim($_POST['current_city'] ?? ''), 0, 100);
$nationality = substr(trim($_POST['nationality'] ?? ''), 0, 100);
$contactMethod = trim($_POST['contact_method'] ?? '');
if (!in_array($contactMethod, ['Phone', 'WhatsApp', 'Email'], true)) {
    $contactMethod = '';
}

$serviceOptions = ['Tourist Visa', 'Business Visa', 'Student Visa', 'Work Visa', 'Transit Visa', 'Family Visa', 'Sports Visa', 'Medical Visa', 'Crew Visa', 'Visa Extension', 'Other'];
$nonVisaServiceOptions = ['General Enquiry', 'Apostille & Attestation', 'Forex Assistance', 'Travel Insurance', 'Flight & Hotel Assistance', 'Other Services'];
$serviceRequired = trim($_POST['service_required'] ?? '');
$isNonVisaService = in_array($serviceRequired, $nonVisaServiceOptions, true);
if (!in_array($serviceRequired, $serviceOptions, true) && !$isNonVisaService) {
    $fieldErrors['service_required'] = 'Please select the service you need.';
}

// Destination country and visa type only make sense for visa services —
// non-visa enquiries (Apostille, Forex, Insurance, Flight/Hotel, General)
// store a sentinel value instead, since both columns are NOT NULL and
// re-purposing them avoids a schema migration for a same-shaped record.
$destinationCountry = trim($_POST['destination_country'] ?? '');
if ($destinationCountry === '') {
    if ($isNonVisaService) {
        $destinationCountry = 'Not Applicable';
    } else {
        $fieldErrors['destination_country'] = 'Please select your destination country.';
    }
}

$visaType = trim($_POST['visa_type'] ?? '');
if ($visaType === '') {
    if ($isNonVisaService) {
        $visaType = 'Not Applicable';
    } else {
        $fieldErrors['visa_type'] = 'Please select a visa type.';
    }
}

$travelDate = trim($_POST['travel_date'] ?? '');
$travelDateObj = DateTime::createFromFormat('Y-m-d', $travelDate);
$today = new DateTime('today');
if (!$travelDateObj || $travelDateObj < $today) {
    $fieldErrors['travel_date'] = 'Please choose a valid travel date (today or later).';
}

$travellers = filter_var($_POST['travellers'] ?? '', FILTER_VALIDATE_INT);
if ($travellers === false || $travellers < 1 || $travellers > 50) {
    $fieldErrors['travellers'] = 'Please enter a valid number of travellers.';
}

$purpose = trim($_POST['purpose'] ?? '');
$message = trim($_POST['message'] ?? '');

if (empty($_POST['consent_accurate']) || empty($_POST['consent_contact'])) {
    $fieldErrors['consent'] = 'Please accept both consent checkboxes to continue.';
}

if (!empty($fieldErrors)) {
    enquiry_fail('Please correct the highlighted fields.', $fieldErrors);
}

$sourceUrl = substr(trim($_POST['source_url'] ?? ''), 0, 500);
$utmSource = substr(trim($_POST['utm_source'] ?? ''), 0, 100);
$utmMedium = substr(trim($_POST['utm_medium'] ?? ''), 0, 100);
$utmCampaign = substr(trim($_POST['utm_campaign'] ?? ''), 0, 100);
$utmTerm = substr(trim($_POST['utm_term'] ?? ''), 0, 100);
$utmContent = substr(trim($_POST['utm_content'] ?? ''), 0, 100);

$enquiryRef = enquiry_generate_ref($pdo, $serviceRequired);
$trackingCode = crm_generate_tracking_code($pdo);
$now = gmdate('c');

$insert = $pdo->prepare('INSERT INTO enquiries (
    enquiry_ref, tracking_code, full_name, email, mobile, passport_number, country_residence, current_city, nationality, contact_method,
    visa_category, service_required, destination_country, visa_type, travel_date, travellers,
    purpose, message, source, source_url, utm_source, utm_medium, utm_campaign, utm_term,
    utm_content, status, ip_address, user_agent, created_at
) VALUES (
    :ref, :tracking_code, :full_name, :email, :mobile, :passport_number, :country_residence, :current_city, :nationality, :contact_method,
    :visa_category, :service_required, :destination_country, :visa_type, :travel_date, :travellers,
    :purpose, :message, :source, :source_url, :utm_source, :utm_medium, :utm_campaign, :utm_term,
    :utm_content, :status, :ip, :ua, :created_at
)');

$insert->execute([
    'ref' => $enquiryRef,
    'tracking_code' => $trackingCode,
    'full_name' => $fullName,
    'email' => $email,
    'mobile' => '+91' . $mobile,
    'passport_number' => $passportNumber,
    'country_residence' => $countryResidence,
    'current_city' => $currentCity,
    'nationality' => $nationality,
    'contact_method' => $contactMethod,
    'visa_category' => $serviceRequired,
    'service_required' => $serviceRequired,
    'destination_country' => $destinationCountry,
    'visa_type' => $visaType,
    'travel_date' => $travelDate,
    'travellers' => $travellers,
    'purpose' => $purpose,
    'message' => $message,
    'source' => 'Website',
    'source_url' => $sourceUrl,
    'utm_source' => $utmSource,
    'utm_medium' => $utmMedium,
    'utm_campaign' => $utmCampaign,
    'utm_term' => $utmTerm,
    'utm_content' => $utmContent,
    'status' => 'New Enquiry',
    'ip' => $_SERVER['REMOTE_ADDR'] ?? '',
    'ua' => substr($_SERVER['HTTP_USER_AGENT'] ?? '', 0, 300),
    'created_at' => $now,
]);
$enquiryId = (int) $pdo->lastInsertId();

$tokenInsert = $pdo->prepare('INSERT INTO submission_tokens (token, enquiry_ref, created_at) VALUES (?, ?, ?)');
$tokenInsert->execute([$submissionToken, $enquiryRef, $now]);

crm_log_activity($pdo, $enquiryId, 'Website', 'created this enquiry', 'Submitted via the website enquiry popup.');
crm_log_status_change($pdo, $enquiryId, null, 'New Enquiry', 'Website', 'Your enquiry has been received and registered with our visa management team.');
crm_notify($pdo, null, 'new_enquiry', "New enquiry $enquiryRef created for $fullName.", $enquiryId);

crm_send_applicant_email(
    $email,
    "Your Visa Enquiry is Registered — $trackingCode",
    "Dear $fullName,\n\n" .
    "Your visa enquiry has been successfully registered with our visa management team.\n\n" .
    "Tracking Code: $trackingCode\n" .
    "Visa Country: $destinationCountry\n" .
    "Visa Type: $visaType\n\n" .
    "Please save this Tracking Code. Use your Tracking Code, Passport Number and registered Mobile Number or Email Address to track your application status at any time:\n" .
    (($_SERVER['HTTPS'] ?? '') === 'on' ? 'https://' : 'http://') . ($_SERVER['HTTP_HOST'] ?? 'visaagency.in') . "/track-application\n\n" .
    "Our team will contact you shortly with the next steps.\n\n" .
    "Regards,\nVisaAgency.in"
);

crm_send_staff_email(
    "New Enquiry Received — $enquiryRef",
    "A new customer enquiry has been submitted on VisaAgency.in.\n\n" .
    "Enquiry Ref: $enquiryRef\n" .
    "Name: $fullName\n" .
    "Email: $email\n" .
    "Mobile: +91$mobile\n" .
    "Passport Number: $passportNumber\n" .
    "Nationality: $nationality\n" .
    "Country of Residence: $countryResidence\n\n" .
    "Service Required: $serviceRequired\n" .
    "Destination Country: $destinationCountry\n" .
    "Visa Type: $visaType\n" .
    "Travel Date: $travelDate\n" .
    "Travellers: $travellers\n" .
    "Purpose: $purpose\n\n" .
    "Message:\n" . ($message !== '' ? $message : '(none)') . "\n\n" .
    "View in CRM: " . (($_SERVER['HTTPS'] ?? '') === 'on' ? 'https://' : 'http://') . ($_SERVER['HTTP_HOST'] ?? 'visaagency.in') . "/admin/enquiry.php?ref=$enquiryRef"
);

// ---- Document uploads (best-effort: the enquiry itself is already saved) ----
$allowedExt = ['pdf', 'jpg', 'jpeg', 'png'];
$allowedMime = ['application/pdf', 'image/jpeg', 'image/png'];
$maxBytes = 5 * 1024 * 1024;
$categories = [
    'photo' => 'Photo',
    'passport_copy' => 'Passport Copy',
    'flight_tickets' => 'Flight Tickets',
    'hotel_reservations' => 'Hotel Reservations',
    'cover_letter' => 'Cover Letter',
    'other_documents' => 'Other Documents',
];

$uploadWarnings = [];
$targetDir = __DIR__ . '/uploads/enquiries/' . $enquiryRef;
$docInsert = $pdo->prepare('INSERT INTO enquiry_documents
    (enquiry_id, category, original_filename, stored_filename, file_type, file_size, uploaded_at)
    VALUES (?, ?, ?, ?, ?, ?, ?)');
$finfo = new finfo(FILEINFO_MIME_TYPE);

foreach ($categories as $fieldName => $label) {
    if (empty($_FILES[$fieldName])) {
        continue;
    }
    $files = $_FILES[$fieldName];
    $isMulti = is_array($files['name']);
    $count = $isMulti ? count($files['name']) : 1;

    for ($i = 0; $i < $count; $i++) {
        $name = $isMulti ? $files['name'][$i] : $files['name'];
        $tmpPath = $isMulti ? $files['tmp_name'][$i] : $files['tmp_name'];
        $error = $isMulti ? $files['error'][$i] : $files['error'];
        $size = $isMulti ? $files['size'][$i] : $files['size'];

        if ($error === UPLOAD_ERR_NO_FILE) {
            continue;
        }
        if ($error !== UPLOAD_ERR_OK) {
            $uploadWarnings[] = "$label: upload failed, please re-attach.";
            continue;
        }
        if ($size > $maxBytes) {
            $uploadWarnings[] = "$label: \"$name\" exceeds the 5MB limit and was skipped.";
            continue;
        }
        $ext = strtolower(pathinfo($name, PATHINFO_EXTENSION));
        $mime = $finfo->file($tmpPath) ?: '';
        if (!in_array($ext, $allowedExt, true) || !in_array($mime, $allowedMime, true)) {
            $uploadWarnings[] = "$label: \"$name\" is not a supported file type and was skipped.";
            continue;
        }

        if (!is_dir($targetDir)) {
            mkdir($targetDir, 0770, true);
        }
        $storedName = bin2hex(random_bytes(10)) . '.' . $ext;
        if (!move_uploaded_file($tmpPath, $targetDir . '/' . $storedName)) {
            $uploadWarnings[] = "$label: \"$name\" could not be saved, please try again.";
            continue;
        }

        $docInsert->execute([$enquiryId, $label, $name, $storedName, $mime, $size, gmdate('c')]);
    }
}

echo json_encode([
    'success' => true,
    'tracking_code' => $trackingCode,
    'full_name' => $fullName,
    'passport_masked' => crm_mask_passport($passportNumber),
    'mobile_masked' => crm_mask_mobile('+91' . $mobile),
    'email_masked' => crm_mask_email($email),
    'destination_country' => $destinationCountry,
    'visa_type' => $visaType,
    'submitted_at' => $now,
    'warnings' => $uploadWarnings,
]);
