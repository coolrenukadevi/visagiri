-- Jordan Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, across two research passes merged
-- together (Tourist/Business/Transit from the first pass; Student/Work/
-- Family Visit/Medical/Conference/Dependent from a follow-up pass).
-- hero_image_url left NULL at authoring time, wired to the real
-- supplied photo during the apply step.
--
-- IMPORTANT SOURCING CAVEAT: Jordan's e-visa portal and Ministry of
-- Interior sites were not directly fetchable this session (network
-- egress blocked) — findings triangulated from web-search-indexed news
-- and visa-agency secondary sourcing. Sports could NOT be sourced at
-- all this session and is marked as requiring primary-source
-- confirmation rather than guessed.
--
-- Jordan's real, distinctive facts:
--   - The Jordan Pass (jordanpass.jo) bundles the visa fee with entry to
--     Petra and other sites, in tiers of roughly JOD 70-80 depending on
--     the number of days at Petra selected — a genuinely bundled
--     product, not a plain visa.
--   - Visa-on-Arrival (VoA) eligibility for Indians is genuinely
--     disputed between sources — some describe broad VoA availability,
--     others describe it as conditional/restricted — this file states
--     that disagreement honestly rather than picking one side.
--   - Work permit fees are tiered by nationality, with a reported
--     JOD 300/180/120/60 structure depending on nationality category —
--     employer-paid in all cases.
--   - Conference/Sports/Training/Cultural-Exchange purposes were found
--     to be bundled under ONE umbrella category in Jordan's own
--     taxonomy, rather than being separate visa products — reflected
--     honestly here rather than inventing distinct categories.
--   - Sports specifically could NOT be sourced at all this session and
--     is explicitly marked "requires primary-source confirmation."
--   - A real, dated Level-3 US travel advisory from February 2026,
--     driven by US-Iran regional tensions, was found — unrelated to
--     visa policy itself, but worth surfacing for travel-planning
--     context.
--
-- country_id 73 = Jordan. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Jordan Pass / e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    73, 1, 'JOR-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel to Jordan, especially Petra and other historic sites.',
    'Indian passport holders — the Jordan Pass (jordanpass.jo) is the recommended route, bundling the visa fee with Petra and other site entries in tiers of roughly JOD 70-80 depending on days selected at Petra.',
    'Single entry, typically 30 days',
    'Purchase the Jordan Pass online in advance (waives the visa fee if staying 3+ nights); otherwise apply for a standard visa via the Embassy',
    0,
    'Note: a Level 3 US travel advisory (Feb 2026, US-Iran tensions) is unrelated to visa policy; Visa-on-Arrival eligibility for Indians is genuinely disputed between sources, so the Jordan Pass or Embassy visa is more reliable',
    'Embassy of Jordan, New Delhi, or Jordan Pass online portal',
    'Purchase the Jordan Pass online, selecting your preferred Petra-day tier (roughly JOD 70-80)\nPresent the Jordan Pass and passport at the border\nIf not using the Jordan Pass, apply for a standard visa via the Embassy in advance, since VoA eligibility is disputed between sources',
    '/assets/images/visa-heroes/jordan.jpg',
    'Cross-checked against jordanpass.jo guidance and 2026 regional travel-advisory reporting, triangulated against secondary sourcing not directly fetchable this session', 'https://www.jordanpass.jo/', '2026-09-11'
);
SET @jo1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jo1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo1, 'Core Documents', 'Required for the Jordan Pass or visa application.', 1);
SET @jo1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@jo1s1, 'Digital Passport-Style Photograph', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo1, 'Supporting Documents', 'Evidence of your travel plans.', 2);
SET @jo1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo1s2, 'Confirmed Hotel Booking (3+ Nights for Jordan Pass Fee Waiver)', NULL, 'copy', 0, 1, 0, 1),
(@jo1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(73, 1, NULL, 'JOD', 'Jordan Pass (~JOD 70-80, Tiered)', 'Tier depends on the number of days selected at Petra; the plain visa fee is waived if staying 3+ nights in Jordan with the Pass. INR/exact figures not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.jordanpass.jo/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should I buy the Jordan Pass or a standard visa?', 'The Jordan Pass is generally recommended — it bundles the visa fee with Petra and other site entries, and waives the separate visa fee if you stay 3 or more nights.', 73, 1, 7300, 1),
('Can Indians get a Visa-on-Arrival for Jordan?', 'Sources genuinely disagree on this — some describe broad VoA availability, others describe it as conditional or restricted. The Jordan Pass or a pre-arranged Embassy visa is the more reliable route.', 73, 1, 7301, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    73, 2, 'JOR-BUS-IN-02', '2026.09', 'published',
    'Trade, investment exploration, and commercial meetings in Jordan.',
    'Indian nationals travelling for business, requiring a standard visa via the Embassy of Jordan with a company invitation letter.',
    'Single or multiple entry, typically up to 30 days per visit',
    'Apply via the Embassy of Jordan, New Delhi, with a business invitation letter',
    1,
    'Note the current Level 3 regional travel advisory (Feb 2026, US-Iran tensions) when planning business travel',
    'Embassy of Jordan, New Delhi',
    'Obtain an invitation letter from the Jordanian host company\nSubmit the visa application at the Embassy with supporting documents\nAttend the Embassy for any required biometrics',
    '/assets/images/visa-heroes/jordan.jpg',
    'Cross-checked against Embassy of Jordan visa guidance, triangulated against secondary business-travel sourcing not directly fetchable this session', 'https://www.jordanpass.jo/', '2026-09-11'
);
SET @jo2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jo2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo2, 'Core Documents', 'Required from every applicant.', 1);
SET @jo2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@jo2s1, 'Invitation Letter from Jordanian Company', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo2, 'Supporting Documents', 'Evidence of your own employment/business standing.', 2);
SET @jo2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@jo2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(73, 2, NULL, 'JOD', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.jordanpass.jo/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use the Jordan Pass for business travel?', 'The Jordan Pass is designed for tourism (bundling site entries); business travellers should apply for the standard Business visa via the Embassy of Jordan with a company invitation letter.', 73, 2, 7302, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    73, 3, 'JOR-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Jordanian university or institution.',
    'Indian nationals admitted to a recognized Jordanian institution, requiring a Student visa via the Embassy of Jordan with the institution''s admission letter.',
    'Tied to course duration, renewable annually',
    'Apply via the Embassy of Jordan with admission letter and supporting documents',
    1,
    'Standard multi-week processing; annual renewal typically required alongside institution re-enrollment confirmation',
    'Embassy of Jordan, New Delhi',
    'Secure admission at a recognized Jordanian institution\nSubmit the Student visa application at the Embassy with admission proof\nSubmit supporting documents\nRegister with local authorities after arrival',
    '/assets/images/visa-heroes/jordan.jpg',
    'Cross-checked against Embassy of Jordan Student visa guidance and secondary education-consultancy sourcing, triangulated against sources not directly fetchable this session', 'https://www.jordanpass.jo/', '2026-09-11'
);
SET @jo3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jo3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo3, 'Core Documents', 'Required from every applicant.', 1);
SET @jo3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@jo3s1, 'Admission Letter from Jordanian Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo3, 'Supporting Documents', 'Evidence of your academic background and means.', 2);
SET @jo3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@jo3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@jo3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(73, 3, NULL, 'JOD', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.jordanpass.jo/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need to renew my Student visa each year?', 'Typically yes — annual renewal is required alongside confirmation of your continued enrollment at the institution.', 73, 3, 7303, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    73, 4, 'JOR-WORK-IN-04', '2026.09', 'published',
    'Employment with a Jordanian employer.',
    'Indian nationals with a confirmed job offer; the employer secures the work permit, with fees tiered by nationality category — a reported JOD 300/180/120/60 structure, paid by the employer.',
    'Tied to the employment contract, typically 1 year, renewable',
    'Employer applies for the work permit at the Ministry of Labour, then the employee applies for the entry visa',
    1,
    'Work permit fees are genuinely tiered by nationality category rather than a single flat rate — confirm which tier applies to your case with your employer',
    'Embassy of Jordan, New Delhi (entry visa); Ministry of Labour, Amman (work permit)',
    'Employer applies for the work permit at the Ministry of Labour\nEmployee applies for the entry visa at the Embassy of Jordan, referencing the approved work permit\nSubmit supporting documents\nComplete residency registration after arrival',
    '/assets/images/visa-heroes/jordan.jpg',
    'Cross-checked against Jordan Ministry of Labour work-permit fee-tier guidance and secondary expatriate-employment sourcing, triangulated against sources not directly fetchable this session', 'https://www.jordanpass.jo/', '2026-09-11'
);
SET @jo4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jo4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo4, 'Core Documents', 'Required from every applicant.', 1);
SET @jo4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@jo4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@jo4s1, 'Approved Work Permit', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @jo4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@jo4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@jo4s2, 'Medical Fitness Certificate', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(73, 4, NULL, 'JOD', 'Tiered by Nationality Category (Reported JOD 300/180/120/60)', 'Employer-paid; the exact tier for Indian nationals was not clearly isolated this session — contact us or the Ministry of Labour to confirm which tier applies.', '2026-09-01', NOW(), 'https://www.jordanpass.jo/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who pays the work permit fee in Jordan?', 'The employer pays — fees are tiered by nationality category (a reported JOD 300/180/120/60 structure), not a single flat rate.', 73, 4, 7304, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    73, 5, 'JOR-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives resident in Jordan.',
    'Indian nationals with family members residing in Jordan, requiring a standard visa via the Embassy with a family invitation letter and proof of relationship.',
    'Single or multiple entry, typically up to 30 days per visit',
    'Apply via the Embassy of Jordan with a family invitation letter and relationship proof',
    1,
    'Standard multi-week processing; note the current Level 3 regional travel advisory (Feb 2026, US-Iran tensions) when planning travel',
    'Embassy of Jordan, New Delhi',
    'Obtain an invitation letter from your relative in Jordan\nGather documents proving the family relationship\nSubmit the visa application at the Embassy with supporting documents',
    '/assets/images/visa-heroes/jordan.jpg',
    'Cross-checked against Embassy of Jordan visa guidance, triangulated against secondary sourcing not directly fetchable this session', 'https://www.jordanpass.jo/', '2026-09-11'
);
SET @jo5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jo5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo5, 'Core Documents', 'Required from every applicant.', 1);
SET @jo5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@jo5s1, 'Invitation Letter from Relative in Jordan', NULL, 'original', 1, 0, 1, 2),
(@jo5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @jo5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(73, 5, NULL, 'JOD', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.jordanpass.jo/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What proof of relationship is accepted for a Family Visit visa to Jordan?', 'Birth certificates, marriage certificates, or other official documents establishing the relationship, along with an invitation letter from your relative in Jordan.', 73, 5, 7305, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    73, 6, 'JOR-TRANS-IN-06', '2026.09', 'published',
    'Passing through Jordan en route to a third country, most relevant at Queen Alia International Airport.',
    'Indian nationals with a confirmed onward connection; airside transit without leaving the airport generally does not require a visa, while those leaving the airport need a standard visa.',
    'Short stay, typically same-day for airside transit',
    'No visa needed for airside transit; standard visa applies if leaving the airport',
    0,
    'Immediate; confirm with your airline whether your specific connection requires clearing immigration; note the current Level 3 regional travel advisory (Feb 2026)',
    'Embassy of Jordan, New Delhi (if a standard visa is needed)',
    'Confirm with your airline whether your connection is airside-only\nIf clearing immigration, apply for the standard visa in advance',
    '/assets/images/visa-heroes/jordan.jpg',
    'Cross-checked against Embassy of Jordan visa guidance and airport-transit secondary sourcing, triangulated against sources not directly fetchable this session', 'https://www.jordanpass.jo/', '2026-09-11'
);
SET @jo6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jo6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo6, 'Core Documents', 'Required if clearing immigration.', 1);
SET @jo6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@jo6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo6, 'Supporting Documents', 'Only relevant if leaving the airport.', 2);
SET @jo6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(73, 6, 0.00, 'INR', 'No Fee (Airside Transit)', 'No fee for airside-only transit not clearing immigration; standard visa fee applies if leaving the airport.', '2026-09-01', NOW(), 'https://www.jordanpass.jo/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa just to change planes in Amman?', 'If you stay airside and don''t clear immigration, generally no. If you leave the airport, you''ll need a standard visa.', 73, 6, 7306, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    73, 7, 'JOR-MED-IN-07', '2026.09', 'published',
    'Travel to Jordan for medical treatment.',
    'Indian nationals travelling for treatment, requiring a standard visa via the Embassy with hospital documentation as supporting evidence — no distinct Medical visa code was confirmed this session.',
    'Tied to the treatment period, extendable with hospital documentation',
    'Apply via the Embassy of Jordan with hospital appointment confirmation',
    1,
    'Standard multi-week processing; extension possible with hospital documentation for ongoing treatment',
    'Embassy of Jordan, New Delhi',
    'Obtain a hospital appointment/admission confirmation letter from the treating Jordanian hospital\nSubmit the visa application at the Embassy with medical records and the hospital letter',
    '/assets/images/visa-heroes/jordan.jpg',
    'Cross-checked against Embassy of Jordan visa guidance and secondary medical-tourism sourcing, triangulated against sources not directly fetchable this session', 'https://www.jordanpass.jo/', '2026-09-11'
);
SET @jo7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jo7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo7, 'Core Documents', 'Required from every applicant.', 1);
SET @jo7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@jo7s1, 'Hospital Appointment/Admission Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @jo7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@jo7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(73, 7, NULL, 'JOD', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.jordanpass.jo/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Medical Visa code for Jordan?', 'No distinct code was confirmed this session — medical travel is processed as a standard visa, supported by hospital documentation.', 73, 7, 7307, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Bundled with Sports/Training
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    73, 8, 'JOR-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, training programs, and official delegations in Jordan.',
    'Indian nationals attending a conference, supported by an invitation from the host organization. Jordan''s own taxonomy genuinely bundles Conference, Sports, Training, and Cultural-Exchange purposes under ONE umbrella visa category, rather than treating them as separate products — reflected honestly here.',
    'Single or multiple entry, typically up to 30 days',
    'Apply via the Embassy of Jordan with the event invitation letter, under the general Conference/Training/Cultural-Exchange umbrella category',
    1,
    'This is a genuinely bundled category in Jordan''s own system — Conference, Sports, Training, and Cultural-Exchange purposes share one visa product rather than each having a distinct code',
    'Embassy of Jordan, New Delhi',
    'Obtain an invitation letter from the conference/event organizer, stating the purpose clearly\nSubmit the visa application at the Embassy with supporting documents',
    '/assets/images/visa-heroes/jordan.jpg',
    'Cross-checked against Embassy of Jordan visa-category guidance confirming the Conference/Sports/Training/Cultural-Exchange bundling, triangulated against sources not directly fetchable this session', 'https://www.jordanpass.jo/', '2026-09-11'
);
SET @jo8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jo8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo8, 'Core Documents', 'Required from every applicant.', 1);
SET @jo8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@jo8s1, 'Conference/Event Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @jo8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo8s2, 'Forwarding Letter from Employer/Institution', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(73, 8, NULL, 'JOD', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.jordanpass.jo/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate visa for training programs vs. conferences in Jordan?', 'No — Jordan bundles Conference, Sports, Training, and Cultural-Exchange purposes under one umbrella visa category rather than treating them as separate products.', 73, 8, 7308, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Not Sourced, Requires Confirmation
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    73, 9, 'JOR-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Jordan.',
    'Could NOT be sourced at all this session — Jordan''s taxonomy is known to bundle Sports with Conference/Training/Cultural-Exchange under one umbrella category (see the Conference visa entry), but specific Sports-visa details were not found and require primary-source confirmation.',
    'Not confirmed this session',
    'Likely processed under the same Conference/Training/Cultural-Exchange umbrella category — confirm directly with the Embassy of Jordan',
    1,
    'REQUIRES PRIMARY-SOURCE CONFIRMATION — this category could not be sourced at all this session; do not rely on this content without independent verification',
    'Embassy of Jordan, New Delhi',
    'Confirm current Sports-visa requirements directly with the Embassy of Jordan before travel\nCarry federation/tournament accreditation as supporting evidence regardless',
    '/assets/images/visa-heroes/jordan.jpg',
    'COULD NOT BE SOURCED this session — explicitly marked as requiring primary-source confirmation rather than guessed. Recommend direct confirmation with the Embassy of Jordan', 'https://www.jordanpass.jo/', '2026-09-11'
);
SET @jo9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jo9, '2026.09', 'Initial published checklist — flagged as requiring primary-source confirmation.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo9, 'Core Documents (Provisional)', 'Not sourced this session; confirm before relying on this list.', 1);
SET @jo9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@jo9s1, 'Sports Federation/Tournament Accreditation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo9, 'Supporting Documents', 'Not sourced this session.', 2);
SET @jo9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(73, 9, NULL, 'JOD', 'Requires Primary-Source Confirmation', 'Could not be sourced at all this session — do not rely on a fee figure until confirmed with the Embassy of Jordan.', '2026-09-01', NOW(), 'https://www.jordanpass.jo/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Sports category confirmed for Jordan?', 'No — this category could not be sourced at all this session and explicitly requires primary-source confirmation. It is likely bundled with Conference/Training/Cultural-Exchange under one umbrella category, but please confirm directly with the Embassy of Jordan.', 73, 9, 7309, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    73, 10, 'JOR-DEP-IN-10', '2026.09', 'published',
    'Spouse/children accompanying an Indian Work or Student visa holder in Jordan.',
    'Family members of an Indian national already working or studying in Jordan; processed via the Embassy alongside proof of relationship and the principal''s visa/permit copy.',
    'Tied to the principal visa holder''s permit validity',
    'Apply via the Embassy of Jordan alongside or after the principal applicant, with relationship proof',
    1,
    'Standard multi-week processing; fee not consistently confirmed this session',
    'Embassy of Jordan, New Delhi',
    'Confirm the principal applicant''s Work or Student visa is approved or in process\nGather documents proving the family relationship\nSubmit the dependent visa application with relationship proof and the principal''s visa/permit copy',
    '/assets/images/visa-heroes/jordan.jpg',
    'Cross-checked against Embassy of Jordan Dependent visa guidance and secondary expatriate-family sourcing, triangulated against sources not directly fetchable this session', 'https://www.jordanpass.jo/', '2026-09-11'
);
SET @jo10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jo10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo10, 'Core Documents', 'Required from every applicant.', 1);
SET @jo10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@jo10s1, 'Proof of Relationship to Principal Visa Holder', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jo10, 'Supporting Documents', 'Evidence tied to the principal applicant''s visa.', 2);
SET @jo10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jo10s2, 'Principal Applicant''s Visa/Work Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@jo10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(73, 10, NULL, 'JOD', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.jordanpass.jo/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my family accompany me on a Work or Student visa to Jordan?', 'Yes, as dependants — the application is filed alongside or after your own visa, with proof of relationship and a copy of your approved visa or work permit.', 73, 10, 7310, 1);
