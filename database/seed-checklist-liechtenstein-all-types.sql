-- Liechtenstein Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search.
--
-- Liechtenstein's real, distinctive facts verified this session:
--   - Liechtenstein is a genuine Schengen Area member (via its 2011
--     Schengen Association Agreement) — unlike Andorra, which is
--     often inaccurately described as Schengen. Indian citizens need
--     a Schengen visa for stays under 90 days.
--   - Liechtenstein has no embassy in India — applications are
--     processed through the Swiss Embassy, New Delhi, or authorized
--     VFS Global centres across India, since Switzerland handles
--     Liechtenstein's diplomatic representation.
--   - Fee: EUR 90 for adults, EUR 45 for children 6-12, free under 6
--     (~INR 8,100 for adults). Processing 15-45 days; recommended to
--     apply 36+ days ahead (21-day appointment wait + 15-day
--     processing).
--   - A short-stay Schengen visa cannot be used for work, internships,
--     or long-term stays — these require a national long-stay visa or
--     residence permit issued by the Swiss Embassy in collaboration
--     with Liechtenstein authorities.
--   - Travel insurance covering all Schengen countries (EUR 30,000+
--     medical and repatriation coverage) is mandatory.
--
-- country_id 129 = Liechtenstein. visa_type_id: 1=Tourist, 2=Business,
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
    129, 1, 'LIE-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Liechtenstein.',
    'Liechtenstein is a genuine Schengen Area member. Indian citizens need a Schengen visa for stays under 90 days, applied for via the Swiss Embassy since Liechtenstein has no embassy in India.',
    'Up to 90 days within any 180-day period',
    'Apply for a Schengen visa via the Swiss Embassy, New Delhi, or authorized VFS Global centres',
    1,
    'Apply 36+ days ahead (21-day appointment wait + 15-day processing). Processing itself takes 15-45 days.',
    'Swiss Embassy, New Delhi (handles Liechtenstein visa applications)',
    'Confirm your passport is valid for 3+ months beyond your stay\nBook a biometric appointment at the Swiss Embassy or VFS Global\nPurchase Schengen travel insurance (EUR 30,000+ coverage)\nGather bank statements showing EUR 50-100/day of stay\nAttend your visa interview and submit biometrics',
    NULL,
    'btwvisas.com and insurte.com secondary sourcing', 'https://btwvisas.com/visa-guide/liechtenstein-tourist-visa/', '2026-09-19'
);
SET @lie1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lie1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lie1, 'Core Documents', 'Required from every applicant.', 1);
SET @lie1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lie1s1, 'Valid Passport (3+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@lie1s1, 'Schengen Visa Application Form', NULL, 'original', 1, 0, 1, 2),
(@lie1s1, 'Schengen Travel Insurance (EUR 30,000+ Coverage)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lie1, 'Supporting Documents', 'Evidence of your travel plans and financial means.', 2);
SET @lie1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lie1s2, 'Confirmed Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@lie1s2, 'Bank Statements (Last 3-6 Months)', NULL, 'original', 1, 0, 0, 2),
(@lie1s2, 'Hotel/Accommodation Reservation', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(129, 1, 90.00, 'EUR', 'Adult Schengen Visa Fee', 'Children 6-12 years: EUR 45. Under 6: free. Additional fees for expedited processing, SMS notifications, or courier delivery.', '2026-01-01', NOW(), 'https://www.atlys.com/en-US/visa/liechtenstein-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Liechtenstein?', 'Yes — a Schengen visa, since Liechtenstein is a genuine Schengen Area member. Apply via the Swiss Embassy, New Delhi, since Liechtenstein has no embassy in India.', 129, 1, 12900, 1),
('Why does the Swiss Embassy process Liechtenstein visas?', 'Liechtenstein has no diplomatic mission in India — Switzerland handles its visa processing and diplomatic representation under their close bilateral arrangement.', 129, 1, 12901, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    129, 2, 'LIE-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Liechtenstein.',
    'Business travellers use the same Schengen visa route as tourists, via the Swiss Embassy, with a business invitation letter as additional support.',
    'Up to 90 days within any 180-day period',
    'Apply for a Schengen visa via the Swiss Embassy, New Delhi, or authorized VFS Global centres',
    1,
    'Apply 36+ days ahead. Business travellers should carry a formal invitation letter.',
    'Swiss Embassy, New Delhi (handles Liechtenstein visa applications)',
    'Confirm your passport is valid for 3+ months beyond your stay\nBook a biometric appointment at the Swiss Embassy or VFS Global\nCarry a business invitation letter from the host organization\nPurchase Schengen travel insurance\nAttend your visa interview and submit biometrics',
    NULL,
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/liechtenstein-visa/', '2026-09-19'
);
SET @lie2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lie2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lie2, 'Core Documents', 'Required from every applicant.', 1);
SET @lie2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lie2s1, 'Valid Passport (3+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@lie2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lie2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @lie2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lie2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@lie2s2, 'Bank Statements (Last 3-6 Months)', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(129, 2, 90.00, 'EUR', 'Adult Schengen Visa Fee', 'Same fee structure as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.atlys.com/en-US/visa/liechtenstein-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Liechtenstein?', 'Yes — the same Schengen visa route applies via the Swiss Embassy, with a business invitation letter recommended.', 129, 2, 12920, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    129, 3, 'LIE-STU-IN-01', '2026.09', 'published',
    'Academic study at a Liechtenstein educational institution.',
    'The short-stay Schengen visa cannot be used for long-term study — a national long-stay visa/residence permit is required, issued by the Swiss Embassy in collaboration with Liechtenstein authorities.',
    'Study-program length, via national long-stay visa/residence permit',
    'Apply for a national long-stay visa via the Swiss Embassy, New Delhi, with a university admission letter',
    1,
    'Not independently confirmed this session: exact student-visa fee and processing time.',
    'Swiss Embassy, New Delhi (in collaboration with Liechtenstein authorities)',
    'Confirm admission with a Liechtenstein educational institution\nGather passport, admission letter, and proof of funds\nApply for a national long-stay visa via the Swiss Embassy, New Delhi\nPurchase Schengen-compliant health insurance\nRegister with local authorities after arrival',
    NULL,
    'y-axis.com secondary sourcing', 'https://www.y-axis.com/visa/visit/liechtenstein/', '2026-09-19'
);
SET @lie3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lie3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lie3, 'Core Documents', 'Required from every applicant.', 1);
SET @lie3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lie3s1, 'Valid Passport (3+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@lie3s1, 'University Admission Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lie3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @lie3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lie3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lie3s2, 'Schengen-Compliant Health Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(129, 3, 0.00, 'EUR', 'Fee Not Independently Confirmed', 'National long-stay visa fees were not independently confirmed this session — verify with the Swiss Embassy, New Delhi.', '2026-01-01', NOW(), 'https://www.y-axis.com/visa/visit/liechtenstein/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I study in Liechtenstein on a Schengen tourist visa?', 'No — long-term study requires a national long-stay visa/residence permit, issued by the Swiss Embassy in collaboration with Liechtenstein authorities.', 129, 3, 12930, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    129, 4, 'LIE-WORK-IN-01', '2026.09', 'published',
    'Employment in Liechtenstein under a local employer.',
    'A short-stay Schengen visa does not permit work — employment requires a national long-stay visa/residence permit issued by the Swiss Embassy in collaboration with Liechtenstein authorities, and is additionally subject to Liechtenstein\'s own strict, quota-limited work-permit system.',
    'Per work-permit validity, quota-limited and renewable',
    'Employer sponsors your national long-stay visa application via the Swiss Embassy, New Delhi',
    1,
    'Liechtenstein maintains a strict quota system for foreign workers, distinct from broader Schengen/EU rules — verify current quota availability directly.',
    'Swiss Embassy, New Delhi (in collaboration with Liechtenstein authorities)',
    'Secure a job offer from a Liechtenstein employer\nEmployer sponsors your national long-stay visa application\nApply via the Swiss Embassy, New Delhi\nConfirm quota availability under Liechtenstein\'s work-permit system\nRegister with local authorities after arrival',
    NULL,
    'y-axis.com secondary sourcing', 'https://www.y-axis.com/visa/visit/liechtenstein/', '2026-09-19'
);
SET @lie4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lie4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lie4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @lie4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lie4s1, 'Valid Passport (3+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@lie4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lie4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @lie4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lie4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@lie4s2, 'Schengen-Compliant Health Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(129, 4, 0.00, 'EUR', 'Fee Not Independently Confirmed', 'Work-visa fees were not independently confirmed this session — verify with the Swiss Embassy, New Delhi.', '2026-01-01', NOW(), 'https://www.y-axis.com/visa/visit/liechtenstein/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is it easy to get a work visa for Liechtenstein?', 'Not necessarily — Liechtenstein maintains a strict quota system for foreign workers, distinct from broader Schengen/EU rules. A national long-stay visa via the Swiss Embassy is required regardless.', 129, 4, 12940, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    129, 5, 'LIE-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Liechtenstein.',
    'Family visitors use the same Schengen visa route as tourists, via the Swiss Embassy.',
    'Up to 90 days within any 180-day period',
    'Apply for a Schengen visa via the Swiss Embassy, New Delhi, or authorized VFS Global centres',
    1,
    'Apply 36+ days ahead. Carry a host invitation letter along with the standard documents.',
    'Swiss Embassy, New Delhi (handles Liechtenstein visa applications)',
    'Confirm your passport is valid for 3+ months beyond your stay\nBook a biometric appointment at the Swiss Embassy or VFS Global\nCarry proof of relationship and a host invitation letter\nPurchase Schengen travel insurance\nAttend your visa interview and submit biometrics',
    NULL,
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/liechtenstein-visa/', '2026-09-19'
);
SET @lie5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lie5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lie5, 'Core Documents', 'Required from every applicant.', 1);
SET @lie5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lie5s1, 'Valid Passport (3+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@lie5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lie5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lie5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lie5s2, 'Host Invitation Letter', NULL, 'original', 1, 0, 0, 1),
(@lie5s2, 'Bank Statements (Last 3-6 Months)', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(129, 5, 90.00, 'EUR', 'Adult Schengen Visa Fee', 'Same fee structure as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.atlys.com/en-US/visa/liechtenstein-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Liechtenstein?', 'Yes — the same Schengen visa route applies as for tourist travel, via the Swiss Embassy.', 129, 5, 12950, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    129, 6, 'LIE-TRAN-IN-01', '2026.09', 'published',
    'Transit through Liechtenstein en route to another destination.',
    'As a genuine Schengen member, transit through Liechtenstein follows standard Schengen transit rules — a Schengen visa is generally required unless the traveller already holds a valid Schengen visa from another member state.',
    'Short transit only, within Schengen rules',
    'Apply for a Schengen visa via the Swiss Embassy if you do not already hold a valid Schengen visa',
    1,
    'Liechtenstein has no international airport of its own — most travel routes through Zurich (Switzerland) or Austria first.',
    'Swiss Embassy, New Delhi (handles Liechtenstein visa applications)',
    'Confirm your connecting travel and transit time\nCheck whether you already hold a valid Schengen visa\nApply for a Schengen visa via the Swiss Embassy if needed\nCarry your onward travel documents and passport',
    NULL,
    'insurte.com secondary sourcing', 'https://insurte.com/liechtenstein-visa-guide', '2026-09-19'
);
SET @lie6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lie6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lie6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @lie6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lie6s1, 'Valid Passport (3+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@lie6s1, 'Valid Schengen Visa (If Not Applying Fresh)', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(129, 6, 90.00, 'EUR', 'Schengen Visa Fee (If Needed)', 'Not required if you already hold a valid Schengen visa from another member state.', '2026-01-01', NOW(), 'https://insurte.com/liechtenstein-visa-guide', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Liechtenstein?', 'A valid Schengen visa covers transit, since Liechtenstein is a genuine Schengen member. It has no international airport of its own — most routes go through Zurich or Austria first.', 129, 6, 12960, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    129, 7, 'LIE-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Liechtenstein.',
    'Medical travellers use the same Schengen visa route as tourists, via the Swiss Embassy.',
    'Up to 90 days within any 180-day period',
    'Apply for a Schengen visa via the Swiss Embassy, New Delhi, or authorized VFS Global centres',
    1,
    'Confirm treatment and appointment directly with the Liechtenstein medical facility before applying.',
    'Swiss Embassy, New Delhi (handles Liechtenstein visa applications)',
    'Confirm treatment and appointment directly with the Liechtenstein medical facility\nBook a biometric appointment at the Swiss Embassy or VFS Global\nPurchase Schengen travel insurance\nGather proof of sufficient funds\nAttend your visa interview and submit biometrics',
    NULL,
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/liechtenstein-visa/', '2026-09-19'
);
SET @lie7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lie7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lie7, 'Core Documents', 'Required from every applicant.', 1);
SET @lie7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lie7s1, 'Valid Passport (3+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@lie7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lie7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lie7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lie7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lie7s2, 'Schengen Travel Insurance (EUR 30,000+ Coverage)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(129, 7, 90.00, 'EUR', 'Adult Schengen Visa Fee', 'Same fee structure as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.atlys.com/en-US/visa/liechtenstein-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Liechtenstein?', 'No separate medical visa — the same Schengen visa route applies as for tourist travel.', 129, 7, 12970, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    129, 8, 'LIE-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Liechtenstein.',
    'Conference attendees use the same Schengen visa route as business travellers, via the Swiss Embassy.',
    'Up to 90 days within any 180-day period',
    'Apply for a Schengen visa via the Swiss Embassy, New Delhi, or authorized VFS Global centres',
    1,
    'Carry a conference invitation letter along with the standard documents.',
    'Swiss Embassy, New Delhi (handles Liechtenstein visa applications)',
    'Confirm your passport is valid for 3+ months beyond your stay\nCarry conference invitation/registration confirmation\nBook a biometric appointment at the Swiss Embassy or VFS Global\nPurchase Schengen travel insurance\nAttend your visa interview and submit biometrics',
    NULL,
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/liechtenstein-visa/', '2026-09-19'
);
SET @lie8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lie8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lie8, 'Core Documents', 'Required from every applicant.', 1);
SET @lie8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lie8s1, 'Valid Passport (3+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@lie8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lie8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lie8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lie8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lie8s2, 'Schengen Travel Insurance (EUR 30,000+ Coverage)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(129, 8, 90.00, 'EUR', 'Adult Schengen Visa Fee', 'Same fee structure as the business visa applies.', '2026-01-01', NOW(), 'https://www.atlys.com/en-US/visa/liechtenstein-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Liechtenstein?', 'No separate conference visa — the same Schengen visa route applies as for business travel.', 129, 8, 12980, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    129, 9, 'LIE-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Liechtenstein.',
    'Sports travellers use the same Schengen visa route as tourists, via the Swiss Embassy.',
    'Up to 90 days within any 180-day period',
    'Apply for a Schengen visa via the Swiss Embassy, New Delhi, or authorized VFS Global centres',
    1,
    'Carry an event invitation letter along with the standard documents.',
    'Swiss Embassy, New Delhi (handles Liechtenstein visa applications)',
    'Confirm your passport is valid for 3+ months beyond your stay\nCarry event invitation/participation confirmation\nBook a biometric appointment at the Swiss Embassy or VFS Global\nPurchase Schengen travel insurance\nAttend your visa interview and submit biometrics',
    NULL,
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/liechtenstein-visa/', '2026-09-19'
);
SET @lie9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lie9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lie9, 'Core Documents', 'Required from every applicant.', 1);
SET @lie9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lie9s1, 'Valid Passport (3+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@lie9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lie9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lie9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lie9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lie9s2, 'Schengen Travel Insurance (EUR 30,000+ Coverage)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(129, 9, 90.00, 'EUR', 'Adult Schengen Visa Fee', 'Same fee structure as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.atlys.com/en-US/visa/liechtenstein-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Liechtenstein?', 'No separate sports visa — the same Schengen visa route applies as for tourist travel.', 129, 9, 12990, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    129, 10, 'LIE-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Liechtenstein work/student visa.',
    'Dependants apply for their own national long-stay visa via the Swiss Embassy, referencing the primary permit holder\'s status and Liechtenstein\'s quota system.',
    'Tied to the primary permit holder\'s validity',
    'Apply for a national long-stay visa via the Swiss Embassy, New Delhi, referencing the primary permit holder\'s status',
    1,
    'Not independently confirmed this session: exact dependant-visa fee and quota implications.',
    'Swiss Embassy, New Delhi (in collaboration with Liechtenstein authorities)',
    'Confirm the primary permit holder\'s work/student visa status\nGather proof of relationship (marriage/birth certificate)\nApply via the Swiss Embassy, New Delhi\nPurchase Schengen-compliant health insurance\nRegister with local authorities after arrival',
    NULL,
    'y-axis.com secondary sourcing', 'https://www.y-axis.com/visa/visit/liechtenstein/', '2026-09-19'
);
SET @lie10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lie10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lie10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @lie10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lie10s1, 'Valid Passport (3+ Months Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@lie10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@lie10s1, 'Primary Permit Holder\'s Visa/Permit Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lie10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @lie10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lie10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lie10s2, 'Schengen-Compliant Health Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(129, 10, 0.00, 'EUR', 'Fee Not Independently Confirmed', 'Dependant national long-stay visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.y-axis.com/visa/visit/liechtenstein/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependants accompany a work/student visa holder to Liechtenstein?', 'Yes, via their own national long-stay visa application through the Swiss Embassy, referencing the primary permit holder\'s status.', 129, 10, 12900, 1);
