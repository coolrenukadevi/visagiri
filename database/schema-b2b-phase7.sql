-- B2B Partner CRM — Phase 7: team/sub-users + a communication centre.
-- Additive, run after schema-b2b-phase6.sql.

SET FOREIGN_KEY_CHECKS = 0;

-- Additional logins scoped to an existing partner account. The
-- primary login stays exactly as-is (partners.email/password_hash,
-- unchanged) — this table is deliberately NOT a replacement for it,
-- just extra identities that authenticate into the same partner_id's
-- data. A partner_team_members row has no `owner` role value; "owner"
-- means "logged in via the partners table directly," checked in code
-- by the absence of a team_member session, not stored here.
CREATE TABLE partner_team_members (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    partner_id BIGINT UNSIGNED NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(190) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NULL,
    role ENUM('manager', 'viewer') NOT NULL DEFAULT 'viewer',
    status ENUM('invited', 'active', 'suspended') NOT NULL DEFAULT 'invited',
    invite_token_hash CHAR(64) NULL,
    invite_expires_at DATETIME NULL,
    invited_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_team_partner (partner_id),
    CONSTRAINT fk_team_partner FOREIGN KEY (partner_id) REFERENCES partners(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Communication centre: extends the existing visa_application_notes
-- table (already doing exactly this job for customers via
-- customer_id/visible_to_customer, see dashboard/pages/messages.php)
-- with the equivalent pair for partners, rather than standing up a
-- separate partner_messages table that would just duplicate the same
-- shape. A note can be visible to the customer, the partner, both, or
-- neither (a purely internal staff note) — the two audiences are
-- independent, so a partner never sees customer-facing chat and vice
-- versa purely by each query filtering on its own flag.
ALTER TABLE visa_application_notes
    ADD COLUMN partner_id BIGINT UNSIGNED NULL AFTER customer_id,
    ADD COLUMN visible_to_partner TINYINT(1) NOT NULL DEFAULT 0 AFTER visible_to_customer,
    ADD CONSTRAINT fk_notes_partner FOREIGN KEY (partner_id) REFERENCES partners(id) ON DELETE SET NULL;

SET FOREIGN_KEY_CHECKS = 1;
