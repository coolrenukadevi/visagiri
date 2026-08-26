<?php
declare(strict_types=1);

/**
 * Forex Buy / Foreign Currency Purchase module helpers. Reuses
 * validate_document_upload() (includes/documents.php) for MIME
 * sniffing and generate_reference_number() (includes/reference-numbers.php)
 * for VG-FX-YYYY-NNNNNN reference numbers — no new upload-validation
 * or reference-generation logic here.
 *
 * forex_delivery_blockers() is the single source of truth for "is
 * this request compliant enough to deliver" — used both by the
 * document-completion checklist widget and the hard gate enforced in
 * admin/pages/forex-requests.php's delivery action, so the checklist
 * a staff member sees can never disagree with what the gate actually
 * enforces.
 */

const FOREX_DOCUMENTS_STORAGE_DIR = __DIR__ . '/../storage/forex-documents';

/**
 * Starting list of common currencies for the request form's dropdown
 * (section 10) — the admin-maintained forex_rates table is not
 * restricted to this list; any currency code can be added there.
 */
const FOREX_CURRENCY_OPTIONS = [
    'USD' => 'US Dollar', 'EUR' => 'Euro', 'GBP' => 'British Pound', 'AED' => 'UAE Dirham',
    'SGD' => 'Singapore Dollar', 'AUD' => 'Australian Dollar', 'CAD' => 'Canadian Dollar',
    'CHF' => 'Swiss Franc', 'JPY' => 'Japanese Yen', 'HKD' => 'Hong Kong Dollar',
    'THB' => 'Thai Baht', 'MYR' => 'Malaysian Ringgit', 'SAR' => 'Saudi Riyal',
    'QAR' => 'Qatari Riyal', 'NZD' => 'New Zealand Dollar', 'CNY' => 'Chinese Yuan',
];

/**
 * Looks up the compliance rule for a country. Returns null if no
 * rule has been entered yet — callers must treat "no rule" as "the
 * full standard checklist applies" (the safe default), never as
 * "nothing is required."
 */
function forex_country_rule_for(string $country): ?array
{
    $stmt = db()->prepare('SELECT * FROM forex_country_rules WHERE country = :country');
    $stmt->execute(['country' => $country]);
    $rule = $stmt->fetch();
    return $rule ?: null;
}

/**
 * Stores an already-validated upload (via validate_document_upload())
 * into private storage, named {reference}-{DOCTYPE}.ext per the
 * spec's file-naming requirement — never the customer's original
 * filename. If a current document of the same type already exists,
 * it is superseded (is_current = 0, deleted_at set) rather than
 * overwritten, so document history is preserved.
 */
function store_forex_document_upload(
    array $file,
    string $documentType,
    int $forexRequestId,
    string $forexReferenceNo,
    int $uploadedBy
): int {
    if (!is_dir(FOREX_DOCUMENTS_STORAGE_DIR)) {
        mkdir(FOREX_DOCUMENTS_STORAGE_DIR, 0755, true);
    }

    $pdo = db();
    $pdo->prepare(
        'UPDATE forex_documents SET is_current = 0, deleted_at = NOW()
         WHERE forex_request_id = :id AND document_type = :type AND is_current = 1'
    )->execute(['id' => $forexRequestId, 'type' => $documentType]);

    $originalName = (string) $file['name'];
    $extension = strtolower(pathinfo($originalName, PATHINFO_EXTENSION));
    $docTypeLabel = strtoupper(str_replace('_', '', $documentType));
    $storedFilename = $forexReferenceNo . '-' . $docTypeLabel . '-' . bin2hex(random_bytes(8)) . '.' . $extension;
    $destination = FOREX_DOCUMENTS_STORAGE_DIR . '/' . $storedFilename;

    if (!move_uploaded_file($file['tmp_name'], $destination)) {
        throw new RuntimeException('Failed to store uploaded file.');
    }

    $finfo = finfo_open(FILEINFO_MIME_TYPE);
    $mimeType = finfo_file($finfo, $destination) ?: 'application/octet-stream';
    finfo_close($finfo);

    $stmt = $pdo->prepare(
        'INSERT INTO forex_documents (forex_request_id, document_type, original_filename, stored_filename, storage_path, mime_type, file_size, uploaded_by)
         VALUES (:request_id, :type, :original_name, :stored_name, :storage_path, :mime, :size, :uploaded_by)'
    );
    $stmt->execute([
        'request_id' => $forexRequestId,
        'type' => $documentType,
        'original_name' => basename($originalName),
        'stored_name' => $storedFilename,
        'storage_path' => 'storage/forex-documents/' . $storedFilename,
        'mime' => $mimeType,
        'size' => $file['size'],
        'uploaded_by' => $uploadedBy,
    ]);

    return (int) $pdo->lastInsertId();
}

