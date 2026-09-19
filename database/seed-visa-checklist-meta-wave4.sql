-- SEO Wave 4 — page-specific meta_title/meta_description for the
-- next 18 highest-intent country+visa-type checklist pages: China,
-- Japan, New Zealand, Singapore, South Korea, Thailand x
-- Tourist/Work/Student. Selection basis: countries.is_popular_destination
-- (a real, pre-existing curated flag) minus the 5 countries already
-- covered in Wave 3 and minus Schengen Area, which carries the flag
-- but has zero published visa_checklists rows (no content exists to
-- draw from, so it was not force-filled). No schema change — reuses
-- the meta_title/meta_description columns added in
-- database/schema-visa-checklist-seo.sql. Matched by `reference` for
-- environment portability, same as seed-visa-checklist-meta-wave3.sql.
--
-- Every fact referenced (CVASC, Z visa, COE, INZ Job Check, ICA SAVE/
-- SOLAR/EPOL, E-7/CVI, WP.3/Non-Immigrant B, Thailand's visa-free/TDAC
-- rules) is drawn directly from that row's own existing purpose/
-- application_method/typical_stay fields — no fees, processing times,
-- or outcomes stated beyond what's already in the row.
--
-- IMPORTANT: import with `mysql --default-character-set=utf8mb4 ...`
-- or via phpMyAdmin's Import tab — see AUDIT.md's Wave 3 entry for why.

UPDATE visa_checklists SET meta_title = 'China Tourist Visa from India: CVASC Requirements & Process | Visagiri', meta_description = 'China tourist visa from India: applying through the Chinese Visa Application Service Centre (CVASC) in Delhi, Mumbai or Kolkata, with the document checklist for Indian travellers.' WHERE reference = 'CHN-TOUR-IN-01';
UPDATE visa_checklists SET meta_title = 'China Work Visa (Z Visa) from India: Requirements & Process | Visagiri', meta_description = 'China Z visa from India: how the employer-led Work Permit Notification leads to your Z visa application, with the document checklist for Indian applicants.' WHERE reference = 'CHN-WORK-IN-04';
UPDATE visa_checklists SET meta_title = 'China Student Visa (X1/X2) from India: Requirements & Process | Visagiri', meta_description = 'China student visa from India: what your institution''s Admission Notice and JW201/JW202 form unlock for your X1/X2 visa application, plus the document checklist.' WHERE reference = 'CHN-STU-IN-03';

UPDATE visa_checklists SET meta_title = 'Japan Tourist Visa from India: Requirements & eVISA Process | Visagiri', meta_description = 'Japan tourist visa from India: applying via VFS Global, or the accredited-agency eVISA for eligible single-entry trips, with the document checklist for Indian travellers.' WHERE reference = 'JPN-TOUR-IN-01';
UPDATE visa_checklists SET meta_title = 'Japan Work Visa from India: COE Process & Requirements | Visagiri', meta_description = 'Japan work visa from India: how your employer''s Certificate of Eligibility (COE) leads to your VFS Global application, with the document checklist for Indian applicants.' WHERE reference = 'JPN-WORK-IN-04';
UPDATE visa_checklists SET meta_title = 'Japan Student Visa from India: COE, Documents & Process | Visagiri', meta_description = 'Japan student visa from India: what your institution''s Certificate of Eligibility (COE) unlocks for your VFS Global visa application, plus the document checklist.' WHERE reference = 'JPN-STU-IN-03';

UPDATE visa_checklists SET meta_title = 'New Zealand Tourist Visa from India: INZ Process & Documents | Visagiri', meta_description = 'New Zealand visitor visa from India: the online Immigration New Zealand (INZ) application and VFS Global biometrics, with the document checklist for Indian applicants.' WHERE reference = 'NZL-TOUR-IN-01';
UPDATE visa_checklists SET meta_title = 'New Zealand Work Visa from India: Job Check & Requirements | Visagiri', meta_description = 'New Zealand skilled work visa from India: how an INZ-accredited employer''s Job Check leads to your application, with the document checklist for Indian applicants.' WHERE reference = 'NZL-WORK-IN-04';
UPDATE visa_checklists SET meta_title = 'New Zealand Student Visa from India: INZ Process & Documents | Visagiri', meta_description = 'New Zealand student visa from India: the online INZ application for an approved education provider, with biometrics and the document checklist explained.' WHERE reference = 'NZL-STU-IN-03';

UPDATE visa_checklists SET meta_title = 'Singapore Tourist Visa from India: ICA SAVE Process & Documents | Visagiri', meta_description = 'Singapore visitor visa from India: applying online through ICA''s SAVE system via an authorised visa agent, with the document checklist for Indian travellers.' WHERE reference = 'SGP-TOUR-IN-01';
UPDATE visa_checklists SET meta_title = 'Singapore Work Visa (Employment Pass) from India: Requirements & Process | Visagiri', meta_description = 'Singapore Employment Pass from India: how your employer''s MOM EPOL application works, with the document checklist for Indian applicants.' WHERE reference = 'SGP-WORK-IN-04';
UPDATE visa_checklists SET meta_title = 'Singapore Student Visa from India: Student''s Pass & Process | Visagiri', meta_description = 'Singapore Student''s Pass from India: how your institution submits your application via ICA''s SOLAR system, with the document checklist explained.' WHERE reference = 'SGP-STU-IN-03';

UPDATE visa_checklists SET meta_title = 'South Korea Tourist Visa from India: Requirements & Application Process | Visagiri', meta_description = 'South Korea tourist visa from India: applying in person at a Korea Visa Application Center, with the document checklist for Indian travellers.' WHERE reference = 'KOR-TOUR-IN-01';
UPDATE visa_checklists SET meta_title = 'South Korea Work Visa (E-7) from India: Requirements & Process | Visagiri', meta_description = 'South Korea E-7 work visa from India: how your employer''s CVI approval leads to visa stamping, covering the 87 designated E-7 occupations, with the document checklist.' WHERE reference = 'KOR-WORK-IN-04';
UPDATE visa_checklists SET meta_title = 'South Korea Student Visa (D-2/D-4) from India: Requirements & Process | Visagiri', meta_description = 'South Korea student visa from India: the D-2 degree-program and D-4 language-training routes, applied for in person, with the document checklist explained.' WHERE reference = 'KOR-STU-IN-03';

UPDATE visa_checklists SET meta_title = 'Thailand Tourist Visa from India: Visa-Free, TDAC & e-Visa Rules | Visagiri', meta_description = 'Thailand tourist entry from India: visa-free stays with mandatory TDAC registration, or the e-Visa route for longer trips, with the document checklist explained.' WHERE reference = 'THA-TOUR-IN-01';
UPDATE visa_checklists SET meta_title = 'Thailand Work Visa from India: WP.3, Non-B & Work Permit | Visagiri', meta_description = 'Thailand work visa from India: the WP.3 pre-approval, Non-Immigrant "B" visa, and post-arrival Work Permit steps, with the document checklist for Indian applicants.' WHERE reference = 'THA-WORK-IN-04';
UPDATE visa_checklists SET meta_title = 'Thailand Student Visa (Non-Immigrant ED) from India: Requirements & Process | Visagiri', meta_description = 'Thailand Non-Immigrant "ED" student visa from India: the embassy application and in-country extension process, with the document checklist explained.' WHERE reference = 'THA-STU-IN-03';
