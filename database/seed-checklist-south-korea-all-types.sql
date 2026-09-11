-- South Korea Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search, same standard as every
-- other country built this session (see AUDIT.md). hero_image_url
-- points at the real Gyeongbokgung Palace/Seoul and South Korean flag
-- photo supplied by the client for this hero.
--
-- South Korea's real, distinctive facts:
--   - Uses a specific visa CODE system (C-3, D-2, E-7, F-3, etc.), not
--     generic category names — each checklist states its real Korean
--     visa code alongside the everyday purpose, since the code is what
--     actually governs eligibility and documents.
--   - K-ETA (Korea's electronic travel authorization) does NOT apply
--     to Indian passport holders — it only covers roughly 67
--     nationalities with existing visa-free/waiver access. India
--     always needs a full C-3-9 visa, never just K-ETA.
--   - Work uses the E-7 "Designated Activities" visa, covering 87
--     specific occupations, with real 2026 minimum salary thresholds
--     (effective 1 February 2026): KRW 31,120,000/year for E-7-1
--     (professional roles) vs KRW 25,890,000/year for E-7-2/E-7-3
--     (semi-/general-skilled) — genuinely different tiers, not one
--     flat figure.
--   - Student requires a tuberculosis test certificate SPECIFICALLY of
--     Indian applicants — a real, India-specific medical-clearance
--     requirement, not a generic rule applied to every nationality.
--   - Transit under the B-2 transfer-passenger exemption needs no
--     separate visa for layovers under 24 hours with a confirmed
--     onward ticket — resumed 30 April 2023 and still current.
--   - Dependent (F-3) had a genuine, dated 2025 policy tightening:
--     since 1 July 2025, Korea no longer accepts in-country F-3
--     conversions — dependants must apply at a Korean consulate/KVAC
--     abroad (i.e. in India) before travelling, and longer-stay F-3
--     applications now require proof of the principal holder's income
--     scaled to household size.
--   - Sports genuinely splits by payment/contract status: professional
--     athletes joining a Korean club use E-6-3 (with an executed
--     player contract and federation registration); non-remunerated
--     short-term competitors typically use C-3-1; a paid short
--     engagement may instead need C-4-5.
--
-- country_id 93 = South Korea. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — C-3-9 Short-Term General
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    93, 1, 'KOR-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and short personal visits to South Korea.',
    'India is not among the ~67 nationalities eligible for K-ETA (Korea''s electronic travel authorization) — Indian passport holders always need a full C-3-9 Short-Term General visa, with mandatory in-person biometrics at a Korea Visa Application Center (KVAC) in India.',
    'Up to 90 days per entry, depending on the entry type granted',
    'In-person application via a Korea Visa Application Center (VFS Global or BLS International) in India',
    1,
    'Standard processing typically runs around 10 working days',
    'Korea Visa Application Center (VFS Global/BLS International), India',
    'Initial consultation to confirm C-3-9 Tourist is correct\nGather documents against this checklist\nBook your appointment at a Korea Visa Application Center\nAttend in person for biometrics (fingerprints and photo, age 17+)\nSubmission of your application and documents\nDecision — visa sticker affixed to your passport once approved',
    '/assets/images/visa-heroes/south-korea.jpg',
    'Korean Ministry of Foreign Affairs and Korea Visa Application Center (India) guidance, cross-checked via independent visa-agency sourcing', 'https://www.mofa.go.kr/', '2026-09-11'
);
SET @kt1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kt1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt1, 'Core Documents', 'Every applicant needs these.', 1);
SET @kt1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt1s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kt1s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt1, 'Financial & Ties Documents', 'Evidence of funds and ties to India.', 2);
SET @kt1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt1s2, 'Bank Statements', NULL, 'copy', 1, 0, 1, 1),
(@kt1s2, 'Income Tax Returns', NULL, 'copy', 1, 0, 0, 2),
(@kt1s2, 'Employment Proof', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt1, 'Travel Documents', 'Evidence of your trip.', 3);
SET @kt1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt1s3, 'Itinerary & Hotel Booking', NULL, 'original', 1, 0, 1, 1),
(@kt1s3, 'Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(93, 1, 3600.00, 'INR', 'C-3-9 Single-Entry Visa Fee (Up to 90 Days)', 'Effective 1 August 2026: INR 3,600 single-entry up to 90 days, INR 5,400 single-entry over 90 days, INR 6,300 double-entry, INR 8,100 multiple-entry. Plus a separate KVAC service charge of INR 1,100-1,600. Group tours of 5+ travellers may qualify for a fee waiver through 30 June 2026.', '2026-08-01', NOW(), 'https://www.mofa.go.kr/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens use K-ETA instead of a visa?', 'No — K-ETA only covers around 67 nationalities with existing visa-free/waiver access. India is not among them, so a full C-3-9 visa is always required.', 93, 1, 1130, 1),
('Is there a fee waiver for group tours?', 'Yes — group tours of 5 or more travellers may qualify for a visa-fee waiver, extended through 30 June 2026.', 93, 1, 1131, 1),
('Is biometrics mandatory for a Korea tourist visa?', 'Yes — fingerprints and a photo are mandatory in person at a Korea Visa Application Center for applicants aged 17 and over.', 93, 1, 1132, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — C-3-4 Short-Term Business
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    93, 2, 'KOR-BUS-IN-02', '2026.09', 'published',
    'Short business visits — meetings, negotiations, and technical consultation — to South Korea.',
    'The C-3-4 Short-Term Business visa covers unpaid business activity — market research, contract negotiation, technical consultation — not employment or remuneration. The invitation letter must follow Korea''s specific "5W1H" detail standard (who, what, when, where, why, how).',
    'Up to 90 days per entry',
    'In-person application via a Korea Visa Application Center in India',
    1,
    'Standard processing typically runs around 10 working days',
    'Korea Visa Application Center (VFS Global/BLS International), India',
    'Initial consultation to confirm C-3-4 Business is correct\nObtain a "5W1H" invitation letter and business registration certificate from your Korean host\nGather documents against this checklist\nBook your appointment and attend biometrics\nSubmission of your application and documents\nDecision once processed',
    '/assets/images/visa-heroes/south-korea.jpg',
    'Korea Visa Application Center C-3-4 Business visa (corporate invitation) guidance', 'https://www.allvisakorea.com/en/post/c-3-4-visa-for-short-term-business-visa-corporate-invitation-inviting-foreign-talent-to-a-company', '2026-09-11'
);
SET @kt2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kt2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt2, 'Core Documents', 'Every applicant needs these.', 1);
SET @kt2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kt2s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt2, 'Business Invitation & Purpose', 'Evidence of who you are meeting and why.', 2);
SET @kt2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt2s2, 'Korean Host Invitation Letter ("5W1H" Format)', 'Who, what, when, where, why, and how — Korea''s specific invitation-detail standard.', 'original', 1, 0, 1, 1),
(@kt2s2, 'Host Company Business Registration Certificate', NULL, 'copy', 1, 0, 1, 2),
(@kt2s2, 'NOC/Authorization Letter from Indian Employer', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt2, 'Financial Documents', 'Evidence of funds.', 3);
SET @kt2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt2s3, 'Bank Statements', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(93, 2, 3600.00, 'INR', 'C-3-4 Single-Entry Visa Fee', 'Same tiered fee schedule as Tourist (C-3-9), plus the separate KVAC service charge.', '2026-08-01', NOW(), 'https://www.allvisakorea.com/en/post/c-3-4-visa-for-short-term-business-visa-corporate-invitation-inviting-foreign-talent-to-a-company', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the "5W1H" invitation standard?', 'Korea''s specific format requiring the invitation letter to detail who, what, when, where, why, and how — a real, distinctive documentation requirement.', 93, 2, 1133, 1),
('Can I be paid during a C-3-4 business visit?', 'No — it covers unpaid business activity like meetings and negotiations; employment/remuneration requires a work visa instead.', 93, 2, 1134, 1),
('Do I need my Indian employer''s authorization too?', 'Yes — an NOC/authorization letter from your Indian employer is required alongside the Korean host''s invitation.', 93, 2, 1135, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — D-2 (Degree) / D-4 (Language/Non-Degree)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    93, 3, 'KOR-STU-IN-03', '2026.09', 'published',
    'Full-time study at a South Korean institution — D-2 for degree programs, D-4 for language training or other non-degree study.',
    'Requires a Standard (Korean government-format) Admission Letter and a tuberculosis test certificate — specifically required of Indian applicants as a real, India-specific medical-clearance rule, not a generic requirement applied to every nationality.',
    'Duration of your program (D-2/D-4 status)',
    'In-person application via a Korea Visa Application Center in India',
    1,
    'A commonly cited funds benchmark is around KRW 20,000,000 (~USD 15,000), though it varies by university/mission',
    'Korea Visa Application Center (VFS Global/BLS International), India',
    'Secure admission and receive your Standard Admission Letter\nComplete a tuberculosis test (required specifically of Indian applicants)\nArrange your proof of funds\nGather documents against this checklist\nSubmit your application and attend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/south-korea.jpg',
    'Korea Visa Application Center D-2/D-4 Student visa guidance', 'https://studyinsouthkorea.in/uncategorized/south-korea-student-visa-complete-2026-guide-for-indian-students/', '2026-09-11'
);
SET @kt3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kt3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt3, 'Core Documents', 'Every applicant needs these.', 1);
SET @kt3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt3s1, 'Valid Passport', 'Valid for at least 6 months.', 'original', 1, 0, 1, 1),
(@kt3s1, 'Standard Admission Letter', 'Korean government-format, from your institution.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt3, 'Medical Documents', 'Mandatory for Indian applicants.', 2);
SET @kt3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt3s2, 'Tuberculosis Test Certificate', 'A real, India-specific requirement.', 'original', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt3, 'Financial Documents', 'Evidence you can fund your studies.', 3);
SET @kt3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt3s3, 'Proof of Funds', 'Commonly benchmarked around KRW 20,000,000.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(93, 3, 80.00, 'USD', 'Student Visa Fee (Single-Entry)', 'Approximately USD 80 single-entry, USD 120 multiple-entry (roughly INR 5,000-7,500 on the local fee schedule).', '2026-09-01', NOW(), 'https://studyinsouthkorea.in/uncategorized/south-korea-student-visa-complete-2026-guide-for-indian-students/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Why is a TB test specifically required for Indian applicants?', 'It is a real, India-specific medical-clearance requirement for the Student visa, not a generic rule applied to every nationality.', 93, 3, 1136, 1),
('What is the difference between D-2 and D-4?', 'D-2 is for degree programs at a Korean university; D-4 is for language training or other non-degree study.', 93, 3, 1137, 1),
('Did anything change for technical/vocational students in 2026?', 'Yes — Korea eased rules for 16 designated technical/vocational programs, expanding permitted part-time work hours and reducing bank-proof requirements for students in those programs.', 93, 3, 1138, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — E-7 Designated Activities
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    93, 4, 'KOR-WORK-IN-04', '2026.09', 'published',
    'Skilled employment in South Korea under the E-7 Designated Activities visa, covering 87 specific occupations.',
    'Requires a Korean employer sponsor for a job on the E-7 occupation list (often with a labour-market test showing no qualified local candidate available), plus a relevant degree and 1-5 years'' experience. Real 2026 minimum salary thresholds (effective 1 February 2026) genuinely differ by tier: KRW 31,120,000/year for E-7-1 (professional roles) vs KRW 25,890,000/year for E-7-2/E-7-3 (semi-/general-skilled).',
    'Tied to your employment contract, renewable',
    'Employer obtains CVI (Confirmation of Visa Issuance) approval in Korea; employee then applies for visa stamping in India',
    1,
    'Total processing (CVI approval plus visa stamping) typically runs 4-8 weeks',
    'Korea Visa Application Center (VFS Global/BLS International), India',
    'Employer confirms your role is on the E-7 occupation list\nEmployer applies for CVI (Confirmation of Visa Issuance) approval in Korea (2-6 weeks)\nGather documents against this checklist\nApply for visa stamping at a Korea Visa Application Center in India\nAttend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/south-korea.jpg',
    'Korean immigration E-7 Designated Activities visa guidance and 2026 salary thresholds', 'https://www.thekoreanlawblog.com/2026/03/e-7-visa-korea.html', '2026-09-11'
);
SET @kt4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kt4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt4, 'Core Documents', 'Every applicant needs these.', 1);
SET @kt4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kt4s1, 'CVI Approval Reference', 'Confirmation of Visa Issuance, obtained by your employer in Korea.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt4, 'Employer Sponsorship Documents', 'Evidence of your job offer.', 2);
SET @kt4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt4s2, 'Employment Contract', 'Confirming your salary meets the applicable E-7-1/2/3 tier threshold.', 'copy', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt4, 'Qualification Documents', 'Evidence you meet the role''s requirements.', 3);
SET @kt4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt4s3, 'Degree Certificate', NULL, 'copy', 1, 0, 0, 1),
(@kt4s3, 'Work Experience Evidence', '1-5 years, per your specific E-7 occupation code.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(93, 4, 60.00, 'USD', 'E-7 Visa Fee (Indicative)', 'No standardized public E-7-specific fee was confirmed this session; indicative general visa-portal bands run roughly USD 40-90 by entry type — confirm the exact figure with the embassy/KVAC.', '2026-09-01', NOW(), 'https://www.thekoreanlawblog.com/2026/03/e-7-visa-korea.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What are the 2026 E-7 salary thresholds?', 'Effective 1 February 2026: KRW 31,120,000/year for E-7-1 (professional roles) and KRW 25,890,000/year for E-7-2/E-7-3 (semi-/general-skilled roles) — genuinely different tiers, not one flat figure.', 93, 4, 1139, 1),
('How many occupations does E-7 cover?', '87 designated occupations, spanning fields like software/AI, semiconductors, nursing, and engineering.', 93, 4, 1140, 1),
('How long does the full E-7 process take?', 'Typically 4-8 weeks total: CVI (Confirmation of Visa Issuance) approval in Korea takes 2-6 weeks, then visa stamping in India takes around 10 working days.', 93, 4, 1141, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — C-3-1 Short-Term General
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    93, 5, 'KOR-FAM-IN-05', '2026.09', 'published',
    'Visiting family members legally resident in South Korea.',
    'Uses the C-3-1 Short-Term General visa code — the same catch-all subtype also used for conferences/training, distinct from the longer-stay F-1 family-visit category which is not the standard route for short Indian family visits.',
    'Up to 90 days per entry',
    'In-person application via a Korea Visa Application Center in India',
    1,
    'Standard processing typically runs around 10 working days',
    'Korea Visa Application Center (VFS Global/BLS International), India',
    'Initial consultation to confirm C-3-1 Family Visit is correct\nObtain proof of your relative''s legal residency (ARC/resident registration copy) and an invitation letter\nGather documents against this checklist\nSubmit your application and attend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/south-korea.jpg',
    'Korea Visa Application Center C-3-1 Short-Term General (family visit) guidance', 'https://kor.blsinternational.com/assets/pdf/Visiting-visa.pdf', '2026-09-11'
);
SET @kt5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kt5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt5, 'Core Documents', 'Every applicant needs these.', 1);
SET @kt5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kt5s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt5, 'Host Documents', 'Evidence of your Korean relative''s legal residency.', 2);
SET @kt5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt5s2, 'Invitation Letter from Korean Relative', NULL, 'original', 1, 0, 1, 1),
(@kt5s2, 'Relative''s ARC/Resident Registration Copy', NULL, 'copy', 1, 0, 1, 2),
(@kt5s2, 'Relative''s Income/Bank Proof', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt5, 'Financial Documents', 'Your own funds evidence.', 3);
SET @kt5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt5s3, 'Bank Statements & Employment Proof', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(93, 5, 3600.00, 'INR', 'C-3-1 Single-Entry Visa Fee', 'Same tiered fee schedule as Tourist (C-3-9), plus the separate KVAC service charge.', '2026-08-01', NOW(), 'https://kor.blsinternational.com/assets/pdf/Visiting-visa.pdf', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct "Family Visit Visa" code for Korea?', 'No — short family visits use the C-3-1 Short-Term General code, the same catch-all subtype also used for conferences and training.', 93, 5, 1142, 1),
('What proves my relative''s legal residency?', 'A copy of their ARC (Alien Registration Card) or resident registration document.', 93, 5, 1143, 1),
('Is F-1 the standard route for short family visits?', 'No — F-1 is a longer-stay family category; C-3-1 is the standard route for short Indian family visits.', 93, 5, 1144, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — B-2 Transfer-Passenger Exemption
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    93, 6, 'KOR-TRANS-IN-06', '2026.09', 'published',
    'Passing through Incheon Airport en route to a third country.',
    'No separate transit visa is generally required for Indians connecting through Incheon under the B-2 transfer-passenger exemption (resumed 30 April 2023), provided the layover stays under 24 hours within the transit area, with a confirmed onward ticket.',
    'Under 24 hours, within the transit area',
    'No application needed for eligible transfers; full C-3 visa required if leaving the transit area',
    0,
    'Eligibility for Incheon''s free Stopover Tourism Programme (for 24+ hour layovers) should be verified directly with the airline/airport',
    'Not applicable for eligible transfers; Korea Visa Application Center if a full C-3 visa is required instead',
    'Confirm your layover stays under 24 hours within the transit area\nEnsure you hold a confirmed onward ticket\nIf leaving the transit area (e.g. for a longer layover), apply for a full C-3 visa instead\nProceed through Incheon under the B-2 transfer-passenger exemption if eligible',
    '/assets/images/visa-heroes/south-korea.jpg',
    'Korean Ministry of Foreign Affairs B-2 transfer-passenger visa-free exemption guidance', 'https://www.mofa.go.kr/be-en/brd/m_7440/view.do?seq=748988', '2026-09-11'
);
SET @kt6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kt6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt6, 'Core Documents', 'For eligible under-24-hour transfers.', 1);
SET @kt6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kt6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt6, 'If Leaving the Transit Area', 'Fall back to a full C-3 visa.', 2);
SET @kt6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt6s2, 'Full C-3 Visa Application', 'Required if your layover exceeds 24 hours or you leave the transit area.', 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(93, 6, 0.00, 'INR', 'No Fee for Eligible Transfers', 'No visa or fee is needed for a qualifying under-24-hour transfer through Incheon''s transit area. A standard C-3 visa fee applies only if you must leave the transit area.', '2026-09-01', NOW(), 'https://www.mofa.go.kr/be-en/brd/m_7440/view.do?seq=748988', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Korea?', 'Generally no, for layovers under 24 hours within Incheon''s transit area, under the B-2 transfer-passenger exemption resumed 30 April 2023.', 93, 6, 1145, 1),
('What if my layover is longer than 24 hours?', 'You would need a full C-3 visa if leaving the transit area — check Incheon''s Stopover Tourism Programme eligibility for India with your airline first.', 93, 6, 1146, 1),
('Do I need biometrics for an eligible transfer?', 'No — biometrics are not needed if you remain within the transit area under the exemption.', 93, 6, 1147, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — C-3-3 Medical Tourism
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    93, 7, 'KOR-MED-IN-07', '2026.09', 'published',
    'Travelling to South Korea for medical treatment, under the dedicated C-3-3 Medical Tourism visa.',
    'Requires an official invitation letter from a Korean medical institution or Ministry-accredited medical-tourism facilitator, detailing patient details, treatment type/dates, on hospital letterhead/seal with a facility registration number.',
    'Up to 90 days per entry',
    'In-person application via a Korea Visa Application Center in India',
    1,
    'Processing typically runs 5-10 working days',
    'Korea Visa Application Center (VFS Global/BLS International), India',
    'Obtain an official invitation letter from the Korean medical institution or accredited facilitator\nGather documents against this checklist\nSubmit your application and attend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/south-korea.jpg',
    'Korea Visa Application Center C-3-3 Medical Tourism visa guidance', 'https://www.allvisakorea.com/en/post/c-3-3-medical-tourism-visa-eligibility-and-required-documents', '2026-09-11'
);
SET @kt7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kt7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt7, 'Core Documents', 'Every applicant needs these.', 1);
SET @kt7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kt7s1, 'Official Medical Institution Invitation Letter', 'On hospital letterhead/seal, with facility registration number.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt7, 'Medical Documents', 'Evidence of your treatment plan.', 2);
SET @kt7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt7s2, 'Treatment Type and Dates', NULL, 'copy', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt7, 'Financial Documents', 'Evidence you can pay for treatment.', 3);
SET @kt7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt7s3, 'Bank Statements', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(93, 7, NULL, 'INR', 'Confirmed After Assessment', 'No standardized government treatment-cost figure exists for Indian patients — cost estimates come from the hospital itself as part of the invitation package; the visa fee tracks the general C-3 schedule.', '2026-09-01', NOW(), 'https://www.allvisakorea.com/en/post/c-3-3-medical-tourism-visa-eligibility-and-required-documents', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does South Korea have a dedicated medical tourism visa?', 'Yes — C-3-3, requiring an official invitation from a Korean medical institution or Ministry-accredited facilitator.', 93, 7, 1148, 1),
('What must the invitation letter include?', 'Patient details, treatment type and dates, on hospital letterhead/seal, with the facility''s registration number.', 93, 7, 1149, 1),
('Who provides the treatment cost estimate?', 'The hospital itself, as part of the invitation package — no standardized government figure exists for Indian patients.', 93, 7, 1150, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — C-3-1 Short-Term General
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    93, 8, 'KOR-CONF-IN-08', '2026.09', 'published',
    'Attending a conference or seminar in South Korea, using the same C-3-1 code as short family visits and training.',
    'Requires an invitation letter from the event organizer — some missions require an original physical letter, and a standard "C-3-1 Invitation Form" template is often provided. Visa is valid for entry within 3 months of issue, and no remuneration is permitted.',
    'Up to 90 days per entry',
    'In-person application via a Korea Visa Application Center in India',
    1,
    'Standard processing typically runs around 10 working days',
    'Korea Visa Application Center (VFS Global/BLS International), India',
    'Obtain an invitation letter from the conference organizer (original physical letter may be required)\nGather documents against this checklist\nSubmit your application and attend biometrics\nDecision once processed — enter within 3 months of visa issue',
    '/assets/images/visa-heroes/south-korea.jpg',
    'Korean MOFA C-3-1 Conference/Event visa guidance', 'https://www.mofa.go.kr/us-seattle-en/brd/m_23042/view.do?seq=49', '2026-09-11'
);
SET @kt8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kt8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt8, 'Core Documents', 'Every applicant needs these.', 1);
SET @kt8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kt8s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt8, 'Conference Documents', 'Evidence of the event and your role.', 2);
SET @kt8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt8s2, 'Conference Invitation Letter', 'Original physical letter may be required; C-3-1 Invitation Form template often used.', 'original', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt8, 'Financial Documents', 'Evidence of funds.', 3);
SET @kt8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt8s3, 'Bank Statements', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(93, 8, 3600.00, 'INR', 'C-3-1 Single-Entry Visa Fee', 'Same tiered fee schedule as Tourist/Family Visit (C-3-9/C-3-1), plus the separate KVAC service charge.', '2026-08-01', NOW(), 'https://www.mofa.go.kr/us-seattle-en/brd/m_23042/view.do?seq=49', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the conference visa share a code with Family Visit?', 'Yes — both use C-3-1, Korea''s catch-all Short-Term General code, distinguished by which invitation/documents you submit.', 93, 8, 1151, 1),
('How soon must I enter Korea after my visa is issued?', 'Within 3 months of issue.', 93, 8, 1152, 1),
('Can I be paid for speaking at the conference?', 'No — no remuneration is permitted under this visa category.', 93, 8, 1153, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — E-6-3 / C-3-1 / C-4-5 (Payment-Dependent)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    93, 9, 'KOR-SPORT-IN-09', '2026.09', 'published',
    'Competing or coaching in South Korea, with the visa code depending on your payment/contract status.',
    'Genuinely splits by status: contracted professional athletes joining a Korean club use E-6-3 (Arts/Entertainment-Athletics), requiring an executed player contract, federation registration, and medical certificate. Non-remunerated short-term competitors typically use C-3-1; a paid short engagement may instead need C-4-5 (short-term work).',
    'E-6-3: tied to the player contract. C-3-1: up to 90 days. C-4-5: short-term, per engagement',
    'In-person application via a Korea Visa Application Center in India, category depends on your status',
    1,
    'Confirm your payment/contract status first — it determines which visa code applies',
    'Korea Visa Application Center (VFS Global/BLS International), India',
    'Confirm whether you are a contracted professional, non-remunerated competitor, or paid short-term participant\nGather documents against this checklist for the applicable category\nSubmit your application and attend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/south-korea.jpg',
    'Korea Visa Application Center E-6 Arts & Entertainment visa and C-3/C-4 short-term visa guidance', 'https://mrvisakorea.com/en/visa-guide/e-6-arts-entertainment-visa-korea/', '2026-09-11'
);
SET @kt9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kt9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt9, 'Core Documents', 'Every applicant needs these.', 1);
SET @kt9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kt9s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt9, 'Contracted Professional Documents (E-6-3)', 'For athletes joining a Korean club.', 2);
SET @kt9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt9s2, 'Executed Player Contract', NULL, 'copy', 0, 1, 1, 1),
(@kt9s2, 'Federation Registration', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt9, 'Non-Remunerated Competitor Documents (C-3-1)', 'For short-term, unpaid competitors.', 3);
SET @kt9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt9s3, 'Event Invitation', NULL, 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(93, 9, NULL, 'INR', 'Confirmed After Assessment', 'Fee depends on which category applies (E-6-3 contracted professional, C-3-1 non-remunerated, or C-4-5 paid short-term) — confirmed once your status is assessed.', '2026-09-01', NOW(), 'https://mrvisakorea.com/en/visa-guide/e-6-arts-entertainment-visa-korea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Which visa do professional athletes use for Korea?', 'E-6-3 (Arts/Entertainment-Athletics), requiring an executed player contract with a Korean club and federation registration.', 93, 9, 1154, 1),
('What about unpaid, short-term competitors?', 'They typically use C-3-1, the same Short-Term General code used for family visits and conferences.', 93, 9, 1155, 1),
('Is there a category for paid short engagements?', 'Yes — C-4-5 (short-term work) may apply for a paid short-term engagement that does not rise to a full player contract.', 93, 9, 1156, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — F-3 Accompanying Family
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    93, 10, 'KOR-DEP-IN-10', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a D-2 (Student) or E-series (Work) visa in South Korea.',
    'F-3 grants no independent work rights and must not be confused with F-6 (for spouses of Korean nationals). Since 1 July 2025, Korea no longer accepts in-country F-3 conversions — dependants must apply at a Korean consulate/KVAC abroad (i.e. in India) before travelling, and longer-stay F-3 applications now require proof of the principal''s income scaled to household size.',
    'Matches the validity of the principal visa holder''s status',
    'In-person application via a Korea Visa Application Center in India — in-country conversion no longer accepted since 1 July 2025',
    1,
    'Apply before travelling — the in-country conversion route was discontinued on 1 July 2025',
    'Korea Visa Application Center (VFS Global/BLS International), India',
    'Confirm the principal D-2/E-series visa holder''s status\nGather documents against this checklist, including apostilled relationship proof\nSubmit your F-3 application at a Korea Visa Application Center in India before travelling\nAttend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/south-korea.jpg',
    'Korean immigration F-3 Accompanying Family visa guidance and July 2025 in-country conversion policy change', 'https://seoulstart.com/guides/f-3-visa-guide', '2026-09-11'
);
SET @kt10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kt10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt10, 'Core Documents', 'Every applicant needs these.', 1);
SET @kt10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kt10s1, 'Principal Holder''s Visa Status Proof', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt10, 'Relationship Documents', 'Apostilled, per Korean immigration rules.', 2);
SET @kt10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt10s2, 'Apostilled Marriage Certificate', 'For a spouse applicant.', 'copy', 0, 1, 1, 1),
(@kt10s2, 'Apostilled Birth Certificate', 'For a child applicant.', 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kt10, 'Financial Documents', 'Evidence of the principal''s income.', 3);
SET @kt10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kt10s3, 'Principal Holder''s Income Evidence', 'Scaled to household size, for longer-stay F-3 applications since 1 July 2025.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(93, 10, 3600.00, 'INR', 'F-3 Visa Fee (Indicative)', 'Tracks the general C-3 single-entry fee schedule as a baseline reference; confirm the exact current F-3 figure with the KVAC.', '2026-08-01', NOW(), 'https://seoulstart.com/guides/f-3-visa-guide', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I convert to F-3 status while already in Korea?', 'No — since 1 July 2025, Korea no longer accepts in-country F-3 conversions. Dependants must apply at a Korean consulate/KVAC abroad, i.e. in India, before travelling.', 93, 10, 1157, 1),
('Is F-3 the same as F-6?', 'No — F-3 is for accompanying family of D-2/E-series holders, while F-6 is specifically for spouses of Korean nationals; the two are not interchangeable.', 93, 10, 1158, 1),
('Can I work on an F-3 visa?', 'No — F-3 grants no independent work rights.', 93, 10, 1159, 1);
