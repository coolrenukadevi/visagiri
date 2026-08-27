<?php
/**
 * Minimal first-party analytics beacon for the Get Assistance widget and
 * floating contact button. No third-party analytics platform exists in
 * this codebase, so this is a real, self-hosted event log — not a fake
 * tracking claim — and it deliberately never stores personal details
 * (name/email/mobile), only event type, service/purpose and page.
 */

require_once __DIR__ . '/includes/enquiry-db.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false]);
    exit;
}

// navigator.sendBeacon(url, URLSearchParams) is spec'd to send
// application/x-www-form-urlencoded, which PHP auto-parses into $_POST —
// but not every browser is consistent, so fall back to parsing the raw
// body if $_POST came back empty.
$data = $_POST;
if (empty($data)) {
    $raw = file_get_contents('php://input');
    if ($raw !== false && $raw !== '') {
        parse_str($raw, $data);
    }
}

$allowedEvents = [
    'get_assistance_click', 'service_selected', 'purpose_selected', 'form_started',
    'form_completed', 'form_abandoned', 'whatsapp_click', 'call_click', 'email_click',
];
$eventType = trim($data['event_type'] ?? '');
if (!in_array($eventType, $allowedEvents, true)) {
    http_response_code(204);
    exit;
}

$pdo = enquiry_db();

// A same-session marker only (not a persistent user identifier) so a
// single burst from one visitor doesn't look like many different people.
session_start();
if (empty($_SESSION['qe_session_id'])) {
    $_SESSION['qe_session_id'] = bin2hex(random_bytes(8));
}

$pdo->prepare('INSERT INTO enquiry_analytics_events (event_type, service, purpose, page_url, session_id, created_at) VALUES (?, ?, ?, ?, ?, ?)')
    ->execute([
        $eventType,
        substr(trim($data['service'] ?? ''), 0, 60),
        substr(trim($data['purpose'] ?? ''), 0, 60),
        substr(trim($data['page_url'] ?? ''), 0, 300),
        $_SESSION['qe_session_id'],
        gmdate('c'),
    ]);

http_response_code(204);
