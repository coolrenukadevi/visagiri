-- Optional destination photo for a checklist's hero banner. Nullable
-- by design: most countries won't have a real, licensed photo
-- supplied yet, and the hero gracefully falls back to a navy/gold
-- gradient (see public/assets/css/visa-checklist.css) rather than a
-- broken image or a placeholder stock photo.

ALTER TABLE visa_checklists
    ADD COLUMN hero_image_url VARCHAR(255) NULL AFTER application_steps;
