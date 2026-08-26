-- Forex module roles + permissions. Reuses the existing roles/
-- permissions tables. "Sales / Travel Consultant" from the spec's
-- role list is intentionally NOT a new role — the existing
-- visa-consultant role already matches that exact description
-- (scoped to assigned records, create-only, no approval rights), so
-- it's simply granted the relevant forex.* permissions below rather
-- than creating a near-duplicate role.

SET NAMES utf8mb4;

INSERT INTO roles (name, slug, description) VALUES
('Forex Manager', 'forex-manager', 'Full forex operations: quotations, approvals, document verification, delivery, rates, compliance.'),
('Forex Executive', 'forex-executive', 'Creates forex requests, uploads documents, prepares quotations. Cannot approve or override compliance.'),
('Compliance / Audit', 'compliance-audit', 'Verifies compliance documentation, views audit/FEMA records. Cannot alter commercial quotation terms.'),
('Accounts', 'accounts', 'Views and updates payment status and financial reports.');

INSERT INTO permissions (permission_key, description) VALUES
('forex.dashboard.view', 'View the forex dashboard'),
('forex.requests.view', 'View forex requests'),
('forex.requests.view_all', 'View every forex request, not just ones assigned to you'),
('forex.requests.manage', 'Create/edit forex requests, update travel/visa/currency details'),
('forex.documents.upload', 'Upload forex compliance documents'),
('forex.documents.verify', 'Verify or reject uploaded forex documents'),
('forex.quotations.create', 'Create forex quotations'),
('forex.quotations.approve', 'Approve forex quotations'),
('forex.rates.manage', 'Maintain the master buy/sell exchange rate table'),
('forex.payments.manage', 'Record and update forex payment status'),
('forex.delivery.manage', 'Mark forex requests as delivered when compliance is complete'),
('forex.delivery.override', 'Override a blocked delivery compliance check (creates a permanent audit record)'),
('forex.compliance.view', 'View FEMA/audit records'),
('forex.country_rules.manage', 'Manage the country visa/document rules used to auto-build checklists'),
('forex.reports.view', 'View forex reports');

-- Super Admin: every forex.* permission (original seed's CROSS JOIN
-- already ran and won't retroactively pick these up).
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'super-admin' AND p.permission_key LIKE 'forex.%';

-- Forex Manager: everything.
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'forex-manager' AND p.permission_key LIKE 'forex.%';

-- Forex Executive: create/manage requests, upload documents, prepare
-- quotations, view dashboard/reports — no verify/approve/rates/
-- delivery/override/country-rules.
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'forex-executive'
  AND p.permission_key IN ('forex.dashboard.view', 'forex.requests.view', 'forex.requests.view_all', 'forex.requests.manage', 'forex.documents.upload', 'forex.quotations.create');

-- Compliance / Audit: read-heavy, verifies documents, views/exports
-- FEMA records, cannot touch commercial quotation terms or delivery.
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'compliance-audit'
  AND p.permission_key IN ('forex.dashboard.view', 'forex.requests.view', 'forex.requests.view_all', 'forex.documents.verify', 'forex.compliance.view');

-- Accounts: payment status + financial reporting only.
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'accounts'
  AND p.permission_key IN ('forex.dashboard.view', 'forex.requests.view', 'forex.requests.view_all', 'forex.payments.manage', 'forex.reports.view');

-- Visa Consultant (existing role, reused as the spec's "Sales/Travel
-- Consultant"): create requests, upload documents, view only their
-- own assigned requests (current_admin_scoped_to_assigned() already
-- returns true for this role — see includes/rbac.php), no approval.
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'visa-consultant'
  AND p.permission_key IN ('forex.dashboard.view', 'forex.requests.view', 'forex.requests.manage', 'forex.documents.upload');
