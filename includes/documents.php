<?php
declare(strict_types=1);

/**
 * Secure document storage. Files land in storage/documents/ — a
 * sibling of includes/, genuinely outside the web root in the
 * two-folder layout and blocked by public/.htaccess's
 * includes|config|storage deny rule in the flattened cPanel package
 * (see bin/package-cpanel.sh). Nothing here is ever served by a
 * direct URL; downloads go through admin/pages/document-download.php,
 * which checks admin auth + permission before streaming a file.
 *
 * No public customer upload portal exists in this project — every
 * document is uploaded by a logged-in staff member on behalf of a
 * visa application or general enquiry, so uploaded_by is always a
 * real admin_users id.
 */

const DOCUMENTS_STORAGE_DIR = __DIR__ . '/../storage/documents';

/** Extension => allowed MIME types. Deliberately excludes anything executable. */
const DOCUMENT_ALLOWED_TYPES = [
    'pdf' => ['application/pdf'],
    'jpg' => ['image/jpeg'],
    'jpeg' => ['image/jpeg'],
    'png' => ['image/png'],
    'doc' => ['application/msword'],
    'docx' => ['application/vnd.openxmlformats-officedocument.wordprocessingml.document'],
];

const DOCUMENT_MAX_BYTES = 10 * 1024 * 1024; // 10MB

/**
 * Validates a single $_FILES entry. Returns an error message, or null
 * if the upload is safe to store. Never trusts the client-supplied
 * MIME type or original filename/extension alone — the actual file
 * content is inspected with finfo.
 */
function validate_document_upload(array $file): ?string
{
    if (($file['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_OK) {
        return match ($file['error']) {
            UPLOAD_ERR_INI_SIZE, UPLOAD_ERR_FORM_SIZE => 'File is too large.',
            UPLOAD_ERR_NO_FILE => 'No file was selected.',
            default => 'Upload failed. Please try again.',
        };
    }

    if (!is_uploaded_file($file['tmp_name'])) {
        return 'Invalid upload.';
    }

    if ($file['size'] <= 0 || $file['size'] > DOCUMENT_MAX_BYTES) {
        return 'File must be under 10MB.';
    }

    $originalName = (string) $file['name'];
    $extension = strtolower(pathinfo($originalName, PATHINFO_EXTENSION));
    if (!isset(DOCUMENT_ALLOWED_TYPES[$extension])) {
        return 'File type not allowed. Accepted: PDF, JPG, PNG, DOC, DOCX.';
    }

    $finfo = finfo_open(FILEINFO_MIME_TYPE);
    $actualMime = finfo_file($finfo, $file['tmp_name']);
    finfo_close($finfo);

    if ($actualMime === false || !in_array($actualMime, DOCUMENT_ALLOWED_TYPES[$extension], true)) {
        return "File content doesn't match its extension — upload rejected.";
    }

    return null;
}

/**
 * Stores an already-validated upload: moves it into storage/documents/
 * under a randomized filename (never trusts or reuses the original
 * name), inserts the documents row, and returns the new row's id.
 */
function store_document_upload(
    array $file,
    ?string $documentType,
    ?int $customerId,
    ?int $visaApplicationId,
    ?int $generalEnquiryId,
    int $uploadedBy
): int {
    if (!is_dir(DOCUMENTS_STORAGE_DIR)) {
        mkdir(DOCUMENTS_STORAGE_DIR, 0755, true);
    }

    $originalName = (string) $file['name'];
    $extension = strtolower(pathinfo($originalName, PATHINFO_EXTENSION));
    $storedFilename = bin2hex(random_bytes(24)) . '.' . $extension;
    $destination = DOCUMENTS_STORAGE_DIR . '/' . $storedFilename;

    if (!move_uploaded_file($file['tmp_name'], $destination)) {
        throw new RuntimeException('Failed to store uploaded file.');
    }

    $finfo = finfo_open(FILEINFO_MIME_TYPE);
    $mimeType = finfo_file($finfo, $destination) ?: 'application/octet-stream';
    finfo_close($finfo);

    $stmt = db()->prepare(
        'INSERT INTO documents (customer_id, visa_application_id, general_enquiry_id, document_type, original_filename, stored_filename, storage_path, mime_type, file_size, uploaded_by)
         VALUES (:customer_id, :application_id, :enquiry_id, :doc_type, :original_name, :stored_name, :storage_path, :mime, :size, :uploaded_by)'
    );
    $stmt->execute([
        'customer_id' => $customerId,
        'application_id' => $visaApplicationId,
        'enquiry_id' => $generalEnquiryId,
        'doc_type' => $documentType,
        'original_name' => basename($originalName),
        'stored_name' => $storedFilename,
        'storage_path' => 'storage/documents/' . $storedFilename,
        'mime' => $mimeType,
        'size' => $file['size'],
        'uploaded_by' => $uploadedBy,
    ]);

    return (int) db()->lastInsertId();
}

/**
 * Same storage/validation path as store_document_upload(), but for a
 * document the customer uploaded themselves through the dashboard —
 * sets uploaded_by_customer_id instead of uploaded_by (admin), which
 * the schema-customer-partner-portal.sql migration made nullable
 * specifically for this. Always tied to one of the customer's own
 * applications; never to a general enquiry (customers don't have a
 * dashboard view of those).
 */
function store_customer_document_upload(
    array $file,
    ?string $documentType,
    int $customerId,
    int $visaApplicationId
): int {
    if (!is_dir(DOCUMENTS_STORAGE_DIR)) {
        mkdir(DOCUMENTS_STORAGE_DIR, 0755, true);
    }

    $originalName = (string) $file['name'];
    $extension = strtolower(pathinfo($originalName, PATHINFO_EXTENSION));
    $storedFilename = bin2hex(random_bytes(24)) . '.' . $extension;
    $destination = DOCUMENTS_STORAGE_DIR . '/' . $storedFilename;

    if (!move_uploaded_file($file['tmp_name'], $destination)) {
        throw new RuntimeException('Failed to store uploaded file.');
    }

    $finfo = finfo_open(FILEINFO_MIME_TYPE);
    $mimeType = finfo_file($finfo, $destination) ?: 'application/octet-stream';
    finfo_close($finfo);

    $stmt = db()->prepare(
        'INSERT INTO documents (customer_id, visa_application_id, document_type, original_filename, stored_filename, storage_path, mime_type, file_size, uploaded_by_customer_id)
         VALUES (:customer_id, :application_id, :doc_type, :original_name, :stored_name, :storage_path, :mime, :size, :uploaded_by_customer_id)'
    );
    $stmt->execute([
        'customer_id' => $customerId,
        'application_id' => $visaApplicationId,
        'doc_type' => $documentType,
        'original_name' => basename($originalName),
        'stored_name' => $storedFilename,
        'storage_path' => 'storage/documents/' . $storedFilename,
        'mime' => $mimeType,
        'size' => $file['size'],
        'uploaded_by_customer_id' => $customerId,
    ]);

    return (int) db()->lastInsertId();
}
