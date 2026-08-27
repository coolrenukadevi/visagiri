-- B2B Partner CRM roles + permissions. Reuses the existing
-- roles/permissions/role_permissions tables (see database/seed-crm.sql)
-- rather than a parallel RBAC system, same as every other module —
-- this file only adds the six new B2B-specific roles and the
-- partners.* permission keys, replacing the old piggyback on
-- customers.view/customers.manage that admin/pages/partners.php used
-- before this phase.

SET NAMES utf8mb4;

INSERT INTO roles (name, slug, description) VALUES
('B2B Admin', 'b2b-admin', 'Full visibility and management of all B2B partners.'),
('B2B Relationship Manager', 'b2b-relationship-manager', 'Visibility limited to partners assigned to them.'),
('B2B Visa Manager', 'b2b-visa-manager', 'Visibility into partner records for visa-case oversight.'),
('B2B Accounts Manager', 'b2b-accounts-manager', 'Visibility into partner records for financial oversight.'),
('B2B Sales Manager', 'b2b-sales-manager', 'Visibility into partner records for sales/performance oversight.'),
('B2B Support Executive', 'b2b-support-executive', 'Visibility into partner records to assist with support queries.');

INSERT INTO permissions (permission_key, description) VALUES
('partners.view', 'View B2B partner records'),
('partners.view_all', 'View every partner, not just ones assigned to you'),
('partners.manage', 'Approve/suspend/reactivate partners and assign a Relationship Manager');

-- Super Admin (already exists from the visa CRM seed): grant every
-- new partners.* permission too, since the original seed's CROSS
-- JOIN already ran and won't retroactively pick these up.
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'super-admin' AND p.permission_key LIKE 'partners.%';

-- B2B Admin: full visibility + management.
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'b2b-admin' AND p.permission_key LIKE 'partners.%';

-- B2B Relationship Manager: deliberately no partners.view_all, so
-- current_admin_b2b_scoped_to_assigned() (includes/rbac.php)
-- restricts them to partners.assigned_admin_id = their own id; no
-- partners.manage either — approvals/suspensions stay with B2B Admin.
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'b2b-relationship-manager' AND p.permission_key = 'partners.view';

-- Visa/Accounts/Sales Manager and Support Executive: full visibility
-- (they're not the "assigned to me only" role — that's the
-- Relationship Manager above), but no approve/suspend/reassign
-- authority.
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug IN ('b2b-visa-manager', 'b2b-accounts-manager', 'b2b-sales-manager', 'b2b-support-executive')
  AND p.permission_key IN ('partners.view', 'partners.view_all');
