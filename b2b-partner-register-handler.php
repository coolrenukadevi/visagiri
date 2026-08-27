<?php
/**
 * POST-only handler for b2b-partner-register.php. Creates the b2b_partners
 * row (status Submitted) and its primary b2b_partner_users account (email
 * already verified via OTP at this point — the partner still cannot log in
 * until an admin approves the application, enforced later in
 * includes/partner-auth.php, not here).
 */
header('Content-Type: application/json');
require_once __DIR__ . '/includes/b2b-otp.php';

function b2b_reg_fail(string $message, array $fieldErrors = [], int $code = 422): void
{
    http_response_code($code);
    echo json_encode(['success' => false, 'message' => $message, 'errors' => $fieldErrors]);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    b2b_reg_fail('Method not allowed.', [], 405);
}

if (!empty($_POST['website_hp'])) {
    // Honeypot tripped — pretend success so bots don't learn anything, but do nothing.
    echo json_encode(['success' => true, 'application_ref' => 'B2B-VOID-000000', 'registration_date' => gmdate('d M Y'), 'status' => 'Submitted']);
    exit;
}

$pdo = b2b_db();

$ip = $_SERVER['REMOTE_ADDR'] ?? '';
if ($ip !== '') {
    $stmt = $pdo->prepare('SELECT COUNT(*) FROM b2b_partners WHERE ip_address = ? AND created_at > ?');
    $stmt->execute([$ip, gmdate('c', time() - 60)]);
    if ((int) $stmt->fetchColumn() >= 3) {
        b2b_reg_fail('Too many applications submitted recently. Please wait a minute and try again.', [], 429);
    }
}

$fieldErrors = [];

$companyName = trim($_POST['company_name'] ?? '');
if ($companyName === '') { $fieldErrors['company_name'] = 'Company name is required.'; }

$businessType = trim($_POST['business_type'] ?? '');
if (!in_array($businessType, B2B_BUSINESS_TYPES, true)) { $fieldErrors['business_type'] = 'Please select a business type.'; }

$yearEstablished = trim($_POST['year_established'] ?? '');
$website = trim($_POST['website'] ?? '');
$gstNumber = strtoupper(trim($_POST['gst_number'] ?? ''));
$panNumber = strtoupper(trim($_POST['pan_number'] ?? ''));
$iataRegistered = ($_POST['iata_registered'] ?? '0') === '1' ? 1 : 0;
$iataNumber = trim($_POST['iata_number'] ?? '');
$tafiNumber = trim($_POST['tafi_number'] ?? '');
$otherAssociation = trim($_POST['other_association'] ?? '');

$address = trim($_POST['address'] ?? '');
if ($address === '') { $fieldErrors['address'] = 'Office address is required.'; }
$city = trim($_POST['city'] ?? '');
if ($city === '') { $fieldErrors['city'] = 'City is required.'; }
$state = trim($_POST['state'] ?? '');
if ($state === '') { $fieldErrors['state'] = 'State is required.'; }
$country = trim($_POST['country'] ?? '') ?: 'India';
$pinCode = trim($_POST['pin_code'] ?? '');
if ($pinCode === '') { $fieldErrors['pin_code'] = 'PIN code is required.'; }

$servicesOffered = array_values(array_intersect((array) ($_POST['services_offered'] ?? []), B2B_SERVICES_OFFERED));
$visaSpecialization = array_values(array_intersect((array) ($_POST['visa_specialization'] ?? []), B2B_VISA_SPECIALIZATION));
$monthlyVolume = trim($_POST['monthly_visa_volume'] ?? '');
if ($monthlyVolume !== '' && !in_array($monthlyVolume, B2B_MONTHLY_VOLUME_BANDS, true)) { $monthlyVolume = ''; }

$contactName = trim($_POST['contact_name'] ?? '');
if ($contactName === '') { $fieldErrors['contact_name'] = 'Contact person name is required.'; }
$contactDesignation = trim($_POST['contact_designation'] ?? '');

