<?php
/**
 * /employee/reports/export — streams the actual export file. Admin-gated
 * the same way employee-reports.php is; this endpoint does the real work,
 * that page is just the menu of links into it.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/employee_auth.php';
require_once __DIR__ . '/lib-php/enquiries.php';
require_once __DIR__ . '/lib-php/support.php';
require_once __DIR__ . '/lib-php/documents.php';
require_once __DIR__ . '/lib-php/customer_auth.php';
require_once __DIR__ . '/lib-php/xlsx_writer.php';
require_once __DIR__ . '/lib-php/pdf_writer.php';

auth_session_start();
$employee = employee_current();
if (!$employee) {
    header('Location: ' . url('/employee-login') . '?next=' . rawurlencode(auth_safe_next('/employee/reports')), true, 302);
    exit;
}
if (!$employee['is_admin']) {
    http_response_code(404);
    require __DIR__ . '/404.php';
    exit;
}

$format = (string) ($_GET['format'] ?? '');
$type = (string) ($_GET['type'] ?? '');

if ($format === 'pdf') {
    $pdf = new SimplePdf();
    $y = 800;
    $pdf->text(50, $y, 'Convercession - Summary Report', 'F2', 16); $y -= 18;
    $pdf->text(50, $y, 'Generated ' . date('j F Y, g:i a'), 'F1', 9); $y -= 20;
    $pdf->line(50, $y, 545, $y); $y -= 24;

    $section = static function (SimplePdf $pdf, string $title, array $counts, int &$y): void {
        $pdf->text(50, $y, $title, 'F2', 12); $y -= 16;
        if (!$counts) { $pdf->text(60, $y, '(no data yet)', 'F1', 10); $y -= 14; }
        foreach ($counts as $label => $n) {
            $pdf->text(60, $y, (string) $label, 'F1', 10);
            $pdf->text(480, $y, (string) $n, 'F1', 10);
            $y -= 14;
        }
        $y -= 10;
    };

    $section($pdf, 'Enquiries by Status (Total: ' . array_sum(enquiries_count_by_status()) . ')', enquiries_count_by_status(), $y);
    $section($pdf, 'Enquiries by Service', enquiries_count_by_service(), $y);
    $section($pdf, 'Support Tickets by Status (Total: ' . array_sum(tickets_count_by_status()) . ')', tickets_count_by_status(), $y);
    $section($pdf, 'Support Tickets by Category', tickets_count_by_category(), $y);
    $section($pdf, 'Documents by Status (Total: ' . array_sum(documents_count_by_status()) . ')', documents_count_by_status(), $y);
    $section($pdf, 'Customers by Status (Total: ' . array_sum(customers_count_by_status()) . ')', customers_count_by_status(), $y);

    $tmp = tempnam(sys_get_temp_dir(), 'cvrpt') . '.pdf';
    $pdf->save($tmp);
    header('Content-Type: application/pdf');
    header('Content-Disposition: attachment; filename="convercession-summary-' . date('Y-m-d') . '.pdf"');
    header('Content-Length: ' . filesize($tmp));
    readfile($tmp);
    @unlink($tmp);
    exit;
}

if (!in_array($type, ['enquiries', 'tickets'], true) || !in_array($format, ['csv', 'xlsx'], true)) {
    http_response_code(400);
    exit('Bad request.');
}

if ($type === 'enquiries') {
    $headers = ['Enquiry Code', 'Customer Name', 'Customer Code', 'Service', 'Country', 'Travel Purpose', 'Status', 'Assigned Consultant', 'Created'];
    $rows = array_map(static fn($e) => [
        $e['enquiry_code'], $e['customer_name'], $e['customer_code'], $e['service_label'], $e['country'],
        $e['travel_purpose'], $e['status'], $e['assigned_employee'] ?: '', date('Y-m-d H:i', (int) $e['created_at']),
    ], enquiries_all());
    $filenameBase = 'convercession-enquiries-' . date('Y-m-d');
} else {
    $headers = ['Ticket Code', 'Customer Name', 'Customer Code', 'Subject', 'Category', 'Status', 'Assigned Consultant', 'Created'];
    $rows = array_map(static fn($t) => [
        $t['ticket_code'], $t['customer_name'], $t['customer_code'], $t['subject'], $t['category'],
        $t['status'], $t['assigned_employee'] ?: '', date('Y-m-d H:i', (int) $t['created_at']),
    ], tickets_all());
    $filenameBase = 'convercession-tickets-' . date('Y-m-d');
}

if ($format === 'csv') {
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="' . $filenameBase . '.csv"');
    $out = fopen('php://output', 'w');
    fputcsv($out, $headers);
    foreach ($rows as $row) fputcsv($out, $row);
    fclose($out);
    exit;
}

// xlsx
$tmp = tempnam(sys_get_temp_dir(), 'cvxlsx') . '.xlsx';
xlsx_write($tmp, ucfirst($type), $headers, $rows);
header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
header('Content-Disposition: attachment; filename="' . $filenameBase . '.xlsx"');
header('Content-Length: ' . filesize($tmp));
readfile($tmp);
@unlink($tmp);
