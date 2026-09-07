<?php
declare(strict_types=1);

/**
 * Public PDF download for one enquiry — gated by knowing BOTH the
 * enquiry number and its tracking token (not sequential, not
 * guessable), so an enquiry number alone can't be used to pull
 * someone else's receipt. No admin login is required since this is
 * the customer's own copy, matching the public wizard's no-login
 * design throughout.
 */

require_once __DIR__ . '/../includes/enquiry.php';
require_once __DIR__ . '/../includes/pdf.php';

$ref = trim((string) ($_GET['ref'] ?? ''));
$token = trim((string) ($_GET['token'] ?? ''));

if ($ref === '' || $token === '') {
    render_not_found('Enquiry not found.');
}

$stmt = db()->prepare('SELECT id, pdf_path FROM enquiries WHERE enquiry_number = :ref AND tracking_token = :token AND deleted_at IS NULL');
$stmt->execute(['ref' => $ref, 'token' => $token]);
$row = $stmt->fetch();

if ($row === false) {
    render_not_found('Enquiry not found. Please check your enquiry number and tracking number.');
}

$pdfPath = $row['pdf_path'] !== null ? __DIR__ . '/../' . $row['pdf_path'] : null;

// Regenerate on demand if it was never created (e.g. generation
// failed at submission time) or the file has gone missing.
if ($pdfPath === null || !is_file($pdfPath)) {
    $enquiry = fetch_enquiry_full((int) $row['id']);
    $documents = fetch_enquiry_documents((int) $row['id']);
    try {
        $relativePath = build_enquiry_pdf($enquiry, $documents);
        db()->prepare('UPDATE enquiries SET pdf_path = :path, pdf_generated_at = NOW() WHERE id = :id')
            ->execute(['path' => $relativePath, 'id' => $row['id']]);
        $pdfPath = __DIR__ . '/../' . $relativePath;
    } catch (Throwable $e) {
        mail_log('[PDF] on-demand regeneration for ' . $ref . ' failed: ' . $e->getMessage());
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
