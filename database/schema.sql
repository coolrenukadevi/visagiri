-- Visagiri 2.0 — normalized schema (Phase 2: Architecture)
-- MySQL 8+, InnoDB, utf8mb4. Every requirements/content table carries
-- last_verified_at + source so stale or unsourced visa information
-- can never silently ship (see AUDIT.md §7).

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ---------------------------------------------------------------
-- Access control
-- ---------------------------------------------------------------

CREATE TABLE roles (
    id            BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(50) NOT NULL UNIQUE,
    description   VARCHAR(255) NULL,
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE users (
    id                  BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    role_id             BIGINT UNSIGNED NOT NULL,
    full_name           VARCHAR(150) NOT NULL,
    email               VARCHAR(191) NOT NULL UNIQUE,
    mobile              VARCHAR(20) NULL,
    password_hash       VARCHAR(255) NOT NULL,
    email_verified_at   TIMESTAMP NULL,
    mobile_verified_at  TIMESTAMP NULL,
    status              ENUM('active','suspended') NOT NULL DEFAULT 'active',
    last_login_at       TIMESTAMP NULL,
    password_reset_token_hash    VARCHAR(255) NULL,
    password_reset_expires_at    TIMESTAMP NULL,
    created_at          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at          TIMESTAMP NULL,
    CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES roles(id),
    INDEX idx_users_role (role_id),
    INDEX idx_users_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------
-- Visa catalog
-- ---------------------------------------------------------------

CREATE TABLE countries (
    id                      BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name                    VARCHAR(100) NOT NULL,
    slug                    VARCHAR(120) NOT NULL UNIQUE,
    iso2                    CHAR(2) NULL,
    iso3                    CHAR(3) NULL,
    flag_image              VARCHAR(255) NULL,
    region                  VARCHAR(100) NULL,
    is_popular_destination  TINYINT(1) NOT NULL DEFAULT 0,
    is_active               TINYINT(1) NOT NULL DEFAULT 1,
    created_at              TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at              TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_countries_active (is_active),
    INDEX idx_countries_popular (is_popular_destination)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE visa_types (
    id           BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(100) NOT NULL,
    slug         VARCHAR(120) NOT NULL UNIQUE,
    description  TEXT NULL,
    icon         VARCHAR(100) NULL,
    sort_order   INT NOT NULL DEFAULT 0,
    is_active    TINYINT(1) NOT NULL DEFAULT 1,
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE country_visa_types (
    id             BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    country_id     BIGINT UNSIGNED NOT NULL,
    visa_type_id   BIGINT UNSIGNED NOT NULL,
    is_available   TINYINT(1) NOT NULL DEFAULT 1,
    created_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_country_visa_type (country_id, visa_type_id),
    CONSTRAINT fk_cvt_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE,
    CONSTRAINT fk_cvt_visa_type FOREIGN KEY (visa_type_id) REFERENCES visa_types(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE visa_requirements (
    id                     BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    country_visa_type_id   BIGINT UNSIGNED NOT NULL,
    eligibility            TEXT NULL,
    documents_required     TEXT NULL,
    application_process    TEXT NULL,
    processing_time        VARCHAR(100) NULL,
    government_fee         DECIMAL(10,2) NULL,
    service_fee            DECIMAL(10,2) NULL,
    currency               CHAR(3) NOT NULL DEFAULT 'INR',
    validity_period        VARCHAR(100) NULL,
    stay_duration          VARCHAR(100) NULL,
    entry_type             ENUM('single','double','multiple') NULL,
    biometrics_required    TINYINT(1) NOT NULL DEFAULT 0,
    interview_required     TINYINT(1) NOT NULL DEFAULT 0,
    notes                  TEXT NULL,
    source_url             VARCHAR(500) NULL,
    last_verified_at       DATE NOT NULL,
    last_verified_by       BIGINT UNSIGNED NULL,
    created_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_vr_cvt FOREIGN KEY (country_visa_type_id) REFERENCES country_visa_types(id) ON DELETE CASCADE,
    CONSTRAINT fk_vr_verifier FOREIGN KEY (last_verified_by) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_vr_last_verified (last_verified_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------
-- Embassies / consulates / VACs
-- ---------------------------------------------------------------

CREATE TABLE embassies (
    id          BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    country_id  BIGINT UNSIGNED NOT NULL,
    name        VARCHAR(200) NOT NULL,
    city        VARCHAR(100) NULL,
    address     VARCHAR(500) NULL,
    phone       VARCHAR(50) NULL,
    email       VARCHAR(191) NULL,
    website     VARCHAR(255) NULL,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_embassies_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE consulates (
    id                 BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    country_id         BIGINT UNSIGNED NOT NULL,
    name               VARCHAR(200) NOT NULL,
    city               VARCHAR(100) NULL,
    address            VARCHAR(500) NULL,
    phone              VARCHAR(50) NULL,
    email              VARCHAR(191) NULL,
    website            VARCHAR(255) NULL,
    jurisdiction_notes TEXT NULL,
    created_at         TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at         TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_consulates_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE vac_centers (
    id               BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    country_id       BIGINT UNSIGNED NOT NULL,
    name             VARCHAR(200) NOT NULL,
    city             VARCHAR(100) NULL,
    address          VARCHAR(500) NULL,
    phone            VARCHAR(50) NULL,
    email            VARCHAR(191) NULL,
    website          VARCHAR(255) NULL,
    operating_hours  VARCHAR(255) NULL,
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_vac_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------
-- Applications
-- ---------------------------------------------------------------

CREATE TABLE applications (
    id                     BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    application_number     VARCHAR(20) NOT NULL UNIQUE,
    user_id                BIGINT UNSIGNED NOT NULL,
    country_id             BIGINT UNSIGNED NOT NULL,
    visa_type_id           BIGINT UNSIGNED NOT NULL,
    assigned_consultant_id BIGINT UNSIGNED NULL,
    applicant_passport_number  VARCHAR(30) NULL,
    applicant_dob               DATE NULL,
    applicant_nationality        VARCHAR(100) NULL,
    status                 ENUM(
                               'created','documents_pending','documents_verified',
                               'payment_completed','appointment_scheduled','submitted',
                               'under_processing','decision_received','completed'
                           ) NOT NULL DEFAULT 'created',
    progress_percent       TINYINT UNSIGNED NOT NULL DEFAULT 0,
    submitted_at           TIMESTAMP NULL,
    decision_at            TIMESTAMP NULL,
    created_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at             TIMESTAMP NULL,
    CONSTRAINT fk_app_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_app_country FOREIGN KEY (country_id) REFERENCES countries(id),
    CONSTRAINT fk_app_visa_type FOREIGN KEY (visa_type_id) REFERENCES visa_types(id),
    CONSTRAINT fk_app_consultant FOREIGN KEY (assigned_consultant_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_app_user (user_id),
    INDEX idx_app_status (status),
    INDEX idx_app_consultant (assigned_consultant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE application_status_history (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    application_id  BIGINT UNSIGNED NOT NULL,
    status          VARCHAR(50) NOT NULL,
    comment         TEXT NULL,
    changed_by      BIGINT UNSIGNED NULL,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_ash_application FOREIGN KEY (application_id) REFERENCES applications(id) ON DELETE CASCADE,
    CONSTRAINT fk_ash_user FOREIGN KEY (changed_by) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_ash_application (application_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------
-- Documents
-- ---------------------------------------------------------------

CREATE TABLE documents (
    id                     BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name                   VARCHAR(150) NOT NULL,
    slug                   VARCHAR(170) NOT NULL UNIQUE,
    description            TEXT NULL,
    is_required_default    TINYINT(1) NOT NULL DEFAULT 0,
    created_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE application_documents (
    id                 BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    application_id     BIGINT UNSIGNED NOT NULL,
    document_id        BIGINT UNSIGNED NOT NULL,
    original_filename  VARCHAR(255) NULL,
    stored_filename    VARCHAR(255) NULL COMMENT 'Randomized name on disk under /uploads, never the original filename',
    mime_type          VARCHAR(100) NULL,
    file_size          INT UNSIGNED NULL COMMENT 'bytes',
    status             ENUM('required','uploaded','under_review','approved','rejected') NOT NULL DEFAULT 'required',
    reviewer_comment   TEXT NULL,
    reviewed_by        BIGINT UNSIGNED NULL,
    uploaded_at        TIMESTAMP NULL,
    reviewed_at        TIMESTAMP NULL,
    created_at         TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at         TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at         TIMESTAMP NULL,
    CONSTRAINT fk_ad_application FOREIGN KEY (application_id) REFERENCES applications(id) ON DELETE CASCADE,
    CONSTRAINT fk_ad_document FOREIGN KEY (document_id) REFERENCES documents(id),
    CONSTRAINT fk_ad_reviewer FOREIGN KEY (reviewed_by) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_ad_application (application_id),
    INDEX idx_ad_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------
-- Appointments & payments
-- ---------------------------------------------------------------

CREATE TABLE appointments (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    application_id  BIGINT UNSIGNED NOT NULL,
    type            ENUM('biometrics','interview','document_submission') NOT NULL,
    scheduled_at    DATETIME NOT NULL,
    location        VARCHAR(255) NULL,
    status          ENUM('scheduled','completed','cancelled','rescheduled') NOT NULL DEFAULT 'scheduled',
    notes           TEXT NULL,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_appt_application FOREIGN KEY (application_id) REFERENCES applications(id) ON DELETE CASCADE,
    INDEX idx_appt_application (application_id),
    INDEX idx_appt_scheduled (scheduled_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE payments (
    id                    BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    application_id        BIGINT UNSIGNED NOT NULL,
    user_id               BIGINT UNSIGNED NOT NULL,
    amount                DECIMAL(10,2) NOT NULL,
    currency              CHAR(3) NOT NULL DEFAULT 'INR',
    purpose               ENUM('service_fee','government_fee','other') NOT NULL DEFAULT 'service_fee',
    status                ENUM('pending','paid','failed','refunded') NOT NULL DEFAULT 'pending',
    payment_method        VARCHAR(50) NULL,
    transaction_reference VARCHAR(191) NULL,
    paid_at               TIMESTAMP NULL,
    created_at            TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at            TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_pay_application FOREIGN KEY (application_id) REFERENCES applications(id) ON DELETE CASCADE,
    CONSTRAINT fk_pay_user FOREIGN KEY (user_id) REFERENCES users(id),
    INDEX idx_pay_application (application_id),
    INDEX idx_pay_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------
-- Communication
-- ---------------------------------------------------------------

CREATE TABLE notifications (
    id                      BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id                 BIGINT UNSIGNED NOT NULL,
    type                    VARCHAR(50) NOT NULL,
    title                   VARCHAR(191) NOT NULL,
    message                 TEXT NULL,
    is_read                 TINYINT(1) NOT NULL DEFAULT 0,
    related_application_id  BIGINT UNSIGNED NULL,
    created_at              TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_notif_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_notif_application FOREIGN KEY (related_application_id) REFERENCES applications(id) ON DELETE SET NULL,
    INDEX idx_notif_user_unread (user_id, is_read)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE messages (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    application_id  BIGINT UNSIGNED NULL,
    sender_id       BIGINT UNSIGNED NOT NULL,
    recipient_id    BIGINT UNSIGNED NOT NULL,
    body            TEXT NOT NULL,
    is_read         TINYINT(1) NOT NULL DEFAULT 0,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_msg_application FOREIGN KEY (application_id) REFERENCES applications(id) ON DELETE CASCADE,
    CONSTRAINT fk_msg_sender FOREIGN KEY (sender_id) REFERENCES users(id),
    CONSTRAINT fk_msg_recipient FOREIGN KEY (recipient_id) REFERENCES users(id),
    INDEX idx_msg_application (application_id),
    INDEX idx_msg_recipient_unread (recipient_id, is_read)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE support_tickets (
    id           BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id      BIGINT UNSIGNED NOT NULL,
    subject      VARCHAR(191) NOT NULL,
    message      TEXT NOT NULL,
    status       ENUM('open','in_progress','resolved','closed') NOT NULL DEFAULT 'open',
    assigned_to  BIGINT UNSIGNED NULL,
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_ticket_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_ticket_assignee FOREIGN KEY (assigned_to) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_ticket_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------
-- Content
-- ---------------------------------------------------------------

CREATE TABLE faqs (
    id            BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    question      VARCHAR(500) NOT NULL,
    answer        TEXT NOT NULL,
    category      VARCHAR(100) NULL,
    country_id    BIGINT UNSIGNED NULL,
    visa_type_id  BIGINT UNSIGNED NULL,
    sort_order    INT NOT NULL DEFAULT 0,
    is_active     TINYINT(1) NOT NULL DEFAULT 1,
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_faq_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE,
    CONSTRAINT fk_faq_visa_type FOREIGN KEY (visa_type_id) REFERENCES visa_types(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE blog_categories (
    id          BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    slug        VARCHAR(120) NOT NULL UNIQUE,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE blog_posts (
    id                BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    category_id       BIGINT UNSIGNED NULL,
    author_id         BIGINT UNSIGNED NOT NULL,
    title             VARCHAR(255) NOT NULL,
    slug              VARCHAR(280) NOT NULL UNIQUE,
    excerpt           VARCHAR(500) NULL,
    content           LONGTEXT NOT NULL,
    featured_image    VARCHAR(255) NULL,
    status            ENUM('draft','published') NOT NULL DEFAULT 'draft',
    seo_title         VARCHAR(255) NULL,
    meta_description  VARCHAR(320) NULL,
    canonical_url     VARCHAR(255) NULL,
    published_at      TIMESTAMP NULL,
    created_at        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_post_category FOREIGN KEY (category_id) REFERENCES blog_categories(id) ON DELETE SET NULL,
    CONSTRAINT fk_post_author FOREIGN KEY (author_id) REFERENCES users(id),
    INDEX idx_post_status_published (status, published_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------
-- Enquiries & audit
-- ---------------------------------------------------------------

CREATE TABLE contact_enquiries (
    id           BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(150) NOT NULL,
    email        VARCHAR(191) NOT NULL,
    mobile       VARCHAR(20) NULL,
    country_id   BIGINT UNSIGNED NULL,
    visa_type_id BIGINT UNSIGNED NULL,
    travel_date  DATE NULL,
    message      TEXT NOT NULL,
    status       ENUM('new','contacted','closed') NOT NULL DEFAULT 'new',
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_enquiry_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE SET NULL,
    CONSTRAINT fk_enquiry_visa_type FOREIGN KEY (visa_type_id) REFERENCES visa_types(id) ON DELETE SET NULL,
    INDEX idx_enquiry_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE audit_logs (
    id           BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id      BIGINT UNSIGNED NULL,
    action       VARCHAR(100) NOT NULL,
    entity_type  VARCHAR(100) NOT NULL,
    entity_id    BIGINT UNSIGNED NULL,
    old_values   JSON NULL,
    new_values   JSON NULL,
    ip_address   VARCHAR(45) NULL,
    user_agent   VARCHAR(255) NULL,
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_audit_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_audit_entity (entity_type, entity_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Server-side rate limiting (login, registration, forgot-password).
-- Deliberately NOT session-based: an attacker who discards cookies
-- between requests would otherwise get a fresh limit every time.
CREATE TABLE rate_limits (
    id                  BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    rate_key            VARCHAR(191) NOT NULL UNIQUE,
    attempt_count       INT UNSIGNED NOT NULL DEFAULT 1,
    window_started_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;

-- ---------------------------------------------------------------
-- Reference-data seed (roles, visa types, document catalog, blog
-- categories). Legitimate catalog data only — no country content,
-- fees, or company statistics are seeded here; those need Phase 7/8
-- data entry against verified sources per AUDIT.md §7.
-- ---------------------------------------------------------------

INSERT INTO roles (name, description) VALUES
    ('super_admin', 'Full system access'),
    ('admin', 'Manage content, applications, users'),
    ('consultant', 'View assigned applications, review documents, update status'),
    ('document_reviewer', 'Review and approve/reject uploaded documents'),
    ('finance', 'View payments, update payment status, generate invoices'),
    ('support', 'View and respond to enquiries and support tickets'),
    ('customer', 'Applicant / end user');

INSERT INTO visa_types (name, slug, description, sort_order) VALUES
    ('Tourist Visa', 'tourist', 'For leisure travel, sightseeing, and visiting a country as a tourist.', 1),
    ('Business Visa', 'business', 'For meetings, conferences, and short-term commercial activity abroad.', 2),
    ('Student Visa', 'student', 'For enrolled students travelling to study at a foreign institution.', 3),
    ('Work Visa', 'work', 'For employment-based travel under a valid job offer or work contract.', 4),
    ('Family Visit Visa', 'family', 'For visiting family members residing in another country.', 5),
    ('Transit Visa', 'transit', 'For passing through a country en route to a final destination.', 6),
    ('Medical Visa', 'medical', 'For travelling abroad to receive medical treatment.', 7),
    ('Conference Visa', 'conference', 'For attending conferences, seminars, or official events abroad.', 8);

INSERT INTO documents (name, slug, is_required_default) VALUES
    ('Passport', 'passport', 1),
    ('Photograph', 'photograph', 1),
    ('Bank Statement', 'bank-statement', 0),
    ('Income Tax Return (ITR)', 'itr', 0),
    ('Employment Letter', 'employment-letter', 0),
    ('Invitation Letter', 'invitation-letter', 0),
    ('Hotel Booking', 'hotel-booking', 0),
    ('Flight Booking', 'flight-booking', 0),
    ('Travel Insurance', 'travel-insurance', 0),
    ('Previous Visa', 'previous-visa', 0),
    ('Other Document', 'other', 0);

INSERT INTO blog_categories (name, slug) VALUES
    ('Visa Updates', 'visa-updates'),
    ('Embassy Updates', 'embassy-updates'),
    ('Visa Guides', 'visa-guides'),
    ('Document Guides', 'document-guides'),
    ('Travel Alerts', 'travel-alerts');

-- Popular-destination countries (Phase 5 homepage needs real entries
-- to link to). Names + standard ISO codes only — objective reference
-- data, not fabricated. NO visa_requirements rows are seeded: fees,
-- processing times, and eligibility rules must come from verified
-- sources during Phase 7/8 data entry, never invented here. Schengen
-- is a multi-country zone, not a single country, so it carries no
-- ISO code.
INSERT INTO countries (name, slug, iso2, iso3, region, is_popular_destination, is_active) VALUES
    ('United States', 'usa', 'US', 'USA', 'North America', 1, 1),
    ('Canada', 'canada', 'CA', 'CAN', 'North America', 1, 1),
    ('United Kingdom', 'uk', 'GB', 'GBR', 'Europe', 1, 1),
    ('Schengen Area', 'schengen', NULL, NULL, 'Europe', 1, 1),
    ('Australia', 'australia', 'AU', 'AUS', 'Oceania', 1, 1),
    ('Japan', 'japan', 'JP', 'JPN', 'Asia', 1, 1),
    ('South Korea', 'south-korea', 'KR', 'KOR', 'Asia', 1, 1),
    ('United Arab Emirates', 'uae', 'AE', 'ARE', 'Asia', 1, 1),
    ('Singapore', 'singapore', 'SG', 'SGP', 'Asia', 1, 1),
    ('New Zealand', 'new-zealand', 'NZ', 'NZL', 'Oceania', 1, 1),
    ('China', 'china', 'CN', 'CHN', 'Asia', 1, 1),
    ('Thailand', 'thailand', 'TH', 'THA', 'Asia', 1, 1);

-- Remaining world countries/territories (Phase 7 — Country Database),
-- organized into the same 6-region taxonomy. Standard ISO 3166-1
-- reference data only (names + codes) — no visa_requirements or
-- country_visa_types rows are seeded for these, same rule as above.
INSERT INTO countries (name, slug, iso2, iso3, region, is_popular_destination, is_active) VALUES
    ('Afghanistan', 'afghanistan', 'AF', 'AFG', 'Asia', 0, 1),
    ('Armenia', 'armenia', 'AM', 'ARM', 'Asia', 0, 1),
    ('Azerbaijan', 'azerbaijan', 'AZ', 'AZE', 'Asia', 0, 1),
    ('Bahrain', 'bahrain', 'BH', 'BHR', 'Asia', 0, 1),
    ('Bangladesh', 'bangladesh', 'BD', 'BGD', 'Asia', 0, 1),
    ('Bhutan', 'bhutan', 'BT', 'BTN', 'Asia', 0, 1),
    ('Brunei', 'brunei', 'BN', 'BRN', 'Asia', 0, 1),
    ('Cambodia', 'cambodia', 'KH', 'KHM', 'Asia', 0, 1),
    ('Cyprus', 'cyprus', 'CY', 'CYP', 'Asia', 0, 1),
    ('Georgia', 'georgia', 'GE', 'GEO', 'Asia', 0, 1),
    ('India', 'india', 'IN', 'IND', 'Asia', 0, 1),
    ('Indonesia', 'indonesia', 'ID', 'IDN', 'Asia', 0, 1),
    ('Iran', 'iran', 'IR', 'IRN', 'Asia', 0, 1),
    ('Iraq', 'iraq', 'IQ', 'IRQ', 'Asia', 0, 1),
    ('Israel', 'israel', 'IL', 'ISR', 'Asia', 0, 1),
    ('Jordan', 'jordan', 'JO', 'JOR', 'Asia', 0, 1),
    ('Kazakhstan', 'kazakhstan', 'KZ', 'KAZ', 'Asia', 0, 1),
    ('Kuwait', 'kuwait', 'KW', 'KWT', 'Asia', 0, 1),
    ('Kyrgyzstan', 'kyrgyzstan', 'KG', 'KGZ', 'Asia', 0, 1),
    ('Laos', 'laos', 'LA', 'LAO', 'Asia', 0, 1),
    ('Lebanon', 'lebanon', 'LB', 'LBN', 'Asia', 0, 1),
    ('Malaysia', 'malaysia', 'MY', 'MYS', 'Asia', 0, 1),
    ('Maldives', 'maldives', 'MV', 'MDV', 'Asia', 0, 1),
    ('Mongolia', 'mongolia', 'MN', 'MNG', 'Asia', 0, 1),
    ('Myanmar', 'myanmar', 'MM', 'MMR', 'Asia', 0, 1),
    ('Nepal', 'nepal', 'NP', 'NPL', 'Asia', 0, 1),
    ('North Korea', 'north-korea', 'KP', 'PRK', 'Asia', 0, 1),
    ('Oman', 'oman', 'OM', 'OMN', 'Asia', 0, 1),
    ('Pakistan', 'pakistan', 'PK', 'PAK', 'Asia', 0, 1),
    ('Palestine', 'palestine', 'PS', 'PSE', 'Asia', 0, 1),
    ('Philippines', 'philippines', 'PH', 'PHL', 'Asia', 0, 1),
    ('Qatar', 'qatar', 'QA', 'QAT', 'Asia', 0, 1),
    ('Saudi Arabia', 'saudi-arabia', 'SA', 'SAU', 'Asia', 0, 1),
    ('Sri Lanka', 'sri-lanka', 'LK', 'LKA', 'Asia', 0, 1),
    ('Syria', 'syria', 'SY', 'SYR', 'Asia', 0, 1),
    ('Taiwan', 'taiwan', 'TW', 'TWN', 'Asia', 0, 1),
    ('Tajikistan', 'tajikistan', 'TJ', 'TJK', 'Asia', 0, 1),
    ('Timor-Leste', 'timor-leste', 'TL', 'TLS', 'Asia', 0, 1),
    ('Turkey', 'turkey', 'TR', 'TUR', 'Asia', 0, 1),
    ('Turkmenistan', 'turkmenistan', 'TM', 'TKM', 'Asia', 0, 1),
    ('Uzbekistan', 'uzbekistan', 'UZ', 'UZB', 'Asia', 0, 1),
    ('Vietnam', 'vietnam', 'VN', 'VNM', 'Asia', 0, 1),
    ('Yemen', 'yemen', 'YE', 'YEM', 'Asia', 0, 1),
    ('Hong Kong', 'hong-kong', 'HK', 'HKG', 'Asia', 0, 1),
    ('Macau', 'macau', 'MO', 'MAC', 'Asia', 0, 1),
    ('Albania', 'albania', 'AL', 'ALB', 'Europe', 0, 1),
    ('Andorra', 'andorra', 'AD', 'AND', 'Europe', 0, 1),
    ('Austria', 'austria', 'AT', 'AUT', 'Europe', 0, 1),
    ('Belarus', 'belarus', 'BY', 'BLR', 'Europe', 0, 1),
    ('Belgium', 'belgium', 'BE', 'BEL', 'Europe', 0, 1),
    ('Bosnia and Herzegovina', 'bosnia-and-herzegovina', 'BA', 'BIH', 'Europe', 0, 1),
    ('Bulgaria', 'bulgaria', 'BG', 'BGR', 'Europe', 0, 1),
    ('Croatia', 'croatia', 'HR', 'HRV', 'Europe', 0, 1),
    ('Czech Republic', 'czech-republic', 'CZ', 'CZE', 'Europe', 0, 1),
    ('Denmark', 'denmark', 'DK', 'DNK', 'Europe', 0, 1),
    ('Estonia', 'estonia', 'EE', 'EST', 'Europe', 0, 1),
    ('Finland', 'finland', 'FI', 'FIN', 'Europe', 0, 1),
    ('France', 'france', 'FR', 'FRA', 'Europe', 0, 1),
    ('Germany', 'germany', 'DE', 'DEU', 'Europe', 0, 1),
    ('Greece', 'greece', 'GR', 'GRC', 'Europe', 0, 1),
    ('Hungary', 'hungary', 'HU', 'HUN', 'Europe', 0, 1),
    ('Iceland', 'iceland', 'IS', 'ISL', 'Europe', 0, 1),
    ('Ireland', 'ireland', 'IE', 'IRL', 'Europe', 0, 1),
    ('Italy', 'italy', 'IT', 'ITA', 'Europe', 0, 1),
    ('Kosovo', 'kosovo', 'XK', 'XKX', 'Europe', 0, 1),
    ('Latvia', 'latvia', 'LV', 'LVA', 'Europe', 0, 1),
    ('Liechtenstein', 'liechtenstein', 'LI', 'LIE', 'Europe', 0, 1),
    ('Lithuania', 'lithuania', 'LT', 'LTU', 'Europe', 0, 1),
    ('Luxembourg', 'luxembourg', 'LU', 'LUX', 'Europe', 0, 1),
    ('Malta', 'malta', 'MT', 'MLT', 'Europe', 0, 1),
    ('Moldova', 'moldova', 'MD', 'MDA', 'Europe', 0, 1),
    ('Monaco', 'monaco', 'MC', 'MCO', 'Europe', 0, 1),
    ('Montenegro', 'montenegro', 'ME', 'MNE', 'Europe', 0, 1),
    ('Netherlands', 'netherlands', 'NL', 'NLD', 'Europe', 0, 1),
    ('North Macedonia', 'north-macedonia', 'MK', 'MKD', 'Europe', 0, 1),
    ('Norway', 'norway', 'NO', 'NOR', 'Europe', 0, 1),
    ('Poland', 'poland', 'PL', 'POL', 'Europe', 0, 1),
    ('Portugal', 'portugal', 'PT', 'PRT', 'Europe', 0, 1),
    ('Romania', 'romania', 'RO', 'ROU', 'Europe', 0, 1),
    ('Russia', 'russia', 'RU', 'RUS', 'Europe', 0, 1),
    ('San Marino', 'san-marino', 'SM', 'SMR', 'Europe', 0, 1),
    ('Serbia', 'serbia', 'RS', 'SRB', 'Europe', 0, 1),
    ('Slovakia', 'slovakia', 'SK', 'SVK', 'Europe', 0, 1),
    ('Slovenia', 'slovenia', 'SI', 'SVN', 'Europe', 0, 1),
    ('Spain', 'spain', 'ES', 'ESP', 'Europe', 0, 1),
    ('Sweden', 'sweden', 'SE', 'SWE', 'Europe', 0, 1),
    ('Switzerland', 'switzerland', 'CH', 'CHE', 'Europe', 0, 1),
    ('Ukraine', 'ukraine', 'UA', 'UKR', 'Europe', 0, 1),
    ('Vatican City', 'vatican-city', 'VA', 'VAT', 'Europe', 0, 1),
    ('Gibraltar', 'gibraltar', 'GI', 'GIB', 'Europe', 0, 1),
    ('Isle of Man', 'isle-of-man', 'IM', 'IMN', 'Europe', 0, 1),
    ('Mexico', 'mexico', 'MX', 'MEX', 'North America', 0, 1),
    ('Antigua and Barbuda', 'antigua-and-barbuda', 'AG', 'ATG', 'North America', 0, 1),
    ('Bahamas', 'bahamas', 'BS', 'BHS', 'North America', 0, 1),
    ('Barbados', 'barbados', 'BB', 'BRB', 'North America', 0, 1),
    ('Belize', 'belize', 'BZ', 'BLZ', 'North America', 0, 1),
    ('Costa Rica', 'costa-rica', 'CR', 'CRI', 'North America', 0, 1),
    ('Cuba', 'cuba', 'CU', 'CUB', 'North America', 0, 1),
    ('Dominica', 'dominica', 'DM', 'DMA', 'North America', 0, 1),
    ('Dominican Republic', 'dominican-republic', 'DO', 'DOM', 'North America', 0, 1),
    ('El Salvador', 'el-salvador', 'SV', 'SLV', 'North America', 0, 1),
    ('Grenada', 'grenada', 'GD', 'GRD', 'North America', 0, 1),
    ('Guatemala', 'guatemala', 'GT', 'GTM', 'North America', 0, 1),
    ('Haiti', 'haiti', 'HT', 'HTI', 'North America', 0, 1),
    ('Honduras', 'honduras', 'HN', 'HND', 'North America', 0, 1),
    ('Jamaica', 'jamaica', 'JM', 'JAM', 'North America', 0, 1),
    ('Nicaragua', 'nicaragua', 'NI', 'NIC', 'North America', 0, 1),
    ('Panama', 'panama', 'PA', 'PAN', 'North America', 0, 1),
    ('Saint Kitts and Nevis', 'saint-kitts-and-nevis', 'KN', 'KNA', 'North America', 0, 1),
    ('Saint Lucia', 'saint-lucia', 'LC', 'LCA', 'North America', 0, 1),
    ('Saint Vincent and the Grenadines', 'saint-vincent-and-the-grenadines', 'VC', 'VCT', 'North America', 0, 1),
    ('Trinidad and Tobago', 'trinidad-and-tobago', 'TT', 'TTO', 'North America', 0, 1),
    ('Puerto Rico', 'puerto-rico', 'PR', 'PRI', 'North America', 0, 1),
    ('Bermuda', 'bermuda', 'BM', 'BMU', 'North America', 0, 1),
    ('Cayman Islands', 'cayman-islands', 'KY', 'CYM', 'North America', 0, 1),
    ('Greenland', 'greenland', 'GL', 'GRL', 'North America', 0, 1),
    ('Argentina', 'argentina', 'AR', 'ARG', 'South America', 0, 1),
    ('Bolivia', 'bolivia', 'BO', 'BOL', 'South America', 0, 1),
    ('Brazil', 'brazil', 'BR', 'BRA', 'South America', 0, 1),
    ('Chile', 'chile', 'CL', 'CHL', 'South America', 0, 1),
    ('Colombia', 'colombia', 'CO', 'COL', 'South America', 0, 1),
    ('Ecuador', 'ecuador', 'EC', 'ECU', 'South America', 0, 1),
    ('Guyana', 'guyana', 'GY', 'GUY', 'South America', 0, 1),
    ('Paraguay', 'paraguay', 'PY', 'PRY', 'South America', 0, 1),
    ('Peru', 'peru', 'PE', 'PER', 'South America', 0, 1),
    ('Suriname', 'suriname', 'SR', 'SUR', 'South America', 0, 1),
    ('Uruguay', 'uruguay', 'UY', 'URY', 'South America', 0, 1),
    ('Venezuela', 'venezuela', 'VE', 'VEN', 'South America', 0, 1),
    ('Algeria', 'algeria', 'DZ', 'DZA', 'Africa', 0, 1),
    ('Angola', 'angola', 'AO', 'AGO', 'Africa', 0, 1),
    ('Benin', 'benin', 'BJ', 'BEN', 'Africa', 0, 1),
    ('Botswana', 'botswana', 'BW', 'BWA', 'Africa', 0, 1),
    ('Burkina Faso', 'burkina-faso', 'BF', 'BFA', 'Africa', 0, 1),
    ('Burundi', 'burundi', 'BI', 'BDI', 'Africa', 0, 1),
    ('Cabo Verde', 'cabo-verde', 'CV', 'CPV', 'Africa', 0, 1),
    ('Cameroon', 'cameroon', 'CM', 'CMR', 'Africa', 0, 1),
    ('Central African Republic', 'central-african-republic', 'CF', 'CAF', 'Africa', 0, 1),
    ('Chad', 'chad', 'TD', 'TCD', 'Africa', 0, 1),
    ('Comoros', 'comoros', 'KM', 'COM', 'Africa', 0, 1),
    ('Republic of the Congo', 'republic-of-the-congo', 'CG', 'COG', 'Africa', 0, 1),
    ('Democratic Republic of the Congo', 'democratic-republic-of-the-congo', 'CD', 'COD', 'Africa', 0, 1),
    ('Djibouti', 'djibouti', 'DJ', 'DJI', 'Africa', 0, 1),
    ('Egypt', 'egypt', 'EG', 'EGY', 'Africa', 0, 1),
    ('Equatorial Guinea', 'equatorial-guinea', 'GQ', 'GNQ', 'Africa', 0, 1),
    ('Eritrea', 'eritrea', 'ER', 'ERI', 'Africa', 0, 1),
    ('Eswatini', 'eswatini', 'SZ', 'SWZ', 'Africa', 0, 1),
    ('Ethiopia', 'ethiopia', 'ET', 'ETH', 'Africa', 0, 1),
    ('Gabon', 'gabon', 'GA', 'GAB', 'Africa', 0, 1),
    ('Gambia', 'gambia', 'GM', 'GMB', 'Africa', 0, 1),
    ('Ghana', 'ghana', 'GH', 'GHA', 'Africa', 0, 1),
    ('Guinea', 'guinea', 'GN', 'GIN', 'Africa', 0, 1),
    ('Guinea-Bissau', 'guinea-bissau', 'GW', 'GNB', 'Africa', 0, 1),
    ('Ivory Coast', 'ivory-coast', 'CI', 'CIV', 'Africa', 0, 1),
    ('Kenya', 'kenya', 'KE', 'KEN', 'Africa', 0, 1),
    ('Lesotho', 'lesotho', 'LS', 'LSO', 'Africa', 0, 1),
    ('Liberia', 'liberia', 'LR', 'LBR', 'Africa', 0, 1),
    ('Libya', 'libya', 'LY', 'LBY', 'Africa', 0, 1),
    ('Madagascar', 'madagascar', 'MG', 'MDG', 'Africa', 0, 1),
    ('Malawi', 'malawi', 'MW', 'MWI', 'Africa', 0, 1),
    ('Mali', 'mali', 'ML', 'MLI', 'Africa', 0, 1),
    ('Mauritania', 'mauritania', 'MR', 'MRT', 'Africa', 0, 1),
    ('Mauritius', 'mauritius', 'MU', 'MUS', 'Africa', 0, 1),
    ('Morocco', 'morocco', 'MA', 'MAR', 'Africa', 0, 1),
    ('Mozambique', 'mozambique', 'MZ', 'MOZ', 'Africa', 0, 1),
    ('Namibia', 'namibia', 'NA', 'NAM', 'Africa', 0, 1),
    ('Niger', 'niger', 'NE', 'NER', 'Africa', 0, 1),
    ('Nigeria', 'nigeria', 'NG', 'NGA', 'Africa', 0, 1),
    ('Rwanda', 'rwanda', 'RW', 'RWA', 'Africa', 0, 1),
    ('Sao Tome and Principe', 'sao-tome-and-principe', 'ST', 'STP', 'Africa', 0, 1),
    ('Senegal', 'senegal', 'SN', 'SEN', 'Africa', 0, 1),
    ('Seychelles', 'seychelles', 'SC', 'SYC', 'Africa', 0, 1),
    ('Sierra Leone', 'sierra-leone', 'SL', 'SLE', 'Africa', 0, 1),
    ('Somalia', 'somalia', 'SO', 'SOM', 'Africa', 0, 1),
    ('South Africa', 'south-africa', 'ZA', 'ZAF', 'Africa', 0, 1),
    ('South Sudan', 'south-sudan', 'SS', 'SSD', 'Africa', 0, 1),
    ('Sudan', 'sudan', 'SD', 'SDN', 'Africa', 0, 1),
    ('Tanzania', 'tanzania', 'TZ', 'TZA', 'Africa', 0, 1),
    ('Togo', 'togo', 'TG', 'TGO', 'Africa', 0, 1),
    ('Tunisia', 'tunisia', 'TN', 'TUN', 'Africa', 0, 1),
    ('Uganda', 'uganda', 'UG', 'UGA', 'Africa', 0, 1),
    ('Zambia', 'zambia', 'ZM', 'ZMB', 'Africa', 0, 1),
    ('Zimbabwe', 'zimbabwe', 'ZW', 'ZWE', 'Africa', 0, 1),
    ('Fiji', 'fiji', 'FJ', 'FJI', 'Oceania', 0, 1),
    ('Kiribati', 'kiribati', 'KI', 'KIR', 'Oceania', 0, 1),
    ('Marshall Islands', 'marshall-islands', 'MH', 'MHL', 'Oceania', 0, 1),
    ('Micronesia', 'micronesia', 'FM', 'FSM', 'Oceania', 0, 1),
    ('Nauru', 'nauru', 'NR', 'NRU', 'Oceania', 0, 1),
    ('Palau', 'palau', 'PW', 'PLW', 'Oceania', 0, 1),
    ('Papua New Guinea', 'papua-new-guinea', 'PG', 'PNG', 'Oceania', 0, 1),
    ('Samoa', 'samoa', 'WS', 'WSM', 'Oceania', 0, 1),
    ('Solomon Islands', 'solomon-islands', 'SB', 'SLB', 'Oceania', 0, 1),
    ('Tonga', 'tonga', 'TO', 'TON', 'Oceania', 0, 1),
    ('Tuvalu', 'tuvalu', 'TV', 'TUV', 'Oceania', 0, 1),
    ('Vanuatu', 'vanuatu', 'VU', 'VUT', 'Oceania', 0, 1),
    ('French Polynesia', 'french-polynesia', 'PF', 'PYF', 'Oceania', 0, 1),
    ('New Caledonia', 'new-caledonia', 'NC', 'NCL', 'Oceania', 0, 1);

-- General, non-country-specific FAQs. Deliberately process-level
-- (how search/tracking/documents work) rather than fabricated stats
-- or country-specific rules — those require verified per-country
-- data and belong in Phase 7/8, not here.
INSERT INTO faqs (question, answer, category, sort_order, is_active) VALUES
    ('Do I need a visa to travel abroad?',
     'Visa requirements depend on your nationality, destination country, and purpose of travel. Use the visa search tool to check requirements for your specific situation.',
     'general', 1, 1),
    ('How long does visa processing take?',
     'Processing times vary significantly by country, visa type, and application volume. Each visa''s detail page lists the current processing time as last verified, along with its source.',
     'general', 2, 1),
    ('What documents do I typically need for a visa application?',
     'Common documents include a valid passport, passport-size photographs, proof of financial means, and travel or accommodation details. Exact requirements vary by country and visa type — see the specific visa page for the full checklist.',
     'general', 3, 1),
    ('Can Visagiri guarantee my visa will be approved?',
     'No. Visa decisions are made solely by the relevant embassy, consulate, or government immigration authority. Visagiri assists with preparation, documentation, and application management, but cannot guarantee approval outcomes.',
     'general', 4, 1),
    ('How can I track my visa application?',
     'Once your application is submitted, you can track its status anytime using your application number on the Track Application page.',
     'general', 5, 1);
