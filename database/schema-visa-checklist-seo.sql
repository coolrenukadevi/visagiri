-- Visa Checklist Engine SEO Wave 3 — per-country-per-visa-type meta
-- title/description override, matching the exact same additive
-- pattern already used for countries/visa_types/visa_faqs/embassies/
-- consulates (see database/schema-content-cms-phase3.sql). NULL by
-- default so every existing checklist keeps its current PHP-generated
-- fallback title/description (visa/index.php) exactly as before —
-- this only lets specific pairs override it, it does not change
-- behavior for the ~1,865 pairs that don't set it.
--
-- Run this file only when migrating an EXISTING database — already
-- folded into a fresh install via database/seed-crm.sql the same way
-- schema-content-cms-phase3.sql documents.

ALTER TABLE visa_checklists
    ADD COLUMN meta_title VARCHAR(255) NULL AFTER reference,
    ADD COLUMN meta_description VARCHAR(500) NULL AFTER meta_title;
