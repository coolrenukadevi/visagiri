-- Visa Documentation Portal — Phase A (architecture only, per the
-- client's own agreed sequencing: build the structure now, populate
-- real per-country visa policy/requirement facts later through the
-- admin CMS, exactly like visa_requirements/embassies already do).
--
-- Adds: a 10th visa type (Dependent Visa, to match the client's
-- requested category list); five country-grouping flags (GCC, ASEAN,
-- SAARC, Middle East, Caribbean) — these are stable, verifiable
-- political/geographic memberships, not visa policy, so they're
-- populated directly in seed-visa-portal.sql; and one new nullable
-- field, visa_policy_for_indians, which is a genuine visa-policy fact
-- (visa-free / visa-on-arrival / eVisa / visa-required) that VARIES
-- and needs a real source — it ships NULL for every country, same
-- discipline as visa_requirements shipping empty, and is only ever
-- set by a staff member through /admin/countries/.

SET FOREIGN_KEY_CHECKS = 0;

ALTER TABLE countries
    ADD COLUMN is_gcc TINYINT(1) NOT NULL DEFAULT 0 AFTER is_schengen,
    ADD COLUMN is_asean TINYINT(1) NOT NULL DEFAULT 0 AFTER is_gcc,
    ADD COLUMN is_saarc TINYINT(1) NOT NULL DEFAULT 0 AFTER is_asean,
    ADD COLUMN is_middle_east TINYINT(1) NOT NULL DEFAULT 0 AFTER is_saarc,
    ADD COLUMN is_caribbean TINYINT(1) NOT NULL DEFAULT 0 AFTER is_middle_east,
    ADD COLUMN visa_policy_for_indians ENUM('visa_required', 'visa_free', 'visa_on_arrival', 'evisa') NULL DEFAULT NULL AFTER is_caribbean,
    ADD KEY idx_countries_gcc (is_gcc),
    ADD KEY idx_countries_asean (is_asean),
    ADD KEY idx_countries_saarc (is_saarc),
    ADD KEY idx_countries_middle_east (is_middle_east),
    ADD KEY idx_countries_caribbean (is_caribbean),
    ADD KEY idx_countries_visa_policy (visa_policy_for_indians);

-- Dependent Visa sits after Work in display order per the client's
-- requested category list — shift the existing categories after it
-- rather than just appending Dependent at the end.
UPDATE visa_types SET sort_order = 6 WHERE slug = 'family';
UPDATE visa_types SET sort_order = 7 WHERE slug = 'transit';
UPDATE visa_types SET sort_order = 8 WHERE slug = 'medical';
UPDATE visa_types SET sort_order = 9 WHERE slug = 'conference';
UPDATE visa_types SET sort_order = 10 WHERE slug = 'sports';

INSERT INTO visa_types (name, slug, description, icon, sort_order, is_active) VALUES
('Dependent Visa', 'dependent', 'For spouses, children, and other dependents accompanying a family member already living abroad.', NULL, 5, 1);

-- Every existing country gets the new type marked available, matching
-- how the other 9 types were seeded (see AUDIT.md) — a starting point
-- for staff to mark unavailable per country if that's ever untrue,
-- not an assertion that dependent visas are guaranteed everywhere.
INSERT INTO country_visa_types (country_id, visa_type_id, is_available)
SELECT id, (SELECT id FROM visa_types WHERE slug = 'dependent'), 1 FROM countries;

SET FOREIGN_KEY_CHECKS = 1;
