-- Madagascar Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search.
--
-- Madagascar's real, distinctive facts verified this session:
--   - All Indian passport holders require a visa for Madagascar —
--     unlike some African destinations, there is no visa-free entry.
--   - Three application routes: an eVisa ("Electronic Landing
--     Authorization," 15 or 30-day options, applied online in
--     advance), Visa on Arrival at Madagascar airports, or an Embassy
--     visa via the Embassy of Madagascar, New Delhi.
--   - Distinctive inverted VOA pricing: the 30-day VOA is free, while
--     the shorter 15-day-or-less VOA carries a small EUR 10
--     administrative fee — the longer stay costs less than the
--     shorter one.
--   - Madagascar maintains two diplomatic missions in India: the
--     Embassy in New Delhi (A-81 Ground Floor, Mayfair Gardens, August
--     Kranti Marg) and a Consulate in Mumbai (Dossa Mansion, Sir P.M.
--     Road).
--   - Distinct Student and long-stay (work/relocation) visa
--     categories exist, with student-visa validity tied to the
--     course/degree duration.
--
-- country_id 29 = Madagascar. visa_type_id: 1=Tourist, 2=Business,
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
    29, 1, 'MDG-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Madagascar.',
    'All Indian passport holders require a visa for Madagascar. Three routes: eVisa (15 or 30 days), Visa on Arrival, or an Embassy visa via New Delhi.',
    '15 or 30 days',
    'Apply online for the eVisa in advance, obtain a Visa on Arrival, or apply via the Embassy of Madagascar, New Delhi',
    0,
    'The 30-day VOA is free; the 15-day-or-less VOA carries a EUR 10 administrative fee — the longer stay costs less.',
    'Embassy of Madagascar, New Delhi; Consulate of Madagascar, Mumbai',
    'Confirm your passport is valid for 6+ months\nApply online for the eVisa, or plan for VOA at the airport\nSelect the 30-day option to avoid the EUR 10 VOA fee if staying longer\nGather proof of accommodation and sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'evisa-madagascar.it.com and btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/madagascar-tourist-visa/', '2026-09-19'
);
SET @mdg1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mdg1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mdg1, 'Core Documents', 'Required from every applicant.', 1);
SET @mdg1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mdg1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mdg1s1, 'Approved eVisa or VOA/Embassy Visa', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mdg1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mdg1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mdg1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 1),
(@mdg1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(29, 1, 0.00, 'EUR', '30-Day VOA/eVisa Fee (Free)', 'The 15-day-or-less VOA carries a EUR 10 fee instead. Some agency sourcing cites a USD 35 eVisa fee for certain durations — verify current pricing before travel.', '2026-01-01', NOW(), 'https://evisa-madagascar.it.com/madagascar-visa-for-indian-citizens/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Madagascar?', 'Yes — unlike some African destinations, Madagascar does not offer visa-free entry. Choose from an eVisa, Visa on Arrival, or Embassy visa.', 29, 1, 2900, 1),
('Is the shorter Madagascar visa cheaper than the longer one?', 'No — unusually, the 30-day VOA is free while the 15-day-or-less VOA carries a EUR 10 administrative fee. The longer stay actually costs less.', 29, 1, 2901, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    29, 2, 'MDG-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Madagascar.',
    'Business travellers use the same eVisa/VOA/embassy framework as tourists, with a business invitation letter as additional support.',
    '15 or 30 days',
    'Apply online for the eVisa in advance, obtain a Visa on Arrival, or apply via the Embassy of Madagascar, New Delhi',
    0,
    'Same VOA fee structure as the tourist visa applies.',
    'Embassy of Madagascar, New Delhi; Consulate of Madagascar, Mumbai',
    'Confirm your passport is valid for 6+ months\nApply online for the eVisa, or plan for VOA at the airport\nCarry a business invitation letter from the host organization\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/in/visas/types-of-madagascar-visa', '2026-09-19'
);
SET @mdg2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mdg2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mdg2, 'Core Documents', 'Required from every applicant.', 1);
SET @mdg2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mdg2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mdg2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mdg2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @mdg2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mdg2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@mdg2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(29, 2, 0.00, 'EUR', '30-Day VOA/eVisa Fee (Free)', 'Same fee structure as the tourist visa applies.', '2026-01-01', NOW(), 'https://evisa-madagascar.it.com/madagascar-visa-for-indian-citizens/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Madagascar?', 'Yes — the same eVisa/VOA/embassy framework applies, with a business invitation letter recommended.', 29, 2, 2920, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    29, 3, 'MDG-STU-IN-01', '2026.09', 'published',
    'Academic study at a Madagascar educational institution.',
    'A distinct student-visa category exists for Indians pursuing higher education or research in Madagascar, with validity tied to the course/degree duration.',
    'Course/degree duration',
    'Apply through the Embassy of Madagascar, New Delhi, with an admission letter',
    1,
    'Not independently confirmed this session: exact student-visa fee.',
    'Embassy of Madagascar, New Delhi',
    'Confirm admission with a Madagascar educational institution\nGather admission letter, financial proof, and passport-size photos\nApply through the Embassy of Madagascar, New Delhi\nRegister with local authorities after arrival\nRenew your visa as required for continued study',
    NULL,
    'akbartravels.com and visahq.com secondary sourcing', 'https://www.akbartravels.com/in/visas/types-of-madagascar-visa', '2026-09-19'
);
SET @mdg3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mdg3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mdg3, 'Core Documents', 'Required from every applicant.', 1);
SET @mdg3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mdg3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mdg3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mdg3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @mdg3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mdg3s2, 'Financial Proof', NULL, 'copy', 1, 0, 0, 1),
(@mdg3s2, 'Passport-Size Photographs', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(29, 3, 0.00, 'EUR', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session — verify with the Embassy of Madagascar, New Delhi.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/types-of-madagascar-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for Madagascar?', 'Yes — Indian students pursuing higher education or research can apply for a student visa, with validity tied to the course/degree duration.', 29, 3, 2930, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    29, 4, 'MDG-WORK-IN-01', '2026.09', 'published',
    'Employment in Madagascar under a local employer.',
    'A distinct long-stay visa category covers extended residence, work, or relocation, sponsored by a local employer.',
    'Per long-stay visa validity, renewable',
    'Employer sponsors your long-stay visa application through the Embassy of Madagascar, New Delhi',
    1,
    'Not independently confirmed this session: exact work-visa fee and local work-permit process.',
    'Embassy of Madagascar, New Delhi',
    'Secure a job offer from a Madagascar employer\nEmployer sponsors your long-stay visa application\nApply through the Embassy of Madagascar, New Delhi\nRegister with local authorities on arrival\nRenew your visa as required for continued employment',
    NULL,
    'itzeazy.in secondary sourcing', 'https://itzeazy.in/blog/2026/03/13/madagascar-visa-for-indian/', '2026-09-19'
);
SET @mdg4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mdg4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mdg4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @mdg4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mdg4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mdg4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mdg4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @mdg4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mdg4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@mdg4s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(29, 4, 0.00, 'EUR', 'Fee Not Independently Confirmed', 'Work/long-stay visa fees were not independently confirmed this session — verify with the Embassy of Madagascar, New Delhi.', '2026-01-01', NOW(), 'https://itzeazy.in/blog/2026/03/13/madagascar-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What does an Indian citizen need to work in Madagascar?', 'A long-stay visa sponsored by your employer, applied for through the Embassy of Madagascar, New Delhi.', 29, 4, 2940, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    29, 5, 'MDG-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Madagascar.',
    'Family visitors use the same eVisa/VOA/embassy framework as tourists.',
    '15 or 30 days',
    'Apply online for the eVisa in advance, obtain a Visa on Arrival, or apply via the Embassy of Madagascar, New Delhi',
    0,
    'Same VOA fee structure as the tourist visa applies.',
    'Embassy of Madagascar, New Delhi; Consulate of Madagascar, Mumbai',
    'Confirm your passport is valid for 6+ months\nApply online for the eVisa, or plan for VOA at the airport\nCarry proof of relationship and host contact details\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'evisa-madagascar.it.com secondary sourcing', 'https://evisa-madagascar.it.com/madagascar-visa-for-indian-citizens/', '2026-09-19'
);
SET @mdg5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mdg5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mdg5, 'Core Documents', 'Required from every applicant.', 1);
SET @mdg5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mdg5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mdg5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mdg5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mdg5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mdg5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 1),
(@mdg5s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(29, 5, 0.00, 'EUR', '30-Day VOA/eVisa Fee (Free)', 'Same fee structure as the tourist visa applies.', '2026-01-01', NOW(), 'https://evisa-madagascar.it.com/madagascar-visa-for-indian-citizens/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Madagascar?', 'Yes — the same eVisa/VOA/embassy framework applies as for tourist travel.', 29, 5, 2950, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    29, 6, 'MDG-TRAN-IN-01', '2026.09', 'published',
    'Transit through Madagascar en route to another destination.',
    'Madagascar offers transit visas as one of its recognized visa categories alongside tourist, business, and student visas.',
    'Short transit only',
    'Apply for a transit visa in advance if clearing immigration',
    0,
    'Not independently confirmed this session whether airside-only transit is exempt — verify with your airline.',
    'Embassy of Madagascar, New Delhi',
    'Confirm your connecting flight and transit time\nApply for a transit visa in advance if there is any possibility of clearing immigration\nCarry your onward boarding pass and passport\nConfirm airside-only transit exemptions directly with your airline',
    NULL,
    'akbartravels.com secondary sourcing (transit exemption not independently confirmed)', 'https://www.akbartravels.com/in/visas/types-of-madagascar-visa', '2026-09-19'
);
SET @mdg6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mdg6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mdg6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @mdg6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mdg6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mdg6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(29, 6, 0.00, 'EUR', 'Fee Not Independently Confirmed', 'Transit visa fee was not independently confirmed this session — verify with the Embassy of Madagascar, New Delhi.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/types-of-madagascar-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Madagascar?', 'Madagascar recognizes transit as a distinct visa category — apply in advance if there is any possibility of clearing immigration.', 29, 6, 2960, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    29, 7, 'MDG-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Madagascar.',
    'Medical travellers use the same eVisa/VOA/embassy framework as tourists.',
    '15 or 30 days',
    'Apply online for the eVisa in advance, obtain a Visa on Arrival, or apply via the Embassy of Madagascar, New Delhi',
    0,
    'Confirm treatment and appointment directly with the Madagascar medical facility before applying.',
    'Embassy of Madagascar, New Delhi; Consulate of Madagascar, Mumbai',
    'Confirm treatment and appointment directly with the Madagascar medical facility\nApply online for the eVisa, or plan for VOA at the airport\nGather proof of sufficient funds\nCarry all medical and travel documents for immigration',
    NULL,
    'evisa-madagascar.it.com secondary sourcing', 'https://evisa-madagascar.it.com/madagascar-visa-for-indian-citizens/', '2026-09-19'
);
SET @mdg7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mdg7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mdg7, 'Core Documents', 'Required from every applicant.', 1);
SET @mdg7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mdg7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mdg7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mdg7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mdg7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mdg7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mdg7s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(29, 7, 0.00, 'EUR', '30-Day VOA/eVisa Fee (Free)', 'Same fee structure as the tourist visa applies.', '2026-01-01', NOW(), 'https://evisa-madagascar.it.com/madagascar-visa-for-indian-citizens/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Madagascar?', 'No separate medical visa — the same eVisa/VOA/embassy framework applies.', 29, 7, 2970, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    29, 8, 'MDG-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Madagascar.',
    'Conference attendees use the same eVisa/VOA/embassy framework as business travellers.',
    '15 or 30 days',
    'Apply online for the eVisa in advance, obtain a Visa on Arrival, or apply via the Embassy of Madagascar, New Delhi',
    0,
    'Same VOA fee structure as the tourist visa applies.',
    'Embassy of Madagascar, New Delhi; Consulate of Madagascar, Mumbai',
    'Confirm your passport is valid for 6+ months\nCarry conference invitation/registration confirmation\nApply online for the eVisa, or plan for VOA at the airport\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/in/visas/types-of-madagascar-visa', '2026-09-19'
);
SET @mdg8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mdg8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mdg8, 'Core Documents', 'Required from every applicant.', 1);
SET @mdg8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mdg8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mdg8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mdg8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mdg8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mdg8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mdg8s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(29, 8, 0.00, 'EUR', '30-Day VOA/eVisa Fee (Free)', 'Same fee structure as the business visa applies.', '2026-01-01', NOW(), 'https://evisa-madagascar.it.com/madagascar-visa-for-indian-citizens/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Madagascar?', 'No separate conference visa — the same eVisa/VOA/embassy framework applies as for business travel.', 29, 8, 2980, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    29, 9, 'MDG-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Madagascar.',
    'Sports travellers use the same eVisa/VOA/embassy framework as tourists.',
    '15 or 30 days',
    'Apply online for the eVisa in advance, obtain a Visa on Arrival, or apply via the Embassy of Madagascar, New Delhi',
    0,
    'Same VOA fee structure as the tourist visa applies.',
    'Embassy of Madagascar, New Delhi; Consulate of Madagascar, Mumbai',
    'Confirm your passport is valid for 6+ months\nCarry event invitation/participation confirmation\nApply online for the eVisa, or plan for VOA at the airport\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/in/visas/types-of-madagascar-visa', '2026-09-19'
);
SET @mdg9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mdg9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mdg9, 'Core Documents', 'Required from every applicant.', 1);
SET @mdg9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mdg9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mdg9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mdg9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mdg9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mdg9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mdg9s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(29, 9, 0.00, 'EUR', '30-Day VOA/eVisa Fee (Free)', 'Same fee structure as the tourist visa applies.', '2026-01-01', NOW(), 'https://evisa-madagascar.it.com/madagascar-visa-for-indian-citizens/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Madagascar?', 'No separate sports visa — the same eVisa/VOA/embassy framework applies as for tourist travel.', 29, 9, 2990, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    29, 10, 'MDG-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Madagascar long-stay/work visa.',
    'Dependants apply through the Embassy of Madagascar, New Delhi, referencing the primary permit holder\'s status.',
    'Tied to the primary permit holder\'s visa validity',
    'Apply through the Embassy of Madagascar, New Delhi, referencing the primary permit holder\'s status',
    1,
    'Not independently confirmed this session: exact dependant-visa fee and processing time.',
    'Embassy of Madagascar, New Delhi',
    'Confirm the primary permit holder\'s long-stay/work visa status\nGather proof of relationship (marriage/birth certificate)\nApply through the Embassy of Madagascar, New Delhi\nRegister with local authorities on arrival if required\nRenew your visa alongside the primary permit holder',
    NULL,
    'itzeazy.in secondary sourcing', 'https://itzeazy.in/blog/2026/03/13/madagascar-visa-for-indian/', '2026-09-19'
);
SET @mdg10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mdg10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mdg10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @mdg10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mdg10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mdg10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@mdg10s1, 'Primary Permit Holder\'s Visa Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mdg10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @mdg10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mdg10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mdg10s2, 'Passport-Size Photographs', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(29, 10, 0.00, 'EUR', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session — verify with the Embassy of Madagascar, New Delhi.', '2026-01-01', NOW(), 'https://itzeazy.in/blog/2026/03/13/madagascar-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependants accompany a work/long-stay visa holder to Madagascar?', 'Yes, via a separate application through the Embassy of Madagascar, New Delhi, referencing the primary permit holder\'s status.', 29, 10, 2900, 1);
