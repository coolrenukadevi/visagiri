-- B2B Partner CRM — Phase 2: multi-step enrollment wizard. Additive
-- only, run after schema-b2b.sql. Does not widen partners.status —
-- it stays the 3-value ENUM from Phase 1 (pending/active/suspended);
-- the wizard produces a 'pending' partner exactly like the old
-- single-step register form did, so Phase 1's approve/suspend/
-- reactivate actions need no changes. enrollment_completed_at (new,
-- below) is what distinguishes "fully submitted the wizard" from
-- "created an account but abandoned it partway through" without
-- touching the status ENUM.

SET FOREIGN_KEY_CHECKS = 0;

ALTER TABLE partners
    ADD COLUMN designation VARCHAR(100) NULL AFTER contact_name,
    ADD COLUMN whatsapp_number VARCHAR(20) NULL AFTER mobile,
    ADD COLUMN alternate_mobile VARCHAR(20) NULL AFTER whatsapp_number,
    ADD COLUMN email_verification_token_hash CHAR(64) NULL AFTER email_verified_at,
    ADD COLUMN email_verification_expires_at DATETIME NULL AFTER email_verification_token_hash,
    ADD COLUMN terms_accepted_at DATETIME NULL AFTER approved_at,
    ADD COLUMN terms_version VARCHAR(20) NULL AFTER terms_accepted_at,
    -- Set only when the partner finishes the final wizard step (terms
    -- acceptance). Ships NULL for an account created at step 2 but
    -- never taken further — same "ships empty until real" convention
    -- as partner_commissions.amount_due — so the admin list/profile
    -- can distinguish an abandoned registration from one genuinely
    -- awaiting review, without a status value change.
    ADD COLUMN enrollment_completed_at DATETIME NULL AFTER terms_version;

-- One row per partner, created/updated across wizard steps 1 and 3
-- (business info, then services/specialization/volume). A partner has
-- no profile row at all until step 1 is submitted — this table is
-- deliberately separate from `partners` itself (which only holds the
-- step-2 contact/login fields) so a partner can exist mid-wizard with
-- a real login before the rest of their business details are known.
CREATE TABLE partner_business_profiles (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    partner_id BIGINT UNSIGNED NOT NULL,
    business_type ENUM('travel_agency', 'tour_operator', 'visa_consultant', 'corporate_travel_desk', 'immigration_consultant', 'freelancer', 'sub_agent', 'other') NULL,
    year_established SMALLINT UNSIGNED NULL,
    website VARCHAR(255) NULL,
    gstin VARCHAR(15) NULL,
    pan VARCHAR(10) NULL,
    iata_registered TINYINT(1) NOT NULL DEFAULT 0,
    iata_number VARCHAR(50) NULL,
    tafi_number VARCHAR(50) NULL,
    other_association VARCHAR(255) NULL,
    registered_address TEXT NULL,
    city VARCHAR(100) NULL,
    state VARCHAR(100) NULL,
    country VARCHAR(100) NULL,
    pincode VARCHAR(20) NULL,
    -- Comma-separated values validated server-side against a fixed
    -- allow-list (includes/partner-enrollment.php) rather than a join
    -- table — these drive display/filtering only in this phase, the
    -- same simple-storage choice this project already made for
    -- countries.target_countries-style fields elsewhere.
    services_offered VARCHAR(500) NULL,
    visa_specialization VARCHAR(500) NULL,
    monthly_visa_volume ENUM('1-10', '11-25', '26-50', '51-100', '100+') NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uniq_partner_business_profile_partner (partner_id),
    -- GSTIN/PAN/IATA duplicate-prevention (client spec §27) needs to
    -- search across partners, so these aren't unique constraints
    -- (two legitimate different partners could share a parent
    -- company's GSTIN in edge cases) but are indexed for the
    -- application-level duplicate check in partner-enrollment.php.
    KEY idx_partner_business_profiles_gstin (gstin),
    KEY idx_partner_business_profiles_pan (pan),
    KEY idx_partner_business_profiles_iata (iata_number),
    CONSTRAINT fk_partner_business_profiles_partner FOREIGN KEY (partner_id) REFERENCES partners(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Deliberately its own table rather than reusing the generic
-- `documents` table (same reasoning forex_documents got its own
-- table): expiry tracking and a supersede-on-reupload lifecycle don't
-- belong on the shared table every other module uses. Document
-- verification actions (verify/reject) are Phase 3 — this phase only
-- stores and lists uploads; every row ships verification_status =
-- 'pending' and stays there until Phase 3 adds the admin action.
CREATE TABLE partner_documents (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    partner_id BIGINT UNSIGNED NOT NULL,
    document_type ENUM('pan_card', 'gst_certificate', 'company_registration', 'trade_license', 'iata_certificate', 'tafi_certificate', 'office_address_proof', 'authorized_signatory_id', 'company_profile', 'other') NOT NULL,
    original_filename VARCHAR(255) NOT NULL,
    stored_filename VARCHAR(100) NOT NULL,
    storage_path VARCHAR(255) NOT NULL,
    mime_type VARCHAR(100) NOT NULL,
    file_size INT UNSIGNED NOT NULL,
    uploaded_by_partner_id BIGINT UNSIGNED NOT NULL,
    uploaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    expiry_date DATE NULL,
    verification_status ENUM('pending', 'verified', 'rejected', 'expired') NOT NULL DEFAULT 'pending',
    verification_remarks VARCHAR(500) NULL,
    verified_by BIGINT UNSIGNED NULL,
    verified_at DATETIME NULL,
    deleted_at DATETIME NULL,
    KEY idx_partner_documents_partner (partner_id),
    CONSTRAINT fk_partner_documents_partner FOREIGN KEY (partner_id) REFERENCES partners(id) ON DELETE CASCADE,
    CONSTRAINT fk_partner_documents_uploaded_by FOREIGN KEY (uploaded_by_partner_id) REFERENCES partners(id) ON DELETE CASCADE,
    CONSTRAINT fk_partner_documents_verified_by FOREIGN KEY (verified_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

SET FOREIGN_KEY_CHECKS = 1;
