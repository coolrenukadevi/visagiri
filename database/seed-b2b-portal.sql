-- RBAC for the standalone B2B Travel Partner Portal. Reuses the
-- existing roles/permissions/role_permissions tables (shared infra)
-- with new permission keys distinct from the existing partners.*
-- keys, since this is a genuinely separate partner system.
INSERT INTO permissions (permission_key, description) VALUES
('b2b_travel_partners.view', 'View B2B Travel Partner applications and profiles'),
('b2b_travel_partners.manage', 'Approve/reject/suspend B2B Travel Partners, verify documents'),
('b2b_travel_partners.billing.view', 'View decrypted B2B Travel Partner banking/billing details');

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'super-admin' AND p.permission_key IN ('b2b_travel_partners.view', 'b2b_travel_partners.manage', 'b2b_travel_partners.billing.view');

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'admin' AND p.permission_key IN ('b2b_travel_partners.view', 'b2b_travel_partners.manage');
