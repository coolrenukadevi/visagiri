-- Forex Buy / Foreign Currency Purchase module — Phase A (core flow:
-- request intake, document verification, quotations with immutable
-- rate snapshots, compliance-gated delivery, audit trail, dashboard).
-- Deferred to Phase B: payment gateway integration, denomination
-- management, PDF/WhatsApp/email quotation delivery, declaration
-- template versioning, admin-editable notification templates, and
-- full reports/export — see AUDIT.md.
--
-- Reuses the existing customers/admin_users/roles/permissions/
-- audit_logs tables rather than parallel ones, per the client's own
-- "reuse existing components, do not duplicate authentication/
-- customer systems" instruction. Lives under /admin/ (same session,
-- same RBAC) rather than a separate login area, since the client's
-- own spec frames this as "CRM menu: Forex → ..." within the
-- existing CRM, unlike the HRMS module which explicitly required its
-- own /hrms/ URL.

SET FOREIGN_KEY_CHECKS = 0;

-- PAN is as sensitive as a passport number and gets the same
-- encrypted-at-rest + searchable-hash treatment (includes/encryption.php),
-- not a new pattern.
ALTER TABLE customers
    ADD COLUMN pan_number_encrypted TEXT NULL AFTER passport_expiry_date,
    ADD COLUMN pan_number_hash CHAR(64) NULL AFTER pan_number_encrypted,
    ADD KEY idx_customers_pan_hash (pan_number_hash);

