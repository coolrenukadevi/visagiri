-- Poland Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url left NULL at
-- authoring time, wired to the real supplied photo during the apply
-- step.
--
-- IMPORTANT SOURCING CAVEAT: Poland's e-konsulat portal and Ministry of
-- Foreign Affairs sites were not directly fetchable this session
-- (network egress blocked) — findings triangulated from web-search-
-- indexed news and immigration-law secondary sourcing.
--
-- Poland's real, distinctive facts:
--   - Poland uses the standard Schengen C-type visa (€90 fee) for
--     short-stay purposes (Tourist, Business, Family Visit, Conference,
--     Medical, Transit within Schengen rules), and the national D-type
--     visa for longer-stay purposes (Work, Study) — this file follows
--     that structural split rather than inventing separate codes for
--     each of the ten categories.
--   - D-type (national) visa fees were found to be disputed across
--     sources, with figures ranging €80-200 depending on category and
--     source — flagged explicitly rather than picking one figure with
--     false confidence.
--   - Poland has become the EU's #2 issuer of Blue Cards (the EU's
--     highly-skilled-worker permit), with a documented surge in Indian
--     IT-worker applications — a genuinely distinctive, dated fact.
--   - A real December 2025 work-permit-fee quadrupling took effect,
--     alongside a new mandatory online MOS II platform for 2026 that
--     employers must use — both dated, specific policy changes.
--   - India is explicitly NOT on Poland's (and the wider Schengen
--     area's) mandatory Airport Transit Visa (ATV) list — a genuinely
--     distinctive detail worth surfacing for the Transit category.
--   - Conference and Sports were both confirmed to have NO dedicated
--     visa codes in Poland's system — folded into the general C-type
--     "Others" purpose code — genuinely distinctive when compared
--     against India's own MHA system, which does have a formal
--     Conference Visa category; this contrast is noted explicitly.
--
-- country_id 139 = Poland. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    139, 1, 'POL-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Poland.',
    'Indian passport holders — the standard Schengen C-type visa (€90 fee), applied via VFS Global/e-konsulat, valid for travel across the wider Schengen area, not just Poland.',
    'Short stay, up to 90 days within any 180-day period, per standard Schengen rules',
    'Apply via VFS Global or e-konsulat, submitting to the Schengen country that is your main destination or first point of entry',
    1,
    'Standard Schengen processing is typically 15 calendar days, extendable to 30-45 in some cases',
    'Consulate General of Poland, New Delhi/Mumbai, or VFS Global centres',
    'Complete the online Schengen visa application form\nBook an appointment at the nearest VFS Global centre\nSubmit passport, photograph, and supporting documents, with biometrics\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/poland.jpg',
    'Cross-checked against Schengen visa fee schedules and VFS Global Poland guidance, triangulated against secondary sourcing not directly fetchable this session', 'https://www.gov.pl/', '2026-09-11'
);
SET @pl1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pl1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl1, 'Core Documents', 'Required from every applicant.', 1);
SET @pl1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl1s1, 'Valid Passport (3+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@pl1s1, 'Completed Schengen Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@pl1s1, 'Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 3),
(@pl1s1, 'Travel/Schengen Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @pl1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl1s2, 'Confirmed Hotel Booking', NULL, 'copy', 1, 0, 0, 1),
(@pl1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@pl1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(139, 1, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Standard Schengen visa fee, applicable across all Schengen member states including Poland.', '2026-09-01', NOW(), 'https://www.gov.pl/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a Poland Tourist visa let me travel elsewhere in Europe?', 'Yes — the Schengen C-type visa is valid for travel across the entire Schengen area, not just Poland, subject to the standard 90-days-in-180 rule.', 139, 1, 13900, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    139, 2, 'POL-BUS-IN-02', '2026.09', 'published',
    'Trade, investment exploration, and commercial meetings in Poland.',
    'Indian nationals travelling for business — the same Schengen C-type visa as Tourist, with a business invitation letter as the differentiating supporting document.',
    'Short stay, up to 90 days within any 180-day period',
    'Apply via VFS Global or e-konsulat with a business invitation letter',
    1,
    'Standard Schengen processing is typically 15 calendar days',
    'Consulate General of Poland, New Delhi/Mumbai, or VFS Global centres',
    'Obtain an invitation letter from the Polish host company\nComplete the online Schengen visa application form\nSubmit documents and biometrics at the VFS Global centre',
    '/assets/images/visa-heroes/poland.jpg',
    'Cross-checked against Schengen visa fee schedules and VFS Global Poland guidance, triangulated against secondary business-travel sourcing not directly fetchable this session', 'https://www.gov.pl/', '2026-09-11'
);
SET @pl2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pl2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl2, 'Core Documents', 'Required from every applicant.', 1);
SET @pl2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pl2s1, 'Invitation Letter from Polish Company', NULL, 'original', 1, 0, 1, 2),
(@pl2s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl2, 'Supporting Documents', 'Evidence of your own employment/business standing.', 2);
SET @pl2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@pl2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(139, 2, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee as Tourist — no separate Business rate under the Schengen system.', '2026-09-01', NOW(), 'https://www.gov.pl/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Business visa code for Poland?', 'No — Business travel uses the same Schengen C-type visa as Tourist, differentiated by the invitation letter and supporting documents.', 139, 2, 13901, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — National D-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    139, 3, 'POL-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Polish university or institution.',
    'Indian nationals admitted to a recognized Polish institution, requiring the national D-type visa for stays over 90 days.',
    'Tied to course duration, followed by a residence permit for stays beyond the initial D-visa validity',
    'Apply via VFS Global or e-konsulat with the institution''s admission letter',
    1,
    'D-type visa fees were found to be disputed across sources, ranging roughly €80-200 depending on category — confirm the current figure with VFS Global before applying',
    'Consulate General of Poland, New Delhi/Mumbai, or VFS Global centres',
    'Secure admission at a recognized Polish institution\nComplete the D-type visa application via VFS Global with admission proof\nSubmit supporting documents and biometrics\nApply for a residence permit (temporary residence card) after arrival if staying beyond the D-visa validity',
    '/assets/images/visa-heroes/poland.jpg',
    'Cross-checked against VFS Global D-type visa guidance and secondary education-consultancy sourcing, triangulated against sources not directly fetchable this session — D-type fee figures found disputed and flagged accordingly', 'https://www.gov.pl/', '2026-09-11'
);
SET @pl3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pl3, '2026.09', 'Initial published checklist — D-type fee dispute flagged.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl3, 'Core Documents', 'Required from every applicant.', 1);
SET @pl3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pl3s1, 'Admission Letter from Polish Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl3, 'Supporting Documents', 'Evidence of your academic background and means.', 2);
SET @pl3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@pl3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@pl3s2, 'Health Insurance Valid in Poland', NULL, 'original', 1, 0, 0, 3),
(@pl3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(139, 3, NULL, 'EUR', 'National D-Type Visa Fee (Disputed, ~€80-200)', 'Fee figures for the D-type Student visa were found disputed across sources this session, ranging roughly €80-200 — contact us to confirm the current figure.', '2026-09-01', NOW(), 'https://www.gov.pl/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How much does the Student D-type visa cost for Poland?', 'Sources genuinely disagree on this — figures found ranged roughly €80-200 depending on category. Confirm the current figure with VFS Global before applying.', 139, 3, 13902, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — National D-Type / EU Blue Card
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    139, 4, 'POL-WORK-IN-04', '2026.09', 'published',
    'Employment with a Polish employer, increasingly via the EU Blue Card for highly-skilled IT professionals — Poland has become the EU''s #2 Blue Card issuer, with a documented surge in Indian IT-worker applications.',
    'Indian nationals with a confirmed job offer, requiring the national D-type work visa, or the EU Blue Card for highly-skilled roles. A December 2025 work-permit-fee quadrupling took effect, alongside a new mandatory online MOS II platform for 2026 that employers must use.',
    'Tied to the employment contract, or up to 4 years for the EU Blue Card, renewable',
    'Employer files via the new mandatory MOS II online platform, then the employee applies for the D-type visa',
    1,
    'Two genuinely dated policy changes: a December 2025 quadrupling of work-permit fees, and a new mandatory online MOS II platform employers must use for 2026 filings — confirm current costs and process with your employer',
    'Consulate General of Poland, New Delhi/Mumbai, or VFS Global centres',
    'Employer secures the work permit or confirms Blue Card eligibility via the mandatory MOS II platform\nEmployee applies for the D-type visa via VFS Global, referencing the approved permit\nSubmit supporting documents and biometrics\nApply for a residence permit/Blue Card after arrival',
    '/assets/images/visa-heroes/poland.jpg',
    'Cross-checked against 2025-2026 Poland work-permit-fee and MOS II platform reporting, and EU Blue Card issuance-ranking news for Poland, triangulated against secondary expatriate-employment sourcing not directly fetchable this session', 'https://www.gov.pl/', '2026-09-11'
);
SET @pl4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pl4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl4, 'Core Documents', 'Required from every applicant.', 1);
SET @pl4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pl4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@pl4s1, 'Approved Work Permit/Blue Card Eligibility Confirmation', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @pl4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@pl4s2, 'Health Insurance Valid in Poland', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(139, 4, NULL, 'EUR', 'Confirmed After Assessment', 'Work-permit fees quadrupled under a December 2025 policy change — exact current figures not consistently confirmed this session, contact us to confirm.', '2026-09-01', NOW(), 'https://www.gov.pl/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Poland a common EU Blue Card destination for Indian IT workers?', 'Yes — Poland has become the EU''s #2 Blue Card issuer, with a documented surge in applications from Indian IT professionals.', 139, 4, 13903, 1),
('Did Poland''s work-permit fees change recently?', 'Yes — a December 2025 policy change quadrupled work-permit fees, alongside a new mandatory online MOS II platform that employers must use for 2026 filings.', 139, 4, 13904, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    139, 5, 'POL-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives resident in Poland.',
    'Indian nationals with family in Poland — the same Schengen C-type visa as Tourist, with a family invitation letter and proof of relationship as the differentiating supporting documents.',
    'Short stay, up to 90 days within any 180-day period',
    'Apply via VFS Global or e-konsulat with a family invitation letter and relationship proof',
    1,
    'Standard Schengen processing is typically 15 calendar days',
    'Consulate General of Poland, New Delhi/Mumbai, or VFS Global centres',
    'Obtain an invitation letter from your relative in Poland\nGather documents proving the family relationship\nComplete the online Schengen visa application form\nSubmit documents and biometrics at the VFS Global centre',
    '/assets/images/visa-heroes/poland.jpg',
    'Cross-checked against Schengen visa fee schedules and VFS Global Poland guidance, triangulated against secondary sourcing not directly fetchable this session', 'https://www.gov.pl/', '2026-09-11'
);
SET @pl5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pl5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl5, 'Core Documents', 'Required from every applicant.', 1);
SET @pl5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pl5s1, 'Invitation Letter from Relative in Poland', NULL, 'original', 1, 0, 1, 2),
(@pl5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3),
(@pl5s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @pl5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(139, 5, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee as Tourist.', '2026-09-01', NOW(), 'https://www.gov.pl/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Family Visit visa code for Poland?', 'No — it is the same Schengen C-type visa as Tourist, differentiated by the invitation letter and proof of relationship.', 139, 5, 13905, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — India Not on ATV List
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    139, 6, 'POL-TRANS-IN-06', '2026.09', 'published',
    'Passing through Poland en route to a third country.',
    'India is explicitly NOT on Poland''s (and the wider Schengen area''s) mandatory Airport Transit Visa (ATV) list — a genuinely distinctive detail. Indian passport holders transiting airside generally do not require a Schengen Transit Visa, though a normal Schengen visa is needed if leaving the airport.',
    'Short stay, typically same-day for airside transit',
    'No Airport Transit Visa needed given India is not on the mandatory ATV list; standard Schengen C-type visa applies if leaving the airport',
    0,
    'Confirm your specific routing with your airline, since ATV list exemptions can change and connections through non-Schengen intermediate airports may add complexity',
    'Consulate General of Poland, New Delhi/Mumbai, or VFS Global centres (if a Schengen visa is needed)',
    'Confirm with your airline whether your connection is airside-only within Schengen\nSince India is not on the mandatory Airport Transit Visa list, no ATV is required for airside transit\nIf clearing immigration, apply for the standard Schengen C-type visa in advance',
    '/assets/images/visa-heroes/poland.jpg',
    'Cross-checked against the Schengen Airport Transit Visa mandatory-nationality list confirming India''s absence, triangulated against secondary sourcing not directly fetchable this session', 'https://www.gov.pl/', '2026-09-11'
);
SET @pl6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pl6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl6, 'Core Documents', 'Required if clearing immigration.', 1);
SET @pl6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pl6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl6, 'Supporting Documents', 'Only relevant if leaving the airport.', 2);
SET @pl6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(139, 6, 0.00, 'INR', 'No Fee (Not on Mandatory ATV List)', 'India is explicitly not on Poland''s (or the Schengen area''s) mandatory Airport Transit Visa list, so no fee applies for airside transit; standard Schengen fee applies if leaving the airport.', '2026-09-01', NOW(), 'https://www.gov.pl/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian passport holders need a special Transit Visa for European airports?', 'No — India is explicitly not on the Schengen area''s mandatory Airport Transit Visa (ATV) list, so no separate transit visa is required for airside connections through Poland.', 139, 6, 13906, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    139, 7, 'POL-MED-IN-07', '2026.09', 'published',
    'Travel to Poland for medical treatment.',
    'Indian nationals travelling for treatment — the same Schengen C-type visa as Tourist, with hospital documentation as the differentiating supporting document.',
    'Short stay, up to 90 days within any 180-day period, extendable with hospital documentation for genuine medical need',
    'Apply via VFS Global or e-konsulat with hospital appointment confirmation',
    1,
    'Standard Schengen processing is typically 15 calendar days',
    'Consulate General of Poland, New Delhi/Mumbai, or VFS Global centres',
    'Obtain a hospital appointment/admission confirmation letter from the treating Polish hospital\nComplete the online Schengen visa application form with medical documentation\nSubmit documents and biometrics at the VFS Global centre',
    '/assets/images/visa-heroes/poland.jpg',
    'Cross-checked against Schengen visa fee schedules and secondary medical-tourism sourcing, triangulated against sources not directly fetchable this session', 'https://www.gov.pl/', '2026-09-11'
);
SET @pl7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pl7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl7, 'Core Documents', 'Required from every applicant.', 1);
SET @pl7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pl7s1, 'Hospital Appointment/Admission Confirmation', NULL, 'original', 1, 0, 1, 2),
(@pl7s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @pl7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@pl7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(139, 7, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee as Tourist; a fee waiver may apply in specific humanitarian medical cases per standard Schengen rules — confirm with the consulate.', '2026-09-01', NOW(), 'https://www.gov.pl/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Medical visa code for Poland?', 'No — it is the same Schengen C-type visa as Tourist, differentiated by hospital documentation rather than a separate legal code.', 139, 7, 13907, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — No Dedicated Code, "Others" Purpose
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    139, 8, 'POL-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, and official delegations in Poland.',
    'Poland has NO dedicated Conference visa code — confirmed this session — folded into the general Schengen C-type "Others" purpose code. This is genuinely distinctive when compared against India''s own MHA system, which does have a formal Conference Visa category.',
    'Short stay, up to 90 days within any 180-day period',
    'Apply via VFS Global or e-konsulat under the general C-type visa, selecting the closest matching purpose category, with an event invitation letter',
    1,
    'Poland has no dedicated Conference visa code, unlike India''s own MHA system — this genuine asymmetry is worth understanding before applying, since Poland processes this purpose under its general "Others" category',
    'Consulate General of Poland, New Delhi/Mumbai, or VFS Global centres',
    'Obtain an invitation letter from the conference organizer/host institution\nComplete the online Schengen C-type visa application, selecting the closest matching purpose\nSubmit documents and biometrics at the VFS Global centre',
    '/assets/images/visa-heroes/poland.jpg',
    'Cross-checked against Schengen visa-category guidance confirming Poland has no dedicated Conference code, contrasted explicitly against India''s own MHA Conference Visa category, triangulated against sources not directly fetchable this session', 'https://www.gov.pl/', '2026-09-11'
);
SET @pl8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pl8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl8, 'Core Documents', 'Required from every applicant.', 1);
SET @pl8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pl8s1, 'Conference/Event Invitation Letter', NULL, 'original', 1, 0, 1, 2),
(@pl8s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @pl8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(139, 8, 90.00, 'EUR', 'Schengen C-Type Visa Fee ("Others" Purpose)', 'Same fee as Tourist — no dedicated Conference-visa fee, since Poland has no distinct Conference visa code.', '2026-09-01', NOW(), 'https://www.gov.pl/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Poland have a dedicated Conference Visa like India does?', 'No — unlike India''s own MHA system, which has a formal Conference Visa category, Poland folds conference attendance into the general Schengen C-type "Others" purpose code.', 139, 8, 13908, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — No Dedicated Code, "Others" Purpose
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    139, 9, 'POL-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Poland.',
    'Poland has NO dedicated Sports visa code — confirmed this session — folded into the general Schengen C-type "Others" purpose code, same as Conference.',
    'Short stay, up to 90 days within any 180-day period',
    'Apply via VFS Global or e-konsulat under the general C-type visa, with federation/tournament accreditation as supporting evidence',
    1,
    'No dedicated Sports visa code exists — modeled under the same "Others" purpose category as Conference',
    'Consulate General of Poland, New Delhi/Mumbai, or VFS Global centres',
    'Obtain accreditation from the relevant sports federation or tournament organizer\nComplete the online Schengen C-type visa application, selecting the closest matching purpose\nSubmit documents and biometrics at the VFS Global centre',
    '/assets/images/visa-heroes/poland.jpg',
    'Cross-checked against Schengen visa-category guidance confirming Poland has no dedicated Sports code, triangulated against sources not directly fetchable this session', 'https://www.gov.pl/', '2026-09-11'
);
SET @pl9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pl9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl9, 'Core Documents', 'Required from every applicant.', 1);
SET @pl9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pl9s1, 'Sports Federation/Tournament Accreditation', NULL, 'original', 1, 0, 1, 2),
(@pl9s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @pl9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(139, 9, 90.00, 'EUR', 'Schengen C-Type Visa Fee ("Others" Purpose)', 'Same fee as Tourist — no dedicated Sports-visa fee, since Poland has no distinct Sports visa code.', '2026-09-01', NOW(), 'https://www.gov.pl/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports Visa for Poland?', 'No — Poland has no distinct Sports visa code. Athletes and officials apply under the general Schengen C-type visa''s "Others" purpose category.', 139, 9, 13909, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — National D-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    139, 10, 'POL-DEP-IN-10', '2026.09', 'published',
    'Spouse/children accompanying an Indian Work or Student D-type visa holder in Poland.',
    'Family members of an Indian national already working (D-type/Blue Card) or studying (D-type) in Poland; apply for their own D-type visa referencing the principal''s permit.',
    'Tied to the principal visa/permit holder''s validity',
    'Family members apply for the D-type visa via VFS Global, referencing the principal''s Work/Student permit',
    1,
    'D-type visa fees were found disputed across sources, ranging roughly €80-200 — confirm the current figure with VFS Global',
    'Consulate General of Poland, New Delhi/Mumbai, or VFS Global centres',
    'Confirm the principal applicant''s Work or Student D-type visa/permit is approved\nGather documents proving the family relationship\nApply for the D-type visa referencing the principal''s permit',
    '/assets/images/visa-heroes/poland.jpg',
    'Cross-checked against VFS Global D-type visa guidance and secondary expatriate-family sourcing, triangulated against sources not directly fetchable this session — D-type fee figures found disputed and flagged accordingly', 'https://www.gov.pl/', '2026-09-11'
);
SET @pl10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pl10, '2026.09', 'Initial published checklist — D-type fee dispute flagged.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl10, 'Core Documents', 'Required from every applicant.', 1);
SET @pl10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pl10s1, 'Proof of Relationship to Principal Visa Holder', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pl10, 'Supporting Documents', 'Evidence tied to the principal applicant''s visa.', 2);
SET @pl10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pl10s2, 'Principal Applicant''s Visa/Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@pl10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(139, 10, NULL, 'EUR', 'National D-Type Visa Fee (Disputed, ~€80-200)', 'Fee figures were found disputed across sources this session — contact us to confirm the current figure.', '2026-09-01', NOW(), 'https://www.gov.pl/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my family join me while I work or study in Poland?', 'Yes — they apply for their own D-type visa referencing your approved Work or Student permit, though exact fee figures vary across sources and should be confirmed directly.', 139, 10, 13910, 1);
