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

INSERT INTO visa_types (name, slug, sort_order) VALUES
    ('Tourist Visa', 'tourist', 1),
    ('Business Visa', 'business', 2),
    ('Student Visa', 'student', 3),
    ('Work Visa', 'work', 4),
    ('Family Visit Visa', 'family', 5),
    ('Transit Visa', 'transit', 6),
    ('Medical Visa', 'medical', 7),
    ('Conference Visa', 'conference', 8);

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
