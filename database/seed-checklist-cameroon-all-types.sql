-- Cameroon Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Cameroon's real, distinctive facts verified this session:
--   - All Indian citizens require an eVisa — apply online via the
--     official evisacam.cm / evisacameroon.com portal, no embassy
--     visit required for the standard route.
--   - Fee: USD 87.50 for a single-entry tourist eVisa, valid up to 90
--     days. Multiple-entry requires embassy application instead of
--     the eVisa portal. One secondary source cites a higher tier
--     (USD 164 / 180 days) — flagged as a possible different
--     category or outdated figure.
--   - Processing: typically 3-5 business days; another source claims
--     as fast as 2-3 business days.
--
-- country_id 8 = Cameroon. visa_type_id: 1=Tourist, 2=Business,
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
    8, 1, 'CMR-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Cameroon.',
    'Indian citizens require an eVisa before travel; apply entirely online for single-entry, or via embassy for multiple-entry.',
    'Up to 90 days, single-entry',
    'Apply online for the eVisa via the official evisacam.cm portal',
    0,
    'Typically 3-5 business days',
    'Cameroon Official eVisa Portal (online) — no in-person appearance required for single-entry',
    'Go to the official evisacam.cm portal\nComplete the online eVisa application form\nUpload passport bio page and photo\nPay the eVisa fee online\nReceive the eVisa approval by email and carry it with your passport',
    '/assets/images/visa-heroes/cameroon.webp',
    'Official Cameroon eVisa portal (evisacam.cm) and evisaguides.com secondary sourcing', 'https://www.evisacam.cm/', '2026-09-19'
);
SET @cmr1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cmr1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr1, 'Core Documents', 'Required from every applicant.', 1);
SET @cmr1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cmr1s1, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@cmr1s1, 'Completed Online eVisa Application', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @cmr1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr1s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 1),
(@cmr1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(8, 1, 87.50, 'USD', 'Single-Entry eVisa Fee', 'Multiple-entry requires an embassy application instead of the eVisa portal. One secondary source cites a higher USD 164/180-day tier — confirm current pricing with the official portal.', '2026-01-01', NOW(), 'https://www.evisacam.cm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Cameroon?', 'Yes — all Indian citizens require an eVisa, applied for entirely online via the official evisacam.cm portal for single-entry trips.', 8, 1, 800, 1),
('Can I get a multiple-entry visa for Cameroon online?', 'Not independently confirmed this session — the eVisa portal is documented for single-entry only; multiple-entry likely requires an embassy application.', 8, 1, 801, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    8, 2, 'CMR-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Cameroon.',
    'Business travellers use the same eVisa framework as tourists, adding a business invitation letter.',
    'Up to 90 days, single-entry',
    'Apply online for the eVisa via the official evisacam.cm portal',
    0,
    'Typically 3-5 business days',
    'Cameroon Official eVisa Portal (online) — no in-person appearance required for single-entry',
    'Obtain a business invitation letter\nGo to the official evisacam.cm portal\nUpload passport, photo, and supporting documents\nPay the eVisa fee online\nReceive the eVisa approval by email',
    '/assets/images/visa-heroes/cameroon.webp',
    'Official Cameroon eVisa portal (evisacam.cm) and evisaguides.com secondary sourcing', 'https://www.evisacam.cm/', '2026-09-19'
);
SET @cmr2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cmr2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr2, 'Core Documents', 'Required from every applicant.', 1);
SET @cmr2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cmr2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @cmr2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@cmr2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(8, 2, 87.50, 'USD', 'Single-Entry eVisa Fee', 'Multiple-entry requires an embassy application instead of the eVisa portal.', '2026-01-01', NOW(), 'https://www.evisacam.cm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should frequent business travellers use the embassy route instead?', 'If you need multiple entries, the embassy application route may suit you better than the single-entry eVisa. Confirm current requirements with the Cameroon embassy.', 8, 2, 802, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    8, 3, 'CMR-STUD-IN-01', '2026.09', 'published',
    'Academic study in Cameroon.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires a long-stay visa beyond the standard 90-day eVisa.',
    'Tied to the academic program duration',
    'Confirm with the nearest Cameroon mission for the student-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Cameroon diplomatic mission (confirm current jurisdiction serving India)',
    'Secure admission confirmation from the Cameroonian institution\nCheck whether the standard eVisa or a separate student visa applies\nGather proof of financial support\nApply via the relevant mission or eVisa portal\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/cameroon.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.evisacam.cm/', '2026-09-19'
);
SET @cmr3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cmr3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr3, 'Core Documents', 'Required from every applicant.', 1);
SET @cmr3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cmr3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @cmr3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@cmr3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(8, 3, NULL, 'USD', 'Confirm at Mission', 'Student visa fee not independently confirmed this session; confirm with the relevant Cameroon mission.', '2026-09-01', NOW(), 'https://www.evisacam.cm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for Cameroon?', 'Not independently confirmed this session — longer academic programs likely require a long-stay visa beyond the standard 90-day eVisa. Confirm with the relevant mission.', 8, 3, 803, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    8, 4, 'CMR-WORK-IN-01', '2026.09', 'published',
    'Employment with a Cameroonian company.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires an employer-sponsored work permit beyond the standard eVisa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the nearest Cameroon mission for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Cameroon diplomatic mission (confirm current jurisdiction serving India)',
    'Secure a signed employment contract from the Cameroonian employer\nCheck whether a separate work permit is required beyond the eVisa\nGather proof of qualifications\nApply via the relevant mission\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/cameroon.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.evisacam.cm/', '2026-09-19'
);
SET @cmr4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cmr4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr4, 'Core Documents', 'Required from every applicant.', 1);
SET @cmr4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cmr4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @cmr4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@cmr4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(8, 4, NULL, 'USD', 'Confirm at Mission', 'Work permit fee not independently confirmed this session; confirm with the relevant Cameroon mission.', '2026-09-01', NOW(), 'https://www.evisacam.cm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for Cameroon beyond the eVisa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit. Confirm with the relevant mission.', 8, 4, 804, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    8, 5, 'CMR-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Cameroon.',
    'Family visits use the same eVisa framework as tourism, adding an invitation letter and relationship proof.',
    'Up to 90 days, single-entry',
    'Apply online for the eVisa via the official evisacam.cm portal',
    0,
    'Typically 3-5 business days',
    'Cameroon Official eVisa Portal (online) — no in-person appearance required for single-entry',
    'Obtain an invitation letter from the family member resident in Cameroon\nGo to the official evisacam.cm portal\nUpload passport, photo, and relationship proof\nPay the eVisa fee online\nReceive the eVisa approval by email',
    '/assets/images/visa-heroes/cameroon.webp',
    'Official Cameroon eVisa portal (evisacam.cm) and evisaguides.com secondary sourcing', 'https://www.evisacam.cm/', '2026-09-19'
);
SET @cmr5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cmr5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr5, 'Core Documents', 'Required from every applicant.', 1);
SET @cmr5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cmr5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @cmr5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@cmr5s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(8, 5, 87.50, 'USD', 'Single-Entry eVisa Fee', 'Multiple-entry requires an embassy application instead of the eVisa portal.', '2026-01-01', NOW(), 'https://www.evisacam.cm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Cameroon on the standard eVisa?', 'Yes — family visits use the same eVisa framework as tourism, with an invitation letter and relationship proof added.', 8, 5, 805, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    8, 6, 'CMR-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Cameroon en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard eVisa or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the eVisa portal or your airline whether the standard eVisa applies',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Cameroon Official eVisa Portal (online) — no in-person appearance required',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific eVisa is required\nGo to the official evisacam.cm portal if needed\nUpload passport, photo, and onward ticket\nReceive the eVisa approval by email if applicable',
    '/assets/images/visa-heroes/cameroon.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.evisacam.cm/', '2026-09-19'
);
SET @cmr6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cmr6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr6, 'Core Documents', 'Required from every applicant.', 1);
SET @cmr6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cmr6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @cmr6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(8, 6, NULL, 'USD', 'Confirm at Portal', 'Transit fee not independently confirmed this session; confirm on the official eVisa portal.', '2026-09-01', NOW(), 'https://www.evisacam.cm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Cameroon?', 'Not independently confirmed this session — confirm with the eVisa portal or your airline whether your specific transit routing requires the standard eVisa.', 8, 6, 806, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    8, 7, 'CMR-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Cameroon.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with medical documentation.',
    'Up to 90 days, single-entry',
    'Apply online for the eVisa via the official evisacam.cm portal',
    0,
    'Typically 3-5 business days',
    'Cameroon Official eVisa Portal (online) — no in-person appearance required',
    'Obtain a medical appointment/admission letter from the hospital\nGo to the official evisacam.cm portal\nUpload passport, photo, and medical documents\nPay the eVisa fee online\nReceive the eVisa approval by email',
    '/assets/images/visa-heroes/cameroon.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.evisacam.cm/', '2026-09-19'
);
SET @cmr7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cmr7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr7, 'Core Documents', 'Required from every applicant.', 1);
SET @cmr7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cmr7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @cmr7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@cmr7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(8, 7, 87.50, 'USD', 'Single-Entry eVisa Fee', 'Multiple-entry requires an embassy application instead of the eVisa portal.', '2026-01-01', NOW(), 'https://www.evisacam.cm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Cameroon?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard eVisa with supporting medical documentation.', 8, 7, 807, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    8, 8, 'CMR-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Cameroon.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business eVisa framework with an event invitation.',
    'Up to 90 days, single-entry',
    'Apply online for the eVisa via the official evisacam.cm portal',
    0,
    'Typically 3-5 business days',
    'Cameroon Official eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation letter from the event organiser\nGo to the official evisacam.cm portal\nUpload passport, photo, and event documents\nPay the eVisa fee online\nReceive the eVisa approval by email',
    '/assets/images/visa-heroes/cameroon.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.evisacam.cm/', '2026-09-19'
);
SET @cmr8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cmr8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr8, 'Core Documents', 'Required from every applicant.', 1);
SET @cmr8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cmr8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @cmr8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(8, 8, 87.50, 'USD', 'Single-Entry eVisa Fee', 'Multiple-entry requires an embassy application instead of the eVisa portal.', '2026-01-01', NOW(), 'https://www.evisacam.cm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Cameroon?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business eVisa framework with an official invitation letter.', 8, 8, 808, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    8, 9, 'CMR-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Cameroon.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with an event invitation.',
    'Up to 90 days, single-entry',
    'Apply online for the eVisa via the official evisacam.cm portal',
    0,
    'Typically 3-5 business days',
    'Cameroon Official eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation from the sporting federation/event organiser\nGo to the official evisacam.cm portal\nUpload passport, photo, and event documents\nPay the eVisa fee online\nReceive the eVisa approval by email',
    '/assets/images/visa-heroes/cameroon.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.evisacam.cm/', '2026-09-19'
);
SET @cmr9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cmr9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr9, 'Core Documents', 'Required from every applicant.', 1);
SET @cmr9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cmr9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @cmr9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(8, 9, 87.50, 'USD', 'Single-Entry eVisa Fee', 'Multiple-entry requires an embassy application instead of the eVisa portal.', '2026-01-01', NOW(), 'https://www.evisacam.cm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Cameroon?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard eVisa with a federation/event invitation.', 8, 9, 809, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    8, 10, 'CMR-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Cameroonian work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the nearest Cameroon mission for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Cameroon diplomatic mission (confirm current jurisdiction serving India)',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply via the relevant mission\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/cameroon.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.evisacam.cm/', '2026-09-19'
);
SET @cmr10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cmr10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr10, 'Core Documents', 'Required from every applicant.', 1);
SET @cmr10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cmr10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cmr10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @cmr10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cmr10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@cmr10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(8, 10, NULL, 'USD', 'Confirm at Mission', 'Dependent permit fee not independently confirmed this session; confirm with the relevant Cameroon mission.', '2026-09-01', NOW(), 'https://www.evisacam.cm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Cameroon?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the relevant mission.', 8, 10, 8010, 1);
