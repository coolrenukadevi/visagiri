<?php
declare(strict_types=1);

/**
 * Shared helpers for the unified public enquiry wizard (pages/
 * enquire.php, Visa + Apostille) and its admin CRM (admin/pages/
 * enquiries.php). Session-tracked multi-step flow, modeled on the
 * existing partner-enrollment wizard (includes/partner-enrollment.php):
 * no login is required, so the real `enquiries` row is created once
 * Step 1 (customer info) is submitted, and its id is held in
 * $_SESSION until the wizard completes — each later step updates that
 * same row rather than accumulating state client-side.
 */

const ENQUIRY_STEPS = [
    1 => 'Customer',
    2 => 'Enquiry Details',
    3 => 'Documents',
    4 => 'Review',
    5 => 'Submitted',
];

/** Visa types are read from the real visa_types table (visa_types_all()); these are the fixed Apostille service options. */
const APOSTILLE_SERVICE_TYPES = [
    'apostille' => 'Apostille',
    'embassy_attestation' => 'Embassy Attestation',
    'commercial_attestation' => 'Commercial Document Attestation',
    'educational_attestation' => 'Educational Document Attestation',
    'personal_attestation' => 'Personal Document Attestation',
    'other' => 'Other Document Legalisation Service',
];

const APOSTILLE_DOCUMENT_TYPES = [
    'birth_certificate' => 'Birth Certificate',
    'marriage_certificate' => 'Marriage Certificate',
    'educational_certificate' => 'Educational Certificate',
    'degree_certificate' => 'Degree Certificate',
    'diploma' => 'Diploma',
    'marksheet' => 'Marksheet',
    'commercial_document' => 'Commercial Document',
    'power_of_attorney' => 'Power of Attorney',
    'affidavit' => 'Affidavit',
    'medical_certificate' => 'Medical Certificate',
    'other' => 'Other',
];

/** Every document category the wizard/CRM knows about, with its display label. Categorization keeps every attachment meaningful instead of an anonymous pile of files. */
const ENQUIRY_DOCUMENT_CATEGORIES = [
    'passport_first' => 'Passport First Page',
    'passport_last' => 'Passport Last Page',
    'passport_combined' => 'Passport First + Last Page (combined)',
    'invitation_letter' => 'Invitation Letter',
    'cover_letter' => 'Cover Letter',
    'hotel_reservation' => 'Hotel Reservation',
    'flight_reservation' => 'Flight Reservation',
    'travel_insurance' => 'Travel Insurance',
    'photograph' => 'Photograph',
    'previous_visa' => 'Previous Visa',
    'financial_documents' => 'Supporting Financial Documents',
    'employment_documents' => 'Employment Documents',
    'apostille_document' => 'Document(s) for Apostille/Legalisation',
    'other' => 'Other Supporting Documents',
];

/** Internal CRM status => customer-safe label shown on the public tracking page. Internal statuses can be more granular than what a customer needs to see. */
const ENQUIRY_STATUS_MAP = [
    'new_enquiry' => 'Enquiry Received',
    'under_review' => 'Documents Under Review',
    'documents_pending' => 'Additional Documents Required',
    'documents_verified' => 'Documents Under Review',
    'processing' => 'Application Processing',
    'additional_info_required' => 'Awaiting Customer Action',
    'application_submitted' => 'Visa Processing / Submission Stage',
    'completed' => 'Completed',
    'closed' => 'Closed',
];

/** @return array<string,string> internal_status_key => internal label, for CRM dropdowns. */
function enquiry_internal_statuses(): array
{
    return [
        'new_enquiry' => 'New Enquiry',
        'under_review' => 'Under Review',
        'documents_pending' => 'Documents Pending',
        'documents_verified' => 'Documents Verified',
        'processing' => 'Processing',
        'additional_info_required' => 'Additional Information Required',
        'application_submitted' => 'Application Submitted',
        'completed' => 'Completed',
        'closed' => 'Closed',
    ];
}

