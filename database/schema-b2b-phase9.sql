-- B2B Partner CRM — Phase 9: B2B enquiry capture + the public landing
-- page it feeds. Additive, run after schema-b2b-phase8.sql. Mirrors
-- visa_enquiries' own shape (schema-crm.sql) — reference number,
-- soft delete, assigned_admin_id, status lifecycle — since this is
-- the same kind of "public form -> staff follow-up" record, just for
-- a prospective partner instead of a prospective traveller.

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE partner_enquiries (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    reference_number VARCHAR(30) NOT NULL UNIQUE,
    company_name VARCHAR(200) NOT NULL,
    contact_name VARCHAR(150) NOT NULL,
    email VARCHAR(190) NOT NULL,
    mobile VARCHAR(20) NOT NULL,
    business_type VARCHAR(100) NULL,
    message TEXT NULL,
    status ENUM('new', 'contacted', 'converted', 'closed') NOT NULL DEFAULT 'new',
    assigned_admin_id BIGINT UNSIGNED NULL,
    ip_address VARCHAR(45) NULL,
    deleted_at DATETIME NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_partner_enq_status (status),
    CONSTRAINT fk_partner_enq_admin FOREIGN KEY (assigned_admin_id) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
