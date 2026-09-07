-- RBAC for the Recycle Bin (admin/pages/recycle-bin.php). Deliberately
-- granted to Super Admin only — restoring a soft-deleted record is
-- gated by an OTP emailed to a fixed operational address
-- (info@tripgation.com), not the acting admin's own inbox, precisely
-- because this is meant to be harder to self-approve than an ordinary
-- permission grant. admin/pages/recycle-bin.php also hard-checks
-- role_slug === 'super-admin' itself (defense in depth) rather than
-- trusting the permission grant alone.
INSERT INTO permissions (permission_key, description) VALUES
('recycle_bin.manage', 'View and OTP-restore soft-deleted records across every module (Super Admin only)');

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'super-admin' AND p.permission_key = 'recycle_bin.manage';
