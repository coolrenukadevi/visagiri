-- Visa Checklist Engine — reusable across every country + visa type,
-- not a Mexico-specific feature. Reuses the existing countries/
-- visa_types catalog (same tables the Singapore country-content system
-- uses) rather than duplicating a country/type list here. A checklist
-- is deliberately its own thing per (country, visa_type) pair — never
-- shared or inherited between pairs, even for the same country (see
-- AUDIT.md's "Visa Checklist Engine" entry for the full design
-- rationale, including why this ships as PHP/MySQL rather than the
-- Puppeteer-based PDF pipeline the original brief suggested).

CREATE TABLE visa_checklists (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    country_id BIGINT UNSIGNED NOT NULL,
    visa_type_id BIGINT UNSIGNED NOT NULL,
    reference VARCHAR(40) NOT NULL UNIQUE COMMENT 'e.g. MEX-TOUR-IN-01',
    version VARCHAR(20) NOT NULL COMMENT 'e.g. 2026.09',
    status ENUM('draft', 'published', 'archived') NOT NULL DEFAULT 'draft',
    source VARCHAR(255) NULL,
    source_url VARCHAR(500) NULL,
    disclaimer TEXT NULL COMMENT 'falls back to the standard disclaimer in code when NULL',
    last_reviewed_at DATE NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uniq_checklist_country_type (country_id, visa_type_id),
    CONSTRAINT fk_checklist_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE,
    CONSTRAINT fk_checklist_visa_type FOREIGN KEY (visa_type_id) REFERENCES visa_types(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Lightweight version log — records that a change happened and why,
-- not a full snapshot of prior content (a real "diff every field"
-- version history is a larger feature than this pass could safely
-- build alongside everything else; see AUDIT.md).
CREATE TABLE visa_checklist_revisions (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    checklist_id BIGINT UNSIGNED NOT NULL,
    version VARCHAR(20) NOT NULL,
    change_summary VARCHAR(500) NULL,
    updated_by VARCHAR(150) NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_checklist_revision_checklist FOREIGN KEY (checklist_id) REFERENCES visa_checklists(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE visa_checklist_sections (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    checklist_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(150) NOT NULL,
    description VARCHAR(500) NULL,
    display_order INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_checklist_section_checklist FOREIGN KEY (checklist_id) REFERENCES visa_checklists(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE visa_checklist_documents (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    section_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(200) NOT NULL,
    description VARCHAR(500) NULL,
    document_type ENUM('original', 'copy', 'both', 'if_applicable') NOT NULL DEFAULT 'copy',
    mandatory TINYINT(1) NOT NULL DEFAULT 1,
    conditional TINYINT(1) NOT NULL DEFAULT 0,
    -- Whether this specific document shows in the public (pre-enquiry)
    -- portion of the page. Admin-curated per document rather than a
    -- computed "show N%" slice, so the public portion is always
    -- genuinely useful information, never an arbitrary cut — see
    -- AUDIT.md and the brief's own "do not hide basic info just to
    -- force a lead" rule.
    is_public TINYINT(1) NOT NULL DEFAULT 0,
    source_note VARCHAR(255) NULL,
    display_order INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_checklist_document_section FOREIGN KEY (section_id) REFERENCES visa_checklist_sections(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Manually admin-controlled visa fee, deliberately separate from any
-- automatic fetch/scrape — see requirement in AUDIT.md. Also
-- deliberately separate from visa_requirements.government_fee/
-- service_fee (the Singapore country-content system's fee fields):
-- that system is a freeform "here's roughly what to expect" note,
-- this one is the specific, admin-curated figure the checklist/PDF
-- quote as authoritative for a given country+type.
CREATE TABLE visa_fees (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    country_id BIGINT UNSIGNED NOT NULL,
    visa_type_id BIGINT UNSIGNED NOT NULL,
    amount DECIMAL(10,2) NULL,
    currency VARCHAR(3) NOT NULL DEFAULT 'USD',
    label VARCHAR(150) NULL COMMENT 'e.g. "Current Consular Fee"',
    note VARCHAR(500) NULL,
    effective_date DATE NULL,
    last_updated DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    source_url VARCHAR(500) NULL,
    updated_by VARCHAR(150) NULL,
    UNIQUE KEY uniq_fee_country_type (country_id, visa_type_id),
    CONSTRAINT fk_fee_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE,
    CONSTRAINT fk_fee_visa_type FOREIGN KEY (visa_type_id) REFERENCES visa_types(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE visa_fee_history (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    country_id BIGINT UNSIGNED NOT NULL,
    visa_type_id BIGINT UNSIGNED NOT NULL,
    old_amount DECIMAL(10,2) NULL,
    new_amount DECIMAL(10,2) NULL,
    currency VARCHAR(3) NOT NULL DEFAULT 'USD',
    updated_by VARCHAR(150) NULL,
    reason VARCHAR(255) NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_fee_history_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE,
    CONSTRAINT fk_fee_history_visa_type FOREIGN KEY (visa_type_id) REFERENCES visa_types(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Checklist unlock authorization. The raw token is never stored (only
-- its SHA-256 hash, same discipline as enquiries.mobile_normalized's
-- searchable_hash() pattern) — a leaked database dump can't be used to
-- forge access. Deliberately NOT associated with localStorage/
-- sessionStorage: the raw token is set once as an httpOnly, Secure
-- cookie scoped to /visa/{country}/{type}/ so a returning visitor is
-- recognised without any client-readable/forgeable storage.
CREATE TABLE checklist_access_tokens (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    token_hash CHAR(64) NOT NULL UNIQUE,
    enquiry_id BIGINT UNSIGNED NULL,
    checklist_id BIGINT UNSIGNED NOT NULL,
    country_id BIGINT UNSIGNED NOT NULL,
    visa_type_id BIGINT UNSIGNED NOT NULL,
    status ENUM('active', 'expired') NOT NULL DEFAULT 'active',
    expires_at DATETIME NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_checklist_token_lookup (token_hash, status),
    CONSTRAINT fk_token_enquiry FOREIGN KEY (enquiry_id) REFERENCES enquiries(id) ON DELETE SET NULL,
    CONSTRAINT fk_token_checklist FOREIGN KEY (checklist_id) REFERENCES visa_checklists(id) ON DELETE CASCADE
) ENGINE=InnoDB;