function enquiry_customer_status_label(string $status): string
{
    return ENQUIRY_STATUS_MAP[$status] ?? 'Enquiry Received';
}

/** Renders the 1-5 step indicator at the top of every wizard page, matching render_partner_enrollment_steps()'s pattern. */
function render_enquiry_steps(int $currentStep): void
{
    ?>
    <ol class="enrollment-steps">
        <?php foreach (ENQUIRY_STEPS as $num => $label): ?>
        <li class="enrollment-steps__item<?= $num === $currentStep ? ' is-current' : ($num < $currentStep ? ' is-done' : '') ?>">
            <span class="enrollment-steps__num"><?= $num < $currentStep ? '&#10003;' : $num ?></span>
            <span class="enrollment-steps__label"><?= e($label) ?></span>
        </li>
        <?php endforeach; ?>
    </ol>
    <?php
}

/**
 * Normalizes a mobile number into "+<countrycode><number>" (e.g.
 * "+919876543210") given a separate country-code field (default +91)
 * and the raw number, stripping spaces/dashes. Returns null if the
 * resulting number doesn't look like a real international number.
 */
function normalize_mobile_number(string $countryCode, string $rawNumber): ?string
{
    $countryCode = '+' . preg_replace('/\D/', '', $countryCode);
    $digits = preg_replace('/\D/', '', $rawNumber);
    if ($digits === '' || strlen($digits) < 7 || strlen($digits) > 14) {
        return null;
    }
    $normalized = $countryCode . $digits;
    if (!preg_match('/^\+[1-9][0-9]{7,15}$/', $normalized)) {
        return null;
    }
    return $normalized;
}

/** Passport numbers: 6-12 alphanumeric characters (covers every real passport format Visagiri deals with), trimmed and upper-cased for consistent storage/search. */
function normalize_passport_number(string $raw): ?string
{
    $clean = strtoupper(preg_replace('/\s+/', '', $raw));
    if (!preg_match('/^[A-Z0-9]{6,12}$/', $clean)) {
        return null;
    }
    return $clean;
}

/** A short, non-sequential tracking token: VGTRK-XXXXXXXX (8 base32-ish uppercase alphanumeric chars, ambiguous characters like 0/O/1/I excluded). */
function generate_tracking_token(): string
{
    $alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    $token = '';
    for ($i = 0; $i < 8; $i++) {
        $token .= $alphabet[random_int(0, strlen($alphabet) - 1)];
    }
    return 'VGTRK-' . $token;
}

/**
 * Looks up which document categories are mandatory for a given
 * service (visa type or apostille), consulting the CMS-configurable
 * enquiry_document_requirements table first (country-specific row,
 * then visa-type-generic row) and falling back to a built-in default
 * so the form always has sane guidance even before an admin has
 * configured anything. Mirrors the client spec's own examples
 * (Business Visa -> Invitation Letter mandatory; Tourist Visa -> not).
 *
 * @return array<string,bool> document_category => is_mandatory
 */
function enquiry_document_requirements_for(string $serviceCategory, ?int $visaTypeId, ?int $countryId, ?string $visaTypeSlug = null): array
{
    $rules = [];

    $stmt = db()->prepare(
        'SELECT document_category, is_mandatory FROM enquiry_document_requirements
         WHERE service_category = :cat AND (visa_type_id = :vt OR visa_type_id IS NULL) AND (country_id = :c OR country_id IS NULL)
         ORDER BY (country_id IS NOT NULL) DESC, (visa_type_id IS NOT NULL) DESC'
    );
    $stmt->execute(['cat' => $serviceCategory, 'vt' => $visaTypeId, 'c' => $countryId]);
    foreach ($stmt->fetchAll() as $row) {
        // First (most specific) row per category wins — country-specific
        // beats visa-type-generic beats service-wide, per the ORDER BY above.
        if (!array_key_exists($row['document_category'], $rules)) {
            $rules[$row['document_category']] = (bool) $row['is_mandatory'];
        }
    }

    if ($rules === []) {
        $rules = enquiry_default_document_requirements($serviceCategory, $visaTypeSlug);
    }

    return $rules;
}

