-- Djibouti Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Djibouti's real, distinctive facts verified this session:
--   - Indian citizens apply for an eVisa entirely online — no embassy
--     visit required.
--   - Fee: INR 3,328 (~USD 35).
--   - Processing: 3 working days; apply at least 3 days before travel.
--   - Validity: up to 90 days.
--
-- country_id 13 = Djibouti. visa_type_id: 1=Tourist, 2=Business,
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
    13, 1, 'DJI-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Djibouti.',
    'Indian citizens require an eVisa before travel; apply entirely online with no in-person embassy visit needed.',
    'Up to 90 days',
    'Apply online for the eVisa via the official portal',
    0,
    '3 working days; apply at least 3 days before travel',
    'Djibouti eVisa Portal (online) — no in-person appearance required',
    'Complete the online eVisa application form\nUpload passport bio page and JPG/JPEG passport-size photo\nUpload proof of accommodation and return/onward flight details\nPay the eVisa fee online with a credit/debit card\nReceive the eVisa by email and carry it with your passport',
    '/assets/images/visa-heroes/djibouti.webp',
    'ixigo.com secondary sourcing (last verified May 2026)', 'https://www.ixigo.com/visa-for-indians/djibouti-dj', '2026-09-19'
);
SET @dji1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dji1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji1, 'Core Documents', 'Required from every applicant.', 1);
SET @dji1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dji1s1, 'Passport-Size Photograph (JPG/JPEG)', NULL, 'copy', 1, 0, 1, 2),
(@dji1s1, 'Completed Online eVisa Application', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @dji1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji1s2, 'Proof of Return/Onward Flight Booking', NULL, 'copy', 1, 0, 0, 1),
(@dji1s2, 'Proof of Hotel/Accommodation Booking', NULL, 'copy', 1, 0, 0, 2),
(@dji1s2, 'Bank Statement or Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(13, 1, 3328.00, 'INR', 'eVisa Fee', 'Approximately USD 35 equivalent.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/djibouti-dj', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Djibouti?', 'Yes — all Indian citizens require an eVisa, applied for entirely online with no embassy visit needed.', 13, 1, 1300, 1),
('How long does the Djibouti eVisa take to process?', 'Typically 3 working days — apply at least 3 days before your travel date.', 13, 1, 1301, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    13, 2, 'DJI-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Djibouti.',
    'Business travellers use the same eVisa framework as tourists, adding a business invitation letter.',
    'Up to 90 days',
    'Apply online for the eVisa via the official portal',
    0,
    '3 working days; apply at least 3 days before travel',
    'Djibouti eVisa Portal (online) — no in-person appearance required',
    'Obtain a business invitation letter\nComplete the online eVisa application form\nUpload passport, photo, and supporting documents\nPay the eVisa fee online\nReceive the eVisa by email',
    '/assets/images/visa-heroes/djibouti.webp',
    'ixigo.com secondary sourcing (last verified May 2026)', 'https://www.ixigo.com/visa-for-indians/djibouti-dj', '2026-09-19'
);
SET @dji2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dji2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji2, 'Core Documents', 'Required from every applicant.', 1);
SET @dji2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dji2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @dji2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@dji2s2, 'Proof of Return/Onward Flight Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(13, 2, 3328.00, 'INR', 'eVisa Fee', 'Approximately USD 35 equivalent.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/djibouti-dj', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use the same eVisa portal for business travel to Djibouti?', 'Yes — business travellers use the same eVisa framework as tourists, adding a business invitation letter to the application.', 13, 2, 1302, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    13, 3, 'DJI-STUD-IN-01', '2026.09', 'published',
    'Academic study in Djibouti.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires a long-stay visa beyond the standard 90-day eVisa.',
    'Tied to the academic program duration',
    'Confirm with the nearest Djibouti mission for the student-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Djibouti diplomatic mission (confirm current jurisdiction serving India)',
    'Secure admission confirmation from the Djiboutian institution\nCheck whether the standard eVisa or a separate student visa applies\nGather proof of financial support\nApply via the relevant mission or eVisa portal\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/djibouti.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/djibouti-dj', '2026-09-19'
);
SET @dji3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dji3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji3, 'Core Documents', 'Required from every applicant.', 1);
SET @dji3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dji3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @dji3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@dji3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(13, 3, NULL, 'INR', 'Confirm at Mission', 'Student visa fee not independently confirmed this session; confirm with the relevant Djibouti mission.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/djibouti-dj', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for Djibouti?', 'Not independently confirmed this session — longer academic programs likely require a long-stay visa beyond the standard 90-day eVisa. Confirm with the relevant mission.', 13, 3, 1303, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    13, 4, 'DJI-WORK-IN-01', '2026.09', 'published',
    'Employment with a Djiboutian company.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires an employer-sponsored work permit beyond the standard eVisa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the nearest Djibouti mission for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Djibouti diplomatic mission (confirm current jurisdiction serving India)',
    'Secure a signed employment contract from the Djiboutian employer\nCheck whether a separate work permit is required beyond the eVisa\nGather proof of qualifications\nApply via the relevant mission\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/djibouti.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/djibouti-dj', '2026-09-19'
);
SET @dji4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dji4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji4, 'Core Documents', 'Required from every applicant.', 1);
SET @dji4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dji4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @dji4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@dji4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(13, 4, NULL, 'INR', 'Confirm at Mission', 'Work permit fee not independently confirmed this session; confirm with the relevant Djibouti mission.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/djibouti-dj', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for Djibouti beyond the eVisa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit. Confirm with the relevant mission.', 13, 4, 1304, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    13, 5, 'DJI-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Djibouti.',
    'Family visits use the same eVisa framework as tourism, adding an invitation letter and relationship proof.',
    'Up to 90 days',
    'Apply online for the eVisa via the official portal',
    0,
    '3 working days; apply at least 3 days before travel',
    'Djibouti eVisa Portal (online) — no in-person appearance required',
    'Obtain an invitation letter from the family member resident in Djibouti\nComplete the online eVisa application form\nUpload passport, photo, and relationship proof\nPay the eVisa fee online\nReceive the eVisa by email',
    '/assets/images/visa-heroes/djibouti.webp',
    'ixigo.com secondary sourcing (last verified May 2026)', 'https://www.ixigo.com/visa-for-indians/djibouti-dj', '2026-09-19'
);
SET @dji5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dji5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji5, 'Core Documents', 'Required from every applicant.', 1);
SET @dji5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dji5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @dji5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@dji5s2, 'Proof of Return/Onward Flight Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(13, 5, 3328.00, 'INR', 'eVisa Fee', 'Approximately USD 35 equivalent.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/djibouti-dj', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Djibouti on the standard eVisa?', 'Yes — family visits use the same eVisa framework as tourism, with an invitation letter and relationship proof added.', 13, 5, 1305, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    13, 6, 'DJI-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Djibouti en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard eVisa or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the eVisa portal or your airline whether the standard eVisa applies',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Djibouti eVisa Portal (online) — no in-person appearance required',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific eVisa is required\nComplete the online application if needed\nUpload passport, photo, and onward ticket\nReceive the eVisa by email if applicable',
    '/assets/images/visa-heroes/djibouti.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/djibouti-dj', '2026-09-19'
);
SET @dji6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dji6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji6, 'Core Documents', 'Required from every applicant.', 1);
SET @dji6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dji6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @dji6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(13, 6, NULL, 'INR', 'Confirm at Portal', 'Transit fee not independently confirmed this session; confirm on the official eVisa portal.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/djibouti-dj', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Djibouti?', 'Not independently confirmed this session — confirm with the eVisa portal or your airline whether your specific transit routing requires the standard eVisa.', 13, 6, 1306, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    13, 7, 'DJI-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Djibouti.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with medical documentation.',
    'Up to 90 days',
    'Apply online for the eVisa via the official portal',
    0,
    '3 working days; apply at least 3 days before travel',
    'Djibouti eVisa Portal (online) — no in-person appearance required',
    'Obtain a medical appointment/admission letter from the hospital\nComplete the online eVisa application form\nUpload passport, photo, and medical documents\nPay the eVisa fee online\nReceive the eVisa by email',
    '/assets/images/visa-heroes/djibouti.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/djibouti-dj', '2026-09-19'
);
SET @dji7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dji7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji7, 'Core Documents', 'Required from every applicant.', 1);
SET @dji7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dji7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @dji7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@dji7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(13, 7, 3328.00, 'INR', 'eVisa Fee', 'Approximately USD 35 equivalent.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/djibouti-dj', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Djibouti?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard eVisa with supporting medical documentation.', 13, 7, 1307, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    13, 8, 'DJI-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Djibouti.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business eVisa framework with an event invitation.',
    'Up to 90 days',
    'Apply online for the eVisa via the official portal',
    0,
    '3 working days; apply at least 3 days before travel',
    'Djibouti eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation letter from the event organiser\nComplete the online eVisa application form\nUpload passport, photo, and event documents\nPay the eVisa fee online\nReceive the eVisa by email',
    '/assets/images/visa-heroes/djibouti.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/djibouti-dj', '2026-09-19'
);
SET @dji8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dji8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji8, 'Core Documents', 'Required from every applicant.', 1);
SET @dji8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dji8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @dji8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(13, 8, 3328.00, 'INR', 'eVisa Fee', 'Approximately USD 35 equivalent.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/djibouti-dj', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Djibouti?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business eVisa framework with an official invitation letter.', 13, 8, 1308, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    13, 9, 'DJI-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Djibouti.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with an event invitation.',
    'Up to 90 days',
    'Apply online for the eVisa via the official portal',
    0,
    '3 working days; apply at least 3 days before travel',
    'Djibouti eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation from the sporting federation/event organiser\nComplete the online eVisa application form\nUpload passport, photo, and event documents\nPay the eVisa fee online\nReceive the eVisa by email',
    '/assets/images/visa-heroes/djibouti.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/djibouti-dj', '2026-09-19'
);
SET @dji9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dji9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji9, 'Core Documents', 'Required from every applicant.', 1);
SET @dji9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dji9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @dji9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(13, 9, 3328.00, 'INR', 'eVisa Fee', 'Approximately USD 35 equivalent.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/djibouti-dj', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Djibouti?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard eVisa with a federation/event invitation.', 13, 9, 1309, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    13, 10, 'DJI-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Djiboutian work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the nearest Djibouti mission for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Djibouti diplomatic mission (confirm current jurisdiction serving India)',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply via the relevant mission\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/djibouti.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/djibouti-dj', '2026-09-19'
);
SET @dji10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dji10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji10, 'Core Documents', 'Required from every applicant.', 1);
SET @dji10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dji10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dji10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @dji10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dji10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@dji10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(13, 10, NULL, 'INR', 'Confirm at Mission', 'Dependent permit fee not independently confirmed this session; confirm with the relevant Djibouti mission.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/djibouti-dj', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Djibouti?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the relevant mission.', 13, 10, 1310, 1);
