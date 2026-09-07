-- Default document-requirement rules — the client spec's own worked
-- example (Business Visa -> Invitation Letter mandatory). Everything
-- else falls back to enquiry_default_document_requirements() in
-- includes/enquiry.php until an admin configures more rules from the
-- CRM's document-rules screen.
INSERT INTO enquiry_document_requirements (service_category, visa_type_id, country_id, document_category, is_mandatory, sort_order)
SELECT 'visa', id, NULL, 'invitation_letter', 1, 1 FROM visa_types WHERE slug = 'business';

-- RBAC for the unified enquiries CRM (admin/pages/enquiries.php).
-- Separate from visa.view/general_enquiries.view because this one
-- table now covers both Visa and Apostille enquiries together —
-- reusing either existing key would either over- or under-grant
-- access relative to what a role actually had before.
INSERT INTO permissions (permission_key, description) VALUES
('enquiries.view', 'View unified Visa + Apostille enquiries'),
('enquiries.manage', 'Update enquiry status/priority/assignment, review documents, soft-delete enquiries');

-- Super Admin: automatic (every permission).
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'super-admin' AND p.permission_key IN ('enquiries.view', 'enquiries.manage');

-- Admin: same as every other operational module it already has.
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'admin' AND p.permission_key IN ('enquiries.view', 'enquiries.manage');

-- Visa Consultant: same enquiries.view/manage a consultant already has
-- for visa.*, scoped to their own assigned records by the existing
-- current_admin_scoped_to_assigned() rule.
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.slug = 'visa-consultant' AND p.permission_key IN ('enquiries.view', 'enquiries.manage');
