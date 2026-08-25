<?php
declare(strict_types=1);

/**
 * Authenticated document download. Read-only — verification status
 * changes happen via the owning module's CSRF-protected POST handler
 * (visa-applications.php / general-enquiries.php), not here.
 */

$id = (int) ($_GET['id'] ?? 0);
if (!$id) {
    http_response_code(404);
    exit('Document not found.');
}

$stmt = db()->prepare('SELECT * FROM documents WHERE id = :id AND deleted_at IS NULL');
$stmt->execute(['id' => $id]);
$document = $stmt->fetch();

if (!$document) {
    http_response_code(404);
    exit('Document not found.');
}

$admin = current_admin();
$canView = has_permission('documents.upload') || has_permission('documents.verify') || has_permission('visa.view') || has_permission('general_enquiries.view');
if (!$canView) {
    http_response_code(403);
    exit('You do not have permission to view this document.');
}
if (current_admin_scoped_to_assigned() && $document['visa_application_id']) {
    $ownerStmt = db()->prepare('SELECT assigned_user FROM visa_applications WHERE id = :id');
    $ownerStmt->execute(['id' => $document['visa_application_id']]);
    if ((int) $ownerStmt->fetchColumn() !== current_admin_id()) {
        http_response_code(403);
        exit('This document is not on an application assigned to you.');
    }
}

$path = __DIR__ . '/../../' . $document['storage_path'];
if (!is_file($path)) {
    http_response_code(404);
    exit('File is missing from storage.');
}

header('Content-Type: ' . $document['mime_type']);
header('Content-Disposition: attachment; filename="' . rawurlencode($document['original_filename']) . '"');
header('Content-Length: ' . (string) filesize($path));
header('X-Content-Type-Options: nosniff');
readfile($path);
exit;
