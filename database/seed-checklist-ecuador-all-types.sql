-- Ecuador Visa Checklist Engine content for all 10 visa types — built this
-- session via web search (WebSearch tool). Direct fetches of the primary
-- source, Ecuador's Cancillería / Ministry of Foreign Affairs & Human
-- Mobility (cancilleria.gob.ec) and its eVisa portal
-- (serviciosdigitales.cancilleria.gob.ec), were BLOCKED by the network
-- egress proxy this session (EGRESS_BLOCKED on cancilleria.gob.ec and
-- ecuapass.com). All findings below are triangulated from search-engine
-- snippets of secondary sources (visa agencies, immigration-law blogs,
-- expat guides) that themselves cite the Cancillería. Figures conflict
-- across sources more than usual for this content set — every disputed
-- figure is flagged inline, and three categories (Medical, Transit,
-- Sports) are flagged as NOT independently confirmed against a primary
-- government source this session.
--
-- Ecuador's real, distinctive facts (as found this session):
--   - Indian passport holders need a visa for Ecuador in virtually all
--     cases — there is no visa-free entry and no visa-on-arrival at any
--     Ecuadorian port of entry. The one reported exception: an Indian
--     citizen holding a valid, previously-used US visa or US Green Card
--     can reportedly enter Ecuador visa-free for up to 90 days — a
--     genuinely distinctive rule mirroring similar exceptions used by
--     Mexico and a few other Latin American states.
--   - Ecuador migrated to a government-run online eVisa portal
--     (serviciosdigitales.cancilleria.gob.ec) starting around July 2024,
--     letting applicants worldwide create an account, pick a visa
--     category, upload documents, and pay government fees online —
--     though residency-linked categories reportedly still require an
--     in-person appearance in Ecuador later for biometrics and the
--     cédula (national ID) appointment. No evidence surfaced this
--     session of Ecuador outsourcing to VFS Global or a similar
--     third-party visa-application centre in India, unlike many
--     European destinations — applications route directly through the
--     Embassy of Ecuador, New Delhi and/or the eVisa portal.
--   - Ecuador's fee model, as reported, separates a flat, non-refundable
--     USD 50 application fee (charged on submission, all categories)
--     from a category-specific grant fee charged only on approval
--     (reported figures: ~USD 270 for most temporary-residency
--     categories, USD 135 for applicants 65+, ~USD 80 for Student,
--     ~USD 320 for the employer-sponsored Work visa, ~USD 400 for
--     Digital Nomad/Corporate, ~USD 200 for Treaty/Mercosur routes).
--     Short-stay visitor-visa fee figures (Tourist/Business/Family
--     Visit/Conference/Sports) vary widely across secondary sources
--     (USD 20, USD 50, and USD 60/230 single/multiple-entry were all
--     cited) and are flagged as approximate throughout.
--   - Ecuador appears to run two distinct work-authorization pathways
--     for skilled foreigners: an employer-sponsored route requiring
--     Ministry of Labor authorization, and a separate "Professional"
--     (commonly cited as category 9-V) route for holders of a
--     university degree recognized by an Ecuadorian national
--     university, intended for independent professional practice
--     rather than salaried employment — a genuine structural distinction
--     reflected in the Work visa checklist below.
--   - The Dependent/"Amparo" family visa (commonly cited as category
--     9-VI) is explicitly NOT extended to parents of the sponsor —
--     only spouses/civil-union partners, minor children, and dependent
--     adult children with a certified disability qualify — and a
--     reform reported as occurring around October 2025 reportedly
--     reinforced a "family unity" principle across Ecuador's temporary
--     and permanent residency rules. This is reported by secondary
--     sources and is NOT independently confirmed against the primary
--     Cancillería text this session.
--   - An apostilled Indian Police Clearance Certificate (processed via
--     India's Ministry of External Affairs) is repeatedly cited as a
--     requirement across several Ecuadorian visa categories, not just
--     Work/residency routes — reflected as a conditional document
--     across multiple checklists below.
--
-- country_id 202 = Ecuador. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Temporary Visitor Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    202, 1, 'ECU-TOUR-IN-01', '2026.09', 'published',
    'Leisure, sightseeing, and recreational travel to Ecuador, including the Galápagos Islands.',
    'Indian passport holders require a visa for Ecuador in virtually all cases — there is no visa-on-arrival and no blanket exemption. One notable, repeatedly-cited exception: Indians holding a valid, previously-used US visa or US Green Card can reportedly enter Ecuador visa-free for up to 90 days.',
    'Up to 90 days per stay; sources disagree on whether the reference window is 180 days or 12 months',
    'Apply online via the Cancillería eVisa portal (serviciosdigitales.cancilleria.gob.ec) or directly at the Embassy of Ecuador, New Delhi',
    1,
    'Reported 3-10 working days via the eVisa portal; some secondary sources instead cite 2-4 weeks — treat as approximate and apply well ahead of travel',
    'Embassy of Ecuador, New Delhi (E-3/2, Vasant Vihar, New Delhi 110057); visa services Monday-Thursday by prior appointment',
    'Register on the Cancillería eVisa portal or contact the Embassy of Ecuador, New Delhi for an appointment\nComplete the online application and upload scanned documents\nPay the government application fee\nAttend an interview/biometrics appointment if requested\nAwait a decision and collect or download the visa',
    '/assets/images/visa-heroes/ecuador.webp',
    'Cross-checked against Cancillería (Ecuador MFA) portal content reflected in visa-agency secondary sourcing; cancilleria.gob.ec blocked from direct fetch this session — figures triangulated and flagged approximate', 'https://www.cancilleria.gob.ec', '2026-09-17'
);
SET @ecu1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ecu1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu1, 'Core Documents', 'Required from every applicant.', 1);
SET @ecu1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu1s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@ecu1s1, 'Passport-Size Photographs', NULL, 'original', 1, 0, 1, 2),
(@ecu1s1, 'Completed eVisa Application Form', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @ecu1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@ecu1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 2),
(@ecu1s2, 'Proof of Funds (Reported Min. USD 1,500 or USD 50/Day)', NULL, 'copy', 1, 0, 0, 3),
(@ecu1s2, 'Police Clearance Certificate (Apostilled via MEA)', 'Reported requirement for Indian nationals in several sources; confirm current applicability for short tourist stays.', 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(202, 1, NULL, 'USD', 'Confirmed After Assessment', 'Secondary sources cite conflicting figures — USD 20, USD 50 (the general Cancillería application fee), and USD 60/230 for single/multiple entry — treat all as approximate and confirm with the Embassy of Ecuador before applying.', '2026-09-01', NOW(), 'https://www.cancilleria.gob.ec', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do all Indian passport holders need a visa to visit Ecuador?', 'Yes, in virtually all cases — Ecuador does not offer visa-on-arrival to Indian nationals. The one repeatedly-cited exception is for Indians holding a valid, previously-used US visa or US Green Card, who can reportedly enter Ecuador visa-free for up to 90 days.', 202, 1, 20200, 1),
('Can I apply for an Ecuador tourist visa fully online?', 'Reportedly yes, via the Cancillería eVisa portal (serviciosdigitales.cancilleria.gob.ec), which lets you create an account, upload documents, and pay online — though you should confirm with the Embassy of Ecuador, New Delhi whether an in-person step is also required for your case.', 202, 1, 20201, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Temporary Visitor Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    202, 2, 'ECU-BUS-IN-02', '2026.09', 'published',
    'Business meetings, negotiations, seminars, and short-term commercial visits to Ecuador.',
    'Indian business travellers apply for the same temporary-visitor visa category as Tourist, differentiated by a company invitation letter from the Ecuadorian host and a forwarding letter from the Indian employer; it does not authorize local employment or salary payment in Ecuador.',
    'Up to 90 days per stay, as a temporary-visitor visa',
    'Apply online via the Cancillería eVisa portal or directly at the Embassy of Ecuador, New Delhi, with a business invitation letter',
    1,
    'Reported 3-10 working days via the eVisa portal; can extend if documentation is incomplete',
    'Embassy of Ecuador, New Delhi (E-3/2, Vasant Vihar, New Delhi 110057); visa services Monday-Thursday by prior appointment',
    'Obtain an invitation letter from the Ecuadorian host company\nGather the Indian employer''s forwarding/sponsorship letter\nRegister on the Cancillería eVisa portal or contact the Embassy of Ecuador, New Delhi\nSubmit documents and pay the government fee\nAttend an interview/biometrics appointment if requested',
    '/assets/images/visa-heroes/ecuador.webp',
    'Cross-checked against Cancillería (Ecuador MFA) portal content reflected in visa-agency secondary sourcing; cancilleria.gob.ec blocked from direct fetch this session', 'https://www.cancilleria.gob.ec', '2026-09-17'
);
SET @ecu2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ecu2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu2, 'Core Documents', 'Required from every applicant.', 1);
SET @ecu2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ecu2s1, 'Business Invitation Letter from Ecuadorian Host Company', NULL, 'original', 1, 0, 1, 2),
(@ecu2s1, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu2, 'Supporting Documents', 'Evidence of the Ecuadorian host and your own means.', 2);
SET @ecu2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu2s2, 'Ecuadorian Host Company Registration Proof', NULL, 'copy', 0, 1, 0, 1),
(@ecu2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2),
(@ecu2s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(202, 2, NULL, 'USD', 'Confirmed After Assessment', 'Reported in the same USD 20-60 range as Tourist across secondary sources — confirm the current figure with the Embassy of Ecuador before applying.', '2026-09-01', NOW(), 'https://www.cancilleria.gob.ec', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the Ecuador Business visa let me take up paid local employment?', 'No — it is a short-term visitor visa for meetings, negotiations, and commercial activity. Salaried employment in Ecuador requires the separate Work visa route.', 202, 2, 20202, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Temporary Resident Student Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    202, 3, 'ECU-STU-IN-03', '2026.09', 'published',
    'Full-time enrollment in a recognized Ecuadorian university or educational institution.',
    'Indian nationals admitted to a full-time program at an institution legally recognized by Ecuador''s national education authority. The visa is reported to be valid for 1 year and renewable annually for the duration of the program.',
    'Valid 1 year, renewable annually for the course duration',
    'Apply online via the Cancillería eVisa portal (serviciosdigitales.cancilleria.gob.ec) with the institution''s admission letter',
    1,
    'Reported total government fee near USD 130 (application plus issuance); processing time not independently confirmed this session — apply well ahead of the academic term',
    'Embassy of Ecuador, New Delhi (E-3/2, Vasant Vihar, New Delhi 110057); visa services Monday-Thursday by prior appointment',
    'Secure admission at a recognized Ecuadorian institution\nRegister on the Cancillería eVisa portal\nGather proof of funds, health insurance, and an apostilled police clearance certificate\nSubmit the application and pay government fees online\nAttend any requested interview/biometrics and await the decision',
    '/assets/images/visa-heroes/ecuador.webp',
    'Cross-checked against Cancillería (Ecuador MFA) portal content reflected in visa-agency and study-abroad secondary sourcing; cancilleria.gob.ec blocked from direct fetch this session', 'https://www.cancilleria.gob.ec', '2026-09-17'
);
SET @ecu3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ecu3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu3, 'Core Documents', 'Required from every applicant.', 1);
SET @ecu3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ecu3s1, 'Admission/Enrollment Certificate from Ecuadorian Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @ecu3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@ecu3s2, 'Proof of Funds (Reported Min. Approx. USD 500)', NULL, 'copy', 1, 0, 0, 2),
(@ecu3s2, 'Health Insurance Valid in Ecuador', NULL, 'original', 1, 0, 0, 3),
(@ecu3s2, 'Police Clearance Certificate (Apostilled via MEA, Last 5 Years'' Residence)', NULL, 'original', 1, 0, 0, 4),
(@ecu3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 5);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(202, 3, 130.00, 'USD', 'Student Visa Government Fee (Application + Issuance, Approximate)', 'One source cites a combined total near USD 130; another cites an USD 80 issuance fee on top of the general USD 50 application fee. Excludes apostille/translation costs — confirm the current figure before applying.', '2026-09-01', NOW(), 'https://www.cancilleria.gob.ec', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work while studying in Ecuador on a Student visa?', 'Reported guidance allows part-time, study-linked activity, but paid employment is described as requiring a separate work permit — confirm current rules with the Embassy of Ecuador before taking on any paid work.', 202, 3, 20203, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Employer-Sponsored / Professional (9-V)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    202, 4, 'ECU-WORK-IN-04', '2026.09', 'published',
    'Employment with an Ecuadorian employer, or independent practice of a recognized profession in Ecuador.',
    'Indian nationals follow one of two reported pathways: an employer-sponsored route requiring Ministry of Labor authorization, or a "Professional" route (commonly cited as category 9-V) for holders of a university degree recognized by an Ecuadorian national university. Requirements and fees differ between the two.',
    'Employer-sponsored work visas reported valid around 2 years, renewable; the Professional route is tied to general temporary-residency terms',
    'Employer-driven application via the Cancillería eVisa portal, with Ministry of Labor authorization required for the employer-sponsored route',
    1,
    'Government fee reported near USD 320 for the employer-sponsored route; timelines not independently confirmed this session — confirm directly with the Embassy of Ecuador',
    'Embassy of Ecuador, New Delhi (E-3/2, Vasant Vihar, New Delhi 110057); visa services Monday-Thursday by prior appointment',
    'Secure a job offer from an Ecuadorian employer, or establish eligibility under the Professional (9-V) route\nFor the employer-sponsored route, the employer obtains Ministry of Labor authorization\nRegister on the Cancillería eVisa portal and submit the application\nPay government fees and attend any requested interview/biometrics\nCollect the visa and complete residency-linked formalities in Ecuador if applicable',
    '/assets/images/visa-heroes/ecuador.webp',
    'Cross-checked against Cancillería (Ecuador MFA) portal content reflected in employer-of-record and visa-agency secondary sourcing; cancilleria.gob.ec blocked from direct fetch this session', 'https://www.cancilleria.gob.ec', '2026-09-17'
);
SET @ecu4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ecu4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu4, 'Core Documents', 'Required documents differ by pathway.', 1);
SET @ecu4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ecu4s1, 'Employment Contract (Employer-Sponsored Route)', NULL, 'copy', 0, 1, 1, 2),
(@ecu4s1, 'Ministry of Labor Authorization (Employer-Sponsored Route)', NULL, 'copy', 0, 1, 1, 3),
(@ecu4s1, 'Recognized University Degree, Locally Certified (Professional/9-V Route)', NULL, 'both', 0, 1, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @ecu4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu4s2, 'Police Clearance Certificate (Apostilled via MEA)', NULL, 'original', 1, 0, 0, 1),
(@ecu4s2, 'Proof of Financial Means', NULL, 'copy', 1, 0, 0, 2),
(@ecu4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(202, 4, NULL, 'USD', 'Confirmed After Assessment', 'Reported near USD 320 for the employer-sponsored route by one source, and INR 15,600-23,400 (roughly USD 185-280) across visa subtypes by another — figures vary by pathway and are not reconciled; confirm before applying.', '2026-09-01', NOW(), 'https://www.cancilleria.gob.ec', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Are there different types of Ecuador work visa for Indians?', 'Reportedly yes — an employer-sponsored route requiring Ministry of Labor authorization for salaried employment, and a separate Professional route (commonly cited as category 9-V) for degree-holders practicing their profession independently. Confirm which applies to your situation with the Embassy of Ecuador.', 202, 4, 20204, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Temporary Visitor Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    202, 5, 'ECU-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or close family who reside in Ecuador, without seeking Ecuadorian residency.',
    'Indian nationals visiting family travel on a temporary-visitor visa — distinct from the residency-linked Dependent ("Amparo") visa — requiring an invitation letter from the host relative plus documentary proof of the family relationship.',
    'Up to 90 days per stay, as a temporary-visitor visa',
    'Apply online via the Cancillería eVisa portal or directly at the Embassy of Ecuador, New Delhi, with a relative''s invitation letter',
    1,
    'Reported 3-10 working days via the eVisa portal; some secondary sources instead cite 2-4 weeks',
    'Embassy of Ecuador, New Delhi (E-3/2, Vasant Vihar, New Delhi 110057); visa services Monday-Thursday by prior appointment',
    'Obtain an invitation letter from your host relative in Ecuador\nGather documents proving the family relationship\nRegister on the Cancillería eVisa portal or contact the Embassy of Ecuador, New Delhi\nSubmit documents and pay the government fee\nAttend an interview/biometrics appointment if requested',
    '/assets/images/visa-heroes/ecuador.webp',
    'Cross-checked against Cancillería (Ecuador MFA) portal content reflected in visa-agency secondary sourcing; cancilleria.gob.ec blocked from direct fetch this session', 'https://www.cancilleria.gob.ec', '2026-09-17'
);
SET @ecu5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ecu5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu5, 'Core Documents', 'Required from every applicant.', 1);
SET @ecu5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ecu5s1, 'Invitation Letter from Host Relative in Ecuador', NULL, 'original', 1, 0, 1, 2),
(@ecu5s1, 'Proof of Family Relationship (Birth/Marriage Certificates)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu5, 'Supporting Documents', 'Evidence of your own means and travel plans.', 2);
SET @ecu5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@ecu5s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(202, 5, NULL, 'USD', 'Confirmed After Assessment', 'Reported in the same USD 20-60 range as Tourist across secondary sources — confirm the current figure with the Embassy of Ecuador before applying.', '2026-09-01', NOW(), 'https://www.cancilleria.gob.ec', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What''s the difference between the Family Visit visa and the Dependent visa?', 'Family Visit is a short-term temporary-visitor visa for visiting relatives without seeking residency. The Dependent ("Amparo") visa is a separate, residency-linked category for spouses, minor children, and qualifying dependents who intend to live in Ecuador alongside a resident or citizen sponsor.', 202, 5, 20205, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Airside Transit / General Visitor Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    202, 6, 'ECU-TRAN-IN-06', '2026.09', 'published',
    'Passing through an Ecuadorian airport (e.g. Quito, Guayaquil) toward a connecting destination.',
    'A visa is reported as generally NOT required for Indian passport holders who remain airside within the international transit zone during a connection. A full Ecuadorian visitor visa is required only if leaving that zone or clearing immigration. NOT independently confirmed this session whether Ecuador operates a distinct, separately-named transit-visa product.',
    'Limited to the connection window while remaining airside',
    'No separate application if staying airside; otherwise apply for the relevant visitor visa via the eVisa portal or Embassy of Ecuador, New Delhi',
    1,
    'Category structure not independently confirmed this session — confirm with your airline and the Embassy of Ecuador before booking any layover requiring you to leave the transit zone',
    'Embassy of Ecuador, New Delhi (E-3/2, Vasant Vihar, New Delhi 110057); visa services Monday-Thursday by prior appointment',
    'Confirm with your airline whether your specific connection requires leaving the international transit zone\nIf you must clear immigration, apply for the appropriate Ecuadorian visitor visa in advance\nCarry your onward ticket and any visa required for your final destination',
    '/assets/images/visa-heroes/ecuador.webp',
    'Cross-checked against secondary visa-agency sourcing on airside transit; NOT independently confirmed against the primary Cancillería source this session (cancilleria.gob.ec blocked from direct fetch)', 'https://www.cancilleria.gob.ec', '2026-09-17'
);
SET @ecu6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ecu6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu6, 'Core Documents', 'Required if you must leave the international transit zone.', 1);
SET @ecu6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ecu6s1, 'Onward/Connecting Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @ecu6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(202, 6, NULL, 'USD', 'Not Applicable (Airside Transit)', 'No fee applies if you remain airside within the international transit zone. If you must leave the zone and clear immigration, the fee for the relevant visitor visa applies instead — not independently confirmed this session.', '2026-09-01', NOW(), 'https://www.cancilleria.gob.ec', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa for a layover in Ecuador?', 'Reportedly no, if you remain airside within the international transit zone. If your connection requires you to clear immigration or leave the transit zone, you would need the relevant Ecuadorian visitor visa — confirm with your airline and the Embassy of Ecuador for your specific routing.', 202, 6, 20206, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — General Temporary Visitor Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    202, 7, 'ECU-MED-IN-07', '2026.09', 'published',
    'Travel to Ecuador to receive medical treatment.',
    'Ecuador does not appear to operate a separately-named "Medical" visa category (NOT independently confirmed this session) — Indian nationals travelling for treatment are expected to apply for the general temporary-visitor visa, documenting the medical purpose with a letter from the treating institution.',
    'Up to 90 days per stay, as a temporary-visitor visa',
    'Apply online via the Cancillería eVisa portal or directly at the Embassy of Ecuador, New Delhi, with medical documentation',
    1,
    'Category structure and processing times not independently confirmed this session — contact the Embassy of Ecuador, New Delhi directly to confirm the correct visa type for medical travel',
    'Embassy of Ecuador, New Delhi (E-3/2, Vasant Vihar, New Delhi 110057); visa services Monday-Thursday by prior appointment',
    'Obtain a letter from the treating Ecuadorian doctor/hospital confirming the need for treatment\nArrange travel/medical insurance\nApply for the general temporary-visitor visa via the eVisa portal or Embassy of Ecuador\nSubmit documents and attend any requested interview',
    '/assets/images/visa-heroes/ecuador.webp',
    'Category existence and structure NOT independently confirmed against the primary Cancillería source this session (cancilleria.gob.ec blocked from direct fetch); treated as a documented-purpose variant of the general visitor visa pending confirmation', 'https://www.cancilleria.gob.ec', '2026-09-17'
);
SET @ecu7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ecu7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu7, 'Core Documents', 'Required from every applicant.', 1);
SET @ecu7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ecu7s1, 'Medical Certificate/Treating-Institution Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @ecu7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@ecu7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(202, 7, NULL, 'USD', 'Confirmed After Assessment', 'No dedicated Medical-visa fee schedule surfaced this session — likely the general temporary-visitor visa fee applies; contact the Embassy of Ecuador to confirm.', '2026-09-01', NOW(), 'https://www.cancilleria.gob.ec', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Ecuador have a dedicated Medical visa category?', 'NOT independently confirmed this session — no separately-named Medical visa category surfaced in research. Indian nationals travelling for treatment appear to apply for the general temporary-visitor visa with medical documentation; confirm the correct category with the Embassy of Ecuador before applying.', 202, 7, 20207, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Temporary Visitor Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    202, 8, 'ECU-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, and academic or professional events in Ecuador.',
    'Indian nationals attending a conference are expected to travel on the same temporary-visitor visa category as Business. Secondary sourcing groups Business, Conference, and academic-event travel together under one overlapping visitor-visa checklist — NOT independently confirmed against the primary Cancillería source this session.',
    'Up to 90 days per stay, as a temporary-visitor visa',
    'Apply online via the Cancillería eVisa portal or directly at the Embassy of Ecuador, New Delhi, with a conference invitation',
    1,
    'Reported 3-10 working days via the eVisa portal; category overlap with Business not independently confirmed this session',
    'Embassy of Ecuador, New Delhi (E-3/2, Vasant Vihar, New Delhi 110057); visa services Monday-Thursday by prior appointment',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nRegister on the Cancillería eVisa portal or contact the Embassy of Ecuador, New Delhi\nSubmit documents and pay the government fee\nAttend an interview/biometrics appointment if requested',
    '/assets/images/visa-heroes/ecuador.webp',
    'Cross-checked against visa-agency secondary sourcing describing an overlapping Business/Conference visitor-visa checklist; NOT independently confirmed against the primary Cancillería source this session (cancilleria.gob.ec blocked from direct fetch)', 'https://www.cancilleria.gob.ec', '2026-09-17'
);
SET @ecu8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ecu8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu8, 'Core Documents', 'Required from every applicant.', 1);
SET @ecu8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ecu8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @ecu8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@ecu8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(202, 8, NULL, 'USD', 'Confirmed After Assessment', 'Reported in the same USD 20-60 range as Tourist/Business across secondary sources — confirm the current figure with the Embassy of Ecuador before applying.', '2026-09-01', NOW(), 'https://www.cancilleria.gob.ec', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Conference visa a separate category from Business?', 'Secondary sourcing suggests they share the same underlying temporary-visitor visa and documentary checklist, distinguished mainly by the invitation letter (conference registration vs. business invitation) — NOT independently confirmed against the primary Cancillería source this session.', 202, 8, 20208, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Temporary Visitor Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    202, 9, 'ECU-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments or events hosted in Ecuador.',
    'Sports travel is expected to route through the same temporary-visitor visa category as Business/Conference, typically requiring a letter from the host event organizer and, commonly, a letter from the athlete''s home sporting federation. NOT independently confirmed against the primary Cancillería source this session.',
    'Up to 90 days per stay, as a temporary-visitor visa',
    'Apply online via the Cancillería eVisa portal or directly at the Embassy of Ecuador, New Delhi, with an event invitation',
    1,
    'Category structure not independently confirmed this session — confirm directly with the Embassy of Ecuador, New Delhi for team/delegation applications',
    'Embassy of Ecuador, New Delhi (E-3/2, Vasant Vihar, New Delhi 110057); visa services Monday-Thursday by prior appointment',
    'Obtain an invitation letter from the host event organizer with event and expense details\nObtain a letter from your home-country sports federation confirming your role\nRegister on the Cancillería eVisa portal or contact the Embassy of Ecuador, New Delhi\nSubmit documents and pay the government fee\nAttend an interview/biometrics appointment if requested',
    '/assets/images/visa-heroes/ecuador.webp',
    'Structure inferred from the general temporary-visitor visa pattern used for Business/Conference; NOT independently confirmed against the primary Cancillería source this session (cancilleria.gob.ec blocked from direct fetch)', 'https://www.cancilleria.gob.ec', '2026-09-17'
);
SET @ecu9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ecu9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu9, 'Core Documents', 'Required from every applicant.', 1);
SET @ecu9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ecu9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @ecu9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu9s2, 'Home-Country Sports Federation Letter', 'Confirms athlete role and no-employment status.', 'original', 0, 1, 0, 1),
(@ecu9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(202, 9, NULL, 'USD', 'Confirmed After Assessment', 'No dedicated Sports-visa fee schedule surfaced this session — likely the general temporary-visitor visa fee applies; confirm with the Embassy of Ecuador before applying, especially for group/delegation bookings.', '2026-09-01', NOW(), 'https://www.cancilleria.gob.ec', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Ecuador have a dedicated visa category for athletes and sports delegations?', 'NOT independently confirmed this session — no separately-named Sports visa category surfaced in research. Delegations appear to apply through the general temporary-visitor visa with an event invitation letter; confirm the correct process with the Embassy of Ecuador, especially for group bookings.', 202, 9, 20209, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Economic Dependence / "Amparo" Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    202, 10, 'ECU-DEP-IN-10', '2026.09', 'published',
    'Spouse, minor children, or qualifying dependent family joining an Ecuadorian resident or citizen sponsor (Economic Dependence / "Amparo" visa, commonly cited as category 9-VI).',
    'Family members of an Indian national holding a qualifying Ecuadorian residency visa, or family of an Ecuadorian citizen. Eligible dependents reportedly include spouses/civil-union partners, minor children, and disabled adult children; parents of the sponsor are generally NOT eligible. A reform reported around October 2025 reinforced a "family unity" principle in Ecuadorian migration policy.',
    'Tied to the sponsor''s residency visa validity',
    'Apply online via the Cancillería eVisa portal, tied to the principal sponsor''s visa/residency file',
    1,
    'Sponsor reportedly must show additional income of roughly USD 250/month per dependent; adult dependents may reportedly apply separately for their own work authorization',
    'Embassy of Ecuador, New Delhi (E-3/2, Vasant Vihar, New Delhi 110057); visa services Monday-Thursday by prior appointment',
    'Confirm the sponsor holds a qualifying Ecuadorian residency visa or citizenship\nGather relationship proof (marriage/birth certificates, apostilled) and the sponsor''s visa/ID copy\nRegister on the Cancillería eVisa portal and submit the dependent application\nDemonstrate the sponsor''s additional income for each dependent\nSubmit documents, attend any requested interview, and await the decision',
    '/assets/images/visa-heroes/ecuador.webp',
    'Cross-checked against Cancillería (Ecuador MFA) portal content reflected in expat/immigration-law secondary sourcing, including a reported October 2025 family-unity reform; cancilleria.gob.ec blocked from direct fetch this session', 'https://www.cancilleria.gob.ec', '2026-09-17'
);
SET @ecu10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ecu10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu10, 'Core Documents', 'Required from every applicant.', 1);
SET @ecu10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ecu10s1, 'Proof of Relationship to Sponsor (Apostilled)', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ecu10, 'Supporting Documents', 'Evidence tied to the sponsor''s status and income.', 2);
SET @ecu10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ecu10s2, 'Sponsor''s Ecuadorian Visa/Cédula Copy', NULL, 'copy', 1, 0, 0, 1),
(@ecu10s2, 'Proof of Sponsor''s Additional Income (Reported ~USD 250/Month per Dependent)', NULL, 'copy', 1, 0, 0, 2),
(@ecu10s2, 'Police Clearance Certificate (Apostilled, Adult Dependents)', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(202, 10, 270.00, 'USD', 'Dependent (Amparo) Visa Government Fee (Approximate)', 'Reported near the general USD 270 temporary-residency grant fee (USD 135 for applicants 65+ under other categories), on top of the general USD 50 application fee — confirm current figures with the Embassy of Ecuador before applying.', '2026-09-01', NOW(), 'https://www.cancilleria.gob.ec', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can parents of the visa holder be sponsored on Ecuador''s Dependent visa?', 'Reportedly no — the Economic Dependence ("Amparo") category generally covers spouses/civil-union partners, minor children, and disabled adult children, but not parents of the sponsor. Parents would need to qualify for their own separate visa category.', 202, 10, 20210, 1),
('Can Dependent visa holders work in Ecuador?', 'Reported guidance suggests adult dependents can seek employment, but only after applying for a separate work authorization — the Dependent visa itself does not automatically grant work rights. Confirm current rules with the Embassy of Ecuador.', 202, 10, 20211, 1);
