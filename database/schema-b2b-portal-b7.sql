-- B2B Travel Partner Portal — Phase B7: quotations + invoices tied to
-- a visa enquiry. Manual payment tracking only — no payment gateway
-- integration exists or was requested anywhere in this project (see
-- schema-crm.sql's visa_payments for the same documented decision);
-- staff record what's actually been collected (method + reference),
-- the same honest approach used everywhere else in this codebase.

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE b2b_enquiry_quotations (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    quotation_reference_no VARCHAR(30) NOT NULL UNIQUE,
    b2b_visa_enquiry_id BIGINT UNSIGNED NOT NULL,
    government_fee DECIMAL(10, 2) NOT NULL DEFAULT 0,
    service_fee DECIMAL(10, 2) NOT NULL DEFAULT 0,
    other_charges DECIMAL(10, 2) NOT NULL DEFAULT 0,
    total_amount DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) NOT NULL DEFAULT 'INR',
    notes TEXT NULL,
    status ENUM('draft', 'sent', 'accepted', 'rejected') NOT NULL DEFAULT 'draft',
    created_by BIGINT UNSIGNED NULL,
    sent_at DATETIME NULL,
    responded_at DATETIME NULL,
    response_note VARCHAR(500) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_b2b_quotations_enquiry (b2b_visa_enquiry_id),
    CONSTRAINT fk_b2b_quotations_enquiry FOREIGN KEY (b2b_visa_enquiry_id) REFERENCES b2b_visa_enquiries(id) ON DELETE CASCADE,
    CONSTRAINT fk_b2b_quotations_admin FOREIGN KEY (created_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE b2b_enquiry_invoices (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    invoice_reference_no VARCHAR(30) NOT NULL UNIQUE,
    b2b_visa_enquiry_id BIGINT UNSIGNED NOT NULL,
    b2b_partner_id BIGINT UNSIGNED NOT NULL,
    quotation_id BIGINT UNSIGNED NULL,
    amount DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) NOT NULL DEFAULT 'INR',
    status ENUM('issued', 'paid', 'cancelled') NOT NULL DEFAULT 'issued',
    payment_method VARCHAR(50) NULL,
    payment_reference VARCHAR(100) NULL,
    notes VARCHAR(500) NULL,
    created_by BIGINT UNSIGNED NULL,
    issued_at DATETIME NULL,
    paid_at DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_b2b_invoices_enquiry (b2b_visa_enquiry_id),
    KEY idx_b2b_invoices_partner (b2b_partner_id),
    CONSTRAINT fk_b2b_invoices_enquiry FOREIGN KEY (b2b_visa_enquiry_id) REFERENCES b2b_visa_enquiries(id) ON DELETE CASCADE,
    CONSTRAINT fk_b2b_invoices_partner FOREIGN KEY (b2b_partner_id) REFERENCES b2b_partners(id) ON DELETE CASCADE,
    CONSTRAINT fk_b2b_invoices_quotation FOREIGN KEY (quotation_id) REFERENCES b2b_enquiry_quotations(id) ON DELETE SET NULL,
    CONSTRAINT fk_b2b_invoices_admin FOREIGN KEY (created_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
