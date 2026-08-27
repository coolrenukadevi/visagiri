<?php
/** CSV export of the logged-in partner's own visa cases — tenant-scoped, mirrors admin/export.php's fputcsv pattern. */
require_once __DIR__ . '/includes/partner-auth.php';
partner_require_login();

$pdo = b2b_db();
$pid = partner_id();

$stmt = $pdo->prepare('SELECT enquiry_ref, full_name, email, mobile, destination_country, visa_type, travel_date, status, created_at
    FROM enquiries WHERE partner_id = ? ORDER BY created_at DESC');
$stmt->execute([$pid]);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

header('Content-Type: text/csv; charset=utf-8');
header('Content-Disposition: attachment; filename="my-visa-cases-' . gmdate('Ymd-His') . '.csv"');
$out = fopen('php://output', 'w');
fputcsv($out, ['Case Ref', 'Applicant', 'Email', 'Mobile', 'Destination', 'Visa Type', 'Travel Date', 'Status', 'Created']);
foreach ($rows as $r) {
    fputcsv($out, [$r['enquiry_ref'], $r['full_name'], $r['email'], $r['mobile'], $r['destination_country'], $r['visa_type'], $r['travel_date'], $r['status'], $r['created_at']]);
}
fclose($out);
