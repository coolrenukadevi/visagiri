<?php
/**
 * AJAX customer lookup for the Forex request form's "Search Existing
 * Customer" step. Queries both enquiries and forex_requests (the CRM has no
 * normalized customers table — see the Forex plan's architecture notes) by
 * name/email/mobile/passport so staff don't re-type details for someone
 * already known to the CRM from either system.
 */
require_once __DIR__ . '/includes/admin-auth.php';
require_once __DIR__ . '/../includes/forex-db.php';
admin_require_login();
header('Content-Type: application/json');

$q = trim($_GET['q'] ?? '');
if (mb_strlen($q) < 2) {
    echo json_encode(['results' => []]);
    exit;
}

$pdo = forex_db();
$like = '%' . $q . '%';
$results = [];
$seen = [];

$enqStmt = $pdo->prepare("SELECT full_name, email, mobile, passport_number, nationality, country_residence AS state, current_city AS city
    FROM enquiries WHERE (full_name LIKE :q OR email LIKE :q OR mobile LIKE :q OR passport_number LIKE :q) AND archived_at IS NULL
    ORDER BY created_at DESC LIMIT 8");
$enqStmt->execute(['q' => $like]);
foreach ($enqStmt->fetchAll(PDO::FETCH_ASSOC) as $row) {
    $key = strtolower(($row['email'] ?: '') . '|' . ($row['mobile'] ?: ''));
    if (isset($seen[$key])) continue;
    $seen[$key] = true;
    $row['source'] = 'Visa Enquiry';
    $results[] = $row;
}

$fxStmt = $pdo->prepare("SELECT full_name, email, mobile, passport_number, nationality, date_of_birth, address, city, state, pin_code,
        pan_number, passport_issue_date, passport_expiry
    FROM forex_requests WHERE (full_name LIKE :q OR email LIKE :q OR mobile LIKE :q OR passport_number LIKE :q) AND archived_at IS NULL
    ORDER BY created_at DESC LIMIT 8");
$fxStmt->execute(['q' => $like]);
foreach ($fxStmt->fetchAll(PDO::FETCH_ASSOC) as $row) {
    $key = strtolower(($row['email'] ?: '') . '|' . ($row['mobile'] ?: ''));
    if (isset($seen[$key])) continue;
    $seen[$key] = true;
    $row['source'] = 'Forex Request';
    $results[] = $row;
}

echo json_encode(['results' => array_slice($results, 0, 10)]);
