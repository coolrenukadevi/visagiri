-- Guatemala Visa Checklist Engine content for all 10 visa types —
-- built this session via web search. hero_image_url left NULL at
-- authoring time (no photo bundle supplied yet for this batch).
--
-- IMPORTANT SOURCING CAVEAT: the official Guatemalan sources —
-- guatemalainindia.com (Embassy of Guatemala in India), igm.gob.gt
-- (Instituto Guatemalteco de Migración), and indemguatemala.gov.in
-- (Embassy of India in Guatemala) — were all blocked by the network
-- egress proxy this session and could not be fetched directly.
-- Findings below are triangulated from web-search-indexed excerpts of
-- those same official pages plus Indian travel-agency aggregators
-- (Akbar Travels, SFRV Travels, Paradise Catchers) and immigration
-- explainer sites (livinginguatemala.com, BorderProof). Fee figures in
-- particular come from travel-agency listings, not a fetched official
-- tariff, and are flagged "(Travel-Agency Estimate)" throughout —
-- confirm exact amounts with the embassy before applying. No category
-- below could be fully verified against a primary Guatemalan
-- government source this session; treat all figures as best-effort
-- and independently reconfirm before publishing to end users.
--
-- Guatemala's real, distinctive facts (as found this session):
--   - Guatemala classifies foreign nationalities into three tiers:
--     Category A (visa-exempt, ~83 countries incl. USA/Canada/UK/EU),
--     Category B (consular visa, NO pre-consultation with Guatemala
--     City required — India falls in this tier), and Category C
--     ("visa consultado" — requires pre-approval from Guatemala City,
--     mostly African/Middle-Eastern nationalities). Being Category B
--     rather than C is a genuine, favorable distinction for Indian
--     applicants, reflected in the eligibility_summary fields below.
--   - Multiple Indian travel-agency sources report that Indian
--     travelers already holding a valid, used US, Canada, or Schengen
--     visa are commonly exempted from needing a separate Guatemala
--     visa for tourism (a regional reciprocity practice reported
--     across CA-4 members) — this could not be confirmed against an
--     official IGM/MINEX source this session and should be verified
--     before an applicant relies on it.
--   - Guatemala DOES maintain a resident Embassy in New Delhi
--     (F-2/3, Ground Floor, Vasant Vihar, New Delhi 110057), contrary
--     to an initial assumption that no resident mission exists; it
--     also lists honorary consulates in Mumbai, Kolkata, and Chennai.
--   - Per secondary reporting, the Embassy of Guatemala in India
--     stopped issuing CA-4 regional transit visas from 7 September
--     2015 following irregularities; no source found this session
--     confirms whether CA-4 visa issuance from India has since
--     resumed — applicants should ask the embassy directly for the
--     current CA-4 status rather than assume either way.
--   - The Work visa route is genuinely a two-step process distinct
--     from the short-stay Category B visa: a MINTRAB (Ministry of
--     Labour) labor clearance filed by the employer first (reported
--     30-60 days), followed by a separate IGM Temporary Residency
--     (Residencia Temporal) application (reported 30-90 days) — with
--     its own separate ~US$25 IGM application fee.
--   - Family reunification runs through a specifically named status,
--     "Residencia de Dependiente," open to spouses and children under
--     25 of a principal resident/visa holder, requiring apostilled
--     civil documents translated into Spanish by a certified
--     translator.
--
-- country_id 168 = Guatemala. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Category B Consular Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    168, 1, 'GTM-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Guatemala.',
    'Indian passport holders are a Category B nationality for Guatemala — a standard consular visa is required, but with no pre-consultation with Guatemala City (unlike Category C nationalities). Indians who already hold a valid, used US, Canada, or Schengen visa are commonly reported to be exempted from this requirement for tourism.',
    'Up to 90 days per entry; extendable once for a further 90 days',
    'Apply in person at the Embassy of Guatemala, New Delhi, or first confirm whether a valid US/Canada/Schengen visa already waives the requirement',
    1,
    'Reported range of 5-15 working days across sources; travel agencies commonly cite 7-14 business days',
    'Embassy of Guatemala, New Delhi (F-2/3, Vasant Vihar) — honorary consulates also listed in Mumbai, Kolkata and Chennai',
    'Check whether a valid US, Canada, or Schengen visa already waives the requirement\nIf not, book an appointment at the Embassy of Guatemala, New Delhi\nComplete the Category B visa application form\nSubmit passport, photos, and supporting documents\nCollect the passport with visa after processing',
    '/assets/images/visa-heroes/guatemala.webp',
    'Cross-checked against Guatemala''s Category A/B/C visa-policy tiering and Indian travel-agency secondary sourcing, triangulated against official sources not directly fetchable this session (guatemalainindia.com, igm.gob.gt blocked)', 'https://en.wikipedia.org/wiki/Visa_policy_of_Guatemala', '2026-09-17'
);
SET @gtm1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gtm1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm1, 'Core Documents', 'Required from every applicant.', 1);
SET @gtm1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm1s1, 'Valid Passport (6+ Months Validity)', 'Must have at least one blank visa page.', 'original', 1, 0, 1, 1),
(@gtm1s1, 'Completed Category B Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@gtm1s1, 'Passport-Size Photographs', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @gtm1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm1s2, 'Round-Trip/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@gtm1s2, 'Confirmed Hotel Booking', NULL, 'copy', 1, 0, 0, 2),
(@gtm1s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@gtm1s2, 'Copy of US/Canada/Schengen Visa (If Relying On It Instead)', 'If claiming the reported visa-exemption route.', 'if_applicable', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(168, 1, 78.00, 'USD', 'Category B Consular Visa Fee (Travel-Agency Estimate)', 'Indian travel-agency aggregators cite approx. Rs. 6,500 (~US$78); an official fetched fee schedule was not available this session — confirm the current figure with the embassy before applying.', '2026-09-01', NOW(), 'https://guatemalainindia.com/visas-category-b/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a Guatemala visa if I already hold a US or Schengen visa?', 'Multiple Indian travel-agency sources report that a valid, previously-used US, Canada, or Schengen visa commonly exempts Indian travelers from a separate Guatemala tourist visa. This could not be confirmed against an official Guatemalan government source this session — verify current eligibility with the Embassy of Guatemala, New Delhi before relying on it.', 168, 1, 16800, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Category B Consular Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    168, 2, 'GTM-BUS-IN-02', '2026.09', 'published',
    'Trade, meetings, and commercial activity in Guatemala.',
    'Indian nationals travelling for business use the same Category B consular visa as Tourist, differentiated by an invitation letter from the Guatemalan host company and proof of the applicant''s own employment/business standing in India.',
    'Up to 90 days per entry',
    'Apply in person at the Embassy of Guatemala, New Delhi, with a business invitation letter',
    1,
    'Reported range of 5-15 working days across sources',
    'Embassy of Guatemala, New Delhi (F-2/3, Vasant Vihar) — honorary consulates also listed in Mumbai, Kolkata and Chennai',
    'Obtain an invitation letter from the Guatemalan host company\nGather proof of your own employment or business registration in India\nBook an appointment at the Embassy of Guatemala, New Delhi\nSubmit the Category B application with supporting documents\nCollect the passport with visa after processing',
    '/assets/images/visa-heroes/guatemala.webp',
    'Cross-checked against Category B consular-visa secondary sourcing, triangulated against official sources not directly fetchable this session (guatemalainindia.com blocked)', 'https://guatemalainindia.com/visas-category-b/', '2026-09-17'
);
SET @gtm2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gtm2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm2, 'Core Documents', 'Required from every applicant.', 1);
SET @gtm2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gtm2s1, 'Invitation Letter from Guatemalan Host Company', NULL, 'original', 1, 0, 1, 2),
(@gtm2s1, 'Completed Category B Visa Application Form', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm2, 'Supporting Documents', 'Evidence of your own employment/business standing and means.', 2);
SET @gtm2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 0, 1, 0, 1),
(@gtm2s2, 'Business Registration Proof (If Self-Employed)', NULL, 'copy', 0, 1, 0, 2),
(@gtm2s2, 'International Credit Card or 6-Month Bank Statement', 'Commonly requested for Category B; a bank statement substitutes if only a debit card is held.', 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(168, 2, 86.00, 'USD', 'Category B Consular Visa Fee (Travel-Agency Estimate)', 'Indian travel-agency aggregators cite approx. Rs. 7,200 (~US$86); confirm the current figure with the embassy before applying.', '2026-09-01', NOW(), 'https://guatemalainindia.com/visas-category-b/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a Guatemala business visa require proof of funds like a credit card?', 'Per the embassy''s own Category B guidance, applicants are commonly asked to show an international credit card, or — if only a debit card is held — a six-month bank statement; a letter of invitation/service is additionally required for paid consultancy assignments.', 168, 2, 16801, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Category B (Study) / Temporary Residency
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    168, 3, 'GTM-STU-IN-03', '2026.09', 'published',
    'Enrolling in a recognized educational institution in Guatemala.',
    'Indian nationals admitted to a Guatemalan institution apply for a Category B visa endorsed for study, sufficient for programs of 90 days or less. Programs longer than three months reportedly require converting to Temporary Residency for Study (Residencia Temporal), typically granted for up to 2 years and renewable.',
    'Up to 90 days on the initial visa; Temporary Residency (up to 2 years, renewable) for longer programs',
    'Apply in person at the Embassy of Guatemala, New Delhi; longer programs require Temporary Residency via the IGM after arrival',
    1,
    'Reported 5-15 working days for the initial visa; IGM residency conversion reported separately at roughly 30-90 days',
    'Embassy of Guatemala, New Delhi (F-2/3, Vasant Vihar) — honorary consulates also listed in Mumbai, Kolkata and Chennai',
    'Secure admission and obtain a Constancia de Inscripcion (proof of enrollment) from the Guatemalan institution\nGather academic records and proof of funds\nBook an appointment at the Embassy of Guatemala, New Delhi\nSubmit the Category B application endorsed for study\nIf the program exceeds 3 months, register for Temporary Residency with the IGM after arrival',
    '/assets/images/visa-heroes/guatemala.webp',
    'Cross-checked against Guatemala Category B student-purpose and Temporary Residency secondary sourcing, triangulated against official sources not directly fetchable this session (guatemalainindia.com, igm.gob.gt blocked)', 'https://livinginguatemala.com/tramites/guatemala-residency/', '2026-09-17'
);
SET @gtm3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gtm3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm3, 'Core Documents', 'Required from every applicant.', 1);
SET @gtm3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gtm3s1, 'Constancia de Inscripcion (Proof of Enrollment)', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm3, 'Supporting Documents', 'Academic background, funds, and cover-letter evidence.', 2);
SET @gtm3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@gtm3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@gtm3s2, 'Cover Letter (Travel Dates, Purpose, Ties to India)', NULL, 'original', 1, 0, 0, 3),
(@gtm3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(168, 3, 95.00, 'USD', 'Category B Study-Purpose Visa Fee (Travel-Agency Estimate)', 'Indian travel-agency aggregators cite approx. Rs. 8,000 (~US$95) for the initial visa; a separate Temporary Residency conversion fee applies for programs over 3 months and was not itemized in sources found this session.', '2026-09-01', NOW(), 'https://guatemalainindia.com/visas-category-b/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need Temporary Residency for a short course in Guatemala?', 'Not necessarily — a Category B visa endorsed for study reportedly covers programs of 90 days or less. Only programs exceeding three months require converting to Temporary Residency for Study (Residencia Temporal) with the IGM after arrival.', 168, 3, 16802, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — MINTRAB Clearance + IGM Temporary Residency
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    168, 4, 'GTM-WORK-IN-04', '2026.09', 'published',
    'Employment with a Guatemalan employer via the two-step MINTRAB labor clearance and IGM Temporary Residency process.',
    'Indian nationals with a confirmed job offer from a registered Guatemalan employer. The employer first files a MINTRAB (Ministry of Labour) clearance (reported 30-60 days), after which the applicant applies for IGM Temporary Residency (Residencia Temporal), reported at a further 30-90 days.',
    'Temporary Work Residency typically valid 1 year, renewable',
    'Employer-driven two-step process: MINTRAB labor clearance, then IGM Temporary Residency; entry visa via the Embassy of Guatemala, New Delhi',
    1,
    'Reported combined range of roughly 60-150 days across the two stages (MINTRAB 30-60 days, then IGM 30-90 days) — notably longer than the short-stay Category B categories',
    'Embassy of Guatemala, New Delhi (entry visa); MINTRAB and IGM, Guatemala City (labor clearance and residency)',
    'Secure a job offer from a registered Guatemalan employer\nEmployer files a MINTRAB labor clearance (Resolucion de Permiso de Trabajo)\nApply for the Category B entry visa at the Embassy of Guatemala, New Delhi, if required\nTravel to Guatemala and apply for IGM Temporary Residency (Residencia Temporal)\nPay the IGM application fee and collect the residency card',
    '/assets/images/visa-heroes/guatemala.webp',
    'Cross-checked against MINTRAB/IGM two-step work-permit reporting from immigration-explainer sources, triangulated against official sources not directly fetchable this session (igm.gob.gt blocked)', 'https://livinginguatemala.com/visas-to-guatemala/work-permit-foreigners-guatemala/', '2026-09-17'
);
SET @gtm4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gtm4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm4, 'Core Documents', 'Required from every applicant.', 1);
SET @gtm4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gtm4s1, 'Employment Contract', 'Must be translated into Spanish and notarized.', 'copy', 1, 0, 1, 2),
(@gtm4s1, 'MINTRAB Labor Clearance (Resolucion de Permiso de Trabajo)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @gtm4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm4s2, 'Academic/Professional Certificates (CV and Diplomas)', NULL, 'copy', 1, 0, 0, 1),
(@gtm4s2, 'Proof of Financial Means', NULL, 'copy', 1, 0, 0, 2),
(@gtm4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 3),
(@gtm4s2, 'Valid Health Insurance', 'Compulsory for all work-visa applicants.', 'original', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(168, 4, NULL, 'USD', 'Confirmed After Assessment', 'Travel-agency aggregators cite an initial visa fee near Rs. 10,000 (~US$119); separately, the IGM Temporary Residency application fee is reported at approximately US$25 per the IGM tarifario, plus MINTRAB filing and Spanish translation/apostille costs not itemized in sources found this session — contact us to confirm the full cost stack.', '2026-09-01', NOW(), 'https://livinginguatemala.com/visas-to-guatemala/work-permit-foreigners-guatemala/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Guatemala work visa a single application?', 'No — it is a genuine two-step process: the employer files a MINTRAB labor clearance first, and only once that is granted does the applicant file a separate IGM Temporary Residency (Residencia Temporal) application, each with its own timeline and fee.', 168, 4, 16803, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Category B Consular Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    168, 5, 'GTM-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Guatemala.',
    'Indian nationals visiting family or friends use the same Category B consular visa as Tourist, with an invitation letter from the Guatemala-based host and proof of the relationship as the differentiating documents.',
    'Up to 90 days per entry',
    'Apply in person at the Embassy of Guatemala, New Delhi, with a host invitation letter and relationship proof',
    1,
    'Reported range of 5-15 working days across sources',
    'Embassy of Guatemala, New Delhi (F-2/3, Vasant Vihar) — honorary consulates also listed in Mumbai, Kolkata and Chennai',
    'Obtain an invitation letter from your host in Guatemala\nGather proof of the relationship (family record, correspondence, prior visit history)\nBook an appointment at the Embassy of Guatemala, New Delhi\nSubmit the Category B application with supporting documents\nCollect the passport with visa after processing',
    '/assets/images/visa-heroes/guatemala.webp',
    'Cross-checked against Category B consular-visa secondary sourcing, triangulated against official sources not directly fetchable this session (guatemalainindia.com blocked)', 'https://guatemalainindia.com/visas-category-b/', '2026-09-17'
);
SET @gtm5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gtm5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm5, 'Core Documents', 'Required from every applicant.', 1);
SET @gtm5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gtm5s1, 'Invitation Letter from Host in Guatemala', NULL, 'original', 1, 0, 1, 2),
(@gtm5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @gtm5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm5s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@gtm5s2, 'Round-Trip/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(168, 5, 78.00, 'USD', 'Category B Consular Visa Fee (Travel-Agency Estimate)', 'Same fee bracket as Tourist per travel-agency aggregators (approx. Rs. 6,500 / ~US$78); confirm the current figure with the embassy before applying.', '2026-09-01', NOW(), 'https://guatemalainindia.com/visas-category-b/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the Guatemala Family Visit invitation letter need notarization?', 'Sources found this session did not clearly confirm a notarization requirement for a simple host invitation letter — treat this as unconfirmed and check the current requirement with the Embassy of Guatemala, New Delhi before applying.', 168, 5, 16804, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Airport/Land Transit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    168, 6, 'GTM-TRAN-IN-06', '2026.09', 'published',
    'Passing through Guatemala, commonly via La Aurora International Airport (Guatemala City), en route to a third country.',
    'Because India is a Category B (non-exempt) nationality, Indian nationals who must clear Guatemalan immigration during a layover — rather than remaining airside for a same-terminal connection — reportedly still need a valid Category B visa. Requirements vary by airline and specific itinerary; confirm before booking.',
    'Limited to the transit/layover window',
    'Confirm with your airline whether your connection requires clearing Guatemalan immigration; if so, apply at the Embassy of Guatemala, New Delhi',
    1,
    'Not separately itemized by sources found this session; likely follows the standard Category B processing window if a visa is genuinely required',
    'Embassy of Guatemala, New Delhi (F-2/3, Vasant Vihar) — honorary consulates also listed in Mumbai, Kolkata and Chennai',
    'Confirm with your airline whether your itinerary requires clearing immigration at La Aurora International Airport\nIf required, apply for a Category B visa at the Embassy of Guatemala, New Delhi\nCarry your onward ticket and any visa required for your final destination\nAllow at least 2 hours for immigration and customs procedures if clearing immigration',
    '/assets/images/visa-heroes/guatemala.webp',
    'Cross-checked against general TWOV/layover guidance for La Aurora International Airport, triangulated against official sources not directly fetchable this session — this category is the least officially confirmed of the ten', 'https://visarequirements.io/transit-visa/guatemala', '2026-09-17'
);
SET @gtm6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gtm6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm6, 'Core Documents', 'Required if immigration clearance during transit is genuinely needed.', 1);
SET @gtm6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gtm6s1, 'Onward/Connecting Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @gtm6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(168, 6, NULL, 'USD', 'Confirmed After Assessment', 'No transit-specific fee schedule separate from the standard Category B visa fee was found this session; confirm with the embassy whether a distinct transit-visa fee applies to your itinerary.', '2026-09-01', NOW(), 'https://visarequirements.io/transit-visa/guatemala', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I skip Guatemalan immigration on a same-terminal layover?', 'Reportedly yes for a purely airside connection at La Aurora International Airport, but TWOV (transit-without-visa) allowances vary by airline and specific itinerary. This was NOT independently confirmed against an official Guatemalan source this session — always verify with your airline and the embassy before booking rather than assuming exemption.', 168, 6, 16805, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Category B Consular Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    168, 7, 'GTM-MED-IN-07', '2026.09', 'published',
    'Travel to Guatemala for medical treatment.',
    'Indian nationals travelling for treatment use the same Category B consular visa as Tourist, with a treating hospital/doctor''s certificate and proof of funds for treatment as the differentiating documents.',
    'Up to 90 days per entry',
    'Apply in person at the Embassy of Guatemala, New Delhi, with a medical certificate from the treating institution',
    1,
    'Reported range of 5-15 working days across sources',
    'Embassy of Guatemala, New Delhi (F-2/3, Vasant Vihar) — honorary consulates also listed in Mumbai, Kolkata and Chennai',
    'Obtain a certificate from the treating Guatemalan hospital/doctor confirming the need for treatment\nGather proof of funds for treatment and accommodation\nBook an appointment at the Embassy of Guatemala, New Delhi\nSubmit the Category B application with supporting documents\nCollect the passport with visa after processing',
    '/assets/images/visa-heroes/guatemala.webp',
    'Cross-checked against Category B consular-visa secondary sourcing; the medical-purpose documentary specifics were NOT independently confirmed against an official Guatemalan source this session', 'https://guatemalainindia.com/visas-category-b/', '2026-09-17'
);
SET @gtm7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gtm7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm7, 'Core Documents', 'Required from every applicant.', 1);
SET @gtm7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gtm7s1, 'Medical Certificate/Institution Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @gtm7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@gtm7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(168, 7, 78.00, 'USD', 'Category B Consular Visa Fee (Travel-Agency Estimate)', 'Same fee bracket as Tourist per travel-agency aggregators (approx. Rs. 6,500 / ~US$78); confirm the current figure with the embassy before applying.', '2026-09-01', NOW(), 'https://guatemalainindia.com/visas-category-b/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can a family member accompany me on a Guatemala Medical visa?', 'Sources found this session did not distinctly address an "attendant" category — an accompanying family member would most likely apply separately under the Tourist or Family Visit route with their own relationship/funds proof. NOT independently confirmed against an official Guatemalan source this session.', 168, 7, 16806, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Category B Consular Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    168, 8, 'GTM-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade events in Guatemala.',
    'Indian nationals attending a conference use the same Category B consular visa as Tourist/Business — Guatemala does not issue a separately named conference visa. A conference invitation or registration confirmation substitutes for a company invitation letter.',
    'Up to 90 days per entry',
    'Apply in person at the Embassy of Guatemala, New Delhi, with a conference invitation/registration confirmation',
    1,
    'Reported range of 5-15 working days across sources',
    'Embassy of Guatemala, New Delhi (F-2/3, Vasant Vihar) — honorary consulates also listed in Mumbai, Kolkata and Chennai',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nBook an appointment at the Embassy of Guatemala, New Delhi\nSubmit the Category B application with supporting documents\nCollect the passport with visa after processing',
    '/assets/images/visa-heroes/guatemala.webp',
    'Cross-checked against Category B consular-visa secondary sourcing, triangulated against official sources not directly fetchable this session (guatemalainindia.com blocked)', 'https://guatemalainindia.com/visas-category-b/', '2026-09-17'
);
SET @gtm8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gtm8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm8, 'Core Documents', 'Required from every applicant.', 1);
SET @gtm8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gtm8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @gtm8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@gtm8s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(168, 8, 86.00, 'USD', 'Category B Consular Visa Fee (Travel-Agency Estimate)', 'Same fee bracket as Business per travel-agency aggregators (approx. Rs. 7,200 / ~US$86); confirm the current figure with the embassy before applying.', '2026-09-01', NOW(), 'https://guatemalainindia.com/visas-category-b/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Conference and Business visas share the same application track in Guatemala?', 'Yes — Guatemala does not issue a distinct conference-visa type; Indian attendees apply through the same Category B consular-visa channel as Business travelers, with a conference invitation letter substituting for a company invitation.', 168, 8, 16807, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Category B Consular Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    168, 9, 'GTM-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Guatemala.',
    'Indian nationals competing or officiating use the same Category B consular visa as Tourist/Conference — Guatemala does not issue a separately named sports visa. A letter from the host event organizer/federation confirming participation is the key differentiating document.',
    'Up to 90 days per entry',
    'Apply in person at the Embassy of Guatemala, New Delhi, with an event/federation invitation letter',
    1,
    'Reported range of 5-15 working days across sources',
    'Embassy of Guatemala, New Delhi (F-2/3, Vasant Vihar) — honorary consulates also listed in Mumbai, Kolkata and Chennai',
    'Obtain a letter from the host event organizer/federation confirming your role and participation\nGather proof of accommodation and return travel\nBook an appointment at the Embassy of Guatemala, New Delhi\nSubmit the Category B application with supporting documents\nCollect the passport with visa after processing',
    '/assets/images/visa-heroes/guatemala.webp',
    'Cross-checked against Category B consular-visa secondary sourcing; the sports-specific documentary detail was NOT independently confirmed against an official Guatemalan source this session', 'https://guatemalainindia.com/visas-category-b/', '2026-09-17'
);
SET @gtm9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gtm9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm9, 'Core Documents', 'Required from every applicant.', 1);
SET @gtm9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gtm9s1, 'Host Event Organizer/Federation Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @gtm9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1),
(@gtm9s2, 'Home-Country Sports Association Letter', NULL, 'original', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(168, 9, 86.00, 'USD', 'Category B Consular Visa Fee (Travel-Agency Estimate)', 'Agency sources do not list a distinct sports-visa fee; shown here in the same bracket as Business/Conference (approx. Rs. 7,200 / ~US$86) — confirm the current figure with the embassy before applying.', '2026-09-01', NOW(), 'https://guatemalainindia.com/visas-category-b/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Guatemala Sports visa category?', 'No — Guatemala does not appear to issue a separately named sports visa; Indian athletes and officials apply through the same Category B consular-visa channel, using an event organizer or federation letter in place of a business invitation.', 168, 9, 16808, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Residencia de Dependiente
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    168, 10, 'GTM-DEP-IN-10', '2026.09', 'published',
    'Spouse or children under 25 joining an Indian national who holds Guatemalan work or study residency.',
    'Family members of an Indian principal resident (e.g., a Temporary Work Residency holder) apply for Residencia de Dependiente. Requires apostilled/legalized marriage or birth certificates translated into Spanish by a certified translator, plus proof of the principal''s own valid residency status.',
    'Tied to the principal resident''s Temporary Residency, commonly up to 1-2 years and renewable',
    'Apply through Guatemala''s Instituto Guatemalteco de Migracion (IGM), alongside or after the principal applicant''s residency approval',
    1,
    'Not separately itemized by sources found this session; likely follows the principal applicant''s IGM residency timeline, reported at roughly 30-90 days',
    'Embassy of Guatemala, New Delhi (entry visa, if needed); Instituto Guatemalteco de Migracion, Guatemala City (dependent residency)',
    'Confirm the principal applicant holds or is applying for Guatemalan Temporary Residency\nGather marriage/birth certificates, apostilled and translated into Spanish by a certified translator\nApply for the Category B entry visa at the Embassy of Guatemala, New Delhi, if required\nSubmit the Residencia de Dependiente application to the IGM, generally alongside the principal applicant\nCollect the dependent residency card',
    '/assets/images/visa-heroes/guatemala.webp',
    'Cross-checked against Residencia de Dependiente secondary reporting (BorderProof), triangulated against official sources not directly fetchable this session (igm.gob.gt blocked)', 'https://www.borderproof.com/visa/gt-dependent', '2026-09-17'
);
SET @gtm10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gtm10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm10, 'Core Documents', 'Required from every applicant.', 1);
SET @gtm10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gtm10s1, 'Proof of Relationship to Principal Applicant', 'Marriage or birth certificate, apostilled and translated into Spanish.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gtm10, 'Supporting Documents', 'Evidence tied to the principal applicant''s residency.', 2);
SET @gtm10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gtm10s2, 'Principal Applicant''s Temporary Residency Card Copy', NULL, 'copy', 1, 0, 0, 1),
(@gtm10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(168, 10, 115.35, 'GTQ', 'Ordinary Residency Visa Fee (Approximate)', 'Reported at GTQ 115.35 for a six-month ordinary residency visa and for each renewal — a modest registration-style fee separate from any initial Category B entry-visa fee; confirm the current figure and whether a distinct dependent-specific fee applies.', '2026-09-01', NOW(), 'https://www.liveandinvestoverseas.com/country-hub/guatemala/guatemala-visa-and-residency-information/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who qualifies as a dependent under Guatemala''s Residencia de Dependiente?', 'Per secondary sourcing, spouses and children under the age of 25 accompanying or joining a principal resident/visa holder qualify; each dependent reportedly pays their own fee but relies on the principal applicant''s supporting documentation.', 168, 10, 16809, 1);
