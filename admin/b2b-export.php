<?php
/** CSV exports for the B2B Partner Reports page — mirrors admin/export.php's fputcsv pattern. */
require_once __DIR__ . '/includes/admin-auth.php';
require_once __DIR__ . '/includes/b2b-permissions.php';
require_once __DIR__ . '/../includes/b2b-db.php';
admin_require_login();

$pdo = b2b_db();
[$scopeSql, $scopeParams] = b2b_scope_sql();
$baseScope = 'archived_at IS NULL' . $scopeSql;
$type = trim($_GET['type'] ?? 'partners');

if ($type === 'audit') {
    if (!b2b_can_export_audit()) {
        http_response_code(403);
        exit('You do not have permission to export the B2B audit log.');
    }
    $entityType = trim($_GET['entity_type'] ?? '');
    $q = trim($_GET['q'] ?? '');
    $dateFrom = trim($_GET['from'] ?? '');
    $dateTo = trim($_GET['to'] ?? '');

    $where = [];
    $auditParams = [];
    if ($entityType !== '') { $where[] = 'entity_type = :entity_type'; $auditParams['entity_type'] = $entityType; }
    if ($q !== '') {
        $where[] = '(action LIKE :q OR previous_value LIKE :q OR new_value LIKE :q OR user_name LIKE :q)';
        $auditParams['q'] = '%' . $q . '%';
    }
    if ($dateFrom !== '') { $where[] = 'created_at >= :from'; $auditParams['from'] = $dateFrom . 'T00:00:00+00:00'; }
    if ($dateTo !== '') { $where[] = 'created_at <= :to'; $auditParams['to'] = $dateTo . 'T23:59:59+00:00'; }
    $whereSql = $where ? 'WHERE ' . implode(' AND ', $where) : '';

    $stmt = $pdo->prepare("SELECT * FROM b2b_audit_logs $whereSql ORDER BY id DESC LIMIT 5000");
    $stmt->execute($auditParams);
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="b2b-audit-log-' . gmdate('Ymd-His') . '.csv"');
    $out = fopen('php://output', 'w');
    fputcsv($out, ['When', 'Entity Type', 'Entity ID', 'Action', 'Previous Value', 'New Value', 'By', 'Role', 'IP Address']);
    foreach ($rows as $r) {
        fputcsv($out, [$r['created_at'], $r['entity_type'], $r['entity_id'], $r['action'], $r['previous_value'], $r['new_value'], $r['user_name'], $r['role'], $r['ip_address']]);
    }
    fclose($out);
    exit;
}

if ($type === 'performance') {
    $canViewFinancials = b2b_can_view_financials();
    $stmt = $pdo->prepare("SELECT p.application_ref, p.company_name, p.status, p.tier, p.country,
            (SELECT COUNT(*) FROM enquiries e WHERE e.partner_id = p.id) AS case_count,
            (SELECT COUNT(*) FROM b2b_quotations q WHERE q.partner_id = p.id AND q.status != 'Draft') AS quotes_sent,
            (SELECT COUNT(*) FROM b2b_quotations q WHERE q.partner_id = p.id AND q.status = 'Accepted') AS quotes_accepted,
            (SELECT COUNT(*) FROM b2b_invoices i WHERE i.partner_id = p.id) AS invoice_count,
            (SELECT COALESCE(SUM(ip.amount), 0) FROM b2b_invoice_payments ip JOIN b2b_invoices i ON i.id = ip.invoice_id WHERE i.partner_id = p.id) AS revenue,
            p.wallet_balance
        FROM b2b_partners p WHERE p.$baseScope ORDER BY p.company_name");
    $stmt->execute($scopeParams);
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="b2b-partner-performance-' . gmdate('Ymd-His') . '.csv"');
    $out = fopen('php://output', 'w');
    $headers = ['Partner ID', 'Company', 'Status', 'Tier', 'Country', 'Visa Cases', 'Quotations Sent', 'Quotations Accepted', 'Invoices Raised'];
    if ($canViewFinancials) { $headers[] = 'Revenue Collected'; $headers[] = 'Wallet Balance'; }
    fputcsv($out, $headers);
    foreach ($rows as $r) {
        $row = [$r['application_ref'], $r['company_name'], $r['status'], $r['tier'], $r['country'], $r['case_count'], $r['quotes_sent'], $r['quotes_accepted'], $r['invoice_count']];
        if ($canViewFinancials) { $row[] = number_format((float) $r['revenue'], 2); $row[] = number_format((float) $r['wallet_balance'], 2); }
        fputcsv($out, $row);
    }
    fclose($out);
    exit;
}

// Default: full partner list.
$stmt = $pdo->prepare("SELECT p.*, u.name AS manager_name FROM b2b_partners p
    LEFT JOIN users u ON u.id = p.assigned_manager_id WHERE p.$baseScope ORDER BY p.created_at DESC");
$stmt->execute($scopeParams);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

header('Content-Type: text/csv; charset=utf-8');
header('Content-Disposition: attachment; filename="b2b-partners-' . gmdate('Ymd-His') . '.csv"');
$out = fopen('php://output', 'w');
fputcsv($out, ['Partner ID', 'Company', 'Business Type', 'Contact Name', 'Email', 'Mobile', 'City', 'Country', 'IATA Registered', 'Status', 'Tier', 'Manager', 'Registered']);
foreach ($rows as $r) {
    fputcsv($out, [
        $r['application_ref'], $r['company_name'], $r['business_type'], $r['contact_name'], $r['contact_email'], $r['contact_mobile'],
        $r['city'], $r['country'], $r['iata_registered'] ? 'Yes' : 'No', $r['status'], $r['tier'], $r['manager_name'] ?: 'Unassigned', substr($r['created_at'], 0, 10),
    ]);
}
fclose($out);
