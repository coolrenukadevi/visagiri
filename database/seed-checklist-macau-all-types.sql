-- Macau Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Macau's real, distinctive facts verified this session:
--   - Indian citizens can enter Macau visa-free for up to 30 days —
--     Macau is a Special Administrative Region of China with its own
--     separate immigration policy, distinct from mainland China's
--     visa requirements.
--   - No visa-on-arrival exists (it simply isn't needed for the
--     visa-free 30-day window); there is also no online application
--     system for longer-stay visas.
--   - For stays beyond 30 days, applicants apply through an Embassy
--     or Consulate of the People's Republic of China, since Macau
--     itself does not maintain separate diplomatic missions in India.
--   - Fee sourcing conflict flagged rather than silently resolved: one
--     source cites a China-visa-style fee (~INR 3,200 single-entry /
--     INR 4,800 double-entry), another cites a much lower MOP-
--     denominated fee (MOP$100/~INR 885 for adults, MOP$50/~INR 442.5
--     for children under 12) — these likely describe different
--     processes (a mainland China visa vs. a Macau-specific extension
--     fee) and are presented with the conflict flagged.
--   - Distinct Student and Work visa categories exist for Indians with
--     confirmed admission or a Macau job offer, valid for the
--     academic program or employment contract length respectively.
--
-- country_id 79 = Macau. visa_type_id: 1=Tourist, 2=Business,
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
    79, 1, 'MAC-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Macau.',
    'Indian citizens can enter Macau visa-free for up to 30 days — Macau is a Special Administrative Region with its own separate immigration policy from mainland China.',
    'Up to 30 days',
    'No visa needed for entry — present passport and standard documents at immigration',
    0,
    'Not applicable for entry itself. For stays beyond 30 days, apply through a Chinese Embassy/Consulate in India.',
    'No Macau-specific mission in India — longer-stay applications route through a Chinese Embassy/Consulate',
    'Confirm your passport has adequate validity for your trip\nBook proof of return/onward ticket\nGather proof of accommodation and sufficient funds\nCarry all documents for immigration on arrival\nApply through a Chinese Embassy/Consulate if staying beyond 30 days',
    NULL,
    'godigit.com and acko.com secondary sourcing', 'https://www.godigit.com/international-travel-insurance/visa/macau-visa-for-indians', '2026-09-19'
);
SET @mac1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mac1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mac1, 'Core Documents', 'Required from every traveller.', 1);
SET @mac1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mac1s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mac1s1, 'Confirmed Return/Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mac1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mac1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mac1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 1),
(@mac1s2, 'Proof of Sufficient Funds', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(79, 1, 0.00, 'MOP', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 30-day entry. Longer-stay fees carry a sourcing conflict — INR 3,200-4,800 (China-visa-style) vs. MOP$100/50 (Macau-specific) — verify directly.', '2026-01-01', NOW(), 'https://www.godigit.com/international-travel-insurance/visa/macau-visa-for-indians', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Macau?', 'No — Indian citizens can enter Macau visa-free for up to 30 days. Macau is a Special Administrative Region of China with its own separate immigration policy.', 79, 1, 7900, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    79, 2, 'MAC-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Macau.',
    'Business travellers use the same visa-free, 30-day framework as tourists.',
    'Up to 30 days',
    'No visa needed for entry — present passport and standard documents at immigration',
    0,
    'Not applicable for entry itself.',
    'No Macau-specific mission in India — longer-stay applications route through a Chinese Embassy/Consulate',
    'Confirm your passport has adequate validity for your trip\nCarry a business invitation letter from the host organization\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'acko.com secondary sourcing', 'https://www.acko.com/visa/macau-visa-for-indians/', '2026-09-19'
);
SET @mac2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mac2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mac2, 'Core Documents', 'Required from every traveller.', 1);
SET @mac2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mac2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mac2s1, 'Business Invitation Letter', NULL, 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mac2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @mac2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mac2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@mac2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(79, 2, 0.00, 'MOP', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 30-day entry.', '2026-01-01', NOW(), 'https://www.acko.com/visa/macau-visa-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Macau?', 'No — the same visa-free, 30-day framework applies as for tourist travel.', 79, 2, 7920, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    79, 3, 'MAC-STU-IN-01', '2026.09', 'published',
    'Academic study at a Macau educational institution.',
    'A distinct student-visa category is available for Indians enrolled in Macau educational institutions, valid for the entire duration of the academic program.',
    'Academic-program length',
    'Apply through a Chinese Embassy/Consulate in India, with a university admission letter',
    1,
    'Not independently confirmed this session: exact student-visa fee — verify with the Chinese Embassy/Consulate.',
    'No Macau-specific mission in India — applications route through a Chinese Embassy/Consulate',
    'Confirm admission with a Macau educational institution\nGather passport, admission letter, and proof of funds\nApply through a Chinese Embassy/Consulate in India\nRegister with local authorities after arrival\nRenew your visa/permit as required for continued study',
    NULL,
    'tataaig.com secondary sourcing', 'https://www.tataaig.com/travel-insurance/macau-visa', '2026-09-19'
);
SET @mac3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mac3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mac3, 'Core Documents', 'Required from every applicant.', 1);
SET @mac3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mac3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mac3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mac3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @mac3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mac3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mac3s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(79, 3, 0.00, 'MOP', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session — verify with the Chinese Embassy/Consulate in India.', '2026-01-01', NOW(), 'https://www.tataaig.com/travel-insurance/macau-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for Macau?', 'Yes — Indian students enrolled at a Macau institution can apply for a student visa valid for the entire academic program, through a Chinese Embassy/Consulate in India.', 79, 3, 7930, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    79, 4, 'MAC-WORK-IN-01', '2026.09', 'published',
    'Employment in Macau under a local employer.',
    'A distinct work-visa category is available for Indians with a confirmed job offer from a Macau-based employer, issued for the length of the employment contract.',
    'Per employment contract length',
    'Employer sponsors your application through a Chinese Embassy/Consulate in India',
    1,
    'Not independently confirmed this session: exact work-visa fee — verify with the Chinese Embassy/Consulate.',
    'No Macau-specific mission in India — applications route through a Chinese Embassy/Consulate',
    'Secure a job offer from a Macau-based employer\nEmployer sponsors your work-visa application\nApply through a Chinese Embassy/Consulate in India\nRegister with local authorities on arrival\nRenew your visa/permit as required for continued employment',
    NULL,
    'tataaig.com secondary sourcing', 'https://www.tataaig.com/travel-insurance/macau-visa', '2026-09-19'
);
SET @mac4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mac4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mac4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @mac4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mac4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mac4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mac4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @mac4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mac4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@mac4s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(79, 4, 0.00, 'MOP', 'Fee Not Independently Confirmed', 'Work visa fees were not independently confirmed this session — verify with the Chinese Embassy/Consulate in India.', '2026-01-01', NOW(), 'https://www.tataaig.com/travel-insurance/macau-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated work visa for Macau?', 'Yes — Indians with a confirmed job offer from a Macau employer can apply for a work visa valid for the length of the employment contract.', 79, 4, 7940, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    79, 5, 'MAC-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Macau.',
    'Family visitors use the same visa-free, 30-day framework as tourists.',
    'Up to 30 days',
    'No visa needed for entry — present passport and standard documents at immigration',
    0,
    'Not applicable for entry itself.',
    'No Macau-specific mission in India — longer-stay applications route through a Chinese Embassy/Consulate',
    'Confirm your passport has adequate validity for your trip\nBook proof of return/onward ticket\nCarry proof of relationship and host contact details\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'godigit.com secondary sourcing', 'https://www.godigit.com/international-travel-insurance/visa/macau-visa-for-indians', '2026-09-19'
);
SET @mac5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mac5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mac5, 'Core Documents', 'Required from every traveller.', 1);
SET @mac5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mac5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mac5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mac5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mac5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mac5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 1),
(@mac5s2, 'Proof of Sufficient Funds', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(79, 5, 0.00, 'MOP', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 30-day entry.', '2026-01-01', NOW(), 'https://www.godigit.com/international-travel-insurance/visa/macau-visa-for-indians', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Macau?', 'No — the same visa-free, 30-day framework applies as for tourist travel.', 79, 5, 7950, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    79, 6, 'MAC-TRAN-IN-01', '2026.09', 'published',
    'Transit through Macau en route to another destination.',
    'Given Macau\'s visa-free tourist entry framework, short transit is expected to be covered by the same visa-free rules.',
    'Short transit, within the visa-free framework',
    'No visa needed for short transit — present passport and onward ticket',
    0,
    'Not applicable for entry itself.',
    'No Macau-specific mission in India',
    'Confirm your connecting flight and transit time\nConfirm your passport has adequate validity\nCarry your onward boarding pass and passport\nCarry all documents for immigration if clearing customs',
    NULL,
    'godigit.com secondary sourcing', 'https://www.godigit.com/international-travel-insurance/visa/macau-visa-for-indians', '2026-09-19'
);
SET @mac6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mac6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mac6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @mac6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mac6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mac6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(79, 6, 0.00, 'MOP', 'No Fee for Visa-Free Transit', 'No fee applies within the visa-free tourist framework.', '2026-01-01', NOW(), 'https://www.godigit.com/international-travel-insurance/visa/macau-visa-for-indians', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Macau?', 'No — short transit is expected to be covered by the same visa-free tourist framework as other short visits.', 79, 6, 7960, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    79, 7, 'MAC-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Macau.',
    'Medical travellers use the same visa-free, 30-day framework as tourists.',
    'Up to 30 days',
    'No visa needed for entry — present passport and standard documents at immigration',
    0,
    'Not applicable for entry itself.',
    'No Macau-specific mission in India — longer-stay applications route through a Chinese Embassy/Consulate',
    'Confirm treatment and appointment directly with the Macau medical facility\nConfirm your passport has adequate validity for your trip\nBook proof of return/onward ticket\nGather proof of sufficient funds\nCarry all medical and travel documents for immigration',
    NULL,
    'godigit.com secondary sourcing', 'https://www.godigit.com/international-travel-insurance/visa/macau-visa-for-indians', '2026-09-19'
);
SET @mac7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mac7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mac7, 'Core Documents', 'Required from every traveller.', 1);
SET @mac7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mac7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mac7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mac7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mac7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mac7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mac7s2, 'Confirmed Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(79, 7, 0.00, 'MOP', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 30-day entry.', '2026-01-01', NOW(), 'https://www.godigit.com/international-travel-insurance/visa/macau-visa-for-indians', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Macau?', 'No separate medical visa — the same visa-free, 30-day framework applies.', 79, 7, 7970, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    79, 8, 'MAC-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Macau.',
    'Conference attendees use the same visa-free, 30-day framework as business travellers.',
    'Up to 30 days',
    'No visa needed for entry — present passport and standard documents at immigration',
    0,
    'Not applicable for entry itself.',
    'No Macau-specific mission in India — longer-stay applications route through a Chinese Embassy/Consulate',
    'Confirm your passport has adequate validity for your trip\nCarry conference invitation/registration confirmation\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'acko.com secondary sourcing', 'https://www.acko.com/visa/macau-visa-for-indians/', '2026-09-19'
);
SET @mac8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mac8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mac8, 'Core Documents', 'Required from every traveller.', 1);
SET @mac8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mac8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mac8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mac8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mac8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mac8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mac8s2, 'Confirmed Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(79, 8, 0.00, 'MOP', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 30-day entry.', '2026-01-01', NOW(), 'https://www.acko.com/visa/macau-visa-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Macau?', 'No separate conference visa — the same visa-free, 30-day framework applies.', 79, 8, 7980, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    79, 9, 'MAC-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Macau.',
    'Sports travellers use the same visa-free, 30-day framework as tourists.',
    'Up to 30 days',
    'No visa needed for entry — present passport and standard documents at immigration',
    0,
    'Not applicable for entry itself.',
    'No Macau-specific mission in India — longer-stay applications route through a Chinese Embassy/Consulate',
    'Confirm your passport has adequate validity for your trip\nCarry event invitation/participation confirmation\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'acko.com secondary sourcing', 'https://www.acko.com/visa/macau-visa-for-indians/', '2026-09-19'
);
SET @mac9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mac9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mac9, 'Core Documents', 'Required from every traveller.', 1);
SET @mac9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mac9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mac9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mac9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mac9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mac9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mac9s2, 'Confirmed Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(79, 9, 0.00, 'MOP', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 30-day entry.', '2026-01-01', NOW(), 'https://www.acko.com/visa/macau-visa-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Macau?', 'No separate sports visa — the same visa-free, 30-day framework applies.', 79, 9, 7990, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    79, 10, 'MAC-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Macau work/student visa.',
    'Dependants enter visa-free like other Indian citizens for short visits; longer stays alongside a work/student visa holder are expected to require their own application through a Chinese Embassy/Consulate.',
    'Tied to the primary permit holder\'s visa validity',
    'Enter visa-free, then apply through a Chinese Embassy/Consulate for longer stays',
    1,
    'Not independently confirmed this session: exact dependant-visa fee and process.',
    'No Macau-specific mission in India — applications route through a Chinese Embassy/Consulate',
    'Confirm the primary permit holder\'s work/student visa status\nGather proof of relationship (marriage/birth certificate)\nEnter Macau visa-free (up to 30 days)\nApply through a Chinese Embassy/Consulate for longer stays\nRegister with local authorities on arrival if required',
    NULL,
    'tataaig.com secondary sourcing', 'https://www.tataaig.com/travel-insurance/macau-visa', '2026-09-19'
);
SET @mac10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mac10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mac10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @mac10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mac10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mac10s1, 'Proof of Relationship to Primary Permit Holder', NULL, 'original', 1, 0, 1, 2),
(@mac10s1, 'Primary Permit Holder\'s Visa Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mac10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @mac10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mac10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mac10s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(79, 10, 0.00, 'MOP', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session — verify with the Chinese Embassy/Consulate in India.', '2026-01-01', NOW(), 'https://www.tataaig.com/travel-insurance/macau-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do dependants of work/student visa holders need their own visa for Macau?', 'For stays beyond 30 days, expected to require their own application through a Chinese Embassy/Consulate — not independently confirmed this session.', 79, 10, 7900, 1);
