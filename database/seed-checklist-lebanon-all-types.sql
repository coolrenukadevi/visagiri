-- Lebanon Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Lebanon's real, distinctive facts verified this session:
--   - CRITICAL SAFETY CAVEAT: the Ministry of External Affairs,
--     Government of India, has strongly advised Indian nationals
--     against travelling to Lebanon and has advised those already in
--     Lebanon to leave, per its March 2026 advisory amid regional
--     tensions — flagged prominently here rather than as a footnote,
--     sourced from mea.gov.in and the Indian Embassy, Beirut.
--   - Indian citizens require a visa for every purpose — there is no
--     visa-free or visa-on-arrival facility for Indian passport
--     holders (some outdated sources incorrectly suggest VOA exists).
--     Apply via VFS Global or the Lebanese Embassy, requiring
--     pre-approval from the General Directorate of General Security.
--   - Distinctive restriction: applicants holding an Israeli sticker
--     or visa in their passport cannot apply unless they obtain a new
--     passport without it.
--   - Distinctive Indian-side restriction: per Indian authorities'
--     request, work-visa applications from female Indian workers
--     under 30 years old are not accepted — sourced from
--     general-security.gov.lb.
--   - Work visas require Emigration Clearance (ECR/ECNR status on the
--     passport) processed via India's e-emigrate system, coordinated
--     with the Indian Embassy, Beirut.
--   - Fee: INR 8,250 (single entry) to INR 16,450 (multiple entry),
--     plus a VFS service fee of INR 1,500 and a Visa Application
--     Centre convenience charge of INR 150. Processing 5-7 working
--     days (Delhi) or 11-12 working days (other locations). Stay up to
--     30 days, extendable to 90 days within Lebanon.
--
-- country_id 78 = Lebanon. visa_type_id: 1=Tourist, 2=Business,
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
    78, 1, 'LBN-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Lebanon.',
    'IMPORTANT: the Government of India has strongly advised against travel to Lebanon since March 2026 amid regional tensions, and advised Indians already there to leave. Separately, Indian citizens require a visa for every purpose — there is no visa-on-arrival for Indian passport holders.',
    'Up to 30 days, extendable to 90 days',
    'Apply via VFS Global or the Lebanese Embassy, with pre-approval from the General Directorate of General Security',
    0,
    'Review the current MEA travel advisory for Lebanon before booking. Applicants with an Israeli sticker/visa in their passport cannot apply unless issued a new passport. Processing 5-7 working days (Delhi) or 11-12 days elsewhere.',
    'Embassy of Lebanon / VFS Global Lebanon Visa Application Centre, India',
    'Review the current MEA travel advisory for Lebanon\nConfirm your passport is valid for 6+ months and has no Israeli sticker/visa\nApply via VFS Global or the Lebanese Embassy\nGather proof of accommodation and General Security pre-approval\nCarry all documents for immigration on arrival',
    NULL,
    'mea.gov.in and btwvisas.com secondary sourcing', 'https://www.indianembassybeirut.gov.in/traveladvisoryforindiannationalsinlebanon', '2026-09-19'
);
SET @lbn1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbn1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbn1, 'Core Documents', 'Required from every applicant.', 1);
SET @lbn1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbn1s1, 'Valid Passport (6+ Months Validity, No Israeli Stamps/Visas)', NULL, 'original', 1, 0, 1, 1),
(@lbn1s1, 'General Directorate of General Security Pre-Approval', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbn1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lbn1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbn1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 1),
(@lbn1s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2),
(@lbn1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(78, 1, 8250.00, 'INR', 'Single-Entry Visa Fee', 'Multiple-entry visa costs INR 16,450. Add a VFS service fee of INR 1,500 and a INR 150 convenience charge.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/lebanon-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is it safe to travel to Lebanon right now?', 'The Government of India has strongly advised against travel to Lebanon since March 2026 amid regional tensions, and has advised Indians already there to leave. Check the latest MEA advisory before booking.', 78, 1, 7800, 1),
('Can Indian citizens get a visa on arrival in Lebanon?', 'No — despite some outdated sources suggesting otherwise, there is no visa-on-arrival for Indian passport holders. Apply in advance via VFS Global or the Lebanese Embassy.', 78, 1, 7801, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    78, 2, 'LBN-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Lebanon.',
    'IMPORTANT: review the current MEA travel advisory before booking business travel to Lebanon. Business travellers use the same visa framework as tourists, with a business invitation letter as additional support.',
    'Up to 30 days, extendable to 90 days',
    'Apply via VFS Global or the Lebanese Embassy, with pre-approval from the General Directorate of General Security',
    0,
    'Review the current MEA travel advisory for Lebanon before booking. Applicants with an Israeli sticker/visa in their passport cannot apply.',
    'Embassy of Lebanon / VFS Global Lebanon Visa Application Centre, India',
    'Review the current MEA travel advisory for Lebanon\nConfirm your passport is valid for 6+ months and has no Israeli sticker/visa\nApply via VFS Global or the Lebanese Embassy\nCarry a business invitation letter from the host organization\nGather General Security pre-approval documentation',
    NULL,
    'general-security.gov.lb secondary sourcing', 'https://www.general-security.gov.lb/en/posts/38', '2026-09-19'
);
SET @lbn2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbn2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbn2, 'Core Documents', 'Required from every applicant.', 1);
SET @lbn2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbn2s1, 'Valid Passport (6+ Months Validity, No Israeli Stamps/Visas)', NULL, 'original', 1, 0, 1, 1),
(@lbn2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbn2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @lbn2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbn2s2, 'General Directorate of General Security Pre-Approval', NULL, 'original', 1, 0, 0, 1),
(@lbn2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(78, 2, 8250.00, 'INR', 'Single-Entry Visa Fee', 'Same fee range as the tourist visa applies; multiple-entry costs INR 16,450.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/lebanon-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Lebanon?', 'Yes — the same visa framework applies, requiring pre-approval from the General Directorate of General Security. Review the current MEA travel advisory before travelling.', 78, 2, 7820, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    78, 3, 'LBN-STU-IN-01', '2026.09', 'published',
    'Academic study at a Lebanese educational institution.',
    'IMPORTANT: review the current MEA travel advisory before committing to study in Lebanon. Study visas route through the same embassy/VFS process with a university admission letter and General Security pre-approval.',
    'Academic-program length, renewable',
    'Apply via VFS Global or the Lebanese Embassy, with a university admission letter',
    1,
    'Review the current MEA travel advisory for Lebanon. Not independently confirmed this session: exact student-visa category fee.',
    'Embassy of Lebanon / VFS Global Lebanon Visa Application Centre, India',
    'Review the current MEA travel advisory for Lebanon\nSecure admission from a Lebanese educational institution\nConfirm your passport is valid for 6+ months and has no Israeli sticker/visa\nApply via VFS Global or the Lebanese Embassy\nGather General Security pre-approval and proof of funds',
    NULL,
    'general-security.gov.lb secondary sourcing', 'https://www.general-security.gov.lb/en/posts/38', '2026-09-19'
);
SET @lbn3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbn3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbn3, 'Core Documents', 'Required from every applicant.', 1);
SET @lbn3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbn3s1, 'Valid Passport (6+ Months Validity, No Israeli Stamps/Visas)', NULL, 'original', 1, 0, 1, 1),
(@lbn3s1, 'University Admission Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbn3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @lbn3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbn3s2, 'General Directorate of General Security Pre-Approval', NULL, 'original', 1, 0, 0, 1),
(@lbn3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(78, 3, 0.00, 'INR', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session — verify via VFS Global or the Lebanese Embassy.', '2026-01-01', NOW(), 'https://www.general-security.gov.lb/en/posts/38', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian students study in Lebanon?', 'Yes, subject to a visa via VFS Global/the Lebanese Embassy and General Security pre-approval — but review the current MEA travel advisory before committing given ongoing regional tensions.', 78, 3, 7830, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    78, 4, 'LBN-WORK-IN-01', '2026.09', 'published',
    'Employment in Lebanon under a local sponsor/employer.',
    'IMPORTANT: review the current MEA travel advisory before accepting employment in Lebanon. Distinctive restriction: per Indian authorities\' request, work-visa applications from female Indian workers under 30 years old are not accepted. Work visas require Emigration Clearance (ECR/ECNR) via India\'s e-emigrate system.',
    'Per work-permit/sponsorship validity',
    'Employer sponsors your work visa; obtain Emigration Clearance via e-emigrate.gov.in and coordinate with the Indian Embassy, Beirut',
    1,
    'Review the current MEA travel advisory for Lebanon. Female Indian workers under 30 years old are not accepted for work-visa applications per Indian authorities\' request.',
    'Embassy of Lebanon / VFS Global Lebanon Visa Application Centre, India; Embassy of India, Beirut (for e-emigrate coordination)',
    'Secure a job offer from a Lebanese employer/sponsor\nConfirm eligibility given the under-30 female-applicant restriction\nObtain Emigration Clearance (ECR/ECNR) via e-emigrate.gov.in\nApply for the work visa via VFS Global or the Lebanese Embassy\nReview the current MEA travel advisory for Lebanon before travelling',
    NULL,
    'general-security.gov.lb secondary sourcing', 'https://www.general-security.gov.lb/en/posts/63', '2026-09-19'
);
SET @lbn4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbn4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbn4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @lbn4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbn4s1, 'Valid Passport (6+ Months Validity, No Israeli Stamps/Visas)', NULL, 'original', 1, 0, 1, 1),
(@lbn4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2),
(@lbn4s1, 'e-Migrate Emigration Clearance (ECR/ECNR)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbn4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @lbn4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbn4s2, 'General Directorate of General Security Pre-Approval', NULL, 'original', 1, 0, 0, 1),
(@lbn4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(78, 4, 0.00, 'INR', 'Fee Not Independently Confirmed', 'Work visa fees vary by visa type and duration; not independently confirmed to a single figure this session.', '2026-01-01', NOW(), 'https://www.general-security.gov.lb/en/posts/63', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Are there restrictions on Indian work-visa applicants for Lebanon?', 'Yes — per Indian authorities\' request, work-visa applications from female Indian workers under 30 years old are not accepted. Emigration Clearance via e-emigrate is also required.', 78, 4, 7840, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    78, 5, 'LBN-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Lebanon.',
    'IMPORTANT: the Government of India has strongly advised against travel to Lebanon since March 2026. Family visitors use the same visa framework as tourists.',
    'Up to 30 days, extendable to 90 days',
    'Apply via VFS Global or the Lebanese Embassy, with pre-approval from the General Directorate of General Security',
    0,
    'Review the current MEA travel advisory for Lebanon before booking.',
    'Embassy of Lebanon / VFS Global Lebanon Visa Application Centre, India',
    'Review the current MEA travel advisory for Lebanon\nConfirm your passport is valid for 6+ months and has no Israeli sticker/visa\nApply via VFS Global or the Lebanese Embassy\nCarry proof of relationship and host contact details\nGather General Security pre-approval documentation',
    NULL,
    'mea.gov.in secondary sourcing', 'https://www.indianembassybeirut.gov.in/traveladvisoryforindiannationalsinlebanon', '2026-09-19'
);
SET @lbn5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbn5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbn5, 'Core Documents', 'Required from every applicant.', 1);
SET @lbn5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbn5s1, 'Valid Passport (6+ Months Validity, No Israeli Stamps/Visas)', NULL, 'original', 1, 0, 1, 1),
(@lbn5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbn5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lbn5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbn5s2, 'General Directorate of General Security Pre-Approval', NULL, 'original', 1, 0, 0, 1),
(@lbn5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(78, 5, 8250.00, 'INR', 'Single-Entry Visa Fee', 'Same fee range as the tourist visa applies; multiple-entry costs INR 16,450.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/lebanon-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Lebanon?', 'Yes — the same visa framework applies as for tourist travel. Given the current MEA advisory, review current security conditions before travelling.', 78, 5, 7850, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    78, 6, 'LBN-TRAN-IN-01', '2026.09', 'published',
    'Transit through Lebanon en route to another destination.',
    'IMPORTANT: given the current MEA advisory against travel to Lebanon, even brief transit should be reconsidered. Sources reviewed this session did not describe a separate airside-only transit exemption for Indian passport holders.',
    'Short transit only',
    'Apply via VFS Global or the Lebanese Embassy before transiting, if there is any possibility of clearing immigration',
    0,
    'Review the current MEA travel advisory for Lebanon. Not independently confirmed this session whether airside-only transit is exempt.',
    'Embassy of Lebanon / VFS Global Lebanon Visa Application Centre, India',
    'Review the current MEA travel advisory for Lebanon\nConfirm your connecting flight and transit time\nApply for the visa in advance if there is any possibility of clearing immigration\nCarry your onward boarding pass and passport\nConfirm transit exemptions directly with your airline',
    NULL,
    'mea.gov.in secondary sourcing (transit exemption not independently confirmed)', 'https://www.indianembassybeirut.gov.in/traveladvisoryforindiannationalsinlebanon', '2026-09-19'
);
SET @lbn6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbn6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbn6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @lbn6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbn6s1, 'Valid Passport (6+ Months Validity, No Israeli Stamps/Visas)', NULL, 'original', 1, 0, 1, 1),
(@lbn6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(78, 6, 0.00, 'INR', 'Fee Not Independently Confirmed', 'Transit visa fee was not independently confirmed this session — verify via VFS Global or the Lebanese Embassy.', '2026-01-01', NOW(), 'https://www.indianembassybeirut.gov.in/traveladvisoryforindiannationalsinlebanon', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Lebanon?', 'Not independently confirmed this session whether airside-only transit is exempt. Given the current MEA advisory, transit through Lebanon should be reconsidered.', 78, 6, 7860, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    78, 7, 'LBN-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Lebanon.',
    'IMPORTANT: the Government of India has strongly advised against travel to Lebanon since March 2026 — verify current conditions before committing to treatment travel. Medical travellers use the same visa framework as tourists.',
    'Up to 30 days, extendable to 90 days',
    'Apply via VFS Global or the Lebanese Embassy, with pre-approval from the General Directorate of General Security',
    0,
    'Review the current MEA travel advisory for Lebanon before booking.',
    'Embassy of Lebanon / VFS Global Lebanon Visa Application Centre, India',
    'Review the current MEA travel advisory for Lebanon\nConfirm treatment and appointment directly with the Lebanese medical facility\nApply via VFS Global or the Lebanese Embassy\nGather General Security pre-approval documentation\nCarry all medical and travel documents for immigration',
    NULL,
    'mea.gov.in secondary sourcing', 'https://www.indianembassybeirut.gov.in/traveladvisoryforindiannationalsinlebanon', '2026-09-19'
);
SET @lbn7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbn7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbn7, 'Core Documents', 'Required from every applicant.', 1);
SET @lbn7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbn7s1, 'Valid Passport (6+ Months Validity, No Israeli Stamps/Visas)', NULL, 'original', 1, 0, 1, 1),
(@lbn7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbn7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lbn7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbn7s2, 'General Directorate of General Security Pre-Approval', NULL, 'original', 1, 0, 0, 1),
(@lbn7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(78, 7, 8250.00, 'INR', 'Single-Entry Visa Fee', 'Same fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/lebanon-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Lebanon?', 'No separate medical visa — the same visa framework applies. Given the current MEA advisory, verify security conditions before travelling.', 78, 7, 7870, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    78, 8, 'LBN-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Lebanon.',
    'IMPORTANT: review the current MEA travel advisory before booking. Conference attendees use the same visa framework as business travellers.',
    'Up to 30 days, extendable to 90 days',
    'Apply via VFS Global or the Lebanese Embassy, with pre-approval from the General Directorate of General Security',
    0,
    'Review the current MEA travel advisory for Lebanon before booking.',
    'Embassy of Lebanon / VFS Global Lebanon Visa Application Centre, India',
    'Review the current MEA travel advisory for Lebanon\nCarry conference invitation/registration confirmation\nApply via VFS Global or the Lebanese Embassy\nGather General Security pre-approval documentation\nCarry all documents for immigration on arrival',
    NULL,
    'mea.gov.in secondary sourcing', 'https://www.indianembassybeirut.gov.in/traveladvisoryforindiannationalsinlebanon', '2026-09-19'
);
SET @lbn8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbn8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbn8, 'Core Documents', 'Required from every applicant.', 1);
SET @lbn8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbn8s1, 'Valid Passport (6+ Months Validity, No Israeli Stamps/Visas)', NULL, 'original', 1, 0, 1, 1),
(@lbn8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbn8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lbn8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbn8s2, 'General Directorate of General Security Pre-Approval', NULL, 'original', 1, 0, 0, 1),
(@lbn8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(78, 8, 8250.00, 'INR', 'Single-Entry Visa Fee', 'Same fee range as the business visa applies.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/lebanon-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Lebanon?', 'No separate conference visa — the same visa framework applies as for business travel.', 78, 8, 7880, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    78, 9, 'LBN-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Lebanon.',
    'IMPORTANT: review the current MEA travel advisory before booking. Sports travellers use the same visa framework as tourists.',
    'Up to 30 days, extendable to 90 days',
    'Apply via VFS Global or the Lebanese Embassy, with pre-approval from the General Directorate of General Security',
    0,
    'Review the current MEA travel advisory for Lebanon before booking.',
    'Embassy of Lebanon / VFS Global Lebanon Visa Application Centre, India',
    'Review the current MEA travel advisory for Lebanon\nCarry event invitation/participation confirmation\nApply via VFS Global or the Lebanese Embassy\nGather General Security pre-approval documentation\nCarry all documents for immigration on arrival',
    NULL,
    'mea.gov.in secondary sourcing', 'https://www.indianembassybeirut.gov.in/traveladvisoryforindiannationalsinlebanon', '2026-09-19'
);
SET @lbn9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbn9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbn9, 'Core Documents', 'Required from every applicant.', 1);
SET @lbn9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbn9s1, 'Valid Passport (6+ Months Validity, No Israeli Stamps/Visas)', NULL, 'original', 1, 0, 1, 1),
(@lbn9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbn9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lbn9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbn9s2, 'General Directorate of General Security Pre-Approval', NULL, 'original', 1, 0, 0, 1),
(@lbn9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(78, 9, 8250.00, 'INR', 'Single-Entry Visa Fee', 'Same fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/lebanon-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Lebanon?', 'No separate sports visa — the same visa framework applies as for tourist travel.', 78, 9, 7890, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    78, 10, 'LBN-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Lebanon work/residence visa.',
    'IMPORTANT: review the current MEA travel advisory before joining family in Lebanon. Dependants apply via VFS Global/the Lebanese Embassy, referencing the primary permit holder\'s status.',
    'Tied to the primary permit holder\'s visa validity',
    'Apply via VFS Global or the Lebanese Embassy, referencing the primary permit holder\'s status',
    1,
    'Review the current MEA travel advisory for Lebanon. Not independently confirmed this session: exact dependant-visa fee and processing time.',
    'Embassy of Lebanon / VFS Global Lebanon Visa Application Centre, India',
    'Review the current MEA travel advisory for Lebanon\nConfirm the primary permit holder\'s work/residence visa status\nGather proof of relationship (marriage/birth certificate)\nApply via VFS Global or the Lebanese Embassy\nGather General Security pre-approval documentation',
    NULL,
    'general-security.gov.lb secondary sourcing', 'https://www.general-security.gov.lb/en/posts/38', '2026-09-19'
);
SET @lbn10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbn10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbn10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @lbn10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbn10s1, 'Valid Passport (6+ Months Validity, No Israeli Stamps/Visas)', NULL, 'original', 1, 0, 1, 1),
(@lbn10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@lbn10s1, 'Primary Permit Holder\'s Visa Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbn10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @lbn10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbn10s2, 'General Directorate of General Security Pre-Approval', NULL, 'original', 1, 0, 0, 1),
(@lbn10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(78, 10, 0.00, 'INR', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session — verify via VFS Global or the Lebanese Embassy.', '2026-01-01', NOW(), 'https://www.general-security.gov.lb/en/posts/38', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependants accompany a work/residence visa holder to Lebanon?', 'Yes, via a separate application through VFS Global/the Lebanese Embassy, referencing the primary permit holder\'s status. Given the current MEA advisory, review current security conditions before travelling.', 78, 10, 7800, 1);
