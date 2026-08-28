-- Legal & Support Centre — Phase 1 seed: grievances.* permissions
-- (granted to super-admin and admin, same idiom as seed-b2b.sql — no
-- new role, per the plan's decision record) plus site_settings rows:
-- a real, admin-editable SLA-hours default, and empty-by-default
-- "legal fact" keys that the new legal pages omit entirely when
-- unset rather than showing a placeholder or a fabricated value.

INSERT INTO permissions (permission_key, description) VALUES
('grievances.view', 'View grievance records'),
('grievances.manage', 'Update status/priority/assignment and escalate grievances');

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'super-admin' AND p.permission_key LIKE 'grievances.%';

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'admin' AND p.permission_key LIKE 'grievances.%';

INSERT INTO site_settings (setting_key, setting_value) VALUES
('grievance_sla_hours', '72'),
('legal_registered_office_address', ''),
('legal_governing_law', ''),
('legal_jurisdiction_city', ''),
('legal_grievance_officer_name', ''),
('legal_grievance_officer_email', ''),
-- Per-page "Last updated" dates. Unlike the facts above, this one is
-- genuinely known (the real date this content was authored), so it
-- ships with a real value rather than empty — an admin bumps it
-- whenever a page's content is materially revised, per the spec.
('legal_privacy_updated_at', CURDATE()),
('legal_terms_updated_at', CURDATE()),
('legal_travel_terms_updated_at', CURDATE()),
('legal_payment_policy_updated_at', CURDATE()),
('legal_refund_policy_updated_at', CURDATE()),
('legal_cookie_policy_updated_at', CURDATE()),
('legal_grievance_updated_at', CURDATE());
