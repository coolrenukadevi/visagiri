-- Legal & Support Centre — Phase 1: the grievance-ticketing table
-- (with real SLA-due-time tracking and a manual-escalation trail, but
-- deliberately no automatic multi-level escalation and no new roles —
-- see the plan's decision record) plus a sibling nullable FK on
-- `documents` so grievance attachments reuse the existing upload
-- system instead of a parallel one. Additive, run after schema-crm.sql.

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE grievances (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    grievance_reference_no VARCHAR(30) NOT NULL UNIQUE,
    customer_id BIGINT UNSIGNED NULL,
    category VARCHAR(100) NOT NULL,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(190) NOT NULL,
    phone VARCHAR(20) NULL,
    related_reference_no VARCHAR(30) NULL,
    description TEXT NOT NULL,
    preferred_contact_method VARCHAR(20) NULL,
    source_page VARCHAR(255) NULL,
    assigned_user BIGINT UNSIGNED NULL,
    priority ENUM('low', 'normal', 'high', 'urgent') NOT NULL DEFAULT 'normal',
    status ENUM('new', 'in_progress', 'resolved', 'closed') NOT NULL DEFAULT 'new',
    sla_due_at DATETIME NULL,
    escalated_at DATETIME NULL,
    escalated_from_user BIGINT UNSIGNED NULL,
    escalation_reason VARCHAR(255) NULL,
    resolved_at DATETIME NULL,
    ip_address VARCHAR(45) NULL,
    deleted_at DATETIME NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_griev_status (status),
    KEY idx_griev_assigned (assigned_user),
    KEY idx_griev_sla_due (sla_due_at),
    CONSTRAINT fk_griev_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL,
    CONSTRAINT fk_griev_assigned FOREIGN KEY (assigned_user) REFERENCES admin_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_griev_escalated_from FOREIGN KEY (escalated_from_user) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE documents
    ADD COLUMN grievance_id BIGINT UNSIGNED NULL AFTER general_enquiry_id,
    ADD KEY idx_docs_grievance (grievance_id),
    ADD CONSTRAINT fk_docs_grievance FOREIGN KEY (grievance_id) REFERENCES grievances(id) ON DELETE CASCADE;

SET FOREIGN_KEY_CHECKS = 1;
