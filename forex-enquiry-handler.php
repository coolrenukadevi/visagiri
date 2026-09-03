<?php
/**
 * POST-only handler for forex-enquiry.php. Creates a forex_requests row
 * (status 'New Request'), seeds placeholder forex_documents rows for
 * whatever this destination's forex_country_rules marks as required (so
 * the upload checklist on forex-documents.php has something to render
 * against immediately), and emails the customer a token-gated upload
 * link — mirrors b2b-partner-register-handler.php's shape, minus the
 * account/OTP steps a forex enquiry doesn't need.
 */
header('Content-Type: application/json');
require_once __DIR__ . '/includes/forex-db.php';

function fx_enq_fail(string $message, int $code = 422): void
{
    http_response_code($code);
    echo json_encode(['success' => false, 'message' => $message]);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    fx_enq_fail('Method not allowed.', 405);
}

if (!empty($_POST['website_hp'])) {
    // Honeypot tripped — pretend success so bots don't learn anything, but do nothing.
    echo json_encode(['success' => true, 'forex_ref' => 'VG-FX-VOID-000000', 'submitted_date' => gmdate('d M Y'), 'status' => 'New Request']);
    exit;
}

$pdo = forex_db();

$ip = $_SERVER['REMOTE_ADDR'] ?? '';
if ($ip !== '') {
    $stmt = $pdo->prepare('SELECT COUNT(*) FROM forex_requests WHERE ip_address = ? AND created_at > ?');
    $stmt->execute([$ip, gmdate('c', time() - 60)]);
    if ((int) $stmt->fetchColumn() >= 3) {
        fx_enq_fail('Too many enquiries submitted recently. Please wait a minute and try again.', 429);
    }
}

$fullName = trim($_POST['full_name'] ?? '');
if ($fullName === '') { fx_enq_fail('Full name is required.'); }

$mobile = preg_replace('/\D/', '', $_POST['mobile'] ?? '');
if (!preg_match('/^[6-9]\d{9}$/', $mobile)) { fx_enq_fail('Please enter a valid 10-digit mobile number.'); }

$email = filter_var(trim($_POST['email'] ?? ''), FILTER_VALIDATE_EMAIL);
if (!$email) { fx_enq_fail('Please enter a valid email address.'); }

$city = trim($_POST['city'] ?? '');
if ($city === '') { fx_enq_fail('City is required.'); }

$nationality = trim($_POST['nationality'] ?? '');
$state = trim($_POST['state'] ?? '');
$dob = trim($_POST['date_of_birth'] ?? '');

$serviceType = trim($_POST['service_type'] ?? '');
if (!in_array($serviceType, FOREX_SERVICE_TYPES, true)) { fx_enq_fail('Please select a valid forex service.'); }

$purpose = trim($_POST['purpose'] ?? '');
if (!in_array($purpose, FOREX_TRAVEL_PURPOSES, true)) { fx_enq_fail('Please select a valid purpose.'); }

$currencies = forex_currencies($pdo);
$currencyCode = strtoupper(trim($_POST['currency_code'] ?? ''));
if (!in_array($currencyCode, $currencies, true)) { fx_enq_fail('Please select a valid currency.'); }

$amount = (float) ($_POST['amount_required'] ?? 0);
if ($amount <= 0) { fx_enq_fail('Please enter the amount required.'); }

$countryVisit = trim($_POST['country_visit'] ?? '');
if ($countryVisit === '') { fx_enq_fail('Please select your destination.'); }

$departureDate = trim($_POST['departure_date'] ?? '') ?: null;
$returnDate = trim($_POST['return_date'] ?? '') ?: null;
$deliveryMethod = trim($_POST['delivery_method'] ?? '');
if ($deliveryMethod !== '' && !in_array($deliveryMethod, FOREX_DELIVERY_METHODS, true)) { $deliveryMethod = ''; }
$specialRequirement = trim($_POST['special_requirement'] ?? '');

// Duplicate/possible-duplicate check (spec §56): same mobile + destination + open status within the last 24h.
$dupStmt = $pdo->prepare("SELECT forex_ref FROM forex_requests WHERE mobile = ? AND country_visit = ? AND created_at > ? AND status NOT IN ('Cancelled', 'Rejected') ORDER BY id DESC LIMIT 1");
$dupStmt->execute(['+91' . $mobile, $countryVisit, gmdate('c', time() - 86400)]);
$existingRef = $dupStmt->fetchColumn();

