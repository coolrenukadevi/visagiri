-- Ivory Coast (Cote d'Ivoire) Visa Checklist Engine content for all 10
-- visa types — built fresh this session via web search.
--
-- Ivory Coast's real, distinctive facts verified this session:
--   - Indian citizens require a visa for Ivory Coast for every
--     purpose — either an eVisa (90 days, multiple entry) or an
--     embassy visa from the Embassy of the Republic of Cote d'Ivoire,
--     New Delhi.
--   - Distinctive restriction: the eVisa route only permits entry
--     through Abidjan Felix Houphouet-Boigny International Airport —
--     travellers arriving by any other airport or land border must
--     use the embassy visa route instead.
--   - Fee: approximately EUR 50 (~INR 5,000) for the standard tourist
--     visa, sourced from ivorycoastimmigration.org.
--   - India maintains its own Embassy of India in Abidjan for
--     consular assistance to Indian nationals in Ivory Coast.
--
-- country_id 24 = Ivory Coast. visa_type_id: 1=Tourist, 2=Business,
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
    24, 1, 'CIV-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Ivory Coast.',
    'Indian citizens require a visa for Ivory Coast — an eVisa (90 days, multiple entry, valid only for arrival at Abidjan airport) or an embassy visa from the Embassy of Cote d\'Ivoire, New Delhi.',
    'Up to 90 days, multiple entry',
    'Apply online for the eVisa (Abidjan airport arrival only), or through the Embassy of Cote d\'Ivoire, New Delhi',
    0,
    'The eVisa is valid only for entry via Abidjan Felix Houphouet-Boigny International Airport — use the embassy route if arriving elsewhere. Processing 3-5 business days.',
    'Embassy of the Republic of Cote d\'Ivoire, New Delhi; Embassy of India, Abidjan (for consular assistance)',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nApply for the eVisa online, or apply through the Embassy of Cote d\'Ivoire, New Delhi\nGather proof of accommodation, return ticket, and sufficient funds\nConfirm you are arriving via Abidjan airport if using the eVisa\nCarry all documents for immigration on arrival',
    NULL,
    'ivisatravel.com and ivorycoastimmigration.org secondary sourcing', 'https://www.ivorycoastimmigration.org/check-requirements/india', '2026-09-19'
);
SET @civ1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@civ1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@civ1, 'Core Documents', 'Required from every applicant.', 1);
SET @civ1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@civ1s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@civ1s1, 'Approved eVisa or Embassy Visa', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@civ1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @civ1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@civ1s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@civ1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 2),
(@civ1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(24, 1, 50.00, 'EUR', 'Tourist Visa Fee', 'Approximately EUR 50 (~INR 5,000) for the standard tourist visa/eVisa.', '2026-01-01', NOW(), 'https://www.ivorycoastimmigration.org/check-requirements/india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Ivory Coast?', 'Yes — either an eVisa (90 days, multiple entry) or an embassy visa from the Embassy of Cote d\'Ivoire, New Delhi.', 24, 1, 2400, 1),
('Does the Ivory Coast eVisa work for all arrival points?', 'No — the eVisa is valid only for entry via Abidjan Felix Houphouet-Boigny International Airport. Travellers arriving elsewhere should use the embassy visa route.', 24, 1, 2401, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    24, 2, 'CIV-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Ivory Coast.',
    'Business travellers use the same eVisa/embassy-visa framework as tourists, with a business invitation letter recommended.',
    'Up to 90 days, multiple entry',
    'Apply online for the eVisa (Abidjan airport arrival only), or through the Embassy of Cote d\'Ivoire, New Delhi',
    0,
    'The eVisa is valid only for entry via Abidjan airport — use the embassy route if arriving elsewhere.',
    'Embassy of the Republic of Cote d\'Ivoire, New Delhi',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nApply for the eVisa online, or apply through the Embassy of Cote d\'Ivoire, New Delhi\nCarry a business invitation letter from the host organization\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'ivorycoastimmigration.org secondary sourcing', 'https://www.ivorycoastimmigration.org/check-requirements/india', '2026-09-19'
);
SET @civ2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@civ2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@civ2, 'Core Documents', 'Required from every applicant.', 1);
SET @civ2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@civ2s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@civ2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@civ2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @civ2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@civ2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@civ2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(24, 2, 50.00, 'EUR', 'Business Visa Fee', 'Same EUR 50 fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.ivorycoastimmigration.org/check-requirements/india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Ivory Coast?', 'Yes — the same eVisa/embassy-visa framework applies, with a business invitation letter recommended.', 24, 2, 2420, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    24, 3, 'CIV-STU-IN-01', '2026.09', 'published',
    'Academic study at an Ivorian educational institution.',
    'Sources reviewed this session did not describe a dedicated Ivory Coast student-visa category distinct from the general embassy visa process, applied for once admission is secured.',
    'Study-program length, renewable',
    'Apply through the Embassy of Cote d\'Ivoire, New Delhi, with a university admission letter',
    1,
    'Not independently confirmed this session whether a distinct student-visa category exists — verify directly with your institution and the Embassy of Cote d\'Ivoire, New Delhi.',
    'Embassy of the Republic of Cote d\'Ivoire, New Delhi',
    'Confirm admission with an Ivorian educational institution\nGather passport, admission letter, and proof of funds\nApply through the Embassy of Cote d\'Ivoire, New Delhi\nCollect your visa on the confirmed collection date\nRegister with local authorities after arrival if required',
    NULL,
    'ivorycoastimmigration.org secondary sourcing', 'https://www.ivorycoastimmigration.org/check-requirements/india', '2026-09-19'
);
SET @civ3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@civ3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@civ3, 'Core Documents', 'Required from every applicant.', 1);
SET @civ3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@civ3s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@civ3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@civ3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @civ3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@civ3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@civ3s2, 'Identity Photograph (4.5cm x 3.5cm)', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(24, 3, 0.00, 'EUR', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session — verify with the Embassy of Cote d\'Ivoire, New Delhi.', '2026-01-01', NOW(), 'https://www.ivorycoastimmigration.org/check-requirements/india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for Ivory Coast?', 'Not independently confirmed this session — apply through the general embassy visa process once admission is secured, via the Embassy of Cote d\'Ivoire, New Delhi.', 24, 3, 2430, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    24, 4, 'CIV-WORK-IN-01', '2026.09', 'published',
    'Employment in Ivory Coast under a local employer.',
    'Sources reviewed this session did not describe a dedicated Ivory Coast work-visa category distinct from the general embassy visa process, applied for with employer sponsorship documentation.',
    'Per employment contract, renewable',
    'Apply through the Embassy of Cote d\'Ivoire, New Delhi, with employer sponsorship documentation',
    1,
    'Not independently confirmed this session: exact work-visa fee, category, and local work-permit process — verify directly with the Embassy of Cote d\'Ivoire, New Delhi, and Ivorian labour authorities.',
    'Embassy of the Republic of Cote d\'Ivoire, New Delhi',
    'Secure a job offer from an Ivorian employer\nGather employment contract/sponsorship letter\nApply through the Embassy of Cote d\'Ivoire, New Delhi\nCollect your visa on the confirmed collection date\nRegister with local labour authorities on arrival if required',
    NULL,
    'ivorycoastimmigration.org secondary sourcing', 'https://www.ivorycoastimmigration.org/check-requirements/india', '2026-09-19'
);
SET @civ4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@civ4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@civ4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @civ4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@civ4s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@civ4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@civ4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @civ4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@civ4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@civ4s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(24, 4, 0.00, 'EUR', 'Fee Not Independently Confirmed', 'Work visa fees were not independently confirmed this session — verify with the Embassy of Cote d\'Ivoire, New Delhi.', '2026-01-01', NOW(), 'https://www.ivorycoastimmigration.org/check-requirements/india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How do I get a work visa for Ivory Coast as an Indian citizen?', 'Apply through the Embassy of Cote d\'Ivoire, New Delhi, with employer sponsorship documentation; exact fee and process were not independently confirmed this session.', 24, 4, 2440, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    24, 5, 'CIV-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Ivory Coast.',
    'Family visitors use the same eVisa/embassy-visa framework as tourists.',
    'Up to 90 days, multiple entry',
    'Apply online for the eVisa (Abidjan airport arrival only), or through the Embassy of Cote d\'Ivoire, New Delhi',
    0,
    'The eVisa is valid only for entry via Abidjan airport — use the embassy route if arriving elsewhere.',
    'Embassy of the Republic of Cote d\'Ivoire, New Delhi',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nApply for the eVisa online, or apply through the Embassy of Cote d\'Ivoire, New Delhi\nCarry proof of relationship and host contact details\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'ivorycoastimmigration.org secondary sourcing', 'https://www.ivorycoastimmigration.org/check-requirements/india', '2026-09-19'
);
SET @civ5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@civ5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@civ5, 'Core Documents', 'Required from every applicant.', 1);
SET @civ5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@civ5s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@civ5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@civ5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @civ5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@civ5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 1),
(@civ5s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(24, 5, 50.00, 'EUR', 'Family Visit Visa Fee', 'Same EUR 50 fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.ivorycoastimmigration.org/check-requirements/india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Ivory Coast?', 'Yes — the same eVisa/embassy-visa framework applies as for tourist travel.', 24, 5, 2450, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    24, 6, 'CIV-TRAN-IN-01', '2026.09', 'published',
    'Transit through Ivory Coast en route to another destination.',
    'Sources reviewed this session did not describe a separate airside-only transit exemption for Indian passport holders — travellers clearing immigration should expect to need the same eVisa/embassy-visa as other visa types.',
    'Short transit only',
    'Apply for the eVisa (Abidjan airport arrival only), or through the Embassy of Cote d\'Ivoire, New Delhi, before transiting',
    0,
    'Not independently confirmed this session whether an airside-only exemption exists — verify with your airline before relying on transiting without a visa.',
    'Embassy of the Republic of Cote d\'Ivoire, New Delhi',
    'Confirm your connecting flight and transit time\nApply for the eVisa in advance if there is any possibility of clearing immigration\nCarry your onward boarding pass and passport\nConfirm airside-only transit exemptions directly with your airline',
    NULL,
    'ivorycoastimmigration.org secondary sourcing (transit exemption not independently confirmed)', 'https://www.ivorycoastimmigration.org/check-requirements/india', '2026-09-19'
);
SET @civ6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@civ6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@civ6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @civ6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@civ6s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@civ6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(24, 6, 0.00, 'EUR', 'Fee Not Independently Confirmed', 'Transit visa fee was not independently confirmed this session — verify with the Embassy of Cote d\'Ivoire, New Delhi.', '2026-01-01', NOW(), 'https://www.ivorycoastimmigration.org/check-requirements/india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Ivory Coast?', 'Not independently confirmed this session whether airside-only transit is exempt. If you may clear immigration, apply for the eVisa in advance.', 24, 6, 2460, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    24, 7, 'CIV-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Ivory Coast.',
    'Medical travellers use the same eVisa/embassy-visa framework as tourists.',
    'Up to 90 days, multiple entry',
    'Apply online for the eVisa (Abidjan airport arrival only), or through the Embassy of Cote d\'Ivoire, New Delhi',
    0,
    'The eVisa is valid only for entry via Abidjan airport — use the embassy route if arriving elsewhere.',
    'Embassy of the Republic of Cote d\'Ivoire, New Delhi',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nConfirm treatment and appointment directly with the Ivorian medical facility\nApply for the eVisa online, or apply through the Embassy of Cote d\'Ivoire, New Delhi\nGather proof of sufficient funds\nCarry all medical and travel documents for immigration',
    NULL,
    'ivorycoastimmigration.org secondary sourcing', 'https://www.ivorycoastimmigration.org/check-requirements/india', '2026-09-19'
);
SET @civ7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@civ7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@civ7, 'Core Documents', 'Required from every applicant.', 1);
SET @civ7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@civ7s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@civ7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@civ7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @civ7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@civ7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@civ7s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(24, 7, 50.00, 'EUR', 'Medical Visa Fee', 'Same EUR 50 fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.ivorycoastimmigration.org/check-requirements/india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Ivory Coast?', 'No separate medical visa — the same eVisa/embassy-visa framework applies as for tourist travel.', 24, 7, 2470, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    24, 8, 'CIV-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Ivory Coast.',
    'Conference attendees use the same eVisa/embassy-visa framework as business travellers.',
    'Up to 90 days, multiple entry',
    'Apply online for the eVisa (Abidjan airport arrival only), or through the Embassy of Cote d\'Ivoire, New Delhi',
    0,
    'The eVisa is valid only for entry via Abidjan airport — use the embassy route if arriving elsewhere.',
    'Embassy of the Republic of Cote d\'Ivoire, New Delhi',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nCarry conference invitation/registration confirmation\nApply for the eVisa online, or apply through the Embassy of Cote d\'Ivoire, New Delhi\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'ivorycoastimmigration.org secondary sourcing', 'https://www.ivorycoastimmigration.org/check-requirements/india', '2026-09-19'
);
SET @civ8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@civ8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@civ8, 'Core Documents', 'Required from every applicant.', 1);
SET @civ8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@civ8s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@civ8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@civ8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @civ8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@civ8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@civ8s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(24, 8, 50.00, 'EUR', 'Conference Visa Fee', 'Same EUR 50 fee range as the business visa applies.', '2026-01-01', NOW(), 'https://www.ivorycoastimmigration.org/check-requirements/india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Ivory Coast?', 'No separate conference visa — the same eVisa/embassy-visa framework applies as for business travel.', 24, 8, 2480, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    24, 9, 'CIV-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Ivory Coast.',
    'Sports travellers use the same eVisa/embassy-visa framework as tourists.',
    'Up to 90 days, multiple entry',
    'Apply online for the eVisa (Abidjan airport arrival only), or through the Embassy of Cote d\'Ivoire, New Delhi',
    0,
    'The eVisa is valid only for entry via Abidjan airport — use the embassy route if arriving elsewhere.',
    'Embassy of the Republic of Cote d\'Ivoire, New Delhi',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nCarry event invitation/participation confirmation\nApply for the eVisa online, or apply through the Embassy of Cote d\'Ivoire, New Delhi\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'ivorycoastimmigration.org secondary sourcing', 'https://www.ivorycoastimmigration.org/check-requirements/india', '2026-09-19'
);
SET @civ9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@civ9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@civ9, 'Core Documents', 'Required from every applicant.', 1);
SET @civ9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@civ9s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@civ9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@civ9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @civ9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@civ9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@civ9s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(24, 9, 50.00, 'EUR', 'Sports Visa Fee', 'Same EUR 50 fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.ivorycoastimmigration.org/check-requirements/india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Ivory Coast?', 'No separate sports visa — the same eVisa/embassy-visa framework applies as for tourist travel.', 24, 9, 2490, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    24, 10, 'CIV-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds an Ivory Coast work/student visa.',
    'Dependants apply through the Embassy of Cote d\'Ivoire, New Delhi, referencing the primary permit holder\'s visa/sponsorship.',
    'Tied to the primary permit holder\'s visa validity',
    'Apply through the Embassy of Cote d\'Ivoire, New Delhi, referencing the primary permit holder\'s visa',
    1,
    'Not independently confirmed this session: exact dependant-visa fee and processing time — verify with the Embassy of Cote d\'Ivoire, New Delhi.',
    'Embassy of the Republic of Cote d\'Ivoire, New Delhi',
    'Confirm the primary permit holder\'s work/student visa status\nGather proof of relationship (marriage/birth certificate)\nApply through the Embassy of Cote d\'Ivoire, New Delhi\nCollect your visa on the confirmed collection date\nCarry all documents for immigration on arrival',
    NULL,
    'ivorycoastimmigration.org secondary sourcing', 'https://www.ivorycoastimmigration.org/check-requirements/india', '2026-09-19'
);
SET @civ10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@civ10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@civ10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @civ10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@civ10s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@civ10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@civ10s1, 'Primary Permit Holder\'s Visa Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@civ10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @civ10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@civ10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@civ10s2, 'Identity Photograph (4.5cm x 3.5cm)', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(24, 10, 0.00, 'EUR', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session — verify with the Embassy of Cote d\'Ivoire, New Delhi.', '2026-01-01', NOW(), 'https://www.ivorycoastimmigration.org/check-requirements/india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependants accompany a work/student visa holder to Ivory Coast?', 'Yes, via a separate application through the Embassy of Cote d\'Ivoire, New Delhi, referencing the primary permit holder\'s visa.', 24, 10, 2400, 1);
