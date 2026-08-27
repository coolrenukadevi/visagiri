-- B2B Partner CRM — Phase 1: RBAC foundation + a real admin Partner
-- CRM. Additive only, run after schema-customer-partner-portal.sql
-- (which created partners/partner_commissions). Does not touch
-- partners.status — it stays the existing 3-value ENUM
-- (pending/active/suspended) for this phase; the client's requested
-- 9-state workflow is driven by a multi-step registration wizard and
-- approval flow that don't exist yet, so widening the ENUM now would
-- add states nothing can reach. See AUDIT.md for the full phasing.

SET FOREIGN_KEY_CHECKS = 0;

-- Relationship Manager assignment — nullable, "ships empty until a
-- real assignment exists" same as partner_commissions.amount_due.
ALTER TABLE partners
    ADD COLUMN assigned_admin_id BIGINT UNSIGNED NULL AFTER approved_at,
    ADD CONSTRAINT fk_partners_assigned_admin FOREIGN KEY (assigned_admin_id) REFERENCES admin_users(id) ON DELETE SET NULL;

-- audit_logs.admin_user_id is already nullable (confirmed in
-- schema-crm.sql), so adding one more nullable actor column is a
-- small, consistent extension of the same "not every action has an
-- admin actor" shape already in place — not a new pattern. Not used
-- by any admin-only action in this phase; exists so log_action()'s
-- new $partnerActorId param has somewhere to write once partners can
-- act on their own account in a later phase.
ALTER TABLE audit_logs
    ADD COLUMN partner_id BIGINT UNSIGNED NULL AFTER admin_user_id,
    ADD KEY idx_audit_partner (partner_id),
    ADD CONSTRAINT fk_audit_partner FOREIGN KEY (partner_id) REFERENCES partners(id) ON DELETE SET NULL;

-- Per-partner status timeline, same shape as forex_status_history —
-- gives the new admin partner profile page a real "Status History"
-- section instead of only the generic audit log.
CREATE TABLE partner_status_history (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    partner_id BIGINT UNSIGNED NOT NULL,
    from_status VARCHAR(40) NULL,
    to_status VARCHAR(40) NOT NULL,
    changed_by BIGINT UNSIGNED NULL,
    remarks VARCHAR(500) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_partner_status_history_partner (partner_id),
    CONSTRAINT fk_partner_status_history_partner FOREIGN KEY (partner_id) REFERENCES partners(id) ON DELETE CASCADE,
    CONSTRAINT fk_partner_status_history_changed_by FOREIGN KEY (changed_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

SET FOREIGN_KEY_CHECKS = 1;
