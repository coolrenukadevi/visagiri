-- Honduras Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Honduras's real, distinctive facts verified this session:
--   - Indian citizens require a visa for Honduras — either an eVisa
--     (single or multiple entry, applied online) or a visa issued by a
--     Honduran mission.
--   - Distinctive recent development: Honduras inaugurated its first
--     resident embassy in New Delhi on 15-16 May 2025 (sources give
--     both dates) — before this, the Ambassador of India in Guatemala
--     City was concurrently accredited to Honduras, with an Honorary
--     Consul General in Tegucigalpa. This checklist uses the New Delhi
--     embassy as the current consular office.
--   - All travellers must complete the online Honduras "Prechequeo"
--     (Traveller's Declaration) no more than 5 days before arrival —
--     in addition to, not instead of, the visa.
--   - CA-4 Border Control Agreement: a Honduras visa is honored across
--     Guatemala, El Salvador, and Nicaragua as one combined travel
--     zone — the visa's total-stay limit applies across all four
--     countries together, not per country.
--   - Sourcing note: passport-validity guidance conflicts across
--     sources (3 months vs. 6 months post-arrival) — 6 months is used
--     here as the safer, more commonly cited figure, with the conflict
--     flagged rather than silently picked.
--   - Work permits route through the Secretaria de Trabajo y Seguridad
--     Social (STSS) for labour approval, then the Instituto Nacional
--     de Migracion (INM) for the Temporary Resident Visa/Temporary
--     Work Permit itself — sourced from inm.gob.hn and secondary
--     immigration-services guides.
--
-- country_id 170 = Honduras. visa_type_id: 1=Tourist, 2=Business,
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
    170, 1, 'HND-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Honduras.',
    'Indian citizens require a visa for Honduras — an eVisa (single or multiple entry) applied for online, or a visa from the Embassy of Honduras, New Delhi.',
    'Per visa validity — recognized across the CA-4 zone (Guatemala, El Salvador, Nicaragua) as one combined stay',
    'Apply online for the Honduras eVisa, or through the Embassy of Honduras, New Delhi',
    0,
    'Complete the online Prechequeo (Traveller\'s Declaration) no more than 5 days before arrival, in addition to the visa. Processing typically 5-10 business days.',
    'Embassy of Honduras, New Delhi (opened May 2025)',
    'Confirm your passport is valid for 6+ months beyond arrival\nApply for the Honduras eVisa online, or apply via the Embassy of Honduras, New Delhi\nGather proof of return/onward ticket and sufficient funds\nComplete the online Prechequeo within 5 days of arrival\nCarry the approved eVisa/visa and Prechequeo confirmation on arrival',
    NULL,
    'inm.gob.hn and akbartravels.com secondary sourcing', 'https://www.akbartravels.com/in/visas/honduras-visa-fees', '2026-09-19'
);
SET @hnd1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hnd1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hnd1, 'Core Documents', 'Required from every applicant.', 1);
SET @hnd1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hnd1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hnd1s1, 'Honduras eVisa or Embassy Visa Approval', NULL, 'copy', 1, 0, 1, 2),
(@hnd1s1, 'Online Prechequeo (Traveller\'s Declaration) Confirmation', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hnd1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @hnd1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hnd1s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@hnd1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(170, 1, 40.00, 'USD', 'eVisa/Visa Fee (Indicative)', 'Sources cite a USD 30-50 range depending on entry type and application channel; not independently confirmed to a single figure this session.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/honduras-visa-fees', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Honduras?', 'Yes — either an eVisa applied for online, or a visa from the Embassy of Honduras in New Delhi, which opened in May 2025.', 170, 1, 17000, 1),
('What is the CA-4 agreement and how does it affect my Honduras visa?', 'A Honduras visa is also honored in Guatemala, El Salvador, and Nicaragua under the CA-4 Border Control Agreement — your total permitted stay applies across all four countries combined, not separately per country.', 170, 1, 17001, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    170, 2, 'HND-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Honduras.',
    'Business travellers use the same eVisa/embassy-visa framework as tourists, also completing the Prechequeo declaration.',
    'Per visa validity — recognized across the CA-4 zone',
    'Apply online for the Honduras eVisa, or through the Embassy of Honduras, New Delhi',
    0,
    'Complete the online Prechequeo no more than 5 days before arrival.',
    'Embassy of Honduras, New Delhi',
    'Confirm your passport is valid for 6+ months beyond arrival\nApply for the Honduras eVisa, or apply via the Embassy of Honduras, New Delhi\nCarry a business invitation letter from the host organization\nComplete the online Prechequeo within 5 days of arrival\nCarry all documents for immigration on arrival',
    NULL,
    'inm.gob.hn secondary sourcing', 'https://inm.gob.hn/visas.html', '2026-09-19'
);
SET @hnd2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hnd2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hnd2, 'Core Documents', 'Required from every applicant.', 1);
SET @hnd2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hnd2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hnd2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2),
(@hnd2s1, 'Online Prechequeo Confirmation', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hnd2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @hnd2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hnd2s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@hnd2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(170, 2, 40.00, 'USD', 'eVisa/Visa Fee (Indicative)', 'Same USD 30-50 range as the tourist eVisa applies for business purposes; not independently confirmed to a single figure this session.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/honduras-visa-fees', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Honduras?', 'Yes — the same eVisa/embassy-visa framework applies, with a business invitation letter recommended.', 170, 2, 17020, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    170, 3, 'HND-STU-IN-01', '2026.09', 'published',
    'Academic study at a Honduran educational institution.',
    'Sources reviewed this session did not describe a dedicated Honduran student-visa category distinct from the general Temporary Resident Visa process handled by the Instituto Nacional de Migracion.',
    'Study-program length, via Temporary Resident Visa renewal',
    'Apply for a Temporary Resident Visa through the Instituto Nacional de Migracion after securing admission',
    1,
    'Not independently confirmed this session whether a distinct student-visa category exists separately from the general residency process — verify directly with your institution and the Embassy of Honduras, New Delhi.',
    'Embassy of Honduras, New Delhi',
    'Confirm admission with a Honduran educational institution\nGather passport, admission letter, and proof of funds\nApply through the Embassy of Honduras, New Delhi, or the Instituto Nacional de Migracion once in-country\nComplete the online Prechequeo before arrival\nRegister your residency status with the INM after arrival if studying long-term',
    NULL,
    'inm.gob.hn secondary sourcing', 'https://inm.gob.hn/residencias.html', '2026-09-19'
);
SET @hnd3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hnd3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hnd3, 'Core Documents', 'Required from every applicant.', 1);
SET @hnd3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hnd3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hnd3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hnd3, 'Supporting Documents', 'Evidence of your means and status.', 2);
SET @hnd3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hnd3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@hnd3s2, 'Police Clearance Certificate', NULL, 'original', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(170, 3, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Student/residency fees were not independently confirmed this session — verify with the Embassy of Honduras, New Delhi.', '2026-01-01', NOW(), 'https://inm.gob.hn/residencias.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for Honduras?', 'Not independently confirmed this session — long-term study typically routes through the general Temporary Resident Visa process handled by the Instituto Nacional de Migracion.', 170, 3, 17030, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    170, 4, 'HND-WORK-IN-01', '2026.09', 'published',
    'Employment in Honduras under a local employer.',
    'Honduras offers a Temporary Resident Visa for employed foreign nationals, and a separate Temporary Work Permit (valid up to 1 year) for short-term work or training. Applications begin with labour approval from the Secretaria de Trabajo y Seguridad Social (STSS), followed by immigration submission to the Instituto Nacional de Migracion (INM).',
    'Up to 1 year (Temporary Work Permit), renewable Temporary Resident Visa for longer employment',
    'Employer files labour approval with STSS, then submits your residency/work-permit application to the INM',
    1,
    'Processing typically takes 60-90 days. Foreign-issued documents must be apostilled/legalized and translated into Spanish by a certified translator. Government fees typically USD 500-1,000 per applicant.',
    'Embassy of Honduras, New Delhi (initial visa); Instituto Nacional de Migracion, Honduras (work permit/residency)',
    'Secure a job offer from a Honduran employer\nEmployer files labour approval with the Secretaria de Trabajo y Seguridad Social (STSS)\nSubmit your Temporary Resident Visa/Work Permit application to the Instituto Nacional de Migracion\nApostille/legalize and translate all foreign-issued documents into Spanish\nEnter Honduras and complete registration once approved',
    NULL,
    'inm.gob.hn and rivermate.com secondary sourcing', 'https://www.rivermate.com/guides/honduras/work-permits-and-visas', '2026-09-19'
);
SET @hnd4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hnd4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hnd4, 'Core Documents', 'Required from every work-permit applicant.', 1);
SET @hnd4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hnd4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hnd4s1, 'Employment Contract/Job Offer Letter', NULL, 'original', 1, 0, 1, 2),
(@hnd4s1, 'STSS Labour Approval', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hnd4, 'Supporting Documents', 'Additional documents required by the INM.', 2);
SET @hnd4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hnd4s2, 'Apostilled Degree Certificates', NULL, 'original', 1, 0, 0, 1),
(@hnd4s2, 'Police Clearance Certificate (Apostilled)', NULL, 'original', 1, 0, 0, 2),
(@hnd4s2, 'Certified Spanish Translations of Foreign Documents', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(170, 4, 750.00, 'USD', 'Work Permit/Residency Fee (Indicative)', 'Sources cite a USD 500-1,000 range per applicant, covering application, residency, and translation/notary costs combined; not independently confirmed to a single figure.', '2026-01-01', NOW(), 'https://www.rivermate.com/guides/honduras/work-permits-and-visas', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How long does a Honduras work permit take to process?', 'Typically 60-90 days, starting with labour approval from the STSS followed by submission to the Instituto Nacional de Migracion.', 170, 4, 17040, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    170, 5, 'HND-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Honduras.',
    'Family visitors use the same eVisa/embassy-visa framework as tourists.',
    'Per visa validity — recognized across the CA-4 zone',
    'Apply online for the Honduras eVisa, or through the Embassy of Honduras, New Delhi',
    0,
    'Complete the online Prechequeo no more than 5 days before arrival.',
    'Embassy of Honduras, New Delhi',
    'Confirm your passport is valid for 6+ months beyond arrival\nApply for the Honduras eVisa, or apply via the Embassy of Honduras, New Delhi\nCarry proof of relationship and host contact details\nComplete the online Prechequeo within 5 days of arrival\nCarry all documents for immigration on arrival',
    NULL,
    'inm.gob.hn secondary sourcing', 'https://inm.gob.hn/visas.html', '2026-09-19'
);
SET @hnd5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hnd5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hnd5, 'Core Documents', 'Required from every applicant.', 1);
SET @hnd5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hnd5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hnd5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hnd5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @hnd5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hnd5s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@hnd5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(170, 5, 40.00, 'USD', 'eVisa/Visa Fee (Indicative)', 'Same USD 30-50 range as the tourist eVisa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/honduras-visa-fees', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Honduras?', 'Yes — the same eVisa/embassy-visa framework applies as for tourist travel.', 170, 5, 17050, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    170, 6, 'HND-TRAN-IN-01', '2026.09', 'published',
    'Transit through Honduras en route to another destination.',
    'Sources reviewed this session did not describe a separate airside-only transit exemption for Indian passport holders distinct from the standard eVisa — travellers clearing immigration in Honduras, even briefly, should expect to need the same eVisa/embassy-visa as other visa types.',
    'Short transit only, per visa validity',
    'Apply online for the Honduras eVisa, or through the Embassy of Honduras, New Delhi, before transiting',
    0,
    'Not independently confirmed this session whether an airside-only exemption exists — verify with your airline and the Embassy of Honduras, New Delhi, before relying on transiting without a visa.',
    'Embassy of Honduras, New Delhi',
    'Confirm your connecting flight and transit time\nApply for the Honduras eVisa in advance if there is any possibility of clearing immigration\nCarry your onward boarding pass and passport\nComplete the online Prechequeo if entering Honduran immigration control\nConfirm airside-only transit exemptions directly with your airline',
    NULL,
    'inm.gob.hn secondary sourcing (transit exemption not independently confirmed)', 'https://inm.gob.hn/visas.html', '2026-09-19'
);
SET @hnd6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hnd6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hnd6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @hnd6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hnd6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hnd6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(170, 6, 40.00, 'USD', 'eVisa/Visa Fee (If Clearing Immigration)', 'Airside-only transit exemption not independently confirmed this session — budget for the standard eVisa fee unless your airline confirms otherwise.', '2026-01-01', NOW(), 'https://inm.gob.hn/visas.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to transit through Honduras?', 'Not independently confirmed this session whether an airside-only exemption exists. If you may clear immigration, apply for the standard eVisa in advance.', 170, 6, 17060, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    170, 7, 'HND-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Honduras.',
    'Medical travellers use the same eVisa/embassy-visa framework as tourists.',
    'Per visa validity — recognized across the CA-4 zone',
    'Apply online for the Honduras eVisa, or through the Embassy of Honduras, New Delhi',
    0,
    'Complete the online Prechequeo no more than 5 days before arrival.',
    'Embassy of Honduras, New Delhi',
    'Confirm your passport is valid for 6+ months beyond arrival\nConfirm treatment and appointment directly with the Honduran medical facility\nApply for the Honduras eVisa, or apply via the Embassy of Honduras, New Delhi\nComplete the online Prechequeo within 5 days of arrival\nCarry all medical and travel documents for immigration',
    NULL,
    'inm.gob.hn secondary sourcing', 'https://inm.gob.hn/visas.html', '2026-09-19'
);
SET @hnd7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hnd7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hnd7, 'Core Documents', 'Required from every applicant.', 1);
SET @hnd7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hnd7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hnd7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hnd7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @hnd7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hnd7s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@hnd7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(170, 7, 40.00, 'USD', 'eVisa/Visa Fee (Indicative)', 'Same USD 30-50 range as the tourist eVisa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/honduras-visa-fees', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Honduras?', 'No separate medical visa — the same eVisa/embassy-visa framework applies as for tourist travel.', 170, 7, 17070, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    170, 8, 'HND-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Honduras.',
    'Conference attendees use the same eVisa/embassy-visa framework as business travellers.',
    'Per visa validity — recognized across the CA-4 zone',
    'Apply online for the Honduras eVisa, or through the Embassy of Honduras, New Delhi',
    0,
    'Complete the online Prechequeo no more than 5 days before arrival.',
    'Embassy of Honduras, New Delhi',
    'Confirm your passport is valid for 6+ months beyond arrival\nCarry conference invitation/registration confirmation\nApply for the Honduras eVisa, or apply via the Embassy of Honduras, New Delhi\nComplete the online Prechequeo within 5 days of arrival\nCarry all documents for immigration on arrival',
    NULL,
    'inm.gob.hn secondary sourcing', 'https://inm.gob.hn/visas.html', '2026-09-19'
);
SET @hnd8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hnd8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hnd8, 'Core Documents', 'Required from every applicant.', 1);
SET @hnd8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hnd8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hnd8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hnd8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @hnd8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hnd8s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@hnd8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(170, 8, 40.00, 'USD', 'eVisa/Visa Fee (Indicative)', 'Same USD 30-50 range as the tourist eVisa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/honduras-visa-fees', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Honduras?', 'No separate conference visa — the same eVisa/embassy-visa framework applies as for business travel.', 170, 8, 17080, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    170, 9, 'HND-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Honduras.',
    'Sports travellers use the same eVisa/embassy-visa framework as tourists.',
    'Per visa validity — recognized across the CA-4 zone',
    'Apply online for the Honduras eVisa, or through the Embassy of Honduras, New Delhi',
    0,
    'Complete the online Prechequeo no more than 5 days before arrival.',
    'Embassy of Honduras, New Delhi',
    'Confirm your passport is valid for 6+ months beyond arrival\nCarry event invitation/participation confirmation\nApply for the Honduras eVisa, or apply via the Embassy of Honduras, New Delhi\nComplete the online Prechequeo within 5 days of arrival\nCarry all documents for immigration on arrival',
    NULL,
    'inm.gob.hn secondary sourcing', 'https://inm.gob.hn/visas.html', '2026-09-19'
);
SET @hnd9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hnd9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hnd9, 'Core Documents', 'Required from every applicant.', 1);
SET @hnd9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hnd9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hnd9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hnd9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @hnd9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hnd9s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@hnd9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(170, 9, 40.00, 'USD', 'eVisa/Visa Fee (Indicative)', 'Same USD 30-50 range as the tourist eVisa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/honduras-visa-fees', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Honduras?', 'No separate sports visa — the same eVisa/embassy-visa framework applies as for tourist travel.', 170, 9, 17090, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    170, 10, 'HND-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Honduran Temporary Resident Visa/Work Permit.',
    'Dependants apply through the same Instituto Nacional de Migracion process as the primary permit holder, filing a separate application tied to the primary applicant\'s approval.',
    'Tied to the primary permit holder\'s Temporary Resident Visa validity',
    'File a dependant residency application with the Instituto Nacional de Migracion, referencing the primary permit holder\'s approval',
    1,
    'Foreign-issued documents (marriage/birth certificates) must be apostilled/legalized and translated into Spanish by a certified translator.',
    'Embassy of Honduras, New Delhi (initial visa); Instituto Nacional de Migracion, Honduras (dependant residency)',
    'Confirm the primary permit holder\'s Temporary Resident Visa/Work Permit status\nGather apostilled marriage/birth certificates proving the relationship\nSubmit certified Spanish translations of all foreign-issued documents\nFile your dependant residency application with the Instituto Nacional de Migracion\nEnter Honduras and complete registration once approved',
    NULL,
    'inm.gob.hn secondary sourcing', 'https://inm.gob.hn/residencias.html', '2026-09-19'
);
SET @hnd10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hnd10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hnd10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @hnd10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hnd10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hnd10s1, 'Apostilled Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@hnd10s1, 'Primary Permit Holder\'s Residency/Work Permit Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hnd10, 'Supporting Documents', 'Additional documents required by the INM.', 2);
SET @hnd10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hnd10s2, 'Certified Spanish Translations of Foreign Documents', NULL, 'copy', 1, 0, 0, 1),
(@hnd10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(170, 10, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Dependant residency fees were not independently confirmed this session — verify with the Instituto Nacional de Migracion.', '2026-01-01', NOW(), 'https://inm.gob.hn/residencias.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do dependants of work-permit holders need their own residency application in Honduras?', 'Yes — dependants file a separate application with the Instituto Nacional de Migracion, referencing the primary permit holder\'s approval and supported by apostilled proof of relationship.', 170, 10, 17000, 1);