-- Admin-maintained buy/sell rates. Never auto-fetched from a live
-- API in this phase — every value here was entered by an authorized
-- user, and every quotation snapshots the rate it used (see
-- forex_quotations.exchange_rate) rather than referencing this table
-- live, so a later rate change never alters a past quotation.
CREATE TABLE forex_rates (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    currency_code CHAR(3) NOT NULL,
    currency_name VARCHAR(60) NOT NULL,
    buy_rate DECIMAL(10, 4) NOT NULL,
    sell_rate DECIMAL(10, 4) NOT NULL,
    source VARCHAR(100) NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    updated_by BIGINT UNSIGNED NULL,
    effective_from DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    effective_until DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_forex_rates_currency (currency_code),
    KEY idx_forex_rates_active (is_active),
    CONSTRAINT fk_forex_rates_updated_by FOREIGN KEY (updated_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Admin-editable per-country compliance rules, driving the automatic
-- document checklist. Ships EMPTY — this project never asserts a
-- legal/visa fact it hasn't had confirmed, and the spec itself
-- requires these to be admin-editable rather than hard-coded. When no
-- rule exists for a country yet, forex_country_rule_for() falls back
-- to the full standard checklist rather than silently requiring
-- nothing.
CREATE TABLE forex_country_rules (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(100) NOT NULL UNIQUE,
    default_currency_code CHAR(3) NULL,
    visa_required ENUM('required', 'not_required', 'visa_on_arrival', 'visa_free', 'evisa', 'other') NOT NULL DEFAULT 'required',
    requires_passport TINYINT(1) NOT NULL DEFAULT 1,
    requires_pan TINYINT(1) NOT NULL DEFAULT 1,
    requires_air_ticket TINYINT(1) NOT NULL DEFAULT 1,
    requires_hotel TINYINT(1) NOT NULL DEFAULT 1,
    requires_visa_copy TINYINT(1) NOT NULL DEFAULT 1,
    requires_declaration TINYINT(1) NOT NULL DEFAULT 0,
    special_compliance_notes TEXT NULL,
    updated_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_country_rules_updated_by FOREIGN KEY (updated_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE forex_requests (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    forex_reference_no VARCHAR(30) NOT NULL UNIQUE,
    customer_id BIGINT UNSIGNED NOT NULL,

    -- Travel details
    country_of_visit VARCHAR(100) NOT NULL,
    cities_to_visit VARCHAR(255) NULL,
    purpose_of_travel ENUM('tourism', 'business', 'medical', 'education', 'employment', 'conference', 'family_visit', 'pilgrimage', 'sports', 'other') NOT NULL DEFAULT 'tourism',
    departure_date DATE NULL,
    return_date DATE NULL,
    duration_of_stay VARCHAR(50) NULL,
    airline VARCHAR(100) NULL,
    flight_number VARCHAR(50) NULL,
    hotel_name VARCHAR(150) NULL,
    hotel_location VARCHAR(150) NULL,
    traveller_type ENUM('individual', 'family', 'corporate', 'student', 'other') NOT NULL DEFAULT 'individual',

    -- Visa status (section 5) — drives the document checklist and the
    -- delivery compliance gate together with forex_country_rules.
    visa_status ENUM('visa_available', 'visa_not_available', 'visa_on_arrival', 'visa_free', 'evisa', 'in_process', 'other') NOT NULL DEFAULT 'visa_available',

    -- Forex requirement
    currency_code CHAR(3) NOT NULL,
    amount_required DECIMAL(14, 2) NOT NULL,
    approx_inr_requirement DECIMAL(14, 2) NULL,
    preferred_collection_date DATE NULL,
    preferred_collection_location VARCHAR(150) NULL,
    delivery_method ENUM('branch_pickup', 'home_delivery', 'courier', 'other') NOT NULL DEFAULT 'branch_pickup',

    status ENUM(
        'new_request', 'awaiting_documents', 'documents_submitted', 'documents_under_verification',
        'documents_verified', 'quotation_preparing', 'quotation_sent', 'customer_accepted',
        'payment_pending', 'payment_received', 'compliance_verification', 'approved_for_processing',
        'forex_processing', 'ready_for_delivery', 'delivered', 'cancelled', 'rejected', 'refund_reversal'
    ) NOT NULL DEFAULT 'new_request',

    assigned_employee BIGINT UNSIGNED NULL,
    created_by BIGINT UNSIGNED NULL,
    deleted_at DATETIME NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY idx_forex_requests_customer (customer_id),
    KEY idx_forex_requests_status (status),
    KEY idx_forex_requests_assigned (assigned_employee),
    KEY idx_forex_requests_currency (currency_code),
    KEY idx_forex_requests_country (country_of_visit),
    KEY idx_forex_requests_created (created_at),
    CONSTRAINT fk_forex_requests_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE RESTRICT,
    CONSTRAINT fk_forex_requests_assigned FOREIGN KEY (assigned_employee) REFERENCES admin_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_forex_requests_created_by FOREIGN KEY (created_by) REFERENCES admin_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_forex_requests_deleted_by FOREIGN KEY (deleted_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Verification fields live directly on the document row rather than a
-- separate forex_document_verifications table — simpler, still fully
-- satisfies "every document must have a verification status" since
-- it's a strict 1:1 relationship, and a NEW row (not an update) is
-- created on replacement so history is preserved (section 9's
-- explicit requirement — old document superseded via deleted_at,
-- never overwritten).
CREATE TABLE forex_documents (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    forex_request_id BIGINT UNSIGNED NOT NULL,
    document_type ENUM('passport', 'pan', 'air_ticket', 'hotel', 'visa', 'declaration', 'other') NOT NULL,
    original_filename VARCHAR(255) NOT NULL,
    stored_filename VARCHAR(255) NOT NULL,
    storage_path VARCHAR(500) NOT NULL,
    mime_type VARCHAR(100) NOT NULL,
    file_size INT UNSIGNED NOT NULL,
    uploaded_by BIGINT UNSIGNED NOT NULL,
    uploaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    verification_status ENUM('pending', 'verified', 'rejected', 'expired', 'not_applicable') NOT NULL DEFAULT 'pending',
    verification_remarks TEXT NULL,
    rejection_reason TEXT NULL,
    verified_by BIGINT UNSIGNED NULL,
    verified_at DATETIME NULL,
    is_current TINYINT(1) NOT NULL DEFAULT 1,
    deleted_at DATETIME NULL,
    KEY idx_forex_documents_request (forex_request_id),
    KEY idx_forex_documents_type (document_type),
    KEY idx_forex_documents_current (is_current),
    CONSTRAINT fk_forex_documents_request FOREIGN KEY (forex_request_id) REFERENCES forex_requests(id) ON DELETE CASCADE,
    CONSTRAINT fk_forex_documents_uploaded_by FOREIGN KEY (uploaded_by) REFERENCES admin_users(id) ON DELETE RESTRICT,
    CONSTRAINT fk_forex_documents_verified_by FOREIGN KEY (verified_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Visa-on-Arrival / Visa-Free customer declaration — section 6's
-- exact required fields. document_id points at the uploaded signed
-- declaration file (a forex_documents row, document_type='declaration');
-- kept as its own table because it carries fields (declaration_date,
-- destination_country as stated on the declaration itself) distinct
-- from the generic document row.
CREATE TABLE forex_declarations (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    forex_request_id BIGINT UNSIGNED NOT NULL,
    document_id BIGINT UNSIGNED NULL,
    customer_name VARCHAR(150) NOT NULL,
    destination_country VARCHAR(100) NOT NULL,
    declaration_date DATE NOT NULL,
    uploaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    verified_by BIGINT UNSIGNED NULL,
    verified_at DATETIME NULL,
    KEY idx_forex_declarations_request (forex_request_id),
    CONSTRAINT fk_forex_declarations_request FOREIGN KEY (forex_request_id) REFERENCES forex_requests(id) ON DELETE CASCADE,
    CONSTRAINT fk_forex_declarations_document FOREIGN KEY (document_id) REFERENCES forex_documents(id) ON DELETE SET NULL,
    CONSTRAINT fk_forex_declarations_verified_by FOREIGN KEY (verified_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Every quotation is a permanent, immutable snapshot — a rate change
-- in forex_rates never touches an existing row here. A revised
-- quotation is always a NEW row (status of the previous one moves to
-- 'superseded'), never an in-place edit once sent.
CREATE TABLE forex_quotations (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    forex_request_id BIGINT UNSIGNED NOT NULL,
    currency_code CHAR(3) NOT NULL,
    currency_amount DECIMAL(14, 2) NOT NULL,
    exchange_rate DECIMAL(10, 4) NOT NULL,
    rate_type ENUM('indicative', 'quoted', 'locked') NOT NULL DEFAULT 'indicative',
    base_inr_amount DECIMAL(14, 2) NOT NULL,
    service_charge DECIMAL(12, 2) NOT NULL DEFAULT 0,
    commission_markup DECIMAL(12, 2) NOT NULL DEFAULT 0,
    gst_amount DECIMAL(12, 2) NOT NULL DEFAULT 0,
    other_charges DECIMAL(12, 2) NOT NULL DEFAULT 0,
    total_inr_amount DECIMAL(14, 2) NOT NULL,
    payment_terms TEXT NULL,
    quotation_expiry DATETIME NULL,
    status ENUM('draft', 'sent', 'accepted', 'expired', 'superseded') NOT NULL DEFAULT 'draft',
    created_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_forex_quotations_request (forex_request_id),
    KEY idx_forex_quotations_status (status),
    CONSTRAINT fk_forex_quotations_request FOREIGN KEY (forex_request_id) REFERENCES forex_requests(id) ON DELETE CASCADE,
    CONSTRAINT fk_forex_quotations_created_by FOREIGN KEY (created_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE forex_approvals (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    forex_request_id BIGINT UNSIGNED NOT NULL,
    quotation_id BIGINT UNSIGNED NULL,
    approver_id BIGINT UNSIGNED NULL,
    action ENUM('approved', 'rejected', 'delivery_override') NOT NULL,
    previous_value TEXT NULL,
    new_value TEXT NULL,
    remarks TEXT NULL,
    ip_address VARCHAR(45) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_forex_approvals_request (forex_request_id),
    CONSTRAINT fk_forex_approvals_request FOREIGN KEY (forex_request_id) REFERENCES forex_requests(id) ON DELETE CASCADE,
    CONSTRAINT fk_forex_approvals_quotation FOREIGN KEY (quotation_id) REFERENCES forex_quotations(id) ON DELETE SET NULL,
    CONSTRAINT fk_forex_approvals_approver FOREIGN KEY (approver_id) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Phase A: manual status entry, no payment-gateway integration yet.
CREATE TABLE forex_payments (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    forex_request_id BIGINT UNSIGNED NOT NULL,
    status ENUM('pending', 'partially_paid', 'paid', 'refunded', 'cancelled') NOT NULL DEFAULT 'pending',
    payment_method VARCHAR(60) NULL,
    transaction_id VARCHAR(100) NULL,
    amount_paid DECIMAL(14, 2) NULL,
    payment_date DATE NULL,
    payment_reference VARCHAR(100) NULL,
    remarks TEXT NULL,
    recorded_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_forex_payments_request (forex_request_id),
    CONSTRAINT fk_forex_payments_request FOREIGN KEY (forex_request_id) REFERENCES forex_requests(id) ON DELETE CASCADE,
    CONSTRAINT fk_forex_payments_recorded_by FOREIGN KEY (recorded_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Phase A: total amount only — denomination-level breakdown is
-- Phase B (forex_denominations).
CREATE TABLE forex_deliveries (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    forex_request_id BIGINT UNSIGNED NOT NULL,
    delivered_at DATETIME NOT NULL,
    delivered_by BIGINT UNSIGNED NOT NULL,
    received_by VARCHAR(150) NOT NULL,
    currency_code CHAR(3) NOT NULL,
    amount_delivered DECIMAL(14, 2) NOT NULL,
    customer_acknowledged TINYINT(1) NOT NULL DEFAULT 0,
    delivery_remarks TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_forex_deliveries_request (forex_request_id),
    CONSTRAINT fk_forex_deliveries_request FOREIGN KEY (forex_request_id) REFERENCES forex_requests(id) ON DELETE CASCADE,
    CONSTRAINT fk_forex_deliveries_delivered_by FOREIGN KEY (delivered_by) REFERENCES admin_users(id) ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE forex_status_history (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    forex_request_id BIGINT UNSIGNED NOT NULL,
    from_status VARCHAR(40) NULL,
    to_status VARCHAR(40) NOT NULL,
    changed_by BIGINT UNSIGNED NULL,
    remarks VARCHAR(500) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_forex_status_history_request (forex_request_id),
    CONSTRAINT fk_forex_status_history_request FOREIGN KEY (forex_request_id) REFERENCES forex_requests(id) ON DELETE CASCADE,
    CONSTRAINT fk_forex_status_history_changed_by FOREIGN KEY (changed_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

SET FOREIGN_KEY_CHECKS = 1;
