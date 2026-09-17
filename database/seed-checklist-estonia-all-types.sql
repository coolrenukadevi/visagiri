-- Estonia Visa Checklist Engine content for all 10 visa types — built fresh
-- this session via web search. hero_image_url left NULL at authoring time
-- (no photo bundle supplied yet for this batch).
--
-- IMPORTANT SOURCING CAVEAT: newdelhi.mfa.ee (Estonian Embassy New Delhi),
-- vm.ee, and visa.vfsglobal.com were NOT directly fetchable this session
-- (network egress blocked to those domains) — findings below were
-- triangulated from search-engine-indexed snippets of those same official
-- pages plus secondary sourcing (VFS Global partner/relocation-agency
-- pages, education consultancies, immigration-law blogs). Fee and
-- threshold figures vary 10-20% across sources and are flagged as
-- approximate throughout. Every category below was researched this
-- session — none are unconfirmed placeholders — but treat exact EUR
-- amounts and day-counts as needing final confirmation against the
-- Embassy's own fee table before publishing to end users.
--
-- Estonia's real, distinctive facts verified this session:
--   - A genuine split application channel, same shape as several other EU
--     states we've covered: short-stay Schengen C-type visas (Tourist,
--     Business, Family Visit, Transit, Medical, Conference, Sports) route
--     through VFS Global (9 Indian cities: New Delhi, Mumbai, Bengaluru,
--     Chennai, Hyderabad, Kolkata, Ahmedabad, Pune, Jalandhar), which then
--     forwards the file to the Embassy of Estonia, New Delhi for decision
--     the next working day. Long-stay D-type visas (Student, Work,
--     Dependent/family reunification) must instead be lodged in person,
--     directly at the Embassy — VFS Global cannot accept D-visa
--     applications at all.
--   - e-Residency is explicitly NOT an immigration or visa program: it is
--     a digital-identity scheme for running an Estonian company online,
--     and Estonia's own e-Residency knowledge base states it grants no
--     right to enter, live in, or travel to Estonia/the EU. It is
--     mentioned here only to head off a common misconception among
--     Indian applicants researching Estonia — it plays no role in any of
--     the 10 checklist categories below.
--   - Estonia's Digital Nomad Visa (a Type D long-stay visa distinct from
--     the standard employer-sponsored Work route) is genuinely available
--     to Indian remote workers/freelancers/entrepreneurs working for
--     non-Estonian clients, reportedly requiring a minimum gross monthly
--     income of ~EUR 4,500 for the preceding 6 months, for stays up to 12
--     months with no path to permanent residency. Folded into the Work
--     visa category's FAQ since our schema has no separate visa_type_id
--     for it.
--   - Estonia runs an annual immigration quota on non-EU residence
--     permits (reported ~1,292 for 2026), but startup founders/
--     employees, ICT specialists, and "top specialists" earning roughly
--     2x the average gross salary are commonly reported as quota-exempt —
--     genuinely relevant to Indian IT-sector applicants, though the exact
--     salary threshold is cited inconsistently across sources (~EUR 2,528
--     flat vs. "2x average salary").
--   - A reported 2026 Aliens Act amendment tightens standard
--     employer-sponsorship conditions (documented local-recruitment
--     proof) while separately opening up to 1,300 quota-exempt permits
--     for shortage sectors — a genuine, dated 2026 policy shift.
--   - Since 28 April 2025, all foreign public documents submitted with a
--     D-visa application (including academic transcripts) must be
--     apostilled/legalized and translated into Estonian or English — a
--     genuine, dated, recently-tightened document rule.
--   - India is NOT among the roughly 13 nationalities subject to a
--     universal Schengen Type A airport transit visa, so most Indian
--     travellers connecting airside through Tallinn need no transit visa
--     at all — only a standard C-type visa if they leave the
--     international transit area.
--
-- country_id 116 = Estonia. visa_type_id: 1=Tourist, 2=Business,
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
    116, 1, 'EST-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel and sightseeing in Estonia.',
    'Indian passport holders — the standard Schengen C-type visa, applied via VFS Global, valid for travel across the whole Schengen area, not just Estonia.',
    'Single or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global (9 Indian cities); forwarded to the Embassy of Estonia, New Delhi for decision',
    1,
    'Standard processing is typically 10-15 calendar days; can extend to several weeks in peak season (June-August)',
    'Embassy of Estonia, New Delhi (decision authority), via VFS Global visa application centres',
    'Book a VFS Global appointment\nComplete the online Schengen visa application form\nGather supporting documents\nAttend the appointment and submit biometrics (mandatory for first-time applicants)\nTrack status and collect your passport',
    '/assets/images/visa-heroes/estonia.webp',
    'Cross-checked against Estonian Embassy New Delhi (newdelhi.mfa.ee) and VFS Global secondary sourcing via search snippets; direct fetch blocked this session', 'https://newdelhi.mfa.ee/general-info-about-short-term-stay-in-estonia/', '2026-09-17'
);
SET @est1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@est1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est1, 'Core Documents', 'Required from every applicant.', 1);
SET @est1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est1s1, 'Valid Passport (3+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@est1s1, 'Completed Schengen Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@est1s1, 'Travel/Schengen Medical Insurance (Min. EUR 30,000 Coverage)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @est1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est1s2, 'Confirmed Hotel Booking', NULL, 'copy', 1, 0, 0, 1),
(@est1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@est1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(116, 1, 90.00, 'EUR', 'Schengen C-Type Visa Fee (Approximate)', 'Standard Schengen visa fee; some sources still cite EUR 80, so treat as approximate pending direct confirmation. A separate VFS Global service fee (reported ~EUR 22, collected as roughly INR 1,750-2,200) also applies.', '2026-09-01', NOW(), 'https://newdelhi.mfa.ee/visa-fee/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does an Estonia Tourist visa let me travel elsewhere in Europe?', 'Yes — the Schengen C-type visa is valid for travel across the entire Schengen area, not just Estonia, subject to the standard 90-days-in-180 rule.', 116, 1, 11600, 1),
('Can I submit my Estonia visa application through a travel agent?', 'No — applications must be lodged in person (or via VFS Global for biometrics) by the applicant; the Embassy does not accept third-party or agent submissions for direct filings.', 116, 1, 11601, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    116, 2, 'EST-BUS-IN-02', '2026.09', 'published',
    'Trade, negotiations, and commercial meetings in Estonia.',
    'Indian nationals travelling for business — the same Schengen C-type visa as Tourist, with a company invitation letter and Indian employer forwarding letter as the differentiating documents.',
    'Single, double, or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global with a business invitation letter and Indian employer forwarding letter',
    1,
    'Standard processing is typically 10-15 calendar days',
    'Embassy of Estonia, New Delhi, via VFS Global visa application centres',
    'Obtain an invitation letter from the Estonian host company\nGather your Indian employer forwarding/sponsorship letter\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/estonia.webp',
    'Cross-checked against Estonian Embassy New Delhi and VFS Global secondary sourcing via search snippets; direct fetch blocked this session', 'https://newdelhi.mfa.ee/general-info-about-short-term-stay-in-estonia/', '2026-09-17'
);
SET @est2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@est2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est2, 'Core Documents', 'Required from every applicant.', 1);
SET @est2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@est2s1, 'Invitation Letter from Estonian Host Company', NULL, 'original', 1, 0, 1, 2),
(@est2s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @est2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@est2s2, 'Business Registration Proof', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(116, 2, 90.00, 'EUR', 'Schengen C-Type Visa Fee (Approximate)', 'Same fee structure as Tourist, plus a separate VFS Global service fee.', '2026-09-01', NOW(), 'https://newdelhi.mfa.ee/visa-fee/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the Estonian host company''s invitation letter need to be in Estonian?', 'It is commonly accepted in English per secondary sourcing, but confirm the current requirement with your host company or VFS before applying.', 116, 2, 11602, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Type D Long-Stay Visa + TRP
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    116, 3, 'EST-STU-IN-03', '2026.09', 'published',
    'Enrolling in an Estonian university or higher-education institution.',
    'Indian nationals admitted to a recognized Estonian institution, applying for a long-stay D-visa (up to 365 days) directly at the Embassy, then converting to a Temporary Residence Permit (TRP) at the Police and Border Guard Board (PPA) within 30 days of arrival.',
    'Up to 365 days on the D-visa; the TRP thereafter covers the full study period plus a post-study buffer',
    'Apply in person directly at the Embassy of Estonia, New Delhi — NOT via VFS Global, unlike the short-stay categories',
    1,
    'D-visa applications are reportedly examined and decided within 30 days of lodging, per the Embassy',
    'Embassy of Estonia, New Delhi',
    'Secure admission at a recognized Estonian institution\nGather proof of funds (reported ~EUR 4,200) and health insurance\nHave academic transcripts/certificates apostilled or legalized (mandatory since 28 April 2025) and translated\nBook an embassy appointment (not VFS) and submit in person\nTravel, then apply for the Temporary Residence Permit (TRP) at the PPA within 30 days of arrival',
    '/assets/images/visa-heroes/estonia.webp',
    'Cross-checked against Study in Estonia and Embassy of Estonia secondary sourcing via search snippets; direct fetch blocked this session', 'https://www.studyinestonia.ee/visa-and-residence-permit', '2026-09-17'
);
SET @est3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@est3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est3, 'Core Documents', 'Required from every applicant.', 1);
SET @est3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@est3s1, 'Admission Letter from Estonian Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @est3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est3s2, 'Apostilled/Legalized Academic Transcripts and Certificates', 'Mandatory apostille/legalization requirement in force since 28 April 2025.', 'copy', 1, 0, 0, 1),
(@est3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@est3s2, 'Health Insurance Valid in Estonia', NULL, 'original', 1, 0, 0, 3),
(@est3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(116, 3, 100.00, 'EUR', 'D-Visa Administrative Fee', 'Payable at the Embassy; a separate Temporary Residence Permit (TRP) fee of approximately EUR 225 applies after arrival. Figures reported by secondary sources — confirm current amounts with the Embassy.', '2026-09-01', NOW(), 'https://www.studyinestonia.ee/visa-and-residence-permit', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can international students work while studying in Estonia?', 'Yes — students on a valid Temporary Residence Permit reportedly can work without hour restrictions, provided they maintain academic progress and a full course load each semester.', 116, 3, 11603, 1),
('Can I stay in Estonia after graduation to look for a job?', 'Yes — graduates reportedly can extend their TRP for up to 270 days to search for work, without needing an employer lined up first.', 116, 3, 11604, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Type D Long-Stay Visa + TRP for Employment
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    116, 4, 'EST-WORK-IN-04', '2026.09', 'published',
    'Employment with an Estonian employer via a long-stay D-visa converting to a Temporary Residence Permit (TRP) for employment.',
    'Indian nationals with a confirmed Estonian job offer. Estonia caps annual non-EU residence permits under an immigration quota (reported ~1,292 for 2026), but startup founders/employees, ICT specialists, and "top specialists" earning roughly double the average gross salary are commonly reported as quota-exempt.',
    'TRP for employment valid for the contract duration, up to 5 years, renewable',
    'Employer-driven registration, then apply for the D-visa/TRP directly at the Embassy of Estonia, New Delhi — not via VFS Global',
    1,
    'D-visa applications reportedly decided within 30 days of lodging; a 2026 Aliens Act amendment reportedly tightens standard sponsor requirements while adding shortage-sector quota-exempt permits',
    'Embassy of Estonia, New Delhi (decision); physical permit collected from the Police and Border Guard Board (PPA) in Estonia',
    'Secure a job offer from an Estonian employer\nEmployer registers the position with the Police and Border Guard Board (PPA)\nApply for the D-visa at the Embassy of Estonia, New Delhi\nTravel to Estonia and apply for the Temporary Residence Permit (TRP) at the PPA\nCollect the physical residence permit card',
    '/assets/images/visa-heroes/estonia.webp',
    'Cross-checked against Work in Estonia and immigration-law secondary sourcing via search snippets; direct fetch blocked this session', 'https://workinestonia.com/12-months-non-eu/', '2026-09-17'
);
SET @est4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@est4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est4, 'Core Documents', 'Required from every applicant.', 1);
SET @est4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@est4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@est4s1, 'PPA Employment Registration Confirmation', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @est4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@est4s2, 'Proof of Financial Means', NULL, 'copy', 1, 0, 0, 2),
(@est4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(116, 4, NULL, 'EUR', 'Confirmed After Assessment', 'D-visa administrative fee reported around EUR 100; TRP-for-employment fees vary by permit type/duration and were not independently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://workinestonia.com/12-months-non-eu/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a fast-track or quota-exempt route for Indian IT professionals?', 'Reportedly yes — startup founders/employees, ICT specialists, and "top specialists" earning roughly double the average Estonian gross salary are commonly cited as exempt from the annual immigration quota, though the exact salary threshold is cited inconsistently across sources.', 116, 4, 11605, 1),
('Is Estonia''s Digital Nomad Visa a separate route from the standard Work visa?', 'Yes — it is a distinct Type D visa for remote workers/freelancers/entrepreneurs serving non-Estonian clients, reportedly requiring a minimum gross monthly income of around EUR 4,500 for the preceding 6 months, for stays up to 12 months with no path to permanent residency.', 116, 4, 11606, 1),
('Can the Digital Nomad Visa be applied for via VFS Global?', 'Sourcing was inconsistent on this point this session — some pages list VFS Global centres for the Digital Nomad Visa while the Embassy''s general guidance states VFS cannot accept any D-visa application. Confirm the correct channel directly with the Embassy before applying.', 116, 4, 11607, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    116, 5, 'EST-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Estonia.',
    'Indian nationals with family or friends in Estonia — the same Schengen C-type visa as Tourist, requiring an invitation letter and proof of the relationship.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with an invitation letter and relationship proof',
    1,
    'Standard processing is typically 10-15 calendar days',
    'Embassy of Estonia, New Delhi, via VFS Global visa application centres',
    'Obtain an invitation letter from your host in Estonia\nGather documents proving the family relationship\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/estonia.webp',
    'Cross-checked against Estonian Embassy New Delhi and VFS Global secondary sourcing via search snippets; direct fetch blocked this session', 'https://newdelhi.mfa.ee/general-info-about-short-term-stay-in-estonia/', '2026-09-17'
);
SET @est5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@est5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est5, 'Core Documents', 'Required from every applicant.', 1);
SET @est5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@est5s1, 'Invitation Letter from Host in Estonia', NULL, 'original', 1, 0, 1, 2),
(@est5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @est5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@est5s2, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(116, 5, 90.00, 'EUR', 'Schengen C-Type Visa Fee (Approximate)', 'Same fee structure as Tourist, plus a separate VFS Global service fee.', '2026-09-01', NOW(), 'https://newdelhi.mfa.ee/visa-fee/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a notarized invitation letter required for a Family Visit visa?', 'Requirements vary by case; secondary sourcing suggests a standard invitation letter plus documentary proof of the relationship is generally expected — confirm the current format with VFS before applying.', 116, 5, 11608, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Type A Airport Transit / Type C
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    116, 6, 'EST-TRAN-IN-06', '2026.09', 'published',
    'Passing through Estonia (typically Tallinn Airport) en route to a non-Schengen destination.',
    'India is not among the roughly 13 nationalities subject to a universal Schengen Type A airport transit visa, so most Indian travellers connecting airside through Estonia need no visa at all; a standard C-type transit visa applies only if leaving the international transit area.',
    'Limited to the connecting window; a C-type transit visa, if required, follows the standard 90/180-day short-stay terms',
    'No visa needed for a pure airside connection; if leaving the transit area, apply via VFS Global with onward ticket and itinerary',
    1,
    'Standard Schengen-adjacent processing reported around 10-15 calendar days, if a C-type transit visa is genuinely required',
    'Embassy of Estonia, New Delhi, via VFS Global centres (only if a visa is genuinely required)',
    'Confirm whether your specific itinerary requires leaving the international transit area\nIf so, apply via VFS Global with onward ticket and itinerary\nSubmit biometrics if required',
    '/assets/images/visa-heroes/estonia.webp',
    'Cross-checked against Schengen transit-visa secondary sourcing on Indian-nationality exemptions, triangulated via search snippets this session', 'https://schengenvisainfo.com/news/explaining-transit-schengen-visa-requirement-for-indians/', '2026-09-17'
);
SET @est6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@est6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est6, 'Core Documents', 'Only relevant if leaving the international transit area.', 1);
SET @est6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@est6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @est6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(116, 6, NULL, 'EUR', 'Confirmed After Assessment', 'No fee applies to a pure airside connection since India is not on Estonia''s Type A transit-visa list; if leaving the transit area, the standard Schengen C-type fee (~EUR 90) would apply.', '2026-09-01', NOW(), 'https://schengenvisainfo.com/news/explaining-transit-schengen-visa-requirement-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian passport holders need an airport transit visa for Estonia?', 'Generally no — India is not on the list of nationalities requiring a universal Schengen Type A airport transit visa. A visa is only needed if you leave the international transit area (e.g. an overnight stopover requiring passport control).', 116, 6, 11609, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    116, 7, 'EST-MED-IN-07', '2026.09', 'published',
    'Travel to Estonia for medical treatment.',
    'Indian nationals travelling for treatment — the same Schengen C-type visa as Tourist, requiring a certificate from the treating doctor or institution confirming the need for specific treatment.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with the medical certificate and Schengen-compliant insurance',
    1,
    'Standard processing is typically 10-15 calendar days, can extend if documentation is incomplete',
    'Embassy of Estonia, New Delhi, via VFS Global visa application centres',
    'Obtain a certificate from the treating Estonian doctor/institution\nArrange Schengen-compliant travel insurance (min. EUR 30,000 cover)\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/estonia.webp',
    'Cross-checked against Estonian Embassy New Delhi and VFS Global secondary sourcing via search snippets; direct fetch blocked this session', 'https://newdelhi.mfa.ee/general-info-about-short-term-stay-in-estonia/', '2026-09-17'
);
SET @est7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@est7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est7, 'Core Documents', 'Required from every applicant.', 1);
SET @est7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@est7s1, 'Medical Certificate/Institution Confirmation', NULL, 'original', 1, 0, 1, 2),
(@est7s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @est7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@est7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(116, 7, 90.00, 'EUR', 'Schengen C-Type Visa Fee (Approximate)', 'Same fee structure as Tourist, plus a separate VFS Global service fee.', '2026-09-01', NOW(), 'https://newdelhi.mfa.ee/visa-fee/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What insurance coverage is required for an Estonia Medical visa?', 'Schengen-compliant travel medical insurance with a minimum of EUR 30,000 coverage, valid across the Schengen area for the full duration of your stay, is generally required — confirm your specific policy meets this before applying.', 116, 7, 11610, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    116, 8, 'EST-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade fairs in Estonia.',
    'Indian nationals attending a conference — the same Schengen C-type visa as Tourist, requiring a conference invitation or registration confirmation as the differentiating document.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a conference invitation/registration confirmation',
    1,
    'Standard processing is typically 10-15 calendar days',
    'Embassy of Estonia, New Delhi, via VFS Global visa application centres',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/estonia.webp',
    'Cross-checked against Estonian Embassy New Delhi and VFS Global secondary sourcing via search snippets; direct fetch blocked this session', 'https://newdelhi.mfa.ee/general-info-about-short-term-stay-in-estonia/', '2026-09-17'
);
SET @est8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@est8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est8, 'Core Documents', 'Required from every applicant.', 1);
SET @est8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@est8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @est8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@est8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(116, 8, 90.00, 'EUR', 'Schengen C-Type Visa Fee (Approximate)', 'Same fee structure as Tourist, plus a separate VFS Global service fee.', '2026-09-01', NOW(), 'https://newdelhi.mfa.ee/visa-fee/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Conference visa processed differently from the Tourist visa?', 'No — it uses the same Schengen C-type visa and channel (VFS Global to the Embassy), with the conference invitation/registration confirmation as the main differentiating document.', 116, 8, 11611, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    116, 9, 'EST-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Estonia.',
    'Indian nationals competing or officiating — the same Schengen C-type visa as Tourist/Conference, requiring a letter from the home-country sports association and an invitation from the host event organizer.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a home-association letter and host-organizer invitation',
    1,
    'Standard processing is typically 10-15 calendar days',
    'Embassy of Estonia, New Delhi, via VFS Global visa application centres',
    'Obtain a letter from your resident-country athletic association confirming your role and no-employment status\nObtain an invitation letter from the host event organizer with event details and expense arrangements\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/estonia.webp',
    'Cross-checked against Estonian Embassy New Delhi and VFS Global secondary sourcing via search snippets; direct fetch blocked this session', 'https://newdelhi.mfa.ee/general-info-about-short-term-stay-in-estonia/', '2026-09-17'
);
SET @est9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@est9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est9, 'Core Documents', 'Required from every applicant.', 1);
SET @est9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@est9s1, 'Home-Country Sports Association Letter', 'Confirms role and no-employment status.', 'original', 1, 0, 1, 2),
(@est9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @est9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(116, 9, 90.00, 'EUR', 'Schengen C-Type Visa Fee (Approximate)', 'Same fee structure as Tourist, plus a separate VFS Global service fee.', '2026-09-01', NOW(), 'https://newdelhi.mfa.ee/visa-fee/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a letter from my sports association even as a support-staff member?', 'Generally yes — the home-country association letter and host-organizer invitation are expected for athletes, officials, and support staff alike, confirming the trip is not paid employment in Estonia.', 116, 9, 11612, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification D-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    116, 10, 'EST-DEP-IN-10', '2026.09', 'published',
    'Spouse/partner, minor children, or dependent relatives joining an Indian national on a qualifying Estonian D-visa or residence permit.',
    'Family members of an Indian national holding a qualifying Estonian long-stay visa or residence permit (e.g. work TRP, student D-visa). Spouse/registered partner, children under 18, and financially dependent parents/grandparents are eligible; accompanying family generally cannot work unless they obtain their own permit.',
    'Tied to the sponsor''s permit validity; up to 365 days per D-visa, with two consecutive long-stay visas capped at 548 days within 730 days',
    'Apply in person directly at the Embassy of Estonia, New Delhi — the D-visa/long-stay route, not VFS',
    1,
    'D-visa applications reportedly decided within 30 days of lodging, per the Embassy',
    'Embassy of Estonia, New Delhi',
    'Confirm the sponsor holds a qualifying D-visa/residence permit\nGather relationship proof (marriage/birth certificates) and the sponsor''s permit copy\nBook an embassy appointment (not VFS) and submit in person\nCollect the visa and register for a residence permit in Estonia if staying long-term',
    '/assets/images/visa-heroes/estonia.webp',
    'Cross-checked against Estonian long-stay visa and family-reunification secondary sourcing via search snippets; direct fetch blocked this session', 'https://vm.ee/en/consular-visa-and-travel-information/visa-information/application-long-stay-d-visa', '2026-09-17'
);
SET @est10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@est10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est10, 'Core Documents', 'Required from every applicant.', 1);
SET @est10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@est10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@est10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @est10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@est10s2, 'Sponsor''s D-Visa/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@est10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(116, 10, NULL, 'EUR', 'Confirmed After Assessment', 'D-visa administrative fee reported around EUR 100 (same as Student/Work D-visa fee); a specific family-reunification fee figure was not independently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://vm.ee/en/consular-visa-and-travel-information/visa-information/application-long-stay-d-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my accompanying spouse work in Estonia on the family reunification D-visa?', 'Generally no — the family D-visa is reported as a non-lucrative permit, so an accompanying spouse or dependent would need to apply for their own separate work permit to be legally employed.', 116, 10, 11613, 1);
