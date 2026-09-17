-- Iceland Visa Checklist Engine content for all 10 visa types — built this
-- session via web search (WebFetch direct fetches were blocked by the
-- network egress proxy for every Icelandic/VFS/agency domain tried:
-- btwvisas.com, work.iceland.is, visa.government.is, island.is all
-- returned EGRESS_BLOCKED). Everything below is triangulated from
-- WebSearch-indexed snippets of government.is, island.is,
-- work.iceland.is, visa.vfsglobal.com, and secondary visa-agency
-- sourcing, NOT from a direct primary-source read this session.
-- hero_image_url left NULL at authoring time (no photo bundle supplied).
--
-- IMPORTANT CORRECTION TO THE BRIEFED ASSUMPTION: Iceland DOES have its
-- own Embassy in New Delhi (opened 26 Feb 2006; also accredited to
-- Australia, Nepal, New Zealand and Sri Lanka) — it is not routed
-- through a neighbouring Nordic embassy. Short-stay Schengen
-- applications are lodged via VFS Global's India network (VFS holds
-- Iceland's outsourcing contract) with the Embassy of Iceland, New
-- Delhi as decision authority. Long-stay residence-permit applications
-- (Student/Work/Dependent) are NOT submitted via VFS or the New Delhi
-- embassy at all — they go directly, on paper, by post (or a Reykjavik
-- drop-box) to the Directorate of Immigration (Útlendingastofnun) in
-- Iceland. This split is reflected in each category's
-- application_method/consular_office fields below.
--
-- Iceland's genuinely distinctive/notable facts verified this session:
--   - A new Icelandic Visa Act (enacted ~12 May 2026) modernised
--     Schengen short-stay visa rules and moved visa-issuance
--     responsibility from the Directorate of Immigration to the
--     Ministry for Foreign Affairs — a mid-2026 institutional change.
--   - Separately, Foreign Nationals Act amendments took effect 8 July
--     2026, transferring WORK-PERMIT processing from the Directorate of
--     Labour (Vinnumálastofnun) to the Directorate of Immigration —
--     work permits and residence permits are now handled by a single
--     authority, a genuine and recent consolidation.
--   - Indian passport holders are explicitly NOT on Iceland's Schengen
--     Annex III list of nationalities requiring a Type A Airport
--     Transit Visa — unlike Pakistan, Bangladesh, Sri Lanka, Iran, Iraq,
--     Afghanistan and others on that list, Indians may transit
--     airside through Keflavík without any transit visa at all.
--   - Iceland's Student residence permit has fixed intake application
--     deadlines reported as 1 June (fall semester) and 1 November
--     (spring semester) — a hard scheduling constraint distinct from a
--     generic rolling-processing model.
--   - Specialist/university-educated work-permit roles are reportedly
--     exempt from the standard Labour Market Test that otherwise
--     requires the employer to prove no EEA/EFTA candidate is
--     available.
--   - Sourcing conflicts flagged honestly rather than resolved by
--     guesswork: the work-permit government fee is cited as both ISK
--     15,000 and ISK 80,000 across sources (not reconciled this
--     session); the Indian-applicant refusal/approval rate is cited
--     inconsistently (one figure implies ~84% approval, another cites
--     94%) and is NOT used as a stated statistic below; student
--     residence-permit processing is cited as both "6-12 weeks" and
--     "2-4 months".
--
-- country_id 123 = Iceland. visa_type_id: 1=Tourist, 2=Business,
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
    123, 1, 'ISL-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Iceland, including the Golden Circle, Ring Road, and Northern Lights viewing.',
    'Indian passport holders — a standard Schengen C-type visa valid for travel across the wider Schengen area, not just Iceland. No visa-on-arrival or eVisa exists for Indian citizens.',
    'Single or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global India; decision made by the Embassy of Iceland, New Delhi',
    1,
    'Standard Schengen processing is around 15 calendar days after transfer from VFS to the embassy; extendable to 30 or 60 days if extra documents or Directorate consultation are needed',
    'Embassy of Iceland, New Delhi (decision authority), via VFS Global centres across India',
    'Book a VFS Global appointment at your nearest of ~15 Indian city centres\nComplete the online Schengen visa application form\nGather supporting documents and Schengen-compliant travel insurance\nAttend the appointment and submit biometrics (mandatory for first-time applicants)\nTrack status and collect your passport',
    '/assets/images/visa-heroes/iceland.webp',
    'Triangulated from WebSearch-indexed government.is, island.is, and VFS Global/visa-agency secondary sourcing; direct fetches of government.is/island.is/VFS pages were blocked this session', 'https://www.government.is/diplomatic-missions/embassy-of-iceland-in-new-delhi/visa-to-iceland/', '2026-09-17'
);
SET @isl1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@isl1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl1, 'Core Documents', 'Required from every applicant.', 1);
SET @isl1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl1s1, 'Valid Passport (3+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@isl1s1, 'Completed Schengen Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@isl1s1, 'Schengen Travel Medical Insurance (Min. EUR 30,000 Coverage)', 'Must cover accident, illness, medical evacuation and repatriation across the whole Schengen area for the full trip duration.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @isl1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl1s2, 'Confirmed Hotel/Accommodation Booking', NULL, 'copy', 1, 0, 0, 1),
(@isl1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@isl1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@isl1s2, 'Day-Wise Travel Itinerary', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(123, 1, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'EUR 90 for adults, EUR 45 for children aged 6-11; a separate VFS Global service charge (reported around INR 2,900) also applies and is non-refundable.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/one-pager/iceland/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Iceland have its own embassy in India?', 'Yes — the Embassy of Iceland, New Delhi has operated since February 2006 and is also accredited to Australia, Nepal, New Zealand and Sri Lanka. Applications are lodged via VFS Global centres across India, with the embassy as decision authority.', 123, 1, 12300, 1),
('Does an Iceland Tourist visa let me travel elsewhere in Europe?', 'Yes — it is a standard Schengen C-type visa valid for travel across the entire Schengen area, not just Iceland, subject to the 90-days-in-180 rule.', 123, 1, 12301, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    123, 2, 'ISL-BUS-IN-02', '2026.09', 'published',
    'Trade meetings, negotiations, and commercial visits to Icelandic companies.',
    'Indian nationals travelling for business — the same Schengen C-type visa as Tourist, differentiated by a company invitation letter and employer sponsorship documentation.',
    'Single, double, or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global India with a business invitation letter; decision by the Embassy of Iceland, New Delhi',
    1,
    'Standard Schengen processing is around 15 calendar days after transfer from VFS to the embassy, extendable in complex cases',
    'Embassy of Iceland, New Delhi (decision authority), via VFS Global centres across India',
    'Obtain an invitation letter from the Icelandic host company\nGather an Indian employer sponsorship/forwarding letter\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/iceland.webp',
    'Triangulated from WebSearch-indexed government.is and VFS Global/visa-agency secondary sourcing; direct fetches were blocked this session', 'https://www.government.is/diplomatic-missions/embassy-of-iceland-in-new-delhi/visa-to-iceland/', '2026-09-17'
);
SET @isl2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@isl2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl2, 'Core Documents', 'Required from every applicant.', 1);
SET @isl2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@isl2s1, 'Invitation Letter from Icelandic Host Company', NULL, 'original', 1, 0, 1, 2),
(@isl2s1, 'Schengen Travel Medical Insurance (Min. EUR 30,000 Coverage)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @isl2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@isl2s2, 'Business Registration Proof', NULL, 'copy', 0, 1, 0, 2),
(@isl2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(123, 2, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate non-refundable VFS Global service charge.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/one-pager/iceland/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Business visa a different visa category from Tourist?', 'No — it is the same underlying Schengen C-type visa; what changes is the supporting documentation, principally the host-company invitation letter and employer sponsorship letter.', 123, 2, 12310, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Residence Permit for Studies
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    123, 3, 'ISL-STU-IN-03', '2026.09', 'published',
    'Full-time enrolment at a recognised Icelandic university or institution.',
    'Indian nationals admitted to recognised full-time study, usually at university level, in Iceland. Requires a residence permit for students, evidencing admission, funds, housing, and health insurance.',
    'Tied to the study programme duration, renewed as required',
    'Apply directly to the Directorate of Immigration in Reykjavik by post/drop-box — NOT via VFS Global or the New Delhi embassy',
    1,
    'Reported as 2-4 months from a complete application; some sources cite 6-12 weeks instead — timelines are inconsistently reported, so apply well ahead of the 1 June (fall) / 1 November (spring) intake deadlines',
    'Directorate of Immigration (Útlendingastofnun), Reykjavik',
    'Secure admission at a recognised Icelandic institution\nGather proof of funds, housing, and health insurance valid in Iceland\nComplete the paper residence-permit application form\nPay the processing fee and post the original application (or use the Reykjavik drop-box) to the Directorate of Immigration\nCollect the permit/visa sticker and travel; register upon arrival in Iceland',
    '/assets/images/visa-heroes/iceland.webp',
    'Triangulated from WebSearch-indexed island.is Directorate of Immigration pages and secondary visa-guide sourcing; direct fetches were blocked this session — processing-time figures conflict across sources and are flagged as such', 'https://island.is/en/residence-permit-students', '2026-09-17'
);
SET @isl3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@isl3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl3, 'Core Documents', 'Required from every applicant.', 1);
SET @isl3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@isl3s1, 'Confirmed Admission Letter from Icelandic Institution', NULL, 'original', 1, 0, 1, 2),
(@isl3s1, 'Completed Residence Permit Application Form', 'Must be submitted in original paper form, not electronically.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl3, 'Supporting Documents', 'Evidence of your academic background, funds, housing and health cover.', 2);
SET @isl3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@isl3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2),
(@isl3s2, 'Proof of Housing/Accommodation in Iceland', NULL, 'copy', 1, 0, 0, 3),
(@isl3s2, 'Health Insurance Valid in Iceland', NULL, 'original', 1, 0, 0, 4),
(@isl3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 5);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(123, 3, 12000.00, 'ISK', 'Student Residence Permit Processing Fee (Approximate)', 'Reported at approximately ISK 12,000; confirm the current figure directly with the Directorate of Immigration before applying.', '2026-09-01', NOW(), 'https://island.is/en/residence-permit-students', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a deadline to apply for an Iceland student residence permit?', 'Reported intake deadlines are 1 June for the fall semester and 1 November for the spring semester — apply well before these dates given processing can run 2-4 months.', 123, 3, 12320, 1),
('Do I submit my student residence permit application through VFS Global?', 'No — unlike short-stay Schengen visas, Iceland residence permit applications (including Student) must be submitted in original paper form directly to the Directorate of Immigration in Reykjavik, by post or its reception drop-box.', 123, 3, 12321, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Residence Permit Based on Work
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    123, 4, 'ISL-WORK-IN-04', '2026.09', 'published',
    'Employment with an Icelandic employer under a residence permit based on work.',
    'Indian nationals with a confirmed job offer; the employer must generally pass a Labour Market Test proving no EEA/EFTA candidate is available, though specialist/university-educated roles are reportedly exempt. Since 8 July 2026, work-permit processing sits solely with the Directorate of Immigration, no longer split with the Directorate of Labour.',
    'Initial permit typically valid up to the contract/permit term, renewable, with a path toward an unlimited permit after 3 years per some sources',
    'Employer-initiated; applicant applies directly to the Directorate of Immigration in Reykjavik — NOT via VFS Global or the New Delhi embassy',
    1,
    'Reported timelines vary widely, from 4-8 weeks to 8-10 months end-to-end — treat as unresolved and confirm current timing, especially given the July 2026 processing-authority change',
    'Directorate of Immigration (Útlendingastofnun), Reykjavik',
    'Secure a job offer from an Icelandic employer\nEmployer completes the Labour Market Test (unless the role is specialist/exempt)\nEmployer and applicant jointly apply to the Directorate of Immigration for the combined residence-and-work permit\nAttend biometrics/interview as required\nReceive the permit, travel, and register upon arrival in Iceland',
    '/assets/images/visa-heroes/iceland.webp',
    'Triangulated from WebSearch-indexed work.iceland.is, island.is, and employer-of-record/immigration-law secondary sourcing; direct fetches were blocked this session — the government fee figure is inconsistently reported and flagged below', 'https://work.iceland.is/working/residence-permit/', '2026-09-17'
);
SET @isl4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@isl4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl4, 'Core Documents', 'Required from every applicant.', 1);
SET @isl4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@isl4s1, 'Employment Contract (Icelandic Collective-Agreement Compliant)', NULL, 'copy', 1, 0, 1, 2),
(@isl4s1, 'Labour Market Test Confirmation', 'Not required for specialist/university-educated roles, per current reporting.', 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @isl4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@isl4s2, 'Proof of Financial Means', NULL, 'copy', 1, 0, 0, 2),
(@isl4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 3),
(@isl4s2, 'Health Insurance Valid in Iceland', NULL, 'original', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(123, 4, NULL, 'ISK', 'Confirmed After Assessment', 'Government fee is inconsistently reported across sources — figures of both ISK 15,000 and ISK 80,000 appear; not reconciled this session, contact us or the Directorate of Immigration to confirm.', '2026-09-01', NOW(), 'https://work.iceland.is/working/residence-permit/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do all Icelandic work-permit roles need a Labour Market Test?', 'Reportedly no — specialist roles requiring university-level education are exempt from the standard Labour Market Test that otherwise requires the employer to prove no EEA/EFTA candidate is suitably available.', 123, 4, 12330, 1),
('Which authority now processes Iceland work permits?', 'Since Foreign Nationals Act amendments took effect on 8 July 2026, work-permit processing moved from the Directorate of Labour to the Directorate of Immigration, which now handles both residence and work permits together.', 123, 4, 12331, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    123, 5, 'ISL-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Iceland for a short stay.',
    'Indian nationals with family or friends in Iceland — the same Schengen C-type visa as Tourist, requiring an invitation letter from the host plus proof of the relationship. Distinct from the Dependent category, which is a long-stay residence permit for joining a sponsor permanently.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global India with an invitation letter and relationship proof; decision by the Embassy of Iceland, New Delhi',
    1,
    'Standard Schengen processing is around 15 calendar days after transfer from VFS to the embassy',
    'Embassy of Iceland, New Delhi (decision authority), via VFS Global centres across India',
    'Obtain an invitation letter from your host in Iceland\nGather documents proving the family or personal relationship\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/iceland.webp',
    'Triangulated from WebSearch-indexed government.is and VFS Global/visa-agency secondary sourcing; direct fetches were blocked this session', 'https://www.government.is/diplomatic-missions/embassy-of-iceland-in-new-delhi/visa-to-iceland/', '2026-09-17'
);
SET @isl5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@isl5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl5, 'Core Documents', 'Required from every applicant.', 1);
SET @isl5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@isl5s1, 'Invitation Letter from Host in Iceland', NULL, 'original', 1, 0, 1, 2),
(@isl5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @isl5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@isl5s2, 'Schengen Travel Medical Insurance (Min. EUR 30,000 Coverage)', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(123, 5, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate non-refundable VFS Global service charge.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/one-pager/iceland/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the difference between Family Visit and Dependent visas for Iceland?', 'Family Visit is a short-stay (up to 90-day) Schengen visa for visiting relatives or friends. Dependent is a long-stay residence permit for a spouse or child moving to Iceland permanently to join a sponsor already holding a valid residence permit.', 123, 5, 12340, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Airport Transit (Type A)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    123, 6, 'ISL-TRAN-IN-06', '2026.09', 'published',
    'Passing through Keflavík International Airport en route to a non-Schengen destination.',
    'Indian passport holders are NOT on Iceland/Schengen''s Annex III list of nationalities requiring a Type A Airport Transit Visa, so Indians may transit airside without one. A Type A visa is only relevant for nationalities on that list; if you plan to pass border control and leave the international transit zone, a regular Schengen C-type visa applies instead.',
    'Duration of the airside connection only; not applicable if leaving the transit zone (see Tourist/Business categories instead)',
    'No transit-visa application typically needed if remaining airside; a Schengen C-type visa applies only if leaving the transit zone',
    0,
    'Not applicable for pure airside transit by Indian nationals; if a Schengen C-type visa is instead needed to leave the transit zone, standard ~15-calendar-day Schengen processing applies',
    'Not applicable — Indian nationals are exempt from Iceland''s Type A visa requirement per current Annex III listings',
    'Confirm your specific itinerary keeps you airside at Keflavík (no border crossing)\nIf you will leave the international transit zone for any reason, apply for a standard Schengen C-type visa instead (see Tourist/Business categories)\nCarry your onward ticket and any visa required for your final destination',
    '/assets/images/visa-heroes/iceland.webp',
    'Triangulated from WebSearch-indexed island.is Annex III transit-visa listings and visa-guide secondary sourcing; direct fetches were blocked this session', 'https://island.is/en/do-you-need-a-visa/airport-transit-visa', '2026-09-17'
);
SET @isl6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@isl6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl6, 'Core Documents', 'What to carry, even though no transit visa is typically required for Indian passport holders.', 1);
SET @isl6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@isl6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl6, 'Supporting Documents', 'Only relevant if you will leave the transit zone.', 2);
SET @isl6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1),
(@isl6s2, 'Schengen C-Type Visa (If Leaving the Transit Zone)', 'See the Tourist or Business visa checklist instead.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(123, 6, NULL, 'EUR', 'Not Applicable for Indian Passport Holders', 'Indian nationals are not on Iceland''s Annex III list requiring a Type A Airport Transit Visa, so no separate transit-visa fee applies for airside connections. If a full Schengen C-type visa is needed instead, the standard EUR 90 fee applies.', '2026-09-01', NOW(), 'https://island.is/en/do-you-need-a-visa/airport-transit-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa to change flights in Iceland?', 'No — Indian passport holders are not on the Annex III list of nationalities Iceland requires a Type A Airport Transit Visa for, so a purely airside connection through Keflavík needs no transit visa at all.', 123, 6, 12350, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    123, 7, 'ISL-MED-IN-07', '2026.09', 'published',
    'Travel to Iceland for medical treatment or consultation.',
    'Indian nationals travelling for treatment — the same Schengen C-type visa as Tourist, requiring a certificate from the treating doctor or institution confirming the need for specific treatment.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global India with the medical certificate and Schengen-compliant insurance; decision by the Embassy of Iceland, New Delhi',
    1,
    'Standard Schengen processing is around 15 calendar days after transfer from VFS to the embassy, extendable if documentation is incomplete',
    'Embassy of Iceland, New Delhi (decision authority), via VFS Global centres across India',
    'Obtain a certificate from the treating Icelandic doctor/institution\nArrange Schengen-compliant travel insurance (min. EUR 30,000 cover)\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/iceland.webp',
    'Triangulated from WebSearch-indexed government.is and VFS Global/visa-agency secondary sourcing; direct fetches were blocked this session', 'https://www.government.is/diplomatic-missions/embassy-of-iceland-in-new-delhi/visa-to-iceland/', '2026-09-17'
);
SET @isl7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@isl7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl7, 'Core Documents', 'Required from every applicant.', 1);
SET @isl7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@isl7s1, 'Medical Certificate/Institution Confirmation', NULL, 'original', 1, 0, 1, 2),
(@isl7s1, 'Schengen Travel Medical Insurance (Min. EUR 30,000 Coverage)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @isl7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@isl7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(123, 7, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate non-refundable VFS Global service charge.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/one-pager/iceland/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What insurance coverage is required for an Iceland Medical visa?', 'The standard Schengen minimum applies: at least EUR 30,000 coverage for accident, illness and medical evacuation/repatriation across the Schengen area, for the full duration of your stay, under EU Regulation (EC) No 810/2009.', 123, 7, 12360, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    123, 8, 'ISL-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade fairs in Iceland.',
    'Indian nationals attending a conference — the same Schengen C-type visa as Tourist/Business, differentiated by a conference invitation or registration confirmation. No Iceland-specific bundling with other categories was found this session, unlike some neighbouring markets.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global India with a conference invitation/registration confirmation; decision by the Embassy of Iceland, New Delhi',
    1,
    'Standard Schengen processing is around 15 calendar days after transfer from VFS to the embassy',
    'Embassy of Iceland, New Delhi (decision authority), via VFS Global centres across India',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/iceland.webp',
    'Triangulated from WebSearch-indexed government.is and VFS Global/visa-agency secondary sourcing; direct fetches were blocked this session — no Iceland-specific documentary bundling with other purposes was found', 'https://www.government.is/diplomatic-missions/embassy-of-iceland-in-new-delhi/visa-to-iceland/', '2026-09-17'
);
SET @isl8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@isl8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl8, 'Core Documents', 'Required from every applicant.', 1);
SET @isl8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@isl8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @isl8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@isl8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(123, 8, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate non-refundable VFS Global service charge.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/one-pager/iceland/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Conference visa different from a Business visa for Iceland?', 'They are the same underlying Schengen C-type visa; the difference is documentary — a conference invitation/registration confirmation rather than a business-meeting invitation letter.', 123, 8, 12370, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    123, 9, 'ISL-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments or sporting events hosted in Iceland.',
    'Indian nationals competing or officiating — the same Schengen C-type visa as Tourist/Conference, generally supported by a letter from the home-country sports association and a host-event invitation, though no Iceland-specific documentary bundling for this category was confirmed this session.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global India with association and event letters; decision by the Embassy of Iceland, New Delhi',
    1,
    'Standard Schengen processing is around 15 calendar days after transfer from VFS to the embassy',
    'Embassy of Iceland, New Delhi (decision authority), via VFS Global centres across India',
    'Obtain a letter from your resident-country athletic association confirming your role\nObtain an invitation letter from the host event organizer with event details\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/iceland.webp',
    'Triangulated from generic Schengen sporting-event visa practice and government.is/VFS secondary sourcing; no Iceland-specific sports-visa page was directly confirmed this session', 'https://www.government.is/diplomatic-missions/embassy-of-iceland-in-new-delhi/visa-to-iceland/', '2026-09-17'
);
SET @isl9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@isl9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl9, 'Core Documents', 'Required from every applicant.', 1);
SET @isl9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@isl9s1, 'Home-Country Sports Association Letter', 'Confirms role and no-employment status.', 'original', 1, 0, 1, 2),
(@isl9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @isl9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1),
(@isl9s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(123, 9, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate non-refundable VFS Global service charge.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/one-pager/iceland/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What documentation is specific to a Sports visa for Iceland?', 'Beyond the standard Schengen documents, applicants are generally expected to provide a letter from their home-country sports association and a separate invitation from the host event organizer — this session found no Iceland-specific bundling of Sports with other categories.', 123, 9, 12380, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification Residence Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    123, 10, 'ISL-DEP-IN-10', '2026.09', 'published',
    'Spouse or minor children joining an Indian national who holds a valid Icelandic residence permit (work, study, or other basis).',
    'Family members of an Indian sponsor holding a qualifying residence permit in Iceland. The sponsor must show sufficient income and adequate housing; a spouse does not need independent funds, while a dependent child requires proof of at least 50% of the standard individual support amount.',
    'Tied to the sponsor''s residence permit validity',
    'Apply directly to the Directorate of Immigration in Reykjavik — NOT via VFS Global or the New Delhi embassy',
    1,
    'The 2025 average processing time for approved first-time family-reunification permits was reported at about 7.5 months, notably longer than short-stay Schengen processing',
    'Directorate of Immigration (Útlendingastofnun), Reykjavik',
    'Confirm the sponsor holds a qualifying valid residence permit and sufficient income/housing\nGather relationship proof (marriage/birth certificates) and the sponsor''s permit copy\nComplete the paper residence-permit application and pay the fee\nPost the original application (or use the Reykjavik drop-box) to the Directorate of Immigration\nWait through the reported multi-month processing window, then travel and register upon arrival',
    '/assets/images/visa-heroes/iceland.webp',
    'Triangulated from WebSearch-indexed island.is family-reunification pages and secondary immigration-law sourcing; direct fetches were blocked this session', 'https://island.is/en/o/directorate-of-immigration/have-applied-family', '2026-09-17'
);
SET @isl10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@isl10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl10, 'Core Documents', 'Required from every applicant.', 1);
SET @isl10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@isl10s1, 'Proof of Relationship to Sponsor (Marriage/Birth Certificate)', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@isl10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit and household means.', 2);
SET @isl10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@isl10s2, 'Sponsor''s Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@isl10s2, 'Proof of Sponsor''s Income', NULL, 'copy', 1, 0, 0, 2),
(@isl10s2, 'Proof of Adequate Housing in Iceland', NULL, 'copy', 1, 0, 0, 3),
(@isl10s2, 'Proof of Own Funds (Dependent Children, Min. 50% of Standard Support Amount)', NULL, 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(123, 10, 110000.00, 'ISK', 'Non-EEA/EFTA Family Reunification Residence Permit Fee', 'Reported at approximately ISK 110,000 for a spousal residence permit application; fees for dependent children were not separately confirmed this session — treat as approximate.', '2026-09-01', NOW(), 'https://island.is/en/o/directorate-of-immigration/have-applied-family', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a dependent spouse need to show their own income?', 'No — Icelandic rules recognise a maintenance obligation between spouses, so it is sufficient for the sponsoring spouse to demonstrate adequate funds; the dependent spouse does not need independent income.', 123, 10, 12390, 1),
('How long does Iceland family reunification typically take?', 'The 2025 average for approved first-time family-reunification permits was reported at roughly 7.5 months — plan well ahead, as this is substantially longer than short-stay Schengen visa processing.', 123, 10, 12391, 1);
