-- B2B Travel Partner Portal — a deliberately separate system from the
-- existing partners/partner_* tables (schema-crm.sql, schema-b2b*.sql),
-- per explicit instruction to build this as a standalone module
-- alongside the existing partner program rather than extend it.
-- Shared low-level infrastructure (admin_users, roles/permissions,
-- countries, audit_logs, documents-validation helpers, encryption,
-- reference-number generator) is reused — only the partner-entity
-- tables and public-facing flow are new.

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE b2b_partners (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    partner_reference_no VARCHAR(30) NOT NULL UNIQUE,

    -- Step 1: Business Information
    legal_business_name VARCHAR(200) NOT NULL,
    trade_name VARCHAR(200) NULL,
    business_type ENUM('travel_agency', 'tour_operator', 'corporate_travel_company', 'online_travel_agency', 'dmc', 'visa_consultant', 'immigration_consultant', 'corporate', 'hotel_hospitality', 'educational_institution', 'other') NOT NULL,
    registration_type VARCHAR(100) NULL,
    year_established SMALLINT UNSIGNED NULL,
    office_address TEXT NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL DEFAULT 'India',
    pincode VARCHAR(20) NOT NULL,
    website VARCHAR(255) NULL,
    business_email VARCHAR(190) NOT NULL,
    business_phone VARCHAR(20) NOT NULL,
    whatsapp_number VARCHAR(20) NULL,
    gstin VARCHAR(15) NULL,
    pan VARCHAR(10) NULL,
    company_registration_number VARCHAR(100) NULL,
    iata_number VARCHAR(50) NULL,
    tids_number VARCHAR(50) NULL,
    udyam_number VARCHAR(50) NULL,
    other_membership VARCHAR(255) NULL,
    employee_count VARCHAR(20) NULL,
    monthly_visa_volume ENUM('1-10', '11-25', '26-50', '51-100', '100+') NULL,
    primary_business_activity VARCHAR(255) NULL,

    -- Workflow
    status ENUM('draft', 'submitted', 'under_review', 'documents_required', 'verification_pending', 'approved', 'active', 'suspended', 'rejected', 'blacklisted', 'closed') NOT NULL DEFAULT 'draft',
    assigned_relationship_manager BIGINT UNSIGNED NULL,
    rejection_reason VARCHAR(500) NULL,
    submitted_at DATETIME NULL,
    approved_at DATETIME NULL,

    -- Declaration
    declaration_accepted_at DATETIME NULL,
    terms_accepted_at DATETIME NULL,
    privacy_accepted_at DATETIME NULL,
    verification_consent_at DATETIME NULL,
    declaration_ip VARCHAR(45) NULL,

    ip_address VARCHAR(45) NULL,
    deleted_at DATETIME NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY idx_b2b_partners_status (status),
    KEY idx_b2b_partners_gstin (gstin),
    KEY idx_b2b_partners_pan (pan),
    KEY idx_b2b_partners_email (business_email),
    KEY idx_b2b_partners_deleted (deleted_at),
    CONSTRAINT fk_b2b_partners_rm FOREIGN KEY (assigned_relationship_manager) REFERENCES admin_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_b2b_partners_deleted_by FOREIGN KEY (deleted_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Individual logins under one partner organisation. The first user
-- created at registration (Step 2) is always 'partner_admin'; that
-- user can later invite colleagues under the other roles.
CREATE TABLE b2b_partner_users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    b2b_partner_id BIGINT UNSIGNED NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    designation ENUM('owner', 'director', 'partner', 'manager', 'travel_consultant', 'visa_consultant', 'operations_manager', 'corporate_travel_manager', 'other') NOT NULL,
    email VARCHAR(190) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    mobile_country_code VARCHAR(6) NOT NULL DEFAULT '+91',
    mobile_number VARCHAR(20) NOT NULL,
    whatsapp_number VARCHAR(20) NULL,
    alternate_email VARCHAR(190) NULL,
    alternate_contact VARCHAR(20) NULL,
    preferred_communication ENUM('email', 'mobile', 'whatsapp') NOT NULL DEFAULT 'email',
    role ENUM('partner_admin', 'partner_manager', 'partner_agent', 'partner_finance') NOT NULL DEFAULT 'partner_admin',
    email_verified_at DATETIME NULL,
    mobile_verified_at DATETIME NULL,
    status ENUM('active', 'suspended') NOT NULL DEFAULT 'active',
    remember_token_hash CHAR(64) NULL,
    reset_token_hash CHAR(64) NULL,
    reset_token_expires_at DATETIME NULL,
    last_login_at DATETIME NULL,
    last_login_ip VARCHAR(45) NULL,
    deleted_at DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY idx_b2b_users_partner (b2b_partner_id),
    KEY idx_b2b_users_deleted (deleted_at),
    CONSTRAINT fk_b2b_users_partner FOREIGN KEY (b2b_partner_id) REFERENCES b2b_partners(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Email/mobile OTP verification during signup — issued against a
-- destination (email address or phone number) rather than a user id,
-- since Step 2 verification happens before or as the account row is
-- created. Same hashed-code + expiry + attempts shape as
-- recycle_bin_otps (database/schema-enquiry-v2.sql), proven pattern.
CREATE TABLE b2b_otps (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    channel ENUM('email', 'mobile') NOT NULL,
    destination VARCHAR(190) NOT NULL,
    purpose VARCHAR(40) NOT NULL DEFAULT 'registration',
    code_hash CHAR(64) NOT NULL,
    expires_at DATETIME NOT NULL,
    consumed_at DATETIME NULL,
    attempts TINYINT UNSIGNED NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_b2b_otps_lookup (channel, destination, purpose)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- KYC / business documents. verification_status has no separate
-- "not_uploaded" state — that's simply the absence of a row for that
-- document_type, matching how enquiry_documents/partner_documents
-- already model this elsewhere in the project.
CREATE TABLE b2b_partner_documents (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    b2b_partner_id BIGINT UNSIGNED NOT NULL,
    document_type ENUM('pan_card', 'gst_certificate', 'company_registration_certificate', 'address_proof', 'authorized_signatory_id', 'business_license', 'travel_agency_license', 'iata_certificate', 'other') NOT NULL,
    original_filename VARCHAR(255) NOT NULL,
    stored_filename VARCHAR(255) NOT NULL,
    storage_path VARCHAR(255) NOT NULL,
    mime_type VARCHAR(100) NOT NULL,
    file_size INT UNSIGNED NOT NULL,
    version INT UNSIGNED NOT NULL DEFAULT 1,
    verification_status ENUM('uploaded', 'under_review', 'verified', 'rejected', 'expired') NOT NULL DEFAULT 'uploaded',
    verification_remarks VARCHAR(500) NULL,
    expiry_date DATE NULL,
    uploaded_by BIGINT UNSIGNED NULL,
    reviewed_by BIGINT UNSIGNED NULL,
    reviewed_at DATETIME NULL,
    deleted_at DATETIME NULL,
    uploaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_b2b_docs_partner (b2b_partner_id),
    KEY idx_b2b_docs_type (document_type),
    KEY idx_b2b_docs_deleted (deleted_at),
    CONSTRAINT fk_b2b_docs_partner FOREIGN KEY (b2b_partner_id) REFERENCES b2b_partners(id) ON DELETE CASCADE,
    CONSTRAINT fk_b2b_docs_uploaded_by FOREIGN KEY (uploaded_by) REFERENCES b2b_partner_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_b2b_docs_reviewed_by FOREIGN KEY (reviewed_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE b2b_partner_services (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    b2b_partner_id BIGINT UNSIGNED NOT NULL,
    service_key VARCHAR(60) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uniq_b2b_service (b2b_partner_id, service_key),
    CONSTRAINT fk_b2b_services_partner FOREIGN KEY (b2b_partner_id) REFERENCES b2b_partners(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Preferred destination countries — references the REAL countries
-- master (schema.sql), never a hard-coded list, per explicit
-- instruction that admin-managed countries must drive this.
CREATE TABLE b2b_partner_countries (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    b2b_partner_id BIGINT UNSIGNED NOT NULL,
    country_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uniq_b2b_country (b2b_partner_id, country_id),
    CONSTRAINT fk_b2b_countries_partner FOREIGN KEY (b2b_partner_id) REFERENCES b2b_partners(id) ON DELETE CASCADE,
    CONSTRAINT fk_b2b_countries_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Banking/billing — sensitive fields encrypted at rest using the
-- project's existing AES-256-GCM helper (includes/encryption.php),
-- same pattern as passport numbers and Forex PAN elsewhere. Only
-- finance/admin roles are ever granted the permission to decrypt
-- these for display (enforced in code, not just hidden in the UI).
CREATE TABLE b2b_partner_billing (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    b2b_partner_id BIGINT UNSIGNED NOT NULL UNIQUE,
    billing_name VARCHAR(200) NULL,
    billing_address TEXT NULL,
    gstin VARCHAR(15) NULL,
    pan VARCHAR(10) NULL,
    bank_name_encrypted TEXT NULL,
    account_holder_encrypted TEXT NULL,
    account_number_encrypted TEXT NULL,
    account_number_hash CHAR(64) NULL,
    ifsc_encrypted TEXT NULL,
    swift_bic VARCHAR(20) NULL,
    payment_terms VARCHAR(100) NULL,
    preferred_currency CHAR(3) NOT NULL DEFAULT 'INR',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_b2b_billing_partner FOREIGN KEY (b2b_partner_id) REFERENCES b2b_partners(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE b2b_status_history (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    b2b_partner_id BIGINT UNSIGNED NOT NULL,
    old_status VARCHAR(40) NULL,
    new_status VARCHAR(40) NOT NULL,
    changed_by BIGINT UNSIGNED NULL,
    reason VARCHAR(500) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_b2b_history_partner (b2b_partner_id),
    CONSTRAINT fk_b2b_history_partner FOREIGN KEY (b2b_partner_id) REFERENCES b2b_partners(id) ON DELETE CASCADE,
    CONSTRAINT fk_b2b_history_changed_by FOREIGN KEY (changed_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
