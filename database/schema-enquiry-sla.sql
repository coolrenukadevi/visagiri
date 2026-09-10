SET FOREIGN_KEY_CHECKS = 0;

-- Enquiry SLA + escalation, following the exact pattern already proven
-- for grievances (database/schema-legal-phase1.sql, admin/pages/
-- grievances.php): sla_due_at is never a stored "is breached" flag —
-- it's a plain due-timestamp, and breach is always computed fresh at
-- render time (enquiry_is_breached() in includes/enquiry.php). Unlike
-- grievances' single flat SLA-hours setting, an enquiry's SLA window
-- is priority-driven and auto-recomputed whenever priority changes
-- (admin/pages/enquiries.php's update handler) — the "workflow"
-- behavior the client's spec asked for: escalating an enquiry to
-- urgent automatically tightens its own deadline.
ALTER TABLE enquiries
    ADD COLUMN IF NOT EXISTS sla_due_at DATETIME NULL AFTER priority,
    ADD COLUMN IF NOT EXISTS escalated_at DATETIME NULL AFTER sla_due_at,
    ADD COLUMN IF NOT EXISTS escalated_from_user BIGINT UNSIGNED NULL AFTER escalated_at,
    ADD COLUMN IF NOT EXISTS escalation_reason VARCHAR(255) NULL AFTER escalated_from_user,
    -- Guards notify_breached_enquiry_slas() (includes/enquiry.php) so a
    -- breach is announced via the admin notification bell exactly
    -- once, not on every dashboard load — same idempotency pattern as
    -- reminders.notified_at (database/schema-reminders.sql).
    ADD COLUMN IF NOT EXISTS sla_breach_notified_at DATETIME NULL AFTER escalation_reason,
    ADD INDEX IF NOT EXISTS idx_enq_sla_due (sla_due_at);

SET FOREIGN_KEY_CHECKS = 1;

-- Priority-to-hours SLA windows, admin-editable via /admin/settings/
-- (same setting()/site_settings mechanism grievance_sla_hours already
-- uses). Defaults are a reasonable starting point, not a claim made to
-- any customer — purely Visagiri's own internal staff targets.
INSERT INTO site_settings (setting_key, setting_value)
VALUES
    ('enquiry_sla_hours_urgent', '4'),
    ('enquiry_sla_hours_high', '24'),
    ('enquiry_sla_hours_normal', '72'),
    ('enquiry_sla_hours_low', '120')
ON DUPLICATE KEY UPDATE setting_value = setting_value;
