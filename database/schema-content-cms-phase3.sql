-- Content/CMS Phase 3 — audit logging (no schema change needed, see
-- admin/pages/*.php), SEO fields on Visa Types/FAQs/Embassies/
-- Consulates (Countries and Locations already had them), and a new
-- content.view read-only permission alongside the existing
-- content.manage. Run once against the live database after Phase 2;
-- also folded into database/seed-crm.sql for fresh installs.
--
-- Visa Application Centres deliberately do NOT get meta_title/
-- meta_description — unlike embassies/consulates they have no public
-- detail page of their own to carry meta tags for (see
-- admin/pages/embassies.php's $typesWithSeo).

SET NAMES utf8mb4;

ALTER TABLE visa_types
    ADD COLUMN meta_title VARCHAR(255) NULL AFTER is_active,
    ADD COLUMN meta_description VARCHAR(500) NULL AFTER meta_title;

ALTER TABLE visa_faqs
    ADD COLUMN meta_title VARCHAR(255) NULL AFTER is_active,
    ADD COLUMN meta_description VARCHAR(500) NULL AFTER meta_title;

ALTER TABLE embassies
    ADD COLUMN meta_title VARCHAR(255) NULL AFTER website,
    ADD COLUMN meta_description VARCHAR(500) NULL AFTER meta_title;

ALTER TABLE consulates
    ADD COLUMN meta_title VARCHAR(255) NULL AFTER website,
    ADD COLUMN meta_description VARCHAR(500) NULL AFTER meta_title;

-- content.view — read-only counterpart to the existing content.manage,
-- for a content reviewer role that shouldn't be able to create/edit/
-- delete. Every role that already holds content.manage is backfilled
-- with content.view below so nobody's existing access narrows.
INSERT IGNORE INTO permissions (permission_key, description) VALUES
('content.view', 'View countries, visa types, visa requirements, embassies, FAQs, locations, and visa checklists (read-only)');

INSERT INTO role_permissions (role_id, permission_id)
SELECT rp.role_id, (SELECT id FROM permissions WHERE permission_key = 'content.view')
FROM role_permissions rp
JOIN permissions p ON p.id = rp.permission_id
WHERE p.permission_key = 'content.manage'
ON DUPLICATE KEY UPDATE role_id = VALUES(role_id);
