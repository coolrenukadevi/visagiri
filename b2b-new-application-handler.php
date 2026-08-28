<?php
/**
 * POST-only handler for b2b-new-application.php. Inserts directly into the
 * shared `enquiries` table (same table every other channel — website,
 * phone, admin drawer — writes to) tagged with partner_id/partner_user_id
 * and source='Partner' (an existing CRM_SOURCES value, not a new one), so
 * staff see B2B-submitted cases in their normal Enquiries/Applications
 * pipeline exactly like any other channel.
 *
 * Reference numbers use b2b_generate_ref() with the admin-configurable
 * 'enquiry_ref_prefix' setting (defaults to 'ENQ-B2B') rather than
 * enquiry_generate_ref() — the latter only accepts a $serviceRequired
 * string and maps it through a fixed 4-prefix ladder (APOS/FOREX/TRAVEL/
 * GEN/VISA) with no way to inject a custom prefix, so it can't produce the
 * visibly-distinct ENQ-B2B-... refs the spec asks for. b2b_generate_ref()
 * already accepts an arbitrary prefix and uses its own independent
 * b2b_ref_counters table, so there's no collision risk with any other
 * ref series on the site.
 */
header('Content-Type: application/json');
require_once __DIR__ . '/includes/partner-auth.php';
require_once __DIR__ . '/includes/b2b-csrf.php';
require_once __DIR__ . '/includes/countries-data.php';
partner_require_login();

function b2b_app_fail(string $message, array $fieldErrors = [], int $code = 422): void
{
    http_response_code($code);
    echo json_encode(['success' => false, 'message' => $message, 'errors' => $fieldErrors]);
    exit;
}

if (!partner_has_permission('create_application')) {
    b2b_app_fail('Your account does not have permission to submit visa applications. Contact your account Owner.', [], 403);
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    b2b_app_fail('Method not allowed.', [], 405);
}

if (!b2b_csrf_valid()) {
    b2b_app_fail('Security check failed. Please refresh the page and try again.', [], 403);
}

$pdo = b2b_db();
$fieldErrors = [];

$fullName = trim($_POST['full_name'] ?? '');
if ($fullName === '') { $fieldErrors['full_name'] = 'Traveller name is required.'; }

$email = filter_var(trim($_POST['email'] ?? ''), FILTER_VALIDATE_EMAIL);
if (!$email) { $fieldErrors['email'] = 'A valid email address is required.'; }

$mobile = preg_replace('/\D/', '', $_POST['mobile'] ?? '');
if (!preg_match('/^[6-9]\d{9}$/', $mobile)) { $fieldErrors['mobile'] = 'Please enter a valid 10-digit Indian mobile number.'; }

$passportNumber = strtoupper(trim($_POST['passport_number'] ?? ''));
$nationality = trim($_POST['nationality'] ?? '');

$visaCategory = trim($_POST['visa_category'] ?? '');
if (!in_array($visaCategory, CRM_VISA_CATEGORIES, true)) { $fieldErrors['visa_category'] = 'Please select a valid category.'; }

$destinationCountry = trim($_POST['destination_country'] ?? '');
if ($destinationCountry === '') { $fieldErrors['destination_country'] = 'Destination country is required.'; }

$visaType = trim($_POST['visa_type'] ?? '');
if ($visaType === '') { $fieldErrors['visa_type'] = 'Visa type is required.'; }

$travelDate = trim($_POST['travel_date'] ?? '');
if ($travelDate === '' || !preg_match('/^\d{4}-\d{2}-\d{2}$/', $travelDate)) { $fieldErrors['travel_date'] = 'Please choose a valid travel date.'; }

$travellers = (int) ($_POST['travellers'] ?? 1);
if ($travellers < 1) { $travellers = 1; }

$message = trim($_POST['message'] ?? '');

if (!empty($fieldErrors)) {
    b2b_app_fail('Please correct the highlighted fields.', $fieldErrors);
}

