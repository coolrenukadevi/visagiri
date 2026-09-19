-- Laos Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Laos's real, distinctive facts verified this session:
--   - Indian citizens require a visa for Laos, but have two convenient
--     routes: an eVisa (USD 35, 3 business days) applied online in
--     advance, or a Visa on Arrival (USD 26-46, cash, 10-40 minute
--     wait at airports) available at major entry points — the eVisa
--     is generally faster since it skips the arrival visa counter.
--   - Stay duration: up to 30 days on both the eVisa and VOA.
--   - Work visas require BOTH a work permit from the Ministry of
--     Labor and Social Welfare AND a separate stay permit from the
--     Foreigners Control Department, in addition to the labour visa
--     itself — a three-part process.
--   - Student visas are a distinct long-term visa category for those
--     enrolled at a Laotian educational institution, with differing
--     entry and validity rules from the tourist eVisa/VOA.
--   - Passport must be valid 6+ months from arrival with 2+ blank
--     pages.
--
-- country_id 77 = Laos. visa_type_id: 1=Tourist, 2=Business,
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
    77, 1, 'LAO-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Laos.',
    'Indian citizens require a visa for Laos, available as either an eVisa (applied online in advance) or a Visa on Arrival at major entry points.',
    'Up to 30 days',
    'Apply online for the eVisa in advance, or obtain a Visa on Arrival (cash) at major entry points',
    0,
    'The eVisa (3 business days) is generally faster than the VOA queue (10-40 minutes at airports, longer at land borders). eVisa fee is non-refundable even if denied.',
    'No dedicated Indian-facing consular office required — both eVisa and VOA are processed directly',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nApply online for the eVisa, or plan to obtain a Visa on Arrival with cash ready\nGather proof of accommodation and sufficient funds\nComplete the visa application form if using VOA\nCarry all documents for immigration on arrival',
    NULL,
    'akbartravels.com and travelfika.com secondary sourcing', 'https://www.akbartravels.com/visa/laos-visa', '2026-09-19'
);
SET @lao1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lao1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lao1, 'Core Documents', 'Required from every traveller.', 1);
SET @lao1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lao1s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lao1s1, 'Approved eVisa or Visa on Arrival', NULL, 'copy', 1, 0, 1, 2),
(@lao1s1, 'Passport-Size Photograph', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lao1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lao1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lao1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 1),
(@lao1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(77, 1, 35.00, 'USD', 'eVisa Fee', 'Non-refundable even if the application is denied. VOA fees range USD 26-46 by nationality/entry point; another source cites eVisa at ~USD 50.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/laos-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Laos?', 'Yes — but two convenient options exist: an eVisa applied for online in advance (USD 35, 3 business days), or a Visa on Arrival (cash, USD 26-46) at major entry points.', 77, 1, 7700, 1),
('Which is faster, the Laos eVisa or Visa on Arrival?', 'The eVisa is generally faster since it lets you skip the arrival visa counter — VOA queues take about 10-40 minutes at airports and longer at land borders.', 77, 1, 7701, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    77, 2, 'LAO-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Laos.',
    'Business travellers can use the same eVisa/VOA framework as tourists for short trips, with a business invitation letter recommended.',
    'Up to 30 days',
    'Apply online for the eVisa in advance, or obtain a Visa on Arrival at major entry points',
    0,
    'For longer or recurring business travel, a dedicated business visa via the Laos Embassy may be more appropriate — not independently confirmed this session.',
    'No dedicated Indian-facing consular office required for short visits',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nApply online for the eVisa, or plan to obtain a Visa on Arrival\nCarry a business invitation letter from the host organization\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/visa/laos-visa', '2026-09-19'
);
SET @lao2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lao2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lao2, 'Core Documents', 'Required from every applicant.', 1);
SET @lao2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lao2s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lao2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lao2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @lao2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lao2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@lao2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(77, 2, 35.00, 'USD', 'eVisa Fee', 'Same USD 35 eVisa fee range as the tourist visa applies for short business trips.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/laos-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Laos?', 'Yes — the same eVisa/VOA framework applies for short trips, with a business invitation letter recommended.', 77, 2, 7720, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    77, 3, 'LAO-STU-IN-01', '2026.09', 'published',
    'Academic study at a Laotian educational institution.',
    'A distinct long-term student visa category applies to those enrolled at a Laotian institution, with different entry and validity rules from the tourist eVisa/VOA.',
    'Academic-program length, renewable',
    'Apply for the student visa through the Laos Embassy/Consulate, with a university admission letter',
    1,
    'Not independently confirmed this session: exact student-visa fee and processing time — verify directly with your institution and the Laos Embassy.',
    'Embassy of Laos, New Delhi',
    'Confirm admission with a Laotian educational institution\nGather passport, admission letter, and proof of funds\nApply for the student visa through the Laos Embassy/Consulate\nRegister with local authorities after arrival\nRenew your student visa as required for continued study',
    NULL,
    'acko.com secondary sourcing', 'https://www.acko.com/visa/laos-visa-for-indians/', '2026-09-19'
);
SET @lao3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lao3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lao3, 'Core Documents', 'Required from every applicant.', 1);
SET @lao3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lao3s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lao3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lao3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @lao3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lao3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lao3s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(77, 3, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session — verify with the Laos Embassy, New Delhi.', '2026-01-01', NOW(), 'https://www.acko.com/visa/laos-visa-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for Laos?', 'Yes — a distinct long-term student visa category applies to those enrolled at a Laotian institution, separate from the tourist eVisa/VOA.', 77, 3, 7730, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    77, 4, 'LAO-WORK-IN-01', '2026.09', 'published',
    'Employment in Laos under a legally recognized local employer.',
    'A three-part process: the labour visa itself, plus a work permit from the Ministry of Labor and Social Welfare, plus a separate stay permit from the Foreigners Control Department.',
    'Per work-permit/stay-permit validity, renewable',
    'Employer sponsors your labour visa; apply separately for a work permit and a stay permit',
    1,
    'Fee cited as approximately INR 4,000-10,000+ depending on validity and criteria; verify exact amounts directly with your employer and Laotian authorities.',
    'Embassy of Laos, New Delhi',
    'Secure a job offer from a legally recognized Laotian employer\nEmployer sponsors your labour visa application\nApply for a work permit from the Ministry of Labor and Social Welfare\nApply for a stay permit from the Foreigners Control Department\nRegister and renew all permits as required for continued employment',
    NULL,
    'tataaig.com secondary sourcing', 'https://www.tataaig.com/travel-insurance/laos-visa-for-indians', '2026-09-19'
);
SET @lao4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lao4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lao4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @lao4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lao4s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lao4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2),
(@lao4s1, 'Work Permit (Ministry of Labor and Social Welfare)', NULL, 'original', 1, 0, 1, 3),
(@lao4s1, 'Stay Permit (Foreigners Control Department)', NULL, 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lao4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @lao4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lao4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@lao4s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(77, 4, 6000.00, 'INR', 'Work Visa Fee (Indicative)', 'Sources cite an INR 4,000-10,000+ range depending on validity and criteria; work permit and stay permit fees are separate and not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.tataaig.com/travel-insurance/laos-visa-for-indians', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What does an Indian citizen need to work in Laos?', 'A labour visa sponsored by your employer, plus a work permit from the Ministry of Labor and Social Welfare, plus a stay permit from the Foreigners Control Department — a three-part process.', 77, 4, 7740, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    77, 5, 'LAO-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Laos.',
    'Family visitors use the same eVisa/VOA framework as tourists.',
    'Up to 30 days',
    'Apply online for the eVisa in advance, or obtain a Visa on Arrival at major entry points',
    0,
    'Not applicable beyond standard entry documentation.',
    'No dedicated Indian-facing consular office required for short visits',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nApply online for the eVisa, or plan to obtain a Visa on Arrival\nCarry proof of relationship and host contact details\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/visa/laos-visa', '2026-09-19'
);
SET @lao5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lao5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lao5, 'Core Documents', 'Required from every traveller.', 1);
SET @lao5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lao5s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lao5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lao5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lao5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lao5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 1),
(@lao5s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(77, 5, 35.00, 'USD', 'eVisa Fee', 'Same USD 35 eVisa fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/laos-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Laos?', 'Yes — the same eVisa/VOA framework applies as for tourist travel.', 77, 5, 7750, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    77, 6, 'LAO-TRAN-IN-01', '2026.09', 'published',
    'Transit through Laos en route to another destination.',
    'Sources reviewed this session did not describe a separate airside-only transit exemption for Indian passport holders — travellers clearing immigration should expect to need the same eVisa/VOA as other visa types.',
    'Short transit only',
    'Apply for the eVisa in advance, or use Visa on Arrival, before transiting',
    0,
    'Not independently confirmed this session whether an airside-only exemption exists — verify with your airline before relying on transiting without a visa.',
    'No dedicated Indian-facing consular office required',
    'Confirm your connecting flight and transit time\nApply for the eVisa in advance if there is any possibility of clearing immigration\nCarry your onward boarding pass and passport\nConfirm airside-only transit exemptions directly with your airline',
    NULL,
    'akbartravels.com secondary sourcing (transit exemption not independently confirmed)', 'https://www.akbartravels.com/visa/laos-visa', '2026-09-19'
);
SET @lao6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lao6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lao6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @lao6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lao6s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lao6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(77, 6, 35.00, 'USD', 'eVisa Fee (If Clearing Immigration)', 'Airside-only transit exemption not independently confirmed this session — budget for the standard eVisa/VOA fee unless your airline confirms otherwise.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/laos-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Laos?', 'Not independently confirmed this session whether airside-only transit is exempt. If you may clear immigration, apply for the eVisa in advance.', 77, 6, 7760, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    77, 7, 'LAO-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Laos.',
    'Medical travellers use the same eVisa/VOA framework as tourists.',
    'Up to 30 days',
    'Apply online for the eVisa in advance, or obtain a Visa on Arrival at major entry points',
    0,
    'Confirm treatment and appointment directly with the Laotian medical facility before applying.',
    'No dedicated Indian-facing consular office required for short visits',
    'Confirm treatment and appointment directly with the Laotian medical facility\nApply online for the eVisa, or plan to obtain a Visa on Arrival\nGather proof of sufficient funds\nBook proof of return/onward ticket\nCarry all medical and travel documents for immigration',
    NULL,
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/visa/laos-visa', '2026-09-19'
);
SET @lao7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lao7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lao7, 'Core Documents', 'Required from every traveller.', 1);
SET @lao7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lao7s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lao7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lao7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lao7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lao7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lao7s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(77, 7, 35.00, 'USD', 'eVisa Fee', 'Same USD 35 eVisa fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/laos-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Laos?', 'No separate medical visa — the same eVisa/VOA framework applies as for tourist travel.', 77, 7, 7770, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    77, 8, 'LAO-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Laos.',
    'Conference attendees use the same eVisa/VOA framework as business travellers.',
    'Up to 30 days',
    'Apply online for the eVisa in advance, or obtain a Visa on Arrival at major entry points',
    0,
    'Not applicable beyond standard entry documentation.',
    'No dedicated Indian-facing consular office required for short visits',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nCarry conference invitation/registration confirmation\nApply online for the eVisa, or plan to obtain a Visa on Arrival\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/visa/laos-visa', '2026-09-19'
);
SET @lao8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lao8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lao8, 'Core Documents', 'Required from every applicant.', 1);
SET @lao8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lao8s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lao8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lao8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lao8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lao8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lao8s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(77, 8, 35.00, 'USD', 'eVisa Fee', 'Same USD 35 eVisa fee range as the business visa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/laos-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Laos?', 'No separate conference visa — the same eVisa/VOA framework applies as for business travel.', 77, 8, 7780, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    77, 9, 'LAO-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Laos.',
    'Sports travellers use the same eVisa/VOA framework as tourists.',
    'Up to 30 days',
    'Apply online for the eVisa in advance, or obtain a Visa on Arrival at major entry points',
    0,
    'Not applicable beyond standard entry documentation.',
    'No dedicated Indian-facing consular office required for short visits',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nCarry event invitation/participation confirmation\nApply online for the eVisa, or plan to obtain a Visa on Arrival\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/visa/laos-visa', '2026-09-19'
);
SET @lao9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lao9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lao9, 'Core Documents', 'Required from every applicant.', 1);
SET @lao9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lao9s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lao9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lao9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lao9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lao9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lao9s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(77, 9, 35.00, 'USD', 'eVisa Fee', 'Same USD 35 eVisa fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/laos-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Laos?', 'No separate sports visa — the same eVisa/VOA framework applies as for tourist travel.', 77, 9, 7790, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    77, 10, 'LAO-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Laos work/student visa.',
    'Dependants apply through the Laos Embassy, referencing the primary permit holder\'s status; longer stays follow the same stay-permit process.',
    'Tied to the primary permit holder\'s validity',
    'Apply through the Laos Embassy, New Delhi, referencing the primary permit holder\'s status',
    1,
    'Not independently confirmed this session: exact dependant-visa fee and processing time — verify directly with the Laos Embassy, New Delhi.',
    'Embassy of Laos, New Delhi',
    'Confirm the primary permit holder\'s work/student visa status\nGather proof of relationship (marriage/birth certificate)\nApply through the Laos Embassy, New Delhi\nApply for a stay permit from the Foreigners Control Department if staying long-term\nRegister with local authorities on arrival',
    NULL,
    'tataaig.com secondary sourcing', 'https://www.tataaig.com/travel-insurance/laos-visa-for-indians', '2026-09-19'
);
SET @lao10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lao10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lao10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @lao10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lao10s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lao10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@lao10s1, 'Primary Permit Holder\'s Visa/Permit Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lao10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @lao10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lao10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lao10s2, 'Stay Permit Application (Foreigners Control Department)', NULL, 'original', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(77, 10, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session — verify with the Laos Embassy, New Delhi.', '2026-01-01', NOW(), 'https://www.tataaig.com/travel-insurance/laos-visa-for-indians', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependants accompany a work/student visa holder to Laos?', 'Yes, via a separate application through the Laos Embassy, New Delhi, referencing the primary permit holder\'s status.', 77, 10, 7700, 1);
