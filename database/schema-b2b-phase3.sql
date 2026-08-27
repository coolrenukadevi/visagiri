-- B2B Partner CRM — Phase 3: admin approval / document-verification
-- workflow + partner-facing notifications. Additive, run after
-- schema-b2b.sql and schema-b2b-phase2.sql.

SET FOREIGN_KEY_CHECKS = 0;

-- Widens the 3-value ENUM from Phase 1 now that this phase builds the
-- admin UI that can actually reach the new states:
--   documents_required — admin sent it back asking for more/better docs
--   rejected            — admin declined the application (terminal)
--   deactivated          — an active partner was shut down for cause (terminal)
-- pending/active/suspended keep their existing meaning and every
-- existing query/branch unchanged.
ALTER TABLE partners
    MODIFY COLUMN status ENUM('pending', 'documents_required', 'active', 'suspended', 'rejected', 'deactivated') NOT NULL DEFAULT 'pending';

-- Badge-only notification feed for the partner portal, mirroring
-- customer_notifications exactly so it can share the same rendering
-- pattern (dashboard-layout.php's unread-badge nav entry, the
-- notifications page itself).
CREATE TABLE partner_notifications (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    partner_id BIGINT UNSIGNED NOT NULL,
    type VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    body TEXT NULL,
    link VARCHAR(255) NULL,
    is_read TINYINT(1) NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_partner_notif_partner (partner_id, is_read),
    CONSTRAINT fk_partner_notif_partner FOREIGN KEY (partner_id) REFERENCES partners(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
