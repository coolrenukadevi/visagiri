<?php
/**
 * POST /enquire — the "Enquire Now" dialog's submit target. JSON in, JSON
 * out, so the dialog can show a result without a full page reload. No GET
 * view of its own; the dialog itself lives in includes/enquire-now.php,
 * included from the footer on every page.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/customer_auth.php';
require_once __DIR__ . '/lib-php/enquiries.php';

header('Content-Type: application/json');
header('Cache-Control: no-store, private');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: ' . url('/'), true, 302);
    exit;
}

$respond = static function (array $body, int $status = 200): never {
    http_response_code($status);
    echo json_encode($body);
    exit;
};

auth_session_start();
$customer = customer_current();
if (!$customer) {
    $respond(['ok' => false, 'error' => 'Please sign in with your Customer ID first.'], 401);
}
if (!auth_csrf_valid($_POST['csrf'] ?? null)) {
    $respond(['ok' => false, 'error' => 'Your session expired — please refresh the page and try again.'], 419);
}

$serviceTypeId = (int) ($_POST['service_type_id'] ?? 0);
$country = trim((string) ($_POST['country'] ?? ''));
$purpose = trim((string) ($_POST['travel_purpose'] ?? ''));
$travelDate = trim((string) ($_POST['travel_date'] ?? ''));
$message = trim((string) ($_POST['message'] ?? ''));

$countries = json_decode((string) file_get_contents(ROOT_PATH . '/data/all-countries.json'), true) ?: [];
$purposes = ['Tourism', 'Business', 'Study', 'Employment', 'Medical', 'Family Visit', 'Conference', 'Other'];

if (!service_type_find($serviceTypeId)) {
    $respond(['ok' => false, 'error' => 'Choose a service.']);
}
if (!in_array($country, $countries, true)) {
    $respond(['ok' => false, 'error' => 'Choose a destination country from the list.']);
}
if (!in_array($purpose, $purposes, true)) {
    $respond(['ok' => false, 'error' => 'Choose a travel purpose.']);
}
if ($travelDate !== '') {
    $d = DateTime::createFromFormat('Y-m-d', $travelDate);
    if (!$d || $d->format('Y-m-d') !== $travelDate) {
        $respond(['ok' => false, 'error' => 'Enter a valid travel date.']);
    }
}
if (strlen($message) > 2000) {
    $respond(['ok' => false, 'error' => 'Message is too long.']);
}

[$id, $err, $code] = enquiry_create((int) $customer['id'], [
    'service_type_id' => $serviceTypeId,
    'country' => $country,
    'travel_purpose' => $purpose,
    'travel_date' => $travelDate,
    'message' => $message,
]);

if (!$id) {
    $respond(['ok' => false, 'error' => $err], 500);
}
$respond(['ok' => true, 'code' => $code, 'url' => url('/enquiry/' . $code)]);
