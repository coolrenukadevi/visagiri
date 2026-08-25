-- HRMS Recruitment CRM — Phase A (core flow only; see AUDIT.md for what
-- Phase B still covers: email notifications, social sharing/OG images,
-- reports/export, LinkedIn share text, dynamic-question admin UI
-- refinements). Reuses the existing admin_users/roles/permissions/
-- audit_logs tables rather than a parallel user system — HR staff log
-- in through the same session/password infrastructure already built
-- for the visa CRM, just with their own roles and permission keys, and
-- their own /hrms/ URL area and dashboard.

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE hr_departments (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE hr_vacancies (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    job_reference_no VARCHAR(30) NOT NULL UNIQUE,
    slug VARCHAR(180) NOT NULL UNIQUE,
    job_title VARCHAR(180) NOT NULL,
    department_id BIGINT UNSIGNED NULL,
    location VARCHAR(150) NULL,
    employment_type ENUM('full_time', 'part_time', 'contract', 'internship') NOT NULL DEFAULT 'full_time',
    experience_required VARCHAR(100) NULL,
    qualification VARCHAR(255) NULL,
    salary_min DECIMAL(10, 2) NULL,
    salary_max DECIMAL(10, 2) NULL,
    salary_currency VARCHAR(3) NOT NULL DEFAULT 'INR',
    job_description TEXT NOT NULL,
    responsibilities TEXT NULL,
    required_skills TEXT NULL,
    benefits TEXT NULL,
    application_closing_date DATE NULL,
    status ENUM('draft', 'published', 'paused', 'closed') NOT NULL DEFAULT 'draft',
    created_by BIGINT UNSIGNED NULL,
    published_at DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_vacancies_status (status),
    KEY idx_vacancies_department (department_id),
    CONSTRAINT fk_vacancies_department FOREIGN KEY (department_id) REFERENCES hr_departments(id) ON DELETE SET NULL,
    CONSTRAINT fk_vacancies_created_by FOREIGN KEY (created_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Dynamic per-vacancy application questions, editable from the HRMS
-- without a code change (the whole point of this table existing).
CREATE TABLE hr_application_questions (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    vacancy_id BIGINT UNSIGNED NOT NULL,
    question_label VARCHAR(255) NOT NULL,
    question_type ENUM('text', 'textarea', 'number', 'select', 'yesno') NOT NULL DEFAULT 'text',
    options TEXT NULL COMMENT 'JSON array of option strings, only used when question_type = select',
    is_required TINYINT(1) NOT NULL DEFAULT 0,
    sort_order SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_questions_vacancy (vacancy_id),
    CONSTRAINT fk_questions_vacancy FOREIGN KEY (vacancy_id) REFERENCES hr_vacancies(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- One row per real person. Matched on email/mobile for duplicate
-- detection before a new application is created (see includes/hrms.php).
CREATE TABLE hr_candidates (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    date_of_birth DATE NULL,
    gender ENUM('male', 'female', 'other') NULL,
    mobile VARCHAR(20) NOT NULL,
    whatsapp_number VARCHAR(20) NULL,
    email VARCHAR(190) NOT NULL,
    address TEXT NULL,
    city VARCHAR(100) NULL,
    state VARCHAR(100) NULL,
    pincode VARCHAR(12) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_candidates_email (email),
    KEY idx_candidates_mobile (mobile),
    KEY idx_candidates_name (full_name)
) ENGINE=InnoDB;

-- One row per (candidate, vacancy) submission — the thing an
-- "Application ID" actually refers to.
CREATE TABLE hr_applications (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    application_reference_no VARCHAR(30) NOT NULL UNIQUE,
    candidate_id BIGINT UNSIGNED NOT NULL,
    vacancy_id BIGINT UNSIGNED NOT NULL,

    -- Professional information
    current_company VARCHAR(150) NULL,
    current_designation VARCHAR(150) NULL,
    total_experience VARCHAR(50) NULL,
    relevant_experience VARCHAR(50) NULL,
    current_salary VARCHAR(50) NULL,
    expected_salary VARCHAR(50) NULL,
    notice_period VARCHAR(100) NULL,
    employment_status ENUM('employed', 'unemployed', 'serving_notice', 'freelancer', 'student', 'other') NULL,
    reason_for_leaving TEXT NULL,
    preferred_location VARCHAR(150) NULL,
    willing_to_relocate TINYINT(1) NULL,

    -- Skills
    primary_skills TEXT NULL,
    secondary_skills TEXT NULL,
    computer_skills TEXT NULL,
    language_skills TEXT NULL,

    -- Pipeline
    status ENUM(
        'new', 'screening', 'shortlisted', 'interview_scheduled', 'interviewed',
        'final_selection', 'offer_released', 'joined', 'rejected', 'on_hold', 'withdrawn'
    ) NOT NULL DEFAULT 'new',
    source ENUM('website', 'linkedin', 'facebook', 'whatsapp', 'referral', 'job_portal', 'other') NOT NULL DEFAULT 'website',
    source_detail VARCHAR(150) NULL COMMENT 'e.g. referring employee name, UTM value',
    assigned_hr BIGINT UNSIGNED NULL,
    is_possible_duplicate TINYINT(1) NOT NULL DEFAULT 0,
    duplicate_of_application_id BIGINT UNSIGNED NULL,

    -- Consent
    consent_accurate_info TINYINT(1) NOT NULL DEFAULT 0,
    consent_data_use TINYINT(1) NOT NULL DEFAULT 0,
    consent_privacy_terms TINYINT(1) NOT NULL DEFAULT 0,
    consent_no_guarantee TINYINT(1) NOT NULL DEFAULT 0,
    consent_given_at DATETIME NULL,
    ip_address VARCHAR(45) NULL,

    deleted_at DATETIME NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY idx_applications_candidate (candidate_id),
    KEY idx_applications_vacancy (vacancy_id),
    KEY idx_applications_status (status),
    KEY idx_applications_assigned (assigned_hr),
    KEY idx_applications_source (source),
    KEY idx_applications_created (created_at),
    CONSTRAINT fk_applications_candidate FOREIGN KEY (candidate_id) REFERENCES hr_candidates(id) ON DELETE CASCADE,
    CONSTRAINT fk_applications_vacancy FOREIGN KEY (vacancy_id) REFERENCES hr_vacancies(id) ON DELETE RESTRICT,
    CONSTRAINT fk_applications_assigned FOREIGN KEY (assigned_hr) REFERENCES admin_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_applications_deleted_by FOREIGN KEY (deleted_by) REFERENCES admin_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_applications_duplicate_of FOREIGN KEY (duplicate_of_application_id) REFERENCES hr_applications(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE hr_candidate_answers (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    application_id BIGINT UNSIGNED NOT NULL,
    question_id BIGINT UNSIGNED NOT NULL,
    answer_text TEXT NULL,
    KEY idx_answers_application (application_id),
    CONSTRAINT fk_answers_application FOREIGN KEY (application_id) REFERENCES hr_applications(id) ON DELETE CASCADE,
    CONSTRAINT fk_answers_question FOREIGN KEY (question_id) REFERENCES hr_application_questions(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE hr_education (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    application_id BIGINT UNSIGNED NOT NULL,
    highest_qualification VARCHAR(150) NULL,
    course_degree VARCHAR(150) NULL,
    institution VARCHAR(200) NULL,
    passing_year YEAR NULL,
    additional_certifications TEXT NULL,
    KEY idx_education_application (application_id),
    CONSTRAINT fk_education_application FOREIGN KEY (application_id) REFERENCES hr_applications(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE hr_employment_history (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    application_id BIGINT UNSIGNED NOT NULL,
    company_name VARCHAR(150) NULL,
    designation VARCHAR(150) NULL,
    duration VARCHAR(100) NULL,
    KEY idx_employment_application (application_id),
    CONSTRAINT fk_employment_application FOREIGN KEY (application_id) REFERENCES hr_applications(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Private storage, same discipline as the visa CRM's documents table
-- (storage/hrms-documents/, randomized filename, real MIME sniffing,
-- served only through an authenticated download endpoint). A
-- dedicated table (not a reuse of the visa CRM's documents table)
-- because CVs are confidential HR data with their own access-audit
-- requirement (section 14) distinct from visa document verification.
CREATE TABLE hr_documents (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    application_id BIGINT UNSIGNED NOT NULL,
    document_type ENUM('cv', 'photograph', 'cover_letter', 'experience_certificate', 'educational_certificate', 'other') NOT NULL,
    original_filename VARCHAR(255) NOT NULL,
    stored_filename VARCHAR(255) NOT NULL,
    storage_path VARCHAR(500) NOT NULL,
    mime_type VARCHAR(100) NOT NULL,
    file_size INT UNSIGNED NOT NULL,
    uploaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at DATETIME NULL,
    KEY idx_hr_documents_application (application_id),
    CONSTRAINT fk_hr_documents_application FOREIGN KEY (application_id) REFERENCES hr_applications(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Per-document access log — section 14's explicit requirement,
-- separate from the general audit_logs table because it needs to
-- answer "who viewed this specific CV, when" as its own query shape.
CREATE TABLE hr_document_access_log (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    document_id BIGINT UNSIGNED NOT NULL,
    admin_user_id BIGINT UNSIGNED NULL,
    action ENUM('view', 'download') NOT NULL DEFAULT 'download',
    ip_address VARCHAR(45) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_doc_access_document (document_id),
    KEY idx_doc_access_admin (admin_user_id),
    CONSTRAINT fk_doc_access_document FOREIGN KEY (document_id) REFERENCES hr_documents(id) ON DELETE CASCADE,
    CONSTRAINT fk_doc_access_admin FOREIGN KEY (admin_user_id) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE hr_interviews (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    application_id BIGINT UNSIGNED NOT NULL,
    round_name VARCHAR(100) NOT NULL DEFAULT 'Interview',
    scheduled_at DATETIME NULL,
    mode ENUM('phone', 'video', 'in_person') NOT NULL DEFAULT 'video',
    location_or_link VARCHAR(255) NULL,
    interviewer BIGINT UNSIGNED NULL,
    status ENUM('scheduled', 'completed', 'rescheduled', 'cancelled', 'no_show') NOT NULL DEFAULT 'scheduled',
    created_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_interviews_application (application_id),
    CONSTRAINT fk_interviews_application FOREIGN KEY (application_id) REFERENCES hr_applications(id) ON DELETE CASCADE,
    CONSTRAINT fk_interviews_interviewer FOREIGN KEY (interviewer) REFERENCES admin_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_interviews_created_by FOREIGN KEY (created_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE hr_interview_feedback (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    interview_id BIGINT UNSIGNED NOT NULL,
    given_by BIGINT UNSIGNED NULL,
    rating TINYINT UNSIGNED NULL COMMENT '1-5',
    recommendation ENUM('select', 'reject', 'hold') NULL,
    feedback_text TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_feedback_interview (interview_id),
    CONSTRAINT fk_feedback_interview FOREIGN KEY (interview_id) REFERENCES hr_interviews(id) ON DELETE CASCADE,
    CONSTRAINT fk_feedback_given_by FOREIGN KEY (given_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE hr_notes (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    application_id BIGINT UNSIGNED NOT NULL,
    admin_user_id BIGINT UNSIGNED NULL,
    note TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_notes_application (application_id),
    CONSTRAINT fk_hr_notes_application FOREIGN KEY (application_id) REFERENCES hr_applications(id) ON DELETE CASCADE,
    CONSTRAINT fk_hr_notes_admin FOREIGN KEY (admin_user_id) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE hr_status_history (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    application_id BIGINT UNSIGNED NOT NULL,
    from_status VARCHAR(30) NULL,
    to_status VARCHAR(30) NOT NULL,
    changed_by BIGINT UNSIGNED NULL,
    remarks VARCHAR(500) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_status_history_application (application_id),
    CONSTRAINT fk_status_history_application FOREIGN KEY (application_id) REFERENCES hr_applications(id) ON DELETE CASCADE,
    CONSTRAINT fk_status_history_changed_by FOREIGN KEY (changed_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Outbound-email tracking, wired up but not populated until Phase B
-- configures real SMTP credentials (see AUDIT.md — no mail transport
-- has ever been configured anywhere in this project).
CREATE TABLE hr_email_log (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    application_id BIGINT UNSIGNED NULL,
    to_email VARCHAR(190) NOT NULL,
    template VARCHAR(100) NOT NULL,
    subject VARCHAR(255) NOT NULL,
    status ENUM('queued', 'sent', 'failed') NOT NULL DEFAULT 'queued',
    error_message VARCHAR(500) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_email_log_application (application_id),
    CONSTRAINT fk_email_log_application FOREIGN KEY (application_id) REFERENCES hr_applications(id) ON DELETE SET NULL
) ENGINE=InnoDB;

SET FOREIGN_KEY_CHECKS = 1;
