-- Malawi Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Malawi's real, distinctive facts verified this session:
--   - India is classified by Malawi as a "Category One" country,
--     meaning a visa must be obtained BEFORE departure — there is no
--     visa-free entry and no visa-on-arrival option at all for Indian
--     passport holders. Airlines will not allow boarding without a
--     valid e-visa or visa approval.
--   - eVisa applied via the official portal evisa.gov.mw; fee USD 75
--     single entry, USD 150 (6-month multiple entry), USD 250
--     (12-month multiple entry) — non-refundable even if denied.
--     Processing 3-10 days depending on source; recommended to apply
--     2 weeks before travel.
--   - The tourist visa cannot be used for any paid employment — a
--     distinct work-visa category is required.
--   - Malawi maintains a High Commission in New Delhi (E-6/14, Vasant
--     Vihar) for embassy-route or supplementary applications.
--
-- country_id 30 = Malawi. visa_type_id: 1=Tourist, 2=Business,
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
    30, 1, 'MWI-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Malawi.',
    'India is classified as a "Category One" country by Malawi — a visa must be obtained before departure; there is no visa-on-arrival option, and airlines will not allow boarding without a valid e-visa.',
    'Per visa validity',
    'Apply online via evisa.gov.mw before departure',
    0,
    'Apply at least 2 weeks before travel; processing 3-10 days depending on source. Fee is non-refundable even if denied.',
    'High Commission of Malawi, New Delhi (E-6/14, Vasant Vihar)',
    'Confirm your passport is valid for 6+ months\nApply for the eVisa online via evisa.gov.mw at least 2 weeks before travel\nUpload travel details and financial proof\nGather proof of accommodation and return ticket\nCarry the approved eVisa for immigration and airline boarding',
    NULL,
    'btwvisas.com and akbartravels.com secondary sourcing', 'https://btwvisas.com/visa-guide/malawi-tourist-visa/', '2026-09-19'
);
SET @mwi1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mwi1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mwi1, 'Core Documents', 'Required from every applicant.', 1);
SET @mwi1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mwi1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mwi1s1, 'Approved eVisa (Required Before Departure)', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mwi1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mwi1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mwi1s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@mwi1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 2),
(@mwi1s2, 'Financial Proof', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(30, 1, 75.00, 'USD', 'Single-Entry eVisa Fee', 'Multiple-entry options: USD 150 (6 months), USD 250 (12 months). Non-refundable even if the application is denied.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/malawi-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens get a visa on arrival in Malawi?', 'No — Malawi classifies India as a "Category One" country, meaning a visa must be obtained before departure. Airlines will not allow boarding without a valid e-visa.', 30, 1, 3000, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    30, 2, 'MWI-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Malawi.',
    'Business travellers use the same mandatory pre-departure eVisa framework as tourists, with a business invitation letter as additional support.',
    'Per visa validity',
    'Apply online via evisa.gov.mw before departure',
    0,
    'Apply at least 2 weeks before travel.',
    'High Commission of Malawi, New Delhi (E-6/14, Vasant Vihar)',
    'Confirm your passport is valid for 6+ months\nApply for the eVisa online via evisa.gov.mw before departure\nCarry a business invitation letter from the host organization\nGather financial proof\nCarry the approved eVisa for immigration and airline boarding',
    NULL,
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/malawi-visa/', '2026-09-19'
);
SET @mwi2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mwi2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mwi2, 'Core Documents', 'Required from every applicant.', 1);
SET @mwi2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mwi2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mwi2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mwi2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @mwi2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mwi2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@mwi2s2, 'Financial Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(30, 2, 75.00, 'USD', 'Single-Entry eVisa Fee', 'Same fee structure as the tourist visa applies.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/malawi-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Malawi?', 'Yes — the same mandatory pre-departure eVisa framework applies, with a business invitation letter recommended.', 30, 2, 3020, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    30, 3, 'MWI-STU-IN-01', '2026.09', 'published',
    'Academic study at a Malawi educational institution.',
    'Sources reviewed this session did not describe a dedicated Malawi student-visa category distinct from the general embassy visa process, applied for once admission is secured.',
    'Study-program length, renewable',
    'Apply through the High Commission of Malawi, New Delhi, with a university admission letter',
    1,
    'Not independently confirmed this session whether a distinct student-visa category exists.',
    'High Commission of Malawi, New Delhi (E-6/14, Vasant Vihar)',
    'Confirm admission with a Malawi educational institution\nGather passport, admission letter, and proof of funds\nApply through the High Commission of Malawi, New Delhi\nRegister with local authorities after arrival if required\nRenew your visa as needed for continued study',
    NULL,
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/visa/malawi-visa', '2026-09-19'
);
SET @mwi3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mwi3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mwi3, 'Core Documents', 'Required from every applicant.', 1);
SET @mwi3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mwi3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mwi3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mwi3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @mwi3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mwi3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mwi3s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(30, 3, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session — verify with the High Commission of Malawi, New Delhi.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/malawi-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for Malawi?', 'Not independently confirmed this session — apply through the general embassy visa process once admission is secured, via the High Commission of Malawi, New Delhi.', 30, 3, 3030, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    30, 4, 'MWI-WORK-IN-01', '2026.09', 'published',
    'Employment in Malawi under a local employer.',
    'The tourist visa cannot be used for any paid employment — a distinct work-visa category is required, sponsored by a local employer.',
    'Per work-permit validity, renewable',
    'Employer sponsors your work-visa application through the High Commission of Malawi, New Delhi',
    1,
    'Not independently confirmed this session: exact work-visa fee and local work-permit process.',
    'High Commission of Malawi, New Delhi (E-6/14, Vasant Vihar)',
    'Secure a job offer from a Malawi employer\nGather employment contract/sponsorship letter\nApply through the High Commission of Malawi, New Delhi\nRegister with local labour authorities on arrival\nRenew your work visa as required for continued employment',
    NULL,
    'acko.com secondary sourcing', 'https://www.acko.com/visa/malawi-visa-for-indians/', '2026-09-19'
);
SET @mwi4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mwi4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mwi4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @mwi4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mwi4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mwi4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mwi4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @mwi4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mwi4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@mwi4s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(30, 4, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Work visa fees were not independently confirmed this session — verify with the High Commission of Malawi, New Delhi.', '2026-01-01', NOW(), 'https://www.acko.com/visa/malawi-visa-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Malawi on a tourist visa?', 'No — the tourist visa cannot be used for any paid employment. A distinct work-visa category, sponsored by a local employer, is required.', 30, 4, 3040, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    30, 5, 'MWI-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Malawi.',
    'Family visitors use the same mandatory pre-departure eVisa framework as tourists.',
    'Per visa validity',
    'Apply online via evisa.gov.mw before departure',
    0,
    'Apply at least 2 weeks before travel.',
    'High Commission of Malawi, New Delhi (E-6/14, Vasant Vihar)',
    'Confirm your passport is valid for 6+ months\nApply for the eVisa online via evisa.gov.mw before departure\nCarry proof of relationship and host contact details\nGather financial proof\nCarry the approved eVisa for immigration and airline boarding',
    NULL,
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/malawi-visa/', '2026-09-19'
);
SET @mwi5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mwi5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mwi5, 'Core Documents', 'Required from every applicant.', 1);
SET @mwi5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mwi5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mwi5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mwi5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mwi5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mwi5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 1),
(@mwi5s2, 'Financial Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(30, 5, 75.00, 'USD', 'Single-Entry eVisa Fee', 'Same fee structure as the tourist visa applies.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/malawi-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Malawi?', 'Yes — the same mandatory pre-departure eVisa framework applies as for tourist travel.', 30, 5, 3050, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    30, 6, 'MWI-TRAN-IN-01', '2026.09', 'published',
    'Transit through Malawi en route to another destination.',
    'Given Malawi\'s strict pre-departure eVisa requirement for Indian citizens (no VOA at all), travellers clearing immigration should expect to need the same eVisa as other visa types.',
    'Short transit only',
    'Apply for the eVisa via evisa.gov.mw in advance if clearing immigration',
    0,
    'Not independently confirmed this session whether an airside-only exemption exists — verify with your airline.',
    'High Commission of Malawi, New Delhi (E-6/14, Vasant Vihar)',
    'Confirm your connecting flight and transit time\nApply for the eVisa in advance if there is any possibility of clearing immigration\nCarry your onward boarding pass and passport\nConfirm airside-only transit exemptions directly with your airline',
    NULL,
    'btwvisas.com secondary sourcing (transit exemption not independently confirmed)', 'https://btwvisas.com/visa-guide/malawi-visa/', '2026-09-19'
);
SET @mwi6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mwi6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mwi6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @mwi6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mwi6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mwi6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(30, 6, 75.00, 'USD', 'eVisa Fee (If Clearing Immigration)', 'Airside-only transit exemption not independently confirmed this session — budget for the standard eVisa fee unless your airline confirms otherwise.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/malawi-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Malawi?', 'Not independently confirmed this session whether airside-only transit is exempt. Given Malawi\'s strict Category One classification for India, apply for the eVisa in advance if you may clear immigration.', 30, 6, 3060, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    30, 7, 'MWI-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Malawi.',
    'Medical travellers use the same mandatory pre-departure eVisa framework as tourists.',
    'Per visa validity',
    'Apply online via evisa.gov.mw before departure',
    0,
    'Confirm treatment and appointment directly with the Malawi medical facility before applying.',
    'High Commission of Malawi, New Delhi (E-6/14, Vasant Vihar)',
    'Confirm treatment and appointment directly with the Malawi medical facility\nApply for the eVisa online via evisa.gov.mw before departure\nGather financial proof\nCarry all medical and travel documents for immigration',
    NULL,
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/malawi-visa/', '2026-09-19'
);
SET @mwi7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mwi7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mwi7, 'Core Documents', 'Required from every applicant.', 1);
SET @mwi7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mwi7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mwi7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mwi7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mwi7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mwi7s2, 'Financial Proof', NULL, 'copy', 1, 0, 0, 1),
(@mwi7s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(30, 7, 75.00, 'USD', 'Single-Entry eVisa Fee', 'Same fee structure as the tourist visa applies.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/malawi-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Malawi?', 'No separate medical visa — the same mandatory pre-departure eVisa framework applies as for tourist travel.', 30, 7, 3070, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    30, 8, 'MWI-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Malawi.',
    'Conference attendees use the same mandatory pre-departure eVisa framework as business travellers.',
    'Per visa validity',
    'Apply online via evisa.gov.mw before departure',
    0,
    'Apply at least 2 weeks before travel.',
    'High Commission of Malawi, New Delhi (E-6/14, Vasant Vihar)',
    'Confirm your passport is valid for 6+ months\nCarry conference invitation/registration confirmation\nApply for the eVisa online via evisa.gov.mw before departure\nGather financial proof\nCarry the approved eVisa for immigration and airline boarding',
    NULL,
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/malawi-visa/', '2026-09-19'
);
SET @mwi8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mwi8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mwi8, 'Core Documents', 'Required from every applicant.', 1);
SET @mwi8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mwi8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mwi8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mwi8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mwi8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mwi8s2, 'Financial Proof', NULL, 'copy', 1, 0, 0, 1),
(@mwi8s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(30, 8, 75.00, 'USD', 'Single-Entry eVisa Fee', 'Same fee structure as the business visa applies.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/malawi-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Malawi?', 'No separate conference visa — the same mandatory pre-departure eVisa framework applies as for business travel.', 30, 8, 3080, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    30, 9, 'MWI-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Malawi.',
    'Sports travellers use the same mandatory pre-departure eVisa framework as tourists.',
    'Per visa validity',
    'Apply online via evisa.gov.mw before departure',
    0,
    'Apply at least 2 weeks before travel.',
    'High Commission of Malawi, New Delhi (E-6/14, Vasant Vihar)',
    'Confirm your passport is valid for 6+ months\nCarry event invitation/participation confirmation\nApply for the eVisa online via evisa.gov.mw before departure\nGather financial proof\nCarry the approved eVisa for immigration and airline boarding',
    NULL,
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/malawi-visa/', '2026-09-19'
);
SET @mwi9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mwi9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mwi9, 'Core Documents', 'Required from every applicant.', 1);
SET @mwi9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mwi9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mwi9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mwi9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mwi9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mwi9s2, 'Financial Proof', NULL, 'copy', 1, 0, 0, 1),
(@mwi9s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(30, 9, 75.00, 'USD', 'Single-Entry eVisa Fee', 'Same fee structure as the tourist visa applies.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/malawi-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Malawi?', 'No separate sports visa — the same mandatory pre-departure eVisa framework applies as for tourist travel.', 30, 9, 3090, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    30, 10, 'MWI-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Malawi work/student visa.',
    'Dependants apply through the High Commission of Malawi, New Delhi, referencing the primary permit holder\'s status.',
    'Tied to the primary permit holder\'s visa validity',
    'Apply through the High Commission of Malawi, New Delhi, referencing the primary permit holder\'s status',
    1,
    'Not independently confirmed this session: exact dependant-visa fee and processing time.',
    'High Commission of Malawi, New Delhi (E-6/14, Vasant Vihar)',
    'Confirm the primary permit holder\'s work/student visa status\nGather proof of relationship (marriage/birth certificate)\nApply through the High Commission of Malawi, New Delhi\nRegister with local authorities on arrival if required\nRenew your visa alongside the primary permit holder',
    NULL,
    'acko.com secondary sourcing', 'https://www.acko.com/visa/malawi-visa-for-indians/', '2026-09-19'
);
SET @mwi10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mwi10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mwi10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @mwi10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mwi10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mwi10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@mwi10s1, 'Primary Permit Holder\'s Visa Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mwi10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @mwi10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mwi10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mwi10s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(30, 10, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session — verify with the High Commission of Malawi, New Delhi.', '2026-01-01', NOW(), 'https://www.acko.com/visa/malawi-visa-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependants accompany a work/student visa holder to Malawi?', 'Yes, via a separate application through the High Commission of Malawi, New Delhi, referencing the primary permit holder\'s status.', 30, 10, 3000, 1);
