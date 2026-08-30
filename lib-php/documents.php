<?php
/**
 * Document upload, storage and serving for an enquiry.
 *
 * Storage: cache/documents/{enquiry_id}/{random}.{ext} — cache/ is already
 * denied to direct web access by both tools/router.php and .htaccess (the
 * same protection auth.sqlite relies on), so this reuses an existing,
 * already-tested boundary instead of inventing a new one. The ONLY way to
 * read a file back is document_serve() below, which re-checks ownership on
 * every request; there is no public URL to a stored file, ever.
 *
 * Validation never trusts the client: extension allow-list AND a real
 * fileinfo MIME sniff of the bytes actually received, not the browser's
 * claimed Content-Type — a renamed .exe still gets caught because its
 * sniffed MIME won't match what the extension promises.
 */
declare(strict_types=1);

require_once __DIR__ . '/enquiries.php';

const DOCUMENT_MAX_COUNT      = 10;   // beyond the mandatory passport slot
const DOCUMENT_MAX_TOTAL_MB   = 30;
const DOCUMENT_MAX_TOTAL_BYTES = DOCUMENT_MAX_TOTAL_MB * 1024 * 1024;

/** extension => expected sniffed MIME. Everything else is rejected outright. */
const DOCUMENT_ALLOWED_TYPES = [
    'pdf'  => 'application/pdf',
    'jpg'  => 'image/jpeg',
    'jpeg' => 'image/jpeg',
    'png'  => 'image/png',
];

function document_migrate(PDO $pdo): void
{
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS document_types (
            id           INTEGER PRIMARY KEY AUTOINCREMENT,
            code         TEXT UNIQUE NOT NULL,
            label        TEXT NOT NULL,
            is_passport  INTEGER NOT NULL DEFAULT 0,
            sort_order   INTEGER NOT NULL DEFAULT 0
        )");
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS documents (
            id                  INTEGER PRIMARY KEY AUTOINCREMENT,
            document_uid        TEXT UNIQUE NOT NULL,
            enquiry_id          INTEGER NOT NULL REFERENCES enquiries(id) ON DELETE CASCADE,
            customer_id         INTEGER NOT NULL REFERENCES customers(id),
            document_type_id    INTEGER NOT NULL REFERENCES document_types(id),
            original_filename   TEXT NOT NULL,
            secure_filename     TEXT NOT NULL,
            mime_type           TEXT NOT NULL,
            size_bytes          INTEGER NOT NULL,
            status              TEXT NOT NULL DEFAULT 'Under Review',
            rejection_reason    TEXT NOT NULL DEFAULT '',
            uploaded_at         INTEGER NOT NULL
        )");
    $pdo->exec('CREATE INDEX IF NOT EXISTS idx_documents_enquiry ON documents(enquiry_id)');

    $seed = $pdo->prepare('INSERT OR IGNORE INTO document_types (code, label, is_passport, sort_order) VALUES (?, ?, ?, ?)');
    $order = 0;
    foreach ([
        ['passport_first', 'Passport — First Page', 1],
        ['passport_last', 'Passport — Last Page', 1],
        ['passport_combined', 'Passport — Combined Copy', 1],
        ['passport_copy', 'Passport Copy', 0],
        ['passport_photo', 'Passport Photograph', 0],
        ['cover_letter', 'Cover Letter', 0],
        ['flight_reservation', 'Flight Reservation', 0],
        ['hotel_reservation', 'Hotel Reservation', 0],
        ['travel_insurance', 'Travel Insurance', 0],
        ['bank_statement', 'Bank Statement', 0],
        ['bank_certificate', 'Bank Certificate', 0],
        ['employment_letter', 'Employment Letter', 0],
        ['salary_slip', 'Salary Slip', 0],
        ['itr', 'ITR', 0],
        ['invitation_letter', 'Invitation Letter', 0],
        ['sponsorship_letter', 'Sponsorship Letter', 0],
        ['previous_visa_copy', 'Previous Visa Copy', 0],
        ['pan_card', 'PAN Card Copy', 0],
        ['visa_copy', 'Visa Copy', 0],
        ['lerms_letter', 'LERMS Letter', 0],
        ['other', 'Other Supporting Document', 0],
    ] as [$code, $label, $isPassport]) {
        $seed->execute([$code, $label, $isPassport, $order++]);
    }
}

function document_db(): ?PDO
{
    static $migrated = false;
    $pdo = enquiry_db();
    if (!$pdo) return null;
    if (!$migrated) {
        document_migrate($pdo);
        $migrated = true;
    }
    return $pdo;
}

function document_types_all(): array
{
    $pdo = document_db();
    if (!$pdo) return [];
    return $pdo->query('SELECT * FROM document_types ORDER BY sort_order')->fetchAll();
}

function document_type_find(int $id): ?array
{
    $pdo = document_db();
    if (!$pdo) return null;
    $st = $pdo->prepare('SELECT * FROM document_types WHERE id = ?');
    $st->execute([$id]);
    return $st->fetch() ?: null;
}

