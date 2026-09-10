-- Country-page content system — adds the rich, long-form editorial
-- fields the generic visa_requirements spec-sheet never had (overview,
-- who-should-apply framing, common mistakes/refusal factors, a short
-- local-city note) plus one new hub-level table (country_content) for
-- content that belongs to the country overview page, not to any single
-- visa type. Reuses the existing countries/visa_types/visa_requirements/
-- visa_faqs tables and the existing /visa/{country}/{type}/ route
-- rather than introducing a parallel content system — see AUDIT.md's
-- "Country visa content system" entry for the reasoning.
--
-- Ships empty for every country except the real content seeded for
-- Singapore in seed-country-content-singapore.sql; every other country
-- keeps rendering the existing honest "not yet published" fallback
-- until real content is added for it, same discipline as
-- visa_requirements always has.

CREATE TABLE country_content (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    country_id BIGINT UNSIGNED NOT NULL,
    hero_tagline VARCHAR(255) NULL,
    overview TEXT NULL,
    who_needs_visa TEXT NULL,
    services_across_india TEXT NULL,
    local_seo_patna TEXT NULL,
    common_mistakes TEXT NULL,
    source_url VARCHAR(500) NULL,
    last_reviewed_at DATE NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uniq_country_content_country (country_id),
    CONSTRAINT fk_country_content_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE
) ENGINE=InnoDB;

ALTER TABLE visa_requirements
    ADD COLUMN overview TEXT NULL AFTER visa_type_id,
    ADD COLUMN who_should_apply TEXT NULL AFTER overview,
    ADD COLUMN common_mistakes TEXT NULL AFTER notes,
    ADD COLUMN local_notes TEXT NULL AFTER common_mistakes,
    ADD COLUMN fee_notes VARCHAR(500) NULL AFTER currency,
    -- Widened from their original VARCHAR(150)/VARCHAR(100): this
    -- content system writes real explanatory sentences here (e.g. "MOM
    -- does not publish a fixed turnaround...") rather than the short
    -- "5-7 business days" values the columns were originally sized for.
    MODIFY COLUMN processing_time VARCHAR(500) NULL,
    MODIFY COLUMN validity_period VARCHAR(500) NULL,
    MODIFY COLUMN stay_duration VARCHAR(500) NULL;
