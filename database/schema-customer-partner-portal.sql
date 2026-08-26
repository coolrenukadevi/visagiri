-- ---------------------------------------------------------------------
-- Customer + Partner Portal — additive migration.
--
-- Restores customer-facing accounts (removed during the earlier
-- "single-folder no-database rebuild", see AUDIT.md) and adds a new
-- partner referral portal, per explicit client request. Everything
-- here is additive: new nullable columns and new tables only, nothing
-- drops or renames existing data. Run after schema-crm.sql.
-- ---------------------------------------------------------------------

-- Customer self-service login. Existing `customers` rows (created via
-- the enquiry/CRM flow, which has no password) simply have
-- password_hash = NULL until the customer registers — is_customer_
-- registered() in includes/customer-auth.php treats that as "no
-- account yet", not "locked out".
ALTER TABLE customers
    ADD COLUMN password_hash VARCHAR(255) NULL AFTER customer_reference_no,
    ADD COLUMN email_verified_at DATETIME NULL AFTER password_hash,
    ADD COLUMN password_reset_token_hash CHAR(64) NULL AFTER email_verified_at,
    ADD COLUMN password_reset_expires_at DATETIME NULL AFTER password_reset_token_hash,
    ADD COLUMN remember_token_hash CHAR(64) NULL AFTER password_reset_expires_at,
    ADD COLUMN remember_token_expires_at DATETIME NULL AFTER remember_token_hash,
    ADD COLUMN referred_by_partner_id BIGINT UNSIGNED NULL AFTER remember_token_expires_at;

-- Documents: `uploaded_by` was NOT NULL and only ever referenced
-- admin_users (see includes/documents.php's own comment: "No public
-- customer upload portal exists"). That's no longer true once the
-- customer dashboard ships, so uploaded_by becomes nullable and a
-- parallel uploaded_by_customer_id is added — application code
-- enforces that exactly one of the two is set, the DB just needs to
-- allow it structurally without breaking every existing staff-
-- uploaded row (which keeps uploaded_by set, uploaded_by_customer_id
-- NULL, unchanged).
ALTER TABLE documents
    MODIFY COLUMN uploaded_by BIGINT UNSIGNED NULL,
    ADD COLUMN uploaded_by_customer_id BIGINT UNSIGNED NULL AFTER uploaded_by,
    ADD CONSTRAINT fk_docs_uploader_customer FOREIGN KEY (uploaded_by_customer_id) REFERENCES customers(id) ON DELETE SET NULL;

-- Application notes become a real two-way thread: existing rows are
-- all staff-authored internal notes (customer_id NULL,
-- visible_to_customer defaults to 0), completely unchanged in
-- behavior. A customer's own dashboard reply sets customer_id and
-- visible_to_customer = 1; staff can also mark their own note visible
-- to surface it as a message rather than an internal note.
ALTER TABLE visa_application_notes
    ADD COLUMN customer_id BIGINT UNSIGNED NULL AFTER admin_user_id,
    ADD COLUMN visible_to_customer TINYINT(1) NOT NULL DEFAULT 0 AFTER note,
    ADD CONSTRAINT fk_notes_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL;

-- In-app notifications for the customer dashboard. Populated by
-- application code on real events only (status change, new message,
-- new document verification result) — never seeded/fabricated.
CREATE TABLE customer_notifications (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id BIGINT UNSIGNED NOT NULL,
    type VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    body TEXT NULL,
    link VARCHAR(255) NULL,
    is_read TINYINT(1) NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_cust_notif_customer (customer_id, is_read),
    CONSTRAINT fk_cust_notif_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Appointments (biometric, embassy interview, document submission,
-- etc.). No admin-side appointment scheduling existed anywhere before
-- this migration — the admin visa-applications detail page gains a
-- small "Schedule Appointment" section alongside this, so the
-- customer-facing list isn't a permanently-empty shell.
CREATE TABLE customer_appointments (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id BIGINT UNSIGNED NOT NULL,
    visa_application_id BIGINT UNSIGNED NULL,
    appointment_type VARCHAR(100) NOT NULL,
    location VARCHAR(255) NULL,
    scheduled_at DATETIME NOT NULL,
    status ENUM('scheduled', 'completed', 'cancelled', 'rescheduled') NOT NULL DEFAULT 'scheduled',
    notes TEXT NULL,
    created_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_cust_appt_customer (customer_id, scheduled_at),
    CONSTRAINT fk_cust_appt_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    CONSTRAINT fk_cust_appt_application FOREIGN KEY (visa_application_id) REFERENCES visa_applications(id) ON DELETE SET NULL,
    CONSTRAINT fk_cust_appt_creator FOREIGN KEY (created_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Partner referral portal
-- ---------------------------------------------------------------------

CREATE TABLE partners (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    partner_reference_no VARCHAR(30) NOT NULL UNIQUE,
    company_name VARCHAR(190) NOT NULL,
    contact_name VARCHAR(190) NOT NULL,
    email VARCHAR(190) NOT NULL UNIQUE,
    mobile VARCHAR(20) NULL,
    password_hash VARCHAR(255) NULL,
    status ENUM('pending', 'active', 'suspended') NOT NULL DEFAULT 'pending',
    email_verified_at DATETIME NULL,
    password_reset_token_hash CHAR(64) NULL,
    password_reset_expires_at DATETIME NULL,
    remember_token_hash CHAR(64) NULL,
    remember_token_expires_at DATETIME NULL,
    approved_by BIGINT UNSIGNED NULL,
    approved_at DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME NULL,
    KEY idx_partners_status (status),
    CONSTRAINT fk_partners_approver FOREIGN KEY (approved_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

ALTER TABLE customers
    ADD CONSTRAINT fk_customers_referred_partner FOREIGN KEY (referred_by_partner_id) REFERENCES partners(id) ON DELETE SET NULL;

-- One row per (partner, application) that generated commission-
-- eligible revenue. amount_due ships NULL — set by staff once a real
-- commission figure exists, same "ships empty until real" pattern as
-- visa_requirements/embassies elsewhere in this project. A partner
-- dashboard summing NULL rows correctly shows "pending" rather than 0.
CREATE TABLE partner_commissions (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    partner_id BIGINT UNSIGNED NOT NULL,
    visa_application_id BIGINT UNSIGNED NOT NULL,
    amount_due DECIMAL(10,2) NULL,
    currency VARCHAR(3) NOT NULL DEFAULT 'INR',
    status ENUM('pending', 'approved', 'paid') NOT NULL DEFAULT 'pending',
    set_by BIGINT UNSIGNED NULL,
    paid_at DATETIME NULL,
    notes TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uniq_partner_commission_application (visa_application_id),
    KEY idx_partner_commissions_partner (partner_id, status),
    CONSTRAINT fk_pcomm_partner FOREIGN KEY (partner_id) REFERENCES partners(id) ON DELETE CASCADE,
    CONSTRAINT fk_pcomm_application FOREIGN KEY (visa_application_id) REFERENCES visa_applications(id) ON DELETE CASCADE,
    CONSTRAINT fk_pcomm_setter FOREIGN KEY (set_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;
