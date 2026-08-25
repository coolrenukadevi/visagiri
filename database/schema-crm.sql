-- Visagiri CRM schema extension — Phase 1 (core CRM): customers, the
-- visa enquiry-to-application pipeline, attestation/general enquiries,
-- document management, RBAC, and audit logging. Scoped to the two
-- confirmed real service lines (visa consultancy, document
-- attestation) — no forex, tour-package, hotel, flight, or travel-
-- insurance tables, since none of those have ever been confirmed as
-- real Visagiri services anywhere in this project. Run after
-- database/schema.sql and database/seed.sql on a fresh install; on
-- this project's own working database it's applied as a migration
-- (see AUDIT.md).

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ---------------------------------------------------------------------
-- RBAC
-- ---------------------------------------------------------------------
CREATE TABLE roles (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    slug VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE permissions (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    permission_key VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255) NULL
) ENGINE=InnoDB;

CREATE TABLE role_permissions (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    role_id BIGINT UNSIGNED NOT NULL,
    permission_id BIGINT UNSIGNED NOT NULL,
    UNIQUE KEY uniq_role_permission (role_id, permission_id),
    CONSTRAINT fk_rp_role FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
    CONSTRAINT fk_rp_permission FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Login session log — NOT a replacement for PHP's own session storage
-- (that stays file-based via session_start(), unchanged). This is an
-- audit/visibility trail: what sessions exist, from where, so staff
-- activity can be reviewed and a session can be force-expired. See
-- AUDIT.md for why this is a log table rather than the session store
-- itself.
CREATE TABLE user_sessions (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    admin_user_id BIGINT UNSIGNED NOT NULL,
    session_token_hash CHAR(64) NOT NULL,
    ip_address VARCHAR(45) NULL,
    user_agent VARCHAR(255) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_activity_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    expired_at DATETIME NULL,
    KEY idx_sessions_admin (admin_user_id),
    KEY idx_sessions_token (session_token_hash),
    CONSTRAINT fk_sessions_admin FOREIGN KEY (admin_user_id) REFERENCES admin_users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE password_resets (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    admin_user_id BIGINT UNSIGNED NOT NULL,
    token_hash CHAR(64) NOT NULL,
    expires_at DATETIME NOT NULL,
    used_at DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_pwreset_admin FOREIGN KEY (admin_user_id) REFERENCES admin_users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Full audit trail of every login attempt (success or fail), distinct
-- from rate_limits (the actual throttling counter, unchanged).
CREATE TABLE login_attempts (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    ip_address VARCHAR(45) NULL,
    user_agent VARCHAR(255) NULL,
    success TINYINT(1) NOT NULL DEFAULT 0,
    attempted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_login_attempts_username (username),
    KEY idx_login_attempts_time (attempted_at)
) ENGINE=InnoDB;

ALTER TABLE admin_users
    ADD COLUMN role_id BIGINT UNSIGNED NULL AFTER full_name,
    ADD CONSTRAINT fk_admin_users_role FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE SET NULL;

-- ---------------------------------------------------------------------
-- Customers
-- ---------------------------------------------------------------------
CREATE TABLE customers (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_reference_no VARCHAR(30) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100) NULL,
    last_name VARCHAR(100) NULL,
    date_of_birth DATE NULL,
    gender ENUM('male', 'female', 'other') NULL,
    nationality VARCHAR(100) NULL,
    -- Passport number is sensitive PII: never stored in plain text.
    -- passport_number_encrypted holds an AES-256-GCM ciphertext
    -- (base64), decrypted only when displayed to authorized staff;
    -- passport_number_hash is a keyed HMAC of the plaintext, used for
    -- exact-match search without ever decrypting stored rows. Both
    -- derive from config/site.php's ENCRYPTION_KEY — see
    -- includes/encryption.php.
    passport_number_encrypted TEXT NULL,
    passport_number_hash CHAR(64) NULL,
    passport_issue_date DATE NULL,
    passport_expiry_date DATE NULL,
    email VARCHAR(190) NULL,
    mobile VARCHAR(20) NULL,
    alternate_mobile VARCHAR(20) NULL,
    address TEXT NULL,
    city VARCHAR(100) NULL,
    state VARCHAR(100) NULL,
    country VARCHAR(100) NULL,
    pincode VARCHAR(20) NULL,
    preferred_contact_method ENUM('email', 'mobile', 'whatsapp') NULL,
    customer_source VARCHAR(100) NULL,
    assigned_employee BIGINT UNSIGNED NULL,
    status ENUM('active', 'inactive') NOT NULL DEFAULT 'active',
    deleted_at DATETIME NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_customers_email (email),
    KEY idx_customers_mobile (mobile),
    KEY idx_customers_passport_hash (passport_number_hash),
    KEY idx_customers_status (status),
    KEY idx_customers_assigned (assigned_employee),
    CONSTRAINT fk_customers_assigned FOREIGN KEY (assigned_employee) REFERENCES admin_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_customers_deleted_by FOREIGN KEY (deleted_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Visa enquiry-to-application pipeline
-- ---------------------------------------------------------------------
-- The existing `enquiries` table (real visitor-submitted enquiries,
-- reference format VIS-YYYY-NNNNNN) becomes visa_enquiries — same
-- rows, extended with customer/assignment/priority/source_page. Old
-- reference numbers are left as-is (a real historical fact, not
-- something to rewrite); new ones use the VG-VISA-YYYY-NNNNNN format.
RENAME TABLE enquiries TO visa_enquiries;
ALTER TABLE visa_enquiries
    ADD COLUMN customer_id BIGINT UNSIGNED NULL AFTER reference_number,
    ADD COLUMN assigned_user BIGINT UNSIGNED NULL AFTER visa_type_id,
    ADD COLUMN priority ENUM('low', 'normal', 'high', 'urgent') NOT NULL DEFAULT 'normal' AFTER status,
    ADD COLUMN source_page VARCHAR(255) NULL AFTER ip_address,
    ADD CONSTRAINT fk_ve_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL,
    ADD CONSTRAINT fk_ve_assigned FOREIGN KEY (assigned_user) REFERENCES admin_users(id) ON DELETE SET NULL,
    ADD KEY idx_ve_status (status),
    ADD KEY idx_ve_assigned (assigned_user);

CREATE TABLE visa_applications (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    application_reference_no VARCHAR(30) NOT NULL UNIQUE,
    visa_enquiry_id BIGINT UNSIGNED NULL,
    customer_id BIGINT UNSIGNED NOT NULL,
    country_id BIGINT UNSIGNED NOT NULL,
    visa_type_id BIGINT UNSIGNED NOT NULL,
    status ENUM('draft', 'documents_pending', 'submitted', 'under_review', 'approved', 'rejected', 'completed', 'cancelled') NOT NULL DEFAULT 'draft',
    priority ENUM('low', 'normal', 'high', 'urgent') NOT NULL DEFAULT 'normal',
    assigned_user BIGINT UNSIGNED NULL,
    travel_date DATE NULL,
    notes TEXT NULL,
    deleted_at DATETIME NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_va_status (status),
    KEY idx_va_assigned (assigned_user),
    KEY idx_va_country (country_id),
    KEY idx_va_visa_type (visa_type_id),
    KEY idx_va_customer (customer_id),
    CONSTRAINT fk_va_enquiry FOREIGN KEY (visa_enquiry_id) REFERENCES visa_enquiries(id) ON DELETE SET NULL,
    CONSTRAINT fk_va_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    CONSTRAINT fk_va_country FOREIGN KEY (country_id) REFERENCES countries(id),
    CONSTRAINT fk_va_visa_type FOREIGN KEY (visa_type_id) REFERENCES visa_types(id),
    CONSTRAINT fk_va_assigned FOREIGN KEY (assigned_user) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Multiple people per application (family/group visas).
CREATE TABLE visa_applicants (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    visa_application_id BIGINT UNSIGNED NOT NULL,
    full_name VARCHAR(200) NOT NULL,
    relationship_to_primary VARCHAR(100) NULL,
    date_of_birth DATE NULL,
    passport_number_encrypted TEXT NULL,
    passport_number_hash CHAR(64) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_applicants_hash (passport_number_hash),
    CONSTRAINT fk_applicants_application FOREIGN KEY (visa_application_id) REFERENCES visa_applications(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE visa_application_notes (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    visa_application_id BIGINT UNSIGNED NOT NULL,
    admin_user_id BIGINT UNSIGNED NULL,
    note TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_notes_application FOREIGN KEY (visa_application_id) REFERENCES visa_applications(id) ON DELETE CASCADE,
    CONSTRAINT fk_notes_admin FOREIGN KEY (admin_user_id) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE visa_application_history (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    visa_application_id BIGINT UNSIGNED NOT NULL,
    old_status VARCHAR(50) NULL,
    new_status VARCHAR(50) NOT NULL,
    changed_by BIGINT UNSIGNED NULL,
    changed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_history_application FOREIGN KEY (visa_application_id) REFERENCES visa_applications(id) ON DELETE CASCADE,
    CONSTRAINT fk_history_admin FOREIGN KEY (changed_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE visa_quotes (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    quote_reference_no VARCHAR(30) NOT NULL UNIQUE,
    visa_application_id BIGINT UNSIGNED NULL,
    visa_enquiry_id BIGINT UNSIGNED NULL,
    government_fee DECIMAL(10, 2) NULL,
    service_fee DECIMAL(10, 2) NULL,
    currency VARCHAR(3) NOT NULL DEFAULT 'INR',
    notes TEXT NULL,
    status ENUM('draft', 'sent', 'accepted', 'rejected') NOT NULL DEFAULT 'draft',
    created_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_quotes_application FOREIGN KEY (visa_application_id) REFERENCES visa_applications(id) ON DELETE CASCADE,
    CONSTRAINT fk_quotes_enquiry FOREIGN KEY (visa_enquiry_id) REFERENCES visa_enquiries(id) ON DELETE CASCADE,
    CONSTRAINT fk_quotes_admin FOREIGN KEY (created_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Manual CRM payment tracking — no payment gateway integration exists
-- or was requested; staff record what's been collected.
CREATE TABLE visa_payments (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    visa_application_id BIGINT UNSIGNED NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) NOT NULL DEFAULT 'INR',
    payment_method VARCHAR(50) NULL,
    payment_reference VARCHAR(100) NULL,
    status ENUM('pending', 'received', 'refunded') NOT NULL DEFAULT 'pending',
    recorded_by BIGINT UNSIGNED NULL,
    paid_at DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_payments_status (status),
    CONSTRAINT fk_payments_application FOREIGN KEY (visa_application_id) REFERENCES visa_applications(id) ON DELETE CASCADE,
    CONSTRAINT fk_payments_admin FOREIGN KEY (recorded_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- General enquiries — attestation services + the general contact form.
-- Replaces contact_messages (folded in below) so there's one table for
-- every non-visa-specific enquiry, not two overlapping ones.
-- ---------------------------------------------------------------------
CREATE TABLE general_enquiries (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    enquiry_reference_no VARCHAR(30) NOT NULL UNIQUE,
    customer_id BIGINT UNSIGNED NULL,
    service_type VARCHAR(100) NOT NULL,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(190) NOT NULL,
    phone VARCHAR(20) NULL,
    subject VARCHAR(255) NULL,
    description TEXT NOT NULL,
    source_page VARCHAR(255) NULL,
    assigned_user BIGINT UNSIGNED NULL,
    priority ENUM('low', 'normal', 'high', 'urgent') NOT NULL DEFAULT 'normal',
    status ENUM('new', 'in_progress', 'resolved', 'closed') NOT NULL DEFAULT 'new',
    ip_address VARCHAR(45) NULL,
    deleted_at DATETIME NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_ge_status (status),
    KEY idx_ge_service (service_type),
    KEY idx_ge_assigned (assigned_user),
    CONSTRAINT fk_ge_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL,
    CONSTRAINT fk_ge_assigned FOREIGN KEY (assigned_user) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

INSERT INTO general_enquiries (enquiry_reference_no, service_type, name, email, phone, subject, description, source_page, status, ip_address, created_at, updated_at)
SELECT
    CONCAT('VG-GEN-', YEAR(created_at), '-', LPAD(id, 6, '0')),
    'general',
    name,
    email,
    phone,
    'Contact form submission',
    CONCAT(IF(destination IS NOT NULL, CONCAT('Destination: ', destination, '\n\n'), ''), message),
    '/contact/',
    IF(status = 'unread', 'new', IF(status = 'replied', 'resolved', 'in_progress')),
    ip_address,
    created_at,
    updated_at
FROM contact_messages;

DROP TABLE contact_messages;

-- ---------------------------------------------------------------------
-- Documents — staff-uploaded, on behalf of a visa application or a
-- general (attestation) enquiry. No public customer upload portal
-- exists in this project, so uploaded_by is always a staff member.
-- ---------------------------------------------------------------------
CREATE TABLE documents (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id BIGINT UNSIGNED NULL,
    visa_application_id BIGINT UNSIGNED NULL,
    general_enquiry_id BIGINT UNSIGNED NULL,
    document_type VARCHAR(100) NULL,
    original_filename VARCHAR(255) NOT NULL,
    stored_filename VARCHAR(255) NOT NULL,
    storage_path VARCHAR(500) NOT NULL,
    mime_type VARCHAR(100) NOT NULL,
    file_size INT UNSIGNED NOT NULL,
    uploaded_by BIGINT UNSIGNED NOT NULL,
    uploaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    verification_status ENUM('pending', 'verified', 'rejected') NOT NULL DEFAULT 'pending',
    verified_by BIGINT UNSIGNED NULL,
    verified_at DATETIME NULL,
    deleted_at DATETIME NULL,
    KEY idx_docs_application (visa_application_id),
    KEY idx_docs_enquiry (general_enquiry_id),
    KEY idx_docs_status (verification_status),
    CONSTRAINT fk_docs_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL,
    CONSTRAINT fk_docs_application FOREIGN KEY (visa_application_id) REFERENCES visa_applications(id) ON DELETE CASCADE,
    CONSTRAINT fk_docs_enquiry FOREIGN KEY (general_enquiry_id) REFERENCES general_enquiries(id) ON DELETE CASCADE,
    CONSTRAINT fk_docs_uploader FOREIGN KEY (uploaded_by) REFERENCES admin_users(id),
    CONSTRAINT fk_docs_verifier FOREIGN KEY (verified_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Audit log
-- ---------------------------------------------------------------------
CREATE TABLE audit_logs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    admin_user_id BIGINT UNSIGNED NULL,
    action VARCHAR(100) NOT NULL,
    module VARCHAR(100) NOT NULL,
    record_id BIGINT UNSIGNED NULL,
    ip_address VARCHAR(45) NULL,
    user_agent VARCHAR(255) NULL,
    old_value TEXT NULL,
    new_value TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_audit_module (module),
    KEY idx_audit_admin (admin_user_id),
    KEY idx_audit_created (created_at),
    CONSTRAINT fk_audit_admin FOREIGN KEY (admin_user_id) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

SET FOREIGN_KEY_CHECKS = 1;