$partnerStmt = $pdo->prepare('SELECT * FROM b2b_partners WHERE id = ?');
$partnerStmt->execute([partner_id()]);
$partner = $partnerStmt->fetch(PDO::FETCH_ASSOC);
if (!$partner) {
    b2b_app_fail('Your partner account could not be found.', [], 403);
}

$enquiryRef = b2b_generate_ref($pdo, b2b_setting($pdo, 'enquiry_ref_prefix', 'ENQ-B2B'));
$trackingCode = crm_generate_tracking_code($pdo);
$assignment = enquiry_auto_assign($pdo, $visaCategory);
$now = gmdate('c');

$insert = $pdo->prepare('INSERT INTO enquiries (
    enquiry_ref, tracking_code, full_name, email, mobile, passport_number, nationality,
    visa_category, service_required, destination_country, visa_type, travel_date, travellers,
    message, source, status, assigned_to, partner_id, partner_user_id, ip_address, user_agent, created_at
) VALUES (
    :ref, :tracking_code, :full_name, :email, :mobile, :passport_number, :nationality,
    :visa_category, :service_required, :destination_country, :visa_type, :travel_date, :travellers,
    :message, :source, :status, :assigned_to, :partner_id, :partner_user_id, :ip, :ua, :created_at
)');
$insert->execute([
    'ref' => $enquiryRef,
    'tracking_code' => $trackingCode,
    'full_name' => $fullName,
    'email' => $email,
    'mobile' => '+91' . $mobile,
    'passport_number' => $passportNumber ?: null,
    'nationality' => $nationality ?: null,
    'visa_category' => $visaCategory,
    'service_required' => $visaCategory,
    'destination_country' => $destinationCountry,
    'visa_type' => $visaType,
    'travel_date' => $travelDate,
    'travellers' => $travellers,
    'message' => $message . "\n\nSubmitted via B2B Partner Portal by " . partner_name() . ' (' . $partner['company_name'] . ', ' . $partner['application_ref'] . ').',
    'source' => 'Partner',
    'status' => 'New Enquiry',
    'assigned_to' => $assignment['name'] ?? null,
    'partner_id' => partner_id(),
    'partner_user_id' => partner_user_id(),
    'ip' => $_SERVER['REMOTE_ADDR'] ?? '',
    'ua' => substr($_SERVER['HTTP_USER_AGENT'] ?? '', 0, 300),
    'created_at' => $now,
]);
$enquiryId = (int) $pdo->lastInsertId();

crm_log_activity($pdo, $enquiryId, partner_name() . ' (B2B Partner)', 'Visa application submitted via B2B Partner Portal', $partner['company_name'] . ' — ' . $partner['application_ref']);
crm_log_status_change($pdo, $enquiryId, null, 'New Enquiry', partner_name() . ' (B2B Partner)', 'Application submitted by our B2B partner ' . $partner['company_name'] . '.');
crm_notify($pdo, null, 'new_enquiry', "New B2B application {$enquiryRef} from {$partner['company_name']} ({$fullName}, {$destinationCountry}).", $enquiryId);
crm_send_staff_email('New B2B Partner Application — ' . $enquiryRef, "Partner: {$partner['company_name']} ({$partner['application_ref']})\nSubmitted by: " . partner_name() . "\n\nTraveller: $fullName\nDestination: $destinationCountry\nVisa Type: $visaType\nCategory: $visaCategory\nTravel Date: $travelDate\nTravellers: $travellers\n\nView in CRM: admin/enquiry.php?ref=" . $enquiryRef);

b2b_notify_partner(
    $pdo, $partner,
    "Application Received — $enquiryRef",
    "Dear " . partner_name() . ",\n\nWe've received the visa application you submitted for $fullName.\n\nReference: $enquiryRef\nDestination: $destinationCountry\nVisa Type: $visaType\n\nYou can track this case from your Partner Portal dashboard.\n\nRegards,\nVisaAgency.in B2B Partner Team"
);

echo json_encode(['success' => true, 'enquiry_ref' => $enquiryRef]);
