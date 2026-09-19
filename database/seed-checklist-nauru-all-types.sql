-- Nauru Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Nauru's real, distinctive facts verified this session:
--   - All Indian passport holders require a visa for Nauru. Visa on
--     arrival exists only for a named list of 15 nationalities (Cook
--     Islands, Fiji, Israel, Marshall Islands, Micronesia, Palau,
--     Papua New Guinea, Russia, Samoa, Solomon Islands, Taiwan,
--     Thailand, Tonga, Tuvalu, Vanuatu) — India is not on this list.
--   - Distinctive, unusually manual application process: visa
--     applications are submitted by EMAIL directly to the Nauru
--     Immigration Service (addressed to the Acting Director of
--     Immigration by name), rather than through a portal or embassy —
--     reflecting Nauru's very small government administrative scale.
--   - Processing takes 2-6 weeks; passport must be valid 3+ months.
--   - Distinctive fee finding: Nauru charges a notorious AUD 8,000
--     media/journalist visa fee, unrelated to ordinary tourist/
--     business visas but worth flagging for any traveller planning
--     journalism-adjacent activity.
--   - Work in Nauru requires a distinct Work Permit/Visa route,
--     separate from ordinary visitor entry.
--
-- country_id 187 = Nauru. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    187, 1, 'NRU-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Nauru.',
    'All Indian passport holders require a visa for Nauru — India is not among the 15 nationalities eligible for visa-on-arrival.',
    'Per visa validity',
    'Email a visa application to the Nauru Immigration Service before travel',
    0,
    'Applications are submitted by email directly to Nauru Immigration, not through an online portal or embassy. Processing 2-6 weeks.',
    'No Nauru mission in India — apply by email directly to the Nauru Immigration Service',
    'Confirm your passport is valid for 3+ months\nComplete the visa application form\nEmail the form and scanned passport copy to Nauru Immigration\nAllow 2-6 weeks for processing\nCarry the approved visa for immigration on arrival',
    '/assets/images/visa-heroes/nauru.webp',
    'naurugov.nr and desinri.com secondary sourcing', 'http://naurugov.nr/about-nauru/visiting-nauru/visa-requirements.aspx', '2026-09-19'
);
SET @nru1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nru1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nru1, 'Core Documents', 'Required from every applicant.', 1);
SET @nru1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nru1s1, 'Valid Passport (3+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nru1s1, 'Completed Visa Application Form', NULL, 'original', 1, 0, 1, 2),
(@nru1s1, 'Scanned Passport Details Page', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nru1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @nru1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nru1s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@nru1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(187, 1, 0.00, 'AUD', 'Fee Not Independently Confirmed', 'Official visitor visa fee not clearly detailed in sources reviewed this session — verify directly with Nauru Immigration. Note: a distinct AUD 8,000 media/journalist visa fee applies for journalism-related visits, not ordinary tourism.', '2026-01-01', NOW(), 'https://www.globalcitizensolutions.com/nauru-immigration/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Nauru?', 'Yes — India is not among the 15 nationalities eligible for visa-on-arrival, so a visa must be arranged in advance by email to Nauru Immigration.', 187, 1, 18700, 1),
('How do Indian citizens apply for a Nauru visa?', 'By emailing a completed application form and passport scan directly to the Nauru Immigration Service — there is no online portal or embassy application in India.', 187, 1, 18701, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    187, 2, 'NRU-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Nauru.',
    'Business travellers use the same email-based visa application process as tourists, with an employer/business letter as additional support.',
    'Per visa validity',
    'Email a visa application, with a letter from your employer stating the reason for travel, to Nauru Immigration',
    0,
    'Processing 2-6 weeks — apply well in advance of any business trip.',
    'No Nauru mission in India — apply by email directly to the Nauru Immigration Service',
    'Confirm your passport is valid for 3+ months\nComplete the visa application form\nGather a letter from your employer stating the reason for travel\nEmail the application to Nauru Immigration\nAllow 2-6 weeks for processing',
    '/assets/images/visa-heroes/nauru.webp',
    'desinri.com secondary sourcing', 'https://desinri.com/visa/nauru-visitor-permit-entry-visa-visitor-requirements-fees-processing-time-how-to-apply/', '2026-09-19'
);
SET @nru2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nru2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nru2, 'Core Documents', 'Required from every applicant.', 1);
SET @nru2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nru2s1, 'Valid Passport (3+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nru2s1, 'Employer Letter Stating Reason for Trip', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nru2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @nru2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nru2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@nru2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(187, 2, 0.00, 'AUD', 'Fee Not Independently Confirmed', 'Official visitor visa fee not clearly detailed in sources reviewed this session — verify directly with Nauru Immigration.', '2026-01-01', NOW(), 'https://www.globalcitizensolutions.com/nauru-immigration/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Nauru?', 'Yes — apply by email to Nauru Immigration with a letter from your employer stating the reason for travel.', 187, 2, 18720, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    187, 3, 'NRU-STU-IN-01', '2026.09', 'published',
    'Academic study at a Nauru educational institution.',
    'Sources reviewed this session did not describe a dedicated Nauru student-visa category distinct from the general email-based visitor visa process.',
    'Study-program length',
    'Email a visa application to Nauru Immigration, with a university admission letter',
    1,
    'Not independently confirmed this session whether a distinct student-visa category exists.',
    'No Nauru mission in India — apply by email directly to the Nauru Immigration Service',
    'Confirm admission with a Nauru educational institution\nGather passport, admission letter, and proof of funds\nEmail the visa application to Nauru Immigration\nAllow 2-6 weeks for processing\nRegister with local authorities after arrival',
    '/assets/images/visa-heroes/nauru.webp',
    'desinri.com secondary sourcing', 'https://desinri.com/visa/nauru-visitor-permit-entry-visa-visitor-requirements-fees-processing-time-how-to-apply/', '2026-09-19'
);
SET @nru3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nru3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nru3, 'Core Documents', 'Required from every applicant.', 1);
SET @nru3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nru3s1, 'Valid Passport (3+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nru3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nru3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @nru3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nru3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@nru3s2, 'Scanned Passport Details Page', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(187, 3, 0.00, 'AUD', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://desinri.com/visa/nauru-visitor-permit-entry-visa-visitor-requirements-fees-processing-time-how-to-apply/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for Nauru?', 'Not independently confirmed this session — apply via the general email-based visitor visa process once admission is secured.', 187, 3, 18730, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    187, 4, 'NRU-WORK-IN-01', '2026.09', 'published',
    'Employment in Nauru under a local employer.',
    'Nauru requires a distinct Work Permit/Visa for paid employment or employment-related duties, separate from ordinary visitor entry.',
    'Per work-permit validity',
    'Employer sponsors your Work Permit application, submitted by email to Nauru Immigration',
    1,
    'Not independently confirmed this session: exact work-permit fee and processing time beyond the general 2-6 week range.',
    'No Nauru mission in India — apply by email directly to the Nauru Immigration Service',
    'Secure a job offer from a Nauru employer\nEmployer sponsors your Work Permit application\nGather employment contract and supporting documents\nEmail the application to Nauru Immigration\nAllow 2-6 weeks for processing',
    '/assets/images/visa-heroes/nauru.webp',
    'desinri.com secondary sourcing', 'https://desinri.com/visa/nauru-work-permit-work-visa-work-requirements-fees-processing-time-how-to-apply/', '2026-09-19'
);
SET @nru4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nru4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nru4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @nru4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nru4s1, 'Valid Passport (3+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nru4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nru4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @nru4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nru4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@nru4s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(187, 4, 0.00, 'AUD', 'Fee Not Independently Confirmed', 'Work permit fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://desinri.com/visa/nauru-work-permit-work-visa-work-requirements-fees-processing-time-how-to-apply/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What does an Indian citizen need to work in Nauru?', 'A distinct Work Permit/Visa sponsored by your employer, separate from ordinary visitor entry — applied for by email to Nauru Immigration.', 187, 4, 18740, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    187, 5, 'NRU-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Nauru.',
    'Family visitors use the same email-based visa application process as tourists.',
    'Per visa validity',
    'Email a visa application to the Nauru Immigration Service before travel',
    0,
    'Processing 2-6 weeks.',
    'No Nauru mission in India — apply by email directly to the Nauru Immigration Service',
    'Confirm your passport is valid for 3+ months\nComplete the visa application form\nCarry proof of relationship and host contact details\nEmail the application to Nauru Immigration\nAllow 2-6 weeks for processing',
    '/assets/images/visa-heroes/nauru.webp',
    'naurugov.nr secondary sourcing', 'http://naurugov.nr/about-nauru/visiting-nauru/visa-requirements.aspx', '2026-09-19'
);
SET @nru5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nru5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nru5, 'Core Documents', 'Required from every applicant.', 1);
SET @nru5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nru5s1, 'Valid Passport (3+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nru5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nru5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @nru5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nru5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 1),
(@nru5s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(187, 5, 0.00, 'AUD', 'Fee Not Independently Confirmed', 'Official visitor visa fee not clearly detailed in sources reviewed this session.', '2026-01-01', NOW(), 'https://www.globalcitizensolutions.com/nauru-immigration/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Nauru?', 'Yes — the same email-based visitor visa process applies as for tourist travel.', 187, 5, 18750, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    187, 6, 'NRU-TRAN-IN-01', '2026.09', 'published',
    'Transit through Nauru en route to another destination.',
    'Sources reviewed this session did not describe a separate airside-only transit exemption for Indian passport holders — given Nauru\'s strict visitor-visa requirement, travellers clearing immigration should expect to need the same email-based visa as other visa types.',
    'Short transit only',
    'Email a visa application to Nauru Immigration in advance if clearing immigration',
    0,
    'Not independently confirmed this session whether an airside-only exemption exists — verify with your airline. Given the 2-6 week processing time, plan well ahead.',
    'No Nauru mission in India — apply by email directly to the Nauru Immigration Service',
    'Confirm your connecting flight and transit time\nEmail a visa application well in advance if there is any possibility of clearing immigration\nCarry your onward boarding pass and passport\nConfirm airside-only transit exemptions directly with your airline',
    '/assets/images/visa-heroes/nauru.webp',
    'naurugov.nr secondary sourcing (transit exemption not independently confirmed)', 'http://naurugov.nr/about-nauru/visiting-nauru/visa-requirements.aspx', '2026-09-19'
);
SET @nru6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nru6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nru6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @nru6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nru6s1, 'Valid Passport (3+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nru6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(187, 6, 0.00, 'AUD', 'Fee Not Independently Confirmed', 'Transit visa fee was not independently confirmed this session.', '2026-01-01', NOW(), 'http://naurugov.nr/about-nauru/visiting-nauru/visa-requirements.aspx', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Nauru?', 'Not independently confirmed this session whether airside-only transit is exempt. Given Nauru\'s strict visa requirement and slow processing, plan well ahead if you may clear immigration.', 187, 6, 18760, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    187, 7, 'NRU-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Nauru.',
    'Medical travellers use the same email-based visa application process as tourists. Note: Nauru\'s medical infrastructure is very limited; serious treatment is typically referred overseas.',
    'Per visa validity',
    'Email a visa application to the Nauru Immigration Service before travel',
    0,
    'Confirm treatment availability directly given Nauru\'s very limited medical infrastructure. Processing 2-6 weeks.',
    'No Nauru mission in India — apply by email directly to the Nauru Immigration Service',
    'Confirm treatment and appointment directly with the Nauru medical facility\nComplete the visa application form\nEmail the application to Nauru Immigration\nAllow 2-6 weeks for processing\nCarry all medical and travel documents for immigration',
    '/assets/images/visa-heroes/nauru.webp',
    'naurugov.nr secondary sourcing', 'http://naurugov.nr/about-nauru/visiting-nauru/visa-requirements.aspx', '2026-09-19'
);
SET @nru7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nru7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nru7, 'Core Documents', 'Required from every applicant.', 1);
SET @nru7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nru7s1, 'Valid Passport (3+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nru7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nru7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @nru7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nru7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@nru7s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(187, 7, 0.00, 'AUD', 'Fee Not Independently Confirmed', 'Official visitor visa fee not clearly detailed in sources reviewed this session.', '2026-01-01', NOW(), 'https://www.globalcitizensolutions.com/nauru-immigration/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Nauru?', 'No separate medical visa — the same email-based visitor visa process applies. Given very limited local medical infrastructure, confirm treatment availability directly beforehand.', 187, 7, 18770, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    187, 8, 'NRU-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Nauru.',
    'Conference attendees use the same email-based visa application process as business travellers.',
    'Per visa validity',
    'Email a visa application to the Nauru Immigration Service before travel',
    0,
    'Processing 2-6 weeks — apply well in advance.',
    'No Nauru mission in India — apply by email directly to the Nauru Immigration Service',
    'Confirm your passport is valid for 3+ months\nCarry conference invitation/registration confirmation\nComplete the visa application form\nEmail the application to Nauru Immigration\nAllow 2-6 weeks for processing',
    '/assets/images/visa-heroes/nauru.webp',
    'naurugov.nr secondary sourcing', 'http://naurugov.nr/about-nauru/visiting-nauru/visa-requirements.aspx', '2026-09-19'
);
SET @nru8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nru8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nru8, 'Core Documents', 'Required from every applicant.', 1);
SET @nru8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nru8s1, 'Valid Passport (3+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nru8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nru8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @nru8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nru8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@nru8s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(187, 8, 0.00, 'AUD', 'Fee Not Independently Confirmed', 'Official visitor visa fee not clearly detailed in sources reviewed this session.', '2026-01-01', NOW(), 'https://www.globalcitizensolutions.com/nauru-immigration/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Nauru?', 'No separate conference visa — the same email-based visitor visa process applies as for business travel.', 187, 8, 18780, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    187, 9, 'NRU-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Nauru.',
    'Sports travellers use the same email-based visa application process as tourists.',
    'Per visa validity',
    'Email a visa application to the Nauru Immigration Service before travel',
    0,
    'Processing 2-6 weeks — apply well in advance.',
    'No Nauru mission in India — apply by email directly to the Nauru Immigration Service',
    'Confirm your passport is valid for 3+ months\nCarry event invitation/participation confirmation\nComplete the visa application form\nEmail the application to Nauru Immigration\nAllow 2-6 weeks for processing',
    '/assets/images/visa-heroes/nauru.webp',
    'naurugov.nr secondary sourcing', 'http://naurugov.nr/about-nauru/visiting-nauru/visa-requirements.aspx', '2026-09-19'
);
SET @nru9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nru9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nru9, 'Core Documents', 'Required from every applicant.', 1);
SET @nru9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nru9s1, 'Valid Passport (3+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nru9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nru9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @nru9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nru9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@nru9s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(187, 9, 0.00, 'AUD', 'Fee Not Independently Confirmed', 'Official visitor visa fee not clearly detailed in sources reviewed this session.', '2026-01-01', NOW(), 'https://www.globalcitizensolutions.com/nauru-immigration/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Nauru?', 'No separate sports visa — the same email-based visitor visa process applies as for tourist travel.', 187, 9, 18790, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    187, 10, 'NRU-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Nauru Work Permit.',
    'Dependants apply via the same email-based process, referencing the primary Work Permit holder\'s status.',
    'Tied to the primary permit holder\'s Work Permit validity',
    'Email a visa application to Nauru Immigration, referencing the primary permit holder\'s status',
    1,
    'Not independently confirmed this session: exact dependant-visa fee and process.',
    'No Nauru mission in India — apply by email directly to the Nauru Immigration Service',
    'Confirm the primary permit holder\'s Work Permit status\nGather proof of relationship (marriage/birth certificate)\nEmail the application to Nauru Immigration\nAllow 2-6 weeks for processing\nRegister with local authorities on arrival',
    '/assets/images/visa-heroes/nauru.webp',
    'desinri.com secondary sourcing', 'https://desinri.com/visa/nauru-work-permit-work-visa-work-requirements-fees-processing-time-how-to-apply/', '2026-09-19'
);
SET @nru10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nru10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nru10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @nru10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nru10s1, 'Valid Passport (3+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nru10s1, 'Proof of Relationship to Primary Permit Holder', NULL, 'original', 1, 0, 1, 2),
(@nru10s1, 'Primary Permit Holder\'s Work Permit Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nru10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @nru10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nru10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@nru10s2, 'Scanned Passport Details Page', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(187, 10, 0.00, 'AUD', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://desinri.com/visa/nauru-work-permit-work-visa-work-requirements-fees-processing-time-how-to-apply/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do dependants of Work Permit holders need their own visa in Nauru?', 'Expected to require a separate application referencing the primary permit holder\'s status — not independently confirmed this session.', 187, 10, 18700, 1);
