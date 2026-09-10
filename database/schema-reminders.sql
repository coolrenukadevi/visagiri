SET FOREIGN_KEY_CHECKS = 0;

-- Follow-up reminders, optionally tied to an enquiry. Deliberately not
-- cron-driven — no cron infrastructure exists anywhere in this project
-- (see AUDIT.md's document-expiry/tier-recalculation entries for the
-- same prior decision) and cPanel Cron Jobs availability on the
-- client's actual hosting plan has never been confirmed. Instead,
-- notify_due_reminders() (includes/reminders.php) is called whenever an
-- admin loads the dashboard, and fans out an admin_notifications row
-- the first time a reminder becomes due (notified_at guards against
-- re-notifying on every subsequent page load). bin/check-reminders.php
-- exposes the same function as an optional CLI entrypoint the client
-- can wire into cPanel Cron Jobs if their plan actually supports it.
CREATE TABLE IF NOT EXISTS reminders (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    enquiry_id BIGINT UNSIGNED NULL,
    title VARCHAR(255) NOT NULL,
    note TEXT NULL,
    due_date DATE NOT NULL,
    assigned_admin_id BIGINT UNSIGNED NULL,
    status ENUM('pending', 'done') NOT NULL DEFAULT 'pending',
    notified_at DATETIME NULL,
    created_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_at DATETIME NULL,
    KEY idx_reminders_due (status, due_date),
    KEY idx_reminders_assigned (assigned_admin_id, status),
    CONSTRAINT fk_reminders_enquiry FOREIGN KEY (enquiry_id) REFERENCES enquiries(id) ON DELETE CASCADE,
    CONSTRAINT fk_reminders_assigned FOREIGN KEY (assigned_admin_id) REFERENCES admin_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_reminders_created_by FOREIGN KEY (created_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;

-- RBAC: who can create/manage reminders — same role set enquiries.view/
-- manage was granted to (schema-enquiry-v2.sql), since reminders exist
-- to follow up on enquiries.
INSERT IGNORE INTO permissions (permission_key, description) VALUES
('reminders.manage', 'Create, complete, and snooze follow-up reminders');

INSERT IGNORE INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug IN ('super-admin', 'admin', 'visa-consultant') AND p.permission_key = 'reminders.manage';
