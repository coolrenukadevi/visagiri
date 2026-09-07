<?php
declare(strict_types=1);

/**
 * Helpers for B2B Travel Partner Portal visa enquiries
 * (b2b_visa_enquiries + related tables) — Phase B6. Reuses the same
 * b2b_travel_partners.view/.manage permissions on the admin side
 * rather than introducing new keys, since enquiry management is a
 * sub-resource of B2B partner management, same as how the old
 * partner system's partners.view already covers partner_enquiries.
 */

const B2B_ENQUIRY_STATUS_LABELS = [
    'new' => 'New',
    'in_progress' => 'In Progress',
    'documents_pending' => 'Documents Pending',
    'submitted' => 'Submitted to Embassy',
    'payment_pending' => 'Payment Pending',
    'completed' => 'Completed',
    'rejected' => 'Rejected',
    'cancelled' => 'Cancelled',
];

const B2B_ENQUIRY_DOCUMENT_TYPES = [
    'passport_copy' => 'Passport Copy',
    'photograph' => 'Passport-size Photograph',
    'invitation_letter' => 'Invitation Letter',
    'travel_itinerary' => 'Travel Itinerary',
    'hotel_booking' => 'Hotel Booking Confirmation',
    'financial_proof' => 'Financial / Bank Statement',
    'employment_letter' => 'Employment / NOC Letter',
    'other' => 'Other Supporting Document',
];

const B2B_APPLICANT_RELATIONSHIPS = [
    'self' => 'Self / Lead Applicant',
    'spouse' => 'Spouse',
    'child' => 'Child',
    'parent' => 'Parent',
    'employee' => 'Employee',
    'colleague' => 'Colleague',
    'other' => 'Other',
];

/** VG-B2BENQ-YYYY-NNNNNN, same shared generator every other CRM entity in this project uses. */
function b2b_generate_enquiry_reference(): string
{
    return generate_reference_number('B2BENQ', 'b2b_visa_enquiries', 'enquiry_reference_no');
}

/**
 * Records a status transition in b2b_enquiry_status_history and
 * updates b2b_visa_enquiries.status together. Exactly one of
 * $changedByAdmin / $changedByPartnerUser should be set — mirrors
 * b2b_change_status()'s shape for partner-status transitions.
 */
function b2b_change_enquiry_status(int $enquiryId, string $newStatus, ?int $changedByAdmin, ?int $changedByPartnerUser, ?string $reason = null): void
{
    $stmt = db()->prepare('SELECT status FROM b2b_visa_enquiries WHERE id = :id');
    $stmt->execute(['id' => $enquiryId]);
    $old = $stmt->fetchColumn();
    if ($old === $newStatus) {
        return;
    }

    db()->prepare('UPDATE b2b_visa_enquiries SET status = :status WHERE id = :id')->execute(['status' => $newStatus, 'id' => $enquiryId]);
    db()->prepare(
        'INSERT INTO b2b_enquiry_status_history (b2b_visa_enquiry_id, old_status, new_status, changed_by_admin, changed_by_partner_user, reason)
         VALUES (:id, :old, :new, :admin, :partner_user, :reason)'
    )->execute([
        'id' => $enquiryId,
        'old' => $old ?: null,
        'new' => $newStatus,
        'admin' => $changedByAdmin,
        'partner_user' => $changedByPartnerUser,
        'reason' => $reason,
    ]);

    // Only notify on an admin-initiated transition — a partner acting
    // on their own enquiry (e.g. cancelling it) doesn't need telling
    // about something they just did themselves.
    if ($changedByAdmin !== null) {
        $refStmt = db()->prepare('SELECT b2b_partner_id, enquiry_reference_no FROM b2b_visa_enquiries WHERE id = :id');
        $refStmt->execute(['id' => $enquiryId]);
        $enquiryRow = $refStmt->fetch();
        if ($enquiryRow) {
            $label = B2B_ENQUIRY_STATUS_LABELS[$newStatus] ?? $newStatus;
            notify_b2b_partner(
                (int) $enquiryRow['b2b_partner_id'],
                'enquiry_status_change',
                'Enquiry ' . $enquiryRow['enquiry_reference_no'] . ' — ' . $label,
                $reason,
                '/b2b/enquiries/?action=view&id=' . $enquiryId
            );
        }
    }
}

/** Same shape as store_b2b_partner_document() — separate table, enquiry-scoped. */
function store_b2b_enquiry_document(array $file, string $documentType, int $enquiryId, ?int $uploadedByUserId): int
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
        'INSERT INTO b2b_enquiry_documents (b2b_visa_enquiry_id, document_type, original_filename, stored_filename, storage_path, mime_type, file_size, uploaded_by)
         VALUES (:enquiry_id, :doc_type, :original_name, :stored_name, :storage_path, :mime, :size, :uploaded_by)'
    );
    $stmt->execute([
        'enquiry_id' => $enquiryId,
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