/** Built-in fallback used only when no admin-configured rule exists at all for this service/visa type. */
function enquiry_default_document_requirements(string $serviceCategory, ?string $visaTypeSlug): array
{
    if ($serviceCategory === 'apostille') {
        return ['apostille_document' => true];
    }

    $defaults = [
        'invitation_letter' => $visaTypeSlug === 'business',
        'cover_letter' => false,
        'hotel_reservation' => false,
        'flight_reservation' => false,
        'travel_insurance' => false,
        'photograph' => false,
        'previous_visa' => false,
        'financial_documents' => false,
        'employment_documents' => false,
    ];

    return $defaults;
}

/**
 * Stores an anonymous public enquiry-wizard upload — same validation
 * path as validate_document_upload(), but no admin/customer login is
 * required (the enquiry itself, not a logged-in user, is the owner),
 * matching the client spec's requirement that customers can attach
 * documents to a public enquiry without an account.
 */
function store_enquiry_document_upload(array $file, string $documentCategory, int $enquiryId): int
{
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

    $mimeType = detect_file_mime_type($destination) ?? 'application/octet-stream';

    $stmt = db()->prepare(
        'INSERT INTO enquiry_documents (enquiry_id, document_category, original_filename, stored_filename, storage_path, mime_type, file_size)
         VALUES (:enquiry_id, :category, :original_name, :stored_name, :storage_path, :mime, :size)'
    );
    $stmt->execute([
        'enquiry_id' => $enquiryId,
        'category' => $documentCategory,
        'original_name' => basename($originalName),
        'stored_name' => $storedFilename,
        'storage_path' => 'storage/documents/' . $storedFilename,
        'mime' => $mimeType,
        'size' => $file['size'],
    ]);

    return (int) db()->lastInsertId();
}

/** Records a status transition in enquiry_status_history and updates the enquiry row's status column together. */
function change_enquiry_status(int $enquiryId, string $newStatus, ?int $changedBy, ?string $remarks = null): void
{
    $stmt = db()->prepare('SELECT status FROM enquiries WHERE id = :id');
    $stmt->execute(['id' => $enquiryId]);
    $old = $stmt->fetchColumn();
    if ($old === $newStatus) {
        return;
    }

    db()->prepare('UPDATE enquiries SET status = :status WHERE id = :id')
        ->execute(['status' => $newStatus, 'id' => $enquiryId]);

    db()->prepare(
        'INSERT INTO enquiry_status_history (enquiry_id, old_status, new_status, changed_by, remarks)
         VALUES (:id, :old, :new, :by, :remarks)'
    )->execute(['id' => $enquiryId, 'old' => $old ?: null, 'new' => $newStatus, 'by' => $changedBy, 'remarks' => $remarks]);
}

/**
 * Sends the customer confirmation email (best-effort — see
 * includes/mail.php's mail_log(), which records exactly why a send
 * failed if it does) and updates enquiries.email_status accordingly.
 * The enquiry row itself is never rolled back or lost if this fails.
 */