$contactEmail = filter_var(trim($_POST['contact_email'] ?? ''), FILTER_VALIDATE_EMAIL);
if (!$contactEmail) { $fieldErrors['contact_email'] = 'Please enter a valid email address.'; }

$contactMobile = preg_replace('/\D/', '', $_POST['contact_mobile'] ?? '');
if (!preg_match('/^[6-9]\d{9}$/', $contactMobile)) { $fieldErrors['contact_mobile'] = 'Please enter a valid 10-digit mobile number.'; }

$contactWhatsapp = preg_replace('/\D/', '', $_POST['contact_whatsapp'] ?? '');
$contactAltMobile = preg_replace('/\D/', '', $_POST['contact_alternate_mobile'] ?? '');

$username = trim($_POST['username'] ?? '');
if ($username === '' || !preg_match('/^[A-Za-z0-9_.-]{3,50}$/', $username)) {
    $fieldErrors['username'] = 'Username must be 3-50 characters (letters, numbers, . _ - only).';
}

$password = (string) ($_POST['password'] ?? '');
$passwordConfirm = (string) ($_POST['password_confirm'] ?? '');
if (strlen($password) < 8) { $fieldErrors['password'] = 'Password must be at least 8 characters.'; }
if ($password !== $passwordConfirm) { $fieldErrors['password_confirm'] = 'Passwords do not match.'; }

$declarationConfirmed = !empty($_POST['declaration_confirmed']);
$allTermsAccepted = $declarationConfirmed
    && !empty($_POST['agree_terms']) && !empty($_POST['agree_privacy']) && !empty($_POST['agree_partner_agreement'])
    && !empty($_POST['agree_commission']) && !empty($_POST['agree_doc_policy']) && !empty($_POST['agree_data_protection']);
if (!$allTermsAccepted) {
    $fieldErrors['declaration_confirmed'] = 'Please accept all terms and the declaration.';
}

if (!empty($fieldErrors)) {
    b2b_reg_fail('Please correct the highlighted fields.', $fieldErrors);
}

// Email must have been verified via OTP within the last hour — never trust the client alone.
if (!b2b_email_recently_verified($pdo, $contactEmail, 'register')) {
    b2b_reg_fail('Please verify your email with the code we sent before submitting.', ['contact_email' => 'Email not verified.']);
}

// Duplicate check (spec §27) — email, mobile, company, GST, PAN, IATA.
$duplicate = b2b_find_duplicate_partner($pdo, [
    'contact_email' => $contactEmail,
    'contact_mobile' => $contactMobile,
    'company_name' => $companyName,
    'gst_number' => $gstNumber,
    'pan_number' => $panNumber,
    'iata_number' => $iataNumber,
]);
if ($duplicate) {
    b2b_reg_fail('An account/application already exists. Please contact your Relationship Manager.');
}

$usernameCheck = $pdo->prepare('SELECT COUNT(*) FROM b2b_partner_users WHERE username = ?');
$usernameCheck->execute([$username]);
if ((int) $usernameCheck->fetchColumn() > 0) {
    b2b_reg_fail('That username is already taken.', ['username' => 'Already taken.']);
}

$applicationRef = b2b_generate_ref($pdo, b2b_setting($pdo, 'application_ref_prefix', 'B2B'));
$uploadToken = bin2hex(random_bytes(24));
$now = gmdate('c');

