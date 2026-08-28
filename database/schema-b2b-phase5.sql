-- B2B Partner CRM — Phase 5: tiered pricing/commission engine. Additive,
-- run after schema-b2b.sql / -phase2.sql / -phase3.sql. Quotations
-- themselves are NOT a new table here: `visa_quotes` (schema-crm.sql)
-- already covers quoting any visa_applications row, partner-referred
-- or not, with its own full admin create/view flow — adding a second
-- `partner_quotations` table as originally sketched in the Phase 1
-- planning notes would just duplicate it. What's actually new is the
-- tier master data and the commission calculation it drives.

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE partner_tiers (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    commission_type ENUM('percentage', 'flat') NOT NULL DEFAULT 'percentage',
    commission_value DECIMAL(10, 2) NOT NULL,
    description VARCHAR(500) NULL,
    sort_order SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Ships NULL until an admin assigns one — same "ships empty until
-- real" convention as assigned_admin_id (Phase 1) and tier_id being
-- unset simply means no automatic commission suggestion is offered
-- yet, not that the partner earns zero commission.
ALTER TABLE partners
    ADD COLUMN tier_id BIGINT UNSIGNED NULL AFTER assigned_admin_id,
    ADD CONSTRAINT fk_partners_tier FOREIGN KEY (tier_id) REFERENCES partner_tiers(id) ON DELETE SET NULL;

SET FOREIGN_KEY_CHECKS = 1;
