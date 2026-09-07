-- B2B Travel Partner Portal — Phase B6: visa enquiries submitted by a
-- partner on behalf of their end clients. Deliberately separate from
-- the unified `enquiries` table (used by public-facing customer/
-- consultant CRM) and from the old partner system's `visa_applications`
-- — this is the B2B portal's own case-management entity, same
-- standalone-by-design decision as the rest of this module.

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE b2b_visa_enquiries (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    enquiry_reference_no VARCHAR(30) NOT NULL UNIQUE,
    b2b_partner_id BIGINT UNSIGNED NOT NULL,
    created_by_user_id BIGINT UNSIGNED NOT NULL,

    destination_country_id BIGINT UNSIGNED NOT NULL,
    visa_type VARCHAR(60) NOT NULL,
    purpose_of_travel VARCHAR(255) NULL,
    intended_travel_date DATE NULL,
    number_of_applicants SMALLINT UNSIGNED NOT NULL DEFAULT 1,
    special_requirements TEXT NULL,

    status ENUM('new', 'in_progress', 'documents_pending', 'submitted', 'payment_pending', 'completed', 'rejected', 'cancelled') NOT NULL DEFAULT 'new',
    assigned_admin_id BIGINT UNSIGNED NULL,

    submitted_at DATETIME NULL,
    deleted_at DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY idx_b2b_enquiries_partner (b2b_partner_id),
    KEY idx_b2b_enquiries_status (status),
    KEY idx_b2b_enquiries_deleted (deleted_at),
    CONSTRAINT fk_b2b_enquiries_partner FOREIGN KEY (b2b_partner_id) REFERENCES b2b_partners(id) ON DELETE CASCADE,
    CONSTRAINT fk_b2b_enquiries_created_by FOREIGN KEY (created_by_user_id) REFERENCES b2b_partner_users(id) ON DELETE RESTRICT,
    CONSTRAINT fk_b2b_enquiries_country FOREIGN KEY (destination_country_id) REFERENCES countries(id) ON DELETE RESTRICT,
    CONSTRAINT fk_b2b_enquiries_assigned FOREIGN KEY (assigned_admin_id) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Passport number is encrypted at rest (encrypt_value(), same AES-256-GCM
-- helper used for billing/banking) — this is the same class of sensitive
-- identity data as the existing partner PAN/GSTIN handling.
CREATE TABLE b2b_enquiry_applicants (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    b2b_visa_enquiry_id BIGINT UNSIGNED NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    date_of_birth DATE NULL,
    nationality VARCHAR(100) NULL,
    passport_number_encrypted TEXT NULL,
    relationship_to_lead VARCHAR(60) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_b2b_applicants_enquiry (b2b_visa_enquiry_id),
    CONSTRAINT fk_b2b_applicants_enquiry FOREIGN KEY (b2b_visa_enquiry_id) REFERENCES b2b_visa_enquiries(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Documents attached at the enquiry level (not per-applicant) — same
-- simplification the client's own existing partner_documents/
-- b2b_partner_documents tables already make for KYC docs; a case with
-- multiple applicants still shares one document set in this phase.
CREATE TABLE b2b_enquiry_documents (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    b2b_visa_enquiry_id BIGINT UNSIGNED NOT NULL,
    document_type VARCHAR(60) NOT NULL,
    original_filename VARCHAR(255) NOT NULL,
    stored_filename VARCHAR(255) NOT NULL,
    storage_path VARCHAR(255) NOT NULL,
    mime_type VARCHAR(100) NOT NULL,
    file_size INT UNSIGNED NOT NULL,
    verification_status ENUM('uploaded', 'verified', 'rejected') NOT NULL DEFAULT 'uploaded',
    verification_remarks VARCHAR(500) NULL,
    uploaded_by BIGINT UNSIGNED NULL,
    reviewed_by BIGINT UNSIGNED NULL,
    reviewed_at DATETIME NULL,
    deleted_at DATETIME NULL,
    uploaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_b2b_enq_docs_enquiry (b2b_visa_enquiry_id),
    KEY idx_b2b_enq_docs_deleted (deleted_at),
    CONSTRAINT fk_b2b_enq_docs_enquiry FOREIGN KEY (b2b_visa_enquiry_id) REFERENCES b2b_visa_enquiries(id) ON DELETE CASCADE,
    CONSTRAINT fk_b2b_enq_docs_uploaded_by FOREIGN KEY (uploaded_by) REFERENCES b2b_partner_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_b2b_enq_docs_reviewed_by FOREIGN KEY (reviewed_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE b2b_enquiry_status_history (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    b2b_visa_enquiry_id BIGINT UNSIGNED NOT NULL,
    old_status VARCHAR(40) NULL,
    new_status VARCHAR(40) NOT NULL,
    changed_by_admin BIGINT UNSIGNED NULL,
    changed_by_partner_user BIGINT UNSIGNED NULL,
    reason VARCHAR(500) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_b2b_enq_history_enquiry (b2b_visa_enquiry_id),
    CONSTRAINT fk_b2b_enq_history_enquiry FOREIGN KEY (b2b_visa_enquiry_id) REFERENCES b2b_visa_enquiries(id) ON DELETE CASCADE,
    CONSTRAINT fk_b2b_enq_history_admin FOREIGN KEY (changed_by_admin) REFERENCES admin_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_b2b_enq_history_partner_user FOREIGN KEY (changed_by_partner_user) REFERENCES b2b_partner_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
