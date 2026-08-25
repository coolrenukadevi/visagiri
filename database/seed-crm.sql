-- Roles + permissions for the Phase 1 CRM. Scoped to the two real
-- Visagiri service lines (visa consultancy, document attestation) —
-- see AUDIT.md. Only 3 of the spec's suggested 5-6 roles are seeded
-- (Super Admin, Admin, Visa Consultant); Sales Manager/Travel
-- Consultant/HR were listed in the original spec but have no real
-- role to fill yet in a visa-and-attestation-only business — the
-- roles table is just data, so adding one later (e.g. if HR needs
-- CRM access) doesn't need a code change, only a new row here.

SET NAMES utf8mb4;

INSERT INTO roles (name, slug, description) VALUES
('Super Admin', 'super-admin', 'Full system access, including user/role management and settings.'),
('Admin', 'admin', 'Customer, enquiry, application, and content management. No user/role management.'),
('Visa Consultant', 'visa-consultant', 'Visa enquiries and applications assigned to this consultant only.');

INSERT INTO permissions (permission_key, description) VALUES
('customers.view', 'View customer records'),
('customers.manage', 'Create/edit/delete customer records'),
('visa.view', 'View visa enquiries and applications'),
('visa.manage', 'Create/edit visa enquiries and applications, change status, add notes/quotes/payments'),
('visa.view_all', 'View every visa enquiry/application, not just ones assigned to you'),
('general_enquiries.view', 'View attestation and general contact enquiries'),
('general_enquiries.manage', 'Edit/assign/status-change general enquiries'),
('documents.upload', 'Upload documents to a customer/application/enquiry'),
('documents.verify', 'Mark uploaded documents verified or rejected'),
('content.manage', 'Manage countries, visa types, visa requirements, embassies, FAQs'),
('users.manage', 'Create/edit admin users and assign roles'),
('settings.manage', 'Edit site settings'),
('audit.view', 'View the audit log');

-- Super Admin: every permission.
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p WHERE r.slug = 'super-admin';

-- Admin: everything except users.manage and settings.manage.
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'admin' AND p.permission_key NOT IN ('users.manage', 'settings.manage');

-- Visa Consultant: visa work (scoped to assigned records — see
-- includes/rbac.php's current_admin_scoped_to_assigned()), read-only
-- on customers and general enquiries, document upload.
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'visa-consultant'
  AND p.permission_key IN ('customers.view', 'visa.view', 'visa.manage', 'general_enquiries.view', 'documents.upload');

-- Assign the existing admin user to Super Admin.
UPDATE admin_users SET role_id = (SELECT id FROM roles WHERE slug = 'super-admin') WHERE username = 'admin';
