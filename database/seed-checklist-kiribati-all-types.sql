-- Kiribati Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Kiribati's real, distinctive facts verified this session:
--   - Indian citizens can enter Kiribati visa-free for tourism, up to
--     30 days on arrival, extendable up to 90 days within a year —
--     no visa fee applies for tourist purposes.
--   - For non-tourism purposes, an embassy/immigration visa is
--     required (up to 30 days, government fee around USD 25).
--   - Employment in Kiribati requires a separate Work Permit or
--     Extension of Stay application — exact fee not independently
--     confirmed this session.
--   - Passport must be valid 6+ months beyond the return date with 2+
--     blank pages.
--   - Sourcing note: some secondary sources describe Kiribati as
--     requiring a 30-day online visa for most nationalities, which
--     conflicts with the visa-free tourist framework described by the
--     majority of sources and Kiribati's own tourism board — the
--     visa-free tourist framework is used as primary since it is
--     corroborated by kiribatitourism.gov.ki.
--
-- country_id 184 = Kiribati. visa_type_id: 1=Tourist, 2=Business,
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
    184, 1, 'KIR-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Kiribati.',
    'Indian citizens can enter Kiribati visa-free for up to 30 days on arrival for tourism, extendable up to 90 days within a year.',
    'Up to 30 days, extendable to 90 days',
    'No visa needed for tourism — present passport and onward ticket on arrival',
    0,
    'Not applicable for entry itself. Extension of stay beyond 30 days must be applied for locally with Kiribati Immigration.',
    'No Indian mission in Kiribati; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nBook proof of return/onward ticket\nGather proof of sufficient funds for your stay\nCarry all documents for immigration on arrival\nApply for an extension of stay locally if needed beyond 30 days',
    NULL,
    'kiribatitourism.gov.ki and ixigo.com secondary sourcing', 'https://kiribatitourism.gov.ki/entry-requirements-visa-info', '2026-09-19'
);
SET @kir1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kir1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kir1, 'Core Documents', 'Required from every traveller.', 1);
SET @kir1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kir1s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@kir1s1, 'Confirmed Onward/Return Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kir1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @kir1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kir1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@kir1s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(184, 1, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'No tourist visa fee applies; a local extension of stay beyond 30 days may carry its own fee, not independently confirmed this session.', '2026-01-01', NOW(), 'https://kiribatitourism.gov.ki/entry-requirements-visa-info', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Kiribati?', 'No — Indian citizens can enter Kiribati visa-free for up to 30 days for tourism, extendable up to 90 days within a year.', 184, 1, 18400, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    184, 2, 'KIR-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Kiribati.',
    'Business travel is non-tourism purpose, requiring an embassy/immigration visa (up to 30 days, government fee ~USD 25) rather than the visa-free tourist route.',
    'Up to 30 days',
    'Apply for an embassy/immigration visa before travel',
    0,
    'This differs from the visa-free tourist entry — business purposes require a visa applied for in advance.',
    'No Indian mission in Kiribati; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nApply for the Kiribati business visa in advance\nCarry a business invitation letter from the host organization\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'passportsandvisas.com secondary sourcing', 'https://www.passportsandvisas.com/visas/kiribati/indian-citizens', '2026-09-19'
);
SET @kir2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kir2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kir2, 'Core Documents', 'Required from every applicant.', 1);
SET @kir2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kir2s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@kir2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kir2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @kir2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kir2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@kir2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(184, 2, 25.00, 'USD', 'Business/Immigration Visa Fee', 'Government fee for the general (non-tourist) immigration visa, up to 30 days.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/kiribati/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Kiribati?', 'Yes — business purposes require an embassy/immigration visa (government fee ~USD 25), unlike the visa-free tourist route.', 184, 2, 18420, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    184, 3, 'KIR-STU-IN-01', '2026.09', 'published',
    'Academic study at a Kiribati educational institution.',
    'Sources reviewed this session did not describe a dedicated Kiribati student-visa category distinct from the general immigration visa/extension-of-stay process.',
    'Academic-program length, via extension of stay',
    'Apply for the general immigration visa, then an extension of stay for longer academic programs',
    1,
    'Not independently confirmed this session whether a distinct student-visa category exists — verify directly with Kiribati Immigration.',
    'No Indian mission in Kiribati; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Confirm admission with a Kiribati educational institution\nGather passport, admission letter, and proof of funds\nApply for the general immigration visa before travel\nFile for an extension of stay locally for longer academic programs\nRegister with the institution on arrival',
    NULL,
    'passportsandvisas.com secondary sourcing', 'https://www.passportsandvisas.com/visas/kiribati/indian-citizens', '2026-09-19'
);
SET @kir3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kir3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kir3, 'Core Documents', 'Required from every applicant.', 1);
SET @kir3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kir3s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@kir3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kir3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @kir3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kir3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@kir3s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(184, 3, 25.00, 'USD', 'Immigration Visa Fee (Indicative)', 'Same USD 25 fee as the general immigration visa applies; extension-of-stay fees for longer study were not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/kiribati/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for Kiribati?', 'Not independently confirmed this session — long-term study is expected to route through the general immigration visa plus a local extension of stay.', 184, 3, 18430, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    184, 4, 'KIR-WORK-IN-01', '2026.09', 'published',
    'Employment in Kiribati under a local employer.',
    'Employment requires a separate Work Permit (or an Extension of Stay application tied to employment), in addition to entry documentation.',
    'Per work-permit validity',
    'Employer/sponsor applies for a Work Permit with Kiribati authorities',
    1,
    'Not independently confirmed this session: exact work-permit fee and processing time — verify directly with Kiribati Immigration.',
    'No Indian mission in Kiribati; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Secure a job offer from a Kiribati employer\nEmployer applies for a Work Permit with Kiribati authorities\nEnter Kiribati and register your Work Permit\nFile for an Extension of Stay if required\nRenew your Work Permit as needed for continued employment',
    NULL,
    'alampatatravels.com secondary sourcing', 'https://www.alampatatravels.com/apply-visa/kiribati', '2026-09-19'
);
SET @kir4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kir4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kir4, 'Core Documents', 'Required from every work-permit applicant.', 1);
SET @kir4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kir4s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@kir4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kir4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @kir4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kir4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@kir4s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(184, 4, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Work Permit fees were not independently confirmed this session — verify with Kiribati Immigration.', '2026-01-01', NOW(), 'https://www.alampatatravels.com/apply-visa/kiribati', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a work permit to work in Kiribati?', 'Yes — a separate Work Permit (or Extension of Stay application) is required in addition to entry documentation, applied for by your employer/sponsor.', 184, 4, 18440, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    184, 5, 'KIR-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Kiribati.',
    'Family visitors use the same visa-free, 30-day tourist framework, extendable up to 90 days.',
    'Up to 30 days, extendable to 90 days',
    'No visa needed for a family visit — present passport and onward ticket on arrival',
    0,
    'Not applicable for entry itself.',
    'No Indian mission in Kiribati; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nBook proof of return/onward ticket\nCarry proof of relationship and host contact details\nGather proof of sufficient funds\nApply for an extension of stay locally if needed beyond 30 days',
    NULL,
    'kiribatitourism.gov.ki secondary sourcing', 'https://kiribatitourism.gov.ki/entry-requirements-visa-info', '2026-09-19'
);
SET @kir5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kir5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kir5, 'Core Documents', 'Required from every traveller.', 1);
SET @kir5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kir5s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@kir5s1, 'Confirmed Onward/Return Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kir5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @kir5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kir5s2, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 0, 1),
(@kir5s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(184, 5, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 30-day entry.', '2026-01-01', NOW(), 'https://kiribatitourism.gov.ki/entry-requirements-visa-info', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Kiribati?', 'No — the same visa-free, 30-day framework applies as for tourist travel.', 184, 5, 18450, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    184, 6, 'KIR-TRAN-IN-01', '2026.09', 'published',
    'Transit through Kiribati en route to another destination.',
    'Given Kiribati\'s visa-free tourist entry framework, short transit is expected to be covered by the same visa-free rules — a separate transit visa was not described in sources reviewed this session.',
    'Short transit, within the visa-free framework',
    'No visa needed for short transit — present passport and onward ticket',
    0,
    'Not applicable for entry itself.',
    'No Indian mission in Kiribati; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Confirm your connecting flight and transit time\nConfirm your passport is valid for 6+ months with 2+ blank pages\nCarry your onward boarding pass and passport\nCarry all documents for immigration if clearing customs',
    NULL,
    'kiribatitourism.gov.ki secondary sourcing', 'https://kiribatitourism.gov.ki/entry-requirements-visa-info', '2026-09-19'
);
SET @kir6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kir6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kir6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @kir6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kir6s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@kir6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(184, 6, 0.00, 'USD', 'No Fee for Visa-Free Transit', 'No fee applies within the visa-free tourist framework.', '2026-01-01', NOW(), 'https://kiribatitourism.gov.ki/entry-requirements-visa-info', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Kiribati?', 'No — short transit is expected to be covered by the same visa-free tourist framework as other short visits.', 184, 6, 18460, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    184, 7, 'KIR-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Kiribati.',
    'Medical travellers use the same visa-free, 30-day tourist framework, extendable up to 90 days. Note: Kiribati\'s medical infrastructure is limited — most serious treatment is typically referred overseas; verify facility availability directly.',
    'Up to 30 days, extendable to 90 days',
    'No visa needed — present passport and onward ticket on arrival',
    0,
    'Not applicable for entry itself. Confirm treatment availability directly given Kiribati\'s limited medical infrastructure.',
    'No Indian mission in Kiribati; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Confirm treatment and appointment directly with the Kiribati medical facility\nConfirm your passport is valid for 6+ months with 2+ blank pages\nBook proof of return/onward ticket\nGather proof of sufficient funds\nApply for an extension of stay locally if needed beyond 30 days',
    NULL,
    'kiribatitourism.gov.ki secondary sourcing', 'https://kiribatitourism.gov.ki/entry-requirements-visa-info', '2026-09-19'
);
SET @kir7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kir7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kir7, 'Core Documents', 'Required from every traveller.', 1);
SET @kir7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kir7s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@kir7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kir7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @kir7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kir7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@kir7s2, 'Confirmed Onward/Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(184, 7, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 30-day entry.', '2026-01-01', NOW(), 'https://kiribatitourism.gov.ki/entry-requirements-visa-info', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Kiribati?', 'No separate medical visa — the same visa-free, 30-day framework applies. Given limited local medical infrastructure, confirm treatment availability directly beforehand.', 184, 7, 18470, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    184, 8, 'KIR-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Kiribati.',
    'Conference attendance is treated as a non-tourism purpose, requiring an embassy/immigration visa similar to business travel.',
    'Up to 30 days',
    'Apply for an embassy/immigration visa before travel',
    0,
    'This differs from the visa-free tourist entry — conference/business purposes require a visa applied for in advance.',
    'No Indian mission in Kiribati; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nApply for the Kiribati immigration visa in advance\nCarry conference invitation/registration confirmation\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'passportsandvisas.com secondary sourcing', 'https://www.passportsandvisas.com/visas/kiribati/indian-citizens', '2026-09-19'
);
SET @kir8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kir8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kir8, 'Core Documents', 'Required from every applicant.', 1);
SET @kir8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kir8s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@kir8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kir8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @kir8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kir8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@kir8s2, 'Confirmed Onward/Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(184, 8, 25.00, 'USD', 'Immigration Visa Fee', 'Government fee for the general (non-tourist) immigration visa, up to 30 days.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/kiribati/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Kiribati?', 'Yes — conference/business purposes require an embassy/immigration visa (government fee ~USD 25), unlike the visa-free tourist route.', 184, 8, 18480, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    184, 9, 'KIR-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Kiribati.',
    'Sports travellers use the same visa-free, 30-day tourist framework as tourists.',
    'Up to 30 days, extendable to 90 days',
    'No visa needed — present passport and onward ticket on arrival',
    0,
    'Not applicable for entry itself.',
    'No Indian mission in Kiribati; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nCarry event invitation/participation confirmation\nBook proof of return/onward ticket\nGather proof of sufficient funds\nApply for an extension of stay locally if needed beyond 30 days',
    NULL,
    'kiribatitourism.gov.ki secondary sourcing', 'https://kiribatitourism.gov.ki/entry-requirements-visa-info', '2026-09-19'
);
SET @kir9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kir9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kir9, 'Core Documents', 'Required from every traveller.', 1);
SET @kir9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kir9s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@kir9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kir9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @kir9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kir9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@kir9s2, 'Confirmed Onward/Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(184, 9, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 30-day entry.', '2026-01-01', NOW(), 'https://kiribatitourism.gov.ki/entry-requirements-visa-info', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Kiribati?', 'No — the same visa-free, 30-day framework applies as for tourist travel.', 184, 9, 18490, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    184, 10, 'KIR-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Kiribati Work Permit.',
    'Dependants enter visa-free like other Indian citizens for short visits; longer stays alongside a Work Permit holder are expected to require their own Extension of Stay application.',
    'Tied to the primary permit holder\'s Work Permit validity',
    'Enter visa-free, then file an Extension of Stay if staying alongside a Work Permit holder beyond 30 days',
    1,
    'Not independently confirmed this session: exact dependant extension-of-stay fee and process — verify with Kiribati Immigration.',
    'No Indian mission in Kiribati; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Confirm the primary Work Permit holder\'s status in Kiribati\nGather proof of relationship (marriage/birth certificate)\nEnter Kiribati visa-free (up to 30 days)\nFile for an Extension of Stay if remaining beyond 30 days\nRenew the extension as needed alongside the primary permit holder',
    NULL,
    'alampatatravels.com secondary sourcing', 'https://www.alampatatravels.com/apply-visa/kiribati', '2026-09-19'
);
SET @kir10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kir10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kir10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @kir10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kir10s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@kir10s1, 'Proof of Relationship to Primary Permit Holder', NULL, 'original', 1, 0, 1, 2),
(@kir10s1, 'Primary Permit Holder\'s Work Permit Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kir10, 'Supporting Documents', 'Additional documents for extension of stay.', 2);
SET @kir10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kir10s2, 'Extension of Stay Application', NULL, 'original', 0, 1, 1, 1),
(@kir10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(184, 10, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Extension-of-stay fees for dependants were not independently confirmed this session — verify with Kiribati Immigration.', '2026-01-01', NOW(), 'https://www.alampatatravels.com/apply-visa/kiribati', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do dependants of Work Permit holders need their own extension of stay in Kiribati?', 'Expected to be required for stays beyond 30 days, filed separately from the primary Work Permit holder\'s application — not independently confirmed this session; verify with Kiribati Immigration.', 184, 10, 18400, 1);
