-- Kosovo Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Kosovo's real, distinctive facts verified this session:
--   - Indian citizens require a visa for Kosovo for tourism and
--     business alike.
--   - Sourcing conflict flagged rather than silently resolved: one
--     source states a paper/embassy visa is the only option available
--     to travellers, while another describes a simplified online
--     e-Visa system for Indian applicants — the embassy/paper-visa
--     route is used as primary here since it is more consistently
--     corroborated, with the eVisa claim flagged as unconfirmed.
--   - Fee: EUR 40 for the standard (C) visa; EUR 80 for the longer-stay
--     D visa (used for work/residence purposes).
--   - Application in India routes through a Kosovo diplomatic mission
--     or an authorized visa agent — Abrodex India Private Limited, New
--     Delhi, is named as a premier authorized service provider for
--     Kosovo Embassy-related services in India.
--   - Airside transit through international airports typically does
--     not require a separate visa for Indian passport holders — a
--     visa is required only if leaving the international zone.
--   - Work in Kosovo requires both a work permit and a temporary
--     residence permit, regardless of visa-exemption status, sourced
--     from globalization-partners.com.
--
-- country_id 127 = Kosovo. visa_type_id: 1=Tourist, 2=Business,
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
    127, 1, 'XKX-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Kosovo.',
    'Indian citizens require a visa for Kosovo. Sources disagree on the application channel: one says a paper/embassy visa is the only option, another describes a simplified online eVisa for Indians — this conflict is flagged rather than resolved.',
    'Per visa validity',
    'Apply through a Kosovo diplomatic mission or authorized visa agent (Abrodex India Pvt Ltd, New Delhi)',
    0,
    'Not independently confirmed this session whether an eVisa option is genuinely available for Indians — verify directly before assuming online application is possible.',
    'Kosovo Embassy / authorized visa agent (Abrodex India Pvt Ltd), New Delhi',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nApply through a Kosovo diplomatic mission or authorized visa agent in New Delhi\nGather bank statements, salary slips, and an employment/leave letter\nBook accommodation and return/onward flights\nCarry travel insurance (recommended) and a cover letter stating your itinerary',
    NULL,
    'ixigo.com and flypgs.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/kosovo-xk', '2026-09-19'
);
SET @xkx1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@xkx1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@xkx1, 'Core Documents', 'Required from every applicant.', 1);
SET @xkx1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@xkx1s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@xkx1s1, 'Completed Visa Application Form', NULL, 'original', 1, 0, 1, 2),
(@xkx1s1, 'Passport-Size Photographs (35x45mm, White Background)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@xkx1, 'Supporting Documents', 'Evidence of your travel plans and financial means.', 2);
SET @xkx1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@xkx1s2, 'Bank Statements (Last 3-6 Months)', NULL, 'original', 1, 0, 0, 1),
(@xkx1s2, 'Confirmed Return/Onward Flight Bookings', NULL, 'copy', 1, 0, 0, 2),
(@xkx1s2, 'Hotel/Accommodation Reservation or Invitation Letter', NULL, 'copy', 1, 0, 0, 3),
(@xkx1s2, 'Employment Letter with Approved Leave Dates', NULL, 'original', 0, 1, 0, 4),
(@xkx1s2, 'Income Tax Returns (Last 2 Years)', NULL, 'copy', 0, 1, 0, 5),
(@xkx1s2, 'Cover Letter Stating Purpose of Visit', NULL, 'original', 1, 0, 0, 6);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(127, 1, 40.00, 'EUR', 'Standard (C) Visa Fee', 'The longer-stay D visa (for work/residence purposes) costs EUR 80.', '2026-01-01', NOW(), 'https://maxglob.com/kosovo-visa-for-indian-passport-holders/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Kosovo?', 'Yes — apply through a Kosovo diplomatic mission or an authorized visa agent, such as Abrodex India Pvt Ltd in New Delhi.', 127, 1, 12700, 1),
('Can Indian citizens apply for a Kosovo eVisa online?', 'Sources disagree: one describes a simplified online eVisa for Indians, another states a paper/embassy visa is the only option. Not independently confirmed this session — verify directly before assuming online application is possible.', 127, 1, 12701, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    127, 2, 'XKX-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Kosovo.',
    'Business travellers use the same visa framework as tourists, with business registration or an invitation letter as additional support.',
    'Per visa validity',
    'Apply through a Kosovo diplomatic mission or authorized visa agent (Abrodex India Pvt Ltd, New Delhi)',
    0,
    'Business registration documents may be requested if self-employed.',
    'Kosovo Embassy / authorized visa agent (Abrodex India Pvt Ltd), New Delhi',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nApply through a Kosovo diplomatic mission or authorized visa agent\nCarry a business invitation letter or business registration\nGather bank statements and income proof\nBook accommodation and return/onward flights',
    NULL,
    'flypgs.com secondary sourcing', 'https://www.flypgs.com/en/visa-information/kosovo', '2026-09-19'
);
SET @xkx2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@xkx2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@xkx2, 'Core Documents', 'Required from every applicant.', 1);
SET @xkx2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@xkx2s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@xkx2s1, 'Business Invitation Letter or Business Registration', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@xkx2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @xkx2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@xkx2s2, 'Bank Statements (Last 3-6 Months)', NULL, 'original', 1, 0, 0, 1),
(@xkx2s2, 'Income Tax Returns (Last 2 Years)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(127, 2, 40.00, 'EUR', 'Standard (C) Visa Fee', 'Same EUR 40 fee as the tourist visa applies.', '2026-01-01', NOW(), 'https://maxglob.com/kosovo-visa-for-indian-passport-holders/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Kosovo?', 'Yes — the same visa framework applies, with a business invitation letter or business registration as additional support.', 127, 2, 12720, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    127, 3, 'XKX-STU-IN-01', '2026.09', 'published',
    'Academic study at a Kosovo educational institution.',
    'Longer-stay study likely uses the D visa (EUR 80) tied to residence purposes, rather than the standard C visa used for short tourist/business visits.',
    'Academic-program length, via D visa/residence permit',
    'Apply for the D visa through a Kosovo diplomatic mission, with a university admission letter',
    1,
    'Not independently confirmed this session: exact student-visa category requirements beyond the general D-visa fee — verify directly with the Kosovo mission and your institution.',
    'Kosovo Embassy / authorized visa agent (Abrodex India Pvt Ltd), New Delhi',
    'Confirm admission with a Kosovo educational institution\nGather passport, admission letter, and proof of funds\nApply for the D visa through a Kosovo diplomatic mission\nRegister for a temporary residence permit after arrival\nRenew your residence permit annually for continued study',
    NULL,
    'globalization-partners.com secondary sourcing', 'https://www.globalization-partners.com/globalpedia/kosovo/visa-permits/', '2026-09-19'
);
SET @xkx3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@xkx3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@xkx3, 'Core Documents', 'Required from every applicant.', 1);
SET @xkx3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@xkx3s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@xkx3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@xkx3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @xkx3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@xkx3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@xkx3s2, 'Accommodation Reservation', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(127, 3, 80.00, 'EUR', 'D Visa Fee (Longer-Stay/Residence)', 'The D visa is used for study and other residence purposes, distinct from the EUR 40 standard C visa.', '2026-01-01', NOW(), 'https://maxglob.com/kosovo-visa-for-indian-passport-holders/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for Kosovo?', 'Longer-stay study is expected to use the D visa (EUR 80) tied to residence purposes rather than the standard C visa — verify exact student category requirements directly.', 127, 3, 12730, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    127, 4, 'XKX-WORK-IN-01', '2026.09', 'published',
    'Employment in Kosovo under a local employer.',
    'Regardless of visa-exemption status, working in Kosovo requires both a work permit and a temporary residence permit, in addition to the D visa for entry.',
    'Per work-permit/residence-permit validity, renewable',
    'Employer sponsors your D-visa application; separately apply for a work permit and temporary residence permit',
    1,
    'Requires coordination of three elements: the D visa itself, a work permit, and a temporary residence permit.',
    'Kosovo Embassy / authorized visa agent (Abrodex India Pvt Ltd), New Delhi',
    'Secure a job offer from a Kosovo employer\nEmployer sponsors your D-visa application\nApply for the D visa through a Kosovo diplomatic mission\nApply for a work permit and temporary residence permit after arrival\nRenew all permits as required for continued employment',
    NULL,
    'globalization-partners.com secondary sourcing', 'https://www.globalization-partners.com/globalpedia/kosovo/visa-permits/', '2026-09-19'
);
SET @xkx4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@xkx4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@xkx4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @xkx4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@xkx4s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@xkx4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@xkx4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @xkx4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@xkx4s2, 'Proof of Qualifications', NULL, 'copy', 1, 0, 0, 1),
(@xkx4s2, 'Work Permit Application', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(127, 4, 80.00, 'EUR', 'D Visa Fee', 'Separate work permit and temporary residence permit fees apply on top of the EUR 80 D-visa fee; exact amounts not independently confirmed this session.', '2026-01-01', NOW(), 'https://maxglob.com/kosovo-visa-for-indian-passport-holders/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is required to work in Kosovo as an Indian citizen?', 'A D visa for entry, plus a separate work permit and a temporary residence permit — all three are required regardless of visa-exemption status.', 127, 4, 12740, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    127, 5, 'XKX-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Kosovo.',
    'Family visitors use the same visa framework as tourists.',
    'Per visa validity',
    'Apply through a Kosovo diplomatic mission or authorized visa agent (Abrodex India Pvt Ltd, New Delhi)',
    0,
    'Carry a host invitation letter along with the standard supporting documents.',
    'Kosovo Embassy / authorized visa agent (Abrodex India Pvt Ltd), New Delhi',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nApply through a Kosovo diplomatic mission or authorized visa agent\nCarry proof of relationship and a host invitation letter\nGather bank statements and income proof\nBook return/onward flights',
    NULL,
    'flypgs.com secondary sourcing', 'https://www.flypgs.com/en/visa-information/kosovo', '2026-09-19'
);
SET @xkx5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@xkx5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@xkx5, 'Core Documents', 'Required from every applicant.', 1);
SET @xkx5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@xkx5s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@xkx5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@xkx5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @xkx5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@xkx5s2, 'Host Invitation Letter', NULL, 'original', 1, 0, 0, 1),
(@xkx5s2, 'Bank Statements (Last 3-6 Months)', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(127, 5, 40.00, 'EUR', 'Standard (C) Visa Fee', 'Same EUR 40 fee as the tourist visa applies.', '2026-01-01', NOW(), 'https://maxglob.com/kosovo-visa-for-indian-passport-holders/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Kosovo?', 'Yes — the same visa framework applies as for tourist travel, with a host invitation letter recommended.', 127, 5, 12750, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    127, 6, 'XKX-TRAN-IN-01', '2026.09', 'published',
    'Airside or short transit through Kosovo en route to another destination.',
    'Airside transit through international airports typically does not require a separate visa for Indian passport holders — a visa is required only if leaving the international zone.',
    'Airside/short transit only',
    'No visa needed for airside transit — remain within the international transit area',
    0,
    'If leaving the airport or clearing immigration, the standard visa application process and fee apply instead.',
    'Kosovo Embassy / authorized visa agent (Abrodex India Pvt Ltd), New Delhi',
    'Confirm your onward connecting flight and transit time\nRemain in the international transit area if not clearing immigration\nIf you must clear immigration, apply for the standard visa in advance\nCarry your onward boarding pass and passport',
    NULL,
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/kosovo-xk', '2026-09-19'
);
SET @xkx6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@xkx6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@xkx6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @xkx6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@xkx6s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@xkx6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(127, 6, 0.00, 'EUR', 'No Fee for Airside Transit', 'Standard EUR 40 visa fee applies only if clearing immigration and leaving the international transit area.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/kosovo-xk', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Kosovo?', 'No — airside transit through international airports typically does not require a separate visa. A visa is required only if leaving the international zone.', 127, 6, 12760, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    127, 7, 'XKX-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Kosovo.',
    'Medical travellers use the same visa framework as tourists.',
    'Per visa validity',
    'Apply through a Kosovo diplomatic mission or authorized visa agent (Abrodex India Pvt Ltd, New Delhi)',
    0,
    'Confirm treatment and appointment directly with the Kosovo medical facility before applying.',
    'Kosovo Embassy / authorized visa agent (Abrodex India Pvt Ltd), New Delhi',
    'Confirm treatment and appointment directly with the Kosovo medical facility\nApply through a Kosovo diplomatic mission or authorized visa agent\nGather bank statements and proof of sufficient funds\nBook accommodation and return/onward flights\nCarry all medical and travel documents for immigration',
    NULL,
    'flypgs.com secondary sourcing', 'https://www.flypgs.com/en/visa-information/kosovo', '2026-09-19'
);
SET @xkx7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@xkx7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@xkx7, 'Core Documents', 'Required from every applicant.', 1);
SET @xkx7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@xkx7s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@xkx7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@xkx7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @xkx7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@xkx7s2, 'Bank Statements (Last 3-6 Months)', NULL, 'original', 1, 0, 0, 1),
(@xkx7s2, 'Confirmed Return/Onward Flight Bookings', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(127, 7, 40.00, 'EUR', 'Standard (C) Visa Fee', 'Same EUR 40 fee as the tourist visa applies.', '2026-01-01', NOW(), 'https://maxglob.com/kosovo-visa-for-indian-passport-holders/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Kosovo?', 'No separate medical visa — the same visa framework applies as for tourist travel.', 127, 7, 12770, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    127, 8, 'XKX-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Kosovo.',
    'Conference attendees use the same visa framework as business travellers.',
    'Per visa validity',
    'Apply through a Kosovo diplomatic mission or authorized visa agent (Abrodex India Pvt Ltd, New Delhi)',
    0,
    'Carry a conference invitation letter along with the standard supporting documents.',
    'Kosovo Embassy / authorized visa agent (Abrodex India Pvt Ltd), New Delhi',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nCarry conference invitation/registration confirmation\nApply through a Kosovo diplomatic mission or authorized visa agent\nGather bank statements and proof of sufficient funds\nBook return/onward flights',
    NULL,
    'flypgs.com secondary sourcing', 'https://www.flypgs.com/en/visa-information/kosovo', '2026-09-19'
);
SET @xkx8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@xkx8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@xkx8, 'Core Documents', 'Required from every applicant.', 1);
SET @xkx8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@xkx8s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@xkx8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@xkx8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @xkx8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@xkx8s2, 'Bank Statements (Last 3-6 Months)', NULL, 'original', 1, 0, 0, 1),
(@xkx8s2, 'Confirmed Return/Onward Flight Bookings', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(127, 8, 40.00, 'EUR', 'Standard (C) Visa Fee', 'Same EUR 40 fee as the business visa applies.', '2026-01-01', NOW(), 'https://maxglob.com/kosovo-visa-for-indian-passport-holders/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Kosovo?', 'No separate conference visa — the same visa framework applies as for business travel.', 127, 8, 12780, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    127, 9, 'XKX-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Kosovo.',
    'Sports travellers use the same visa framework as tourists.',
    'Per visa validity',
    'Apply through a Kosovo diplomatic mission or authorized visa agent (Abrodex India Pvt Ltd, New Delhi)',
    0,
    'Carry event invitation/participation confirmation along with the standard supporting documents.',
    'Kosovo Embassy / authorized visa agent (Abrodex India Pvt Ltd), New Delhi',
    'Confirm your passport is valid for 6+ months with 2+ blank pages\nCarry event invitation/participation confirmation\nApply through a Kosovo diplomatic mission or authorized visa agent\nGather bank statements and proof of sufficient funds\nBook return/onward flights',
    NULL,
    'flypgs.com secondary sourcing', 'https://www.flypgs.com/en/visa-information/kosovo', '2026-09-19'
);
SET @xkx9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@xkx9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@xkx9, 'Core Documents', 'Required from every applicant.', 1);
SET @xkx9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@xkx9s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@xkx9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@xkx9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @xkx9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@xkx9s2, 'Bank Statements (Last 3-6 Months)', NULL, 'original', 1, 0, 0, 1),
(@xkx9s2, 'Confirmed Return/Onward Flight Bookings', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(127, 9, 40.00, 'EUR', 'Standard (C) Visa Fee', 'Same EUR 40 fee as the tourist visa applies.', '2026-01-01', NOW(), 'https://maxglob.com/kosovo-visa-for-indian-passport-holders/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Kosovo?', 'No separate sports visa — the same visa framework applies as for tourist travel.', 127, 9, 12790, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    127, 10, 'XKX-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Kosovo D visa/work permit.',
    'Dependants apply for their own D visa, referencing the primary permit holder\'s work permit and residence status.',
    'Tied to the primary permit holder\'s validity',
    'Apply for the D visa through a Kosovo diplomatic mission, referencing the primary permit holder\'s status',
    1,
    'Not independently confirmed this session: exact dependant-visa requirements beyond the general D-visa fee — verify directly with the Kosovo mission.',
    'Kosovo Embassy / authorized visa agent (Abrodex India Pvt Ltd), New Delhi',
    'Confirm the primary permit holder\'s D visa/work permit status\nGather proof of relationship (marriage/birth certificate)\nApply for the D visa through a Kosovo diplomatic mission\nRegister for a temporary residence permit after arrival\nRenew your residence permit alongside the primary permit holder',
    NULL,
    'globalization-partners.com secondary sourcing', 'https://www.globalization-partners.com/globalpedia/kosovo/visa-permits/', '2026-09-19'
);
SET @xkx10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@xkx10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@xkx10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @xkx10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@xkx10s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@xkx10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@xkx10s1, 'Primary Permit Holder\'s D Visa/Work Permit Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@xkx10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @xkx10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@xkx10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@xkx10s2, 'Accommodation Reservation', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(127, 10, 80.00, 'EUR', 'D Visa Fee', 'Same EUR 80 D-visa fee as the work/student visa applies.', '2026-01-01', NOW(), 'https://maxglob.com/kosovo-visa-for-indian-passport-holders/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependants accompany a work/student visa holder to Kosovo?', 'Yes, via their own D-visa application, referencing the primary permit holder\'s work permit and residence status.', 127, 10, 12700, 1);
