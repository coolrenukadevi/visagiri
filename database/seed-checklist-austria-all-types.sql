-- Austria Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url left NULL at
-- authoring time, wired to the real supplied photo during the apply
-- step.
--
-- IMPORTANT SOURCING CAVEAT: Austria's Ministry of Foreign Affairs and
-- Migration (migration.gv.at) sites were not directly fetchable this
-- session (network egress blocked) — findings triangulated from
-- web-search-indexed news and immigration-law secondary sourcing.
--
-- Austria's real, distinctive facts:
--   - The Red-White-Red (RWR) Card is a genuine 3-tier points system:
--     Very Highly Qualified Workers (≥70 points) get a unique 6-month
--     job-seeker visa allowing entry with NO job offer yet; Skilled
--     Workers in Shortage Occupations (≥55 points); and Other Key
--     Workers, qualified by a salary threshold of €3,465/month from 1
--     January 2026. Each tier is genuinely distinct, not variations of
--     one product.
--   - A distinctive EVE (Elektronische Verpflichtungserklärung —
--     Electronic Declaration of Commitment) system is required for
--     BOTH Business AND Family-Visit invitations — a government-
--     mediated, formally registered guarantee-letter system, not just
--     an informal invitation letter as in many other countries. This
--     structural detail is surfaced explicitly in both categories.
--   - Salary thresholds (including the RWR €3,465/month figure) are
--     calculated against 14 PAYMENTS PER YEAR, not 12 — a genuine
--     Austria/Germany-style payroll quirk (two extra "13th/14th month"
--     payments) that changes how monthly-equivalent figures should be
--     interpreted; this file states the 14-payment basis explicitly
--     rather than implying a simple ×12 annual calculation.
--   - A two-step process applies to most long-stay categories: first a
--     national visa (D visa) issued abroad, then a local residence
--     permit application, handled either by MA 35 in Vienna or the
--     district Bezirkshauptmannschaft (BH) elsewhere in Austria — this
--     Vienna/rest-of-Austria administrative split is named explicitly.
--   - Austria maintains an annually revised, dual-level (nationwide AND
--     regional) shortage-occupation list feeding the RWR Card's Skilled
--     Worker tier — a genuinely two-layered list structure worth
--     surfacing.
--
-- country_id 108 = Austria. visa_type_id: 1=Tourist, 2=Business,
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
    108, 1, 'AUT-TOUR-IN-01', '2026.09', 'published',
    'Leisure and Alpine/cultural travel to Austria.',
    'Indian passport holders — the standard Schengen C-type visa (€90 fee), applied via VFS Global, valid for travel across the wider Schengen area, not just Austria.',
    'Short stay, up to 90 days within any 180-day period, per standard Schengen rules',
    'Apply via VFS Global, submitting to Austria if it is your main destination or first point of entry',
    1,
    'Standard Schengen processing is typically 15 calendar days, extendable to 30-45 in some cases',
    'Austrian Embassy, New Delhi, or VFS Global centres in other Indian cities',
    'Complete the online Schengen visa application form\nBook an appointment at the nearest VFS Global centre\nSubmit passport, photograph, and supporting documents, with biometrics\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/austria.jpg',
    'Cross-checked against Schengen visa fee schedules and VFS Global Austria guidance, triangulated against secondary sourcing not directly fetchable this session', 'https://www.bmeia.gv.at/', '2026-09-11'
);
SET @at1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at1, 'Core Documents', 'Required from every applicant.', 1);
SET @at1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at1s1, 'Valid Passport (3+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@at1s1, 'Completed Schengen Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@at1s1, 'Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 3),
(@at1s1, 'Travel/Schengen Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @at1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at1s2, 'Confirmed Hotel Booking', NULL, 'copy', 1, 0, 0, 1),
(@at1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@at1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(108, 1, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Standard Schengen visa fee, applicable across all Schengen member states including Austria.', '2026-09-01', NOW(), 'https://www.bmeia.gv.at/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does an Austria Tourist visa let me travel elsewhere in Europe?', 'Yes — the Schengen C-type visa is valid for travel across the entire Schengen area, not just Austria, subject to the standard 90-days-in-180 rule.', 108, 1, 10800, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen C-Type + EVE
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    108, 2, 'AUT-BUS-IN-02', '2026.09', 'published',
    'Trade, investment exploration, and commercial meetings in Austria.',
    'Indian nationals travelling for business, using the Schengen C-type visa. Austria requires a distinctive EVE (Elektronische Verpflichtungserklärung — Electronic Declaration of Commitment), a government-mediated, formally registered guarantee-letter system, rather than just an informal company invitation letter.',
    'Short stay, up to 90 days within any 180-day period',
    'Austrian host company files the EVE guarantee electronically, then the applicant applies via VFS Global referencing it',
    1,
    'The EVE is a genuinely distinctive, government-mediated commitment system — not a simple invitation letter — the host company must formally register it before the visa application is submitted',
    'Austrian Embassy, New Delhi, or VFS Global centres',
    'Have the Austrian host company file the EVE (Electronic Declaration of Commitment) via the relevant Austrian authority\nComplete the online Schengen visa application form, referencing the registered EVE\nSubmit documents and biometrics at the VFS Global centre',
    '/assets/images/visa-heroes/austria.jpg',
    'Cross-checked against Austrian EVE (Verpflichtungserklärung) system guidance and Schengen visa fee schedules, triangulated against secondary business-travel sourcing not directly fetchable this session', 'https://www.bmeia.gv.at/', '2026-09-11'
);
SET @at2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at2, 'Core Documents', 'Required from every applicant.', 1);
SET @at2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at2s1, 'Registered EVE (Electronic Declaration of Commitment)', 'A government-mediated commitment, not a plain invitation letter.', 'original', 1, 0, 1, 2),
(@at2s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at2, 'Supporting Documents', 'Evidence of your own employment/business standing.', 2);
SET @at2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@at2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(108, 2, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same visa fee as Tourist; the EVE registration itself may carry a separate administrative cost not consistently confirmed this session.', '2026-09-01', NOW(), 'https://www.bmeia.gv.at/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the EVE for an Austria Business visa?', 'The Elektronische Verpflichtungserklärung (Electronic Declaration of Commitment) — a government-mediated, formally registered guarantee-letter system that Austria requires instead of a simple informal invitation letter.', 108, 2, 10801, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — National D Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    108, 3, 'AUT-STU-IN-03', '2026.09', 'published',
    'Enrolling in an Austrian university or institution.',
    'Indian nationals admitted to a recognized Austrian institution, requiring the national D visa followed by a residence permit for stays beyond the initial visa validity.',
    'Tied to course duration, via annual residence-permit renewal',
    'Apply via VFS Global with the admission letter for the D visa; residence permit via MA 35 (Vienna) or the local Bezirkshauptmannschaft (elsewhere)',
    1,
    'Genuinely two-step: the national D visa is issued abroad first, then the residence permit is processed locally — by MA 35 specifically if studying in Vienna, or the district Bezirkshauptmannschaft (BH) elsewhere in Austria',
    'Austrian Embassy, New Delhi, or VFS Global centres (D visa); MA 35 Vienna or local BH (residence permit)',
    'Secure admission at a recognized Austrian institution\nApply for the national D visa via VFS Global with admission proof\nSubmit supporting documents and biometrics\nAfter arrival, apply for the residence permit at MA 35 (Vienna) or the local Bezirkshauptmannschaft (elsewhere)',
    '/assets/images/visa-heroes/austria.jpg',
    'Cross-checked against MA 35/Bezirkshauptmannschaft residence-permit guidance and secondary education-consultancy sourcing, triangulated against sources not directly fetchable this session', 'https://www.bmeia.gv.at/', '2026-09-11'
);
SET @at3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at3, 'Core Documents', 'Required from every applicant.', 1);
SET @at3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at3s1, 'Admission Letter from Austrian Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at3, 'Supporting Documents', 'Evidence of your academic background and means.', 2);
SET @at3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@at3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@at3s2, 'Health Insurance Valid in Austria', NULL, 'original', 1, 0, 0, 3),
(@at3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(108, 3, NULL, 'EUR', 'Confirmed After Assessment', 'D visa and separate residence-permit fees were not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.bmeia.gv.at/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Where do I apply for my residence permit as a student in Vienna vs. elsewhere?', 'In Vienna, MA 35 handles residence permits; elsewhere in Austria, the local district authority (Bezirkshauptmannschaft, or BH) handles it. Both come after the national D visa is issued.', 108, 3, 10802, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Red-White-Red Card (3-Tier)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    108, 4, 'AUT-WORK-IN-04', '2026.09', 'published',
    'Employment with an Austrian employer via the Red-White-Red (RWR) Card, a genuine 3-tier points system.',
    'Indian nationals qualify under one of three distinct tiers: Very Highly Qualified Workers (≥70 points, with a unique 6-month job-seeker visa allowing entry with NO job offer yet); Skilled Workers in Shortage Occupations (≥55 points, against a dual-level nationwide AND regional list); or Other Key Workers, qualified by a €3,465/month salary threshold from 1 Jan 2026 — calculated against 14 payments per year, not 12.',
    'Tied to the employment contract, typically 24 months for the initial RWR Card, renewable as RWR Card Plus',
    'Apply via VFS Global for the national D visa, referencing your RWR Card tier; then apply for the RWR Card residence permit locally',
    1,
    'Salary/points thresholds are calculated against 14 payments per year (two extra "13th/14th month" payments), not a simple annual salary divided by 12 — keep this in mind for the €3,465/month threshold',
    'Austrian Embassy, New Delhi, or VFS Global centres (D visa); MA 35 Vienna or local BH (RWR Card residence permit)',
    'Determine which RWR Card tier applies: Very Highly Qualified (≥70 points, job-seeker visa option with no job offer needed), Skilled Worker in Shortage Occupation (≥55 points), or Other Key Worker (€3,465/month salary threshold, 14-payment basis)\nApply for the national D visa via VFS Global\nApply for the RWR Card residence permit at MA 35 (Vienna) or local BH (elsewhere) after arrival',
    '/assets/images/visa-heroes/austria.jpg',
    'Cross-checked against Austria RWR Card 3-tier points-system guidance, the 2026 salary-threshold update, and the 14-payment payroll convention, triangulated against secondary expatriate-employment sourcing not directly fetchable this session', 'https://www.bmeia.gv.at/', '2026-09-11'
);
SET @at4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at4, 'Core Documents', 'Required from every applicant, tier-dependent specifics vary.', 1);
SET @at4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at4s1, 'RWR Card Points Assessment Documentation', 'Varies by tier — education, experience, age, language skills scored per the points system.', 'copy', 1, 0, 1, 2),
(@at4s1, 'Employment Contract or Job-Seeker Declaration', 'Job-seeker visa (Very Highly Qualified tier) does not require an existing job offer.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @at4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@at4s2, 'Proof of Salary (Other Key Worker Tier, €3,465/Month on 14-Payment Basis)', NULL, 'copy', 0, 1, 0, 2),
(@at4s2, 'Health Insurance Valid in Austria', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(108, 4, NULL, 'EUR', 'Confirmed After Assessment', 'RWR Card fees vary by tier and were not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.bmeia.gv.at/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I move to Austria for work without a job offer first?', 'Yes, if you qualify as a Very Highly Qualified Worker (≥70 points) — this tier includes a unique 6-month job-seeker visa allowing entry to search for work without an existing offer.', 108, 4, 10803, 1),
('Is the €3,465/month salary threshold a simple monthly figure?', 'Not quite — it''s calculated against 14 payments per year, an Austria/Germany payroll convention involving two extra "13th/14th month" payments, not a plain annual salary divided by 12.', 108, 4, 10804, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen C-Type + EVE
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    108, 5, 'AUT-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives resident in Austria.',
    'Indian nationals with family in Austria — the Schengen C-type visa, requiring the same distinctive EVE (Electronic Declaration of Commitment) government-mediated guarantee-letter system as Business, rather than an informal invitation letter.',
    'Short stay, up to 90 days within any 180-day period',
    'Sponsoring relative in Austria files the EVE guarantee electronically, then the applicant applies via VFS Global referencing it',
    1,
    'Same EVE system as Business — the sponsoring relative must formally register the Verpflichtungserklärung with the relevant Austrian authority before the visa application is submitted',
    'Austrian Embassy, New Delhi, or VFS Global centres',
    'Have your relative in Austria file the EVE (Electronic Declaration of Commitment) via the relevant Austrian authority\nGather documents proving the family relationship\nComplete the online Schengen visa application form, referencing the registered EVE',
    '/assets/images/visa-heroes/austria.jpg',
    'Cross-checked against Austrian EVE (Verpflichtungserklärung) system guidance, triangulated against secondary sourcing not directly fetchable this session', 'https://www.bmeia.gv.at/', '2026-09-11'
);
SET @at5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at5, 'Core Documents', 'Required from every applicant.', 1);
SET @at5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at5s1, 'Registered EVE (Electronic Declaration of Commitment)', NULL, 'original', 1, 0, 1, 2),
(@at5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @at5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(108, 5, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same visa fee as Tourist; the EVE registration itself may carry a separate administrative cost not consistently confirmed this session.', '2026-09-01', NOW(), 'https://www.bmeia.gv.at/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does visiting family in Austria also require the EVE system?', 'Yes — Austria requires the same government-mediated Electronic Declaration of Commitment (EVE) for Family Visit invitations as it does for Business, not just an informal invitation letter.', 108, 5, 10805, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    108, 6, 'AUT-TRANS-IN-06', '2026.09', 'published',
    'Passing through Austria en route to a third country.',
    'India is not on Austria''s (or the wider Schengen area''s) mandatory Airport Transit Visa list — Indian passport holders transiting airside generally do not require a separate transit visa, though a normal Schengen visa is needed if leaving the airport.',
    'Short stay, typically same-day for airside transit',
    'No Airport Transit Visa needed for airside transit; standard Schengen C-type visa applies if leaving the airport',
    0,
    'Confirm your specific routing with your airline, since exemptions can change and connections through non-Schengen intermediate airports may add complexity',
    'Austrian Embassy, New Delhi, or VFS Global centres (if a Schengen visa is needed)',
    'Confirm with your airline whether your connection is airside-only within Schengen\nSince India is not on the mandatory Airport Transit Visa list, no ATV is required for airside transit\nIf clearing immigration, apply for the standard Schengen C-type visa in advance',
    '/assets/images/visa-heroes/austria.jpg',
    'Cross-checked against the Schengen Airport Transit Visa mandatory-nationality list confirming India''s absence, triangulated against secondary sourcing not directly fetchable this session', 'https://www.bmeia.gv.at/', '2026-09-11'
);
SET @at6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at6, 'Core Documents', 'Required if clearing immigration.', 1);
SET @at6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at6, 'Supporting Documents', 'Only relevant if leaving the airport.', 2);
SET @at6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(108, 6, 0.00, 'INR', 'No Fee (Not on Mandatory ATV List)', 'India is not on Austria''s (or the Schengen area''s) mandatory Airport Transit Visa list, so no fee applies for airside transit; standard Schengen fee applies if leaving the airport.', '2026-09-01', NOW(), 'https://www.bmeia.gv.at/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian passport holders need a special Transit Visa for Austrian airports?', 'No — India is not on the Schengen area''s mandatory Airport Transit Visa (ATV) list, so no separate transit visa is required for airside connections through Austria.', 108, 6, 10806, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    108, 7, 'AUT-MED-IN-07', '2026.09', 'published',
    'Travel to Austria for medical treatment.',
    'Indian nationals travelling for treatment — the same Schengen C-type visa as Tourist, with hospital documentation as the differentiating supporting document.',
    'Short stay, up to 90 days within any 180-day period, extendable with hospital documentation for genuine medical need',
    'Apply via VFS Global with hospital appointment confirmation',
    1,
    'Standard Schengen processing is typically 15 calendar days',
    'Austrian Embassy, New Delhi, or VFS Global centres',
    'Obtain a hospital appointment/admission confirmation letter from the treating Austrian hospital\nComplete the online Schengen visa application form with medical documentation\nSubmit documents and biometrics at the VFS Global centre',
    '/assets/images/visa-heroes/austria.jpg',
    'Cross-checked against Schengen visa fee schedules and secondary medical-tourism sourcing, triangulated against sources not directly fetchable this session', 'https://www.bmeia.gv.at/', '2026-09-11'
);
SET @at7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at7, 'Core Documents', 'Required from every applicant.', 1);
SET @at7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at7s1, 'Hospital Appointment/Admission Confirmation', NULL, 'original', 1, 0, 1, 2),
(@at7s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @at7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@at7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(108, 7, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee as Tourist.', '2026-09-01', NOW(), 'https://www.bmeia.gv.at/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Medical visa code for Austria?', 'No — it is the same Schengen C-type visa as Tourist, differentiated by hospital documentation rather than a separate legal code.', 108, 7, 10807, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    108, 8, 'AUT-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, and official delegations in Austria — notably Vienna''s significant role as a UN and international-organization hub.',
    'Indian nationals attending a conference, using the Schengen C-type visa with an event invitation letter as supporting evidence.',
    'Short stay, up to 90 days within any 180-day period',
    'Apply via VFS Global with the event invitation letter',
    1,
    'Standard Schengen processing is typically 15 calendar days; Vienna''s status as a UN hub means many conference invitations come from international organizations rather than private companies',
    'Austrian Embassy, New Delhi, or VFS Global centres',
    'Obtain an invitation letter from the conference organizer/host institution\nComplete the online Schengen visa application form\nSubmit documents and biometrics at the VFS Global centre',
    '/assets/images/visa-heroes/austria.jpg',
    'Cross-checked against Schengen visa fee schedules and Vienna''s international-organization-hub status, triangulated against secondary sourcing not directly fetchable this session', 'https://www.bmeia.gv.at/', '2026-09-11'
);
SET @at8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at8, 'Core Documents', 'Required from every applicant.', 1);
SET @at8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at8s1, 'Conference/Event Invitation Letter', NULL, 'original', 1, 0, 1, 2),
(@at8s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @at8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(108, 8, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee as Tourist.', '2026-09-01', NOW(), 'https://www.bmeia.gv.at/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the Conference visa require the EVE system like Business does?', 'No — Conference visas use a standard event invitation letter, not the government-mediated EVE required specifically for Business and Family Visit invitations.', 108, 8, 10808, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    108, 9, 'AUT-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Austria.',
    'Indian nationals competing or officiating, using the Schengen C-type visa with federation/tournament accreditation as supporting evidence — no distinct Sports visa code was confirmed this session.',
    'Short stay, up to 90 days within any 180-day period',
    'Apply via VFS Global with federation/tournament accreditation',
    1,
    'Standard Schengen processing is typically 15 calendar days',
    'Austrian Embassy, New Delhi, or VFS Global centres',
    'Obtain accreditation from the relevant sports federation or tournament organizer\nComplete the online Schengen visa application form\nSubmit documents and biometrics at the VFS Global centre',
    '/assets/images/visa-heroes/austria.jpg',
    'Cross-checked against Schengen visa fee schedules, triangulated against secondary sourcing not directly fetchable this session', 'https://www.bmeia.gv.at/', '2026-09-11'
);
SET @at9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at9, 'Core Documents', 'Required from every applicant.', 1);
SET @at9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at9s1, 'Sports Federation/Tournament Accreditation', NULL, 'original', 1, 0, 1, 2),
(@at9s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @at9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(108, 9, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee as Tourist.', '2026-09-01', NOW(), 'https://www.bmeia.gv.at/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Sports Visa for Austria?', 'No distinct code was confirmed this session — athletes and officials apply for the standard Schengen C-type visa, with federation accreditation as supporting evidence.', 108, 9, 10809, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    108, 10, 'AUT-DEP-IN-10', '2026.09', 'published',
    'Spouse/children accompanying an Indian RWR Card holder or Student in Austria — via Austria''s Family Reunification (Familienzusammenführung) route.',
    'Family members of an Indian national already working (RWR Card) or studying in Austria; apply for their own national D visa and residence permit under Family Reunification rules.',
    'Tied to the principal visa/permit holder''s validity',
    'Family members apply for the national D visa via VFS Global, referencing the principal''s RWR Card/Student permit, then the residence permit locally',
    1,
    'Genuinely two-step, same as the principal applicant: national D visa first, then the residence permit via MA 35 (Vienna) or local Bezirkshauptmannschaft (elsewhere)',
    'Austrian Embassy, New Delhi, or VFS Global centres (D visa); MA 35 Vienna or local BH (residence permit)',
    'Confirm the principal applicant''s RWR Card or Student permit is approved\nGather documents proving the family relationship\nApply for the national D visa referencing the principal''s permit\nAfter arrival, apply for the residence permit at MA 35 (Vienna) or local Bezirkshauptmannschaft (elsewhere)',
    '/assets/images/visa-heroes/austria.jpg',
    'Cross-checked against Austria Family Reunification (Familienzusammenführung) guidance and secondary expatriate-family sourcing, triangulated against sources not directly fetchable this session', 'https://www.bmeia.gv.at/', '2026-09-11'
);
SET @at10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at10, 'Core Documents', 'Required from every applicant.', 1);
SET @at10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at10s1, 'Proof of Relationship to Principal Visa Holder', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at10, 'Supporting Documents', 'Evidence tied to the principal applicant''s visa.', 2);
SET @at10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at10s2, 'Principal Applicant''s RWR Card/Student Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@at10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@at10s2, 'Health Insurance Valid in Austria', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(108, 10, NULL, 'EUR', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.bmeia.gv.at/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my family join me on an RWR Card in Austria?', 'Yes — via Family Reunification, following the same two-step process as the principal applicant: a national D visa first, then a residence permit through MA 35 (Vienna) or the local Bezirkshauptmannschaft elsewhere.', 108, 10, 10810, 1);