$insert = $pdo->prepare('INSERT INTO b2b_partners (
    application_ref, status, upload_token, company_name, business_type, year_established, website, gst_number, pan_number,
    iata_registered, iata_number, tafi_number, other_association, address, city, state, country, pin_code,
    services_offered, visa_specialization, monthly_visa_volume,
    contact_name, contact_designation, contact_email, contact_mobile, contact_whatsapp, contact_alternate_mobile,
    ip_address, submitted_at, created_at
) VALUES (
    :ref, :status, :upload_token, :company_name, :business_type, :year_established, :website, :gst_number, :pan_number,
    :iata_registered, :iata_number, :tafi_number, :other_association, :address, :city, :state, :country, :pin_code,
    :services_offered, :visa_specialization, :monthly_volume,
    :contact_name, :contact_designation, :contact_email, :contact_mobile, :contact_whatsapp, :contact_alt_mobile,
    :ip, :submitted_at, :created_at
)');
$insert->execute([
    'ref' => $applicationRef,
    'status' => 'Submitted',
    'upload_token' => $uploadToken,
    'company_name' => $companyName,
    'business_type' => $businessType,
    'year_established' => $yearEstablished,
    'website' => $website,
    'gst_number' => $gstNumber,
    'pan_number' => $panNumber,
    'iata_registered' => $iataRegistered,
    'iata_number' => $iataNumber,
    'tafi_number' => $tafiNumber,
    'other_association' => $otherAssociation,
    'address' => $address,
    'city' => $city,
    'state' => $state,
    'country' => $country,
    'pin_code' => $pinCode,
    'services_offered' => json_encode($servicesOffered),
    'visa_specialization' => json_encode($visaSpecialization),
    'monthly_volume' => $monthlyVolume,
    'contact_name' => $contactName,
    'contact_designation' => $contactDesignation,
    'contact_email' => $contactEmail,
    'contact_mobile' => '+91' . $contactMobile,
    'contact_whatsapp' => $contactWhatsapp !== '' ? '+91' . $contactWhatsapp : '+91' . $contactMobile,
    'contact_alt_mobile' => $contactAltMobile !== '' ? '+91' . $contactAltMobile : null,
    'ip' => $ip,
    'submitted_at' => $now,
    'created_at' => $now,
]);
$partnerId = (int) $pdo->lastInsertId();

$userInsert = $pdo->prepare('INSERT INTO b2b_partner_users (
    partner_id, name, designation, email, username, password_hash, mobile, whatsapp, alternate_mobile,
    role, permissions, is_primary, status, email_verified_at, created_at
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1, ?, ?, ?)');
$userInsert->execute([
    $partnerId, $contactName, $contactDesignation, $contactEmail, $username,
    password_hash($password, PASSWORD_DEFAULT),
    '+91' . $contactMobile,
    $contactWhatsapp !== '' ? '+91' . $contactWhatsapp : '+91' . $contactMobile,
    $contactAltMobile !== '' ? '+91' . $contactAltMobile : null,
    'Owner', json_encode(array_keys(B2B_PARTNER_PERMISSIONS)), 'Active', $now, $now,
]);

b2b_log_audit($pdo, 'partner', $partnerId, 'Website', 'System', 'B2B partner application submitted', '', $applicationRef);
b2b_notify($pdo, null, 'b2b_new_application', "New B2B partner application $applicationRef from $companyName.", $partnerId);

$scheme = (($_SERVER['HTTPS'] ?? '') === 'on') ? 'https://' : 'http://';
$host = $_SERVER['HTTP_HOST'] ?? 'visaagency.in';
$uploadUrl = "$scheme$host/b2b-partner-documents?ref=" . rawurlencode($applicationRef) . '&token=' . rawurlencode($uploadToken);

$partnerRow = ['id' => $partnerId, 'contact_email' => $contactEmail];
b2b_notify_partner(
    $pdo, $partnerRow,
    "Your B2B Partner Application is Submitted — $applicationRef",
    "Dear $contactName,\n\nThank you for applying to become a VisaAgency.in B2B Partner.\n\n"
    . "Application Number: $applicationRef\nCompany: $companyName\nStatus: Submitted\n\n"
    . "Please upload your supporting documents (PAN, GST certificate, IATA certificate if applicable, etc.) using the private link below:\n$uploadUrl\n\n"
    . "Our B2B team will review your application and documents. We'll be in touch with next steps.\n\n"
    . "Regards,\nVisaAgency.in B2B Partner Team"
);

echo json_encode([
    'success' => true,
    'application_ref' => $applicationRef,
    'upload_token' => $uploadToken,
    'registration_date' => gmdate('d M Y'),
    'status' => 'Submitted',
]);
