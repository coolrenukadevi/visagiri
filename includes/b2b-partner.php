<?php
declare(strict_types=1);

/**
 * Shared helpers for the standalone B2B Travel Partner Portal
 * (b2b/pages/register-*.php, b2b/pages/dashboard.php,
 * admin/pages/b2b-partners.php). Deliberately separate from
 * includes/partner-enrollment.php — this is a different partner
 * system by design, sharing only low-level infrastructure
 * (db(), encryption, mail, RBAC, reference numbers, document
 * validation) rather than the partner-entity/dashboard code itself.
 */

const B2B_BUSINESS_TYPES = [
    'travel_agency' => 'Travel Agency',
    'tour_operator' => 'Tour Operator',
    'corporate_travel_company' => 'Corporate Travel Management Company',
    'online_travel_agency' => 'Online Travel Agency',
    'dmc' => 'DMC',
    'visa_consultant' => 'Visa Consultant',
    'immigration_consultant' => 'Immigration Consultant',
    'corporate' => 'Corporate',
    'hotel_hospitality' => 'Hotel / Hospitality Company',
    'educational_institution' => 'Educational Institution',
    'other' => 'Other',
];

const B2B_DESIGNATIONS = [
    'owner' => 'Owner',
    'director' => 'Director',
    'partner' => 'Partner',
    'manager' => 'Manager',
    'travel_consultant' => 'Travel Consultant',
    'visa_consultant' => 'Visa Consultant',
    'operations_manager' => 'Operations Manager',
    'corporate_travel_manager' => 'Corporate Travel Manager',
    'other' => 'Other',
];

const B2B_MONTHLY_VOLUME = ['1-10' => '1-10', '11-25' => '11-25', '26-50' => '26-50', '51-100' => '51-100', '100+' => '100+'];

const B2B_VISA_SERVICES = [
    'tourist_visa' => 'Tourist Visa',
    'business_visa' => 'Business Visa',
    'employment_visa' => 'Employment Visa',
    'student_visa' => 'Student Visa',
    'transit_visa' => 'Transit Visa',
    'medical_visa' => 'Medical Visa',
    'conference_visa' => 'Conference Visa',
    'family_dependent_visa' => 'Family / Dependent Visa',
    'visit_visa' => 'Visit Visa',
    'crew_visa' => 'Crew Visa',
    'official_visa' => 'Official Visa',
    'other' => 'Other',
];

const B2B_DOCUMENT_TYPES = [
    'pan_card' => 'PAN Card',
    'gst_certificate' => 'GST Certificate',
    'company_registration_certificate' => 'Company / Business Registration Certificate',
    'address_proof' => 'Address Proof',
    'authorized_signatory_id' => 'Authorized Signatory ID',
    'business_license' => 'Business License',
    'travel_agency_license' => 'Travel Agency License / Industry Registration',
    'iata_certificate' => 'IATA Certificate',
    'other' => 'Other Supporting Document',
];

const B2B_ROLES = [
    'partner_admin' => 'Partner Admin',
    'partner_manager' => 'Partner Manager',
    'partner_agent' => 'Partner Agent',
    'partner_finance' => 'Partner Finance',
];

const B2B_STATUS_LABELS = [
    'draft' => 'Draft',
    'submitted' => 'Submitted',
    'under_review' => 'Under Review',
    'documents_required' => 'Documents Required',
    'verification_pending' => 'Verification Pending',
    'approved' => 'Approved',
    'active' => 'Active',
    'suspended' => 'Temporarily Suspended',
    'rejected' => 'Rejected',
    'blacklisted' => 'Blacklisted',
    'closed' => 'Closed',
];

const B2B_ENROLLMENT_STEPS = [
    1 => 'Business Information',
    2 => 'Contact & Verification',
    3 => 'KYC Documents',
    4 => 'Services & Countries',
    5 => 'Billing',
    6 => 'Declaration',
];

function render_b2b_enrollment_steps(int $currentStep): void
{
    ?>
    <ol class="enrollment-steps">
        <?php foreach (B2B_ENROLLMENT_STEPS as $num => $label): ?>
        <li class="enrollment-steps__item<?= $num === $currentStep ? ' is-current' : ($num < $currentStep ? ' is-done' : '') ?>">
            <span class="enrollment-steps__num"><?= $num < $currentStep ? '&#10003;' : $num ?></span>
            <span class="enrollment-steps__label"><?= e($label) ?></span>
        </li>
        <?php endforeach; ?>
    </ol>
    <?php
}

/** VG-B2B-YYYY-NNNNNN, using the same shared generator every other CRM entity in this project uses. */
function b2b_generate_partner_reference(): string
{
    return generate_reference_number('B2B', 'b2b_partners', 'partner_reference_no');
}

/**
 * Issues a 6-digit OTP for a signup-time email/mobile verification
 * step. Not tied to a partner_user id (the account may not exist yet)
 * — looked up later by channel+destination+purpose. Invalidates any
 * earlier unconsumed code for the same destination+purpose first, so
 * only the newest code is ever live (same discipline as the Recycle
 * Bin's restore OTPs).
 */
function b2b_issue_otp(string $channel, string $destination, string $purpose = 'registration', int $ttlMinutes = 10): string
{
    $pdo = db();
    $pdo->prepare('UPDATE b2b_otps SET consumed_at = NOW() WHERE channel = :channel AND destination = :dest AND purpose = :purpose AND consumed_at IS NULL')
        ->execute(['channel' => $channel, 'dest' => $destination, 'purpose' => $purpose]);

    $code = (string) random_int(100000, 999999);
    $pdo->prepare(
        'INSERT INTO b2b_otps (channel, destination, purpose, code_hash, expires_at) VALUES (:channel, :dest, :purpose, :hash, DATE_ADD(NOW(), INTERVAL :ttl MINUTE))'
    )->execute(['channel' => $channel, 'dest' => $destination, 'purpose' => $purpose, 'hash' => hash('sha256', $code), 'ttl' => $ttlMinutes]);

    return $code;
}

