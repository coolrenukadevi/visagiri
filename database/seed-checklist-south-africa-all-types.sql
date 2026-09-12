-- South Africa Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search. hero_image_url left NULL at
-- authoring time, wired to the real supplied photo during the apply
-- step.
--
-- IMPORTANT SOURCING CAVEAT: South Africa's Department of Home Affairs
-- site was not directly fetchable this session (network egress
-- blocked) — findings triangulated from web-search-indexed news and
-- visa-agency secondary sourcing. Transit/Medical/Conference/Sports/
-- General-Work/Dependent categories were only lightly sourced this
-- session — flagged explicitly below and in each category's fields
-- rather than fabricated.
--
-- South Africa's real, distinctive facts:
--   - A new Electronic Travel Authorisation (ETA) system was expanded to
--     include Indian nationals effective 12 Feb 2026 — a free
--     authorization valid only for entry through three specific
--     airports: OR Tambo (Johannesburg), Cape Town, and Lanseria. This
--     is a genuinely new, dated, and geographically-restricted policy,
--     not a general visa-free arrangement.
--   - The Trusted Tour Operator Scheme (TTOS), which previously allowed
--     accredited tour operators to bring Indian tourist groups in with
--     lighter visa requirements, has been reported as being phased out
--     — noted as a reported trend rather than a confirmed final
--     decision.
--   - The Critical Skills Work Visa allows applicants to submit their
--     application with a PENDING SAQA (South African Qualifications
--     Authority) evaluation rather than waiting for it to complete
--     first — a genuinely distinctive procedural detail that speeds up
--     the process for qualifying applicants.
--   - Several categories (Transit, Medical, Conference, Sports, General
--     Work Visa specifics, Dependent) were only lightly sourced this
--     session — each is flagged explicitly as "insufficiently sourced
--     this session" with no invented fee/process numbers.
--
-- country_id 46 = South Africa. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — ETA (Since 12 Feb 2026) / Visitor's Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    46, 1, 'ZAF-TOUR-IN-01', '2026.09', 'published',
    'Leisure and safari travel to South Africa.',
    'Indian passport holders — as of 12 Feb 2026, a new free Electronic Travel Authorisation (ETA) is available, but only for entry through OR Tambo (Johannesburg), Cape Town, or Lanseria airports; travel via other ports of entry still requires the standard Visitor''s Visa.',
    'Up to 90 days',
    'Apply online for the ETA if entering via OR Tambo, Cape Town, or Lanseria; otherwise apply for the standard Visitor''s Visa via VFS Global',
    0,
    'The ETA is new (effective 12 Feb 2026) and restricted to three airports — confirm your entry port; the previously-used Trusted Tour Operator Scheme (TTOS) is reportedly being phased out',
    'VFS Global Visa Application Centres in India (for the standard Visitor''s Visa); ETA is online-only',
    'Confirm which airport you will enter through\nIf OR Tambo, Cape Town, or Lanseria, apply online for the free ETA\nIf entering elsewhere, apply for the standard Visitor''s Visa via VFS Global with supporting documents and biometrics',
    '/assets/images/visa-heroes/south-africa.jpg',
    'Cross-checked against 2026 ETA-rollout news reporting and VFS Global Visitor''s Visa guidance, triangulated against secondary sourcing not directly fetchable this session', 'https://www.dha.gov.za/', '2026-09-11'
);
SET @za1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@za1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za1, 'For the ETA (OR Tambo, Cape Town, Lanseria Only)', 'A free, online-only authorization limited to these three airports.', 1);
SET @za1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@za1s1, 'Digital Passport-Style Photograph', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za1, 'For the Standard Visitor''s Visa (Other Ports of Entry)', 'Required if entering through any airport other than the three ETA-eligible ones.', 2);
SET @za1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za1s2, 'Confirmed Hotel Booking', NULL, 'copy', 0, 1, 0, 1),
(@za1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 0, 1, 0, 2),
(@za1s2, 'Bank Statement (Last 3 Months)', NULL, 'copy', 0, 1, 0, 3),
(@za1s2, 'Yellow Fever Certificate (If Transiting a Risk Country)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(46, 1, 0.00, 'INR', 'No ETA Fee (Restricted to 3 Airports)', 'The ETA is free but limited to OR Tambo, Cape Town, and Lanseria entry; the standard Visitor''s Visa fee for other ports was not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.dha.gov.za/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use the new ETA no matter which airport I fly into?', 'No — the ETA introduced 12 Feb 2026 is limited to entry through OR Tambo (Johannesburg), Cape Town, or Lanseria airports. Other ports of entry still require the standard Visitor''s Visa.', 46, 1, 4600, 1),
('Is the Trusted Tour Operator Scheme still available?', 'It has been reported as being phased out — confirm current availability with your tour operator or VFS Global before relying on it.', 46, 1, 4601, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    46, 2, 'ZAF-BUS-IN-02', '2026.09', 'published',
    'Trade, investment exploration, and commercial meetings in South Africa.',
    'Indian nationals travelling for business, requiring the Business Visitor''s Visa via VFS Global with a company invitation letter; the airport-restricted ETA covers tourism primarily, and business eligibility under the ETA was not clearly confirmed this session.',
    'Up to 90 days',
    'Apply via VFS Global with a business invitation letter and supporting documents',
    1,
    'Confirm whether your specific business purpose qualifies for the ETA (if entering via an eligible airport) or requires the standard Business Visitor''s Visa',
    'VFS Global Visa Application Centres in India',
    'Obtain an invitation letter from the South African host company\nComplete the Business Visitor''s Visa application via VFS Global\nSubmit documents and biometrics at the visa application centre',
    '/assets/images/visa-heroes/south-africa.jpg',
    'Cross-checked against VFS Global Business Visitor''s Visa guidance, triangulated against secondary sourcing not directly fetchable this session', 'https://www.dha.gov.za/', '2026-09-11'
);
SET @za2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@za2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za2, 'Core Documents', 'Required from every applicant.', 1);
SET @za2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@za2s1, 'Invitation Letter from South African Company', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za2, 'Supporting Documents', 'Evidence of your own employment/business standing.', 2);
SET @za2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@za2s2, 'Bank Statement (Last 3 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(46, 2, NULL, 'INR', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.dha.gov.za/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the new ETA cover business travel?', 'This was not clearly confirmed this session — confirm your specific eligibility with VFS Global or the ETA portal before relying on it for business purposes.', 46, 2, 4602, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    46, 3, 'ZAF-STU-IN-03', '2026.09', 'published',
    'Enrolling in a South African university or institution.',
    'Indian nationals admitted to a recognized South African institution, requiring a Study Visa via VFS Global with the institution''s admission letter.',
    'Tied to course duration, renewable',
    'Apply via VFS Global with admission letter and supporting documents',
    1,
    'Standard multi-week processing; ensure medical/radiological reports meet current South African requirements',
    'VFS Global Visa Application Centres in India',
    'Secure admission at a recognized South African institution\nComplete the Study Visa application via VFS Global\nSubmit documents, medical reports, and biometrics at the visa application centre\nRegister with the institution and Department of Home Affairs after arrival',
    '/assets/images/visa-heroes/south-africa.jpg',
    'Cross-checked against VFS Global Study Visa guidance and secondary education-consultancy sourcing, triangulated against sources not directly fetchable this session', 'https://www.dha.gov.za/', '2026-09-11'
);
SET @za3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@za3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za3, 'Core Documents', 'Required from every applicant.', 1);
SET @za3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@za3s1, 'Admission Letter from South African Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za3, 'Supporting Documents', 'Evidence of your academic background, health, and means.', 2);
SET @za3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@za3s2, 'Medical and Radiological Reports', NULL, 'original', 1, 0, 0, 2),
(@za3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 3),
(@za3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(46, 3, NULL, 'INR', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.dha.gov.za/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What health documents does a Study Visa need?', 'Medical and radiological (chest X-ray/TB screening) reports meeting current South African immigration requirements, in addition to standard academic and financial documents.', 46, 3, 4603, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Critical Skills Work Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    46, 4, 'ZAF-WORK-IN-04', '2026.09', 'published',
    'Employment with a South African employer, most commonly via the Critical Skills Work Visa for in-demand professions.',
    'Indian nationals with skills on South Africa''s Critical Skills List, or a General Work Visa for other roles. The Critical Skills Work Visa allows submission with a PENDING SAQA (South African Qualifications Authority) evaluation rather than waiting for it to complete first — a genuinely distinctive procedural detail.',
    'Tied to the employment contract, typically up to 5 years, renewable',
    'Apply via VFS Global with proof of qualifications on the Critical Skills List; SAQA evaluation may be submitted as pending',
    1,
    'General Work Visa specifics (labour-market-testing requirements, quota rules) were only lightly sourced this session — flagged for follow-up verification; the Critical Skills route is the better-documented path this session',
    'VFS Global Visa Application Centres in India',
    'Confirm your profession appears on South Africa''s Critical Skills List\nSubmit your SAQA evaluation application (can be pending at the time of visa submission)\nApply for the Critical Skills Work Visa via VFS Global with your qualifications and job offer\nSubmit documents and biometrics at the visa application centre',
    '/assets/images/visa-heroes/south-africa.jpg',
    'Cross-checked against VFS Global Critical Skills Work Visa guidance and secondary expatriate-employment sourcing, triangulated against sources not directly fetchable this session — General Work Visa specifics flagged as insufficiently sourced', 'https://www.dha.gov.za/', '2026-09-11'
);
SET @za4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@za4, '2026.09', 'Initial published checklist — General Work Visa specifics flagged as needing further verification.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za4, 'Core Documents', 'Required from every applicant.', 1);
SET @za4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@za4s1, 'Employment Contract/Job Offer', NULL, 'copy', 1, 0, 1, 2),
(@za4s1, 'SAQA Evaluation (May Be Pending)', 'Can be submitted as pending under the Critical Skills route.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @za4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@za4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@za4s2, 'Proof of Professional Registration (Where Applicable)', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(46, 4, NULL, 'INR', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.dha.gov.za/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need my SAQA evaluation completed before applying for the Critical Skills Work Visa?', 'No — a genuinely distinctive feature of this visa is that you can submit your application while the SAQA evaluation is still pending, rather than waiting for it to complete first.', 46, 4, 4604, 1),
('Is the General Work Visa route as well-documented as the Critical Skills route?', 'Not this session — General Work Visa specifics (labour-market testing, quotas) were only lightly sourced. If your role isn''t on the Critical Skills List, contact us or the Department of Home Affairs directly for current requirements.', 46, 4, 4605, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    46, 5, 'ZAF-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives resident in South Africa.',
    'Indian nationals with family members residing in South Africa; only lightly sourced this session — likely processed under the same ETA/Visitor''s Visa framework as Tourist entry, but this was not separately, explicitly confirmed.',
    'Likely up to 90 days, pending confirmation',
    'Likely the same ETA (if eligible airport) or Visitor''s Visa process as Tourist entry',
    0,
    'Only lightly sourced this session — flagged for follow-up verification before relying on this content for planning',
    'VFS Global Visa Application Centres in India; ETA online if eligible',
    'Confirm current Family Visit requirements directly with VFS Global or the Department of Home Affairs\nGather documents proving the family relationship\nApply via the ETA (if eligible airport) or standard Visitor''s Visa process',
    '/assets/images/visa-heroes/south-africa.jpg',
    'INSUFFICIENTLY SOURCED this session — recommend direct confirmation with VFS Global or the Department of Home Affairs before relying on this content', 'https://www.dha.gov.za/', '2026-09-11'
);
SET @za5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@za5, '2026.09', 'Initial published checklist — flagged as needing primary-source verification.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za5, 'Core Documents (Provisional)', 'Confirm before relying on this list.', 1);
SET @za5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@za5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za5, 'Supporting Documents', 'Not independently confirmed this session.', 2);
SET @za5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za5s2, 'Invitation Letter from Relative in South Africa', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(46, 5, NULL, 'INR', 'Confirmed After Assessment', 'Not independently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.dha.gov.za/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Family Visit category fully confirmed for South Africa?', 'Not yet — this category was only lightly sourced this session and is flagged for follow-up verification. Please confirm current requirements directly with VFS Global or the Department of Home Affairs.', 46, 5, 4606, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Insufficiently Sourced, Flagged
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    46, 6, 'ZAF-TRANS-IN-06', '2026.09', 'published',
    'Passing through South Africa en route to a third country, most relevant at OR Tambo International Airport.',
    'Only lightly sourced this session — general transit-visa rules for Indians were not independently confirmed. Flagged for follow-up verification rather than filled with invented specifics.',
    'Not confirmed this session',
    'Confirm current transit-visa requirements directly with VFS Global or your airline',
    1,
    'INSUFFICIENTLY SOURCED this session — do not rely on this content for fee or process details without independent confirmation',
    'VFS Global Visa Application Centres in India',
    'Confirm current transit-visa requirements directly with VFS Global or your airline before travel\nCarry onward ticket and passport regardless',
    '/assets/images/visa-heroes/south-africa.jpg',
    'INSUFFICIENTLY SOURCED this session — recommend direct confirmation with VFS Global or the Department of Home Affairs before relying on this content', 'https://www.dha.gov.za/', '2026-09-11'
);
SET @za6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@za6, '2026.09', 'Initial published checklist — flagged as needing primary-source verification.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za6, 'Core Documents (Provisional)', 'Confirm before relying on this list.', 1);
SET @za6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@za6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za6, 'Supporting Documents', 'Not independently confirmed this session.', 2);
SET @za6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(46, 6, NULL, 'INR', 'Confirmed After Assessment', 'Not independently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.dha.gov.za/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Transit category fully confirmed for South Africa?', 'Not yet — this category was only lightly sourced this session. Please confirm current transit requirements directly with VFS Global or your airline before travel.', 46, 6, 4607, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Insufficiently Sourced, Flagged
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    46, 7, 'ZAF-MED-IN-07', '2026.09', 'published',
    'Travel to South Africa for medical treatment.',
    'Only lightly sourced this session — a distinct Medical visa product was not independently confirmed. Flagged for follow-up verification rather than filled with invented specifics.',
    'Not confirmed this session',
    'Confirm current Medical-visa requirements directly with VFS Global or the Department of Home Affairs',
    1,
    'INSUFFICIENTLY SOURCED this session — do not rely on this content for fee or process details without independent confirmation',
    'VFS Global Visa Application Centres in India',
    'Confirm current Medical-visa requirements directly with VFS Global before travel\nCarry hospital documentation as supporting evidence regardless',
    '/assets/images/visa-heroes/south-africa.jpg',
    'INSUFFICIENTLY SOURCED this session — recommend direct confirmation with VFS Global or the Department of Home Affairs before relying on this content', 'https://www.dha.gov.za/', '2026-09-11'
);
SET @za7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@za7, '2026.09', 'Initial published checklist — flagged as needing primary-source verification.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za7, 'Core Documents (Provisional)', 'Confirm before relying on this list.', 1);
SET @za7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@za7s1, 'Hospital Appointment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za7, 'Supporting Documents', 'Not independently confirmed this session.', 2);
SET @za7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za7s2, 'Medical Records/Referral', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(46, 7, NULL, 'INR', 'Confirmed After Assessment', 'Not independently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.dha.gov.za/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Medical category fully confirmed for South Africa?', 'Not yet — this category was only lightly sourced this session. Please confirm current requirements directly with VFS Global or the Department of Home Affairs before travel.', 46, 7, 4608, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Insufficiently Sourced, Flagged
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    46, 8, 'ZAF-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, and official delegations in South Africa.',
    'Only lightly sourced this session — likely processed under the same ETA/Visitor''s or Business Visa framework, but this was not separately, explicitly confirmed.',
    'Likely up to 90 days, pending confirmation',
    'Confirm current Conference-visa requirements directly with VFS Global or the Department of Home Affairs',
    1,
    'INSUFFICIENTLY SOURCED this session — do not rely on this content for fee or process details without independent confirmation',
    'VFS Global Visa Application Centres in India',
    'Confirm current Conference-visa requirements directly with VFS Global before travel\nCarry a conference invitation letter as supporting evidence regardless',
    '/assets/images/visa-heroes/south-africa.jpg',
    'INSUFFICIENTLY SOURCED this session — recommend direct confirmation with VFS Global or the Department of Home Affairs before relying on this content', 'https://www.dha.gov.za/', '2026-09-11'
);
SET @za8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@za8, '2026.09', 'Initial published checklist — flagged as needing primary-source verification.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za8, 'Core Documents (Provisional)', 'Confirm before relying on this list.', 1);
SET @za8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@za8s1, 'Conference/Event Invitation Letter', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za8, 'Supporting Documents', 'Not independently confirmed this session.', 2);
SET @za8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(46, 8, NULL, 'INR', 'Confirmed After Assessment', 'Not independently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.dha.gov.za/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Conference category fully confirmed for South Africa?', 'Not yet — this category was only lightly sourced this session. Please confirm current requirements directly with VFS Global or the Department of Home Affairs before travel.', 46, 8, 4609, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Insufficiently Sourced, Flagged
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    46, 9, 'ZAF-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in South Africa.',
    'Only lightly sourced this session — likely processed under the same ETA/Visitor''s or Business Visa framework, but this was not separately, explicitly confirmed.',
    'Likely up to 90 days, pending confirmation',
    'Confirm current Sports-visa requirements directly with VFS Global or the Department of Home Affairs',
    1,
    'INSUFFICIENTLY SOURCED this session — do not rely on this content for fee or process details without independent confirmation',
    'VFS Global Visa Application Centres in India',
    'Confirm current Sports-visa requirements directly with VFS Global before travel\nCarry federation/tournament accreditation as supporting evidence regardless',
    '/assets/images/visa-heroes/south-africa.jpg',
    'INSUFFICIENTLY SOURCED this session — recommend direct confirmation with VFS Global or the Department of Home Affairs before relying on this content', 'https://www.dha.gov.za/', '2026-09-11'
);
SET @za9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@za9, '2026.09', 'Initial published checklist — flagged as needing primary-source verification.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za9, 'Core Documents (Provisional)', 'Confirm before relying on this list.', 1);
SET @za9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@za9s1, 'Sports Federation/Tournament Accreditation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za9, 'Supporting Documents', 'Not independently confirmed this session.', 2);
SET @za9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(46, 9, NULL, 'INR', 'Confirmed After Assessment', 'Not independently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.dha.gov.za/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Sports category fully confirmed for South Africa?', 'Not yet — this category was only lightly sourced this session. Please confirm current requirements directly with VFS Global or the Department of Home Affairs before travel.', 46, 9, 4610, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Insufficiently Sourced, Flagged
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    46, 10, 'ZAF-DEP-IN-10', '2026.09', 'published',
    'Spouse/children accompanying an Indian Work or Student visa holder in South Africa.',
    'Only lightly sourced this session — likely a Dependent/Relative''s Visa tied to the principal permit holder, consistent with standard South African immigration practice, but this was not separately, explicitly confirmed.',
    'Likely tied to the principal visa holder''s permit validity, pending confirmation',
    'Confirm current Dependent-visa requirements directly with VFS Global or the Department of Home Affairs',
    1,
    'INSUFFICIENTLY SOURCED this session — do not rely on this content for fee or process details without independent confirmation',
    'VFS Global Visa Application Centres in India',
    'Confirm current Dependent-visa requirements directly with VFS Global before applying\nGather documents proving the family relationship\nPrepare to file alongside or after the principal applicant''s visa',
    '/assets/images/visa-heroes/south-africa.jpg',
    'INSUFFICIENTLY SOURCED this session — recommend direct confirmation with VFS Global or the Department of Home Affairs before relying on this content', 'https://www.dha.gov.za/', '2026-09-11'
);
SET @za10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@za10, '2026.09', 'Initial published checklist — flagged as needing primary-source verification.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za10, 'Core Documents (Provisional)', 'Confirm before relying on this list.', 1);
SET @za10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@za10s1, 'Proof of Relationship to Principal Visa Holder', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@za10, 'Supporting Documents', 'Not independently confirmed this session.', 2);
SET @za10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@za10s2, 'Principal Applicant''s Visa Copy', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(46, 10, NULL, 'INR', 'Confirmed After Assessment', 'Not independently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.dha.gov.za/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Dependent category fully confirmed for South Africa?', 'Not yet — this category was only lightly sourced this session. Please confirm current requirements directly with VFS Global or the Department of Home Affairs before applying.', 46, 10, 4611, 1);
