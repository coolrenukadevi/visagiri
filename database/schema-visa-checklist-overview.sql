-- Adds the "Visa Overview" fields the checklist page's Overview tab
-- needs (purpose, typical stay, application method, whether personal
-- appearance is required, a processing-time note, and the consular
-- office name) — these belong at the same (country, visa_type)
-- granularity as visa_checklists itself, so they live on that table
-- rather than a new one. Also adds application_steps for the
-- Application Process tab (newline-separated steps, same rendering
-- pattern already used for visa_requirements.application_process).

ALTER TABLE visa_checklists
    ADD COLUMN purpose VARCHAR(255) NULL AFTER version,
    ADD COLUMN eligibility_summary VARCHAR(500) NULL AFTER purpose,
    ADD COLUMN typical_stay VARCHAR(150) NULL AFTER eligibility_summary,
    ADD COLUMN application_method VARCHAR(150) NULL AFTER typical_stay,
    ADD COLUMN personal_appearance TINYINT(1) NOT NULL DEFAULT 0 AFTER application_method,
    ADD COLUMN processing_note VARCHAR(255) NULL AFTER personal_appearance,
    ADD COLUMN consular_office VARCHAR(255) NULL AFTER processing_note,
    ADD COLUMN application_steps TEXT NULL AFTER consular_office;