function forex_record_status_change(int $forexRequestId, ?string $fromStatus, string $toStatus, ?string $remarks = null): void
{
    db()->prepare(
        'INSERT INTO forex_status_history (forex_request_id, from_status, to_status, changed_by, remarks)
         VALUES (:id, :from_status, :to_status, :changed_by, :remarks)'
    )->execute([
        'id' => $forexRequestId,
        'from_status' => $fromStatus,
        'to_status' => $toStatus,
        'changed_by' => current_admin_id(),
        'remarks' => $remarks,
    ]);
    log_action('status_change', 'forex_requests', $forexRequestId, $fromStatus, $toStatus);
}

function forex_status_labels(): array
{
    return [
        'new_request' => 'New Request',
        'awaiting_documents' => 'Awaiting Documents',
        'documents_submitted' => 'Documents Submitted',
        'documents_under_verification' => 'Documents Under Verification',
        'documents_verified' => 'Documents Verified',
        'quotation_preparing' => 'Quotation Preparing',
        'quotation_sent' => 'Quotation Sent',
        'customer_accepted' => 'Customer Accepted',
        'payment_pending' => 'Payment Pending',
        'payment_received' => 'Payment Received',
        'compliance_verification' => 'Compliance Verification',
        'approved_for_processing' => 'Approved for Processing',
        'forex_processing' => 'Forex Procurement / Processing',
        'ready_for_delivery' => 'Ready for Delivery',
        'delivered' => 'Delivered',
        'cancelled' => 'Cancelled',
        'rejected' => 'Rejected',
        'refund_reversal' => 'Refund / Reversal',
    ];
}

/** Customer-safe status labels for the public tracking page — never a raw internal status string. */
function forex_customer_status_label(string $status): string
{
    $map = [
        'new_request' => 'Request Received',
        'awaiting_documents' => 'Awaiting Your Documents',
        'documents_submitted' => 'Documents Received',
        'documents_under_verification' => 'Documents Under Verification',
        'documents_verified' => 'Documents Verified',
        'quotation_preparing' => 'Quotation Being Prepared',
        'quotation_sent' => 'Quotation Ready',
        'customer_accepted' => 'Quotation Accepted',
        'payment_pending' => 'Payment Pending',
        'payment_received' => 'Payment Received',
        'compliance_verification' => 'Compliance Verification',
        'approved_for_processing' => 'Approved for Processing',
        'forex_processing' => 'Processing Your Forex',
        'ready_for_delivery' => 'Ready for Collection/Delivery',
        'delivered' => 'Delivered',
        'cancelled' => 'Cancelled',
        'rejected' => 'Not Approved',
        'refund_reversal' => 'Refund in Progress',
    ];
    return $map[$status] ?? ucwords(str_replace('_', ' ', $status));
}

const FOREX_DOCUMENT_TYPE_LABELS = [
    'passport' => 'Passport',
    'pan' => 'PAN Card',
    'air_ticket' => 'Air Ticket',
    'hotel' => 'Hotel Booking',
    'visa' => 'Visa Copy',
    'declaration' => 'Visa-on-Arrival/Visa-Free Declaration',
    'other' => 'Other Document',
];

/**
 * The single source of truth for "can this request be delivered."
 * Returns an empty array when every mandatory compliance condition is
 * satisfied; otherwise a list of human-readable blocker strings.
 * Re-fetches everything itself rather than trusting caller-supplied
 * data, so the checklist widget and the hard delivery gate can never
 * disagree with each other.
 */