function send_enquiry_confirmation_email(array $enquiry): void
{
    $subject = 'Visagiri Enquiry Confirmation — ' . $enquiry['enquiry_number'];
    $trackUrl = APP_URL . '/track/?ref=' . urlencode($enquiry['enquiry_number']);
    $pdfUrl = APP_URL . '/enquire/pdf/?ref=' . urlencode($enquiry['enquiry_number']) . '&token=' . urlencode($enquiry['tracking_token']);

    $lines = [
        '<p>Dear ' . e($enquiry['name']) . ',</p>',
        '<p>Your enquiry has been successfully received.</p>',
        '<p><strong>Enquiry No.:</strong> ' . e($enquiry['enquiry_number']) . '<br>',
        '<strong>Tracking No.:</strong> ' . e($enquiry['tracking_token']) . '<br>',
        '<strong>Service:</strong> ' . e($enquiry['service_category'] === 'visa' ? 'Visa Enquiry' : 'Apostille / Document Legalisation') . '</p>',
        '<p>Our team will review the submitted information and documents. You can track your enquiry any time using your tracking number.</p>',
        '<p><a href="' . e($pdfUrl) . '">Download Enquiry PDF</a> &nbsp;|&nbsp; <a href="' . e($trackUrl) . '">Track Your Enquiry</a></p>',
        '<p>Regards,<br>Visagiri Team</p>',
        '<hr>',
        '<p style="font-size:12px;color:#666">' . e(setting('contact_phone_display', '+91 7065 819 819')) . ' &middot; ' . e(setting('contact_email', 'info@visagiri.com')) . '<br>',
        e(enquiry_disclaimer_text()) . '</p>',
    ];

    $ok = send_mail($enquiry['email'], $subject, implode("\n", $lines), $enquiry['name']);

    db()->prepare('UPDATE enquiries SET email_status = :status, email_sent_at = :sent WHERE id = :id')
        ->execute([
            'status' => $ok ? 'sent' : 'failed',
            'sent' => $ok ? date('Y-m-d H:i:s') : null,
            'id' => $enquiry['id'],
        ]);
}

/** The approved default disclaimer text — exact wording, never altered. */
function enquiry_disclaimer_text(): string
{
    return 'Visa decisions are made solely by the relevant embassy, consulate, or government immigration authority. Visagiri provides visa consultancy and application-management assistance and does not guarantee visa approval.';
}

/**
 * Fetches one enquiry row joined with the human-readable names the
 * PDF/email need (country, visa type), and — deliberately only here,
 * for the immediate post-submission PDF/email generation, never
 * exposed through any public endpoint — the decrypted passport
 * number under 'passport_number_plain' so build_enquiry_pdf() can
 * mask it for display without a second decrypt call.
 */
function fetch_enquiry_full(int $enquiryId): array
{
    $stmt = db()->prepare(
        'SELECT e.*, dc.name AS destination_country_name, vt.name AS visa_type_name, ac.name AS apostille_country_name
         FROM enquiries e
         LEFT JOIN countries dc ON dc.id = e.destination_country_id
         LEFT JOIN visa_types vt ON vt.id = e.visa_type_id
         LEFT JOIN countries ac ON ac.id = e.apostille_destination_country_id
         WHERE e.id = :id'
    );
    $stmt->execute(['id' => $enquiryId]);
    $row = $stmt->fetch();
    if ($row === false) {
        throw new RuntimeException("Enquiry $enquiryId not found.");
    }
    if ($row['passport_number_encrypted'] !== null) {
        $row['passport_number_plain'] = decrypt_value($row['passport_number_encrypted']);
    }
    return $row;
}

/** @return list<array<string,mixed>> */
function fetch_enquiry_documents(int $enquiryId): array
{
    $stmt = db()->prepare('SELECT * FROM enquiry_documents WHERE enquiry_id = :id ORDER BY uploaded_at ASC');
    $stmt->execute(['id' => $enquiryId]);
    return $stmt->fetchAll();
}

/**
 * Builds the {visaTypeSlug: {category: isMandatory}} map the wizard's
 * client-side JS uses to show/hide "Required" hints as the visitor
 * picks a visa type — purely a UX hint; enquire.php's own POST
 * handler re-checks the same rules server-side before ever accepting
 * a submission, so nothing here needs to be trusted.
 */
function enquiry_document_rules_for_js(array $visaTypes): array
{
    $rules = [];
    foreach ($visaTypes as $t) {
        $rules[$t['slug']] = enquiry_document_requirements_for('visa', (int) $t['id'], null, $t['slug']);
    }
    $rules['__apostille__'] = enquiry_document_requirements_for('apostille', null, null);
    return $rules;
}

/** Masks a passport number for customer-facing/public display: keeps the last 4 characters, masks the rest. */
function mask_passport_number(string $passport): string
{
    $len = strlen($passport);
    if ($len <= 4) {
        return $passport;
    }
    return str_repeat('X', $len - 4) . substr($passport, -4);
}