function documents_for_enquiry(int $enquiryId): array
{
    $pdo = document_db();
    if (!$pdo) return [];
    $st = $pdo->prepare('
        SELECT d.*, t.label AS type_label, t.is_passport
        FROM documents d JOIN document_types t ON t.id = d.document_type_id
        WHERE d.enquiry_id = ? ORDER BY d.uploaded_at');
    $st->execute([$enquiryId]);
    return $st->fetchAll();
}

function document_find_by_uid(string $uid): ?array
{
    $pdo = document_db();
    if (!$pdo) return null;
    $st = $pdo->prepare('
        SELECT d.*, t.label AS type_label, t.is_passport
        FROM documents d JOIN document_types t ON t.id = d.document_type_id
        WHERE d.document_uid = ?');
    $st->execute([$uid]);
    return $st->fetch() ?: null;
}

function documents_storage_dir(int $enquiryId): string
{
    return CACHE_PATH . '/documents/' . $enquiryId;
}

/**
 * @param array $file One entry of $_FILES, e.g. $_FILES['file'].
 * @return array{0:?array,1:string} [document row, error] — error is '' on success.
 */
function document_upload(int $enquiryId, int $customerId, int $documentTypeId, array $file): array
{
    if (($file['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_OK) {
        $tooBig = in_array($file['error'] ?? null, [UPLOAD_ERR_INI_SIZE, UPLOAD_ERR_FORM_SIZE], true);
        return [null, $tooBig ? 'That file is too large.' : 'Upload failed. Please try again.'];
    }
    if (!document_type_find($documentTypeId)) {
        return [null, 'Choose a document type.'];
    }

    $existing = documents_for_enquiry($enquiryId);
    $nonPassportCount = count(array_filter($existing, static fn($d) => !$d['is_passport']));
    $type = document_type_find($documentTypeId);
    if (!$type['is_passport'] && $nonPassportCount >= DOCUMENT_MAX_COUNT) {
        return [null, 'You\'ve reached the ' . DOCUMENT_MAX_COUNT . '-document limit for this enquiry.'];
    }
    $totalBytes = array_sum(array_column($existing, 'size_bytes')) + (int) $file['size'];
    if ($totalBytes > DOCUMENT_MAX_TOTAL_BYTES) {
        return [null, 'This would put the enquiry over the ' . DOCUMENT_MAX_TOTAL_MB . ' MB total limit.'];
    }

    $originalName = (string) ($file['name'] ?? 'document');
    $ext = strtolower(pathinfo($originalName, PATHINFO_EXTENSION));
    if (!isset(DOCUMENT_ALLOWED_TYPES[$ext])) {
        return [null, 'Only PDF, JPG and PNG files are accepted.'];
    }

    $sniffed = '';
    if (function_exists('finfo_open')) {
        $finfo = finfo_open(FILEINFO_MIME_TYPE);
        $sniffed = (string) finfo_file($finfo, $file['tmp_name']);
        finfo_close($finfo);
    } else {
        // fileinfo is bundled with PHP by default; if a host has disabled it,
        // fail closed rather than silently skip the one check that catches a
        // renamed executable.
        log_error('documents: fileinfo extension unavailable — rejecting upload defensively');
        return [null, 'Uploads are temporarily unavailable. Please try again shortly.'];
    }
    $expected = DOCUMENT_ALLOWED_TYPES[$ext];
    $sniffOk = $sniffed === $expected
        || ($ext === 'jpg' && $sniffed === 'image/jpeg')
        || ($ext === 'jpeg' && $sniffed === 'image/jpeg');
    if (!$sniffOk) {
        return [null, 'That file\'s content doesn\'t match a ' . strtoupper($ext) . ' — please check and re-upload.'];
    }

    $dir = documents_storage_dir($enquiryId);
    if (!is_dir($dir) && !@mkdir($dir, 0770, true) && !is_dir($dir)) {
        log_error('documents: cannot create ' . $dir);
        return [null, 'Something went wrong storing your file. Please try again.'];
    }
    $secureFilename = bin2hex(random_bytes(16)) . '.' . $ext;
    $dest = $dir . '/' . $secureFilename;
    if (!move_uploaded_file($file['tmp_name'], $dest)) {
        log_error('documents: move_uploaded_file failed for ' . $dest);
        return [null, 'Something went wrong storing your file. Please try again.'];
    }
    @chmod($dest, 0640);

    $pdo = document_db();
    $uid = bin2hex(random_bytes(16));
    try {
        $pdo->prepare('
            INSERT INTO documents
                (document_uid, enquiry_id, customer_id, document_type_id, original_filename, secure_filename, mime_type, size_bytes, status, uploaded_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)')
            ->execute([$uid, $enquiryId, $customerId, $documentTypeId, $originalName, $secureFilename, $sniffed, (int) $file['size'], 'Under Review', time()]);
    } catch (Throwable $e) {
        @unlink($dest);
        log_error('documents: insert failed — ' . $e->getMessage());
        return [null, 'Something went wrong saving your file. Please try again.'];
    }

    return [document_find_by_uid($uid), ''];
}

function document_delete(array $document): bool
{
    $pdo = document_db();
    if (!$pdo) return false;
    $path = documents_storage_dir((int) $document['enquiry_id']) . '/' . $document['secure_filename'];
    $pdo->prepare('DELETE FROM documents WHERE id = ?')->execute([$document['id']]);
    @unlink($path);
    return true;
}

/** Streams a document to the browser. Caller must already have verified
 *  the requester owns the enquiry this document belongs to. */
function document_serve(array $document): void
{
    $path = documents_storage_dir((int) $document['enquiry_id']) . '/' . $document['secure_filename'];
    if (!is_file($path)) {
        http_response_code(404);
        exit;
    }
    header('Content-Type: ' . $document['mime_type']);
    header('Content-Length: ' . filesize($path));
    header('Content-Disposition: inline; filename="' . rawurlencode($document['original_filename']) . '"');
    header('X-Content-Type-Options: nosniff');
    header('Cache-Control: private, no-store');
    readfile($path);
}