function forex_delivery_blockers(int $forexRequestId): array
{
    $pdo = db();

    $stmt = $pdo->prepare('SELECT * FROM forex_requests WHERE id = :id');
    $stmt->execute(['id' => $forexRequestId]);
    $request = $stmt->fetch();
    if (!$request) {
        return ['Forex request not found.'];
    }

    $blockers = [];

    // Customer identity on file (distinct from the passport/PAN
    // *document copies* checked below — this checks the customer
    // record's own identity fields were captured).
    $custStmt = $pdo->prepare('SELECT passport_number_encrypted, pan_number_encrypted FROM customers WHERE id = :id');
    $custStmt->execute(['id' => $request['customer_id']]);
    $customer = $custStmt->fetch();
    if (!$customer || !$customer['passport_number_encrypted'] || !$customer['pan_number_encrypted']) {
        $blockers[] = 'Customer identity (passport number and PAN) not fully recorded.';
    }

    $rule = forex_country_rule_for($request['country_of_visit']);
    // No rule on file yet defaults to "everything required" — the
    // safe fallback, never "nothing required."
    $requiresAirTicket = $rule === null || (int) $rule['requires_air_ticket'] === 1;
    $requiresHotel = $rule === null || (int) $rule['requires_hotel'] === 1;

    $docsStmt = $pdo->prepare('SELECT * FROM forex_documents WHERE forex_request_id = :id AND is_current = 1');
    $docsStmt->execute(['id' => $forexRequestId]);
    $documentsByType = [];
    foreach ($docsStmt->fetchAll() as $doc) {
        $documentsByType[$doc['document_type']] = $doc;
    }

    $checkVerified = function (string $type, string $label) use (&$blockers, $documentsByType): void {
        $doc = $documentsByType[$type] ?? null;
        if (!$doc) {
            $blockers[] = "$label not uploaded.";
        } elseif ($doc['verification_status'] === 'rejected') {
            $blockers[] = "$label was rejected — a corrected document is required.";
        } elseif ($doc['verification_status'] !== 'verified') {
            $blockers[] = "$label is uploaded but not yet verified.";
        }
    };

    $checkVerified('passport', 'Passport copy');
    $checkVerified('pan', 'PAN copy');
    if ($requiresAirTicket) {
        $checkVerified('air_ticket', 'Air ticket');
    }
    if ($requiresHotel) {
        $checkVerified('hotel', 'Hotel booking proof');
    }

    // Visa vs declaration — section 5/6's core rule.
    $visaDocumentRequired = in_array($request['visa_status'], ['visa_available', 'evisa'], true);
    $declarationRequired = in_array($request['visa_status'], ['visa_on_arrival', 'visa_free'], true);

    if ($visaDocumentRequired) {
        $checkVerified('visa', 'Visa copy');
    } elseif ($declarationRequired) {
        $declStmt = $pdo->prepare('SELECT * FROM forex_declarations WHERE forex_request_id = :id ORDER BY id DESC LIMIT 1');
        $declStmt->execute(['id' => $forexRequestId]);
        $declaration = $declStmt->fetch();
        if (!$declaration || !$declaration['verified_at']) {
            $blockers[] = 'Signed Visa-on-Arrival/Visa-Free declaration not uploaded or not yet verified.';
        }
    } else {
        // visa_not_available / in_process / other — section 5's
        // explicit warning: cannot proceed until resolved to one of
        // the above states.
        $blockers[] = 'Forex delivery cannot be completed until the required visa documentation is verified, unless the destination is confirmed as Visa on Arrival / Visa-Free / otherwise eligible under applicable rules.';
    }

    $paymentStmt = $pdo->prepare('SELECT * FROM forex_payments WHERE forex_request_id = :id ORDER BY id DESC LIMIT 1');
    $paymentStmt->execute(['id' => $forexRequestId]);
    $payment = $paymentStmt->fetch();
    if (!$payment || $payment['status'] !== 'paid') {
        $blockers[] = 'Payment has not been confirmed as received in full.';
    }

    $approvalStmt = $pdo->prepare(
        "SELECT action FROM forex_approvals WHERE forex_request_id = :id ORDER BY id DESC LIMIT 1"
    );
    $approvalStmt->execute(['id' => $forexRequestId]);
    $latestApproval = $approvalStmt->fetchColumn();
    if ($latestApproval !== 'approved' && $latestApproval !== 'delivery_override') {
        $blockers[] = 'Required approval has not been completed.';
    }

    return $blockers;
}

/** Document-completion progress for the checklist widget — count of applicable documents that are verified. */
function forex_document_completion(int $forexRequestId): array
{
    $pdo = db();
    $stmt = $pdo->prepare('SELECT * FROM forex_requests WHERE id = :id');
    $stmt->execute(['id' => $forexRequestId]);
    $request = $stmt->fetch();

    $rule = forex_country_rule_for($request['country_of_visit']);
    $requiresAirTicket = $rule === null || (int) $rule['requires_air_ticket'] === 1;
    $requiresHotel = $rule === null || (int) $rule['requires_hotel'] === 1;
    $visaDocumentRequired = in_array($request['visa_status'], ['visa_available', 'evisa'], true);
    $declarationRequired = in_array($request['visa_status'], ['visa_on_arrival', 'visa_free'], true);

    $applicable = ['passport', 'pan'];
    if ($requiresAirTicket) {
        $applicable[] = 'air_ticket';
    }
    if ($requiresHotel) {
        $applicable[] = 'hotel';
    }
    if ($visaDocumentRequired) {
        $applicable[] = 'visa';
    } elseif ($declarationRequired) {
        $applicable[] = 'declaration';
    }

    $docsStmt = $pdo->prepare('SELECT document_type, verification_status FROM forex_documents WHERE forex_request_id = :id AND is_current = 1');
    $docsStmt->execute(['id' => $forexRequestId]);
    $statusByType = [];
    foreach ($docsStmt->fetchAll() as $row) {
        $statusByType[$row['document_type']] = $row['verification_status'];
    }

    $items = [];
    $verifiedCount = 0;
    foreach ($applicable as $type) {
        $status = $statusByType[$type] ?? 'not_uploaded';
        if ($status === 'verified') {
            $verifiedCount++;
        }
        $items[] = ['type' => $type, 'label' => FOREX_DOCUMENT_TYPE_LABELS[$type], 'status' => $status];
    }

    return ['items' => $items, 'verified' => $verifiedCount, 'total' => count($applicable)];
}
