-- Unified Enquiry System v2 — replaces the public-facing role of
-- visa_enquiries (still kept, read-only, for historical records) and
-- the apostille slice of general_enquiries with one entity that
-- covers both Visa and Apostille enquiries, with real document
-- upload, a status workflow, a PDF receipt, and secure tracking.
-- Additive only — run after schema-crm.sql (customers, admin_users,
-- countries, visa_types already exist).

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE enquiries (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    enquiry_number VARCHAR(30) NOT NULL,
    tracking_token VARCHAR(20) NOT NULL,
    service_category ENUM('visa', 'apostille') NOT NULL,

    -- Customer info (Step 1 — both service categories)
    customer_id BIGINT UNSIGNED NULL,
    name VARCHAR(150) NOT NULL,
    mobile_country_code VARCHAR(6) NOT NULL DEFAULT '+91',
    mobile_number VARCHAR(20) NOT NULL,
    mobile_normalized VARCHAR(20) NOT NULL,
    email VARCHAR(190) NOT NULL,
    current_city VARCHAR(100) NOT NULL,
    current_state VARCHAR(100) NOT NULL,

    -- Visa-specific (Step 2, service_category = visa)
    destination_country_id BIGINT UNSIGNED NULL,
    visa_type_id BIGINT UNSIGNED NULL,
    passport_number_encrypted TEXT NULL,
    passport_number_hash CHAR(64) NULL,
    passport_issued_from VARCHAR(150) NULL,
    journey_date DATE NULL,
    pax_count SMALLINT UNSIGNED NOT NULL DEFAULT 1,

    -- Apostille-specific (Step 2, service_category = apostille)
    apostille_service_type VARCHAR(60) NULL,
    apostille_document_type VARCHAR(100) NULL,
    apostille_document_count SMALLINT UNSIGNED NULL,
    apostille_destination_country_id BIGINT UNSIGNED NULL,
    apostille_purpose VARCHAR(255) NULL,

    remarks TEXT NULL,
    declaration_accepted_at DATETIME NULL,

    status VARCHAR(40) NOT NULL DEFAULT 'new_enquiry',
    priority ENUM('low', 'normal', 'high', 'urgent') NOT NULL DEFAULT 'normal',
    assigned_user BIGINT UNSIGNED NULL,

    pdf_path VARCHAR(255) NULL,
    pdf_generated_at DATETIME NULL,
    email_status ENUM('pending', 'sent', 'failed') NOT NULL DEFAULT 'pending',
    email_sent_at DATETIME NULL,

    ip_address VARCHAR(45) NULL,
    source_page VARCHAR(255) NULL,

    deleted_at DATETIME NULL,
    deleted_by BIGINT UNSIGNED NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    UNIQUE KEY uniq_enquiry_number (enquiry_number),
    UNIQUE KEY uniq_tracking_token (tracking_token),
    KEY idx_enq_status (status),
    KEY idx_enq_category (service_category),
    KEY idx_enq_assigned (assigned_user),
    KEY idx_enq_created (created_at),
    KEY idx_enq_passport_hash (passport_number_hash),
    KEY idx_enq_email (email),
    KEY idx_enq_mobile (mobile_normalized),
    KEY idx_enq_deleted (deleted_at),
    CONSTRAINT fk_enq_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL,
    CONSTRAINT fk_enq_country FOREIGN KEY (destination_country_id) REFERENCES countries(id) ON DELETE SET NULL,
    CONSTRAINT fk_enq_visa_type FOREIGN KEY (visa_type_id) REFERENCES visa_types(id) ON DELETE SET NULL,
    CONSTRAINT fk_enq_apostille_country FOREIGN KEY (apostille_destination_country_id) REFERENCES countries(id) ON DELETE SET NULL,
    CONSTRAINT fk_enq_assigned FOREIGN KEY (assigned_user) REFERENCES admin_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_enq_deleted_by FOREIGN KEY (deleted_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE enquiry_documents (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    enquiry_id BIGINT UNSIGNED NOT NULL,
    document_category VARCHAR(60) NOT NULL,
    original_filename VARCHAR(255) NOT NULL,
    stored_filename VARCHAR(255) NOT NULL,
    storage_path VARCHAR(255) NOT NULL,
    mime_type VARCHAR(100) NOT NULL,
    file_size INT UNSIGNED NOT NULL,
    review_status ENUM('uploaded', 'under_review', 'verified', 'rejected', 'copy_required') NOT NULL DEFAULT 'uploaded',
    review_remarks VARCHAR(500) NULL,
    reviewed_by BIGINT UNSIGNED NULL,
    reviewed_at DATETIME NULL,
    uploaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_enq_doc_enquiry (enquiry_id),
    KEY idx_enq_doc_category (document_category),
    CONSTRAINT fk_enq_doc_enquiry FOREIGN KEY (enquiry_id) REFERENCES enquiries(id) ON DELETE CASCADE,
    CONSTRAINT fk_enq_doc_reviewed_by FOREIGN KEY (reviewed_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE enquiry_status_history (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    enquiry_id BIGINT UNSIGNED NOT NULL,
    old_status VARCHAR(40) NULL,
    new_status VARCHAR(40) NOT NULL,
    changed_by BIGINT UNSIGNED NULL,
    remarks VARCHAR(500) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_enq_hist_enquiry (enquiry_id),
    CONSTRAINT fk_enq_hist_enquiry FOREIGN KEY (enquiry_id) REFERENCES enquiries(id) ON DELETE CASCADE,
    CONSTRAINT fk_enq_hist_changed_by FOREIGN KEY (changed_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- CMS-configurable document requirement rules — "for this service
-- category + visa type (+ optional country override), is this
-- document category mandatory?" Looked up by
-- enquiry_document_requirements_for() in includes/enquiry.php, which
-- falls back to a sane built-in default (see that function) when no
-- row matches, so the form is never left with zero guidance if the
-- admin hasn't configured anything yet.
CREATE TABLE enquiry_document_requirements (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    service_category ENUM('visa', 'apostille') NOT NULL,
    visa_type_id BIGINT UNSIGNED NULL,
    country_id BIGINT UNSIGNED NULL,
    document_category VARCHAR(60) NOT NULL,
    is_mandatory TINYINT(1) NOT NULL DEFAULT 0,
    sort_order INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uniq_doc_rule (service_category, visa_type_id, country_id, document_category),
    KEY idx_doc_rule_visa_type (visa_type_id),
    CONSTRAINT fk_doc_rule_visa_type FOREIGN KEY (visa_type_id) REFERENCES visa_types(id) ON DELETE CASCADE,
    CONSTRAINT fk_doc_rule_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Superadmin-only Recycle Bin restore, step-up verified by a one-time
-- code emailed to a fixed operational address (not the admin's own
-- inbox) rather than trusting the session alone for an action that
-- reverses a soft-delete.
CREATE TABLE recycle_bin_otps (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    admin_user_id BIGINT UNSIGNED NOT NULL,
    code_hash CHAR(64) NOT NULL,
    table_name VARCHAR(60) NOT NULL,
    record_id BIGINT UNSIGNED NOT NULL,
    expires_at DATETIME NOT NULL,
    consumed_at DATETIME NULL,
    attempts TINYINT UNSIGNED NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_recycle_otp_admin (admin_user_id),
    CONSTRAINT fk_recycle_otp_admin FOREIGN KEY (admin_user_id) REFERENCES admin_users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
