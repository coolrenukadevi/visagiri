-- Namibia Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Namibia's real, distinctive facts verified this session:
--   - Major, very recent policy reversal: effective 1 April 2025,
--     Namibia ended its visa-exemption policy for 33 countries
--     including India — ordinary Indian passport holders can no
--     longer enter visa-free. Diplomatic/official Indian passport
--     holders retain a 3-month visa-free privilege, a distinction
--     worth flagging since most travellers hold ordinary passports.
--   - An online eVisa system launched the same month (April 2025);
--     applications can also be submitted at the High Commission of
--     Namibia, New Delhi.
--   - Fee: NAD 1,600 (~USD 90/EUR 80/GBP 65). Sourcing conflict on
--     processing time flagged: one source cites 7-10 working days,
--     another 3-4 working days — recommend applying 4-6 weeks ahead
--     regardless.
--   - Any employment, business activity, training, audits, or
--     volunteer work requires a proper work permit — a tourist visa
--     is explicitly insufficient.
--
-- country_id 36 = Namibia. visa_type_id: 1=Tourist, 2=Business,
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
    36, 1, 'NAM-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Namibia.',
    'Ordinary Indian passport holders now require a visa for Namibia — visa-free entry for India ended 1 April 2025. Diplomatic/official Indian passport holders retain a 3-month visa-free privilege.',
    'Per visa validity',
    'Apply online via the eVisa portal, or through the High Commission of Namibia, New Delhi',
    0,
    'Apply 4-6 weeks ahead. Sources disagree on processing time (3-4 vs. 7-10 working days).',
    'High Commission of Namibia, New Delhi',
    'Confirm your passport is valid for 6+ months\nApply online via the eVisa portal, or apply through the High Commission of Namibia, New Delhi\nGather flight bookings, hotel reservations, and bank statements\nPurchase travel insurance\nApply 4-6 weeks before travel',
    '/assets/images/visa-heroes/namibia.webp',
    'btwvisas.com and itzeazy.in secondary sourcing', 'https://btwvisas.com/visa-guide/namibia-visa/', '2026-09-19'
);
SET @nam1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nam1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nam1, 'Core Documents', 'Required from every applicant.', 1);
SET @nam1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nam1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nam1s1, 'Approved eVisa or Embassy Visa', NULL, 'copy', 1, 0, 1, 2),
(@nam1s1, 'Passport-Size Photographs', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nam1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @nam1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nam1s2, 'Flight Bookings', NULL, 'copy', 1, 0, 0, 1),
(@nam1s2, 'Hotel Reservations', NULL, 'copy', 1, 0, 0, 2),
(@nam1s2, 'Bank Statements', NULL, 'original', 1, 0, 0, 3),
(@nam1s2, 'Travel Insurance', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(36, 1, 1600.00, 'NAD', 'Tourist Visa Fee', 'Approximately USD 90 / EUR 80 / GBP 65 at typical exchange rates.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/namibia-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Namibia?', 'Yes, for ordinary passport holders — Namibia ended visa-free entry for India effective 1 April 2025. Diplomatic/official Indian passport holders retain a 3-month visa-free privilege.', 36, 1, 3600, 1),
('Has Namibia always required a visa for Indians?', 'No — this is a recent policy change. Namibia ended its visa-exemption policy for 33 countries including India on 1 April 2025, alongside launching a new eVisa system.', 36, 1, 3601, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    36, 2, 'NAM-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Namibia.',
    'Business travellers use the same eVisa/embassy-visa framework as tourists, with a business invitation letter as additional support.',
    'Per visa validity',
    'Apply online via the eVisa portal, or through the High Commission of Namibia, New Delhi',
    0,
    'Apply 4-6 weeks ahead.',
    'High Commission of Namibia, New Delhi',
    'Confirm your passport is valid for 6+ months\nApply online via the eVisa portal, or apply through the High Commission of Namibia, New Delhi\nCarry a business invitation letter from the host organization\nGather bank statements\nApply 4-6 weeks before travel',
    '/assets/images/visa-heroes/namibia.webp',
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/namibia-visa/', '2026-09-19'
);
SET @nam2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nam2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nam2, 'Core Documents', 'Required from every applicant.', 1);
SET @nam2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nam2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nam2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nam2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @nam2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nam2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@nam2s2, 'Bank Statements', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(36, 2, 1600.00, 'NAD', 'Business Visa Fee', 'Same NAD 1,600 fee as the tourist visa applies.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/namibia-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Namibia?', 'Yes — the same eVisa/embassy-visa framework applies, with a business invitation letter recommended.', 36, 2, 3620, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    36, 3, 'NAM-STU-IN-01', '2026.09', 'published',
    'Academic study at a Namibia educational institution.',
    'Sources reviewed this session did not describe a dedicated Namibia student-visa category distinct from the general embassy visa process, applied for once admission is secured.',
    'Study-program length, renewable',
    'Apply through the High Commission of Namibia, New Delhi, with a university admission letter',
    1,
    'Not independently confirmed this session whether a distinct student-visa category exists.',
    'High Commission of Namibia, New Delhi',
    'Confirm admission with a Namibia educational institution\nGather passport, admission letter, and proof of funds\nApply through the High Commission of Namibia, New Delhi\nRegister with local authorities after arrival if required\nRenew your visa as needed for continued study',
    '/assets/images/visa-heroes/namibia.webp',
    'chaloafrica.com secondary sourcing', 'https://www.chaloafrica.com/namibia-visas/', '2026-09-19'
);
SET @nam3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nam3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nam3, 'Core Documents', 'Required from every applicant.', 1);
SET @nam3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nam3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nam3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nam3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @nam3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nam3s2, 'Bank Statements', NULL, 'original', 1, 0, 0, 1),
(@nam3s2, 'Travel Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(36, 3, 0.00, 'NAD', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session — verify with the High Commission of Namibia, New Delhi.', '2026-01-01', NOW(), 'https://www.chaloafrica.com/namibia-visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for Namibia?', 'Not independently confirmed this session — apply through the general embassy visa process once admission is secured.', 36, 3, 3630, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    36, 4, 'NAM-WORK-IN-01', '2026.09', 'published',
    'Employment, training, audits, or volunteer work in Namibia under a local sponsor.',
    'Any form of employment, business activity, training, audits, or volunteer work requires a proper work permit — a tourist visa is explicitly insufficient.',
    'Per work-permit validity, renewable',
    'Employer/sponsor coordinates your work-permit application through the High Commission of Namibia, New Delhi',
    1,
    'Not independently confirmed this session: exact work-permit fee and processing time.',
    'High Commission of Namibia, New Delhi',
    'Secure a job offer or sponsorship from a Namibian entity\nGather employment contract/sponsorship letter\nApply through the High Commission of Namibia, New Delhi\nRegister with local labour authorities on arrival\nRenew your work permit as required for continued activity',
    '/assets/images/visa-heroes/namibia.webp',
    'itzeazy.in secondary sourcing', 'https://itzeazy.in/blog/2026/01/08/namibia-visa-for-indian/', '2026-09-19'
);
SET @nam4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nam4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nam4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @nam4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nam4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nam4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nam4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @nam4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nam4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@nam4s2, 'Bank Statements', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(36, 4, 0.00, 'NAD', 'Fee Not Independently Confirmed', 'Work permit fees were not independently confirmed this session — verify with the High Commission of Namibia, New Delhi.', '2026-01-01', NOW(), 'https://itzeazy.in/blog/2026/01/08/namibia-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Namibia on a tourist visa?', 'No — any form of employment, business activity, training, audits, or volunteer work requires a proper work permit; a tourist visa is explicitly insufficient.', 36, 4, 3640, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    36, 5, 'NAM-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Namibia.',
    'Family visitors use the same eVisa/embassy-visa framework as tourists.',
    'Per visa validity',
    'Apply online via the eVisa portal, or through the High Commission of Namibia, New Delhi',
    0,
    'Apply 4-6 weeks ahead.',
    'High Commission of Namibia, New Delhi',
    'Confirm your passport is valid for 6+ months\nApply online via the eVisa portal, or apply through the High Commission of Namibia, New Delhi\nCarry proof of relationship and host contact details\nGather bank statements\nApply 4-6 weeks before travel',
    '/assets/images/visa-heroes/namibia.webp',
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/namibia-visa/', '2026-09-19'
);
SET @nam5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nam5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nam5, 'Core Documents', 'Required from every applicant.', 1);
SET @nam5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nam5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nam5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nam5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @nam5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nam5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 1),
(@nam5s2, 'Bank Statements', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(36, 5, 1600.00, 'NAD', 'Family Visit Visa Fee', 'Same NAD 1,600 fee as the tourist visa applies.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/namibia-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Namibia?', 'Yes — the same eVisa/embassy-visa framework applies as for tourist travel.', 36, 5, 3650, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    36, 6, 'NAM-TRAN-IN-01', '2026.09', 'published',
    'Transit through Namibia en route to another destination.',
    'Sources reviewed this session did not describe a separate airside-only transit exemption for Indian passport holders following the April 2025 visa-exemption removal.',
    'Short transit only',
    'Apply for the eVisa in advance if clearing immigration',
    0,
    'Not independently confirmed this session whether an airside-only exemption exists — verify with your airline.',
    'High Commission of Namibia, New Delhi',
    'Confirm your connecting flight and transit time\nApply for the eVisa in advance if there is any possibility of clearing immigration\nCarry your onward boarding pass and passport\nConfirm airside-only transit exemptions directly with your airline',
    '/assets/images/visa-heroes/namibia.webp',
    'btwvisas.com secondary sourcing (transit exemption not independently confirmed)', 'https://btwvisas.com/visa-guide/namibia-visa/', '2026-09-19'
);
SET @nam6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nam6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nam6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @nam6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nam6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nam6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(36, 6, 1600.00, 'NAD', 'Visa Fee (If Clearing Immigration)', 'Airside-only transit exemption not independently confirmed this session — budget for the standard visa fee unless your airline confirms otherwise.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/namibia-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Namibia?', 'Not independently confirmed this session whether airside-only transit is exempt following the April 2025 policy change. If you may clear immigration, apply for the eVisa in advance.', 36, 6, 3660, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    36, 7, 'NAM-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Namibia.',
    'Medical travellers use the same eVisa/embassy-visa framework as tourists.',
    'Per visa validity',
    'Apply online via the eVisa portal, or through the High Commission of Namibia, New Delhi',
    0,
    'Confirm treatment and appointment directly with the Namibia medical facility before applying.',
    'High Commission of Namibia, New Delhi',
    'Confirm treatment and appointment directly with the Namibia medical facility\nApply online via the eVisa portal, or apply through the High Commission of Namibia, New Delhi\nGather bank statements and travel insurance\nApply 4-6 weeks before travel',
    '/assets/images/visa-heroes/namibia.webp',
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/namibia-visa/', '2026-09-19'
);
SET @nam7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nam7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nam7, 'Core Documents', 'Required from every applicant.', 1);
SET @nam7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nam7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nam7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nam7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @nam7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nam7s2, 'Bank Statements', NULL, 'original', 1, 0, 0, 1),
(@nam7s2, 'Travel Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(36, 7, 1600.00, 'NAD', 'Medical Visa Fee', 'Same NAD 1,600 fee as the tourist visa applies.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/namibia-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Namibia?', 'No separate medical visa — the same eVisa/embassy-visa framework applies as for tourist travel.', 36, 7, 3670, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    36, 8, 'NAM-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Namibia.',
    'Conference attendees use the same eVisa/embassy-visa framework as business travellers.',
    'Per visa validity',
    'Apply online via the eVisa portal, or through the High Commission of Namibia, New Delhi',
    0,
    'Apply 4-6 weeks ahead.',
    'High Commission of Namibia, New Delhi',
    'Confirm your passport is valid for 6+ months\nCarry conference invitation/registration confirmation\nApply online via the eVisa portal, or apply through the High Commission of Namibia, New Delhi\nGather bank statements\nApply 4-6 weeks before travel',
    '/assets/images/visa-heroes/namibia.webp',
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/namibia-visa/', '2026-09-19'
);
SET @nam8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nam8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nam8, 'Core Documents', 'Required from every applicant.', 1);
SET @nam8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nam8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nam8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nam8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @nam8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nam8s2, 'Bank Statements', NULL, 'original', 1, 0, 0, 1),
(@nam8s2, 'Travel Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(36, 8, 1600.00, 'NAD', 'Conference Visa Fee', 'Same NAD 1,600 fee as the business visa applies.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/namibia-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Namibia?', 'No separate conference visa — the same eVisa/embassy-visa framework applies as for business travel.', 36, 8, 3680, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    36, 9, 'NAM-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Namibia.',
    'Sports travellers use the same eVisa/embassy-visa framework as tourists.',
    'Per visa validity',
    'Apply online via the eVisa portal, or through the High Commission of Namibia, New Delhi',
    0,
    'Apply 4-6 weeks ahead.',
    'High Commission of Namibia, New Delhi',
    'Confirm your passport is valid for 6+ months\nCarry event invitation/participation confirmation\nApply online via the eVisa portal, or apply through the High Commission of Namibia, New Delhi\nGather bank statements\nApply 4-6 weeks before travel',
    '/assets/images/visa-heroes/namibia.webp',
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/namibia-visa/', '2026-09-19'
);
SET @nam9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nam9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nam9, 'Core Documents', 'Required from every applicant.', 1);
SET @nam9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nam9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nam9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nam9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @nam9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nam9s2, 'Bank Statements', NULL, 'original', 1, 0, 0, 1),
(@nam9s2, 'Travel Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(36, 9, 1600.00, 'NAD', 'Sports Visa Fee', 'Same NAD 1,600 fee as the tourist visa applies.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/namibia-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Namibia?', 'No separate sports visa — the same eVisa/embassy-visa framework applies as for tourist travel.', 36, 9, 3690, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    36, 10, 'NAM-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Namibia work permit.',
    'Dependants apply through the High Commission of Namibia, New Delhi, referencing the primary permit holder\'s status.',
    'Tied to the primary permit holder\'s permit validity',
    'Apply through the High Commission of Namibia, New Delhi, referencing the primary permit holder\'s status',
    1,
    'Not independently confirmed this session: exact dependant-visa fee and processing time.',
    'High Commission of Namibia, New Delhi',
    'Confirm the primary permit holder\'s work-permit status\nGather proof of relationship (marriage/birth certificate)\nApply through the High Commission of Namibia, New Delhi\nRegister with local authorities on arrival if required\nRenew your visa alongside the primary permit holder',
    '/assets/images/visa-heroes/namibia.webp',
    'itzeazy.in secondary sourcing', 'https://itzeazy.in/blog/2026/01/08/namibia-visa-for-indian/', '2026-09-19'
);
SET @nam10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nam10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nam10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @nam10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nam10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nam10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@nam10s1, 'Primary Permit Holder\'s Work Permit Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nam10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @nam10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nam10s2, 'Bank Statements', NULL, 'original', 1, 0, 0, 1),
(@nam10s2, 'Travel Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(36, 10, 0.00, 'NAD', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://itzeazy.in/blog/2026/01/08/namibia-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependants accompany a work-permit holder to Namibia?', 'Yes, via a separate application through the High Commission of Namibia, New Delhi, referencing the primary permit holder\'s status.', 36, 10, 3600, 1);
