-- Brunei Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Brunei's real, distinctive facts verified this session:
--   - Ordinary Indian passport holders must obtain a visa in advance —
--     no visa-on-arrival or eVisa facility; apply through the High
--     Commission of Brunei Darussalam in New Delhi.
--   - Distinctive sponsor requirement: Indian nationals (along with
--     Bangladesh, Iran, Pakistan, Sri Lanka) must have a sponsor —
--     a Brunei-registered travel agency, airline, hotel, or Brunei
--     resident — who provides a supporting letter.
--   - Fee: INR 1000 single-entry, INR 2500 multiple-entry short-visit
--     visa (official High Commission rates).
--   - Processing: 5-7 working days typically; recommended to apply
--     at least 3 weeks before travel.
--   - Stay: typically up to 30 days.
--
-- country_id 61 = Brunei. visa_type_id: 1=Tourist, 2=Business,
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
    61, 1, 'BRN-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Brunei.',
    'All Indian citizens require a visa in advance — no visa-on-arrival or eVisa. A sponsor (travel agency, airline, hotel, or Brunei resident) is required.',
    'Typically up to 30 days',
    'Apply through the High Commission of Brunei Darussalam in New Delhi with a sponsor letter',
    1,
    'Typically 5-7 working days; apply at least 3 weeks before travel',
    'High Commission of Brunei Darussalam, New Delhi',
    'Arrange a sponsor (travel agency, airline, hotel, or Brunei resident) for a supporting letter\nComplete the visa application form\nGather passport, photo, and travel documents\nSubmit the application at the High Commission in New Delhi\nPay the visa fee and collect the visa',
    '/assets/images/visa-heroes/brunei.webp',
    'BTW Visas and VisaGo secondary sourcing', 'https://btwvisas.com/visa-guide/brunei-tourist-visa/', '2026-09-19'
);
SET @brn1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brn1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn1, 'Core Documents', 'Required from every applicant.', 1);
SET @brn1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@brn1s1, 'Completed Visa Application Form', NULL, 'original', 1, 0, 1, 2),
(@brn1s1, 'Recent Passport-Size Photograph', NULL, 'original', 1, 0, 1, 3),
(@brn1s1, 'Sponsor Letter (Travel Agency/Airline/Hotel/Resident)', NULL, 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @brn1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn1s2, 'Confirmed Flight Tickets (Round Trip)', NULL, 'copy', 1, 0, 0, 1),
(@brn1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(61, 1, 1000.00, 'INR', 'Single-Entry Visa Fee', 'Multiple-entry short-visit visa is INR 2500.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/brunei-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens get a Brunei visa on arrival?', 'No — Brunei does not offer visa-on-arrival or eVisa facilities to Indian passport holders; the visa must be obtained in advance from the High Commission of Brunei Darussalam in New Delhi.', 61, 1, 6100, 1),
('Why do I need a sponsor for a Brunei visa?', 'Nationals of Bangladesh, India, Iran, Pakistan, and Sri Lanka are required to have a sponsor — a Brunei-registered travel agency, airline, hotel, or Brunei resident — who provides a supporting letter for the application.', 61, 1, 6101, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    61, 2, 'BRN-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Brunei.',
    'Business travellers apply through the same High Commission process as tourists, with a business sponsor/inviting company instead of a travel-agency sponsor.',
    'Typically up to 30 days',
    'Apply through the High Commission of Brunei Darussalam in New Delhi with a business sponsor letter',
    1,
    'Typically 5-7 working days; apply at least 3 weeks before travel',
    'High Commission of Brunei Darussalam, New Delhi',
    'Obtain a business invitation/sponsor letter from the Brunei company\nComplete the visa application form\nGather passport, photo, and supporting documents\nSubmit the application at the High Commission in New Delhi\nPay the visa fee and collect the visa',
    '/assets/images/visa-heroes/brunei.webp',
    'BTW Visas and VisaGo secondary sourcing', 'https://btwvisas.com/visa-guide/brunei-visa', '2026-09-19'
);
SET @brn2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brn2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn2, 'Core Documents', 'Required from every applicant.', 1);
SET @brn2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@brn2s1, 'Business Invitation/Sponsor Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @brn2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@brn2s2, 'Confirmed Flight Tickets (Round Trip)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(61, 2, 2500.00, 'INR', 'Multiple-Entry Short-Visit Visa Fee', 'Single-entry visa is INR 1000.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/brunei-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should business travellers apply for the multiple-entry visa?', 'If you expect repeat trips to Brunei, the multiple-entry short-visit visa (INR 2500) may be more convenient than the single-entry option (INR 1000).', 61, 2, 6102, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    61, 3, 'BRN-STUD-IN-01', '2026.09', 'published',
    'Academic study in Brunei.',
    'A distinct Student Visa category exists per general sourcing; likely requires an admission-backed application via the High Commission.',
    'Tied to the academic program duration',
    'Apply through the High Commission of Brunei Darussalam in New Delhi',
    1,
    'Not independently confirmed this session for a specific working-day figure beyond the standard 5-7 working days',
    'High Commission of Brunei Darussalam, New Delhi',
    'Secure admission confirmation from the Bruneian institution\nArrange a sponsor letter (often the institution itself)\nGather proof of financial support\nSubmit the visa application at the High Commission\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/brunei.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/brunei-visa', '2026-09-19'
);
SET @brn3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brn3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn3, 'Core Documents', 'Required from every applicant.', 1);
SET @brn3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@brn3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @brn3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@brn3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(61, 3, NULL, 'INR', 'Confirm at High Commission', 'Student visa fee not independently confirmed this session; confirm with the High Commission of Brunei Darussalam.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/brunei-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a sponsor for a Brunei student visa?', 'Yes — the sponsor requirement applies to Indian nationals across visa categories; for students this is typically arranged through the admitting institution.', 61, 3, 6103, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    61, 4, 'BRN-WORK-IN-01', '2026.09', 'published',
    'Employment with a Bruneian company.',
    'A distinct Employment Visa category exists per general sourcing; requires an employer sponsor and work-permit backing.',
    'Tied to the employment contract duration',
    'Employer sponsors the application through the High Commission of Brunei Darussalam',
    1,
    'Not independently confirmed this session for a specific working-day figure beyond the standard 5-7 working days',
    'High Commission of Brunei Darussalam, New Delhi',
    'Secure a signed employment contract from the Bruneian employer\nHave the employer act as sponsor and provide a letter\nGather proof of qualifications\nSubmit the visa application at the High Commission\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/brunei.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/brunei-visa', '2026-09-19'
);
SET @brn4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brn4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn4, 'Core Documents', 'Required from every applicant.', 1);
SET @brn4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@brn4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @brn4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@brn4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(61, 4, NULL, 'INR', 'Confirm at High Commission', 'Work visa fee not independently confirmed this session; confirm with the High Commission of Brunei Darussalam.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/brunei-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who sponsors a Brunei work visa for Indian citizens?', 'The employer typically acts as the required sponsor, providing the supporting letter for the employment visa application.', 61, 4, 6104, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    61, 5, 'BRN-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Brunei.',
    'Family visits use the same High Commission process as tourism, with the resident family member acting as sponsor.',
    'Typically up to 30 days',
    'Apply through the High Commission of Brunei Darussalam in New Delhi with a sponsor letter from the resident family member',
    1,
    'Typically 5-7 working days; apply at least 3 weeks before travel',
    'High Commission of Brunei Darussalam, New Delhi',
    'Obtain a sponsor letter from the family member resident in Brunei\nComplete the visa application form\nGather passport, photo, and relationship proof\nSubmit the application at the High Commission in New Delhi\nPay the visa fee and collect the visa',
    '/assets/images/visa-heroes/brunei.webp',
    'BTW Visas and VisaGo secondary sourcing', 'https://btwvisas.com/visa-guide/brunei-visa', '2026-09-19'
);
SET @brn5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brn5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn5, 'Core Documents', 'Required from every applicant.', 1);
SET @brn5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@brn5s1, 'Sponsor Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @brn5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@brn5s2, 'Confirmed Flight Tickets (Round Trip)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(61, 5, 1000.00, 'INR', 'Single-Entry Visa Fee', 'Multiple-entry short-visit visa is INR 2500.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/brunei-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my family member in Brunei act as my visa sponsor?', 'Yes — a Brunei resident can act as the required sponsor for a family-visit visa, providing the supporting letter for your application.', 61, 5, 6105, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    61, 6, 'BRN-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Brunei en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard visa or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the High Commission of Brunei Darussalam or your airline whether the standard visa applies',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'High Commission of Brunei Darussalam, New Delhi',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific visa is required\nContact the High Commission if needed\nSubmit passport and onward ticket for the application\nConfirm sponsor requirements if applicable',
    '/assets/images/visa-heroes/brunei.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/brunei-visa', '2026-09-19'
);
SET @brn6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brn6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn6, 'Core Documents', 'Required from every applicant.', 1);
SET @brn6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@brn6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @brn6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(61, 6, NULL, 'INR', 'Confirm at High Commission', 'Transit fee not independently confirmed this session; confirm with the High Commission of Brunei Darussalam.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/brunei-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Brunei?', 'Not independently confirmed this session — confirm with the High Commission of Brunei Darussalam or your airline whether your specific transit routing requires the standard visa.', 61, 6, 6106, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    61, 7, 'BRN-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Brunei.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa with medical documentation and a sponsor.',
    'Typically up to 30 days',
    'Apply through the High Commission of Brunei Darussalam in New Delhi',
    1,
    'Typically 5-7 working days; apply at least 3 weeks before travel',
    'High Commission of Brunei Darussalam, New Delhi',
    'Obtain a medical appointment/admission letter from the hospital (often acting as sponsor)\nComplete the visa application form\nGather passport, photo, and medical documents\nSubmit the application at the High Commission\nPay the visa fee and collect the visa',
    '/assets/images/visa-heroes/brunei.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/brunei-visa', '2026-09-19'
);
SET @brn7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brn7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn7, 'Core Documents', 'Required from every applicant.', 1);
SET @brn7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@brn7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @brn7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@brn7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(61, 7, 1000.00, 'INR', 'Single-Entry Visa Fee', 'Multiple-entry short-visit visa is INR 2500.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/brunei-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Brunei?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard visa with supporting medical documentation and a sponsor (often the hospital).', 61, 7, 6107, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    61, 8, 'BRN-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Brunei.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business visa framework with an event sponsor.',
    'Typically up to 30 days',
    'Apply through the High Commission of Brunei Darussalam in New Delhi',
    1,
    'Typically 5-7 working days; apply at least 3 weeks before travel',
    'High Commission of Brunei Darussalam, New Delhi',
    'Obtain an official invitation/sponsor letter from the event organiser\nComplete the visa application form\nGather passport, photo, and event documents\nSubmit the application at the High Commission\nPay the visa fee and collect the visa',
    '/assets/images/visa-heroes/brunei.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/brunei-visa', '2026-09-19'
);
SET @brn8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brn8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn8, 'Core Documents', 'Required from every applicant.', 1);
SET @brn8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@brn8s1, 'Official Event Invitation/Sponsor Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @brn8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(61, 8, 2500.00, 'INR', 'Multiple-Entry Short-Visit Visa Fee', 'Single-entry visa is INR 1000.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/brunei-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Brunei?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business visa framework with an official invitation/sponsor letter.', 61, 8, 6108, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    61, 9, 'BRN-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Brunei.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa with a federation/event sponsor.',
    'Typically up to 30 days',
    'Apply through the High Commission of Brunei Darussalam in New Delhi',
    1,
    'Typically 5-7 working days; apply at least 3 weeks before travel',
    'High Commission of Brunei Darussalam, New Delhi',
    'Obtain an official invitation/sponsor letter from the sporting federation/event organiser\nComplete the visa application form\nGather passport, photo, and event documents\nSubmit the application at the High Commission\nPay the visa fee and collect the visa',
    '/assets/images/visa-heroes/brunei.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/brunei-visa', '2026-09-19'
);
SET @brn9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brn9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn9, 'Core Documents', 'Required from every applicant.', 1);
SET @brn9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@brn9s1, 'Official Event/Federation Invitation/Sponsor Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @brn9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(61, 9, 2500.00, 'INR', 'Multiple-Entry Short-Visit Visa Fee', 'Single-entry visa is INR 1000.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/brunei-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Brunei?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard visa with a federation/event sponsor.', 61, 9, 6109, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    61, 10, 'BRN-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Brunei work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the High Commission of Brunei Darussalam for the dependent-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'High Commission of Brunei Darussalam, New Delhi',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply via the High Commission of Brunei Darussalam\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/brunei.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/brunei-visa', '2026-09-19'
);
SET @brn10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@brn10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn10, 'Core Documents', 'Required from every applicant.', 1);
SET @brn10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@brn10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@brn10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @brn10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@brn10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@brn10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(61, 10, NULL, 'INR', 'Confirm at High Commission', 'Dependent visa fee not independently confirmed this session; confirm with the High Commission of Brunei Darussalam.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/brunei-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent visa in Brunei?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the High Commission of Brunei Darussalam.', 61, 10, 6110, 1);
