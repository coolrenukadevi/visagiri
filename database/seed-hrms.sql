-- HRMS roles + permissions. Reuses the visa CRM's roles/permissions
-- tables (see database/seed-crm.sql) rather than a parallel RBAC
-- system — Super Admin already exists and gets every permission
-- below via the same CROSS JOIN pattern; this file only adds the two
-- new HR-specific roles and the hrms.* permission keys.

SET NAMES utf8mb4;

INSERT INTO roles (name, slug, description) VALUES
('HR Admin', 'hr-admin', 'Manages vacancies, all candidates, interviews, recruitment pipeline, and reports.'),
('HR Executive', 'hr-executive', 'Screening and interview coordination for candidates assigned to them only.');

INSERT INTO permissions (permission_key, description) VALUES
('hrms.dashboard.view', 'View the HRMS recruitment dashboard'),
('hrms.vacancies.manage', 'Create/edit/publish/close job vacancies and their application questions'),
('hrms.candidates.view', 'View candidate and application records'),
('hrms.candidates.manage', 'Change status, assign HR, add notes, move pipeline stage'),
('hrms.candidates.view_all', 'View every candidate/application, not just ones assigned to you'),
('hrms.documents.download', 'View/download candidate CVs and documents'),
('hrms.interviews.manage', 'Schedule interviews and record feedback'),
('hrms.reports.view', 'View and export recruitment reports');

-- Super Admin (already exists from the visa CRM seed): grant every
-- new hrms.* permission too, since the original seed's CROSS JOIN
-- already ran and won't retroactively pick these up.
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'super-admin' AND p.permission_key LIKE 'hrms.%';

-- HR Admin: everything except seeing/managing records outside their
-- own assignment isn't restricted for this role — full visibility.
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'hr-admin' AND p.permission_key LIKE 'hrms.%';

-- HR Executive: no hrms.candidates.view_all, so
-- current_admin_hrms_scoped_to_assigned() (includes/rbac.php)
-- restricts them to candidates assigned to them; no reports export.
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'hr-executive'
  AND p.permission_key IN ('hrms.dashboard.view', 'hrms.candidates.view', 'hrms.candidates.manage', 'hrms.documents.download', 'hrms.interviews.manage');

-- A dedicated HR Admin login for /hrms/ — separate from the site's
-- one 'admin' super-admin account, so HR staff have their own
-- credential rather than sharing the CRM/Forex admin login. Logs in
-- through the same admin_users table/session as every other role
-- (see hrms/pages/login.php) — CHANGE THIS PASSWORD and the
-- placeholder email immediately after first login via
-- /hrms/dashboard/ > Profile (or the equivalent admin_users update).
-- Credentials for this specific hash were provided separately,
-- outside this file, per the same rule as the main admin account.
INSERT INTO `admin_users` (`username`, `email`, `password_hash`, `full_name`, `status`) VALUES
('hr.admin', 'hr@visagiri.com', '$2y$12$7IHasXIqUVRcAgvyVjLUsehE0RFd0LMYouc0nz6h1bt53rYOpmMr2', 'Visagiri HR Admin', 'active');

UPDATE admin_users SET role_id = (SELECT id FROM roles WHERE slug = 'hr-admin') WHERE username = 'hr.admin';
