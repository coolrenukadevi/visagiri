<?php
require_once __DIR__ . '/includes/admin-auth.php';
admin_require_login();
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed.']);
    exit;
}

$fullName = trim($_POST['full_name'] ?? '');
$email = trim($_POST['email'] ?? '');
$mobile = trim($_POST['mobile'] ?? '');
$destinationCountry = trim($_POST['destination_country'] ?? '');
$visaCategory = trim($_POST['visa_category'] ?? '');
$visaType = trim($_POST['visa_type'] ?? '');
$travelDate = trim($_POST['travel_date'] ?? '');
$travellers = filter_var($_POST['travellers'] ?? '', FILTER_VALIDATE_INT);
$source = trim($_POST['source'] ?? 'Website');

if ($fullName === '' || !filter_var($email, FILTER_VALIDATE_EMAIL) || $mobile === ''
    || $destinationCountry === '' || $visaCategory === '' || $visaType === ''
    || $travelDate === '' || !$travellers || $travellers < 1) {
    echo json_encode(['success' => false, 'message' => 'Please fill in all required fields correctly.']);
    exit;
}

$pdo = enquiry_db();
$enquiryRef = enquiry_generate_ref($pdo, $visaCategory);
$trackingCode = crm_generate_tracking_code($pdo);
$now = gmdate('c');

$fields = [
    'enquiry_ref' => $enquiryRef,
    'tracking_code' => $trackingCode,
    'full_name' => $fullName,
    'email' => $email,
    'mobile' => $mobile,
    'whatsapp_number' => trim($_POST['whatsapp_number'] ?? ''),
    'date_of_birth' => trim($_POST['date_of_birth'] ?? '') ?: null,
    'gender' => trim($_POST['gender'] ?? ''),
    'nationality' => trim($_POST['nationality'] ?? ''),
    'passport_number' => trim($_POST['passport_number'] ?? ''),
    'passport_expiry' => trim($_POST['passport_expiry'] ?? '') ?: null,
    'current_city' => trim($_POST['current_city'] ?? ''),
    'country_residence' => trim($_POST['country_residence'] ?? ''),
    'visa_category' => $visaCategory,
    'service_required' => $visaCategory,
    'destination_country' => $destinationCountry,
    'visa_type' => $visaType,
    'purpose' => trim($_POST['purpose'] ?? ''),
    'travel_date' => $travelDate,
    'expected_stay_duration' => trim($_POST['expected_stay_duration'] ?? ''),
    'travellers' => $travellers,
    'previous_visa_history' => trim($_POST['previous_visa_history'] ?? ''),
    'previous_refusal' => trim($_POST['previous_refusal'] ?? ''),
    'urgency' => trim($_POST['urgency'] ?? 'Normal'),
    'departure_city' => trim($_POST['departure_city'] ?? ''),
    'arrival_city' => trim($_POST['arrival_city'] ?? ''),
    'flight_status' => trim($_POST['flight_status'] ?? ''),
    'hotel_required' => trim($_POST['hotel_required'] ?? ''),
    'insurance_required' => trim($_POST['insurance_required'] ?? ''),
    'invitation_letter' => trim($_POST['invitation_letter'] ?? ''),
    'sponsorship' => trim($_POST['sponsorship'] ?? ''),
    'accommodation_details' => trim($_POST['accommodation_details'] ?? ''),
    'source' => $source,
    'campaign' => trim($_POST['campaign'] ?? ''),
    'referral_name' => trim($_POST['referral_name'] ?? ''),
    'partner' => trim($_POST['partner'] ?? ''),
    'assigned_to' => trim($_POST['assigned_to'] ?? ''),
    'visa_consultant' => trim($_POST['visa_consultant'] ?? ''),
    'priority' => trim($_POST['priority'] ?? 'Medium'),
    'estimated_value' => $_POST['estimated_value'] !== '' ? (float) $_POST['estimated_value'] : null,
    'conversion_probability' => $_POST['conversion_probability'] !== '' ? (int) $_POST['conversion_probability'] : null,
    'message' => trim($_POST['message'] ?? ''),
    'status' => 'New Enquiry',
    'ip_address' => $_SERVER['REMOTE_ADDR'] ?? '',
    'user_agent' => substr($_SERVER['HTTP_USER_AGENT'] ?? '', 0, 300),
    'created_at' => $now,
    'updated_at' => $now,
];