/**
 * Verifies a submitted OTP. Returns true and marks it consumed on
 * success. Expiry is compared in SQL (NOW() > expires_at), not via
 * PHP strtotime()/time() — this app runs with
 * date_default_timezone_set('Asia/Kolkata') (includes/config.php),
 * so a PHP-side comparison against a MySQL-generated UTC timestamp
 * would misread every code as already expired (the exact bug fixed
 * in admin/pages/recycle-bin.php's OTP check earlier in this project).
 */
function b2b_verify_otp(string $channel, string $destination, string $code, string $purpose = 'registration'): bool
{
    $pdo = db();
    $stmt = $pdo->prepare(
        'SELECT *, (NOW() > expires_at) AS is_expired FROM b2b_otps
         WHERE channel = :channel AND destination = :dest AND purpose = :purpose AND consumed_at IS NULL
         ORDER BY id DESC LIMIT 1'
    );
    $stmt->execute(['channel' => $channel, 'dest' => $destination, 'purpose' => $purpose]);
    $otp = $stmt->fetch();

    if (!$otp || (bool) $otp['is_expired'] || (int) $otp['attempts'] >= 5) {
        return false;
    }

    if (!hash_equals($otp['code_hash'], hash('sha256', $code))) {
        $pdo->prepare('UPDATE b2b_otps SET attempts = attempts + 1 WHERE id = :id')->execute(['id' => $otp['id']]);
        return false;
    }

    $pdo->prepare('UPDATE b2b_otps SET consumed_at = NOW() WHERE id = :id')->execute(['id' => $otp['id']]);
    return true;
}

/** True if this channel+destination+purpose has ever been successfully verified (i.e. a consumed OTP row exists). */
function b2b_is_verified(string $channel, string $destination, string $purpose = 'registration'): bool
{
    $stmt = db()->prepare('SELECT COUNT(*) FROM b2b_otps WHERE channel = :channel AND destination = :dest AND purpose = :purpose AND consumed_at IS NOT NULL');
    $stmt->execute(['channel' => $channel, 'dest' => $destination, 'purpose' => $purpose]);
    return (int) $stmt->fetchColumn() > 0;
}

/** Same shape as store_partner_document_upload() (includes/documents.php) — separate table, separate uploader identity. */
function store_b2b_partner_document(array $file, string $documentType, int $b2bPartnerId, ?int $uploadedByUserId): int
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

    $finfo = finfo_open(FILEINFO_MIME_TYPE);
    $mimeType = finfo_file($finfo, $destination) ?: 'application/octet-stream';
    finfo_close($finfo);

    $stmt = db()->prepare(
        'INSERT INTO b2b_partner_documents (b2b_partner_id, document_type, original_filename, stored_filename, storage_path, mime_type, file_size, uploaded_by)
         VALUES (:partner_id, :doc_type, :original_name, :stored_name, :storage_path, :mime, :size, :uploaded_by)'
    );
    $stmt->execute([
        'partner_id' => $b2bPartnerId,
        'doc_type' => $documentType,
        'original_name' => basename($originalName),
        'stored_name' => $storedFilename,
        'storage_path' => 'storage/documents/' . $storedFilename,
        'mime' => $mimeType,
        'size' => $file['size'],
        'uploaded_by' => $uploadedByUserId,
    ]);

    return (int) db()->lastInsertId();
}

/** Records a status transition in b2b_status_history and updates b2b_partners.status together. */
function b2b_change_status(int $partnerId, string $newStatus, ?int $changedBy, ?string $reason = null): void
{
    $stmt = db()->prepare('SELECT status FROM b2b_partners WHERE id = :id');
    $stmt->execute(['id' => $partnerId]);
    $old = $stmt->fetchColumn();
    if ($old === $newStatus) {
        return;
    }

    db()->prepare('UPDATE b2b_partners SET status = :status WHERE id = :id')->execute(['status' => $newStatus, 'id' => $partnerId]);
    db()->prepare('INSERT INTO b2b_status_history (b2b_partner_id, old_status, new_status, changed_by, reason) VALUES (:id, :old, :new, :by, :reason)')
        ->execute(['id' => $partnerId, 'old' => $old ?: null, 'new' => $newStatus, 'by' => $changedBy, 'reason' => $reason]);
}

/**
 * Delivers an OTP code. Email is sent via the existing SMTP client.
 * There is no SMS/WhatsApp gateway configured in this project (the
 * spec calls this "integration-ready", not required) — until one is
 * added, the mobile OTP is honestly surfaced back to the visitor on
 * screen after being generated, exactly the way this codebase already
 * shows a dev-only verification link when SMTP isn't configured (see
 * partner/pages/register-contact.php's $devVerifyLink), rather than
 * pretending an SMS silently went out.
 */
function b2b_deliver_email_otp(string $email, string $code): void
{
    send_mail(
        $email,
        'Your Visagiri B2B Partner Verification Code',
        '<p>Your email verification code is:</p><p style="font-size:24px;font-weight:bold;letter-spacing:4px">' . e($code) . '</p><p>This code expires in 10 minutes.</p>',
        null
    );
}
