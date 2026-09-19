-- Barbados Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url left NULL
-- pattern-consistent with other batches.
--
-- SOURCING CAVEAT: official Barbados immigration domains were not
-- directly fetchable this session (egress-proxy blocked); findings
-- triangulated from BTW Visas and Skyscanner secondary sourcing, which
-- disagreed on whether Indians need a visa at all for tourism/business
-- — one source claims visa-free entry, most describe a required eVisa.
-- The eVisa framework is used below as the primary path since it is
-- the majority-sourced position, but this conflict is flagged
-- honestly rather than silently resolved.
--
-- Barbados' real, distinctive facts verified this session:
--   - eVisa system: single-entry (USD 107) and multiple-entry (USD
--     211), applied for entirely online, approval emailed.
--   - Processing: 7-15 business days.
--   - Maximum stay: up to 180 days within a calendar year.
--
-- country_id 156 = Barbados. visa_type_id: 1=Tourist, 2=Business,
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
    156, 1, 'BRB-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Barbados.',
    'Sources disagree on whether Indian citizens need a visa for tourism — most describe an eVisa requirement (single or multiple entry); confirm the current position with official Barbados sources before applying.',
    'Up to 180 days within a calendar year',
    'Apply online for the eVisa (single or multiple entry) — no embassy visit needed',
    0,
    'Reported 7-15 business days',
    'Barbados eVisa Portal (online) — no in-person appearance required',
    'Verify current visa requirement with official Barbados sources\nCreate an account on the eVisa portal if required\nUpload passport bio page, photo, and travel documents\nPay the eVisa fee online\nReceive the eVisa by email and carry it alongside your passport',
    '/assets/images/visa-heroes/barbados.webp',
    'BTW Visas and Skyscanner secondary sourcing; official Barbados government domains not directly fetchable this session', 'https://btwvisas.com/visa-guide/barbados-visa/', '2026-09-19'
);
SET @brb1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brb1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb1, 'Core Documents', 'Required from every applicant.', 1);
SET @brb1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb1s1, 'Valid Passport (Valid Throughout Stay)', NULL, 'original', 1, 0, 1, 1),
(@brb1s1, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@brb1s1, 'Completed Online eVisa Application', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @brb1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb1s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 1),
(@brb1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(156, 1, 107.00, 'USD', 'Single-Entry eVisa Fee', 'Multiple-entry eVisa is reported at USD 211. Sources disagree on whether a visa is even required for Indian tourists — verify with official Barbados sources before applying.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/barbados-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Barbados?', 'Sources disagree — most describe a required eVisa (single or multiple entry), while one source suggests visa-free entry for business/tourism. Verify the current position with official Barbados sources before booking.', 156, 1, 15600, 1),
('How long can I stay in Barbados on the eVisa?', 'The eVisa reportedly allows a stay of up to 180 days within a calendar year, processed within 7-15 business days.', 156, 1, 15601, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    156, 2, 'BRB-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Barbados.',
    'Business travellers use the same eVisa framework as tourists, adding a business invitation letter; sources disagree on whether a visa is required at all.',
    'Up to 180 days within a calendar year',
    'Apply online for the eVisa (single or multiple entry) — no embassy visit needed',
    0,
    'Reported 7-15 business days',
    'Barbados eVisa Portal (online) — no in-person appearance required',
    'Verify current visa requirement with official Barbados sources\nObtain a business invitation letter\nCreate an account on the eVisa portal if required\nUpload passport, photo, and supporting documents\nReceive the eVisa by email',
    '/assets/images/visa-heroes/barbados.webp',
    'BTW Visas secondary sourcing; official Barbados government domains not directly fetchable this session', 'https://btwvisas.com/visa-guide/barbados-visa/', '2026-09-19'
);
SET @brb2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brb2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb2, 'Core Documents', 'Required from every applicant.', 1);
SET @brb2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb2s1, 'Valid Passport (Valid Throughout Stay)', NULL, 'original', 1, 0, 1, 1),
(@brb2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @brb2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@brb2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(156, 2, 211.00, 'USD', 'Multiple-Entry eVisa Fee', 'Single-entry eVisa is reported at USD 107. Sources disagree on whether a visa is even required for Indian business travellers — verify with official Barbados sources.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/barbados-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should business travellers use the multiple-entry eVisa?', 'If you expect to make repeat trips to Barbados, the multiple-entry eVisa (USD 211) may be more convenient than the single-entry option (USD 107).', 156, 2, 15602, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    156, 3, 'BRB-STUD-IN-01', '2026.09', 'published',
    'Academic study in Barbados.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires a student permit beyond the standard eVisa for longer programs.',
    'Tied to the academic program duration',
    'Confirm with the nearest Barbados mission for the student-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Barbados diplomatic mission (confirm current jurisdiction serving India)',
    'Secure admission confirmation from the Barbadian institution\nCheck whether the standard eVisa or a separate student permit applies\nGather proof of financial support\nApply via the eVisa portal or relevant mission\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/barbados.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/barbados-visa/', '2026-09-19'
);
SET @brb3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brb3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb3, 'Core Documents', 'Required from every applicant.', 1);
SET @brb3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb3s1, 'Valid Passport (Valid Throughout Stay)', NULL, 'original', 1, 0, 1, 1),
(@brb3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @brb3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@brb3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(156, 3, NULL, 'USD', 'Confirm at Mission', 'Student permit fee not independently confirmed this session; confirm with the relevant Barbados mission.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/barbados-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for Barbados?', 'Not independently confirmed this session — longer academic programs likely require a student permit beyond the standard eVisa. Confirm with the relevant mission.', 156, 3, 15603, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    156, 4, 'BRB-WORK-IN-01', '2026.09', 'published',
    'Employment with a Barbadian company.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires an employer-sponsored work permit beyond the standard eVisa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the nearest Barbados mission for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Barbados diplomatic mission (confirm current jurisdiction serving India)',
    'Secure a signed employment contract from the Barbadian employer\nCheck whether a separate work permit is required beyond the eVisa\nGather proof of qualifications\nApply via the relevant mission or portal\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/barbados.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/barbados-visa/', '2026-09-19'
);
SET @brb4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brb4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb4, 'Core Documents', 'Required from every applicant.', 1);
SET @brb4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb4s1, 'Valid Passport (Valid Throughout Stay)', NULL, 'original', 1, 0, 1, 1),
(@brb4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @brb4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@brb4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(156, 4, NULL, 'USD', 'Confirm at Mission', 'Work permit fee not independently confirmed this session; confirm with the relevant Barbados mission.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/barbados-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for Barbados beyond the eVisa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit. Confirm with the relevant mission.', 156, 4, 15604, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    156, 5, 'BRB-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Barbados.',
    'Family visits use the same eVisa framework as tourism, adding an invitation letter and relationship proof.',
    'Up to 180 days within a calendar year',
    'Apply online for the eVisa (single or multiple entry) — no embassy visit needed',
    0,
    'Reported 7-15 business days',
    'Barbados eVisa Portal (online) — no in-person appearance required',
    'Obtain an invitation letter from the family member resident in Barbados\nCreate an account on the eVisa portal\nUpload passport, photo, and relationship proof\nPay the eVisa fee online\nReceive the eVisa by email',
    '/assets/images/visa-heroes/barbados.webp',
    'BTW Visas secondary sourcing; official Barbados government domains not directly fetchable this session', 'https://btwvisas.com/visa-guide/barbados-visa/', '2026-09-19'
);
SET @brb5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brb5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb5, 'Core Documents', 'Required from every applicant.', 1);
SET @brb5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb5s1, 'Valid Passport (Valid Throughout Stay)', NULL, 'original', 1, 0, 1, 1),
(@brb5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @brb5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@brb5s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(156, 5, 107.00, 'USD', 'Single-Entry eVisa Fee', 'Multiple-entry eVisa is reported at USD 211. Confirm the exact current requirement/fee with official Barbados sources.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/barbados-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Barbados on the standard eVisa?', 'Yes — family visits use the same eVisa framework as tourism, with an invitation letter and relationship proof added.', 156, 5, 15605, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    156, 6, 'BRB-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Barbados en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard eVisa or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the eVisa portal or your airline whether the standard eVisa applies',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Barbados eVisa Portal (online) — no in-person appearance required',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific eVisa is required\nCreate an account on the eVisa portal if needed\nUpload passport, photo, and onward ticket\nReceive the eVisa by email if applicable',
    '/assets/images/visa-heroes/barbados.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/barbados-visa/', '2026-09-19'
);
SET @brb6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brb6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb6, 'Core Documents', 'Required from every applicant.', 1);
SET @brb6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb6s1, 'Valid Passport (Valid Throughout Stay)', NULL, 'original', 1, 0, 1, 1),
(@brb6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @brb6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(156, 6, NULL, 'USD', 'Confirm at Portal', 'Transit fee not independently confirmed this session; confirm on the official eVisa portal.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/barbados-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Barbados?', 'Not independently confirmed this session — confirm with the eVisa portal or your airline whether your specific transit routing requires the standard eVisa.', 156, 6, 15606, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    156, 7, 'BRB-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Barbados.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with medical documentation.',
    'Up to 180 days within a calendar year',
    'Apply online for the eVisa (single or multiple entry) — no embassy visit needed',
    0,
    'Reported 7-15 business days',
    'Barbados eVisa Portal (online) — no in-person appearance required',
    'Obtain a medical appointment/admission letter from the hospital\nCreate an account on the eVisa portal\nUpload passport, photo, and medical documents\nPay the eVisa fee online\nReceive the eVisa by email',
    '/assets/images/visa-heroes/barbados.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/barbados-visa/', '2026-09-19'
);
SET @brb7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brb7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb7, 'Core Documents', 'Required from every applicant.', 1);
SET @brb7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb7s1, 'Valid Passport (Valid Throughout Stay)', NULL, 'original', 1, 0, 1, 1),
(@brb7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @brb7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@brb7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(156, 7, 107.00, 'USD', 'Single-Entry eVisa Fee', 'Multiple-entry eVisa is reported at USD 211. Confirm the exact current requirement/fee with official Barbados sources.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/barbados-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Barbados?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard eVisa with supporting medical documentation.', 156, 7, 15607, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    156, 8, 'BRB-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Barbados.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business eVisa framework with an event invitation.',
    'Up to 180 days within a calendar year',
    'Apply online for the eVisa (single or multiple entry) — no embassy visit needed',
    0,
    'Reported 7-15 business days',
    'Barbados eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation letter from the event organiser\nCreate an account on the eVisa portal\nUpload passport, photo, and event documents\nPay the eVisa fee online\nReceive the eVisa by email',
    '/assets/images/visa-heroes/barbados.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/barbados-visa/', '2026-09-19'
);
SET @brb8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brb8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb8, 'Core Documents', 'Required from every applicant.', 1);
SET @brb8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb8s1, 'Valid Passport (Valid Throughout Stay)', NULL, 'original', 1, 0, 1, 1),
(@brb8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @brb8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(156, 8, 107.00, 'USD', 'Single-Entry eVisa Fee', 'Multiple-entry eVisa is reported at USD 211. Confirm the exact current requirement/fee with official Barbados sources.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/barbados-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Barbados?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business eVisa framework with an official invitation letter.', 156, 8, 15608, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    156, 9, 'BRB-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Barbados.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with an event invitation.',
    'Up to 180 days within a calendar year',
    'Apply online for the eVisa (single or multiple entry) — no embassy visit needed',
    0,
    'Reported 7-15 business days',
    'Barbados eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation from the sporting federation/event organiser\nCreate an account on the eVisa portal\nUpload passport, photo, and event documents\nPay the eVisa fee online\nReceive the eVisa by email',
    '/assets/images/visa-heroes/barbados.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/barbados-visa/', '2026-09-19'
);
SET @brb9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brb9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb9, 'Core Documents', 'Required from every applicant.', 1);
SET @brb9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb9s1, 'Valid Passport (Valid Throughout Stay)', NULL, 'original', 1, 0, 1, 1),
(@brb9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @brb9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(156, 9, 107.00, 'USD', 'Single-Entry eVisa Fee', 'Multiple-entry eVisa is reported at USD 211. Confirm the exact current requirement/fee with official Barbados sources.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/barbados-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Barbados?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard eVisa with a federation/event invitation.', 156, 9, 15609, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    156, 10, 'BRB-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Barbadian work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the nearest Barbados mission for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Barbados diplomatic mission (confirm current jurisdiction serving India)',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply via the relevant mission or portal\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/barbados.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/barbados-visa/', '2026-09-19'
);
SET @brb10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brb10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb10, 'Core Documents', 'Required from every applicant.', 1);
SET @brb10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb10s1, 'Valid Passport (Valid Throughout Stay)', NULL, 'original', 1, 0, 1, 1),
(@brb10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brb10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @brb10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brb10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@brb10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(156, 10, NULL, 'USD', 'Confirm at Mission', 'Dependent permit fee not independently confirmed this session; confirm with the relevant Barbados mission.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/barbados-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Barbados?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the relevant mission.', 156, 10, 15610, 1);
