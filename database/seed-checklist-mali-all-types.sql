-- Mali Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Mali's real, distinctive facts verified this session:
--   - CRITICAL SAFETY CAVEAT: multiple governments maintain "Do Not
--     Travel" advisories for Mali due to terrorism, kidnapping, and
--     armed conflict, with a state of emergency in effect. A
--     coordinated series of attacks occurred on 25 April 2026 across
--     Kidal, Gao, Kati, Sevare, and near Bamako International
--     Airport. The Embassy of India, Bamako advises detailed
--     assessment of the situation, in coordination with your host/
--     employer, before any travel.
--   - DISTINCTIVE FRAUD WARNING: the Embassy of India, Bamako has
--     received complaints of Indian nationals being cheated by
--     individuals posing as importers/exporters/businessmen, with
--     fake paper visas sent by email enabling fraudulent travel to
--     Mali — flagged explicitly here as a real, documented scam
--     pattern, not a generic caution.
--   - Indian citizens require a visa, decided wholly by the Embassy of
--     the Republic of Mali, New Delhi. Fee ~USD 50 (government) or
--     INR 5,000-16,600 depending on visa type/source; processing 7-14
--     days. Apply 17+ days before departure.
--   - Visa is issued as a single-entry permit valid 90 days from issue
--     (for entry), with the 30-day stay period beginning on arrival.
--   - Yellow Fever vaccination is mandatory for entry.
--
-- country_id 31 = Mali. visa_type_id: 1=Tourist, 2=Business,
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
    31, 1, 'MLI-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Mali.',
    'IMPORTANT: multiple governments maintain "Do Not Travel" advisories for Mali due to terrorism and armed conflict, including a state of emergency and an April 2026 coordinated attack series. The Embassy of India, Bamako, also warns of fraudsters emailing fake paper visas to Indian nationals.',
    '30 days, within a 90-day single-entry validity window',
    'Apply through the Embassy of the Republic of Mali, New Delhi',
    0,
    'Review the current security advisory before booking. Verify any visa received by email directly with the Embassy — fake paper visas have been reported. Yellow Fever vaccination mandatory. Apply 17+ days before departure.',
    'Embassy of the Republic of Mali, New Delhi',
    'Review the current security advisory for Mali\nConfirm your passport is valid for 6+ months with 2+ blank pages\nApply through the Embassy of the Republic of Mali, New Delhi, 17+ days before travel\nGet the mandatory Yellow Fever vaccination\nVerify any visa received by email directly with the embassy to avoid fraud',
    NULL,
    'mea.gov.in, passportsandvisas.com, and embassyofindiabamako.gov.in secondary sourcing', 'https://www.embassyofindiabamako.gov.in/page/travel-advice/', '2026-09-19'
);
SET @mli1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mli1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mli1, 'Core Documents', 'Required from every applicant.', 1);
SET @mli1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mli1s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@mli1s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mli1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mli1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mli1s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@mli1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(31, 1, 50.00, 'USD', 'Government Visa Fee', 'Agency sourcing cites a wider INR 5,000-16,600 range depending on visa type; only apply through the official Embassy of Mali to avoid the reported email visa fraud pattern.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/mali/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is it safe to travel to Mali right now?', 'No — multiple governments maintain "Do Not Travel" advisories due to terrorism, kidnapping, and armed conflict, with a state of emergency in effect and an April 2026 coordinated attack series. Review the current advisory before booking.', 31, 1, 3100, 1),
('Are there visa scams targeting Indians travelling to Mali?', 'Yes — the Embassy of India, Bamako has received complaints of fraudsters emailing fake paper visas to Indian nationals. Always verify any visa directly with the Embassy of Mali before travelling.', 31, 1, 3101, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    31, 2, 'MLI-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Mali.',
    'IMPORTANT: review the current "Do Not Travel" advisory for Mali. Business travellers, especially those approached by unfamiliar Mali-based "importers/exporters," should be alert to the documented email visa fraud pattern targeting Indians.',
    '30 days, within a 90-day single-entry validity window',
    'Apply through the Embassy of the Republic of Mali, New Delhi',
    0,
    'Verify any business invitation and visa directly with the embassy — fraud targeting Indian businesspeople has been reported. Yellow Fever vaccination mandatory.',
    'Embassy of the Republic of Mali, New Delhi',
    'Review the current security advisory for Mali\nIndependently verify any Mali-based business contact/invitation\nApply through the Embassy of the Republic of Mali, New Delhi\nGet the mandatory Yellow Fever vaccination\nVerify any visa received by email directly with the embassy to avoid fraud',
    NULL,
    'embassyofindiabamako.gov.in secondary sourcing', 'https://www.embassyofindiabamako.gov.in/page/travel-advice/', '2026-09-19'
);
SET @mli2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mli2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mli2, 'Core Documents', 'Required from every applicant.', 1);
SET @mli2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mli2s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@mli2s1, 'Business Invitation Letter (Independently Verified)', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mli2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @mli2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mli2s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 1),
(@mli2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(31, 2, 50.00, 'USD', 'Government Visa Fee', 'Same fee range as the tourist visa; only apply through the official Embassy of Mali.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/mali/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Mali?', 'Yes — apply through the Embassy of the Republic of Mali, New Delhi. Given documented visa fraud targeting Indian businesspeople, independently verify any Mali-based contact and visa.', 31, 2, 3120, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    31, 3, 'MLI-STU-IN-01', '2026.09', 'published',
    'Academic study at a Mali educational institution.',
    'IMPORTANT: review the current "Do Not Travel" advisory before committing to study in Mali. Sources reviewed this session did not describe a dedicated student-visa category distinct from the general embassy visa.',
    'Study-program length',
    'Apply through the Embassy of the Republic of Mali, New Delhi, with a university admission letter',
    1,
    'Review the current security advisory for Mali before committing to study there.',
    'Embassy of the Republic of Mali, New Delhi',
    'Review the current security advisory for Mali\nSecure admission from a Mali educational institution\nApply through the Embassy of the Republic of Mali, New Delhi\nGet the mandatory Yellow Fever vaccination\nVerify any visa received by email directly with the embassy to avoid fraud',
    NULL,
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/in/visas/mali-visa-requirements-documents', '2026-09-19'
);
SET @mli3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mli3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mli3, 'Core Documents', 'Required from every applicant.', 1);
SET @mli3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mli3s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@mli3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mli3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @mli3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mli3s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 1),
(@mli3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(31, 3, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/mali-visa-requirements-documents', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should Indian students study in Mali given the current situation?', 'Multiple governments maintain "Do Not Travel" advisories for Mali — this should be weighed very heavily before committing to study there.', 31, 3, 3130, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    31, 4, 'MLI-WORK-IN-01', '2026.09', 'published',
    'Employment in Mali under a local employer.',
    'IMPORTANT: review the current "Do Not Travel" advisory before accepting employment in Mali. Work-related visas are cited at the higher end of the fee range (up to INR 16,600).',
    'Per work-visa validity',
    'Employer sponsors your work-visa application through the Embassy of the Republic of Mali, New Delhi',
    1,
    'Independently verify your employer/sponsor given documented fraud targeting Indians travelling to Mali.',
    'Embassy of the Republic of Mali, New Delhi',
    'Review the current security advisory for Mali\nIndependently verify your Mali-based employer/sponsor\nApply through the Embassy of the Republic of Mali, New Delhi\nGet the mandatory Yellow Fever vaccination\nVerify any visa received by email directly with the embassy to avoid fraud',
    NULL,
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/in/visas/mali-visa-requirements-documents', '2026-09-19'
);
SET @mli4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mli4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mli4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @mli4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mli4s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@mli4s1, 'Employment Contract/Sponsorship Letter (Independently Verified)', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mli4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @mli4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mli4s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 1),
(@mli4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(31, 4, 16600.00, 'INR', 'Work Visa Fee (Upper Range, Indicative)', 'Sources cite a wider INR 5,000-16,600 range across visa types, with work visas at the higher end.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/mali-visa-requirements-documents', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is it safe to work in Mali right now?', 'Multiple governments maintain "Do Not Travel" advisories for Mali due to terrorism and armed conflict — this should be weighed very heavily, and any employer/sponsor should be independently verified given documented fraud targeting Indians.', 31, 4, 3140, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    31, 5, 'MLI-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Mali.',
    'IMPORTANT: multiple governments maintain "Do Not Travel" advisories for Mali. Family visitors use the same embassy-visa framework as tourists.',
    '30 days, within a 90-day single-entry validity window',
    'Apply through the Embassy of the Republic of Mali, New Delhi',
    0,
    'Review the current security advisory before booking. Yellow Fever vaccination mandatory.',
    'Embassy of the Republic of Mali, New Delhi',
    'Review the current security advisory for Mali\nConfirm your passport is valid for 6+ months with 2+ blank pages\nApply through the Embassy of the Republic of Mali, New Delhi\nGet the mandatory Yellow Fever vaccination\nVerify any visa received by email directly with the embassy to avoid fraud',
    NULL,
    'embassyofindiabamako.gov.in secondary sourcing', 'https://www.embassyofindiabamako.gov.in/page/travel-advice/', '2026-09-19'
);
SET @mli5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mli5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mli5, 'Core Documents', 'Required from every applicant.', 1);
SET @mli5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mli5s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@mli5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mli5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mli5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mli5s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 1),
(@mli5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(31, 5, 50.00, 'USD', 'Government Visa Fee', 'Same fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/mali/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Mali?', 'Yes — the same embassy-visa framework applies. Given the current "Do Not Travel" advisory, review current conditions carefully.', 31, 5, 3150, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    31, 6, 'MLI-TRAN-IN-01', '2026.09', 'published',
    'Transit through Mali en route to another destination.',
    'IMPORTANT: given "Do Not Travel" advisories including near Bamako International Airport itself (site of an April 2026 attack), transit through Mali should be avoided wherever an alternative routing exists.',
    'Short transit only',
    'Apply through the Embassy of the Republic of Mali, New Delhi, in advance if clearing immigration',
    0,
    'Review the current security advisory for Mali, including risks at Bamako airport itself.',
    'Embassy of the Republic of Mali, New Delhi',
    'Review the current security advisory for Mali\nSeek alternative routing avoiding Mali wherever possible\nConfirm your connecting flight and transit time\nApply for the visa in advance if there is any possibility of clearing immigration\nCarry your onward boarding pass and passport',
    NULL,
    'embassyofindiabamako.gov.in secondary sourcing (transit exemption not independently confirmed)', 'https://www.embassyofindiabamako.gov.in/page/travel-advice/', '2026-09-19'
);
SET @mli6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mli6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mli6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @mli6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mli6s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@mli6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(31, 6, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Transit visa fee was not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.embassyofindiabamako.gov.in/page/travel-advice/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should Indian citizens transit through Mali?', 'Given "Do Not Travel" advisories, including risks near Bamako International Airport itself, seek alternative routing avoiding Mali wherever possible.', 31, 6, 3160, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    31, 7, 'MLI-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Mali.',
    'IMPORTANT: multiple governments maintain "Do Not Travel" advisories for Mali. Mali is not a typical inbound medical-travel destination given the security and infrastructure situation.',
    '30 days, within a 90-day single-entry validity window',
    'Apply through the Embassy of the Republic of Mali, New Delhi',
    0,
    'Review the current security advisory for Mali. Verify treatment facility availability and safety directly.',
    'Embassy of the Republic of Mali, New Delhi',
    'Review the current security advisory for Mali\nConfirm treatment and appointment directly with the Mali medical facility\nApply through the Embassy of the Republic of Mali, New Delhi\nGet the mandatory Yellow Fever vaccination\nVerify any visa received by email directly with the embassy to avoid fraud',
    NULL,
    'embassyofindiabamako.gov.in secondary sourcing', 'https://www.embassyofindiabamako.gov.in/page/travel-advice/', '2026-09-19'
);
SET @mli7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mli7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mli7, 'Core Documents', 'Required from every applicant.', 1);
SET @mli7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mli7s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@mli7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mli7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mli7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mli7s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 1),
(@mli7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(31, 7, 50.00, 'USD', 'Government Visa Fee', 'Same fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/mali/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Mali?', 'No separate medical visa — the same embassy-visa framework applies. Given the current advisory, this is not a recommended destination for medical travel.', 31, 7, 3170, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    31, 8, 'MLI-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Mali.',
    'IMPORTANT: multiple governments maintain "Do Not Travel" advisories for Mali. Conference attendees use the same embassy-visa framework as business travellers.',
    '30 days, within a 90-day single-entry validity window',
    'Apply through the Embassy of the Republic of Mali, New Delhi',
    0,
    'Review the current security advisory before booking.',
    'Embassy of the Republic of Mali, New Delhi',
    'Review the current security advisory for Mali\nCarry conference invitation/registration confirmation\nApply through the Embassy of the Republic of Mali, New Delhi\nGet the mandatory Yellow Fever vaccination\nVerify any visa received by email directly with the embassy to avoid fraud',
    NULL,
    'embassyofindiabamako.gov.in secondary sourcing', 'https://www.embassyofindiabamako.gov.in/page/travel-advice/', '2026-09-19'
);
SET @mli8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mli8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mli8, 'Core Documents', 'Required from every applicant.', 1);
SET @mli8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mli8s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@mli8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mli8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mli8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mli8s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 1),
(@mli8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(31, 8, 50.00, 'USD', 'Government Visa Fee', 'Same fee range as the business visa applies.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/mali/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Mali?', 'No separate conference visa — the same embassy-visa framework applies. Given the current advisory, reconsider necessity before booking.', 31, 8, 3180, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    31, 9, 'MLI-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Mali.',
    'IMPORTANT: multiple governments maintain "Do Not Travel" advisories for Mali. Sports travellers use the same embassy-visa framework as tourists.',
    '30 days, within a 90-day single-entry validity window',
    'Apply through the Embassy of the Republic of Mali, New Delhi',
    0,
    'Review the current security advisory before booking.',
    'Embassy of the Republic of Mali, New Delhi',
    'Review the current security advisory for Mali\nCarry event invitation/participation confirmation\nApply through the Embassy of the Republic of Mali, New Delhi\nGet the mandatory Yellow Fever vaccination\nVerify any visa received by email directly with the embassy to avoid fraud',
    NULL,
    'embassyofindiabamako.gov.in secondary sourcing', 'https://www.embassyofindiabamako.gov.in/page/travel-advice/', '2026-09-19'
);
SET @mli9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mli9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mli9, 'Core Documents', 'Required from every applicant.', 1);
SET @mli9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mli9s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@mli9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mli9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mli9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mli9s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 1),
(@mli9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(31, 9, 50.00, 'USD', 'Government Visa Fee', 'Same fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/mali/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Mali?', 'No separate sports visa — the same embassy-visa framework applies. Given the current advisory, reconsider necessity before booking.', 31, 9, 3190, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    31, 10, 'MLI-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Mali work/residence visa.',
    'IMPORTANT: multiple governments maintain "Do Not Travel" advisories for Mali, which should weigh heavily on whether dependants join a primary permit holder there at all.',
    'Tied to the primary permit holder\'s visa validity',
    'Apply through the Embassy of the Republic of Mali, New Delhi, referencing the primary permit holder\'s status',
    1,
    'Review the current security advisory for Mali before proceeding.',
    'Embassy of the Republic of Mali, New Delhi',
    'Review the current security advisory for Mali\nConfirm the primary permit holder\'s visa status\nGather proof of relationship (marriage/birth certificate)\nApply through the Embassy of the Republic of Mali, New Delhi\nGet the mandatory Yellow Fever vaccination',
    NULL,
    'embassyofindiabamako.gov.in secondary sourcing', 'https://www.embassyofindiabamako.gov.in/page/travel-advice/', '2026-09-19'
);
SET @mli10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mli10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mli10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @mli10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mli10s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@mli10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@mli10s1, 'Primary Permit Holder\'s Visa Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mli10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @mli10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mli10s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 1),
(@mli10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(31, 10, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.embassyofindiabamako.gov.in/page/travel-advice/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should dependants join a work-visa holder in Mali?', 'Given "Do Not Travel" advisories, this should be very carefully reconsidered before proceeding.', 31, 10, 3100, 1);
