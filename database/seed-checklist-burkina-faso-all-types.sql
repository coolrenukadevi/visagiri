-- Burkina Faso Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search.
--
-- Burkina Faso's real, distinctive facts verified this session:
--   - All Indian citizens require an eVisa — apply only via the
--     official portal (visaburkina.bf) to avoid overpaying on
--     unofficial third-party sites.
--   - Fee: USD 143 (single-entry only via eVisa).
--   - Processing: typically 3-5 business days.
--   - Validity: 30 days from issue date; maximum stay 30 days.
--
-- country_id 5 = Burkina Faso. visa_type_id: 1=Tourist, 2=Business,
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
    5, 1, 'BFA-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Burkina Faso.',
    'All Indian citizens require an eVisa, applied for exclusively through the official visaburkina.bf portal.',
    'Up to 30 days, single-entry',
    'Apply online via the official eVisa portal (visaburkina.bf) — avoid unofficial third-party sites',
    0,
    'Typically 3-5 business days',
    'Burkina Faso Official eVisa Portal (online) — no in-person appearance required',
    'Go to the official visaburkina.bf portal (avoid unofficial sites)\nComplete the online eVisa application form\nUpload passport bio page, photo, and travel documents\nPay the eVisa fee online\nReceive the eVisa by email and carry it with your passport',
    '/assets/images/visa-heroes/burkina-faso.webp',
    'Official Burkina Faso eVisa portal (visaburkina.bf) and dovisa.com secondary sourcing', 'https://applicant.visaburkina.bf/', '2026-09-19'
);
SET @bfa1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bfa1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa1, 'Core Documents', 'Required from every applicant.', 1);
SET @bfa1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bfa1s1, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@bfa1s1, 'Completed Online eVisa Application', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @bfa1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa1s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 1),
(@bfa1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(5, 1, 143.00, 'USD', 'eVisa Fee (Single-Entry)', 'Apply only through the official visaburkina.bf portal — unofficial sites charge extra fees.', '2026-01-01', NOW(), 'https://applicant.visaburkina.bf/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Burkina Faso?', 'Yes — all Indian citizens require an eVisa, applied for exclusively through the official visaburkina.bf portal.', 5, 1, 500, 1),
('How long does the Burkina Faso eVisa take?', 'Typically 3-5 business days. The eVisa is valid for 30 days from issue, with a maximum stay of 30 days, single-entry only.', 5, 1, 501, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    5, 2, 'BFA-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Burkina Faso.',
    'Business travellers use the same eVisa framework as tourists, adding a business invitation letter.',
    'Up to 30 days, single-entry',
    'Apply online via the official eVisa portal (visaburkina.bf)',
    0,
    'Typically 3-5 business days',
    'Burkina Faso Official eVisa Portal (online) — no in-person appearance required',
    'Obtain a business invitation letter\nGo to the official visaburkina.bf portal\nUpload passport, photo, and supporting documents\nPay the eVisa fee online\nReceive the eVisa by email',
    '/assets/images/visa-heroes/burkina-faso.webp',
    'Official Burkina Faso eVisa portal (visaburkina.bf) and dovisa.com secondary sourcing', 'https://applicant.visaburkina.bf/', '2026-09-19'
);
SET @bfa2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bfa2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa2, 'Core Documents', 'Required from every applicant.', 1);
SET @bfa2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bfa2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @bfa2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@bfa2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(5, 2, 143.00, 'USD', 'eVisa Fee (Single-Entry)', 'Apply only through the official visaburkina.bf portal — unofficial sites charge extra fees.', '2026-01-01', NOW(), 'https://applicant.visaburkina.bf/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Burkina Faso eVisa single or multiple entry for business?', 'The eVisa is single-entry only, valid for 30 days from issue. Confirm current re-entry rules with the official portal if you need multiple trips.', 5, 2, 502, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    5, 3, 'BFA-STUD-IN-01', '2026.09', 'published',
    'Academic study in Burkina Faso.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires a long-stay visa beyond the standard 30-day eVisa.',
    'Tied to the academic program duration',
    'Confirm with the nearest Burkina Faso mission for the student-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Burkina Faso diplomatic mission (confirm current jurisdiction serving India)',
    'Secure admission confirmation from the Burkinabe institution\nCheck whether the standard eVisa or a separate student visa applies\nGather proof of financial support\nApply via the relevant mission or eVisa portal\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/burkina-faso.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://applicant.visaburkina.bf/', '2026-09-19'
);
SET @bfa3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bfa3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa3, 'Core Documents', 'Required from every applicant.', 1);
SET @bfa3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bfa3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @bfa3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bfa3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(5, 3, NULL, 'USD', 'Confirm at Mission', 'Student visa fee not independently confirmed this session; confirm with the relevant Burkina Faso mission.', '2026-09-01', NOW(), 'https://applicant.visaburkina.bf/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for Burkina Faso?', 'Not independently confirmed this session — longer academic programs likely require a long-stay visa beyond the standard 30-day eVisa. Confirm with the relevant mission.', 5, 3, 503, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    5, 4, 'BFA-WORK-IN-01', '2026.09', 'published',
    'Employment with a Burkinabe company.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires an employer-sponsored work permit beyond the standard eVisa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the nearest Burkina Faso mission for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Burkina Faso diplomatic mission (confirm current jurisdiction serving India)',
    'Secure a signed employment contract from the Burkinabe employer\nCheck whether a separate work permit is required beyond the eVisa\nGather proof of qualifications\nApply via the relevant mission\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/burkina-faso.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://applicant.visaburkina.bf/', '2026-09-19'
);
SET @bfa4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bfa4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa4, 'Core Documents', 'Required from every applicant.', 1);
SET @bfa4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bfa4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @bfa4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bfa4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(5, 4, NULL, 'USD', 'Confirm at Mission', 'Work permit fee not independently confirmed this session; confirm with the relevant Burkina Faso mission.', '2026-09-01', NOW(), 'https://applicant.visaburkina.bf/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for Burkina Faso beyond the eVisa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit. Confirm with the relevant mission.', 5, 4, 504, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    5, 5, 'BFA-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Burkina Faso.',
    'Family visits use the same eVisa framework as tourism, adding an invitation letter and relationship proof.',
    'Up to 30 days, single-entry',
    'Apply online via the official eVisa portal (visaburkina.bf)',
    0,
    'Typically 3-5 business days',
    'Burkina Faso Official eVisa Portal (online) — no in-person appearance required',
    'Obtain an invitation letter from the family member resident in Burkina Faso\nGo to the official visaburkina.bf portal\nUpload passport, photo, and relationship proof\nPay the eVisa fee online\nReceive the eVisa by email',
    '/assets/images/visa-heroes/burkina-faso.webp',
    'Official Burkina Faso eVisa portal (visaburkina.bf) and dovisa.com secondary sourcing', 'https://applicant.visaburkina.bf/', '2026-09-19'
);
SET @bfa5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bfa5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa5, 'Core Documents', 'Required from every applicant.', 1);
SET @bfa5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bfa5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @bfa5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@bfa5s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(5, 5, 143.00, 'USD', 'eVisa Fee (Single-Entry)', 'Apply only through the official visaburkina.bf portal — unofficial sites charge extra fees.', '2026-01-01', NOW(), 'https://applicant.visaburkina.bf/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Burkina Faso on the standard eVisa?', 'Yes — family visits use the same eVisa framework as tourism, with an invitation letter and relationship proof added.', 5, 5, 505, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    5, 6, 'BFA-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Burkina Faso en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard eVisa or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the eVisa portal or your airline whether the standard eVisa applies',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Burkina Faso Official eVisa Portal (online) — no in-person appearance required',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific eVisa is required\nGo to the official visaburkina.bf portal if needed\nUpload passport, photo, and onward ticket\nReceive the eVisa by email if applicable',
    '/assets/images/visa-heroes/burkina-faso.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://applicant.visaburkina.bf/', '2026-09-19'
);
SET @bfa6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bfa6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa6, 'Core Documents', 'Required from every applicant.', 1);
SET @bfa6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bfa6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @bfa6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(5, 6, NULL, 'USD', 'Confirm at Portal', 'Transit fee not independently confirmed this session; confirm on the official eVisa portal.', '2026-09-01', NOW(), 'https://applicant.visaburkina.bf/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Burkina Faso?', 'Not independently confirmed this session — confirm with the eVisa portal or your airline whether your specific transit routing requires the standard eVisa.', 5, 6, 506, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    5, 7, 'BFA-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Burkina Faso.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with medical documentation.',
    'Up to 30 days, single-entry',
    'Apply online via the official eVisa portal (visaburkina.bf)',
    0,
    'Typically 3-5 business days',
    'Burkina Faso Official eVisa Portal (online) — no in-person appearance required',
    'Obtain a medical appointment/admission letter from the hospital\nGo to the official visaburkina.bf portal\nUpload passport, photo, and medical documents\nPay the eVisa fee online\nReceive the eVisa by email',
    '/assets/images/visa-heroes/burkina-faso.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://applicant.visaburkina.bf/', '2026-09-19'
);
SET @bfa7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bfa7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa7, 'Core Documents', 'Required from every applicant.', 1);
SET @bfa7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bfa7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @bfa7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@bfa7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(5, 7, 143.00, 'USD', 'eVisa Fee (Single-Entry)', 'Apply only through the official visaburkina.bf portal — unofficial sites charge extra fees.', '2026-01-01', NOW(), 'https://applicant.visaburkina.bf/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Burkina Faso?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard eVisa with supporting medical documentation.', 5, 7, 507, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    5, 8, 'BFA-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Burkina Faso.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business eVisa framework with an event invitation.',
    'Up to 30 days, single-entry',
    'Apply online via the official eVisa portal (visaburkina.bf)',
    0,
    'Typically 3-5 business days',
    'Burkina Faso Official eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation letter from the event organiser\nGo to the official visaburkina.bf portal\nUpload passport, photo, and event documents\nPay the eVisa fee online\nReceive the eVisa by email',
    '/assets/images/visa-heroes/burkina-faso.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://applicant.visaburkina.bf/', '2026-09-19'
);
SET @bfa8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bfa8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa8, 'Core Documents', 'Required from every applicant.', 1);
SET @bfa8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bfa8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @bfa8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(5, 8, 143.00, 'USD', 'eVisa Fee (Single-Entry)', 'Apply only through the official visaburkina.bf portal — unofficial sites charge extra fees.', '2026-01-01', NOW(), 'https://applicant.visaburkina.bf/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Burkina Faso?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business eVisa framework with an official invitation letter.', 5, 8, 508, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    5, 9, 'BFA-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Burkina Faso.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with an event invitation.',
    'Up to 30 days, single-entry',
    'Apply online via the official eVisa portal (visaburkina.bf)',
    0,
    'Typically 3-5 business days',
    'Burkina Faso Official eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation from the sporting federation/event organiser\nGo to the official visaburkina.bf portal\nUpload passport, photo, and event documents\nPay the eVisa fee online\nReceive the eVisa by email',
    '/assets/images/visa-heroes/burkina-faso.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://applicant.visaburkina.bf/', '2026-09-19'
);
SET @bfa9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bfa9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa9, 'Core Documents', 'Required from every applicant.', 1);
SET @bfa9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bfa9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @bfa9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(5, 9, 143.00, 'USD', 'eVisa Fee (Single-Entry)', 'Apply only through the official visaburkina.bf portal — unofficial sites charge extra fees.', '2026-01-01', NOW(), 'https://applicant.visaburkina.bf/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Burkina Faso?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard eVisa with a federation/event invitation.', 5, 9, 509, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    5, 10, 'BFA-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Burkina Faso work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the nearest Burkina Faso mission for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Burkina Faso diplomatic mission (confirm current jurisdiction serving India)',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply via the relevant mission\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/burkina-faso.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://applicant.visaburkina.bf/', '2026-09-19'
);
SET @bfa10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bfa10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa10, 'Core Documents', 'Required from every applicant.', 1);
SET @bfa10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bfa10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bfa10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @bfa10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bfa10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@bfa10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(5, 10, NULL, 'USD', 'Confirm at Mission', 'Dependent permit fee not independently confirmed this session; confirm with the relevant Burkina Faso mission.', '2026-09-01', NOW(), 'https://applicant.visaburkina.bf/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Burkina Faso?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the relevant mission.', 5, 10, 5010, 1);
