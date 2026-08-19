<?php
require_once __DIR__ . '/includes/admin-auth.php';
admin_require_login();
header('Content-Type: application/json');

$q = trim($_GET['q'] ?? '');
if (mb_strlen($q) < 2) {
    echo json_encode(['results' => []]);
    exit;
}

$pdo = enquiry_db();
$like = '%' . $q . '%';
$sql = 'SELECT enquiry_ref, full_name, mobile, email, passport_number, destination_country, visa_type, assigned_to
    FROM enquiries
    WHERE enquiry_ref LIKE :q OR full_name LIKE :q OR mobile LIKE :q OR email LIKE :q
       OR passport_number LIKE :q OR destination_country LIKE :q OR visa_type LIKE :q';
$params = ['q' => $like];
if (!admin_can_view_all()) {
    $sql .= ' AND assigned_to = :me';
    $params['me'] = admin_name();
}
$sql .= ' ORDER BY created_at DESC LIMIT 10';

$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

$results = array_map(function ($r) {
    return [
        'ref' => $r['enquiry_ref'],
        'name' => htmlspecialchars($r['full_name']),
        'mobile' => htmlspecialchars($r['mobile']),
        'destination' => htmlspecialchars($r['destination_country']),
    ];
}, $rows);

echo json_encode(['results' => $results]);
