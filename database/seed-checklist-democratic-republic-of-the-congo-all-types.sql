-- Democratic Republic of the Congo (DRC) Visa Checklist Engine content
-- for all 10 visa types — built fresh this session via web search.
--
-- SOURCING CAVEAT: one source claims Indian citizens can enter DRC
-- visa-free for 30-90 days, but this conflicts with the large majority
-- of sourcing (including the DRC's own official eVisa portal,
-- evisa.gouv.cd) describing a mandatory eVisa. The eVisa route is used
-- below as the primary path since it is the majority-sourced and
-- officially-documented position, and the "visa-free" claim is flagged
-- as likely outdated or incorrect rather than silently adopted.
--
-- DRC's real, distinctive facts verified this session:
--   - Official eVisa fee: USD 50 via evisa.gouv.cd (avoid unofficial
--     third-party sites, which reportedly charge USD 300+).
--   - Distinctive additional cost: a separate USD 90 arrival fee is
--     paid on entry, on top of the USD 50 eVisa fee — a genuinely
--     unusual two-part cost structure.
--   - Processing: ~10 business days.
--   - Validity: single-entry only, 30 days validity, 30 days max stay.
--
-- country_id 12 = Democratic Republic of the Congo. visa_type_id:
-- 1=Tourist, 2=Business, 3=Student, 4=Work, 5=Family Visit, 6=Transit,
-- 7=Medical, 8=Conference, 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    12, 1, 'COD-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to the Democratic Republic of the Congo.',
    'Indian citizens require a mandatory eVisa — one secondary source claims visa-free entry, but this conflicts with the DRC''s own official eVisa portal and the majority of sourcing.',
    'Up to 30 days, single-entry',
    'Apply online for the eVisa via the official evisa.gouv.cd portal — avoid unofficial third-party sites',
    0,
    'Approximately 10 business days',
    'DRC Official eVisa Portal (online) — no in-person appearance required',
    'Go to the official evisa.gouv.cd portal (avoid unofficial sites)\nComplete the online eVisa application form\nUpload passport bio page and photo\nPay the USD 50 eVisa fee online\nBudget for a separate USD 90 fee payable on arrival at the port of entry',
    '/assets/images/visa-heroes/democratic-republic-of-the-congo.webp',
    'Official DRC eVisa portal (evisa.gouv.cd) and evisaguides.com/congo-evisa.com secondary sourcing; one source''s visa-free claim conflicts with the majority and official position', 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', '2026-09-19'
);
SET @cod1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cod1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod1, 'Core Documents', 'Required from every applicant.', 1);
SET @cod1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cod1s1, 'Passport-Size Photograph (White Background)', NULL, 'copy', 1, 0, 1, 2),
(@cod1s1, 'Completed Online eVisa Application', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @cod1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod1s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@cod1s2, 'Proof of Accommodation Booking or Invitation Letter', NULL, 'copy', 1, 0, 0, 2),
(@cod1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(12, 1, 50.00, 'USD', 'Official eVisa Fee', 'Applied via evisa.gouv.cd. A separate, distinctive USD 90 fee is also payable on arrival at the port of entry, on top of this eVisa fee. Unofficial third-party sites reportedly charge USD 300+ — apply only through the official portal.', '2026-01-01', NOW(), 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for the DRC?', 'Yes — an eVisa is required, applied for via the official evisa.gouv.cd portal. One secondary source claims visa-free entry, but this conflicts with the DRC''s own official portal and the majority of current sourcing.', 12, 1, 1200, 1),
('Is there an extra fee to pay on arrival in the DRC?', 'Yes — beyond the USD 50 eVisa fee, a separate USD 90 fee is payable at the port of entry on arrival, a distinctive two-part cost structure.', 12, 1, 1201, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    12, 2, 'COD-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in the DRC.',
    'Business travellers use the same mandatory eVisa framework as tourists, adding a business invitation letter.',
    'Up to 30 days, single-entry',
    'Apply online for the eVisa via the official evisa.gouv.cd portal',
    0,
    'Approximately 10 business days',
    'DRC Official eVisa Portal (online) — no in-person appearance required',
    'Obtain a business invitation letter\nGo to the official evisa.gouv.cd portal\nUpload passport, photo, and supporting documents\nPay the USD 50 eVisa fee online\nBudget for a separate USD 90 fee payable on arrival',
    '/assets/images/visa-heroes/democratic-republic-of-the-congo.webp',
    'Official DRC eVisa portal (evisa.gouv.cd) and congo-evisa.com secondary sourcing', 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', '2026-09-19'
);
SET @cod2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cod2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod2, 'Core Documents', 'Required from every applicant.', 1);
SET @cod2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cod2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @cod2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@cod2s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(12, 2, 50.00, 'USD', 'Official eVisa Fee', 'Applied via evisa.gouv.cd. A separate USD 90 fee is also payable on arrival.', '2026-01-01', NOW(), 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should business travellers budget for both eVisa costs?', 'Yes — budget for both the USD 50 eVisa fee paid online and the separate USD 90 fee paid on arrival, regardless of travel purpose.', 12, 2, 1202, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    12, 3, 'COD-STUD-IN-01', '2026.09', 'published',
    'Academic study in the DRC.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires a long-stay visa beyond the standard 30-day eVisa.',
    'Tied to the academic program duration',
    'Confirm with the nearest DRC mission for the student-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest DRC diplomatic mission (confirm current jurisdiction serving India)',
    'Secure admission confirmation from the Congolese institution\nCheck whether the standard eVisa or a separate student visa applies\nGather proof of financial support\nApply via the relevant mission or eVisa portal\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/democratic-republic-of-the-congo.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', '2026-09-19'
);
SET @cod3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cod3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod3, 'Core Documents', 'Required from every applicant.', 1);
SET @cod3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cod3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @cod3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@cod3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(12, 3, NULL, 'USD', 'Confirm at Mission', 'Student visa fee not independently confirmed this session; confirm with the relevant DRC mission.', '2026-09-01', NOW(), 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for the DRC?', 'Not independently confirmed this session — longer academic programs likely require a long-stay visa beyond the standard 30-day eVisa. Confirm with the relevant mission.', 12, 3, 1203, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    12, 4, 'COD-WORK-IN-01', '2026.09', 'published',
    'Employment with a Congolese (DRC) company.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires an employer-sponsored work permit beyond the standard eVisa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the nearest DRC mission for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest DRC diplomatic mission (confirm current jurisdiction serving India)',
    'Secure a signed employment contract from the DRC employer\nCheck whether a separate work permit is required beyond the eVisa\nGather proof of qualifications\nApply via the relevant mission\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/democratic-republic-of-the-congo.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', '2026-09-19'
);
SET @cod4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cod4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod4, 'Core Documents', 'Required from every applicant.', 1);
SET @cod4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cod4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @cod4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@cod4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(12, 4, NULL, 'USD', 'Confirm at Mission', 'Work permit fee not independently confirmed this session; confirm with the relevant DRC mission.', '2026-09-01', NOW(), 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for the DRC beyond the eVisa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit. Confirm with the relevant mission.', 12, 4, 1204, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    12, 5, 'COD-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in the DRC.',
    'Family visits use the same mandatory eVisa framework as tourism, adding an invitation letter and relationship proof.',
    'Up to 30 days, single-entry',
    'Apply online for the eVisa via the official evisa.gouv.cd portal',
    0,
    'Approximately 10 business days',
    'DRC Official eVisa Portal (online) — no in-person appearance required',
    'Obtain an invitation letter from the family member resident in the DRC\nGo to the official evisa.gouv.cd portal\nUpload passport, photo, and relationship proof\nPay the USD 50 eVisa fee online\nBudget for a separate USD 90 fee payable on arrival',
    '/assets/images/visa-heroes/democratic-republic-of-the-congo.webp',
    'Official DRC eVisa portal (evisa.gouv.cd) and congo-evisa.com secondary sourcing', 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', '2026-09-19'
);
SET @cod5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cod5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod5, 'Core Documents', 'Required from every applicant.', 1);
SET @cod5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cod5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @cod5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@cod5s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(12, 5, 50.00, 'USD', 'Official eVisa Fee', 'A separate USD 90 fee is also payable on arrival.', '2026-01-01', NOW(), 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in the DRC on the standard eVisa?', 'Yes — family visits use the same mandatory eVisa framework as tourism, with an invitation letter and relationship proof added.', 12, 5, 1205, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    12, 6, 'COD-TRAN-IN-01', '2026.09', 'published',
    'Transiting through the DRC en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard eVisa or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the eVisa portal or your airline whether the standard eVisa applies',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'DRC Official eVisa Portal (online) — no in-person appearance required',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific eVisa is required\nGo to the official evisa.gouv.cd portal if needed\nUpload passport, photo, and onward ticket\nBudget for the arrival fee if disembarking',
    '/assets/images/visa-heroes/democratic-republic-of-the-congo.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', '2026-09-19'
);
SET @cod6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cod6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod6, 'Core Documents', 'Required from every applicant.', 1);
SET @cod6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cod6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @cod6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(12, 6, NULL, 'USD', 'Confirm at Portal', 'Transit fee not independently confirmed this session; confirm on the official eVisa portal.', '2026-09-01', NOW(), 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through the DRC?', 'Not independently confirmed this session — confirm with the eVisa portal or your airline whether your specific transit routing requires the standard eVisa.', 12, 6, 1206, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    12, 7, 'COD-MED-IN-01', '2026.09', 'published',
    'Medical treatment in the DRC.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with medical documentation.',
    'Up to 30 days, single-entry',
    'Apply online for the eVisa via the official evisa.gouv.cd portal',
    0,
    'Approximately 10 business days',
    'DRC Official eVisa Portal (online) — no in-person appearance required',
    'Obtain a medical appointment/admission letter from the hospital\nGo to the official evisa.gouv.cd portal\nUpload passport, photo, and medical documents\nPay the USD 50 eVisa fee online\nBudget for a separate USD 90 fee payable on arrival',
    '/assets/images/visa-heroes/democratic-republic-of-the-congo.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', '2026-09-19'
);
SET @cod7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cod7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod7, 'Core Documents', 'Required from every applicant.', 1);
SET @cod7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cod7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @cod7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@cod7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(12, 7, 50.00, 'USD', 'Official eVisa Fee', 'A separate USD 90 fee is also payable on arrival.', '2026-01-01', NOW(), 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for the DRC?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard eVisa with supporting medical documentation.', 12, 7, 1207, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    12, 8, 'COD-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in the DRC.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business eVisa framework with an event invitation.',
    'Up to 30 days, single-entry',
    'Apply online for the eVisa via the official evisa.gouv.cd portal',
    0,
    'Approximately 10 business days',
    'DRC Official eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation letter from the event organiser\nGo to the official evisa.gouv.cd portal\nUpload passport, photo, and event documents\nPay the USD 50 eVisa fee online\nBudget for a separate USD 90 fee payable on arrival',
    '/assets/images/visa-heroes/democratic-republic-of-the-congo.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', '2026-09-19'
);
SET @cod8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cod8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod8, 'Core Documents', 'Required from every applicant.', 1);
SET @cod8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cod8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @cod8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(12, 8, 50.00, 'USD', 'Official eVisa Fee', 'A separate USD 90 fee is also payable on arrival.', '2026-01-01', NOW(), 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for the DRC?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business eVisa framework with an official invitation letter.', 12, 8, 1208, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    12, 9, 'COD-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in the DRC.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with an event invitation.',
    'Up to 30 days, single-entry',
    'Apply online for the eVisa via the official evisa.gouv.cd portal',
    0,
    'Approximately 10 business days',
    'DRC Official eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation from the sporting federation/event organiser\nGo to the official evisa.gouv.cd portal\nUpload passport, photo, and event documents\nPay the USD 50 eVisa fee online\nBudget for a separate USD 90 fee payable on arrival',
    '/assets/images/visa-heroes/democratic-republic-of-the-congo.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', '2026-09-19'
);
SET @cod9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cod9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod9, 'Core Documents', 'Required from every applicant.', 1);
SET @cod9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cod9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @cod9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(12, 9, 50.00, 'USD', 'Official eVisa Fee', 'A separate USD 90 fee is also payable on arrival.', '2026-01-01', NOW(), 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for the DRC?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard eVisa with a federation/event invitation.', 12, 9, 1209, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    12, 10, 'COD-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid DRC work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the nearest DRC mission for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest DRC diplomatic mission (confirm current jurisdiction serving India)',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply via the relevant mission\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/democratic-republic-of-the-congo.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', '2026-09-19'
);
SET @cod10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cod10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod10, 'Core Documents', 'Required from every applicant.', 1);
SET @cod10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cod10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cod10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @cod10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cod10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@cod10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(12, 10, NULL, 'USD', 'Confirm at Mission', 'Dependent permit fee not independently confirmed this session; confirm with the relevant DRC mission.', '2026-09-01', NOW(), 'https://congo-evisa.com/democratic-republic-of-the-congo-visa-fee/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in the DRC?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the relevant mission.', 12, 10, 1210, 1);
