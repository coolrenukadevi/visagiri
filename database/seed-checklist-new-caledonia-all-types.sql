-- New Caledonia Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search.
--
-- New Caledonia's real, distinctive facts verified this session:
--   - New Caledonia is a French dependent territory but is NEITHER a
--     French overseas region NOR part of the Schengen area — the
--     inverse of Monaco (which does use France's Schengen visa).
--     Holding a French/Schengen residence permit or long-stay visa
--     does NOT automatically exempt travellers from needing a
--     separate New Caledonia visa, and conversely a New Caledonia
--     visa cannot be used to enter mainland France.
--   - The visa itself must carry special wording specifically
--     clarifying its validity for entry to New Caledonia — a standard
--     French/Schengen visa is not sufficient on its own.
--   - Applications are submitted only through VFS France
--     (www.vfs-france.co.in) with a prior appointment; fee EUR 60;
--     processing allow 15 working days.
--
-- country_id 188 = New Caledonia. visa_type_id: 1=Tourist, 2=Business,
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
    188, 1, 'NCL-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to New Caledonia.',
    'Indian citizens require a visa specifically for New Caledonia — despite being a French territory, it is not part of Schengen, and a standard French/Schengen visa does NOT cover entry here; the visa must carry special New Caledonia-specific wording.',
    'Per visa validity',
    'Apply via VFS France (vfs-france.co.in) with a prior appointment',
    1,
    'A New Caledonia visa cannot be used to enter mainland France, and vice versa — these are two separate visa processes despite the French territorial link. Allow 15 working days for processing.',
    'French Consulate/VFS France (New Caledonia-specific visa)',
    'Confirm your passport is valid for 6+ months beyond your stay\nBook an appointment via VFS France (vfs-france.co.in)\nGather proof of onward/departure travel from New Caledonia\nSubmit all required documents at your appointment\nAllow 15 working days for processing',
    '/assets/images/visa-heroes/new-caledonia.webp',
    'newcaledonia.travel and entryconditions.com secondary sourcing', 'https://www.newcaledonia.travel/travel-guide/passport-visa-and-customs/', '2026-09-19'
);
SET @ncl1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ncl1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ncl1, 'Core Documents', 'Required from every applicant.', 1);
SET @ncl1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ncl1s1, 'Valid Passport (6+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@ncl1s1, 'New Caledonia-Specific Visa Approval', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ncl1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @ncl1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ncl1s2, 'Proof of Onward/Departure Travel', NULL, 'copy', 1, 0, 0, 1),
(@ncl1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 2),
(@ncl1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(188, 1, 60.00, 'EUR', 'Short-Stay Visa Fee', 'Applies specifically to the New Caledonia visa — separate from any France/Schengen visa fee.', '2026-01-01', NOW(), 'https://lomelono.com/new-caledonia-visa-for-indian-passport/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does my Schengen visa cover New Caledonia?', 'No — New Caledonia is a French territory but is not part of Schengen. A holding a French/Schengen residence permit or long-stay visa does not exempt you; a separate New Caledonia-specific visa is required.', 188, 1, 18800, 1),
('Can I use a New Caledonia visa to enter France?', 'No — a New Caledonia visa cannot be used to enter mainland France, and a France/Schengen visa cannot be used to enter New Caledonia. These are entirely separate application processes.', 188, 1, 18801, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    188, 2, 'NCL-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in New Caledonia.',
    'Business travellers use the same New Caledonia-specific visa route as tourists, with a business invitation letter as additional support.',
    'Per visa validity',
    'Apply via VFS France (vfs-france.co.in) with a prior appointment',
    1,
    'Allow 15 working days for processing.',
    'French Consulate/VFS France (New Caledonia-specific visa)',
    'Confirm your passport is valid for 6+ months beyond your stay\nBook an appointment via VFS France\nCarry a business invitation letter from the host organization\nGather proof of sufficient funds\nAllow 15 working days for processing',
    '/assets/images/visa-heroes/new-caledonia.webp',
    'newcaledonia.travel secondary sourcing', 'https://www.newcaledonia.travel/travel-guide/passport-visa-and-customs/', '2026-09-19'
);
SET @ncl2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ncl2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ncl2, 'Core Documents', 'Required from every applicant.', 1);
SET @ncl2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ncl2s1, 'Valid Passport (6+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@ncl2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ncl2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @ncl2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ncl2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@ncl2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(188, 2, 60.00, 'EUR', 'Short-Stay Visa Fee', 'Same EUR 60 fee as the tourist visa applies.', '2026-01-01', NOW(), 'https://lomelono.com/new-caledonia-visa-for-indian-passport/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for New Caledonia?', 'Yes — the same New Caledonia-specific visa route applies via VFS France, with a business invitation letter recommended.', 188, 2, 18820, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    188, 3, 'NCL-STU-IN-01', '2026.09', 'published',
    'Academic study at a New Caledonia educational institution.',
    'Sources reviewed this session did not describe a dedicated New Caledonia student-visa category distinct from the general VFS France visa process, applied for once admission is secured.',
    'Study-program length, renewable',
    'Apply via VFS France (vfs-france.co.in), with a university admission letter',
    1,
    'Not independently confirmed this session whether a distinct student-visa category exists.',
    'French Consulate/VFS France (New Caledonia-specific visa)',
    'Confirm admission with a New Caledonia educational institution\nGather passport, admission letter, and proof of funds\nBook an appointment via VFS France\nAllow 15 working days for processing\nRegister with local authorities after arrival',
    '/assets/images/visa-heroes/new-caledonia.webp',
    'newcaledonia.travel secondary sourcing', 'https://www.newcaledonia.travel/travel-guide/passport-visa-and-customs/', '2026-09-19'
);
SET @ncl3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ncl3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ncl3, 'Core Documents', 'Required from every applicant.', 1);
SET @ncl3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ncl3s1, 'Valid Passport (6+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@ncl3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ncl3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @ncl3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ncl3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@ncl3s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(188, 3, 0.00, 'EUR', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session — the short-stay fee of EUR 60 may not apply to longer study programs.', '2026-01-01', NOW(), 'https://www.newcaledonia.travel/travel-guide/passport-visa-and-customs/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for New Caledonia?', 'Not independently confirmed this session — apply via VFS France once admission is secured; a longer-stay visa category likely applies beyond the short-stay EUR 60 fee.', 188, 3, 18830, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    188, 4, 'NCL-WORK-IN-01', '2026.09', 'published',
    'Employment in New Caledonia under a local employer.',
    'Sources reviewed this session did not describe a dedicated New Caledonia work-visa process in detail — apply via VFS France with employer sponsorship documentation.',
    'Per work-visa validity',
    'Employer sponsors your work-visa application via VFS France',
    1,
    'Not independently confirmed this session: exact work-visa fee, category, and local work-permit process.',
    'French Consulate/VFS France (New Caledonia-specific visa)',
    'Secure a job offer from a New Caledonia employer\nEmployer sponsors your work-visa application\nBook an appointment via VFS France\nGather employment contract and supporting documents\nAllow 15+ working days for processing',
    '/assets/images/visa-heroes/new-caledonia.webp',
    'newcaledonia.travel secondary sourcing', 'https://www.newcaledonia.travel/travel-guide/passport-visa-and-customs/', '2026-09-19'
);
SET @ncl4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ncl4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ncl4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @ncl4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ncl4s1, 'Valid Passport (6+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@ncl4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ncl4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @ncl4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ncl4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@ncl4s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(188, 4, 0.00, 'EUR', 'Fee Not Independently Confirmed', 'Work visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.newcaledonia.travel/travel-guide/passport-visa-and-customs/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How do I get a work visa for New Caledonia as an Indian citizen?', 'Apply via VFS France with employer sponsorship documentation; exact fee and process were not independently confirmed this session.', 188, 4, 18840, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    188, 5, 'NCL-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in New Caledonia.',
    'Family visitors use the same New Caledonia-specific visa route as tourists.',
    'Per visa validity',
    'Apply via VFS France (vfs-france.co.in) with a prior appointment',
    1,
    'Allow 15 working days for processing.',
    'French Consulate/VFS France (New Caledonia-specific visa)',
    'Confirm your passport is valid for 6+ months beyond your stay\nBook an appointment via VFS France\nCarry proof of relationship and host contact details\nGather proof of sufficient funds\nAllow 15 working days for processing',
    '/assets/images/visa-heroes/new-caledonia.webp',
    'newcaledonia.travel secondary sourcing', 'https://www.newcaledonia.travel/travel-guide/passport-visa-and-customs/', '2026-09-19'
);
SET @ncl5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ncl5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ncl5, 'Core Documents', 'Required from every applicant.', 1);
SET @ncl5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ncl5s1, 'Valid Passport (6+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@ncl5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ncl5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @ncl5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ncl5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 1),
(@ncl5s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(188, 5, 60.00, 'EUR', 'Short-Stay Visa Fee', 'Same EUR 60 fee as the tourist visa applies.', '2026-01-01', NOW(), 'https://lomelono.com/new-caledonia-visa-for-indian-passport/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in New Caledonia?', 'Yes — the same New Caledonia-specific visa route applies as for tourist travel.', 188, 5, 18850, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    188, 6, 'NCL-TRAN-IN-01', '2026.09', 'published',
    'Transit through New Caledonia en route to another destination.',
    'Sources reviewed this session did not describe a separate airside-only transit exemption for Indian passport holders — given New Caledonia\'s standalone visa requirement, travellers clearing immigration should expect to need the same visa as other visa types.',
    'Short transit only',
    'Apply via VFS France in advance if there is any possibility of clearing immigration',
    1,
    'Not independently confirmed this session whether an airside-only exemption exists — verify with your airline.',
    'French Consulate/VFS France (New Caledonia-specific visa)',
    'Confirm your connecting flight and transit time\nApply via VFS France in advance if there is any possibility of clearing immigration\nCarry your onward boarding pass and passport\nConfirm airside-only transit exemptions directly with your airline',
    '/assets/images/visa-heroes/new-caledonia.webp',
    'newcaledonia.travel secondary sourcing (transit exemption not independently confirmed)', 'https://www.newcaledonia.travel/travel-guide/passport-visa-and-customs/', '2026-09-19'
);
SET @ncl6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ncl6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ncl6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @ncl6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ncl6s1, 'Valid Passport (6+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@ncl6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(188, 6, 60.00, 'EUR', 'Short-Stay Visa Fee (If Clearing Immigration)', 'Airside-only transit exemption not independently confirmed this session — budget for the standard visa fee unless your airline confirms otherwise.', '2026-01-01', NOW(), 'https://lomelono.com/new-caledonia-visa-for-indian-passport/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for New Caledonia?', 'Not independently confirmed this session whether airside-only transit is exempt. If you may clear immigration, apply via VFS France in advance.', 188, 6, 18860, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    188, 7, 'NCL-MED-IN-01', '2026.09', 'published',
    'Medical treatment in New Caledonia.',
    'Medical travellers use the same New Caledonia-specific visa route as tourists.',
    'Per visa validity',
    'Apply via VFS France (vfs-france.co.in) with a prior appointment',
    1,
    'Confirm treatment and appointment directly with the New Caledonia medical facility before applying.',
    'French Consulate/VFS France (New Caledonia-specific visa)',
    'Confirm treatment and appointment directly with the New Caledonia medical facility\nBook an appointment via VFS France\nGather proof of sufficient funds\nAllow 15 working days for processing',
    '/assets/images/visa-heroes/new-caledonia.webp',
    'newcaledonia.travel secondary sourcing', 'https://www.newcaledonia.travel/travel-guide/passport-visa-and-customs/', '2026-09-19'
);
SET @ncl7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ncl7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ncl7, 'Core Documents', 'Required from every applicant.', 1);
SET @ncl7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ncl7s1, 'Valid Passport (6+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@ncl7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ncl7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @ncl7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ncl7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@ncl7s2, 'Proof of Onward/Departure Travel', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(188, 7, 60.00, 'EUR', 'Short-Stay Visa Fee', 'Same EUR 60 fee as the tourist visa applies.', '2026-01-01', NOW(), 'https://lomelono.com/new-caledonia-visa-for-indian-passport/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for New Caledonia?', 'No separate medical visa — the same New Caledonia-specific visa route applies as for tourist travel.', 188, 7, 18870, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    188, 8, 'NCL-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in New Caledonia.',
    'Conference attendees use the same New Caledonia-specific visa route as business travellers.',
    'Per visa validity',
    'Apply via VFS France (vfs-france.co.in) with a prior appointment',
    1,
    'Allow 15 working days for processing.',
    'French Consulate/VFS France (New Caledonia-specific visa)',
    'Confirm your passport is valid for 6+ months beyond your stay\nCarry conference invitation/registration confirmation\nBook an appointment via VFS France\nGather proof of sufficient funds\nAllow 15 working days for processing',
    '/assets/images/visa-heroes/new-caledonia.webp',
    'newcaledonia.travel secondary sourcing', 'https://www.newcaledonia.travel/travel-guide/passport-visa-and-customs/', '2026-09-19'
);
SET @ncl8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ncl8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ncl8, 'Core Documents', 'Required from every applicant.', 1);
SET @ncl8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ncl8s1, 'Valid Passport (6+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@ncl8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ncl8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @ncl8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ncl8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@ncl8s2, 'Proof of Onward/Departure Travel', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(188, 8, 60.00, 'EUR', 'Short-Stay Visa Fee', 'Same EUR 60 fee as the business visa applies.', '2026-01-01', NOW(), 'https://lomelono.com/new-caledonia-visa-for-indian-passport/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for New Caledonia?', 'No separate conference visa — the same New Caledonia-specific visa route applies as for business travel.', 188, 8, 18880, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    188, 9, 'NCL-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in New Caledonia.',
    'Sports travellers use the same New Caledonia-specific visa route as tourists.',
    'Per visa validity',
    'Apply via VFS France (vfs-france.co.in) with a prior appointment',
    1,
    'Allow 15 working days for processing.',
    'French Consulate/VFS France (New Caledonia-specific visa)',
    'Confirm your passport is valid for 6+ months beyond your stay\nCarry event invitation/participation confirmation\nBook an appointment via VFS France\nGather proof of sufficient funds\nAllow 15 working days for processing',
    '/assets/images/visa-heroes/new-caledonia.webp',
    'newcaledonia.travel secondary sourcing', 'https://www.newcaledonia.travel/travel-guide/passport-visa-and-customs/', '2026-09-19'
);
SET @ncl9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ncl9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ncl9, 'Core Documents', 'Required from every applicant.', 1);
SET @ncl9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ncl9s1, 'Valid Passport (6+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@ncl9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ncl9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @ncl9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ncl9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@ncl9s2, 'Proof of Onward/Departure Travel', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(188, 9, 60.00, 'EUR', 'Short-Stay Visa Fee', 'Same EUR 60 fee as the tourist visa applies.', '2026-01-01', NOW(), 'https://lomelono.com/new-caledonia-visa-for-indian-passport/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for New Caledonia?', 'No separate sports visa — the same New Caledonia-specific visa route applies as for tourist travel.', 188, 9, 18890, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    188, 10, 'NCL-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a New Caledonia work/student visa.',
    'Dependants apply via VFS France, referencing the primary permit holder\'s status.',
    'Tied to the primary permit holder\'s visa validity',
    'Apply via VFS France, referencing the primary permit holder\'s status',
    1,
    'Not independently confirmed this session: exact dependant-visa fee and processing time.',
    'French Consulate/VFS France (New Caledonia-specific visa)',
    'Confirm the primary permit holder\'s work/student visa status\nGather proof of relationship (marriage/birth certificate)\nBook an appointment via VFS France\nAllow 15+ working days for processing\nRegister with local authorities after arrival',
    '/assets/images/visa-heroes/new-caledonia.webp',
    'newcaledonia.travel secondary sourcing', 'https://www.newcaledonia.travel/travel-guide/passport-visa-and-customs/', '2026-09-19'
);
SET @ncl10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ncl10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ncl10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @ncl10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ncl10s1, 'Valid Passport (6+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@ncl10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@ncl10s1, 'Primary Permit Holder\'s Visa Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ncl10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @ncl10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ncl10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@ncl10s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(188, 10, 0.00, 'EUR', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.newcaledonia.travel/travel-guide/passport-visa-and-customs/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependants accompany a work/student visa holder to New Caledonia?', 'Yes, via their own application through VFS France, referencing the primary permit holder\'s status.', 188, 10, 18800, 1);
