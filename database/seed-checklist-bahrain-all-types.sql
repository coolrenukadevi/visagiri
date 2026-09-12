-- Bahrain Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url left NULL at
-- authoring time, wired to the real supplied photo during the apply
-- step.
--
-- IMPORTANT SOURCING CAVEAT: evisa.gov.bh was not directly fetchable
-- this session (network egress blocked) — findings triangulated from
-- web-search-indexed news and visa-agency secondary sourcing.
--
-- Bahrain's real, distinctive facts:
--   - Bahrain does NOT offer unconditional visa-free entry or a
--     general Visa-on-Arrival to Indians — the eVisa via evisa.gov.bh
--     is the primary, reliable route. Fee figures were found genuinely
--     conflicted across sources (BD5/BD9/BD10 all cited) — this file
--     states that conflict explicitly rather than picking one number
--     with false confidence.
--   - Work permits run entirely separately through the LMRA (Labour
--     Market Regulatory Authority)'s employer-side Expat Management
--     System — a distinctive institutional detail worth naming
--     explicitly, since LMRA is not the same body that issues the
--     entry eVisa.
--   - Bahrain has no distinct Conference or Sports visa SKUs; Sports is
--     modeled via a rare, genuinely documented event-specific "Events
--     Visa" mechanism — concretely confirmed only for F1 Bahrain Grand
--     Prix ticket holders in sources found this session, not a general
--     product for any sporting event.
--   - Dependent (Family Residence) requires the sponsor to meet an
--     income floor of BHD 400/month for a spouse/children, rising to
--     BHD 1,000/month for parents or children over 24 — a genuinely
--     tiered income requirement. Dependents cannot work without a
--     SEPARATE LMRA-issued work permit of their own — this distinction
--     is preserved explicitly.
--
-- country_id 58 = Bahrain. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    58, 1, 'BHR-TOUR-IN-01', '2026.09', 'published',
    'Leisure and business-hub travel to Bahrain.',
    'Indian passport holders — Bahrain does not offer unconditional visa-free entry or a general Visa-on-Arrival to Indians. The eVisa via evisa.gov.bh is the primary, reliable route.',
    'Single entry up to 30 days, or multiple entry up to 90 days depending on type selected',
    'Apply online via evisa.gov.bh in advance',
    0,
    'Fee figures for the eVisa were found genuinely conflicted across sources this session (BD5, BD9, and BD10 all cited) — confirm the current exact figure directly on evisa.gov.bh before finalizing your budget',
    'Not applicable for e-visa; Embassy of Bahrain, New Delhi, for any paper-visa alternative',
    'Complete the eVisa application online via evisa.gov.bh\nUpload passport scan and photograph\nPay the eVisa fee online\nPresent the eVisa approval and passport at the border',
    '/assets/images/visa-heroes/bahrain.jpg',
    'Cross-checked against evisa.gov.bh guidance and secondary visa-agency sourcing, triangulated against sources not directly fetchable this session — fee figures found conflicted across sources and flagged accordingly', 'https://www.evisa.gov.bh/', '2026-09-11'
);
SET @bh1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bh1, '2026.09', 'Initial published checklist — eVisa fee conflict across sources flagged.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh1, 'Core Documents', 'Required for the eVisa application.', 1);
SET @bh1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bh1s1, 'Digital Passport-Style Photograph', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh1, 'Supporting Documents', 'Evidence of your travel plans.', 2);
SET @bh1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@bh1s2, 'Confirmed Hotel Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(58, 1, NULL, 'BHD', 'Confirmed After Assessment (Sources Conflict: BD5/9/10)', 'Fee figures found genuinely conflicted across sources this session — confirm the current exact figure directly on evisa.gov.bh.', '2026-09-01', NOW(), 'https://www.evisa.gov.bh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there Visa-on-Arrival for Indians visiting Bahrain?', 'No — Bahrain does not offer unconditional visa-free entry or a general Visa-on-Arrival to Indians. Apply for the eVisa in advance via evisa.gov.bh.', 58, 1, 5800, 1),
('How much does the Bahrain eVisa cost?', 'Sources genuinely conflict on this — figures of BD5, BD9, and BD10 were all cited. Confirm the current exact figure directly on evisa.gov.bh before finalizing your budget.', 58, 1, 5801, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    58, 2, 'BHR-BUS-IN-02', '2026.09', 'published',
    'Trade, investment exploration, and commercial meetings in Bahrain.',
    'Indian nationals travelling for business, requiring a Business eVisa via evisa.gov.bh with a company invitation letter.',
    'Single or multiple entry, typically up to 90 days',
    'Apply online via evisa.gov.bh with a business invitation letter',
    0,
    'Standard eVisa processing is typically a few business days',
    'Not applicable for e-visa; Embassy of Bahrain, New Delhi, for any paper-visa alternative',
    'Obtain an invitation letter from the Bahraini host company\nComplete the online eVisa application form\nSubmit documents and pay the fee online',
    '/assets/images/visa-heroes/bahrain.jpg',
    'Cross-checked against evisa.gov.bh guidance, triangulated against secondary business-travel sourcing not directly fetchable this session', 'https://www.evisa.gov.bh/', '2026-09-11'
);
SET @bh2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bh2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh2, 'Core Documents', 'Required for the eVisa application.', 1);
SET @bh2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bh2s1, 'Invitation Letter from Bahraini Company', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh2, 'Supporting Documents', 'Evidence of your own employment/business standing.', 2);
SET @bh2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@bh2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(58, 2, NULL, 'BHD', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.evisa.gov.bh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a company invitation for the Business eVisa?', 'Yes — a business invitation letter from your Bahraini host company is required alongside the standard eVisa documentation.', 58, 2, 5802, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    58, 3, 'BHR-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Bahraini university or institution.',
    'Indian nationals admitted to a recognized Bahraini institution, requiring a Student Visa sponsored by the institution.',
    'Tied to course duration, renewable annually',
    'Institution sponsors the Student Visa application via the General Directorate of Nationality, Passports and Residence (GDNPR)',
    1,
    'Standard multi-week processing; annual renewal typically required alongside institution re-enrollment confirmation',
    'General Directorate of Nationality, Passports and Residence, Manama (via institution sponsorship); Embassy of Bahrain, New Delhi',
    'Secure admission at a recognized Bahraini institution\nHave the institution sponsor your Student Visa application\nSubmit supporting documents\nRegister with local authorities after arrival',
    '/assets/images/visa-heroes/bahrain.jpg',
    'Cross-checked against GDNPR Student Visa guidance and secondary education-consultancy sourcing, triangulated against sources not directly fetchable this session', 'https://www.evisa.gov.bh/', '2026-09-11'
);
SET @bh3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bh3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh3, 'Core Documents', 'Required from every applicant.', 1);
SET @bh3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bh3s1, 'Admission Letter from Bahraini Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh3, 'Supporting Documents', 'Evidence of your academic background and means.', 2);
SET @bh3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bh3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@bh3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(58, 3, NULL, 'BHD', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.evisa.gov.bh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who sponsors an Indian student''s visa for Bahrain?', 'The Bahraini institution sponsors the Student Visa application via the General Directorate of Nationality, Passports and Residence (GDNPR).', 58, 3, 5803, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — LMRA-Managed
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    58, 4, 'BHR-WORK-IN-04', '2026.09', 'published',
    'Employment with a Bahraini employer — Bahrain has a significant resident Indian expatriate workforce.',
    'Indian nationals with a confirmed job offer; the Labour Market Regulatory Authority (LMRA) manages work permits entirely separately from the entry eVisa system, via the employer-side Expat Management System — this distinct institutional split is worth understanding upfront.',
    'Tied to the employment contract, typically 1-2 years, renewable',
    'Employer files the work permit application via the LMRA''s Expat Management System, then the employee applies for the entry visa',
    1,
    'LMRA (work permits) is a genuinely distinct institution from the entry-visa system — employers manage the entire process through LMRA''s Expat Management System, separate from the GDNPR/eVisa route used for tourism/business',
    'LMRA, Manama (employer-facing); Embassy of Bahrain, New Delhi (entry visa)',
    'Employer files the work permit application via the LMRA Expat Management System\nEmployee applies for the entry visa via the Embassy of Bahrain, referencing the approved permit\nSubmit supporting documents and medical clearance\nComplete residency registration after arrival',
    '/assets/images/visa-heroes/bahrain.jpg',
    'Cross-checked against LMRA Expat Management System guidance and secondary expatriate-employment sourcing, triangulated against sources not directly fetchable this session', 'https://www.evisa.gov.bh/', '2026-09-11'
);
SET @bh4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bh4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh4, 'Core Documents', 'Required from every applicant.', 1);
SET @bh4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bh4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@bh4s1, 'Approved LMRA Work Permit', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @bh4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bh4s2, 'Medical Fitness Certificate', NULL, 'original', 1, 0, 0, 2),
(@bh4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(58, 4, NULL, 'BHD', 'Confirmed After Assessment', 'LMRA work-permit fees vary by sector and were not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.evisa.gov.bh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who manages work permits in Bahrain?', 'The Labour Market Regulatory Authority (LMRA) — a distinct institution from the GDNPR/eVisa system used for entry visas — manages work permits entirely through its employer-side Expat Management System.', 58, 4, 5804, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    58, 5, 'BHR-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives resident in Bahrain — distinct from the longer-term Dependent (Family Residence) permit.',
    'Indian nationals with family in Bahrain, requiring a Family Visit eVisa via evisa.gov.bh with an invitation and relationship proof.',
    'Single or multiple entry, typically up to 90 days',
    'Apply online via evisa.gov.bh with a family invitation letter and relationship proof',
    0,
    'Standard eVisa processing is typically a few business days; fee figures found conflicted across sources this session, same as Tourist',
    'Not applicable for e-visa; Embassy of Bahrain, New Delhi, for any paper-visa alternative',
    'Obtain an invitation letter from your relative in Bahrain\nGather documents proving the family relationship\nComplete the online eVisa application form',
    '/assets/images/visa-heroes/bahrain.jpg',
    'Cross-checked against evisa.gov.bh guidance, triangulated against secondary sourcing not directly fetchable this session', 'https://www.evisa.gov.bh/', '2026-09-11'
);
SET @bh5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bh5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh5, 'Core Documents', 'Required from every applicant.', 1);
SET @bh5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bh5s1, 'Invitation Letter from Relative in Bahrain', NULL, 'original', 1, 0, 1, 2),
(@bh5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @bh5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(58, 5, NULL, 'BHD', 'Confirmed After Assessment (Sources Conflict)', 'Same fee conflict as Tourist (BD5/9/10 cited across sources) — confirm the current exact figure on evisa.gov.bh.', '2026-09-01', NOW(), 'https://www.evisa.gov.bh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Family Visit the same as the Dependent Family Residence permit?', 'No — Family Visit is a short-term eVisa for visiting relatives, while Dependent (Family Residence) is a separate, longer-term residency permit with its own income requirements.', 58, 5, 5805, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    58, 6, 'BHR-TRANS-IN-06', '2026.09', 'published',
    'Passing through Bahrain en route to a third country, most relevant at Bahrain International Airport.',
    'Indian nationals with a confirmed onward connection; airside transit without leaving the airport generally does not require a visa, while those leaving the airport need the standard eVisa.',
    'Short stay, typically same-day for airside transit',
    'No visa needed for airside transit; standard eVisa applies if leaving the airport',
    0,
    'Immediate; confirm with your airline whether your specific connection requires clearing immigration',
    'Not applicable',
    'Confirm with your airline whether your connection is airside-only\nIf clearing immigration, apply for the standard eVisa in advance',
    '/assets/images/visa-heroes/bahrain.jpg',
    'Cross-checked against evisa.gov.bh guidance and airport-transit secondary sourcing, triangulated against sources not directly fetchable this session', 'https://www.evisa.gov.bh/', '2026-09-11'
);
SET @bh6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bh6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh6, 'Core Documents', 'Required if clearing immigration.', 1);
SET @bh6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bh6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh6, 'Supporting Documents', 'Only relevant if leaving the airport.', 2);
SET @bh6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(58, 6, 0.00, 'INR', 'No Fee (Airside Transit)', 'No fee for airside-only transit not clearing immigration; standard eVisa fee applies if leaving the airport.', '2026-09-01', NOW(), 'https://www.evisa.gov.bh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa just to change planes in Bahrain?', 'If you stay airside and don''t clear immigration, generally no. If you leave the airport, you''ll need the standard eVisa.', 58, 6, 5806, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    58, 7, 'BHR-MED-IN-07', '2026.09', 'published',
    'Travel to Bahrain for medical treatment.',
    'Indian nationals travelling for treatment, requiring the eVisa with hospital documentation as supporting evidence — no distinct Medical visa code was confirmed this session.',
    'Single or multiple entry, typically up to 90 days, extendable with hospital documentation',
    'Apply online via evisa.gov.bh with hospital appointment confirmation',
    0,
    'Standard eVisa processing is typically a few business days',
    'Not applicable for e-visa',
    'Obtain a hospital appointment/admission confirmation letter from the treating Bahraini hospital\nComplete the eVisa application online with medical documentation\nPresent the eVisa approval and passport at the border',
    '/assets/images/visa-heroes/bahrain.jpg',
    'Cross-checked against evisa.gov.bh guidance and secondary medical-tourism sourcing, triangulated against sources not directly fetchable this session', 'https://www.evisa.gov.bh/', '2026-09-11'
);
SET @bh7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bh7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh7, 'Core Documents', 'Required from every applicant.', 1);
SET @bh7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bh7s1, 'Hospital Appointment/Admission Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @bh7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@bh7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(58, 7, NULL, 'BHD', 'Confirmed After Assessment (Sources Conflict)', 'Same fee conflict as Tourist — confirm the current exact figure on evisa.gov.bh.', '2026-09-01', NOW(), 'https://www.evisa.gov.bh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Medical Visa code for Bahrain?', 'No distinct code was confirmed this session — medical travel is processed as the standard eVisa, supported by hospital documentation.', 58, 7, 5807, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — No Distinct SKU
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    58, 8, 'BHR-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, and official delegations in Bahrain.',
    'Bahrain has no distinct Conference visa SKU — confirmed this session — processed under the general Business eVisa with an event invitation letter.',
    'Single or multiple entry, typically up to 90 days',
    'Apply online via evisa.gov.bh under the Business eVisa category, with the event invitation letter',
    0,
    'No dedicated Conference visa product exists — modeled as a Business-eVisa use-case',
    'Not applicable for e-visa',
    'Obtain an invitation letter from the conference organizer/host institution\nComplete the online Business eVisa application form\nSubmit documents and pay the fee online',
    '/assets/images/visa-heroes/bahrain.jpg',
    'Cross-checked against secondary sourcing confirming no dedicated Conference visa SKU exists; modeled as a Business-eVisa use-case', 'https://www.evisa.gov.bh/', '2026-09-11'
);
SET @bh8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bh8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh8, 'Core Documents', 'Required from every applicant.', 1);
SET @bh8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bh8s1, 'Conference/Event Invitation Letter', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @bh8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(58, 8, NULL, 'BHD', 'Confirmed After Assessment', 'Follows the Business eVisa fee schedule — contact us to confirm.', '2026-09-01', NOW(), 'https://www.evisa.gov.bh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Conference Visa for Bahrain?', 'No — Bahrain has no distinct Conference visa SKU. Delegates apply under the general Business eVisa, with an event invitation letter as supporting evidence.', 58, 8, 5808, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Rare Event-Specific "Events Visa"
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    58, 9, 'BHR-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or spectators attending major sporting events in Bahrain.',
    'Bahrain has no general Sports visa SKU. A rare, genuinely documented "Events Visa" mechanism exists — concretely confirmed only for F1 Bahrain Grand Prix ticket holders in sources found this session, not a general product for any sporting event.',
    'Tied to the specific event dates',
    'For F1 Grand Prix: apply via the Events Visa process linked to ticket purchase; other events use the general Business/Tourist eVisa with accreditation',
    0,
    'The documented "Events Visa" mechanism was specifically confirmed only for F1 Bahrain Grand Prix ticket holders this session — for other sporting events/tournaments, the general Business or Tourist eVisa route with accreditation is the fallback',
    'Not applicable for e-visa',
    'For F1 Grand Prix attendance: check whether your ticket purchase links to the official Events Visa process\nFor other sporting events: obtain accreditation from the relevant sports federation or tournament organizer and apply for the general Business/Tourist eVisa',
    '/assets/images/visa-heroes/bahrain.jpg',
    'Cross-checked against F1 Bahrain Grand Prix Events Visa reporting; general applicability to other sporting events was NOT confirmed this session and is flagged accordingly', 'https://www.evisa.gov.bh/', '2026-09-11'
);
SET @bh9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bh9, '2026.09', 'Initial published checklist — Events Visa scope limited to F1 confirmation.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh9, 'Core Documents (F1 Grand Prix)', 'Concretely confirmed this session for F1 ticket holders.', 1);
SET @bh9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bh9s1, 'F1 Bahrain Grand Prix Ticket Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh9, 'Core Documents (Other Sporting Events, Fallback)', 'General eVisa route, not the confirmed Events Visa mechanism.', 2);
SET @bh9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh9s2, 'Sports Federation/Tournament Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(58, 9, NULL, 'BHD', 'Confirmed After Assessment', 'Fee depends heavily on which route applies (F1 Events Visa vs. general eVisa) — contact us to confirm.', '2026-09-01', NOW(), 'https://www.evisa.gov.bh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a general Sports Visa for Bahrain?', 'Not a general one — the only concretely documented event-specific mechanism found this session is an "Events Visa" tied to F1 Bahrain Grand Prix ticket purchases. For other sporting events, the general Business/Tourist eVisa with federation accreditation is the fallback.', 58, 9, 5809, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Residence
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    58, 10, 'BHR-DEP-IN-10', '2026.09', 'published',
    'Spouse/children (or parents/over-24 children) accompanying an Indian Work or Student visa holder in Bahrain — termed Family Residence.',
    'Family members of an Indian national already working or studying in Bahrain; the sponsor must meet a tiered income floor — BHD 400/month for a spouse/children, rising to BHD 1,000/month for parents or children over 24.',
    'Tied to the principal visa/permit holder''s validity',
    'Sponsor applies for the Family Residence permit via the GDNPR, meeting the applicable income tier',
    1,
    'IMPORTANT: dependents CANNOT work in Bahrain without a SEPARATE LMRA-issued work permit of their own — Family Residence status alone does not authorize employment',
    'General Directorate of Nationality, Passports and Residence (GDNPR), Manama',
    'Confirm the principal applicant''s Work or Student visa is approved\nConfirm the sponsor meets the applicable income floor (BHD 400/month for spouse/children, BHD 1,000/month for parents/over-24 children)\nGather documents proving the family relationship\nApply for the Family Residence permit via GDNPR',
    '/assets/images/visa-heroes/bahrain.jpg',
    'Cross-checked against GDNPR Family Residence income-threshold guidance and secondary expatriate-family sourcing, triangulated against sources not directly fetchable this session', 'https://www.evisa.gov.bh/', '2026-09-11'
);
SET @bh10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bh10, '2026.09', 'Initial published checklist — tiered income floor and separate work-permit requirement documented explicitly.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh10, 'Core Documents', 'Required from every applicant.', 1);
SET @bh10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bh10s1, 'Proof of Relationship to Principal Visa Holder', NULL, 'copy', 1, 0, 1, 2),
(@bh10s1, 'Sponsor Income Proof (BHD 400 or BHD 1,000/Month Tier)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bh10, 'Supporting Documents', 'Additional evidence.', 2);
SET @bh10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bh10s2, 'Principal Applicant''s Visa/Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@bh10s2, 'Medical Fitness Certificate', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(58, 10, NULL, 'BHD', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.evisa.gov.bh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my dependent family members work in Bahrain?', 'Not automatically — Family Residence status alone does not authorize employment. Dependents need a separate, distinct work permit issued by the LMRA before they can legally work.', 58, 10, 5810, 1),
('What income does a sponsor need to bring family to Bahrain?', 'It''s tiered: BHD 400/month for a spouse or children, rising to BHD 1,000/month if sponsoring parents or children over 24.', 58, 10, 5811, 1);