$columns = implode(', ', array_keys($fields));
$placeholders = ':' . implode(', :', array_keys($fields));
$insert = $pdo->prepare("INSERT INTO enquiries ($columns) VALUES ($placeholders)");
$insert->execute($fields);
$enquiryId = (int) $pdo->lastInsertId();

crm_log_activity($pdo, $enquiryId, admin_name(), 'created this enquiry', 'Added manually via the CRM.');
crm_log_status_change($pdo, $enquiryId, null, 'New Enquiry', admin_name(), 'Your enquiry has been received and registered with our visa management team.');
if (filter_var($fullName !== '' ? $email : '', FILTER_VALIDATE_EMAIL)) {
    crm_send_applicant_email(
        $email,
        "Your Visa Enquiry is Registered — $trackingCode",
        "Dear $fullName,\n\nYour visa enquiry has been successfully registered with our visa management team.\n\n" .
        "Tracking Code: $trackingCode\nVisa Country: $destinationCountry\nVisa Type: $visaType\n\n" .
        "Please save this Tracking Code. Use your Tracking Code, Passport Number and registered Mobile Number or Email Address to track your application status at any time:\n" .
        (($_SERVER['HTTPS'] ?? '') === 'on' ? 'https://' : 'http://') . ($_SERVER['HTTP_HOST'] ?? 'visaagency.in') . "/track-application\n\n" .
        "Regards,\nVisaAgency.in"
    );
}
if (!empty($fields['assigned_to'])) {
    crm_log_activity($pdo, $enquiryId, admin_name(), 'assigned to ' . $fields['assigned_to']);
    $assignee = $pdo->prepare('SELECT id FROM users WHERE name = ?');
    $assignee->execute([$fields['assigned_to']]);
    $assigneeId = $assignee->fetchColumn();
    if ($assigneeId) {
        crm_notify($pdo, (int) $assigneeId, 'assignment', "New enquiry $enquiryRef assigned to you.", $enquiryId);
    }
}
crm_notify($pdo, null, 'new_enquiry', "New enquiry $enquiryRef created for $fullName.", $enquiryId);

// ---- Document uploads ----
$allowedExt = ['pdf', 'jpg', 'jpeg', 'png'];
$allowedMime = ['application/pdf', 'image/jpeg', 'image/png'];
$maxBytes = 5 * 1024 * 1024;
$targetDir = __DIR__ . '/../uploads/enquiries/' . $enquiryRef;
$docInsert = $pdo->prepare('INSERT INTO enquiry_documents
    (enquiry_id, category, original_filename, stored_filename, file_type, file_size, status, uploaded_at)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?)');
$finfo = new finfo(FILEINFO_MIME_TYPE);
$docCount = 0;

foreach ($_FILES as $fieldName => $fileGroup) {
    if (strpos($fieldName, 'doc_') !== 0) continue;
    $index = (int) substr($fieldName, 4);
    $category = CRM_DOC_CATEGORIES[$index] ?? 'Other Documents';
    $count = is_array($fileGroup['name']) ? count($fileGroup['name']) : 1;
    for ($i = 0; $i < $count; $i++) {
        $name = is_array($fileGroup['name']) ? $fileGroup['name'][$i] : $fileGroup['name'];
        $tmp = is_array($fileGroup['tmp_name']) ? $fileGroup['tmp_name'][$i] : $fileGroup['tmp_name'];
        $error = is_array($fileGroup['error']) ? $fileGroup['error'][$i] : $fileGroup['error'];
        $size = is_array($fileGroup['size']) ? $fileGroup['size'][$i] : $fileGroup['size'];
        if ($error === UPLOAD_ERR_NO_FILE || $error !== UPLOAD_ERR_OK) continue;
        if ($size > $maxBytes) continue;
        $ext = strtolower(pathinfo($name, PATHINFO_EXTENSION));
        $mime = $finfo->file($tmp) ?: '';
        if (!in_array($ext, $allowedExt, true) || !in_array($mime, $allowedMime, true)) continue;
        if (!is_dir($targetDir)) mkdir($targetDir, 0770, true);
        $stored = bin2hex(random_bytes(10)) . '.' . $ext;
        if (!move_uploaded_file($tmp, $targetDir . '/' . $stored)) continue;
        $docInsert->execute([$enquiryId, $category, $name, $stored, $mime, $size, 'Uploaded', gmdate('c')]);
        $docCount++;
    }
}
if ($docCount > 0) {
    crm_log_activity($pdo, $enquiryId, admin_name(), "uploaded $docCount document(s)");
}

echo json_encode(['success' => true, 'enquiry_ref' => $enquiryRef]);
