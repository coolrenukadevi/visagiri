-- Guinea (Conakry) Visa Checklist Engine content for all 10 visa
-- types — built fresh this session via web search.
--
-- SOURCING CAVEAT: sources disagree on the exact eVisa fee — reported
-- variously as USD 80, USD 50 (~EUR 45), or USD 100. Flagged honestly
-- below rather than picking one arbitrarily; the official portal
-- (paf.gov.gn) is the authoritative source to confirm current pricing.
--
-- Guinea's real, distinctive facts verified this session:
--   - Official eVisa portal: paf.gov.gn — apply only through this
--     official site, as unofficial sites charge extra fees.
--   - Validity: up to 90 days.
--   - Processing: announced at 72 hours for a complete application;
--     typically 3-4 business days in practice, with possible delays.
--
-- country_id 22 = Guinea. visa_type_id: 1=Tourist, 2=Business,
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
    22, 1, 'GIN-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Guinea (Conakry).',
    'Indian citizens require an eVisa, applied for online through the official paf.gov.gn portal — sources disagree on the exact current fee.',
    'Up to 90 days',
    'Apply online for the eVisa via the official paf.gov.gn portal — avoid unofficial third-party sites',
    0,
    'Announced at 72 hours for a complete application; typically 3-4 business days, with possible delays',
    'Guinea Official eVisa Portal (paf.gov.gn) — no in-person appearance required',
    'Go to the official paf.gov.gn portal (avoid unofficial sites)\nComplete the online eVisa application form\nUpload passport bio page and photo\nPay the eVisa fee online\nReceive the eVisa by email and carry it with your passport',
    '/assets/images/visa-heroes/guinea.webp',
    'visamundi.co, evisaguides.com secondary sourcing; sources disagree on the exact fee', 'https://evisaguides.com/en/destination/guinea/', '2026-09-19'
);
SET @gin1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gin1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin1, 'Core Documents', 'Required from every applicant.', 1);
SET @gin1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gin1s1, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@gin1s1, 'Completed Online eVisa Application', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @gin1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin1s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 1),
(@gin1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(22, 1, 80.00, 'USD', 'eVisa Fee', 'Sources disagree — reported variously as USD 80, USD 50 (~EUR 45), or USD 100. Confirm the current fee on the official paf.gov.gn portal.', '2026-01-01', NOW(), 'https://evisaguides.com/en/destination/guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Guinea?', 'Yes — an eVisa is required, applied for online through the official paf.gov.gn portal.', 22, 1, 2200, 1),
('What is the exact eVisa fee for Guinea?', 'Sources disagree, reporting figures ranging from USD 50 to USD 100. Confirm the current exact fee on the official paf.gov.gn portal before applying.', 22, 1, 2201, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    22, 2, 'GIN-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Guinea.',
    'Business travellers use the same eVisa framework as tourists, adding a business invitation letter.',
    'Up to 90 days',
    'Apply online for the eVisa via the official paf.gov.gn portal',
    0,
    'Announced at 72 hours for a complete application; typically 3-4 business days',
    'Guinea Official eVisa Portal (paf.gov.gn) — no in-person appearance required',
    'Obtain a business invitation letter\nGo to the official paf.gov.gn portal\nUpload passport, photo, and supporting documents\nPay the eVisa fee online\nReceive the eVisa by email',
    '/assets/images/visa-heroes/guinea.webp',
    'visamundi.co, evisaguides.com secondary sourcing', 'https://evisaguides.com/en/destination/guinea/', '2026-09-19'
);
SET @gin2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gin2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin2, 'Core Documents', 'Required from every applicant.', 1);
SET @gin2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gin2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @gin2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@gin2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(22, 2, 80.00, 'USD', 'eVisa Fee', 'Sources disagree — reported variously as USD 80, USD 50, or USD 100. Confirm the current fee on the official paf.gov.gn portal.', '2026-01-01', NOW(), 'https://evisaguides.com/en/destination/guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use the same eVisa portal for business travel to Guinea?', 'Yes — business travellers use the same eVisa framework as tourists, adding a business invitation letter.', 22, 2, 2202, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    22, 3, 'GIN-STUD-IN-01', '2026.09', 'published',
    'Academic study in Guinea.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires a long-stay visa beyond the standard 90-day eVisa.',
    'Tied to the academic program duration',
    'Confirm with the nearest Guinea mission for the student-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Guinea diplomatic mission (confirm current jurisdiction serving India)',
    'Secure admission confirmation from the Guinean institution\nCheck whether the standard eVisa or a separate student visa applies\nGather proof of financial support\nApply via the relevant mission or eVisa portal\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/guinea.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisaguides.com/en/destination/guinea/', '2026-09-19'
);
SET @gin3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gin3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin3, 'Core Documents', 'Required from every applicant.', 1);
SET @gin3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gin3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @gin3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@gin3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(22, 3, NULL, 'USD', 'Confirm at Mission', 'Student visa fee not independently confirmed this session; confirm with the relevant Guinea mission.', '2026-09-01', NOW(), 'https://evisaguides.com/en/destination/guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for Guinea?', 'Not independently confirmed this session — longer academic programs likely require a long-stay visa beyond the standard 90-day eVisa. Confirm with the relevant mission.', 22, 3, 2203, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    22, 4, 'GIN-WORK-IN-01', '2026.09', 'published',
    'Employment with a Guinean company.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires an employer-sponsored work permit beyond the standard eVisa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the nearest Guinea mission for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Guinea diplomatic mission (confirm current jurisdiction serving India)',
    'Secure a signed employment contract from the Guinean employer\nCheck whether a separate work permit is required beyond the eVisa\nGather proof of qualifications\nApply via the relevant mission\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/guinea.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisaguides.com/en/destination/guinea/', '2026-09-19'
);
SET @gin4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gin4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin4, 'Core Documents', 'Required from every applicant.', 1);
SET @gin4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gin4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @gin4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@gin4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(22, 4, NULL, 'USD', 'Confirm at Mission', 'Work permit fee not independently confirmed this session; confirm with the relevant Guinea mission.', '2026-09-01', NOW(), 'https://evisaguides.com/en/destination/guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for Guinea beyond the eVisa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit. Confirm with the relevant mission.', 22, 4, 2204, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    22, 5, 'GIN-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Guinea.',
    'Family visits use the same eVisa framework as tourism, adding an invitation letter and relationship proof.',
    'Up to 90 days',
    'Apply online for the eVisa via the official paf.gov.gn portal',
    0,
    'Announced at 72 hours for a complete application; typically 3-4 business days',
    'Guinea Official eVisa Portal (paf.gov.gn) — no in-person appearance required',
    'Obtain an invitation letter from the family member resident in Guinea\nGo to the official paf.gov.gn portal\nUpload passport, photo, and relationship proof\nPay the eVisa fee online\nReceive the eVisa by email',
    '/assets/images/visa-heroes/guinea.webp',
    'visamundi.co, evisaguides.com secondary sourcing', 'https://evisaguides.com/en/destination/guinea/', '2026-09-19'
);
SET @gin5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gin5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin5, 'Core Documents', 'Required from every applicant.', 1);
SET @gin5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gin5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @gin5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@gin5s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(22, 5, 80.00, 'USD', 'eVisa Fee', 'Sources disagree — reported variously as USD 80, USD 50, or USD 100. Confirm current fee on the official paf.gov.gn portal.', '2026-01-01', NOW(), 'https://evisaguides.com/en/destination/guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Guinea on the standard eVisa?', 'Yes — family visits use the same eVisa framework as tourism, with an invitation letter and relationship proof added.', 22, 5, 2205, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    22, 6, 'GIN-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Guinea en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard eVisa or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the eVisa portal or your airline whether the standard eVisa applies',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Guinea Official eVisa Portal (paf.gov.gn) — no in-person appearance required',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific eVisa is required\nGo to the official paf.gov.gn portal if needed\nUpload passport, photo, and onward ticket\nReceive the eVisa by email if applicable',
    '/assets/images/visa-heroes/guinea.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisaguides.com/en/destination/guinea/', '2026-09-19'
);
SET @gin6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gin6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin6, 'Core Documents', 'Required from every applicant.', 1);
SET @gin6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gin6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @gin6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(22, 6, NULL, 'USD', 'Confirm at Portal', 'Transit fee not independently confirmed this session; confirm on the official eVisa portal.', '2026-09-01', NOW(), 'https://evisaguides.com/en/destination/guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Guinea?', 'Not independently confirmed this session — confirm with the eVisa portal or your airline whether your specific transit routing requires the standard eVisa.', 22, 6, 2206, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    22, 7, 'GIN-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Guinea.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with medical documentation.',
    'Up to 90 days',
    'Apply online for the eVisa via the official paf.gov.gn portal',
    0,
    'Announced at 72 hours for a complete application; typically 3-4 business days',
    'Guinea Official eVisa Portal (paf.gov.gn) — no in-person appearance required',
    'Obtain a medical appointment/admission letter from the hospital\nGo to the official paf.gov.gn portal\nUpload passport, photo, and medical documents\nPay the eVisa fee online\nReceive the eVisa by email',
    '/assets/images/visa-heroes/guinea.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisaguides.com/en/destination/guinea/', '2026-09-19'
);
SET @gin7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gin7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin7, 'Core Documents', 'Required from every applicant.', 1);
SET @gin7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gin7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @gin7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@gin7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(22, 7, 80.00, 'USD', 'eVisa Fee', 'Sources disagree — reported variously as USD 80, USD 50, or USD 100. Confirm current fee on the official paf.gov.gn portal.', '2026-01-01', NOW(), 'https://evisaguides.com/en/destination/guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Guinea?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard eVisa with supporting medical documentation.', 22, 7, 2207, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    22, 8, 'GIN-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Guinea.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business eVisa framework with an event invitation.',
    'Up to 90 days',
    'Apply online for the eVisa via the official paf.gov.gn portal',
    0,
    'Announced at 72 hours for a complete application; typically 3-4 business days',
    'Guinea Official eVisa Portal (paf.gov.gn) — no in-person appearance required',
    'Obtain an official invitation letter from the event organiser\nGo to the official paf.gov.gn portal\nUpload passport, photo, and event documents\nPay the eVisa fee online\nReceive the eVisa by email',
    '/assets/images/visa-heroes/guinea.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisaguides.com/en/destination/guinea/', '2026-09-19'
);
SET @gin8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gin8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin8, 'Core Documents', 'Required from every applicant.', 1);
SET @gin8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gin8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @gin8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(22, 8, 80.00, 'USD', 'eVisa Fee', 'Sources disagree — reported variously as USD 80, USD 50, or USD 100. Confirm current fee on the official paf.gov.gn portal.', '2026-01-01', NOW(), 'https://evisaguides.com/en/destination/guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Guinea?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business eVisa framework with an official invitation letter.', 22, 8, 2208, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    22, 9, 'GIN-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Guinea.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with an event invitation.',
    'Up to 90 days',
    'Apply online for the eVisa via the official paf.gov.gn portal',
    0,
    'Announced at 72 hours for a complete application; typically 3-4 business days',
    'Guinea Official eVisa Portal (paf.gov.gn) — no in-person appearance required',
    'Obtain an official invitation from the sporting federation/event organiser\nGo to the official paf.gov.gn portal\nUpload passport, photo, and event documents\nPay the eVisa fee online\nReceive the eVisa by email',
    '/assets/images/visa-heroes/guinea.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisaguides.com/en/destination/guinea/', '2026-09-19'
);
SET @gin9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gin9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin9, 'Core Documents', 'Required from every applicant.', 1);
SET @gin9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gin9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @gin9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(22, 9, 80.00, 'USD', 'eVisa Fee', 'Sources disagree — reported variously as USD 80, USD 50, or USD 100. Confirm current fee on the official paf.gov.gn portal.', '2026-01-01', NOW(), 'https://evisaguides.com/en/destination/guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Guinea?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard eVisa with a federation/event invitation.', 22, 9, 2209, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    22, 10, 'GIN-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Guinean work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the nearest Guinea mission for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Guinea diplomatic mission (confirm current jurisdiction serving India)',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply via the relevant mission\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/guinea.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisaguides.com/en/destination/guinea/', '2026-09-19'
);
SET @gin10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gin10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin10, 'Core Documents', 'Required from every applicant.', 1);
SET @gin10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gin10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gin10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @gin10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gin10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@gin10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(22, 10, NULL, 'USD', 'Confirm at Mission', 'Dependent permit fee not independently confirmed this session; confirm with the relevant Guinea mission.', '2026-09-01', NOW(), 'https://evisaguides.com/en/destination/guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Guinea?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the relevant mission.', 22, 10, 2210, 1);
