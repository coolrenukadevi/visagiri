<?php
declare(strict_types=1);

/**
 * Public PDF download for one forex_requests row — reached only via
 * the /forex/track/ page's own success card, POSTing the same
 * reference number + registered mobile number it just verified (a
 * hidden-field POST rather than a GET link, so the customer's mobile
 * number never ends up in a bookmarkable URL or server access log).
 * forex_requests has no customer-held token (every request is
 * staff-created — see database/schema-enquiry-pdf-downloads.sql), so
 * this reuses forex/track/index.php's own reference+mobile lookup as
 * the download gate instead.
 */

if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
    redirect('/forex/track/');
}

csrf_require();

if (!rate_limit_check('forex-track:' . ($_SERVER['REMOTE_ADDR'] ?? ''), 10, 900)) {
    render_not_found('Too many attempts. Please try again later.');
}

$reference = trim((string) ($_POST['reference'] ?? ''));
$mobile = trim((string) ($_POST['mobile'] ?? ''));

if ($reference === '' || $mobile === '') {
    render_not_found('Forex request not found.');
}

$stmt = db()->prepare(
    'SELECT fr.id, fr.forex_reference_no, fr.status, fr.currency_code, fr.amount_required, fr.country_of_visit,
            fr.purpose_of_travel, fr.departure_date, fr.return_date, fr.pdf_path, fr.created_at
     FROM forex_requests fr JOIN customers c ON c.id = fr.customer_id
     WHERE fr.forex_reference_no = :ref AND c.mobile = :mobile AND fr.deleted_at IS NULL'
);
$stmt->execute(['ref' => $reference, 'mobile' => $mobile]);
$row = $stmt->fetch();

if ($row === false) {
    render_not_found('Forex request not found. Please check your reference number and registered mobile number.');
}

$pdfPath = $row['pdf_path'] !== null ? __DIR__ . '/../' . $row['pdf_path'] : null;

if ($pdfPath === null || !is_file($pdfPath)) {
    try {
        $relativePath = build_forex_request_pdf($row);
        db()->prepare('UPDATE forex_requests SET pdf_path = :path WHERE id = :id')
            ->execute(['path' => $relativePath, 'id' => $row['id']]);
        $pdfPath = __DIR__ . '/../' . $relativePath;
    } catch (Throwable $e) {
        mail_log('[PDF] on-demand regeneration for forex request ' . $reference . ' failed: ' . $e->getMessage());
        http_response_code(503);
        exit('The PDF could not be generated right now. Please try again shortly.');
    }
}

$filename = 'Visagiri-Forex-' . preg_replace('/[^A-Za-z0-9\-]/', '', $reference) . '.pdf';

header('Content-Type: application/pdf');
header('Content-Disposition: attachment; filename="' . $filename . '"');
header('Content-Length: ' . filesize($pdfPath));
header('X-Content-Type-Options: nosniff');
readfile($pdfPath);
exit;
