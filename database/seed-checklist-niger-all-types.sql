-- Niger Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Niger's real, distinctive facts verified this session:
--   - CRITICAL SAFETY CAVEAT: the Government of India's MEA advisory
--     urges Indian nationals in Niger to leave as soon as possible and
--     asks those planning travel to reconsider — a real, documented
--     incident saw five Indian nationals kidnapped after their convoy
--     was ambushed in the Tillaberi region. Niger's airspace has been
--     closed at times; departure via land border requires extreme
--     caution. The US similarly maintains a Level 4 "Do Not Travel"
--     advisory (Dec 2025) citing terrorism, kidnapping, crime, and
--     civil unrest, with a state of emergency and movement
--     restrictions in many regions.
--   - Sourcing conflict flagged rather than silently resolved: one
--     source states all Indian citizens require a visa stamped before
--     departure (with a narrow "flyer visa" pre-approval exception via
--     Niger's National Police, collected at Niamey airport after
--     mandatory next-day registration with the Director General of
--     Immigration); another describes straightforward visa-free entry
--     for 30-90 days. The visa-required route is used as primary
--     since it is more specifically documented, with the conflict
--     flagged.
--   - No eVisa exists for Indian citizens — apply at the Embassy of
--     Niger, New Delhi, or via the flyer-visa pre-approval process.
--   - Mandatory Yellow Fever vaccination for all travellers over 9
--     months old.
--
-- country_id 37 = Niger. visa_type_id: 1=Tourist, 2=Business,
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
    37, 1, 'NER-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Niger.',
    'IMPORTANT: the Government of India urges Indian nationals in Niger to leave as soon as possible and asks those planning travel to reconsider, following a documented kidnapping of five Indian nationals in the Tillaberi region. Separately, sources disagree on visa-free vs. visa-required entry — the visa-required route (with a narrow pre-approved flyer-visa exception) is used as primary here.',
    'Per visa validity',
    'Apply through the Embassy of Niger, New Delhi, or obtain pre-approval for the flyer visa at Niamey airport',
    0,
    'Review the current MEA travel advisory for Niger before booking. Mandatory Yellow Fever vaccination. Processing 2-3 days for embassy visas.',
    'Embassy of Niger, New Delhi; Embassy of India, Niamey',
    'Review the current MEA travel advisory for Niger\nConfirm your passport is valid for 6+ months\nGet the mandatory Yellow Fever vaccination\nApply through the Embassy of Niger, New Delhi, or obtain flyer-visa pre-approval\nRegister with the Embassy of India, Niamey, if travelling despite the advisory',
    '/assets/images/visa-heroes/niger.webp',
    'mea.gov.in, btwvisas.com, and visitworld.today secondary sourcing', 'https://www.india.com/news/world/mea-advisory-urges-indian-citizens-to-leave-violence-torn-niger-as-soon-as-possible-6222996/', '2026-09-19'
);
SET @ner1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ner1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ner1, 'Core Documents', 'Required from every applicant.', 1);
SET @ner1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ner1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ner1s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ner1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @ner1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ner1s2, 'Approved Visa or Flyer-Visa Pre-Approval', NULL, 'copy', 1, 0, 0, 1),
(@ner1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(37, 1, 7350.00, 'INR', 'Single-Entry Visa Fee (3 Months)', 'Multiple-entry (3 months) costs INR 10,160. Sourcing conflict flagged: some sources describe visa-free 30-90 day entry instead — verify current status directly given the fast-changing security and policy situation.', '2026-01-01', NOW(), 'https://indembniamey.gov.in/pages/Mjk,', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is it safe to travel to Niger right now?', 'No — the Government of India urges Indian nationals in Niger to leave as soon as possible and asks those planning travel to reconsider, following a documented kidnapping of five Indian nationals. Check the latest MEA advisory before booking.', 37, 1, 3700, 1),
('Do Indian citizens need a visa for Niger?', 'Sources disagree — one describes mandatory visa (with a narrow flyer-visa pre-approval exception), another describes visa-free entry. Given the fast-changing situation, verify current requirements directly with the Embassy of Niger, New Delhi.', 37, 1, 3701, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    37, 2, 'NER-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Niger.',
    'IMPORTANT: review the current MEA travel advisory before booking business travel to Niger. Business travellers use the same visa framework as tourists.',
    'Per visa validity',
    'Apply through the Embassy of Niger, New Delhi, or obtain pre-approval for the flyer visa at Niamey airport',
    0,
    'Review the current MEA travel advisory for Niger before booking. Mandatory Yellow Fever vaccination.',
    'Embassy of Niger, New Delhi; Embassy of India, Niamey',
    'Review the current MEA travel advisory for Niger\nGet the mandatory Yellow Fever vaccination\nApply through the Embassy of Niger, New Delhi, or obtain flyer-visa pre-approval\nCarry a business invitation letter from the host organization\nRegister with the Embassy of India, Niamey, if travelling despite the advisory',
    '/assets/images/visa-heroes/niger.webp',
    'mea.gov.in secondary sourcing', 'https://www.india.com/news/world/mea-advisory-urges-indian-citizens-to-leave-violence-torn-niger-as-soon-as-possible-6222996/', '2026-09-19'
);
SET @ner2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ner2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ner2, 'Core Documents', 'Required from every applicant.', 1);
SET @ner2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ner2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ner2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ner2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @ner2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ner2s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 1),
(@ner2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(37, 2, 7350.00, 'INR', 'Single-Entry Visa Fee (3 Months)', 'Same fee range as the tourist visa applies; multiple-entry (3 months) costs INR 10,160.', '2026-01-01', NOW(), 'https://indembniamey.gov.in/pages/Mjk,', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Niger?', 'Yes, per the primary sourcing used here — apply through the Embassy of Niger, New Delhi. Review the current MEA travel advisory before travelling.', 37, 2, 3720, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    37, 3, 'NER-STU-IN-01', '2026.09', 'published',
    'Academic study at a Niger educational institution.',
    'IMPORTANT: review the current MEA travel advisory before committing to study in Niger. Sources reviewed this session did not describe a dedicated student-visa category distinct from the general embassy visa.',
    'Study-program length',
    'Apply through the Embassy of Niger, New Delhi, with a university admission letter',
    1,
    'Review the current MEA travel advisory for Niger before committing to study there.',
    'Embassy of Niger, New Delhi; Embassy of India, Niamey',
    'Review the current MEA travel advisory for Niger\nSecure admission from a Niger educational institution\nGet the mandatory Yellow Fever vaccination\nApply through the Embassy of Niger, New Delhi\nRegister with the Embassy of India, Niamey',
    '/assets/images/visa-heroes/niger.webp',
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/niger-visa/', '2026-09-19'
);
SET @ner3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ner3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ner3, 'Core Documents', 'Required from every applicant.', 1);
SET @ner3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ner3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ner3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ner3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @ner3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ner3s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 1),
(@ner3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(37, 3, 0.00, 'INR', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/niger-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should Indian students study in Niger given the current situation?', 'The Government of India urges Indians in Niger to leave and advises against travel — this should be weighed very heavily before committing to study there.', 37, 3, 3730, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    37, 4, 'NER-WORK-IN-01', '2026.09', 'published',
    'Employment in Niger under a local employer.',
    'IMPORTANT: review the current MEA travel advisory before accepting employment in Niger. Tourist visas do not permit employment — a work visa/permit requires sponsorship from a Nigerien employer.',
    'Per work-permit validity',
    'Employer sponsors your work-visa application through the Embassy of Niger, New Delhi',
    1,
    'Review the current MEA travel advisory for Niger. Not independently confirmed this session: exact work-visa fee.',
    'Embassy of Niger, New Delhi; Embassy of India, Niamey',
    'Review the current MEA travel advisory for Niger\nSecure a job offer from a Nigerien employer\nGet the mandatory Yellow Fever vaccination\nApply through the Embassy of Niger, New Delhi\nRegister with the Embassy of India, Niamey',
    '/assets/images/visa-heroes/niger.webp',
    'visitworld.today secondary sourcing', 'https://visitworld.today/niger/india-citizenship/travel', '2026-09-19'
);
SET @ner4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ner4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ner4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @ner4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ner4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ner4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ner4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @ner4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ner4s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 1),
(@ner4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(37, 4, 0.00, 'INR', 'Fee Not Independently Confirmed', 'Work visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://visitworld.today/niger/india-citizenship/travel', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Niger on a tourist visa?', 'No — tourist visas do not permit employment. A work visa/permit sponsored by a Nigerien employer is required.', 37, 4, 3740, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    37, 5, 'NER-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Niger.',
    'IMPORTANT: the Government of India urges Indians in Niger to leave and advises against travel. Family visitors use the same visa framework as tourists.',
    'Per visa validity',
    'Apply through the Embassy of Niger, New Delhi, or obtain pre-approval for the flyer visa at Niamey airport',
    0,
    'Review the current MEA travel advisory for Niger before booking.',
    'Embassy of Niger, New Delhi; Embassy of India, Niamey',
    'Review the current MEA travel advisory for Niger\nGet the mandatory Yellow Fever vaccination\nApply through the Embassy of Niger, New Delhi\nCarry proof of relationship and host contact details\nRegister with the Embassy of India, Niamey, if travelling despite the advisory',
    '/assets/images/visa-heroes/niger.webp',
    'mea.gov.in secondary sourcing', 'https://www.india.com/news/world/mea-advisory-urges-indian-citizens-to-leave-violence-torn-niger-as-soon-as-possible-6222996/', '2026-09-19'
);
SET @ner5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ner5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ner5, 'Core Documents', 'Required from every applicant.', 1);
SET @ner5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ner5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ner5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ner5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @ner5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ner5s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 1),
(@ner5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(37, 5, 7350.00, 'INR', 'Single-Entry Visa Fee (3 Months)', 'Same fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://indembniamey.gov.in/pages/Mjk,', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Niger?', 'Yes, per the primary sourcing used here. Given the current MEA advisory urging Indians in Niger to leave, review current conditions very carefully.', 37, 5, 3750, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    37, 6, 'NER-TRAN-IN-01', '2026.09', 'published',
    'Transit through Niger en route to another destination.',
    'IMPORTANT: given Niger\'s airspace closures and the MEA advisory urging Indians to leave the country, transit through Niger should be avoided wherever an alternative routing exists.',
    'Short transit only',
    'Apply through the Embassy of Niger, New Delhi, in advance if there is any possibility of clearing immigration',
    0,
    'Review the current MEA travel advisory for Niger, including reports of airspace closures.',
    'Embassy of Niger, New Delhi; Embassy of India, Niamey',
    'Review the current MEA travel advisory for Niger, including airspace status\nSeek alternative routing avoiding Niger wherever possible\nConfirm your connecting flight and transit time\nApply for the visa in advance if there is any possibility of clearing immigration\nCarry your onward boarding pass and passport',
    '/assets/images/visa-heroes/niger.webp',
    'mea.gov.in secondary sourcing (transit exemption not independently confirmed)', 'https://www.india.com/news/world/mea-advisory-urges-indian-citizens-to-leave-violence-torn-niger-as-soon-as-possible-6222996/', '2026-09-19'
);
SET @ner6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ner6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ner6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @ner6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ner6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ner6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(37, 6, 0.00, 'INR', 'Fee Not Independently Confirmed', 'Transit visa fee was not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.india.com/news/world/mea-advisory-urges-indian-citizens-to-leave-violence-torn-niger-as-soon-as-possible-6222996/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should Indian citizens transit through Niger?', 'Given reported airspace closures and the MEA advisory urging Indians to leave Niger, seek alternative routing avoiding Niger wherever possible.', 37, 6, 3760, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    37, 7, 'NER-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Niger.',
    'IMPORTANT: the Government of India urges Indians in Niger to leave and advises against travel. Niger is not a typical destination for inbound medical travel given the security and infrastructure situation.',
    'Per visa validity',
    'Apply through the Embassy of Niger, New Delhi',
    0,
    'Review the current MEA travel advisory for Niger. Verify treatment facility availability and safety directly.',
    'Embassy of Niger, New Delhi; Embassy of India, Niamey',
    'Review the current MEA travel advisory for Niger\nConfirm treatment and appointment directly with the Niger medical facility\nGet the mandatory Yellow Fever vaccination\nApply through the Embassy of Niger, New Delhi\nRegister with the Embassy of India, Niamey',
    '/assets/images/visa-heroes/niger.webp',
    'mea.gov.in secondary sourcing', 'https://www.india.com/news/world/mea-advisory-urges-indian-citizens-to-leave-violence-torn-niger-as-soon-as-possible-6222996/', '2026-09-19'
);
SET @ner7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ner7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ner7, 'Core Documents', 'Required from every applicant.', 1);
SET @ner7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ner7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ner7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ner7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @ner7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ner7s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 1),
(@ner7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(37, 7, 7350.00, 'INR', 'Single-Entry Visa Fee (3 Months)', 'Same fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://indembniamey.gov.in/pages/Mjk,', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Niger?', 'No separate medical visa per the primary sourcing used here. Given the current advisory, this is not a recommended destination for medical travel.', 37, 7, 3770, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    37, 8, 'NER-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Niger.',
    'IMPORTANT: the Government of India urges Indians in Niger to leave and advises against travel. Conference attendees use the same visa framework as business travellers.',
    'Per visa validity',
    'Apply through the Embassy of Niger, New Delhi',
    0,
    'Review the current MEA travel advisory for Niger before booking.',
    'Embassy of Niger, New Delhi; Embassy of India, Niamey',
    'Review the current MEA travel advisory for Niger\nCarry conference invitation/registration confirmation\nGet the mandatory Yellow Fever vaccination\nApply through the Embassy of Niger, New Delhi\nRegister with the Embassy of India, Niamey',
    '/assets/images/visa-heroes/niger.webp',
    'mea.gov.in secondary sourcing', 'https://www.india.com/news/world/mea-advisory-urges-indian-citizens-to-leave-violence-torn-niger-as-soon-as-possible-6222996/', '2026-09-19'
);
SET @ner8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ner8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ner8, 'Core Documents', 'Required from every applicant.', 1);
SET @ner8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ner8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ner8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ner8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @ner8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ner8s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 1),
(@ner8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(37, 8, 7350.00, 'INR', 'Single-Entry Visa Fee (3 Months)', 'Same fee range as the business visa applies.', '2026-01-01', NOW(), 'https://indembniamey.gov.in/pages/Mjk,', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Niger?', 'No separate conference visa per the primary sourcing used here. Given the current MEA advisory, reconsider necessity before booking.', 37, 8, 3780, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    37, 9, 'NER-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Niger.',
    'IMPORTANT: the Government of India urges Indians in Niger to leave and advises against travel. Sports travellers use the same visa framework as tourists.',
    'Per visa validity',
    'Apply through the Embassy of Niger, New Delhi',
    0,
    'Review the current MEA travel advisory for Niger before booking.',
    'Embassy of Niger, New Delhi; Embassy of India, Niamey',
    'Review the current MEA travel advisory for Niger\nCarry event invitation/participation confirmation\nGet the mandatory Yellow Fever vaccination\nApply through the Embassy of Niger, New Delhi\nRegister with the Embassy of India, Niamey',
    '/assets/images/visa-heroes/niger.webp',
    'mea.gov.in secondary sourcing', 'https://www.india.com/news/world/mea-advisory-urges-indian-citizens-to-leave-violence-torn-niger-as-soon-as-possible-6222996/', '2026-09-19'
);
SET @ner9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ner9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ner9, 'Core Documents', 'Required from every applicant.', 1);
SET @ner9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ner9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ner9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ner9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @ner9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ner9s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 1),
(@ner9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(37, 9, 7350.00, 'INR', 'Single-Entry Visa Fee (3 Months)', 'Same fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://indembniamey.gov.in/pages/Mjk,', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Niger?', 'No separate sports visa per the primary sourcing used here. Given the current MEA advisory, reconsider necessity before booking.', 37, 9, 3790, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    37, 10, 'NER-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Niger work/residence visa.',
    'IMPORTANT: the MEA advisory urges Indians in Niger to leave, which should weigh heavily on whether dependants join a primary permit holder there at all.',
    'Tied to the primary permit holder\'s visa validity',
    'Apply through the Embassy of Niger, New Delhi, referencing the primary permit holder\'s status',
    1,
    'Review the current MEA travel advisory for Niger before proceeding.',
    'Embassy of Niger, New Delhi; Embassy of India, Niamey',
    'Review the current MEA travel advisory for Niger\nConfirm the primary permit holder\'s visa status\nGather proof of relationship (marriage/birth certificate)\nGet the mandatory Yellow Fever vaccination\nApply through the Embassy of Niger, New Delhi',
    '/assets/images/visa-heroes/niger.webp',
    'mea.gov.in secondary sourcing', 'https://www.india.com/news/world/mea-advisory-urges-indian-citizens-to-leave-violence-torn-niger-as-soon-as-possible-6222996/', '2026-09-19'
);
SET @ner10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ner10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ner10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @ner10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ner10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ner10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@ner10s1, 'Primary Permit Holder\'s Visa Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ner10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @ner10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ner10s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 1),
(@ner10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(37, 10, 0.00, 'INR', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.india.com/news/world/mea-advisory-urges-indian-citizens-to-leave-violence-torn-niger-as-soon-as-possible-6222996/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should dependants join a work-visa holder in Niger?', 'Given the MEA advisory urging Indians in Niger to leave, this should be very carefully reconsidered before proceeding.', 37, 10, 3700, 1);
