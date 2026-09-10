<?php
declare(strict_types=1);

/**
 * Public PDF download for one general_enquiries row (the
 * pages/contact.php Visa/Attestation/Forex/Travel/General service-type
 * form) — gated by knowing BOTH the reference number and its tracking
 * token, same non-enumerating two-factor pattern as
 * pages/enquiry-pdf-download.php. No admin login required, since this
 * is the customer's own copy.
 */

$ref = trim((string) ($_GET['ref'] ?? ''));
$token = trim((string) ($_GET['token'] ?? ''));

if ($ref === '' || $token === '') {
    render_not_found('Enquiry not found.');
}

$stmt = db()->prepare(
    'SELECT id, enquiry_reference_no, tracking_token, service_type, name, email, phone, subject, description, status, pdf_path, created_at
     FROM general_enquiries WHERE enquiry_reference_no = :ref AND tracking_token = :token AND deleted_at IS NULL'
);
$stmt->execute(['ref' => $ref, 'token' => $token]);
$row = $stmt->fetch();

if ($row === false) {
    render_not_found('Enquiry not found. Please check your reference number and tracking number.');
}

$pdfPath = $row['pdf_path'] !== null ? __DIR__ . '/../' . $row['pdf_path'] : null;

// Regenerate on demand if it was never created (e.g. generation failed
// at submission time) or the file has gone missing.
if ($pdfPath === null || !is_file($pdfPath)) {
    try {
        $relativePath = build_general_enquiry_pdf($row);
        db()->prepare('UPDATE general_enquiries SET pdf_path = :path WHERE id = :id')
            ->execute(['path' => $relativePath, 'id' => $row['id']]);
        $pdfPath = __DIR__ . '/../' . $relativePath;
    } catch (Throwable $e) {
        mail_log('[PDF] on-demand regeneration for general enquiry ' . $ref . ' failed: ' . $e->getMessage());
        http_response_code(503);
        exit('The PDF could not be generated right now. Please try again shortly.');
    }
}

$filename = 'Visagiri-Enquiry-' . preg_replace('/[^A-Za-z0-9\-]/', '', $ref) . '.pdf';

header('Content-Type: application/pdf');
header('Content-Disposition: attachment; filename="' . $filename . '"');
header('Content-Length: ' . filesize($pdfPath));
header('X-Content-Type-Options: nosniff');
readfile($pdfPath);
exit;
