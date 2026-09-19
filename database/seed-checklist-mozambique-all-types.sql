-- Mozambique Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search.
--
-- Mozambique's real, distinctive facts verified this session:
--   - Indian citizens require a visa for Mozambique for every purpose
--     — no visa-free entry exists.
--   - Sourcing conflict flagged rather than silently resolved: one
--     source describes both an eVisa and Visa on Arrival as available
--     to Indians, another states Mozambique does NOT offer visa-on-
--     arrival for Indian travellers and requires advance application
--     — the eVisa route (5 business days, USD 50) is used as primary
--     since it is the more specifically documented mechanism, with
--     the VOA conflict flagged.
--   - Fee sourcing also varies: USD 50 (eVisa portal) vs. a higher
--     INR 14,000 agency-quoted figure — both presented, flagged as a
--     conflict rather than resolved.
--   - Mozambique maintains an Embassy in New Delhi and an Honorary
--     Consulate in Mumbai for embassy-route applications.
--
-- country_id 35 = Mozambique. visa_type_id: 1=Tourist, 2=Business,
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
    35, 1, 'MOZ-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Mozambique.',
    'Indian citizens require a visa for Mozambique. Sources disagree on availability of visa-on-arrival: one describes eVisa and VOA as both available, another states Mozambique does not offer VOA for Indians and requires advance application — apply for the eVisa in advance to avoid uncertainty.',
    'Per visa validity',
    'Apply for the eVisa online in advance, or through the Embassy of Mozambique, New Delhi',
    0,
    'Given the sourcing conflict on VOA availability, apply for the eVisa in advance rather than relying on VOA. Processing ~5 business days.',
    'Embassy of Mozambique, New Delhi; Honorary Consulate, Mumbai',
    'Confirm your passport is valid for 6+ months\nApply for the eVisa online at least 5 business days before travel\nGather proof of accommodation and flight itinerary\nPurchase travel insurance\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/mozambique.webp',
    'akbartravels.com and embassies.net secondary sourcing', 'https://www.akbartravels.com/in/visas/mozambique-visa-fees', '2026-09-19'
);
SET @moz1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@moz1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@moz1, 'Core Documents', 'Required from every applicant.', 1);
SET @moz1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@moz1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@moz1s1, 'Approved eVisa or Embassy Visa', NULL, 'copy', 1, 0, 1, 2),
(@moz1s1, 'Passport-Size Photographs (35x45mm, White Background)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@moz1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @moz1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@moz1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 1),
(@moz1s2, 'Flight Itinerary', NULL, 'copy', 1, 0, 0, 2),
(@moz1s2, 'Financial Proof', NULL, 'copy', 1, 0, 0, 3),
(@moz1s2, 'Travel Insurance', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(35, 1, 50.00, 'USD', 'eVisa Fee', 'Agency sourcing cites a higher INR 14,000 figure for some visa services — verify current pricing on the official eVisa portal.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/mozambique-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Mozambique?', 'Yes — there is no visa-free entry. Apply for the eVisa in advance; sources disagree on whether visa-on-arrival is genuinely available to Indians.', 35, 1, 3500, 1),
('Can Indian citizens get a visa on arrival in Mozambique?', 'Sources disagree — one describes VOA as available, another states Mozambique does not offer VOA for Indian travellers. Apply for the eVisa in advance to avoid uncertainty.', 35, 1, 3501, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    35, 2, 'MOZ-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Mozambique.',
    'Business travellers use the same eVisa/embassy-visa framework as tourists, with a business invitation letter as additional support.',
    'Per visa validity',
    'Apply for the eVisa online in advance, or through the Embassy of Mozambique, New Delhi',
    0,
    'Apply for the eVisa in advance given the VOA sourcing conflict.',
    'Embassy of Mozambique, New Delhi; Honorary Consulate, Mumbai',
    'Confirm your passport is valid for 6+ months\nApply for the eVisa online in advance\nCarry a business invitation letter from the host organization\nGather financial proof and travel insurance\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/mozambique.webp',
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/in/visas/mozambique-visa-fees', '2026-09-19'
);
SET @moz2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@moz2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@moz2, 'Core Documents', 'Required from every applicant.', 1);
SET @moz2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@moz2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@moz2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@moz2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @moz2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@moz2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@moz2s2, 'Financial Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(35, 2, 50.00, 'USD', 'eVisa Fee', 'Same USD 50 fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/mozambique-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Mozambique?', 'Yes — the same eVisa/embassy-visa framework applies, with a business invitation letter recommended.', 35, 2, 3520, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    35, 3, 'MOZ-STU-IN-01', '2026.09', 'published',
    'Academic study at a Mozambique educational institution.',
    'Sources reviewed this session did not describe a dedicated Mozambique student-visa category distinct from the general embassy visa process, applied for once admission is secured.',
    'Study-program length, renewable',
    'Apply through the Embassy of Mozambique, New Delhi, with a university admission letter',
    1,
    'Not independently confirmed this session whether a distinct student-visa category exists.',
    'Embassy of Mozambique, New Delhi',
    'Confirm admission with a Mozambique educational institution\nGather passport, admission letter, and proof of funds\nApply through the Embassy of Mozambique, New Delhi\nRegister with local authorities after arrival if required\nRenew your visa as needed for continued study',
    '/assets/images/visa-heroes/mozambique.webp',
    'embassies.net secondary sourcing', 'https://embassies.net/mozambique-visa-for-india-citizens', '2026-09-19'
);
SET @moz3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@moz3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@moz3, 'Core Documents', 'Required from every applicant.', 1);
SET @moz3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@moz3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@moz3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@moz3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @moz3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@moz3s2, 'Financial Proof', NULL, 'copy', 1, 0, 0, 1),
(@moz3s2, 'Travel Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(35, 3, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session — verify with the Embassy of Mozambique, New Delhi.', '2026-01-01', NOW(), 'https://embassies.net/mozambique-visa-for-india-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for Mozambique?', 'Not independently confirmed this session — apply through the general embassy visa process once admission is secured.', 35, 3, 3530, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    35, 4, 'MOZ-WORK-IN-01', '2026.09', 'published',
    'Employment in Mozambique under a local employer.',
    'Sources reviewed this session did not describe a dedicated Mozambique work-visa process in detail — apply through the Embassy of Mozambique, New Delhi, with employer sponsorship.',
    'Per work-visa validity, renewable',
    'Employer sponsors your work-visa application through the Embassy of Mozambique, New Delhi',
    1,
    'Not independently confirmed this session: exact work-visa fee, category, and local work-permit process.',
    'Embassy of Mozambique, New Delhi',
    'Secure a job offer from a Mozambique employer\nGather employment contract/sponsorship letter\nApply through the Embassy of Mozambique, New Delhi\nRegister with local labour authorities on arrival\nRenew your work visa as required for continued employment',
    '/assets/images/visa-heroes/mozambique.webp',
    'embassies.net secondary sourcing', 'https://embassies.net/mozambique-visa-for-india-citizens', '2026-09-19'
);
SET @moz4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@moz4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@moz4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @moz4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@moz4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@moz4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@moz4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @moz4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@moz4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@moz4s2, 'Financial Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(35, 4, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Work visa fees were not independently confirmed this session — verify with the Embassy of Mozambique, New Delhi.', '2026-01-01', NOW(), 'https://embassies.net/mozambique-visa-for-india-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How do I get a work visa for Mozambique as an Indian citizen?', 'Apply through the Embassy of Mozambique, New Delhi, with employer sponsorship documentation; exact fee and process were not independently confirmed this session.', 35, 4, 3540, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    35, 5, 'MOZ-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Mozambique.',
    'Family visitors use the same eVisa/embassy-visa framework as tourists.',
    'Per visa validity',
    'Apply for the eVisa online in advance, or through the Embassy of Mozambique, New Delhi',
    0,
    'Apply for the eVisa in advance given the VOA sourcing conflict.',
    'Embassy of Mozambique, New Delhi; Honorary Consulate, Mumbai',
    'Confirm your passport is valid for 6+ months\nApply for the eVisa online in advance\nCarry proof of relationship and host contact details\nGather financial proof and travel insurance\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/mozambique.webp',
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/in/visas/mozambique-visa-fees', '2026-09-19'
);
SET @moz5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@moz5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@moz5, 'Core Documents', 'Required from every applicant.', 1);
SET @moz5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@moz5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@moz5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@moz5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @moz5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@moz5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 1),
(@moz5s2, 'Financial Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(35, 5, 50.00, 'USD', 'eVisa Fee', 'Same USD 50 fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/mozambique-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Mozambique?', 'Yes — the same eVisa/embassy-visa framework applies as for tourist travel.', 35, 5, 3550, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    35, 6, 'MOZ-TRAN-IN-01', '2026.09', 'published',
    'Transit through Mozambique en route to another destination.',
    'Sources reviewed this session did not describe a separate airside-only transit exemption for Indian passport holders — since Mozambique has no visa-free entry, travellers clearing immigration should expect to need the same eVisa/embassy-visa as other visa types.',
    'Short transit only',
    'Apply for the eVisa in advance if clearing immigration',
    0,
    'Not independently confirmed this session whether an airside-only exemption exists — verify with your airline.',
    'Embassy of Mozambique, New Delhi',
    'Confirm your connecting flight and transit time\nApply for the eVisa in advance if there is any possibility of clearing immigration\nCarry your onward boarding pass and passport\nConfirm airside-only transit exemptions directly with your airline',
    '/assets/images/visa-heroes/mozambique.webp',
    'akbartravels.com secondary sourcing (transit exemption not independently confirmed)', 'https://www.akbartravels.com/in/visas/mozambique-visa-fees', '2026-09-19'
);
SET @moz6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@moz6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@moz6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @moz6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@moz6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@moz6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(35, 6, 50.00, 'USD', 'eVisa Fee (If Clearing Immigration)', 'Airside-only transit exemption not independently confirmed this session — budget for the standard eVisa fee unless your airline confirms otherwise.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/mozambique-visa-fees', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Mozambique?', 'Not independently confirmed this session whether airside-only transit is exempt. Since there is no visa-free entry, apply for the eVisa in advance if you may clear immigration.', 35, 6, 3560, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    35, 7, 'MOZ-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Mozambique.',
    'Medical travellers use the same eVisa/embassy-visa framework as tourists.',
    'Per visa validity',
    'Apply for the eVisa online in advance, or through the Embassy of Mozambique, New Delhi',
    0,
    'Confirm treatment and appointment directly with the Mozambique medical facility before applying.',
    'Embassy of Mozambique, New Delhi; Honorary Consulate, Mumbai',
    'Confirm treatment and appointment directly with the Mozambique medical facility\nApply for the eVisa online in advance\nGather financial proof and travel insurance\nCarry all medical and travel documents for immigration',
    '/assets/images/visa-heroes/mozambique.webp',
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/in/visas/mozambique-visa-fees', '2026-09-19'
);
SET @moz7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@moz7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@moz7, 'Core Documents', 'Required from every applicant.', 1);
SET @moz7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@moz7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@moz7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@moz7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @moz7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@moz7s2, 'Financial Proof', NULL, 'copy', 1, 0, 0, 1),
(@moz7s2, 'Travel Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(35, 7, 50.00, 'USD', 'eVisa Fee', 'Same USD 50 fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/mozambique-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Mozambique?', 'No separate medical visa — the same eVisa/embassy-visa framework applies as for tourist travel.', 35, 7, 3570, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    35, 8, 'MOZ-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Mozambique.',
    'Conference attendees use the same eVisa/embassy-visa framework as business travellers.',
    'Per visa validity',
    'Apply for the eVisa online in advance, or through the Embassy of Mozambique, New Delhi',
    0,
    'Apply for the eVisa in advance given the VOA sourcing conflict.',
    'Embassy of Mozambique, New Delhi; Honorary Consulate, Mumbai',
    'Confirm your passport is valid for 6+ months\nCarry conference invitation/registration confirmation\nApply for the eVisa online in advance\nGather financial proof and travel insurance\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/mozambique.webp',
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/in/visas/mozambique-visa-fees', '2026-09-19'
);
SET @moz8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@moz8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@moz8, 'Core Documents', 'Required from every applicant.', 1);
SET @moz8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@moz8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@moz8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@moz8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @moz8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@moz8s2, 'Financial Proof', NULL, 'copy', 1, 0, 0, 1),
(@moz8s2, 'Travel Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(35, 8, 50.00, 'USD', 'eVisa Fee', 'Same USD 50 fee range as the business visa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/mozambique-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Mozambique?', 'No separate conference visa — the same eVisa/embassy-visa framework applies as for business travel.', 35, 8, 3580, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    35, 9, 'MOZ-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Mozambique.',
    'Sports travellers use the same eVisa/embassy-visa framework as tourists.',
    'Per visa validity',
    'Apply for the eVisa online in advance, or through the Embassy of Mozambique, New Delhi',
    0,
    'Apply for the eVisa in advance given the VOA sourcing conflict.',
    'Embassy of Mozambique, New Delhi; Honorary Consulate, Mumbai',
    'Confirm your passport is valid for 6+ months\nCarry event invitation/participation confirmation\nApply for the eVisa online in advance\nGather financial proof and travel insurance\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/mozambique.webp',
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/in/visas/mozambique-visa-fees', '2026-09-19'
);
SET @moz9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@moz9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@moz9, 'Core Documents', 'Required from every applicant.', 1);
SET @moz9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@moz9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@moz9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@moz9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @moz9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@moz9s2, 'Financial Proof', NULL, 'copy', 1, 0, 0, 1),
(@moz9s2, 'Travel Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(35, 9, 50.00, 'USD', 'eVisa Fee', 'Same USD 50 fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/mozambique-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Mozambique?', 'No separate sports visa — the same eVisa/embassy-visa framework applies as for tourist travel.', 35, 9, 3590, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    35, 10, 'MOZ-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Mozambique work/student visa.',
    'Dependants apply through the Embassy of Mozambique, New Delhi, referencing the primary permit holder\'s visa.',
    'Tied to the primary permit holder\'s visa validity',
    'Apply through the Embassy of Mozambique, New Delhi, referencing the primary permit holder\'s visa',
    1,
    'Not independently confirmed this session: exact dependant-visa fee and processing time.',
    'Embassy of Mozambique, New Delhi',
    'Confirm the primary permit holder\'s work/student visa status\nGather proof of relationship (marriage/birth certificate)\nApply through the Embassy of Mozambique, New Delhi\nRegister with local authorities on arrival if required\nRenew your visa alongside the primary permit holder',
    '/assets/images/visa-heroes/mozambique.webp',
    'embassies.net secondary sourcing', 'https://embassies.net/mozambique-visa-for-india-citizens', '2026-09-19'
);
SET @moz10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@moz10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@moz10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @moz10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@moz10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@moz10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@moz10s1, 'Primary Permit Holder\'s Visa Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@moz10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @moz10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@moz10s2, 'Financial Proof', NULL, 'copy', 1, 0, 0, 1),
(@moz10s2, 'Travel Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(35, 10, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://embassies.net/mozambique-visa-for-india-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependants accompany a work/student visa holder to Mozambique?', 'Yes, via a separate application through the Embassy of Mozambique, New Delhi, referencing the primary permit holder\'s visa.', 35, 10, 3500, 1);
