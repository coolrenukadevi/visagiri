-- B2B Travel Partner Portal — Phase B8: enquiry messaging, a partner
-- notification centre, and a support ticket system. Deliberately
-- separate tables from the old partner system's equivalents
-- (visa_application_notes, partner_notifications) — same standalone-
-- by-design decision behind every other table in this module.

SET FOREIGN_KEY_CHECKS = 0;

-- One thread per enquiry. Exactly one of sender_admin_id /
-- sender_partner_user_id is set per row, same split
-- b2b_enquiry_status_history already uses for "who changed this."
CREATE TABLE b2b_enquiry_messages (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    b2b_visa_enquiry_id BIGINT UNSIGNED NOT NULL,
    sender_admin_id BIGINT UNSIGNED NULL,
    sender_partner_user_id BIGINT UNSIGNED NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_b2b_enq_msg_enquiry (b2b_visa_enquiry_id),
    CONSTRAINT fk_b2b_enq_msg_enquiry FOREIGN KEY (b2b_visa_enquiry_id) REFERENCES b2b_visa_enquiries(id) ON DELETE CASCADE,
    CONSTRAINT fk_b2b_enq_msg_admin FOREIGN KEY (sender_admin_id) REFERENCES admin_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_b2b_enq_msg_partner_user FOREIGN KEY (sender_partner_user_id) REFERENCES b2b_partner_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Same shape as partner_notifications (database/schema-b2b-phase3.sql).
CREATE TABLE b2b_partner_notifications (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    b2b_partner_id BIGINT UNSIGNED NOT NULL,
    type VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    body TEXT NULL,
    link VARCHAR(255) NULL,
    is_read TINYINT(1) NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_b2b_partner_notif (b2b_partner_id, is_read),
    CONSTRAINT fk_b2b_partner_notif_partner FOREIGN KEY (b2b_partner_id) REFERENCES b2b_partners(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE b2b_support_tickets (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ticket_reference_no VARCHAR(30) NOT NULL UNIQUE,
    b2b_partner_id BIGINT UNSIGNED NOT NULL,
    created_by_user_id BIGINT UNSIGNED NOT NULL,
    subject VARCHAR(255) NOT NULL,
    category VARCHAR(60) NOT NULL DEFAULT 'general',
    priority ENUM('low', 'normal', 'high', 'urgent') NOT NULL DEFAULT 'normal',
    status ENUM('open', 'in_progress', 'resolved', 'closed') NOT NULL DEFAULT 'open',
    assigned_admin_id BIGINT UNSIGNED NULL,
    resolved_at DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_b2b_tickets_partner (b2b_partner_id),
    KEY idx_b2b_tickets_status (status),
    CONSTRAINT fk_b2b_tickets_partner FOREIGN KEY (b2b_partner_id) REFERENCES b2b_partners(id) ON DELETE CASCADE,
    CONSTRAINT fk_b2b_tickets_created_by FOREIGN KEY (created_by_user_id) REFERENCES b2b_partner_users(id) ON DELETE RESTRICT,
    CONSTRAINT fk_b2b_tickets_assigned FOREIGN KEY (assigned_admin_id) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE b2b_support_ticket_messages (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    b2b_support_ticket_id BIGINT UNSIGNED NOT NULL,
    sender_admin_id BIGINT UNSIGNED NULL,
    sender_partner_user_id BIGINT UNSIGNED NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_b2b_ticket_msg_ticket (b2b_support_ticket_id),
    CONSTRAINT fk_b2b_ticket_msg_ticket FOREIGN KEY (b2b_support_ticket_id) REFERENCES b2b_support_tickets(id) ON DELETE CASCADE,
    CONSTRAINT fk_b2b_ticket_msg_admin FOREIGN KEY (sender_admin_id) REFERENCES admin_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_b2b_ticket_msg_partner_user FOREIGN KEY (sender_partner_user_id) REFERENCES b2b_partner_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
