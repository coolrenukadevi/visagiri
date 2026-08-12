-- Visagiri database schema — MySQL/MariaDB, no ORM.
-- Content tables (countries, visa_types, visa_faqs) are seeded from the
-- same real data exported during the earlier no-database phase (see
-- database/seed-data.sql); nothing here is fabricated. Tables with no
-- real data available (embassies, consulates, visa_application_centres,
-- visa_requirements) ship empty — the site renders an honest "not yet
-- published" state for them until an admin adds real entries.

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------
-- Admin authentication
-- ---------------------------------------------------------------------
CREATE TABLE admin_users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(60) NOT NULL UNIQUE,
    email VARCHAR(190) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    status ENUM('active', 'suspended') NOT NULL DEFAULT 'active',
    last_login_at DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- File-based rate limiter was used during the no-database phase; moved
-- back to a table now that MySQL is available again, matching the
-- original Phase 16 design.
CREATE TABLE rate_limits (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    rate_key VARCHAR(190) NOT NULL UNIQUE,
    attempt_count INT UNSIGNED NOT NULL DEFAULT 1,
    window_started_at DATETIME NOT NULL,
    KEY idx_rate_limits_window (window_started_at)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Catalog: regions, countries, visa types
-- ---------------------------------------------------------------------
CREATE TABLE regions (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    slug VARCHAR(120) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE countries (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(120) NOT NULL UNIQUE,
    iso2 CHAR(2) NULL,
    iso3 CHAR(3) NULL,
    region_id BIGINT UNSIGNED NULL,
    is_popular_destination TINYINT(1) NOT NULL DEFAULT 0,
    is_schengen TINYINT(1) NOT NULL DEFAULT 0,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    meta_title VARCHAR(255) NULL,
    meta_description VARCHAR(500) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_countries_active (is_active),
    KEY idx_countries_popular (is_popular_destination),
    CONSTRAINT fk_countries_region FOREIGN KEY (region_id) REFERENCES regions(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE visa_types (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(120) NOT NULL UNIQUE,
    description TEXT NULL,
    icon VARCHAR(10) NULL,
    sort_order INT NOT NULL DEFAULT 0,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Which visa types are offered for which countries. Populated with
-- every real country x every real visa type marked available — this
-- matches actual current business policy (no country currently
-- restricts which of the 9 visa types it offers), while still giving
-- admins a real place to mark a specific combination unavailable later
-- rather than that policy being an unstated assumption in application code.
CREATE TABLE country_visa_types (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    country_id BIGINT UNSIGNED NOT NULL,
    visa_type_id BIGINT UNSIGNED NOT NULL,
    is_available TINYINT(1) NOT NULL DEFAULT 1,
    UNIQUE KEY uniq_country_visa_type (country_id, visa_type_id),
    CONSTRAINT fk_cvt_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE,
    CONSTRAINT fk_cvt_visa_type FOREIGN KEY (visa_type_id) REFERENCES visa_types(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Eligibility/documents/fees/etc. per country+visa-type combination.
-- Ships empty: no requirement has ever been sourced and verified for
-- any real country+type pair. Admins fill this in via the CMS; the
-- public visa-detail page shows an honest "not yet verified" notice
-- for any combination with no row here.
CREATE TABLE visa_requirements (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    country_id BIGINT UNSIGNED NOT NULL,
    visa_type_id BIGINT UNSIGNED NOT NULL,
    eligibility TEXT NULL,
    documents_required TEXT NULL,
    application_process TEXT NULL,
    processing_time VARCHAR(150) NULL,
    government_fee DECIMAL(10,2) NULL,
    service_fee DECIMAL(10,2) NULL,
    currency VARCHAR(3) NOT NULL DEFAULT 'INR',
    validity_period VARCHAR(150) NULL,
    stay_duration VARCHAR(150) NULL,
    entry_type VARCHAR(100) NULL,
    biometrics_required TINYINT(1) NOT NULL DEFAULT 0,
    interview_required TINYINT(1) NOT NULL DEFAULT 0,
    notes TEXT NULL,
    source_url VARCHAR(500) NULL,
    last_verified_at DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uniq_requirement_country_type (country_id, visa_type_id),
    CONSTRAINT fk_vr_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE,
    CONSTRAINT fk_vr_visa_type FOREIGN KEY (visa_type_id) REFERENCES visa_types(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Contact points. All three ship empty — no real address has ever been
-- confirmed for any country. See visa_requirements comment above; same
-- discipline applies.
-- ---------------------------------------------------------------------
CREATE TABLE embassies (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    country_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(200) NOT NULL,
    city VARCHAR(100) NULL,
    address TEXT NULL,
    phone VARCHAR(50) NULL,
    website VARCHAR(255) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_embassies_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE consulates (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    country_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(200) NOT NULL,
    city VARCHAR(100) NULL,
    address TEXT NULL,
    phone VARCHAR(50) NULL,
    website VARCHAR(255) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_consulates_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE visa_application_centres (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    country_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(200) NOT NULL,
    city VARCHAR(100) NULL,
    address TEXT NULL,
    phone VARCHAR(50) NULL,
    website VARCHAR(255) NULL,
    operating_hours VARCHAR(150) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_vac_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- FAQs — seeded with the 5 real general FAQs (country_id/visa_type_id
-- NULL) already in production use; per-country/per-type FAQs are a
-- real feature, just unused so far (matches history: none of the
-- original rows were ever tagged to a specific country or type).
-- ---------------------------------------------------------------------
CREATE TABLE visa_faqs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    question VARCHAR(500) NOT NULL,
    answer TEXT NOT NULL,
    country_id BIGINT UNSIGNED NULL,
    visa_type_id BIGINT UNSIGNED NULL,
    sort_order INT NOT NULL DEFAULT 0,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_faqs_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE,
    CONSTRAINT fk_faqs_visa_type FOREIGN KEY (visa_type_id) REFERENCES visa_types(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Enquiries (structured visa enquiry widget) + general contact messages
-- ---------------------------------------------------------------------
CREATE TABLE enquiries (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    reference_number VARCHAR(30) NOT NULL UNIQUE,
    name VARCHAR(150) NOT NULL,
    mobile VARCHAR(20) NOT NULL,
    email VARCHAR(190) NOT NULL,
    country_id BIGINT UNSIGNED NULL,
    visa_type_id BIGINT UNSIGNED NULL,
    purpose_of_travel VARCHAR(150) NULL,
    travel_date DATE NULL,
    travellers_count SMALLINT UNSIGNED NOT NULL DEFAULT 1,
    message TEXT NULL,
    status ENUM('new', 'contacted', 'in_progress', 'closed') NOT NULL DEFAULT 'new',
    ip_address VARCHAR(45) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_enquiries_status (status),
    KEY idx_enquiries_created (created_at),
    CONSTRAINT fk_enquiries_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE SET NULL,
    CONSTRAINT fk_enquiries_visa_type FOREIGN KEY (visa_type_id) REFERENCES visa_types(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE contact_messages (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(190) NOT NULL,
    phone VARCHAR(20) NULL,
    destination VARCHAR(100) NULL,
    message TEXT NOT NULL,
    status ENUM('unread', 'read', 'replied') NOT NULL DEFAULT 'unread',
    ip_address VARCHAR(45) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_contact_messages_status (status)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Site settings — key/value store for admin-editable configuration
-- (contact details, mail recipients, integration URLs, homepage copy)
-- so none of this needs a code deploy to change, and none of it needs
-- an .env file. Seeded with the site's real, already-confirmed values.
-- ---------------------------------------------------------------------
CREATE TABLE site_settings (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    setting_key VARCHAR(100) NOT NULL UNIQUE,
    setting_value TEXT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;
