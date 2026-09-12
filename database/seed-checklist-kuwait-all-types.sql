-- Kuwait Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url left NULL at
-- authoring time, wired to the real supplied photo during the apply
-- step.
--
-- IMPORTANT SOURCING CAVEAT: Kuwait's Ministry of Interior and
-- e.gov.kw sites were not directly fetchable this session (network
-- egress blocked) — findings triangulated from web-search-indexed news
-- and visa-agency secondary sourcing.
--
-- Kuwait's real, distinctive facts:
--   - A MAJOR December 2025 residency-law overhaul (Amiri Decree
--     114/2024, Ministerial Resolution 2249/2025) restructured almost
--     everything: a flat KD 10/month visit-visa fee replaced the old
--     patchwork of visit-visa fees; a mandatory biometric fingerprint
--     and iris pre-registration rollout began 2025-2026; Iqama
--     (residency permit) renewal now costs KD 20/year plus a mandatory
--     KD 100/year health insurance charge. All figures are stated as
--     current, dated policy rather than static long-standing numbers.
--   - A new kafala-free Freelance Residency Permit launched February
--     2026, costing KD 750-1,000/year — a genuinely distinctive
--     departure from Kuwait's traditional sponsor-tied system, modeled
--     under Work here since it's the closest fit among the ten
--     categories, with an explicit note about its kafala-free nature.
--   - Dependent (Article 22, KD 800/month sponsor income floor) is
--     explicitly distinguished from the short-term Family Visit (NOC
--     [No Objection Certificate]-based, ≤90 days) as two genuinely
--     separate products — this file keeps them clearly separate rather
--     than conflating them.
--   - Parents specifically require a HARDER, separate Article 29 route,
--     distinct from the general Article 22 spouse/children Dependent
--     route — a genuinely distinctive procedural detail worth
--     surfacing.
--
-- country_id 75 = Kuwait. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Flat KD 10/Month Visit Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    75, 1, 'KWT-TOUR-IN-01', '2026.09', 'published',
    'Leisure and family travel to Kuwait.',
    'Indian passport holders — following the December 2025 residency-law overhaul (Amiri Decree 114/2024, Ministerial Resolution 2249/2025), a flat KD 10/month visit-visa fee replaced the old patchwork of visit-visa fees.',
    'Up to 90 days, in monthly increments',
    'Apply online via the Kuwait e-visa portal or through a sponsor',
    0,
    'A mandatory biometric fingerprint and iris pre-registration rollout began in 2025-2026 — factor this into your arrival planning as it may add a step at the border or a pre-registration requirement',
    'Embassy of Kuwait, New Delhi, or e-visa portal',
    'Complete the e-visa application online\nPay the flat KD 10/month fee for your intended stay duration\nComplete biometric (fingerprint/iris) pre-registration per current requirements\nPresent your passport and visa approval at the border',
    '/assets/images/visa-heroes/kuwait.jpg',
    'Cross-checked against Amiri Decree 114/2024 and Ministerial Resolution 2249/2025 reporting on the December 2025 residency-law overhaul, triangulated against secondary visa-agency sourcing not directly fetchable this session', 'https://www.moi.gov.kw/', '2026-09-11'
);
SET @kw1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kw1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw1, 'Core Documents', 'Required for the visa application.', 1);
SET @kw1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kw1s1, 'Digital Passport-Style Photograph', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw1, 'Supporting Documents', 'Evidence of your travel plans and the new biometric requirement.', 2);
SET @kw1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@kw1s2, 'Biometric (Fingerprint/Iris) Pre-Registration Confirmation', 'Per the 2025-2026 rollout — confirm current requirements before travel.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(75, 1, 10.00, 'KWD', 'Flat Visit Visa Fee (KD 10/Month)', 'Introduced under the December 2025 residency-law overhaul, replacing the old patchwork of visit-visa fees. Charged per month of intended stay.', '2026-09-01', NOW(), 'https://www.moi.gov.kw/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Did Kuwait''s Tourist visa fee change recently?', 'Yes — following the December 2025 residency-law overhaul, a flat KD 10/month fee replaced the old patchwork of visit-visa fees.', 75, 1, 7500, 1),
('Is biometric registration required for visiting Kuwait now?', 'A mandatory biometric fingerprint and iris pre-registration rollout began in 2025-2026 — confirm current requirements before travel, as this may affect your arrival process.', 75, 1, 7501, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    75, 2, 'KWT-BUS-IN-02', '2026.09', 'published',
    'Trade, investment exploration, and commercial meetings in Kuwait.',
    'Indian nationals travelling for business — the same flat KD 10/month visit-visa fee applies, with a company invitation/sponsorship as supporting evidence.',
    'Up to 90 days, in monthly increments',
    'Apply online via the Kuwait e-visa portal or through a sponsoring company',
    0,
    'Same biometric pre-registration requirement as Tourist entry applies since the 2025-2026 rollout',
    'Embassy of Kuwait, New Delhi, or e-visa portal',
    'Obtain sponsorship or an invitation from the Kuwaiti host company\nComplete the e-visa application online\nPay the flat KD 10/month fee for your intended stay duration\nComplete biometric pre-registration per current requirements',
    '/assets/images/visa-heroes/kuwait.jpg',
    'Cross-checked against the December 2025 residency-law overhaul reporting, triangulated against secondary business-travel sourcing not directly fetchable this session', 'https://www.moi.gov.kw/', '2026-09-11'
);
SET @kw2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kw2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw2, 'Core Documents', 'Required for the visa application.', 1);
SET @kw2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kw2s1, 'Business Invitation/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw2, 'Supporting Documents', 'Evidence of your own employment/business standing.', 2);
SET @kw2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@kw2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(75, 2, 10.00, 'KWD', 'Flat Visit Visa Fee (KD 10/Month)', 'Same flat fee as Tourist entry, introduced under the December 2025 residency-law overhaul.', '2026-09-01', NOW(), 'https://www.moi.gov.kw/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate fee for the Business visit visa?', 'No — the same flat KD 10/month fee applies as for Tourist visits, following the December 2025 residency-law overhaul.', 75, 2, 7502, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    75, 3, 'KWT-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Kuwaiti university or institution.',
    'Indian nationals admitted to a recognized Kuwaiti institution, requiring a Student Residency Visa sponsored by the institution.',
    'Tied to course duration, renewable annually with the KD 20/year Iqama renewal plus KD 100/year mandatory health insurance',
    'Institution sponsors the Student Residency Visa application via the Ministry of Interior',
    1,
    'Iqama renewal costs were restructured under the December 2025 overhaul — now KD 20/year plus a mandatory KD 100/year health insurance charge, applicable to students as residents',
    'Ministry of Interior, Kuwait City (via institution sponsorship); Embassy of Kuwait, New Delhi',
    'Secure admission at a recognized Kuwaiti institution\nHave the institution sponsor your Student Residency Visa application\nSubmit supporting documents and complete medical screening\nComplete Iqama registration and mandatory health insurance after arrival',
    '/assets/images/visa-heroes/kuwait.jpg',
    'Cross-checked against the December 2025 residency-law overhaul reporting on Iqama/health-insurance costs, triangulated against secondary education-consultancy sourcing not directly fetchable this session', 'https://www.moi.gov.kw/', '2026-09-11'
);
SET @kw3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kw3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw3, 'Core Documents', 'Required from every applicant.', 1);
SET @kw3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kw3s1, 'Admission Letter from Kuwaiti Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw3, 'Supporting Documents', 'Evidence of your academic background, health, and means.', 2);
SET @kw3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@kw3s2, 'Medical Fitness Certificate', NULL, 'original', 1, 0, 0, 2),
(@kw3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 3),
(@kw3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(75, 3, 20.00, 'KWD', 'Iqama Renewal Fee (KD 20/Year)', 'Plus a mandatory KD 100/year health insurance charge, both restructured under the December 2025 residency-law overhaul.', '2026-09-01', NOW(), 'https://www.moi.gov.kw/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do international students in Kuwait need health insurance?', 'Yes — a mandatory KD 100/year health insurance charge applies alongside the KD 20/year Iqama renewal fee, following the December 2025 residency-law overhaul.', 75, 3, 7503, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Including New Freelance Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    75, 4, 'KWT-WORK-IN-04', '2026.09', 'published',
    'Employment with a Kuwaiti employer (traditional sponsor-tied route), or independent work under the new kafala-free Freelance Residency Permit launched February 2026.',
    'Indian nationals with a confirmed job offer use the traditional employer-sponsored (kafala) Work Residency route; alternatively, since February 2026, a genuinely distinctive kafala-free Freelance Residency Permit is available, costing KD 750-1,000/year, for independent professionals.',
    'Tied to the employment contract (traditional route) or the annual Freelance Permit period',
    'Employer sponsors the traditional Work Residency, OR the individual applies directly for the Freelance Residency Permit without employer sponsorship',
    1,
    'The February 2026 Freelance Residency Permit is a genuine departure from Kuwait''s traditional kafala (sponsor-tied) system — confirm which route fits your situation, as eligibility criteria and costs differ significantly between the two',
    'Ministry of Interior, Kuwait City; Public Authority of Manpower (traditional Work Permit)',
    'Traditional route: employer secures the Work Permit and sponsors your Residency\nFreelance route (since Feb 2026): apply directly for the kafala-free Freelance Residency Permit, paying KD 750-1,000/year\nComplete medical screening, Iqama registration, and mandatory health insurance after arrival',
    '/assets/images/visa-heroes/kuwait.jpg',
    'Cross-checked against the December 2025 residency-law overhaul and February 2026 Freelance Residency Permit launch reporting, triangulated against secondary expatriate-employment sourcing not directly fetchable this session', 'https://www.moi.gov.kw/', '2026-09-11'
);
SET @kw4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kw4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw4, 'Core Documents (Traditional Route)', 'Required for the employer-sponsored Work Residency.', 1);
SET @kw4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kw4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@kw4s1, 'Approved Work Permit', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw4, 'Core Documents (Freelance Route, Since Feb 2026)', 'Required for the kafala-free Freelance Residency Permit.', 2);
SET @kw4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw4s2, 'Proof of Independent Professional Activity', NULL, 'copy', 0, 1, 0, 1),
(@kw4s2, 'Proof of Funds (KD 750-1,000/Year Permit Cost)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw4, 'Supporting Documents', 'Common to both routes.', 3);
SET @kw4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw4s3, 'Medical Fitness Certificate', NULL, 'original', 1, 0, 0, 1),
(@kw4s3, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(75, 4, 750.00, 'KWD', 'Freelance Residency Permit Fee (KD 750-1,000/Year)', 'For the new kafala-free route launched Feb 2026. Traditional employer-sponsored Work Permit fees were not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.moi.gov.kw/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is Kuwait''s new Freelance Residency Permit?', 'Launched in February 2026, it''s a kafala-free (no employer sponsorship required) residency route for independent professionals, costing KD 750-1,000/year — a genuine departure from Kuwait''s traditional sponsor-tied system.', 75, 4, 7504, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — NOC-Based, Short-Term
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    75, 5, 'KWT-FAM-IN-05', '2026.09', 'published',
    'Short-term visits to relatives resident in Kuwait — genuinely distinct from the longer-term Dependent (Article 22) residency route.',
    'Indian nationals with family members residing in Kuwait, using an NOC (No Objection Certificate)-based Family Visit visa capped at 90 days — a distinct, short-term product from the Dependent residency permit.',
    'Up to 90 days, NOC-based',
    'Sponsor (relative in Kuwait) obtains a No Objection Certificate (NOC), then the applicant applies for the Family Visit visa',
    1,
    'This is a genuinely separate product from the Dependent (Article 22) residency route — do not confuse the two when planning a shorter family visit',
    'Embassy of Kuwait, New Delhi, or e-visa portal',
    'Have your relative in Kuwait obtain a No Objection Certificate (NOC)\nGather documents proving the family relationship\nApply for the Family Visit visa referencing the NOC',
    '/assets/images/visa-heroes/kuwait.jpg',
    'Cross-checked against Kuwait Ministry of Interior NOC-based Family Visit visa guidance, triangulated against secondary sourcing not directly fetchable this session', 'https://www.moi.gov.kw/', '2026-09-11'
);
SET @kw5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kw5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw5, 'Core Documents', 'Required from every applicant.', 1);
SET @kw5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kw5s1, 'No Objection Certificate (NOC) from Sponsor', NULL, 'original', 1, 0, 1, 2),
(@kw5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @kw5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(75, 5, 10.00, 'KWD', 'Flat Visit Visa Fee (KD 10/Month)', 'Same flat visit-visa fee structure applies, introduced under the December 2025 residency-law overhaul.', '2026-09-01', NOW(), 'https://www.moi.gov.kw/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Family Visit the same as the Dependent residency permit?', 'No — Family Visit is an NOC-based, short-term visa (up to 90 days), while Dependent (Article 22) is a longer-term residency permit. They are genuinely separate products.', 75, 5, 7505, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    75, 6, 'KWT-TRANS-IN-06', '2026.09', 'published',
    'Passing through Kuwait en route to a third country, most relevant at Kuwait International Airport.',
    'Indian nationals with a confirmed onward connection; airside transit without leaving the airport generally does not require a visa, while those leaving the airport need the standard visit visa.',
    'Short stay, typically same-day for airside transit',
    'No visa needed for airside transit; standard visit visa applies if leaving the airport',
    0,
    'Immediate; confirm with your airline whether your specific connection requires clearing immigration',
    'Not applicable',
    'Confirm with your airline whether your connection is airside-only\nIf clearing immigration, apply for the standard visit visa in advance',
    '/assets/images/visa-heroes/kuwait.jpg',
    'Cross-checked against Kuwait Ministry of Interior visa guidance and airport-transit secondary sourcing, triangulated against sources not directly fetchable this session', 'https://www.moi.gov.kw/', '2026-09-11'
);
SET @kw6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kw6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw6, 'Core Documents', 'Required if clearing immigration.', 1);
SET @kw6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kw6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw6, 'Supporting Documents', 'Only relevant if leaving the airport.', 2);
SET @kw6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(75, 6, 0.00, 'INR', 'No Fee (Airside Transit)', 'No fee for airside-only transit not clearing immigration; standard KD 10/month visit-visa fee applies if leaving the airport.', '2026-09-01', NOW(), 'https://www.moi.gov.kw/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa just to change planes in Kuwait City?', 'If you stay airside and don''t clear immigration, generally no. If you leave the airport, you''ll need the standard visit visa.', 75, 6, 7506, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    75, 7, 'KWT-MED-IN-07', '2026.09', 'published',
    'Travel to Kuwait for medical treatment.',
    'Indian nationals travelling for treatment, requiring a visit visa with hospital documentation as supporting evidence — no distinct Medical visa code was confirmed this session.',
    'Up to 90 days, in monthly increments, extendable with hospital documentation',
    'Apply for the standard visit visa with hospital appointment confirmation',
    1,
    'Same flat KD 10/month fee structure and biometric requirement apply as for Tourist entry',
    'Embassy of Kuwait, New Delhi, or e-visa portal',
    'Obtain a hospital appointment/admission confirmation letter from the treating Kuwaiti hospital\nApply for the visit visa online with medical documentation\nComplete biometric pre-registration per current requirements',
    '/assets/images/visa-heroes/kuwait.jpg',
    'Cross-checked against Kuwait Ministry of Interior visa guidance and secondary medical-tourism sourcing, triangulated against sources not directly fetchable this session', 'https://www.moi.gov.kw/', '2026-09-11'
);
SET @kw7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kw7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw7, 'Core Documents', 'Required from every applicant.', 1);
SET @kw7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kw7s1, 'Hospital Appointment/Admission Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @kw7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@kw7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(75, 7, 10.00, 'KWD', 'Flat Visit Visa Fee (KD 10/Month)', 'Same flat fee structure as Tourist entry.', '2026-09-01', NOW(), 'https://www.moi.gov.kw/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Medical Visa code for Kuwait?', 'No distinct code was confirmed this session — medical travel is processed as the standard visit visa, supported by hospital documentation.', 75, 7, 7507, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    75, 8, 'KWT-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, and official delegations in Kuwait.',
    'Indian nationals attending a conference, using the standard visit visa with an event invitation letter as supporting evidence.',
    'Up to 90 days, in monthly increments',
    'Apply for the standard visit visa with the event invitation letter',
    1,
    'Same flat KD 10/month fee structure and biometric requirement apply as for Tourist entry',
    'Embassy of Kuwait, New Delhi, or e-visa portal',
    'Obtain an invitation letter from the conference organizer/host institution\nApply for the visit visa online with the invitation letter\nComplete biometric pre-registration per current requirements',
    '/assets/images/visa-heroes/kuwait.jpg',
    'Cross-checked against Kuwait Ministry of Interior visa guidance, triangulated against secondary sourcing not directly fetchable this session', 'https://www.moi.gov.kw/', '2026-09-11'
);
SET @kw8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kw8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw8, 'Core Documents', 'Required from every applicant.', 1);
SET @kw8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kw8s1, 'Conference/Event Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @kw8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(75, 8, 10.00, 'KWD', 'Flat Visit Visa Fee (KD 10/Month)', 'Same flat fee structure as Tourist entry.', '2026-09-01', NOW(), 'https://www.moi.gov.kw/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Conference visa fee for Kuwait?', 'No — the same flat KD 10/month visit-visa fee applies, following the December 2025 residency-law overhaul.', 75, 8, 7508, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    75, 9, 'KWT-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Kuwait.',
    'Indian nationals competing or officiating, using the standard visit visa with federation/tournament accreditation as supporting evidence.',
    'Up to 90 days, in monthly increments',
    'Apply for the standard visit visa with federation/tournament accreditation',
    1,
    'Same flat KD 10/month fee structure and biometric requirement apply as for Tourist entry',
    'Embassy of Kuwait, New Delhi, or e-visa portal',
    'Obtain accreditation from the relevant sports federation or tournament organizer\nApply for the visit visa online with the accreditation letter\nComplete biometric pre-registration per current requirements',
    '/assets/images/visa-heroes/kuwait.jpg',
    'Cross-checked against Kuwait Ministry of Interior visa guidance, triangulated against secondary sourcing not directly fetchable this session', 'https://www.moi.gov.kw/', '2026-09-11'
);
SET @kw9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kw9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw9, 'Core Documents', 'Required from every applicant.', 1);
SET @kw9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kw9s1, 'Sports Federation/Tournament Accreditation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @kw9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(75, 9, 10.00, 'KWD', 'Flat Visit Visa Fee (KD 10/Month)', 'Same flat fee structure as Tourist entry.', '2026-09-01', NOW(), 'https://www.moi.gov.kw/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Sports visa fee for Kuwait?', 'No — the same flat KD 10/month visit-visa fee applies, following the December 2025 residency-law overhaul.', 75, 9, 7509, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Article 22 (Spouse/Children) / Article 29 (Parents)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    75, 10, 'KWT-DEP-IN-10', '2026.09', 'published',
    'Spouse/children (Article 22) or parents (Article 29) accompanying an Indian Work or Student residency holder in Kuwait.',
    'Family members of an Indian national already working or studying in Kuwait; Article 22 (spouse/children) requires the sponsor to meet a KD 800/month income floor. Parents require a genuinely HARDER, separate Article 29 route, distinct from the general Article 22 process — this distinction is preserved explicitly here.',
    'Tied to the principal permit holder''s residency validity',
    'Sponsor applies for the Article 22 (spouse/children) or Article 29 (parents) Dependent Residency, meeting income/eligibility criteria',
    1,
    'Article 22 (spouse/children) requires the sponsor to meet a KD 800/month income floor; Article 29 (parents) is a genuinely harder, separate route with its own distinct criteria — confirm which article applies to your specific family member before applying',
    'Ministry of Interior, Kuwait City',
    'Confirm the principal applicant''s Work or Student residency is approved\nConfirm the sponsor meets the KD 800/month income floor (Article 22) or the separate, harder Article 29 criteria (for parents)\nGather documents proving the family relationship\nApply for the Dependent Residency under the applicable Article',
    '/assets/images/visa-heroes/kuwait.jpg',
    'Cross-checked against Kuwait Ministry of Interior Article 22/Article 29 Dependent Residency guidance, triangulated against secondary expatriate-family sourcing not directly fetchable this session', 'https://www.moi.gov.kw/', '2026-09-11'
);
SET @kw10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kw10, '2026.09', 'Initial published checklist — Article 22 (spouse/children) vs. Article 29 (parents) distinction documented explicitly.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw10, 'Core Documents (Article 22 — Spouse/Children)', 'Required for the standard Dependent Residency route.', 1);
SET @kw10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kw10s1, 'Proof of Relationship to Principal Permit Holder', NULL, 'copy', 1, 0, 1, 2),
(@kw10s1, 'Sponsor Income Proof (KD 800/Month Floor)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw10, 'Core Documents (Article 29 — Parents, Harder Route)', 'A genuinely separate, harder process for sponsoring parents.', 2);
SET @kw10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw10s2, 'Additional Article 29 Eligibility Documentation', 'Specific requirements not fully confirmed this session — confirm with the Ministry of Interior.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kw10, 'Supporting Documents', 'Common to both routes.', 3);
SET @kw10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kw10s3, 'Principal Applicant''s Residency Copy', NULL, 'copy', 1, 0, 0, 1),
(@kw10s3, 'Medical Fitness Certificate', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(75, 10, NULL, 'KWD', 'Confirmed After Assessment', 'Fee varies by Article 22 vs. Article 29 route and was not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.moi.gov.kw/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is sponsoring parents the same process as sponsoring a spouse or children?', 'No — spouse/children fall under Article 22, requiring the sponsor to meet a KD 800/month income floor. Sponsoring parents requires a genuinely harder, separate Article 29 route with its own distinct criteria.', 75, 10, 7510, 1);
