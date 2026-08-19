<?php
require_once __DIR__ . '/includes/admin-auth.php';
admin_require_login();

$status = trim($_GET['status'] ?? '');
$visaCategory = trim($_GET['visa_category'] ?? '');
$country = trim($_GET['country'] ?? '');
$assignedTo = trim($_GET['assigned_to'] ?? '');
$priority = trim($_GET['priority'] ?? '');
$source = trim($_GET['source'] ?? '');
$search = trim($_GET['q'] ?? '');
$mine = isset($_GET['mine']);

$where = ['e.archived_at IS NULL'];
$params = [];
if (!admin_can_view_all() || $mine) { $where[] = 'e.assigned_to = :me'; $params['me'] = admin_name(); }
if ($status !== '') { $where[] = 'e.status = :status'; $params['status'] = $status; }
if ($visaCategory !== '') { $where[] = 'e.visa_category = :visa_category'; $params['visa_category'] = $visaCategory; }
if ($country !== '') { $where[] = 'e.destination_country = :country'; $params['country'] = $country; }
if ($assignedTo !== '') { $where[] = 'e.assigned_to = :assigned_to'; $params['assigned_to'] = $assignedTo; }
if ($priority !== '') { $where[] = 'e.priority = :priority'; $params['priority'] = $priority; }
if ($source !== '') { $where[] = 'e.source = :source'; $params['source'] = $source; }
if ($search !== '') {
    $where[] = '(e.full_name LIKE :q OR e.email LIKE :q OR e.mobile LIKE :q OR e.enquiry_ref LIKE :q)';
    $params['q'] = '%' . $search . '%';
}

$pdo = enquiry_db();
$stmt = $pdo->prepare('SELECT enquiry_ref, full_name, email, mobile, destination_country, visa_type, travel_date,
    status, priority, assigned_to, source, created_at FROM enquiries e WHERE ' . implode(' AND ', $where) . ' ORDER BY created_at DESC');
$stmt->execute($params);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

header('Content-Type: text/csv; charset=utf-8');
header('Content-Disposition: attachment; filename="enquiries-' . gmdate('Ymd-His') . '.csv"');
$out = fopen('php://output', 'w');
fputcsv($out, ['Enquiry ID', 'Customer', 'Email', 'Mobile', 'Country', 'Visa Type', 'Travel Date', 'Status', 'Priority', 'Assigned To', 'Source', 'Created']);
foreach ($rows as $r) {
    fputcsv($out, [$r['enquiry_ref'], $r['full_name'], $r['email'], $r['mobile'], $r['destination_country'], $r['visa_type'], $r['travel_date'], $r['status'], $r['priority'], $r['assigned_to'], $r['source'], $r['created_at']]);
}
fclose($out);