$forexRef = forex_generate_ref($pdo);
$uploadToken = bin2hex(random_bytes(24));
$now = gmdate('c');

$insert = $pdo->prepare('INSERT INTO forex_requests (
    forex_ref, status, full_name, date_of_birth, mobile, email, city, state, nationality,
    country_visit, purpose, departure_date, return_date, service_type, currency_code, amount_required,
    delivery_method, special_requirement, upload_token, ip_address, created_at, updated_at
) VALUES (
    :ref, :status, :full_name, :dob, :mobile, :email, :city, :state, :nationality,
    :country_visit, :purpose, :departure_date, :return_date, :service_type, :currency_code, :amount_required,
    :delivery_method, :special_requirement, :upload_token, :ip, :created_at, :updated_at
)');
$insert->execute([
    'ref' => $forexRef,
    'status' => 'New Request',
    'full_name' => $fullName,
    'dob' => $dob,
    'mobile' => '+91' . $mobile,
    'email' => $email,
    'city' => $city,
    'state' => $state,
    'nationality' => $nationality,
    'country_visit' => $countryVisit,
    'purpose' => $purpose,
    'departure_date' => $departureDate,
    'return_date' => $returnDate,
    'service_type' => $serviceType,
    'currency_code' => $currencyCode,
    'amount_required' => $amount,
    'delivery_method' => $deliveryMethod ?: null,
    'special_requirement' => $specialRequirement,
    'upload_token' => $uploadToken,
    'ip' => $ip,
    'created_at' => $now,
    'updated_at' => $now,
]);
$requestId = (int) $pdo->lastInsertId();

// Seed a placeholder checklist row for every document this destination requires,
// so forex-documents.php has something to render before any file is uploaded.
$requiredDocs = forex_required_docs_for_country($pdo, $countryVisit);
$docSeed = $pdo->prepare("INSERT INTO forex_documents (forex_request_id, doc_type, status, uploaded_at) VALUES (?, ?, 'Not Uploaded', NULL)");
foreach ($requiredDocs as $docType => $required) {
    if ($required) {
        $docSeed->execute([$requestId, $docType]);
    }
}

forex_log_status_change($pdo, $requestId, null, 'New Request', 'Customer', 'Submitted via public website enquiry form.');
forex_log_audit($pdo, $requestId, 'Customer', 'Customer', 'Forex enquiry submitted', '', $forexRef);
forex_notify($pdo, null, 'forex_new_request', "New Forex enquiry $forexRef from $fullName ($serviceType, $currencyCode $amount).", $requestId);

$scheme = (($_SERVER['HTTPS'] ?? '') === 'on') ? 'https://' : 'http://';
$host = $_SERVER['HTTP_HOST'] ?? 'visaagency.in';
$uploadUrl = "$scheme$host/forex-documents?ref=" . rawurlencode($forexRef) . '&token=' . rawurlencode($uploadToken);
$trackUrl = "$scheme$host/forex-track?ref=" . rawurlencode($forexRef);

$requestRow = ['id' => $requestId, 'email' => $email];
forex_notify_customer(
    $pdo, $requestRow,
    "Your Forex Enquiry Is Submitted — $forexRef",
    "Dear $fullName,\n\nThank you for your forex enquiry with VisaAgency.in.\n\n"
    . "Forex Reference: $forexRef\nService: $serviceType\nCurrency: $currencyCode $amount\nDestination: $countryVisit\nStatus: New Request\n\n"
    . "Please upload your supporting documents using the private link below:\n$uploadUrl\n\n"
    . "You can track this request anytime at:\n$trackUrl\n\n"
    . "Our forex team will confirm a quotation before anything is charged.\n\n"
    . "Regards,\nVisaAgency.in Forex Team"
);

echo json_encode([
    'success' => true,
    'forex_ref' => $forexRef,
    'upload_token' => $uploadToken,
    'submitted_date' => gmdate('d M Y'),
    'status' => 'New Request',
    'possible_duplicate_of' => $existingRef ?: null,
]);
