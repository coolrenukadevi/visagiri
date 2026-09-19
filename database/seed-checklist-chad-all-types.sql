-- Chad Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Chad's real, distinctive facts verified this session:
--   - Indian citizens are NOT eligible for visa-on-arrival — a sticker
--     eVisa (issued via the official Chad eVisa website) must be
--     approved before boarding any flight to N'Djamena.
--   - Fee: INR 25,000 non-refundable (government processing fee,
--     inclusive of all government fees) — notably high, and a
--     rejection does not result in a refund.
--   - Processing: 3-10 working days (Chad/India public holidays don't
--     count toward this window).
--   - Validity: single-entry eVisa is 30 days validity/30 days max
--     stay; multiple-entry is 90 days validity/30 days max stay per
--     visit.
--
-- country_id 10 = Chad. visa_type_id: 1=Tourist, 2=Business,
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
    10, 1, 'TCD-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Chad.',
    'Indian citizens are not eligible for visa-on-arrival — an approved eVisa is mandatory before boarding any flight to N''Djamena.',
    'Up to 30 days per visit',
    'Apply online for the sticker eVisa via the official Chad eVisa website',
    0,
    '3-10 working days (Chad/India public holidays excluded)',
    'Chad Official eVisa Portal (online) — no in-person appearance required',
    'Go to the official Chad eVisa website\nComplete the online application form\nUpload passport bio page and photo\nPay the non-refundable INR 25,000 government processing fee\nReceive the approved eVisa before booking your flight to N''Djamena',
    '/assets/images/visa-heroes/chad.webp',
    'travelsagaholidays.in and evisapass.org secondary sourcing', 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', '2026-09-19'
);
SET @tcd1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tcd1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd1, 'Core Documents', 'Required from every applicant.', 1);
SET @tcd1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tcd1s1, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@tcd1s1, 'Completed Online eVisa Application', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @tcd1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd1s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 1),
(@tcd1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(10, 1, 25000.00, 'INR', 'eVisa Government Processing Fee', 'Non-refundable, including a rejected application — this figure covers all government fees for the sticker eVisa.', '2026-01-01', NOW(), 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens get a Chad visa on arrival?', 'No — Indian citizens are not eligible for visa-on-arrival in Chad. An approved eVisa is mandatory before boarding any flight to N''Djamena.', 10, 1, 1000, 1),
('Is the Chad visa fee refundable if my application is rejected?', 'No — the INR 25,000 government processing fee is non-refundable even if the application is rejected.', 10, 1, 1001, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    10, 2, 'TCD-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Chad.',
    'Business travellers use the same mandatory eVisa framework as tourists, adding a business invitation letter.',
    'Up to 30 days per visit',
    'Apply online for the sticker eVisa via the official Chad eVisa website',
    0,
    '3-10 working days (Chad/India public holidays excluded)',
    'Chad Official eVisa Portal (online) — no in-person appearance required',
    'Obtain a business invitation letter\nGo to the official Chad eVisa website\nUpload passport, photo, and supporting documents\nPay the non-refundable INR 25,000 government processing fee\nReceive the approved eVisa before travel',
    '/assets/images/visa-heroes/chad.webp',
    'travelsagaholidays.in and evisapass.org secondary sourcing', 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', '2026-09-19'
);
SET @tcd2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tcd2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd2, 'Core Documents', 'Required from every applicant.', 1);
SET @tcd2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tcd2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @tcd2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@tcd2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(10, 2, 25000.00, 'INR', 'eVisa Government Processing Fee', 'Non-refundable, including a rejected application. Multiple-entry (90-day validity/30-day stay per visit) may cost more — confirm the current tiered fee with the official portal.', '2026-01-01', NOW(), 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should frequent business travellers apply for a multiple-entry eVisa?', 'If you expect repeat trips to Chad, the multiple-entry eVisa (90-day validity, 30-day stay per visit) may suit you better than single-entry — confirm the current fee tier with the official portal.', 10, 2, 1002, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    10, 3, 'TCD-STUD-IN-01', '2026.09', 'published',
    'Academic study in Chad.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires a long-stay visa beyond the standard 30-day eVisa.',
    'Tied to the academic program duration',
    'Confirm with the nearest Chad mission for the student-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Chad diplomatic mission (confirm current jurisdiction serving India)',
    'Secure admission confirmation from the Chadian institution\nCheck whether the standard eVisa or a separate student visa applies\nGather proof of financial support\nApply via the relevant mission or eVisa portal\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/chad.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', '2026-09-19'
);
SET @tcd3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tcd3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd3, 'Core Documents', 'Required from every applicant.', 1);
SET @tcd3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tcd3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @tcd3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@tcd3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(10, 3, NULL, 'INR', 'Confirm at Mission', 'Student visa fee not independently confirmed this session; confirm with the relevant Chad mission.', '2026-09-01', NOW(), 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for Chad?', 'Not independently confirmed this session — longer academic programs likely require a long-stay visa beyond the standard 30-day eVisa. Confirm with the relevant mission.', 10, 3, 1003, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    10, 4, 'TCD-WORK-IN-01', '2026.09', 'published',
    'Employment with a Chadian company.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires an employer-sponsored work permit beyond the standard eVisa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the nearest Chad mission for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Chad diplomatic mission (confirm current jurisdiction serving India)',
    'Secure a signed employment contract from the Chadian employer\nCheck whether a separate work permit is required beyond the eVisa\nGather proof of qualifications\nApply via the relevant mission\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/chad.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', '2026-09-19'
);
SET @tcd4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tcd4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd4, 'Core Documents', 'Required from every applicant.', 1);
SET @tcd4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tcd4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @tcd4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@tcd4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(10, 4, NULL, 'INR', 'Confirm at Mission', 'Work permit fee not independently confirmed this session; confirm with the relevant Chad mission.', '2026-09-01', NOW(), 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for Chad beyond the eVisa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit. Confirm with the relevant mission.', 10, 4, 1004, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    10, 5, 'TCD-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Chad.',
    'Family visits use the same mandatory eVisa framework as tourism, adding an invitation letter and relationship proof.',
    'Up to 30 days per visit',
    'Apply online for the sticker eVisa via the official Chad eVisa website',
    0,
    '3-10 working days (Chad/India public holidays excluded)',
    'Chad Official eVisa Portal (online) — no in-person appearance required',
    'Obtain an invitation letter from the family member resident in Chad\nGo to the official Chad eVisa website\nUpload passport, photo, and relationship proof\nPay the non-refundable INR 25,000 government processing fee\nReceive the approved eVisa before travel',
    '/assets/images/visa-heroes/chad.webp',
    'travelsagaholidays.in and evisapass.org secondary sourcing', 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', '2026-09-19'
);
SET @tcd5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tcd5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd5, 'Core Documents', 'Required from every applicant.', 1);
SET @tcd5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tcd5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @tcd5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@tcd5s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(10, 5, 25000.00, 'INR', 'eVisa Government Processing Fee', 'Non-refundable, including a rejected application.', '2026-01-01', NOW(), 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Chad on the standard eVisa?', 'Yes — family visits use the same mandatory eVisa framework as tourism, with an invitation letter and relationship proof added.', 10, 5, 1005, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    10, 6, 'TCD-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Chad en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard eVisa or a separate provision — confirm with the airline before travel, especially given Indians are not eligible for visa-on-arrival.',
    'Short duration tied to the transit itinerary',
    'Confirm with the eVisa portal or your airline whether the standard eVisa applies',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Chad Official eVisa Portal (online) — no in-person appearance required',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific eVisa is required\nGo to the official Chad eVisa website if needed\nUpload passport, photo, and onward ticket\nReceive the approved eVisa before travel if applicable',
    '/assets/images/visa-heroes/chad.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', '2026-09-19'
);
SET @tcd6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tcd6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd6, 'Core Documents', 'Required from every applicant.', 1);
SET @tcd6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tcd6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @tcd6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(10, 6, NULL, 'INR', 'Confirm at Portal', 'Transit fee not independently confirmed this session; confirm on the official eVisa portal.', '2026-09-01', NOW(), 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Chad?', 'Not independently confirmed this session — confirm with the eVisa portal or your airline whether your specific transit routing requires the standard eVisa, especially since visa-on-arrival is not available to Indian citizens.', 10, 6, 1006, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    10, 7, 'TCD-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Chad.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with medical documentation.',
    'Up to 30 days per visit',
    'Apply online for the sticker eVisa via the official Chad eVisa website',
    0,
    '3-10 working days (Chad/India public holidays excluded)',
    'Chad Official eVisa Portal (online) — no in-person appearance required',
    'Obtain a medical appointment/admission letter from the hospital\nGo to the official Chad eVisa website\nUpload passport, photo, and medical documents\nPay the non-refundable INR 25,000 government processing fee\nReceive the approved eVisa before travel',
    '/assets/images/visa-heroes/chad.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', '2026-09-19'
);
SET @tcd7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tcd7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd7, 'Core Documents', 'Required from every applicant.', 1);
SET @tcd7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tcd7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @tcd7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@tcd7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(10, 7, 25000.00, 'INR', 'eVisa Government Processing Fee', 'Non-refundable, including a rejected application.', '2026-01-01', NOW(), 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Chad?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard eVisa with supporting medical documentation.', 10, 7, 1007, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    10, 8, 'TCD-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Chad.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business eVisa framework with an event invitation.',
    'Up to 30 days per visit',
    'Apply online for the sticker eVisa via the official Chad eVisa website',
    0,
    '3-10 working days (Chad/India public holidays excluded)',
    'Chad Official eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation letter from the event organiser\nGo to the official Chad eVisa website\nUpload passport, photo, and event documents\nPay the non-refundable INR 25,000 government processing fee\nReceive the approved eVisa before travel',
    '/assets/images/visa-heroes/chad.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', '2026-09-19'
);
SET @tcd8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tcd8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd8, 'Core Documents', 'Required from every applicant.', 1);
SET @tcd8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tcd8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @tcd8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(10, 8, 25000.00, 'INR', 'eVisa Government Processing Fee', 'Non-refundable, including a rejected application.', '2026-01-01', NOW(), 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Chad?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business eVisa framework with an official invitation letter.', 10, 8, 1008, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    10, 9, 'TCD-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Chad.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with an event invitation.',
    'Up to 30 days per visit',
    'Apply online for the sticker eVisa via the official Chad eVisa website',
    0,
    '3-10 working days (Chad/India public holidays excluded)',
    'Chad Official eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation from the sporting federation/event organiser\nGo to the official Chad eVisa website\nUpload passport, photo, and event documents\nPay the non-refundable INR 25,000 government processing fee\nReceive the approved eVisa before travel',
    '/assets/images/visa-heroes/chad.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', '2026-09-19'
);
SET @tcd9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tcd9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd9, 'Core Documents', 'Required from every applicant.', 1);
SET @tcd9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tcd9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @tcd9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(10, 9, 25000.00, 'INR', 'eVisa Government Processing Fee', 'Non-refundable, including a rejected application.', '2026-01-01', NOW(), 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Chad?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard eVisa with a federation/event invitation.', 10, 9, 1009, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    10, 10, 'TCD-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Chadian work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the nearest Chad mission for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Chad diplomatic mission (confirm current jurisdiction serving India)',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply via the relevant mission\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/chad.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', '2026-09-19'
);
SET @tcd10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tcd10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd10, 'Core Documents', 'Required from every applicant.', 1);
SET @tcd10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tcd10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tcd10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @tcd10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tcd10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@tcd10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(10, 10, NULL, 'INR', 'Confirm at Mission', 'Dependent permit fee not independently confirmed this session; confirm with the relevant Chad mission.', '2026-09-01', NOW(), 'https://travelsagaholidays.in/blog/chad-visa-requirements-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Chad?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the relevant mission.', 10, 10, 1010, 1);
