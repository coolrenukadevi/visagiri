<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/enquiry.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: ' . url('index.php'));
    exit;
}

if (!csrf_verify($_POST['csrf_token'] ?? null)) {
    flash_set('error', 'Your session expired — please try submitting again.');
    header('Location: ' . url('index.php') . '#enquiry');
    exit;
}

$serviceType = $_POST['service_type'] ?? '';
if (!in_array($serviceType, VALID_SERVICE_TYPES, true)) {
    flash_set('error', 'Please choose a valid service.');
    header('Location: ' . url('index.php') . '#enquiry');
    exit;
}

$customer = [
    'name' => trim($_POST['name'] ?? ''),
    'email' => trim($_POST['email'] ?? ''),
    'mobile' => trim($_POST['mobile'] ?? ''),
    'nationality' => trim($_POST['nationality'] ?? ''),
];

if ($customer['name'] === '') {
    flash_set('error', 'Please enter your name.');
    header('Location: ' . url('index.php') . '#enquiry');
    exit;
}
if ($customer['mobile'] === '' && !filter_var($customer['email'], FILTER_VALIDATE_EMAIL)) {
    flash_set('error', 'Please provide a valid email or mobile number so we can reach you.');
    header('Location: ' . url('index.php') . '#enquiry');
    exit;
}

$fieldMap = [
    'visa' => ['country', 'visa_category_id', 'travel_date', 'travellers_count', 'nationality'],
    'hotel' => ['destination', 'check_in', 'check_out', 'rooms', 'adults', 'children', 'hotel_category', 'budget'],
    'flight' => ['from_city', 'to_city', 'departure_date', 'return_date', 'trip_type', 'adults', 'children', 'cabin_class'],
    'tour' => ['destination', 'travel_date', 'duration', 'travellers', 'budget'],
    'insurance' => ['destination', 'travel_start', 'travel_end', 'traveller_count', 'traveller_ages', 'insurance_type'],
    'forex' => ['currency', 'amount', 'travel_country', 'travel_date', 'forex_type', 'delivery_pref'],
    'general' => ['subject', 'message'],
];

$serviceData = [];
foreach ($fieldMap[$serviceType] as $field) {
    $serviceData[$field] = trim((string) ($_POST[$field] ?? ''));
}

if ($serviceType === 'visa' && $serviceData['country'] !== '') {
    $countryRow = db()->prepare('SELECT id, name FROM countries WHERE slug = ?');
    $countryRow->execute([$serviceData['country']]);
    if ($match = $countryRow->fetch()) {
        $serviceData['country_id'] = $match['id'];
        $serviceData['destination'] = $match['name'];
    }
}

try {
    $result = create_enquiry($serviceType, $customer, $serviceData, 'Website');
    header('Location: ' . url('thank-you.php') . '?ref=' . urlencode($result['reference_no']));
    exit;
} catch (Throwable $e) {
    flash_set('error', 'We could not submit your enquiry right now — please try again or call us directly.');
    header('Location: ' . url('index.php') . '#enquiry');
    exit;
}
