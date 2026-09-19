-- Iran Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Iran's real, distinctive facts verified this session:
--   - CRITICAL SAFETY CAVEAT, more urgent than any prior country this
--     project has covered: the Ministry of External Affairs, Government
--     of India, issued an escalating series of advisories through 2026
--     — 5 Jan 2026 (avoid non-essential travel amid nationwide
--     protests), 14 Jan 2026 (Indian nationals in Iran advised to
--     leave), 23 Apr 2026 (MEA advised Indians "not to travel to Iran,
--     whether by air or land," with India airlifting 600+ citizens
--     out), and 19 Jul 2026 (travel should be postponed until the
--     security environment improves). This is flagged directly and
--     prominently in eligibility_summary/processing_note for every
--     visa type below — sourced from mea.gov.in and newsonair.gov.in —
--     rather than treated as a footnote to the visa procedure.
--   - Distinctive, very recent policy change: Iran suspended its
--     visa-waiver facility for ordinary Indian passport holders
--     effective 22 November 2025, and visa-on-arrival for Indians has
--     also been suspended. Indian citizens must now obtain a visa in
--     advance (eVisa via evisa.mfa.ir, or through the Iranian Embassy/
--     Consulate in New Delhi) before travelling — a marked change from
--     the VOA-based access most secondary sources still describe.
--   - Mandatory travel health insurance (via Iran Insurance Company)
--     has been required for all visa applicants since May 2024, issued
--     by email within about 3 hours of visa approval.
--   - Visa approval is issued as an "Authorization Code"/Visa Grant
--     Notice from Iran's MFA, valid for one month, which must then be
--     used to collect the physical visa.
--   - Student visas route separately: admission from a recognized
--     Iranian university first, then a Certificate of Eligibility
--     endorsed by the Ministry of Science, Research and Technology
--     (MSRT) or the Ministry of Health and Medical Education (MOHME)
--     before the visa application itself.
--
-- country_id 69 = Iran. visa_type_id: 1=Tourist, 2=Business,
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
    69, 1, 'IRN-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Iran.',
    'IMPORTANT: the Government of India has repeatedly advised against travel to Iran through 2026 amid nationwide unrest, most recently on 19 July 2026, urging postponement until the security environment improves. Separately, Iran suspended its visa waiver and visa-on-arrival for Indians from 22 November 2025 — a visa must now be obtained in advance.',
    'Per visa validity',
    'Apply online via evisa.mfa.ir, or through the Iranian Embassy/Consulate in New Delhi',
    0,
    'Review the current MEA travel advisory for Iran before booking. Mandatory travel health insurance required. Processing 3-14 days; the Authorization Code is valid for 1 month to collect the visa.',
    'Embassy of Iran / Iranian Consulate, New Delhi',
    'Review the current MEA travel advisory for Iran\nConfirm your passport is valid for 6+ months\nApply for the eVisa via evisa.mfa.ir, or apply through the Iranian Embassy/Consulate, New Delhi\nPurchase mandatory travel health insurance (issued via Iran Insurance Company)\nCollect your visa using the Authorization Code once approved',
    NULL,
    'mea.gov.in, btwvisas.com, and visitouriran.com secondary sourcing', 'https://www.mea.gov.in/advisories-details?75=', '2026-09-19'
);
SET @irn1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irn1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irn1, 'Core Documents', 'Required from every applicant.', 1);
SET @irn1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irn1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irn1s1, 'Visa Authorization Code / Grant Notice', NULL, 'copy', 1, 0, 1, 2),
(@irn1s1, 'Mandatory Travel Health Insurance', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irn1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @irn1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irn1s2, 'Passport-Size Photographs', NULL, 'original', 1, 0, 0, 1),
(@irn1s2, 'Hotel Booking Confirmation', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(69, 1, 60.00, 'EUR', 'Embassy Visa Fee', 'A separate EUR 90 airport/VOA figure appears in older sourcing, but visa-on-arrival for Indians has been suspended since November 2025 — the EUR 60 embassy/eVisa fee is the current applicable route.', '2026-01-01', NOW(), 'https://www.godigit.com/international-travel-insurance/visa/iran-visa-for-indians', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is it safe to travel to Iran right now?', 'The Government of India has repeatedly advised against travel to Iran through 2026 amid nationwide unrest, most recently on 19 July 2026, urging postponement until the security situation improves. Check the latest MEA advisory before booking.', 69, 1, 6900, 1),
('Can Indian citizens still get a visa on arrival in Iran?', 'No — Iran suspended visa-on-arrival and its prior visa-waiver facility for ordinary Indian passport holders effective 22 November 2025. A visa must now be obtained in advance via eVisa or the Iranian Embassy/Consulate in New Delhi.', 69, 1, 6901, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    69, 2, 'IRN-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Iran.',
    'IMPORTANT: the Government of India has advised against travel to Iran through 2026 amid ongoing unrest. Business travellers use the same advance-visa framework as tourists, with a business invitation letter in addition.',
    'Per visa validity',
    'Apply through the Iranian Embassy/Consulate in New Delhi, with a business invitation letter',
    0,
    'Review the current MEA travel advisory for Iran before booking. Mandatory travel health insurance required.',
    'Embassy of Iran / Iranian Consulate, New Delhi',
    'Review the current MEA travel advisory for Iran\nConfirm your passport is valid for 6+ months\nObtain a business invitation letter from the host organization in Iran\nApply through the Iranian Embassy/Consulate, New Delhi\nPurchase mandatory travel health insurance',
    NULL,
    'mea.gov.in and btwvisas.com secondary sourcing', 'https://www.mea.gov.in/advisories-details?75=', '2026-09-19'
);
SET @irn2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irn2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irn2, 'Core Documents', 'Required from every applicant.', 1);
SET @irn2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irn2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irn2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2),
(@irn2s1, 'Mandatory Travel Health Insurance', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irn2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @irn2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irn2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@irn2s2, 'Passport-Size Photographs', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(69, 2, 60.00, 'EUR', 'Embassy Visa Fee', 'Same EUR 60 embassy fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.godigit.com/international-travel-insurance/visa/iran-visa-for-indians', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Iran?', 'Yes — apply in advance via the Iranian Embassy/Consulate in New Delhi with a business invitation letter; visa-on-arrival is suspended.', 69, 2, 6920, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    69, 3, 'IRN-STU-IN-01', '2026.09', 'published',
    'Academic study at an Iranian educational institution.',
    'IMPORTANT: review the current MEA travel advisory before committing to study in Iran. Student visas cannot be applied for directly online — admission from a recognized Iranian university is required first, followed by a Certificate of Eligibility.',
    'Academic-program length, renewable',
    'Secure university admission, obtain a Certificate of Eligibility from MSRT/MOHME, then apply through the Iranian Embassy/Consulate, New Delhi',
    1,
    'Review the current MEA travel advisory for Iran. The Certificate of Eligibility is endorsed by the Ministry of Science, Research and Technology (MSRT) or the Ministry of Health and Medical Education (MOHME) depending on your field of study.',
    'Embassy of Iran / Iranian Consulate, New Delhi',
    'Review the current MEA travel advisory for Iran\nSecure admission from a recognized Iranian university\nObtain a Certificate of Eligibility from MSRT (general study) or MOHME (medical study)\nApply through the Iranian Embassy/Consulate, New Delhi\nPurchase mandatory travel health insurance',
    NULL,
    'iranianvisa.com and tappersia.com secondary sourcing', 'https://www.iranianvisa.com/visa/student-visa', '2026-09-19'
);
SET @irn3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irn3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irn3, 'Core Documents', 'Required from every applicant.', 1);
SET @irn3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irn3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irn3s1, 'University Admission Letter', NULL, 'original', 1, 0, 1, 2),
(@irn3s1, 'Certificate of Eligibility (MSRT/MOHME)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irn3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @irn3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irn3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@irn3s2, 'Mandatory Travel Health Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(69, 3, 0.00, 'EUR', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session — verify with the Iranian Embassy/Consulate, New Delhi.', '2026-01-01', NOW(), 'https://www.iranianvisa.com/visa/student-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for an Iran student visa directly online?', 'No — unlike the tourist eVisa, student visas require university admission and a Certificate of Eligibility from MSRT or MOHME first, then an embassy application.', 69, 3, 6930, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    69, 4, 'IRN-WORK-IN-01', '2026.09', 'published',
    'Employment in Iran under a local sponsor/employer.',
    'IMPORTANT: review the current MEA travel advisory before accepting employment in Iran. Work visas require sponsorship from an Iranian employer and MFA authorization before travel; detailed procedural specifics were not extensively sourced this session.',
    'Per work-permit validity, renewable',
    'Employer/sponsor initiates the work-visa authorization with Iran\'s MFA; apply through the Iranian Embassy/Consulate, New Delhi',
    1,
    'Review the current MEA travel advisory for Iran. Not independently confirmed this session: exact work-permit fee and processing time — verify directly with the Iranian Embassy/Consulate, New Delhi.',
    'Embassy of Iran / Iranian Consulate, New Delhi',
    'Review the current MEA travel advisory for Iran\nSecure a sponsoring employer in Iran\nEmployer initiates work-visa authorization with Iran\'s Ministry of Foreign Affairs\nApply through the Iranian Embassy/Consulate, New Delhi, once authorized\nPurchase mandatory travel health insurance',
    NULL,
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/iran-visa', '2026-09-19'
);
SET @irn4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irn4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irn4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @irn4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irn4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irn4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2),
(@irn4s1, 'MFA Work-Visa Authorization', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irn4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @irn4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irn4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@irn4s2, 'Mandatory Travel Health Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(69, 4, 0.00, 'EUR', 'Fee Not Independently Confirmed', 'Work-visa fees were not independently confirmed this session — verify with the Iranian Embassy/Consulate, New Delhi.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/iran-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How do I get a work visa for Iran as an Indian citizen?', 'Your Iranian employer must initiate a work-visa authorization with Iran\'s Ministry of Foreign Affairs; you then apply through the Iranian Embassy/Consulate in New Delhi once authorized.', 69, 4, 6940, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    69, 5, 'IRN-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Iran.',
    'IMPORTANT: the Government of India has advised against travel to Iran through 2026 amid ongoing unrest. Family visitors use the same advance-visa framework as tourists.',
    'Per visa validity',
    'Apply online via evisa.mfa.ir, or through the Iranian Embassy/Consulate in New Delhi',
    0,
    'Review the current MEA travel advisory for Iran before booking. Mandatory travel health insurance required.',
    'Embassy of Iran / Iranian Consulate, New Delhi',
    'Review the current MEA travel advisory for Iran\nConfirm your passport is valid for 6+ months\nApply for the eVisa via evisa.mfa.ir, or apply through the Iranian Embassy/Consulate, New Delhi\nCarry proof of relationship and host contact details\nPurchase mandatory travel health insurance',
    NULL,
    'mea.gov.in and btwvisas.com secondary sourcing', 'https://www.mea.gov.in/advisories-details?75=', '2026-09-19'
);
SET @irn5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irn5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irn5, 'Core Documents', 'Required from every applicant.', 1);
SET @irn5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irn5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irn5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irn5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @irn5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irn5s2, 'Mandatory Travel Health Insurance', NULL, 'copy', 1, 0, 0, 1),
(@irn5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(69, 5, 60.00, 'EUR', 'Embassy Visa Fee', 'Same EUR 60 embassy fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.godigit.com/international-travel-insurance/visa/iran-visa-for-indians', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Iran?', 'Yes, applied in advance — visa-on-arrival for Indians is suspended. Review the current MEA travel advisory before travelling.', 69, 5, 6950, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    69, 6, 'IRN-TRAN-IN-01', '2026.09', 'published',
    'Transit through Iran en route to another destination.',
    'IMPORTANT: given the current MEA advisory against travel to Iran, even brief transit should be reconsidered. Sources reviewed this session did not confirm a separate airside-only transit exemption for Indian passport holders following the November 2025 visa-waiver suspension.',
    'Short transit only, per visa validity',
    'Apply for a transit visa via evisa.mfa.ir or the Iranian Embassy/Consulate, New Delhi, before transiting',
    0,
    'Review the current MEA travel advisory for Iran. Not independently confirmed this session whether airside-only transit is exempt — verify with your airline before relying on it.',
    'Embassy of Iran / Iranian Consulate, New Delhi',
    'Review the current MEA travel advisory for Iran\nConfirm your connecting flight and transit time\nApply for a transit visa if there is any possibility of clearing immigration\nCarry your onward boarding pass and passport\nConfirm airside-only transit exemptions directly with your airline',
    NULL,
    'mea.gov.in secondary sourcing (transit exemption not independently confirmed)', 'https://www.mea.gov.in/advisories-details?75=', '2026-09-19'
);
SET @irn6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irn6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irn6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @irn6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irn6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irn6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(69, 6, 0.00, 'EUR', 'Fee Not Independently Confirmed', 'Transit visa fee was not independently confirmed this session — verify with the Iranian Embassy/Consulate, New Delhi.', '2026-01-01', NOW(), 'https://www.mea.gov.in/advisories-details?75=', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Iran?', 'Not independently confirmed this session whether airside-only transit is exempt following the November 2025 visa-waiver suspension. Given the current MEA advisory, transit through Iran should be reconsidered.', 69, 6, 6960, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    69, 7, 'IRN-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Iran.',
    'IMPORTANT: the Government of India has advised against travel to Iran through 2026 amid ongoing unrest — verify current conditions before committing to treatment travel. Medical travellers use the same advance-visa framework as tourists.',
    'Per visa validity',
    'Apply online via evisa.mfa.ir, or through the Iranian Embassy/Consulate in New Delhi',
    0,
    'Review the current MEA travel advisory for Iran before booking. Mandatory travel health insurance required.',
    'Embassy of Iran / Iranian Consulate, New Delhi',
    'Review the current MEA travel advisory for Iran\nConfirm treatment and appointment directly with the Iranian medical facility\nApply for the eVisa via evisa.mfa.ir, or apply through the Iranian Embassy/Consulate, New Delhi\nPurchase mandatory travel health insurance\nCarry all medical and travel documents for immigration',
    NULL,
    'mea.gov.in and btwvisas.com secondary sourcing', 'https://www.mea.gov.in/advisories-details?75=', '2026-09-19'
);
SET @irn7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irn7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irn7, 'Core Documents', 'Required from every applicant.', 1);
SET @irn7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irn7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irn7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irn7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @irn7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irn7s2, 'Mandatory Travel Health Insurance', NULL, 'copy', 1, 0, 0, 1),
(@irn7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(69, 7, 60.00, 'EUR', 'Embassy Visa Fee', 'Same EUR 60 embassy fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.godigit.com/international-travel-insurance/visa/iran-visa-for-indians', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Iran?', 'Yes, applied in advance like a tourist visa — visa-on-arrival is suspended. Given the current MEA advisory, verify current security conditions before committing to treatment travel.', 69, 7, 6970, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    69, 8, 'IRN-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Iran.',
    'IMPORTANT: the Government of India has advised against travel to Iran through 2026 amid ongoing unrest. Conference attendees use the same advance-visa framework as business travellers.',
    'Per visa validity',
    'Apply through the Iranian Embassy/Consulate in New Delhi, with a conference invitation letter',
    0,
    'Review the current MEA travel advisory for Iran before booking. Mandatory travel health insurance required.',
    'Embassy of Iran / Iranian Consulate, New Delhi',
    'Review the current MEA travel advisory for Iran\nCarry conference invitation/registration confirmation\nApply through the Iranian Embassy/Consulate, New Delhi\nPurchase mandatory travel health insurance\nCarry all documents for immigration on arrival',
    NULL,
    'mea.gov.in and btwvisas.com secondary sourcing', 'https://www.mea.gov.in/advisories-details?75=', '2026-09-19'
);
SET @irn8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irn8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irn8, 'Core Documents', 'Required from every applicant.', 1);
SET @irn8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irn8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irn8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irn8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @irn8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irn8s2, 'Mandatory Travel Health Insurance', NULL, 'copy', 1, 0, 0, 1),
(@irn8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(69, 8, 60.00, 'EUR', 'Embassy Visa Fee', 'Same EUR 60 embassy fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.godigit.com/international-travel-insurance/visa/iran-visa-for-indians', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Iran?', 'No separate conference visa — the same advance-visa framework applies as for business travel.', 69, 8, 6980, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    69, 9, 'IRN-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Iran.',
    'IMPORTANT: the Government of India has advised against travel to Iran through 2026 amid ongoing unrest. Sports travellers use the same advance-visa framework as tourists.',
    'Per visa validity',
    'Apply online via evisa.mfa.ir, or through the Iranian Embassy/Consulate in New Delhi',
    0,
    'Review the current MEA travel advisory for Iran before booking. Mandatory travel health insurance required.',
    'Embassy of Iran / Iranian Consulate, New Delhi',
    'Review the current MEA travel advisory for Iran\nCarry event invitation/participation confirmation\nApply for the eVisa via evisa.mfa.ir, or apply through the Iranian Embassy/Consulate, New Delhi\nPurchase mandatory travel health insurance\nCarry all documents for immigration on arrival',
    NULL,
    'mea.gov.in and btwvisas.com secondary sourcing', 'https://www.mea.gov.in/advisories-details?75=', '2026-09-19'
);
SET @irn9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irn9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irn9, 'Core Documents', 'Required from every applicant.', 1);
SET @irn9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irn9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irn9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irn9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @irn9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irn9s2, 'Mandatory Travel Health Insurance', NULL, 'copy', 1, 0, 0, 1),
(@irn9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(69, 9, 60.00, 'EUR', 'Embassy Visa Fee', 'Same EUR 60 embassy fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.godigit.com/international-travel-insurance/visa/iran-visa-for-indians', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Iran?', 'No separate sports visa — the same advance-visa framework applies as for tourist travel.', 69, 9, 6990, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    69, 10, 'IRN-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds an Iranian work/student visa.',
    'IMPORTANT: the Government of India has advised against travel to Iran through 2026 amid ongoing unrest. Dependants apply through the Iranian Embassy/Consulate, referencing the primary visa/permit holder\'s approval.',
    'Tied to the primary visa/permit holder\'s validity',
    'Apply through the Iranian Embassy/Consulate, New Delhi, referencing the primary permit holder\'s approval',
    1,
    'Review the current MEA travel advisory for Iran. Not independently confirmed this session: exact dependant-visa fee and processing time.',
    'Embassy of Iran / Iranian Consulate, New Delhi',
    'Review the current MEA travel advisory for Iran\nConfirm the primary visa/permit holder\'s status in Iran\nGather proof of relationship (marriage/birth certificate)\nApply through the Iranian Embassy/Consulate, New Delhi\nPurchase mandatory travel health insurance',
    NULL,
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/iran-visa', '2026-09-19'
);
SET @irn10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irn10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irn10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @irn10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irn10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irn10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@irn10s1, 'Primary Permit Holder\'s Visa/Permit Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irn10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @irn10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irn10s2, 'Mandatory Travel Health Insurance', NULL, 'copy', 1, 0, 0, 1),
(@irn10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(69, 10, 0.00, 'EUR', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session — verify with the Iranian Embassy/Consulate, New Delhi.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/iran-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependants accompany a work/student visa holder to Iran?', 'Yes, via a separate application through the Iranian Embassy/Consulate, New Delhi, referencing the primary permit holder\'s approval. Given the current MEA advisory, review current security conditions before travelling.', 69, 10, 6900, 1);
