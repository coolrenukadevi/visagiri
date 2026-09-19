-- Libya Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Libya's real, distinctive facts verified this session:
--   - CRITICAL SAFETY CAVEAT: the Government of India (mea.gov.in) has
--     advised Indian nationals to avoid travelling to Libya AND
--     explicitly not to take up ANY employment there, due to the
--     deteriorating security situation. The US similarly maintains a
--     Level 4 "Do Not Travel" advisory (reissued Aug 2026), citing
--     kidnapping, terrorism, landmines, and armed conflict — there is
--     no US Embassy operating in Libya at all. This is flagged
--     prominently in every visa type below, especially Work.
--   - Entry itself is significantly restricted for Indian passport
--     holders — some sourcing describes entry as not possible at all
--     in certain cases; this uncertainty is flagged rather than
--     glossed over.
--   - Fee sourcing conflict: one source cites a flat USD 25 government
--     fee (30-60 day processing); another cites a much wider USD
--     15-420 range depending on visa duration/entry type (1-month
--     single entry vs. 3/6-month multiple entry) — both are presented
--     with the range flagged as unresolved.
--   - Recommended to apply at least 63 days before departure.
--   - Passport must be valid 6+ months beyond arrival with 2+ blank
--     pages.
--
-- country_id 28 = Libya. visa_type_id: 1=Tourist, 2=Business,
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
    28, 1, 'LBY-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Libya.',
    'IMPORTANT: the Government of India advises against all travel to Libya due to a deteriorating security situation. Entry is also significantly restricted for Indian passport holders, with some sources describing entry as not possible in certain cases.',
    'Up to 30 days',
    'Apply through the Libyan Embassy, allowing 63+ days before departure',
    0,
    'Review the current MEA travel advisory for Libya before booking. Fee sourcing conflicts: USD 25 flat fee per one source, USD 15-420 range by duration per another.',
    'Embassy of Libya, India',
    'Review the current MEA travel advisory for Libya\nConfirm your passport is valid for 6+ months with 2+ blank pages\nApply through the Libyan Embassy at least 63 days before departure\nGather proof of return/onward ticket\nContact the embassy directly to confirm current entry feasibility',
    NULL,
    'mea.gov.in and passportsandvisas.com secondary sourcing', 'https://www.mea.gov.in/press-releases.htm?dtl/25791/Travel_Advisory_against_travel_to_Libya', '2026-09-19'
);
SET @lby1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lby1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lby1, 'Core Documents', 'Required from every applicant.', 1);
SET @lby1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lby1s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lby1s1, 'Approved Embassy Visa', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lby1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lby1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lby1s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@lby1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(28, 1, 25.00, 'USD', 'Government Fee (Sourcing Conflict Flagged)', 'One source cites a flat USD 25 fee; another cites USD 15-420 depending on duration/entry type (1-month single entry to 6-month multiple entry). Verify directly with the embassy.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/libya/indian-citizens/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is it safe to travel to Libya right now?', 'No — the Government of India advises against all travel to Libya due to a deteriorating security situation. The US similarly maintains a Level 4 Do Not Travel advisory citing kidnapping, terrorism, and armed conflict.', 28, 1, 2800, 1),
('Can Indian citizens always get a Libya visa?', 'Not reliably — entry is significantly restricted for Indian passport holders, and some sourcing describes entry as not possible in certain cases. Contact the Libyan Embassy directly to confirm current feasibility.', 28, 1, 2801, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    28, 2, 'LBY-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Libya.',
    'IMPORTANT: the Government of India advises against all travel to Libya. Business travellers use the same restricted embassy-visa framework as tourists.',
    'Up to 30 days',
    'Apply through the Libyan Embassy, allowing 63+ days before departure',
    0,
    'Review the current MEA travel advisory for Libya before booking.',
    'Embassy of Libya, India',
    'Review the current MEA travel advisory for Libya\nConfirm your passport is valid for 6+ months with 2+ blank pages\nApply through the Libyan Embassy at least 63 days before departure\nCarry a business invitation letter from the host organization\nContact the embassy directly to confirm current entry feasibility',
    NULL,
    'mea.gov.in secondary sourcing', 'https://www.mea.gov.in/press-releases.htm?dtl/25791/Travel_Advisory_against_travel_to_Libya', '2026-09-19'
);
SET @lby2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lby2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lby2, 'Core Documents', 'Required from every applicant.', 1);
SET @lby2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lby2s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lby2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lby2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @lby2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lby2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@lby2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(28, 2, 25.00, 'USD', 'Government Fee (Sourcing Conflict Flagged)', 'Same fee sourcing conflict as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/libya/indian-citizens/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Libya?', 'Yes — the same restricted embassy-visa framework applies. Given the current MEA advisory against travel, reconsider necessity before booking.', 28, 2, 2820, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    28, 3, 'LBY-STU-IN-01', '2026.09', 'published',
    'Academic study at a Libyan educational institution.',
    'IMPORTANT: the Government of India advises against all travel to Libya. Sources reviewed this session did not describe a dedicated student-visa category distinct from the general restricted embassy visa.',
    'Academic-program length',
    'Apply through the Libyan Embassy, with a university admission letter',
    1,
    'Review the current MEA travel advisory for Libya before committing to study there. Not independently confirmed: exact student-visa category.',
    'Embassy of Libya, India',
    'Review the current MEA travel advisory for Libya\nSecure admission from a Libyan educational institution\nApply through the Libyan Embassy at least 63 days before departure\nGather proof of sufficient funds\nContact the embassy directly to confirm current entry feasibility',
    NULL,
    'passportsandvisas.com secondary sourcing', 'https://www.passportsandvisas.com/visas/libya/indian-citizens/', '2026-09-19'
);
SET @lby3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lby3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lby3, 'Core Documents', 'Required from every applicant.', 1);
SET @lby3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lby3s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lby3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lby3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @lby3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lby3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lby3s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(28, 3, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/libya/indian-citizens/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should Indian students study in Libya given the current situation?', 'The Government of India advises against all travel to Libya due to a deteriorating security situation — this should be weighed heavily before committing to study there.', 28, 3, 2830, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    28, 4, 'LBY-WORK-IN-01', '2026.09', 'published',
    'Employment in Libya under a local employer.',
    'CRITICAL: the Government of India explicitly advises Indian nationals NOT to take up any employment in Libya, due to the deteriorating security situation — this is a direct, specific directive, not a general caution.',
    'Per work-visa validity',
    'Employer sends invitation letter and documents to the Libya Work Department',
    1,
    'The MEA explicitly advises against taking ANY employment in Libya. Review this advisory carefully before proceeding.',
    'Embassy of Libya, India',
    'Review the MEA advisory explicitly against taking employment in Libya\nIf proceeding despite the advisory, secure a job offer from a Libyan employer\nEmployer sends an invitation letter and your documents to the Libya Work Department\nApply through the Libyan Embassy for the work visa\nContact the embassy directly to confirm current feasibility',
    NULL,
    'mea.gov.in and visitworld.today secondary sourcing', 'https://mea.gov.in/press-releases?dtl%2F702%2FIndians_safe_in_Libya_avoid_nonessential_travel=', '2026-09-19'
);
SET @lby4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lby4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lby4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @lby4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lby4s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lby4s1, 'Employer Invitation Letter (to Libya Work Department)', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lby4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @lby4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lby4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@lby4s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(28, 4, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Work visa fees were not independently confirmed this session, and the MEA advises against taking any employment in Libya.', '2026-01-01', NOW(), 'https://mea.gov.in/press-releases?dtl%2F702%2FIndians_safe_in_Libya_avoid_nonessential_travel=', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the Government of India advise against working in Libya?', 'Yes — the MEA explicitly advises Indian nationals not to take up any employment in Libya, due to the deteriorating security situation. This is a direct directive, not a general caution.', 28, 4, 2840, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    28, 5, 'LBY-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Libya.',
    'IMPORTANT: the Government of India advises against all travel to Libya. Family visitors use the same restricted embassy-visa framework as tourists.',
    'Up to 30 days',
    'Apply through the Libyan Embassy, allowing 63+ days before departure',
    0,
    'Review the current MEA travel advisory for Libya before booking.',
    'Embassy of Libya, India',
    'Review the current MEA travel advisory for Libya\nConfirm your passport is valid for 6+ months with 2+ blank pages\nApply through the Libyan Embassy at least 63 days before departure\nCarry proof of relationship and host contact details\nContact the embassy directly to confirm current entry feasibility',
    NULL,
    'mea.gov.in secondary sourcing', 'https://www.mea.gov.in/press-releases.htm?dtl/25791/Travel_Advisory_against_travel_to_Libya', '2026-09-19'
);
SET @lby5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lby5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lby5, 'Core Documents', 'Required from every applicant.', 1);
SET @lby5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lby5s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lby5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lby5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lby5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lby5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 1),
(@lby5s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(28, 5, 25.00, 'USD', 'Government Fee (Sourcing Conflict Flagged)', 'Same fee sourcing conflict as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/libya/indian-citizens/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Libya?', 'Yes — the same restricted embassy-visa framework applies. Given the current MEA advisory against travel, review current conditions carefully.', 28, 5, 2850, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    28, 6, 'LBY-TRAN-IN-01', '2026.09', 'published',
    'Transit through Libya en route to another destination.',
    'IMPORTANT: given the MEA advisory against all travel to Libya, transit through Libya should be avoided wherever an alternative routing exists. Sources reviewed this session did not describe a transit exemption for Indian passport holders.',
    'Short transit only',
    'Apply through the Libyan Embassy in advance if there is any possibility of clearing immigration',
    0,
    'Review the current MEA travel advisory for Libya. Not independently confirmed: any transit exemption.',
    'Embassy of Libya, India',
    'Review the current MEA travel advisory for Libya\nSeek alternative routing avoiding Libya wherever possible\nConfirm your connecting flight and transit time\nApply for the visa in advance if there is any possibility of clearing immigration\nCarry your onward boarding pass and passport',
    NULL,
    'mea.gov.in secondary sourcing (transit exemption not independently confirmed)', 'https://www.mea.gov.in/press-releases.htm?dtl/25791/Travel_Advisory_against_travel_to_Libya', '2026-09-19'
);
SET @lby6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lby6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lby6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @lby6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lby6s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lby6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(28, 6, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Transit visa fee was not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.mea.gov.in/press-releases.htm?dtl/25791/Travel_Advisory_against_travel_to_Libya', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should Indian citizens transit through Libya?', 'Given the MEA advisory against all travel to Libya, seek alternative routing avoiding Libya wherever possible.', 28, 6, 2860, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    28, 7, 'LBY-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Libya.',
    'IMPORTANT: the Government of India advises against all travel to Libya. Libya is not typically a recommended destination for inbound medical travel given the security and infrastructure situation.',
    'Up to 30 days',
    'Apply through the Libyan Embassy, allowing 63+ days before departure',
    0,
    'Review the current MEA travel advisory for Libya. Verify treatment facility availability and safety directly.',
    'Embassy of Libya, India',
    'Review the current MEA travel advisory for Libya\nConfirm treatment and appointment directly with the Libyan medical facility\nApply through the Libyan Embassy at least 63 days before departure\nGather proof of sufficient funds\nContact the embassy directly to confirm current entry feasibility',
    NULL,
    'mea.gov.in secondary sourcing', 'https://www.mea.gov.in/press-releases.htm?dtl/25791/Travel_Advisory_against_travel_to_Libya', '2026-09-19'
);
SET @lby7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lby7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lby7, 'Core Documents', 'Required from every applicant.', 1);
SET @lby7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lby7s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lby7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lby7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lby7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lby7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lby7s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(28, 7, 25.00, 'USD', 'Government Fee (Sourcing Conflict Flagged)', 'Same fee sourcing conflict as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/libya/indian-citizens/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Libya?', 'No separate medical visa — the same restricted embassy-visa framework applies. Given the current MEA advisory, this is not a recommended destination for medical travel.', 28, 7, 2870, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    28, 8, 'LBY-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Libya.',
    'IMPORTANT: the Government of India advises against all travel to Libya. Conference attendees use the same restricted embassy-visa framework as business travellers.',
    'Up to 30 days',
    'Apply through the Libyan Embassy, allowing 63+ days before departure',
    0,
    'Review the current MEA travel advisory for Libya before booking.',
    'Embassy of Libya, India',
    'Review the current MEA travel advisory for Libya\nCarry conference invitation/registration confirmation\nApply through the Libyan Embassy at least 63 days before departure\nGather proof of sufficient funds\nContact the embassy directly to confirm current entry feasibility',
    NULL,
    'mea.gov.in secondary sourcing', 'https://www.mea.gov.in/press-releases.htm?dtl/25791/Travel_Advisory_against_travel_to_Libya', '2026-09-19'
);
SET @lby8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lby8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lby8, 'Core Documents', 'Required from every applicant.', 1);
SET @lby8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lby8s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lby8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lby8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lby8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lby8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lby8s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(28, 8, 25.00, 'USD', 'Government Fee (Sourcing Conflict Flagged)', 'Same fee sourcing conflict as the business visa applies.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/libya/indian-citizens/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Libya?', 'No separate conference visa — the same restricted embassy-visa framework applies. Given the current MEA advisory, reconsider necessity before booking.', 28, 8, 2880, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    28, 9, 'LBY-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Libya.',
    'IMPORTANT: the Government of India advises against all travel to Libya. Sports travellers use the same restricted embassy-visa framework as tourists.',
    'Up to 30 days',
    'Apply through the Libyan Embassy, allowing 63+ days before departure',
    0,
    'Review the current MEA travel advisory for Libya before booking.',
    'Embassy of Libya, India',
    'Review the current MEA travel advisory for Libya\nCarry event invitation/participation confirmation\nApply through the Libyan Embassy at least 63 days before departure\nGather proof of sufficient funds\nContact the embassy directly to confirm current entry feasibility',
    NULL,
    'mea.gov.in secondary sourcing', 'https://www.mea.gov.in/press-releases.htm?dtl/25791/Travel_Advisory_against_travel_to_Libya', '2026-09-19'
);
SET @lby9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lby9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lby9, 'Core Documents', 'Required from every applicant.', 1);
SET @lby9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lby9s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lby9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lby9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lby9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lby9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lby9s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(28, 9, 25.00, 'USD', 'Government Fee (Sourcing Conflict Flagged)', 'Same fee sourcing conflict as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/libya/indian-citizens/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Libya?', 'No separate sports visa — the same restricted embassy-visa framework applies. Given the current MEA advisory, reconsider necessity before booking.', 28, 9, 2890, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    28, 10, 'LBY-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Libya work/residence visa.',
    'CRITICAL: the MEA explicitly advises against any employment in Libya, which extends to reconsidering whether dependants should join a primary permit holder there at all given the security situation.',
    'Tied to the primary permit holder\'s visa validity',
    'Apply through the Libyan Embassy, referencing the primary permit holder\'s status',
    1,
    'Review the MEA advisory explicitly against employment and travel to Libya before proceeding.',
    'Embassy of Libya, India',
    'Review the MEA advisory against travel and employment in Libya\nConfirm the primary permit holder\'s visa status\nGather proof of relationship (marriage/birth certificate)\nApply through the Libyan Embassy\nContact the embassy directly to confirm current entry feasibility',
    NULL,
    'mea.gov.in secondary sourcing', 'https://mea.gov.in/press-releases?dtl%2F702%2FIndians_safe_in_Libya_avoid_nonessential_travel=', '2026-09-19'
);
SET @lby10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lby10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lby10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @lby10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lby10s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lby10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@lby10s1, 'Primary Permit Holder\'s Visa Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lby10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @lby10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lby10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lby10s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(28, 10, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session, and the MEA advises against employment/travel to Libya.', '2026-01-01', NOW(), 'https://mea.gov.in/press-releases?dtl%2F702%2FIndians_safe_in_Libya_avoid_nonessential_travel=', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should dependants join a work-visa holder in Libya?', 'Given the MEA advisory explicitly against employment and travel in Libya, this should be very carefully reconsidered before proceeding.', 28, 10, 2800, 1);
