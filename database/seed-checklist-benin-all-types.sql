-- Benin Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Benin's real, distinctive facts verified this session:
--   - All Indian citizens require an eVisa before travel — no
--     visa-free or visa-on-arrival route confirmed for tourism/business.
--   - eVisa tiers: EUR 50 (30-day single-entry), EUR 75 (30-day
--     multiple-entry), EUR 100 (90-day multiple-entry).
--   - Processing: typically 24-48 business hours, up to 5 business
--     days in peak periods; apply at least 7 days before travel.
--   - Wholly online application — no embassy visit required for the
--     eVisa route.
--
-- country_id 3 = Benin. visa_type_id: 1=Tourist, 2=Business,
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
    3, 1, 'BEN-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Benin.',
    'Indian citizens require an eVisa before travel; apply entirely online with no in-person embassy visit needed.',
    'Up to 30 days (single or multiple-entry) or 90 days (multiple-entry tier)',
    'Apply online for the eVisa via the official portal',
    0,
    'Typically 24-48 business hours; allow up to 5 business days in peak periods',
    'Benin eVisa Portal (online) — no in-person appearance required',
    'Complete the online eVisa application form\nUpload passport bio page and photo\nUpload proof of accommodation and return ticket\nPay the eVisa fee online\nReceive the eVisa approval by email and carry it with your passport',
    '/assets/images/visa-heroes/benin.webp',
    'Official Benin eVisa portal and evisaguides.com secondary sourcing', 'https://evisabenin.com/', '2026-09-19'
);
SET @ben1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ben1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben1, 'Core Documents', 'Required from every applicant.', 1);
SET @ben1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ben1s1, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@ben1s1, 'Completed Online eVisa Application', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @ben1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben1s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 1),
(@ben1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(3, 1, 50.00, 'EUR', '30-Day Single-Entry eVisa Fee', 'Multiple-entry 30-day tier is EUR 75; 90-day multiple-entry tier is EUR 100.', '2026-01-01', NOW(), 'https://evisabenin.com/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Benin?', 'Yes — all Indian citizens require an eVisa before travel, applied for entirely online with no embassy visit needed.', 3, 1, 300, 1),
('How long does the Benin eVisa take to process?', 'Typically 24-48 business hours, though peak periods may take up to 5 business days. Apply at least 7 days before your travel date.', 3, 1, 301, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    3, 2, 'BEN-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Benin.',
    'Business travellers use the same eVisa framework as tourists, adding a business invitation letter.',
    'Up to 30 days (single or multiple-entry) or 90 days (multiple-entry tier)',
    'Apply online for the eVisa via the official portal',
    0,
    'Typically 24-48 business hours; allow up to 5 business days in peak periods',
    'Benin eVisa Portal (online) — no in-person appearance required',
    'Obtain a business invitation letter\nComplete the online eVisa application form\nUpload passport, photo, and supporting documents\nPay the eVisa fee online\nReceive the eVisa approval by email',
    '/assets/images/visa-heroes/benin.webp',
    'Official Benin eVisa portal and evisaguides.com secondary sourcing', 'https://evisabenin.com/', '2026-09-19'
);
SET @ben2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ben2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben2, 'Core Documents', 'Required from every applicant.', 1);
SET @ben2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ben2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @ben2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@ben2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(3, 2, 75.00, 'EUR', '30-Day Multiple-Entry eVisa Fee', 'Single-entry 30-day tier is EUR 50; 90-day multiple-entry tier is EUR 100.', '2026-01-01', NOW(), 'https://evisabenin.com/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should business travellers use the multiple-entry eVisa?', 'If you expect repeat trips to Benin, the 30-day (EUR 75) or 90-day (EUR 100) multiple-entry tiers may be more convenient than the single-entry option (EUR 50).', 3, 2, 302, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    3, 3, 'BEN-STUD-IN-01', '2026.09', 'published',
    'Academic study in Benin.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires a long-stay student visa beyond the standard eVisa.',
    'Tied to the academic program duration',
    'Confirm with the nearest Benin mission for the student-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Benin diplomatic mission (confirm current jurisdiction serving India)',
    'Secure admission confirmation from the Beninese institution\nCheck whether the standard eVisa or a separate student visa applies\nGather proof of financial support\nApply via the relevant mission\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/benin.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisabenin.com/', '2026-09-19'
);
SET @ben3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ben3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben3, 'Core Documents', 'Required from every applicant.', 1);
SET @ben3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ben3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @ben3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@ben3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(3, 3, NULL, 'EUR', 'Confirm at Mission', 'Student visa fee not independently confirmed this session; confirm with the relevant Benin mission.', '2026-09-01', NOW(), 'https://evisabenin.com/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for Benin?', 'Not independently confirmed this session — longer academic programs likely require a long-stay student visa beyond the standard eVisa. Confirm with the relevant mission.', 3, 3, 303, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    3, 4, 'BEN-WORK-IN-01', '2026.09', 'published',
    'Employment with a Beninese company.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires an employer-sponsored work permit beyond the standard eVisa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the nearest Benin mission for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Benin diplomatic mission (confirm current jurisdiction serving India)',
    'Secure a signed employment contract from the Beninese employer\nCheck whether a separate work permit is required beyond the eVisa\nGather proof of qualifications\nApply via the relevant mission\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/benin.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisabenin.com/', '2026-09-19'
);
SET @ben4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ben4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben4, 'Core Documents', 'Required from every applicant.', 1);
SET @ben4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ben4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @ben4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@ben4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(3, 4, NULL, 'EUR', 'Confirm at Mission', 'Work permit fee not independently confirmed this session; confirm with the relevant Benin mission.', '2026-09-01', NOW(), 'https://evisabenin.com/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for Benin beyond the eVisa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit. Confirm with the relevant mission.', 3, 4, 304, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    3, 5, 'BEN-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Benin.',
    'Family visits use the same eVisa framework as tourism, adding an invitation letter and relationship proof.',
    'Up to 30 days (single or multiple-entry) or 90 days (multiple-entry tier)',
    'Apply online for the eVisa via the official portal',
    0,
    'Typically 24-48 business hours; allow up to 5 business days in peak periods',
    'Benin eVisa Portal (online) — no in-person appearance required',
    'Obtain an invitation letter from the family member resident in Benin\nComplete the online eVisa application form\nUpload passport, photo, and relationship proof\nPay the eVisa fee online\nReceive the eVisa approval by email',
    '/assets/images/visa-heroes/benin.webp',
    'Official Benin eVisa portal and evisaguides.com secondary sourcing', 'https://evisabenin.com/', '2026-09-19'
);
SET @ben5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ben5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben5, 'Core Documents', 'Required from every applicant.', 1);
SET @ben5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ben5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @ben5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@ben5s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(3, 5, 50.00, 'EUR', '30-Day Single-Entry eVisa Fee', 'Multiple-entry 30-day tier is EUR 75; 90-day multiple-entry tier is EUR 100.', '2026-01-01', NOW(), 'https://evisabenin.com/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Benin on the standard eVisa?', 'Yes — family visits use the same eVisa framework as tourism, with an invitation letter and relationship proof added.', 3, 5, 305, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    3, 6, 'BEN-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Benin en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard eVisa or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the eVisa portal or your airline whether the standard eVisa applies',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Benin eVisa Portal (online) — no in-person appearance required',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific eVisa is required\nComplete the online application if needed\nUpload passport, photo, and onward ticket\nReceive the eVisa approval by email if applicable',
    '/assets/images/visa-heroes/benin.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisabenin.com/', '2026-09-19'
);
SET @ben6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ben6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben6, 'Core Documents', 'Required from every applicant.', 1);
SET @ben6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ben6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @ben6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(3, 6, NULL, 'EUR', 'Confirm at Portal', 'Transit fee not independently confirmed this session; confirm on the official eVisa portal.', '2026-09-01', NOW(), 'https://evisabenin.com/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Benin?', 'Not independently confirmed this session — confirm with the eVisa portal or your airline whether your specific transit routing requires the standard eVisa.', 3, 6, 306, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    3, 7, 'BEN-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Benin.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with medical documentation.',
    'Up to 30 days (single or multiple-entry) or 90 days (multiple-entry tier)',
    'Apply online for the eVisa via the official portal',
    0,
    'Typically 24-48 business hours; allow up to 5 business days in peak periods',
    'Benin eVisa Portal (online) — no in-person appearance required',
    'Obtain a medical appointment/admission letter from the hospital\nComplete the online eVisa application form\nUpload passport, photo, and medical documents\nPay the eVisa fee online\nReceive the eVisa approval by email',
    '/assets/images/visa-heroes/benin.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisabenin.com/', '2026-09-19'
);
SET @ben7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ben7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben7, 'Core Documents', 'Required from every applicant.', 1);
SET @ben7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ben7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @ben7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@ben7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(3, 7, 50.00, 'EUR', '30-Day Single-Entry eVisa Fee', 'Multiple-entry 30-day tier is EUR 75; 90-day multiple-entry tier is EUR 100.', '2026-01-01', NOW(), 'https://evisabenin.com/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Benin?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard eVisa with supporting medical documentation.', 3, 7, 307, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    3, 8, 'BEN-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Benin.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business eVisa framework with an event invitation.',
    'Up to 30 days (single or multiple-entry) or 90 days (multiple-entry tier)',
    'Apply online for the eVisa via the official portal',
    0,
    'Typically 24-48 business hours; allow up to 5 business days in peak periods',
    'Benin eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation letter from the event organiser\nComplete the online eVisa application form\nUpload passport, photo, and event documents\nPay the eVisa fee online\nReceive the eVisa approval by email',
    '/assets/images/visa-heroes/benin.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisabenin.com/', '2026-09-19'
);
SET @ben8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ben8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben8, 'Core Documents', 'Required from every applicant.', 1);
SET @ben8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ben8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @ben8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(3, 8, 75.00, 'EUR', '30-Day Multiple-Entry eVisa Fee', 'Single-entry 30-day tier is EUR 50; 90-day multiple-entry tier is EUR 100.', '2026-01-01', NOW(), 'https://evisabenin.com/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Benin?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business eVisa framework with an official invitation letter.', 3, 8, 308, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    3, 9, 'BEN-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Benin.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with an event invitation.',
    'Up to 30 days (single or multiple-entry) or 90 days (multiple-entry tier)',
    'Apply online for the eVisa via the official portal',
    0,
    'Typically 24-48 business hours; allow up to 5 business days in peak periods',
    'Benin eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation from the sporting federation/event organiser\nComplete the online eVisa application form\nUpload passport, photo, and event documents\nPay the eVisa fee online\nReceive the eVisa approval by email',
    '/assets/images/visa-heroes/benin.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisabenin.com/', '2026-09-19'
);
SET @ben9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ben9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben9, 'Core Documents', 'Required from every applicant.', 1);
SET @ben9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ben9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @ben9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(3, 9, 75.00, 'EUR', '30-Day Multiple-Entry eVisa Fee', 'Single-entry 30-day tier is EUR 50; 90-day multiple-entry tier is EUR 100.', '2026-01-01', NOW(), 'https://evisabenin.com/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Benin?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard eVisa with a federation/event invitation.', 3, 9, 309, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    3, 10, 'BEN-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Beninese work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the nearest Benin mission for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Benin diplomatic mission (confirm current jurisdiction serving India)',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply via the relevant mission\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/benin.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisabenin.com/', '2026-09-19'
);
SET @ben10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ben10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben10, 'Core Documents', 'Required from every applicant.', 1);
SET @ben10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ben10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ben10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @ben10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ben10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@ben10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(3, 10, NULL, 'EUR', 'Confirm at Mission', 'Dependent permit fee not independently confirmed this session; confirm with the relevant Benin mission.', '2026-09-01', NOW(), 'https://evisabenin.com/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Benin?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the relevant mission.', 3, 10, 310, 1);
