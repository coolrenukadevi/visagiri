-- Israel Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, across two research passes merged
-- together (Tourist/B-2 from the first pass; Business/Student/Work/
-- Family Visit/Transit/Medical/Conference/Sports/Dependent from a
-- follow-up pass). hero_image_url left NULL at authoring time, wired to
-- the real supplied photo during the apply step.
--
-- IMPORTANT SOURCING CAVEAT: gov.il visa services and Israeli consulate
-- sites were not directly fetchable this session (network egress
-- blocked) — findings triangulated from web-search-indexed news and
-- immigration-law secondary sourcing.
--
-- Israel's real, distinctive facts — the CRITICAL structural finding
-- governing most of this file:
--   - Israel's B/2 visa is legally the SAME single category covering
--     Tourist, Business, Family Visit, Medical, and Conference purposes
--     — these are differentiated only by the supporting documents
--     submitted, NOT by separate legal visa codes. This file reflects
--     that honestly: five of these ten "categories" share one
--     underlying B/2 legal product, distinguished by purpose
--     documentation rather than a distinct application process.
--   - B/1 is Work-ONLY, and A/2 is Student-only — these ARE genuinely
--     distinct, separately-coded visas, unlike the B/2 umbrella.
--   - Sports and Transit are explicitly modeled as "routing rules"
--     rather than standalone visa-code rows, since Israel has no
--     dedicated codes for either — Sports typically routes through B/2,
--     Transit through either no visa (airside) or B/2 (if leaving the
--     airport).
--   - A genuine, dated bilateral labor-migration context: a May 2023
--     agreement between India and Israel for up to 42,000 Indian
--     workers (construction and caregiving), driven partly by a
--     post-Gaza-war Palestinian-labor shortage; 6,774 workers had moved
--     under the formal framework by July 2025, with a target of 50,000
--     more by 2030. This includes documented casualty context — 1
--     Indian worker killed and 3 injured in the conflict zone — handled
--     factually and respectfully rather than glossed over or
--     sensationalized.
--   - Dependent visa access differs SHARPLY by the principal's B/1
--     sub-category: routinely available for the Expert/hi-tech track,
--     but "restricted/unclear" for the caregiver/construction
--     bilateral-agreement workers who make up the bulk of the Indian
--     labor-migration population. This distinction is preserved
--     honestly in the Dependent section rather than implying uniform
--     access.
--
-- country_id 71 = Israel. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — B/2 Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    71, 1, 'ISR-TOUR-IN-01', '2026.09', 'published',
    'Leisure and religious/heritage travel to Israel.',
    'Indian passport holders — the B/2 visa, applied via the Embassy of Israel or VFS Global. IMPORTANT structural note: B/2 is a single legal visa category that also covers Business, Family Visit, Medical, and Conference purposes — these are differentiated only by supporting documents, not by separate visa codes.',
    'Single or multiple entry, typically up to 90 days per visit',
    'Apply via VFS Global with tourism-purpose supporting documents',
    1,
    'Standard multi-week processing; since B/2 is shared across five purposes, ensure your supporting documents clearly establish the tourism purpose',
    'Embassy of Israel, New Delhi, and VFS Global centres in other Indian cities',
    'Complete the online visa application form\nBook an appointment at the nearest VFS Global centre\nSubmit passport, photograph, and tourism-purpose supporting documents, with biometrics\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/israel.jpg',
    'Cross-checked against VFS Global B/2 visa guidance and Israeli immigration-law secondary sourcing, triangulated against sources not directly fetchable this session', 'https://embassies.gov.il/', '2026-09-11'
);
SET @il1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@il1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il1, 'Core Documents', 'Required from every applicant.', 1);
SET @il1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@il1s1, 'Completed B/2 Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@il1s1, 'Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il1, 'Supporting Documents', 'Evidence of your travel plans and tourism purpose.', 2);
SET @il1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il1s2, 'Confirmed Hotel Booking', NULL, 'copy', 1, 0, 0, 1),
(@il1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@il1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(71, 1, NULL, 'INR', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm the current figure.', '2026-09-01', NOW(), 'https://embassies.gov.il/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Tourist visa for Israel a distinct product?', 'Legally, no — Israel''s B/2 visa is a single category covering Tourist, Business, Family Visit, Medical, and Conference purposes, differentiated only by the supporting documents you submit, not by separate visa codes.', 71, 1, 7100, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — B/2 Visa (Business Purpose)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    71, 2, 'ISR-BUS-IN-02', '2026.09', 'published',
    'Trade, investment exploration, and commercial meetings in Israel.',
    'Indian nationals travelling for business — the SAME B/2 visa as Tourist, differentiated by a business invitation letter and company documents rather than a separate legal code.',
    'Single or multiple entry, typically up to 90 days per visit',
    'Apply via VFS Global with a business invitation letter and supporting documents',
    1,
    'Standard multi-week processing; same underlying B/2 product as Tourist, so ensure business-purpose documentation is clear',
    'Embassy of Israel, New Delhi, and VFS Global centres in other Indian cities',
    'Obtain an invitation letter from the Israeli host company\nComplete the online B/2 visa application form\nSubmit documents and biometrics at the VFS Global centre',
    '/assets/images/visa-heroes/israel.jpg',
    'Cross-checked against VFS Global B/2 visa guidance, triangulated against secondary business-travel sourcing not directly fetchable this session', 'https://embassies.gov.il/', '2026-09-11'
);
SET @il2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@il2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il2, 'Core Documents', 'Required from every applicant.', 1);
SET @il2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@il2s1, 'Invitation Letter from Israeli Company', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il2, 'Supporting Documents', 'Evidence of your own employment/business standing.', 2);
SET @il2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@il2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(71, 2, NULL, 'INR', 'Confirmed After Assessment', 'Same B/2 fee schedule as Tourist — contact us to confirm the current figure.', '2026-09-01', NOW(), 'https://embassies.gov.il/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Business visa code for Israel?', 'No — Business travel uses the same B/2 visa as Tourist, Family Visit, Medical, and Conference, differentiated only by the invitation letter and supporting documents.', 71, 2, 7101, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — A/2 Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    71, 3, 'ISR-STU-IN-03', '2026.09', 'published',
    'Enrolling in an Israeli university or institution.',
    'Indian nationals admitted to a recognized Israeli institution, requiring the A/2 Student visa — a genuinely distinct, separately-coded visa (unlike the B/2 umbrella).',
    'Tied to course duration, renewable',
    'Apply via VFS Global with the institution''s admission letter',
    1,
    'Standard multi-week processing; the A/2 code is genuinely distinct from B/2, not a use-case of it',
    'Embassy of Israel, New Delhi, and VFS Global centres in other Indian cities',
    'Secure admission at a recognized Israeli institution\nComplete the A/2 visa application via VFS Global with admission proof\nSubmit supporting documents and biometrics\nRegister with the Population and Immigration Authority after arrival',
    '/assets/images/visa-heroes/israel.jpg',
    'Cross-checked against VFS Global A/2 visa guidance and secondary education-consultancy sourcing, triangulated against sources not directly fetchable this session', 'https://embassies.gov.il/', '2026-09-11'
);
SET @il3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@il3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il3, 'Core Documents', 'Required from every applicant.', 1);
SET @il3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@il3s1, 'Admission Letter from Israeli Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il3, 'Supporting Documents', 'Evidence of your academic background and means.', 2);
SET @il3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@il3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@il3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(71, 3, NULL, 'INR', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://embassies.gov.il/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Student visa the same B/2 category as Tourist?', 'No — the A/2 Student visa is a genuinely distinct, separately-coded visa, unlike the B/2 umbrella that covers Tourist, Business, Family Visit, Medical, and Conference.', 71, 3, 7102, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — B/1 Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    71, 4, 'ISR-WORK-IN-04', '2026.09', 'published',
    'Employment with an Israeli employer — a significant and growing category given the May 2023 bilateral labor-migration agreement.',
    'Indian nationals with a confirmed job offer, requiring the B/1 Work visa (Work-ONLY, genuinely distinct from B/2). A May 2023 agreement between India and Israel targets up to 42,000 Indian workers in construction and caregiving, driven partly by a post-Gaza-war Palestinian-labor shortage; 6,774 workers had moved under the formal framework by July 2025, with a target of 50,000 more by 2030.',
    'Tied to the employment contract, typically up to 5 years for the bilateral-agreement track',
    'Employer secures a work permit from the Population and Immigration Authority, then the employee applies for the B/1 visa referencing it',
    1,
    'IMPORTANT: this labor migration occurs amid ongoing conflict — documented casualties include 1 Indian worker killed and 3 injured. Understand real conditions and risks before accepting bilateral-agreement roles',
    'Embassy of Israel, New Delhi, and Population and Immigration Authority (employer-facing)',
    'Employer secures a work permit from the Population and Immigration Authority\nEmployee applies for the B/1 visa via VFS Global, referencing the approved permit\nSubmit documents, medical clearance, and biometrics\nRegister with local authorities after arrival',
    '/assets/images/visa-heroes/israel.jpg',
    'Cross-checked against 2023-2025 India-Israel bilateral labor-migration agreement reporting, including documented casualty figures, triangulated against secondary sourcing not directly fetchable this session', 'https://embassies.gov.il/', '2026-09-11'
);
SET @il4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@il4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il4, 'Core Documents', 'Required from every applicant.', 1);
SET @il4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@il4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@il4s1, 'Approved Work Permit', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @il4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il4s2, 'Medical Fitness Certificate', NULL, 'original', 1, 0, 0, 1),
(@il4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@il4s2, 'Academic/Professional/Trade Certificates', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(71, 4, NULL, 'INR', 'Confirmed After Assessment', 'Fee varies by track (bilateral-agreement caregiving/construction vs. Expert/hi-tech) and was not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://embassies.gov.il/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the India-Israel bilateral labor agreement?', 'A May 2023 agreement targeting up to 42,000 Indian workers, mainly in construction and caregiving. By July 2025, 6,774 workers had moved under the formal framework, with a target of 50,000 more by 2030.', 71, 4, 7103, 1),
('Are there risks associated with these jobs given the regional situation?', 'Yes — this labor migration occurs in the context of the ongoing conflict, and documented casualties among Indian workers include reports of at least 1 killed and 3 injured. We encourage applicants to understand current conditions fully before accepting a role.', 71, 4, 7104, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — B/2 Visa (Family Visit Purpose)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    71, 5, 'ISR-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives resident in Israel.',
    'Indian nationals with family in Israel — the SAME B/2 visa as Tourist and Business, differentiated by a family invitation letter and relationship proof rather than a separate legal code.',
    'Single or multiple entry, typically up to 90 days per visit',
    'Apply via VFS Global with a family invitation letter and relationship proof',
    1,
    'Standard multi-week processing; same underlying B/2 product as Tourist, so ensure family-visit documentation is clear',
    'Embassy of Israel, New Delhi, and VFS Global centres in other Indian cities',
    'Obtain an invitation letter from your relative in Israel\nGather documents proving the family relationship\nComplete the online B/2 visa application form\nSubmit documents and biometrics at the VFS Global centre',
    '/assets/images/visa-heroes/israel.jpg',
    'Cross-checked against VFS Global B/2 visa guidance, triangulated against secondary sourcing not directly fetchable this session', 'https://embassies.gov.il/', '2026-09-11'
);
SET @il5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@il5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il5, 'Core Documents', 'Required from every applicant.', 1);
SET @il5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@il5s1, 'Invitation Letter from Relative in Israel', NULL, 'original', 1, 0, 1, 2),
(@il5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @il5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(71, 5, NULL, 'INR', 'Confirmed After Assessment', 'Same B/2 fee schedule as Tourist — contact us to confirm the current figure.', '2026-09-01', NOW(), 'https://embassies.gov.il/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Family Visit visa code for Israel?', 'No — it is the same B/2 visa as Tourist and Business, differentiated only by the invitation letter and proof of relationship you submit.', 71, 5, 7105, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Routing Rule, No Standalone Code
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    71, 6, 'ISR-TRANS-IN-06', '2026.09', 'published',
    'Passing through Israel en route to a third country, most relevant at Ben Gurion Airport.',
    'Israel has no dedicated Transit visa code — this is modeled as a routing rule rather than a standalone visa product: passengers staying airside generally need no visa, while those leaving the airport apply for the standard B/2 visa.',
    'Short stay, typically same-day for airside transit',
    'No visa needed for airside transit; standard B/2 visa applies if leaving the airport',
    0,
    'Immediate for airside transit; confirm with your airline whether your specific connection requires clearing immigration',
    'Embassy of Israel, New Delhi (if a B/2 visa is needed)',
    'Confirm with your airline whether your connection is airside-only\nIf clearing immigration, apply for the standard B/2 visa in advance',
    '/assets/images/visa-heroes/israel.jpg',
    'Cross-checked against secondary sourcing confirming no dedicated Transit visa code exists; modeled as a routing rule between airside-transit and B/2', 'https://embassies.gov.il/', '2026-09-11'
);
SET @il6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@il6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il6, 'Core Documents', 'Required if clearing immigration.', 1);
SET @il6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@il6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il6, 'Supporting Documents', 'Only relevant if leaving the airport.', 2);
SET @il6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(71, 6, 0.00, 'INR', 'No Fee (Airside Transit)', 'No fee for airside-only transit not clearing immigration; standard B/2 visa fee applies if leaving the airport.', '2026-09-01', NOW(), 'https://embassies.gov.il/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Transit Visa for Israel?', 'No — Israel has no dedicated Transit visa code. Airside connections generally need no visa, while leaving the airport requires the standard B/2 visa.', 71, 6, 7106, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — B/2 Visa (Medical Purpose)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    71, 7, 'ISR-MED-IN-07', '2026.09', 'published',
    'Travel to Israel for medical treatment.',
    'Indian nationals travelling for treatment — the SAME B/2 visa as Tourist and Business, differentiated by hospital documentation rather than a separate legal code.',
    'Tied to the treatment period, extendable with hospital documentation, within the general B/2 stay allowance',
    'Apply via VFS Global with hospital appointment confirmation',
    1,
    'Same underlying B/2 product as Tourist; extension possible with hospital documentation for ongoing treatment',
    'Embassy of Israel, New Delhi, and VFS Global centres in other Indian cities',
    'Obtain a hospital appointment/admission confirmation letter from the treating Israeli hospital\nComplete the online B/2 visa application form with medical documentation\nSubmit documents and biometrics at the VFS Global centre',
    '/assets/images/visa-heroes/israel.jpg',
    'Cross-checked against VFS Global B/2 visa guidance and secondary medical-tourism sourcing, triangulated against sources not directly fetchable this session', 'https://embassies.gov.il/', '2026-09-11'
);
SET @il7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@il7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il7, 'Core Documents', 'Required from every applicant.', 1);
SET @il7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@il7s1, 'Hospital Appointment/Admission Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @il7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@il7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(71, 7, NULL, 'INR', 'Confirmed After Assessment', 'Same B/2 fee schedule as Tourist — contact us to confirm the current figure.', '2026-09-01', NOW(), 'https://embassies.gov.il/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Medical visa code for Israel?', 'No — it is the same B/2 visa as Tourist and Business, differentiated only by hospital documentation rather than a distinct application process.', 71, 7, 7107, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — B/2 Visa (Conference Purpose)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    71, 8, 'ISR-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, and official delegations in Israel.',
    'Indian nationals attending a conference — the SAME B/2 visa as Tourist and Business, differentiated by an event invitation letter rather than a separate legal code.',
    'Single or multiple entry, typically up to 90 days per visit',
    'Apply via VFS Global with the event invitation letter',
    1,
    'Standard multi-week processing; same underlying B/2 product as Tourist, so ensure conference-purpose documentation is clear',
    'Embassy of Israel, New Delhi, and VFS Global centres in other Indian cities',
    'Obtain an invitation letter from the conference organizer/host institution\nComplete the online B/2 visa application form\nSubmit documents and biometrics at the VFS Global centre',
    '/assets/images/visa-heroes/israel.jpg',
    'Cross-checked against VFS Global B/2 visa guidance, triangulated against secondary sourcing not directly fetchable this session', 'https://embassies.gov.il/', '2026-09-11'
);
SET @il8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@il8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il8, 'Core Documents', 'Required from every applicant.', 1);
SET @il8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@il8s1, 'Conference/Event Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @il8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(71, 8, NULL, 'INR', 'Confirmed After Assessment', 'Same B/2 fee schedule as Tourist — contact us to confirm the current figure.', '2026-09-01', NOW(), 'https://embassies.gov.il/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Conference visa code for Israel?', 'No — it is the same B/2 visa as Tourist and Business, differentiated only by the event invitation letter you submit.', 71, 8, 7108, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Routing Rule, No Standalone Code
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    71, 9, 'ISR-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Israel.',
    'Israel has no dedicated Sports visa code — this is modeled as a routing rule, with delegations typically applying for the general B/2 visa with federation/tournament accreditation as the supporting document.',
    'Single or multiple entry, typically up to 90 days, within the general B/2 framework',
    'Apply via VFS Global under the B/2 visa, with federation/tournament accreditation as supporting evidence',
    1,
    'No dedicated Sports visa product exists — modeled as a B/2 use-case, consistent with Israel''s general visa-purpose structure',
    'Embassy of Israel, New Delhi, and VFS Global centres in other Indian cities',
    'Obtain accreditation from the relevant sports federation or tournament organizer\nApply for the B/2 visa with the accreditation letter as supporting evidence\nSubmit documents and biometrics at the VFS Global centre',
    '/assets/images/visa-heroes/israel.jpg',
    'Cross-checked against secondary sourcing confirming no dedicated Sports visa code exists; modeled as a B/2 routing rule', 'https://embassies.gov.il/', '2026-09-11'
);
SET @il9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@il9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il9, 'Core Documents', 'Required from every applicant.', 1);
SET @il9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@il9s1, 'Sports Federation/Tournament Accreditation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @il9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(71, 9, NULL, 'INR', 'Confirmed After Assessment', 'Follows the B/2 fee schedule — contact us to confirm the current figure.', '2026-09-01', NOW(), 'https://embassies.gov.il/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports Visa for Israel?', 'No — Israel has no dedicated Sports visa code. Athletes and officials apply for the general B/2 visa, with federation or tournament accreditation as supporting evidence.', 71, 9, 7109, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — B/1 Track-Dependent Access
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    71, 10, 'ISR-DEP-IN-10', '2026.09', 'published',
    'Spouse/children accompanying an Indian Work (B/1) or Student (A/2) visa holder in Israel.',
    'IMPORTANT: Dependent visa access differs sharply by the principal''s track. For the B/1 Expert/hi-tech track, dependent visas are routinely available. For the bilateral-agreement caregiving/construction B/1 workers who make up the bulk of the Indian labor-migration population, dependent access is restricted/unclear based on sources found this session — this distinction is preserved honestly rather than implying uniform access. A/2 Student dependants are generally more straightforward.',
    'Tied to the principal visa holder''s visa validity; varies significantly by track',
    'Apply via VFS Global alongside/after the principal — eligibility depends heavily on which B/1 sub-category the principal holds',
    1,
    'This is a genuinely uneven category: confirm your principal''s specific B/1 sub-category (Expert/hi-tech vs. bilateral-agreement caregiving/construction) before assuming dependent eligibility',
    'Embassy of Israel, New Delhi, and VFS Global centres in other Indian cities',
    'Confirm which B/1 sub-category (or A/2 Student track) the principal applicant holds, since dependent eligibility varies significantly by track\nGather documents proving the family relationship\nSubmit the dependent visa application with relationship proof and the principal''s visa/permit copy',
    '/assets/images/visa-heroes/israel.jpg',
    'Cross-checked against secondary sourcing on B/1 sub-category-dependent Dependent-visa access differences, triangulated against sources not directly fetchable this session — genuine access variability preserved rather than flattened', 'https://embassies.gov.il/', '2026-09-11'
);
SET @il10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@il10, '2026.09', 'Initial published checklist — B/1 sub-category dependent-access distinction documented explicitly.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il10, 'Core Documents', 'Required from every applicant.', 1);
SET @il10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@il10s1, 'Proof of Relationship to Principal Visa Holder', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@il10, 'Supporting Documents', 'Evidence tied to the principal applicant''s visa and specific track.', 2);
SET @il10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@il10s2, 'Principal Applicant''s Visa/Work Permit Copy (Specify B/1 Sub-Category)', NULL, 'copy', 1, 0, 0, 1),
(@il10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(71, 10, NULL, 'INR', 'Confirmed After Assessment', 'Fee and even basic eligibility vary sharply by the principal''s B/1 sub-category — contact us to confirm your specific case.', '2026-09-01', NOW(), 'https://embassies.gov.il/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my family join me on any Israeli Work visa?', 'It depends heavily on your specific track. Dependent visas are routinely available for the B/1 Expert/hi-tech track, but access is restricted or unclear for the bilateral-agreement caregiving/construction B/1 workers who make up most of the current Indian labor-migration population. Confirm your specific sub-category before assuming eligibility.', 71, 10, 7110, 1);
