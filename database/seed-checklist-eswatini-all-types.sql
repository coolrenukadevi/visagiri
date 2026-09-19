-- Eswatini (formerly Swaziland) Visa Checklist Engine content for all
-- 10 visa types — built fresh this session via web search.
--
-- Eswatini's real, distinctive facts verified this session:
--   - Indian citizens require a visa obtained BEFORE arrival — either
--     at a Swazi embassy/consulate or via the official eVisa portal
--     (evisa.gov.sz). Visa-on-arrival has been suspended — a genuine,
--     dated policy change worth flagging.
--   - Stay: up to 30 days, with a further 30-day extension available
--     at the Ministry of Home Affairs after arrival.
--   - eVisa fee and exact processing time not independently confirmed
--     this session — the official evisa.gov.sz portal exists but
--     specific pricing was not found in searchable secondary sources.
--
-- country_id 17 = Eswatini. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    17, 1, 'SWZ-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Eswatini.',
    'Indian citizens require a visa obtained before arrival — visa-on-arrival has been suspended. Apply via the official eVisa portal (evisa.gov.sz) or a Swazi embassy/consulate.',
    'Up to 30 days, with a further 30-day extension available at the Ministry of Home Affairs',
    'Apply online via the official evisa.gov.sz portal, or at the nearest Swazi embassy/consulate',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Eswatini Official eVisa Portal (evisa.gov.sz) — no in-person appearance required for the eVisa route',
    'Go to the official evisa.gov.sz portal\nComplete the online eVisa application form\nUpload passport bio page and photo\nPay the eVisa fee online\nReceive the eVisa approval before travel — visa-on-arrival is not available',
    '/assets/images/visa-heroes/eswatini.webp',
    'thekingdomofeswatini.com and entryconditions.com secondary sourcing; official evisa.gov.sz portal confirmed but exact fee not found', 'https://www.thekingdomofeswatini.com/visa-guide/', '2026-09-19'
);
SET @swz1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swz1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz1, 'Core Documents', 'Required from every applicant.', 1);
SET @swz1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@swz1s1, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@swz1s1, 'Completed Online eVisa Application', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @swz1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz1s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 1),
(@swz1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(17, 1, NULL, 'USD', 'Confirm at Portal', 'Fee not independently confirmed this session with an exact figure; confirm current pricing on evisa.gov.sz.', '2026-09-01', NOW(), 'https://evisa.gov.sz/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens get an Eswatini visa on arrival?', 'No — visa-on-arrival has been suspended. Indian citizens must obtain a visa before arrival, either via the official eVisa portal (evisa.gov.sz) or a Swazi embassy/consulate.', 17, 1, 1700, 1),
('How long can I stay in Eswatini on a tourist visa?', 'Up to 30 days, with a further 30-day extension available at the Ministry of Home Affairs after arrival.', 17, 1, 1701, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    17, 2, 'SWZ-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Eswatini.',
    'Business travellers use the same eVisa/embassy framework as tourists, adding a business invitation letter.',
    'Up to 30 days, with a further 30-day extension available at the Ministry of Home Affairs',
    'Apply online via the official evisa.gov.sz portal, or at the nearest Swazi embassy/consulate',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Eswatini Official eVisa Portal (evisa.gov.sz) — no in-person appearance required for the eVisa route',
    'Obtain a business invitation letter\nGo to the official evisa.gov.sz portal\nUpload passport, photo, and supporting documents\nPay the eVisa fee online\nReceive the eVisa approval before travel',
    '/assets/images/visa-heroes/eswatini.webp',
    'thekingdomofeswatini.com and entryconditions.com secondary sourcing', 'https://www.thekingdomofeswatini.com/visa-guide/', '2026-09-19'
);
SET @swz2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swz2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz2, 'Core Documents', 'Required from every applicant.', 1);
SET @swz2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@swz2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @swz2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@swz2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(17, 2, NULL, 'USD', 'Confirm at Portal', 'Fee not independently confirmed this session; confirm current pricing on evisa.gov.sz.', '2026-09-01', NOW(), 'https://evisa.gov.sz/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for the Eswatini eVisa for business travel?', 'Yes — business travellers use the same eVisa framework as tourists, adding a business invitation letter to the application.', 17, 2, 1702, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    17, 3, 'SWZ-STUD-IN-01', '2026.09', 'published',
    'Academic study in Eswatini.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires a long-stay visa beyond the standard 30-day allowance.',
    'Tied to the academic program duration',
    'Confirm with the nearest Eswatini mission for the student-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Eswatini diplomatic mission (confirm current jurisdiction serving India)',
    'Secure admission confirmation from the Eswatini institution\nCheck whether the standard eVisa or a separate student visa applies\nGather proof of financial support\nApply via the relevant mission or eVisa portal\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/eswatini.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.thekingdomofeswatini.com/visa-guide/', '2026-09-19'
);
SET @swz3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swz3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz3, 'Core Documents', 'Required from every applicant.', 1);
SET @swz3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@swz3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @swz3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@swz3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(17, 3, NULL, 'USD', 'Confirm at Mission', 'Student visa fee not independently confirmed this session; confirm with the relevant Eswatini mission.', '2026-09-01', NOW(), 'https://www.thekingdomofeswatini.com/visa-guide/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for Eswatini?', 'Not independently confirmed this session — longer academic programs likely require a long-stay visa beyond the standard 30-day allowance. Confirm with the relevant mission.', 17, 3, 1703, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    17, 4, 'SWZ-WORK-IN-01', '2026.09', 'published',
    'Employment with an Eswatini company.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires an employer-sponsored work permit beyond the standard eVisa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the nearest Eswatini mission for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Eswatini diplomatic mission (confirm current jurisdiction serving India)',
    'Secure a signed employment contract from the Eswatini employer\nCheck whether a separate work permit is required beyond the eVisa\nGather proof of qualifications\nApply via the relevant mission\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/eswatini.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.thekingdomofeswatini.com/visa-guide/', '2026-09-19'
);
SET @swz4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swz4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz4, 'Core Documents', 'Required from every applicant.', 1);
SET @swz4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@swz4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @swz4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@swz4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(17, 4, NULL, 'USD', 'Confirm at Mission', 'Work permit fee not independently confirmed this session; confirm with the relevant Eswatini mission.', '2026-09-01', NOW(), 'https://www.thekingdomofeswatini.com/visa-guide/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for Eswatini beyond the eVisa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit. Confirm with the relevant mission.', 17, 4, 1704, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    17, 5, 'SWZ-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Eswatini.',
    'Family visits use the same eVisa framework as tourism, adding an invitation letter and relationship proof.',
    'Up to 30 days, with a further 30-day extension available at the Ministry of Home Affairs',
    'Apply online via the official evisa.gov.sz portal, or at the nearest Swazi embassy/consulate',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Eswatini Official eVisa Portal (evisa.gov.sz) — no in-person appearance required for the eVisa route',
    'Obtain an invitation letter from the family member resident in Eswatini\nGo to the official evisa.gov.sz portal\nUpload passport, photo, and relationship proof\nPay the eVisa fee online\nReceive the eVisa approval before travel',
    '/assets/images/visa-heroes/eswatini.webp',
    'thekingdomofeswatini.com and entryconditions.com secondary sourcing', 'https://www.thekingdomofeswatini.com/visa-guide/', '2026-09-19'
);
SET @swz5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swz5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz5, 'Core Documents', 'Required from every applicant.', 1);
SET @swz5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@swz5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @swz5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@swz5s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(17, 5, NULL, 'USD', 'Confirm at Portal', 'Fee not independently confirmed this session; confirm current pricing on evisa.gov.sz.', '2026-09-01', NOW(), 'https://evisa.gov.sz/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Eswatini on the standard eVisa?', 'Yes — family visits use the same eVisa framework as tourism, with an invitation letter and relationship proof added.', 17, 5, 1705, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    17, 6, 'SWZ-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Eswatini en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard eVisa or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the eVisa portal or your airline whether the standard eVisa applies',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Eswatini Official eVisa Portal (evisa.gov.sz) — no in-person appearance required',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific eVisa is required\nGo to the official evisa.gov.sz portal if needed\nUpload passport, photo, and onward ticket\nConfirm requirements with your airline before travel',
    '/assets/images/visa-heroes/eswatini.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.thekingdomofeswatini.com/visa-guide/', '2026-09-19'
);
SET @swz6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swz6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz6, 'Core Documents', 'Required from every applicant.', 1);
SET @swz6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@swz6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @swz6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(17, 6, NULL, 'USD', 'Confirm at Portal', 'Transit fee not independently confirmed this session; confirm on the official eVisa portal.', '2026-09-01', NOW(), 'https://evisa.gov.sz/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Eswatini?', 'Not independently confirmed this session — confirm with the eVisa portal or your airline whether your specific transit routing requires the standard eVisa.', 17, 6, 1706, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    17, 7, 'SWZ-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Eswatini.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with medical documentation.',
    'Up to 30 days, with a further 30-day extension available at the Ministry of Home Affairs',
    'Apply online via the official evisa.gov.sz portal, or at the nearest Swazi embassy/consulate',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Eswatini Official eVisa Portal (evisa.gov.sz) — no in-person appearance required for the eVisa route',
    'Obtain a medical appointment/admission letter from the hospital\nGo to the official evisa.gov.sz portal\nUpload passport, photo, and medical documents\nPay the eVisa fee online\nReceive the eVisa approval before travel',
    '/assets/images/visa-heroes/eswatini.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.thekingdomofeswatini.com/visa-guide/', '2026-09-19'
);
SET @swz7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swz7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz7, 'Core Documents', 'Required from every applicant.', 1);
SET @swz7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@swz7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @swz7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@swz7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(17, 7, NULL, 'USD', 'Confirm at Portal', 'Fee not independently confirmed this session; confirm current pricing on evisa.gov.sz.', '2026-09-01', NOW(), 'https://evisa.gov.sz/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Eswatini?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard eVisa with supporting medical documentation.', 17, 7, 1707, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    17, 8, 'SWZ-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Eswatini.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business eVisa framework with an event invitation.',
    'Up to 30 days, with a further 30-day extension available at the Ministry of Home Affairs',
    'Apply online via the official evisa.gov.sz portal, or at the nearest Swazi embassy/consulate',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Eswatini Official eVisa Portal (evisa.gov.sz) — no in-person appearance required for the eVisa route',
    'Obtain an official invitation letter from the event organiser\nGo to the official evisa.gov.sz portal\nUpload passport, photo, and event documents\nPay the eVisa fee online\nReceive the eVisa approval before travel',
    '/assets/images/visa-heroes/eswatini.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.thekingdomofeswatini.com/visa-guide/', '2026-09-19'
);
SET @swz8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swz8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz8, 'Core Documents', 'Required from every applicant.', 1);
SET @swz8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@swz8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @swz8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(17, 8, NULL, 'USD', 'Confirm at Portal', 'Fee not independently confirmed this session; confirm current pricing on evisa.gov.sz.', '2026-09-01', NOW(), 'https://evisa.gov.sz/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Eswatini?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business eVisa framework with an official invitation letter.', 17, 8, 1708, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    17, 9, 'SWZ-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Eswatini.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with an event invitation.',
    'Up to 30 days, with a further 30-day extension available at the Ministry of Home Affairs',
    'Apply online via the official evisa.gov.sz portal, or at the nearest Swazi embassy/consulate',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Eswatini Official eVisa Portal (evisa.gov.sz) — no in-person appearance required for the eVisa route',
    'Obtain an official invitation from the sporting federation/event organiser\nGo to the official evisa.gov.sz portal\nUpload passport, photo, and event documents\nPay the eVisa fee online\nReceive the eVisa approval before travel',
    '/assets/images/visa-heroes/eswatini.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.thekingdomofeswatini.com/visa-guide/', '2026-09-19'
);
SET @swz9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swz9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz9, 'Core Documents', 'Required from every applicant.', 1);
SET @swz9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@swz9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @swz9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(17, 9, NULL, 'USD', 'Confirm at Portal', 'Fee not independently confirmed this session; confirm current pricing on evisa.gov.sz.', '2026-09-01', NOW(), 'https://evisa.gov.sz/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Eswatini?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard eVisa with a federation/event invitation.', 17, 9, 1709, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    17, 10, 'SWZ-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Eswatini work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the nearest Eswatini mission for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Eswatini diplomatic mission (confirm current jurisdiction serving India)',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply via the relevant mission\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/eswatini.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.thekingdomofeswatini.com/visa-guide/', '2026-09-19'
);
SET @swz10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swz10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz10, 'Core Documents', 'Required from every applicant.', 1);
SET @swz10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@swz10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swz10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @swz10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swz10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@swz10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(17, 10, NULL, 'USD', 'Confirm at Mission', 'Dependent permit fee not independently confirmed this session; confirm with the relevant Eswatini mission.', '2026-09-01', NOW(), 'https://www.thekingdomofeswatini.com/visa-guide/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Eswatini?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the relevant mission.', 17, 10, 1710, 1);
