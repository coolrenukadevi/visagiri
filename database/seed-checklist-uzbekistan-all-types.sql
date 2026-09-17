-- Uzbekistan Visa Checklist Engine content for all 10 visa types — built
-- this session via WebSearch synthesis (WebFetch was blocked by the
-- network egress proxy for every domain tried this session, including
-- yuz.uz, gazeta.uz, uzbekembassy.in, e-visa.gov.uz, tribuneindia.com,
-- aninews.in, airindia.com and travelandtourworld.com — so nothing here
-- was pulled from a primary source page directly; everything is
-- triangulated across multiple independent secondary sources returned
-- by WebSearch, and no fee/date/figure below was invented).
--
-- HEADLINE FINDING — VERIFIED, HIGH CONFIDENCE: Uzbekistan introduced a
-- CONDITIONAL visa-free entry for Indian citizens, effective 1 September
-- 2026, announced by President Shavkat Mirziyoyev during PM Narendra
-- Modi's state visit to Tashkent (29-30 August 2026). This is NOT a
-- blanket visa waiver for all Indian passport holders — it applies only
-- to Indian citizens who ALREADY hold a valid MULTIPLE-ENTRY tourist or
-- business visa issued by Australia, Canada, Japan, New Zealand, the
-- Republic of Korea, the United Kingdom, the United States, or a
-- Schengen Agreement state, and who present an air ticket for a flight
-- to India or a third country on arrival. Qualifying travellers get a
-- visa-free stay of up to 30 days from the date of entry. This exact
-- combination of facts (effective date, 30-day cap, the 8-country/region
-- qualifying list, and the air-ticket condition) was independently and
-- consistently corroborated across the Indian Embassy Tashkent (as
-- reported by The Tribune and ANI), Uzbekistan's yuz.uz national news
-- portal, and independent Uzbek outlet Gazeta.uz, so it is treated as
-- solid. All Indian travellers who do NOT hold one of those qualifying
-- third-country visas still need Uzbekistan's own e-Visa (or an ordinary
-- consular visa) — that pre-existing e-Visa system is documented below
-- as the fallback/default route for every category.
--
-- Uzbekistan's other genuinely distinctive/notable facts verified this
-- session:
--   - The e-Visa (e-visa.gov.uz, launched 2019) is fully online — no
--     embassy visit and no biometrics for most applicants, unlike a
--     Schengen-style process. Officially published tiers are USD 20
--     (single entry), USD 35 (double entry) and USD 50 (multiple
--     entry), each entry/stay capped at 30 days within a 90-day
--     validity window from issue — though some travel-agency sites
--     quote USD 120 for multiple-entry, a discrepancy flagged in the
--     fee notes below pending direct portal confirmation.
--   - Student and Work-permit routes are NOT covered by the e-Visa or
--     the new visa-free scheme at all — both still require an in-person
--     application at the Embassy of the Republic of Uzbekistan, New
--     Delhi, backed by a visa-support/invitation confirmation number
--     registered with Uzbek authorities.
--   - Uzbekistan runs a "Highly Qualified Specialist" fast-track for
--     Work permits: a Top-1000-university graduate with 5+ years'
--     relevant experience and a job offer above USD 60,000/year can get
--     a permit valid up to 3 years, with reduced state fees and, since
--     a December 2018 reform, exemption from the standard employer
--     quota/licensing process that ordinary work-permit sponsorships
--     go through.
--   - Since a July 2018 reform, Business visa invitation letters can be
--     issued for 3, 6, or 12 months' validity, letting a single
--     consular Business visa cover up to a year of trips.
--   - A separate visa-free transit allowance (up to 5 days) exists for
--     travellers connecting on Uzbekistan Airways only, presenting their
--     ticket on arrival — but this session could NOT independently
--     confirm whether Indian passport holders are on the eligible
--     nationality list for that specific scheme, so the Transit
--     category below treats the standard consular transit visa as the
--     safe default and flags the Uzbekistan Airways allowance as
--     unconfirmed for Indians.
--   - CATEGORIES FLAGGED AS UNDER-SOURCED (best-effort structure only,
--     figures marked approximate/NOT independently confirmed this
--     session): Work permit state fees, Transit visa fees, Medical visa
--     fees, and Dependent/family-reunification residence-permit fees —
--     none of these had a reliable government-quoted figure surface in
--     this session's searches.
--
-- country_id 103 = Uzbekistan. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — e-Visa, with new conditional visa-free route
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    103, 1, 'UZB-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Uzbekistan, including Samarkand, Bukhara, Khiva and Tashkent.',
    'Indian nationals have two routes: a fully online e-Visa (no embassy visit or biometrics); or, from 1 Sept 2026, conditional visa-free entry (up to 30 days) if you already hold a valid multiple-entry tourist/business visa for Australia, Canada, Japan, New Zealand, South Korea, the UK, the USA, or a Schengen state, plus an onward/return air ticket.',
    'Up to 30 days per stay (e-Visa: within a 90-day validity window; visa-free route: from date of entry)',
    'e-Visa portal (e-visa.gov.uz), or border entry without a visa if holding a qualifying third-country multi-entry visa',
    0,
    'e-Visa typically issued within 2-3 working days; the visa-free route (effective 1 Sept 2026) needs no advance processing at all',
    'Embassy of the Republic of Uzbekistan, New Delhi (not required for e-Visa or the visa-free route)',
    'Check whether you already hold a qualifying multiple-entry visa (Australia/Canada/Japan/New Zealand/South Korea/UK/USA/Schengen) — if so, just carry it plus an onward/return air ticket\nIf not, apply online at e-visa.gov.uz for a single, double or multiple-entry e-Visa\nUpload passport bio page and photo, pay the fee online\nReceive the e-Visa by email and print it\nPresent passport, e-Visa (or qualifying visa + air ticket) and onward ticket on arrival',
    '/assets/images/visa-heroes/uzbekistan.webp',
    'Cross-checked across Indian Embassy Tashkent reporting (via Tribune India/ANI), Uzbekistan''s yuz.uz news portal, and Gazeta.uz, triangulated against e-Visa portal secondary sourcing (WebFetch blocked this session for all primary domains)', 'https://e-visa.gov.uz', '2026-09-17'
);
SET @uzb1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@uzb1, '2026.09', 'Initial published checklist, including the 1 Sept 2026 conditional visa-free announcement.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb1, 'Core Documents', 'Required from every applicant, whichever route you use.', 1);
SET @uzb1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb1s1, 'Valid Passport (3+ Months, 1 Blank Page)', NULL, 'original', 1, 0, 1, 1),
(@uzb1s1, 'Passport-Size Photograph (35x40mm, White Background)', 'Required for the e-Visa application.', 'copy', 1, 0, 1, 2),
(@uzb1s1, 'Onward/Return Air Ticket', 'Mandatory for the conditional visa-free route; recommended for e-Visa applicants too.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb1, 'Visa-Free Route Documents', 'Only needed if using the September 2026 conditional visa-free entry instead of an e-Visa.', 2);
SET @uzb1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb1s2, 'Valid Multiple-Entry Visa (Australia/Canada/Japan/New Zealand/South Korea/UK/USA/Schengen)', 'Must still be valid on the date of entry into Uzbekistan.', 'original', 0, 1, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb1, 'Supporting Documents', 'Evidence of your travel plans, recommended for e-Visa applicants.', 3);
SET @uzb1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb1s3, 'Confirmed Hotel Booking', NULL, 'copy', 0, 1, 0, 1),
(@uzb1s3, 'Travel Insurance', NULL, 'copy', 0, 1, 0, 2),
(@uzb1s3, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(103, 1, 20.00, 'USD', 'e-Visa Single-Entry Fee', 'Officially published tiers: USD 20 single-entry, USD 35 double-entry, USD 50 multiple-entry (some travel-agency sites quote USD 120 for multiple-entry — treat as a discrepancy pending direct portal confirmation). No fee applies to the conditional visa-free route.', '2026-09-01', NOW(), 'https://e-visa.gov.uz', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do all Indian tourists get visa-free entry to Uzbekistan now?', 'No. From 1 September 2026, visa-free entry (up to 30 days) applies only to Indian citizens who already hold a valid multiple-entry tourist or business visa for Australia, Canada, Japan, New Zealand, South Korea, the UK, the USA, or a Schengen state, plus an onward/return air ticket. Everyone else still needs Uzbekistan''s own e-Visa or a consular visa.', 103, 1, 10300, 1),
('Do I need to visit an embassy for the Uzbekistan e-Visa?', 'No — the e-Visa is a fully online process with no embassy visit and no biometrics for most tourist applicants; you apply and pay at e-visa.gov.uz and receive the visa by email.', 103, 1, 10301, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — e-Visa Business Category / Consular Invitation
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    103, 2, 'UZB-BUS-IN-02', '2026.09', 'published',
    'Trade negotiations, meetings, and commercial activity in Uzbekistan.',
    'Indian nationals travelling for business can use the e-Visa business category for short trips, or a consular Business visa via the Embassy for longer-validity company invitations. Holders of a qualifying multiple-entry business visa from certain third countries also qualify for the new conditional visa-free route (see Tourist).',
    'Up to 30 days per stay on e-Visa; consular Business visa invitation letters can be issued for 3, 6 or 12 months, allowing up to 1 year of trips',
    'e-Visa portal (e-visa.gov.uz) for short trips, or Embassy of Uzbekistan, New Delhi with a company invitation letter for extended validity',
    0,
    'e-Visa typically issued within 2-3 working days; consular Business visa processing reported around 3-5 working days once the invitation letter is confirmed',
    'Embassy of the Republic of Uzbekistan, New Delhi',
    'Decide between the e-Visa business category (short trips) and a consular Business visa (longer validity)\nFor the consular route, obtain an invitation/visa-support letter from your Uzbek host company (valid 3, 6 or 12 months)\nSubmit the e-Visa application online, or the consular application with the invitation letter at the Embassy\nPay the applicable fee\nReceive the e-Visa by email, or collect the visa from the Embassy',
    '/assets/images/visa-heroes/uzbekistan.webp',
    'Cross-checked against e-Visa business-category secondary sourcing and reporting on the July 2018 invitation-letter validity reform, triangulated across multiple sources (WebFetch blocked this session)', 'https://e-visa.gov.uz', '2026-09-17'
);
SET @uzb2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@uzb2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb2, 'Core Documents', 'Required from every applicant.', 1);
SET @uzb2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb2s1, 'Valid Passport (3+ Months, 1 Blank Page)', NULL, 'original', 1, 0, 1, 1),
(@uzb2s1, 'Business Invitation/Visa-Support Letter from Uzbek Host', 'Required for the consular route; e-Visa business applicants upload a scanned copy.', 'both', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @uzb2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@uzb2s2, 'Business Registration/Company Proof', NULL, 'copy', 0, 1, 0, 2),
(@uzb2s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(103, 2, 20.00, 'USD', 'e-Visa Business Single-Entry Fee', 'Same tiered schedule as Tourist (USD 20/35/50 for single/double/multiple entry) applies to the e-Visa business category. A separate consular fee may apply for longer-validity invitation-letter-based Business visas — confirm with the Embassy.', '2026-09-01', NOW(), 'https://e-visa.gov.uz', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can one Business visa cover multiple trips to Uzbekistan over a year?', 'Yes, if you go the consular route — since a July 2018 reform, Uzbek Business visa invitation letters can be issued for 3, 6 or 12 months'' validity, letting a single visa cover up to a year of trips.', 103, 2, 10310, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Consular, Not Covered by e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    103, 3, 'UZB-STU-IN-03', '2026.09', 'published',
    'Enrolling in a recognized Uzbek university or higher-education institution.',
    'Indian nationals admitted to a recognized Uzbek institution. Student visas are NOT covered by the e-Visa system or the new visa-free route — every applicant must apply in person at the Embassy with a visa-support/invitation confirmation number from the institution, and Student visa holders are not permitted to work in Uzbekistan.',
    'Typically issued for 1 year, renewable for the duration of the study programme',
    'In person at the Embassy of the Republic of Uzbekistan, New Delhi — not e-Visa eligible',
    1,
    'Reported around 10-15 working days once the university''s visa-support confirmation number and full documents are submitted',
    'Embassy of the Republic of Uzbekistan, New Delhi',
    'Secure admission and obtain a visa-support/invitation confirmation number from the Uzbek institution\nArrange the required medical certificate, including an HIV test, per Indian Embassy Tashkent guidance for students\nGather academic transcripts and proof of funds\nBook an Embassy appointment and submit in person\nCollect the visa and register locally in Uzbekistan on arrival',
    '/assets/images/visa-heroes/uzbekistan.webp',
    'Cross-checked against Embassy of India, Tashkent student advisory reporting and education-consultancy secondary sourcing, triangulated across multiple sources (WebFetch blocked this session)', 'https://eoitashkent.gov.in', '2026-09-17'
);
SET @uzb3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@uzb3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb3, 'Core Documents', 'Required from every applicant.', 1);
SET @uzb3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@uzb3s1, 'Admission Letter with Visa-Support Confirmation Number', NULL, 'original', 1, 0, 1, 2),
(@uzb3s1, 'Medical Certificate (Including HIV Test)', 'Required per Indian Embassy Tashkent guidance for students.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb3, 'Supporting Documents', 'Evidence of your academic background and funds.', 2);
SET @uzb3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@uzb3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@uzb3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(103, 3, 250.00, 'USD', 'One-Year Student Visa Fee (Approximate)', 'Reported around USD 250 for a one-year student visa by education-consultancy secondary sources — not independently confirmed against the Embassy''s own fee schedule this session; confirm before applying.', '2026-09-01', NOW(), 'https://eoitashkent.gov.in', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian students in Uzbekistan work part-time?', 'No — secondary sourcing indicates Student visa holders are not permitted to work legally in Uzbekistan, unlike some European student-visa regimes.', 103, 3, 10320, 1),
('Does the new visa-free route or the e-Visa cover studying in Uzbekistan?', 'No — neither the e-Visa nor the September 2026 conditional visa-free entry covers study purposes. Students must still apply in person at the Embassy with the institution''s visa-support confirmation number.', 103, 3, 10321, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Employer-Sponsored Work Permit + Consular Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    103, 4, 'UZB-WORK-IN-04', '2026.09', 'published',
    'Employment with an Uzbek employer, requiring an employer-obtained work permit plus a consular work visa.',
    'Indian nationals with a confirmed Uzbek job offer. Standard sponsorships go through the employer''s work-permit/quota process at the Ministry of Employment and Labour Relations. A "Highly Qualified Specialist" fast-track exists for Top-1000-university graduates with 5+ years'' experience and a salary above USD 60,000/year, exempt from the standard quota/licensing step since a December 2018 reform.',
    'Standard work permit typically tied to the contract term; Highly Qualified Specialist permits can be issued for up to 3 years',
    'Employer-driven work-permit application, followed by the applicant''s consular work visa at the Embassy of Uzbekistan, New Delhi',
    1,
    'Timeline depends on the employer''s work-permit approval; the Highly Qualified Specialist route is reported as faster due to quota/licensing exemption',
    'Embassy of the Republic of Uzbekistan, New Delhi',
    'Secure a job offer from an Uzbek employer\nEmployer applies for a work permit at the Ministry of Employment and Labour Relations (or claims Highly Qualified Specialist exemption if eligible)\nApplicant applies for the consular work visa at the Embassy with the approved work permit and visa-support documents\nAttend the Embassy appointment\nTravel and register locally in Uzbekistan on arrival',
    '/assets/images/visa-heroes/uzbekistan.webp',
    'Cross-checked against Uzbek labour-law/immigration secondary sourcing on the Highly Qualified Specialist scheme and the December 2018 quota-exemption reform, triangulated across multiple sources (WebFetch blocked this session)', 'https://e-immigration.uz', '2026-09-17'
);
SET @uzb4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@uzb4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb4, 'Core Documents', 'Required from every applicant.', 1);
SET @uzb4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@uzb4s1, 'Employment Contract/Job Offer', NULL, 'copy', 1, 0, 1, 2),
(@uzb4s1, 'Employer''s Approved Work Permit', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb4, 'Highly Qualified Specialist Fast-Track', 'Only relevant if claiming the Top-1000-university / high-salary exemption.', 2);
SET @uzb4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb4s2, 'Proof of Top-1000 University Degree', NULL, 'copy', 0, 1, 0, 1),
(@uzb4s2, 'Proof of 5+ Years'' Relevant Experience', NULL, 'copy', 0, 1, 0, 2),
(@uzb4s2, 'Proof of Salary Above USD 60,000/Year', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb4, 'Supporting Documents', 'Additional applicant-side evidence.', 3);
SET @uzb4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb4s3, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@uzb4s3, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(103, 4, NULL, 'USD', 'Confirmed After Assessment', 'No reliable government-quoted work-permit/visa fee figure surfaced this session; Highly Qualified Specialists reportedly pay reduced state fees versus standard sponsorships. NOT independently confirmed this session — contact us or the Embassy to confirm.', '2026-09-01', NOW(), 'https://e-immigration.uz', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a fast-track work-permit route for skilled Indian professionals?', 'Yes — Uzbekistan''s "Highly Qualified Specialist" scheme covers Top-1000-university graduates with 5+ years'' relevant experience and a job offer above USD 60,000/year, offering permits valid up to 3 years and exemption from the standard employer quota/licensing process since a December 2018 reform.', 103, 4, 10330, 1),
('Can a Highly Qualified Specialist hold a second job in Uzbekistan?', 'Reportedly yes — Highly Qualified and Qualified Specialists holding a work permit do not need a separate permit for a part-time job alongside their main employment, per secondary sourcing.', 103, 4, 10331, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — e-Visa Private-Visit Category / Consular
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    103, 5, 'UZB-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Uzbekistan.',
    'Indian nationals visiting family/friends can use the e-Visa private-visit category online, or a consular visa via the Embassy with a formal invitation. Requires an invitation from the host in Uzbekistan plus proof of the relationship; not covered by the September 2026 visa-free route unless the traveller separately holds a qualifying third-country visa.',
    'Up to 30 days per stay',
    'e-Visa portal (e-visa.gov.uz), private-visit category, or Embassy of Uzbekistan, New Delhi with an invitation letter',
    0,
    'e-Visa typically issued within 2-3 working days',
    'Embassy of the Republic of Uzbekistan, New Delhi',
    'Obtain an invitation letter from your host in Uzbekistan\nGather documents proving the family/personal relationship\nApply online via the e-Visa private-visit category, or submit the consular application at the Embassy\nPay the applicable fee\nReceive the e-Visa by email, or collect the visa from the Embassy',
    '/assets/images/visa-heroes/uzbekistan.webp',
    'Cross-checked against e-Visa private-visit category secondary sourcing, triangulated across multiple sources (WebFetch blocked this session)', 'https://e-visa.gov.uz', '2026-09-17'
);
SET @uzb5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@uzb5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb5, 'Core Documents', 'Required from every applicant.', 1);
SET @uzb5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@uzb5s1, 'Invitation Letter from Host in Uzbekistan', NULL, 'both', 1, 0, 1, 2),
(@uzb5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @uzb5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb5s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@uzb5s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(103, 5, 20.00, 'USD', 'e-Visa Private-Visit Single-Entry Fee', 'Same tiered schedule as Tourist (USD 20/35/50 for single/double/multiple entry) is reported to apply to the private-visit e-Visa category.', '2026-09-01', NOW(), 'https://e-visa.gov.uz', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the September 2026 visa-free entry cover family visits?', 'Only indirectly — it is not a family-visit-specific scheme. It applies to any Indian traveller (including one visiting family) who already holds a qualifying multiple-entry tourist/business visa from the listed countries, plus an air ticket. Without that, family visitors still need the e-Visa or a consular visa.', 103, 5, 10340, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Consular Transit Visa (Default Route)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    103, 6, 'UZB-TRAN-IN-06', '2026.09', 'published',
    'Passing through Uzbekistan (e.g. Tashkent) en route to a third country.',
    'A standard consular transit visa (up to 72 hours) via the Embassy is the confirmed default for Indian travellers. A separate visa-free transit allowance (up to 5 days) exists for those connecting on Uzbekistan Airways only, but this session could NOT independently confirm whether Indian passport holders qualify for that specific allowance — verify directly before relying on it.',
    'Up to 72 hours on the consular transit visa; a possible 5-day Uzbekistan-Airways-only allowance is unconfirmed for Indians this session',
    'Embassy of the Republic of Uzbekistan, New Delhi, in advance of travel',
    1,
    'Reported around 3 working days for the consular transit visa',
    'Embassy of the Republic of Uzbekistan, New Delhi',
    'Confirm your connection genuinely requires leaving the international transit zone\nIf Uzbekistan Airways is carrying your full itinerary, check directly with the airline/airport whether the visa-free transit allowance applies to Indian passports (NOT independently confirmed this session)\nOtherwise, apply for a consular transit visa at the Embassy with your onward ticket and itinerary\nSubmit documents in advance of travel',
    '/assets/images/visa-heroes/uzbekistan.webp',
    'Cross-checked against transit-visa and visa-free-transit-allowance secondary sourcing, triangulated across multiple sources (WebFetch blocked this session) — Indian eligibility for the Uzbekistan-Airways-only allowance flagged as unconfirmed', 'https://gov.uz', '2026-09-17'
);
SET @uzb6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@uzb6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb6, 'Core Documents', 'Required if a consular transit visa is needed.', 1);
SET @uzb6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@uzb6s1, 'Onward Flight/Rail Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @uzb6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(103, 6, NULL, 'USD', 'Confirmed After Assessment', 'No reliable government-quoted transit visa fee figure surfaced this session — NOT independently confirmed; contact us or the Embassy to confirm before applying.', '2026-09-01', NOW(), 'https://gov.uz', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian travellers use the Uzbekistan-Airways-only visa-free transit allowance?', 'Unclear from this session''s research — a 5-day visa-free transit allowance exists for Uzbekistan-Airways-only connections, but Indian eligibility for it was NOT independently confirmed. Treat the standard consular transit visa as the safe default until you verify directly with the Embassy or airline.', 103, 6, 10350, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Consular Visa, Not e-Visa Eligible
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    103, 7, 'UZB-MED-IN-07', '2026.09', 'published',
    'Travel to Uzbekistan for medical treatment at an accredited institution.',
    'Indian nationals travelling for treatment need a consular Medical visa, issued for up to 3 months, requiring an invitation from an accredited Uzbek medical institution. This session found the Medical visa described as a passport "sticker visa" requiring an Embassy application, not the online e-Visa.',
    'Up to 3 months',
    'Embassy of the Republic of Uzbekistan, New Delhi, with an invitation from the treating institution',
    1,
    'Processing reported similar to other consular (non-e-Visa) categories; confirm the current timeline with the Embassy',
    'Embassy of the Republic of Uzbekistan, New Delhi',
    'Obtain an invitation/confirmation from the accredited Uzbek medical institution\nGather medical records and referral documentation\nArrange proof of funds for treatment\nSubmit the consular application at the Embassy\nCollect the visa and travel',
    '/assets/images/visa-heroes/uzbekistan.webp',
    'Cross-checked against medical-visa secondary sourcing describing the sticker-visa/consular requirement, triangulated across multiple sources (WebFetch blocked this session)', 'https://gov.uz', '2026-09-17'
);
SET @uzb7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@uzb7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb7, 'Core Documents', 'Required from every applicant.', 1);
SET @uzb7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@uzb7s1, 'Invitation from Accredited Medical Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @uzb7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@uzb7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(103, 7, NULL, 'USD', 'Confirmed After Assessment', 'No reliable government-quoted Medical visa fee figure surfaced this session — NOT independently confirmed; contact us or the Embassy to confirm before applying.', '2026-09-01', NOW(), 'https://gov.uz', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for a Uzbekistan Medical visa through the e-Visa portal?', 'This session''s research indicates the Medical visa is a consular "sticker visa" applied for directly at the Embassy, not through the online e-Visa system — confirm the current position with the Embassy before travelling.', 103, 7, 10360, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — e-Visa Business Category / Consular
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    103, 8, 'UZB-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade fairs in Uzbekistan.',
    'Indian nationals attending a conference typically use the e-Visa business category, backed by a conference invitation or registration confirmation, or a consular visa with an MFA-confirmed invitation from the host organizer for longer or officially-hosted events.',
    'Up to 30 days per stay on e-Visa',
    'e-Visa portal (e-visa.gov.uz), business category, or Embassy of Uzbekistan, New Delhi for MFA-confirmed invitations',
    0,
    'e-Visa typically issued within 2-3 working days',
    'Embassy of the Republic of Uzbekistan, New Delhi',
    'Obtain a conference invitation or registration confirmation from the host organizer\nGather proof of accommodation and return travel\nApply via the e-Visa business category online, or submit the consular application at the Embassy\nPay the applicable fee\nReceive the e-Visa by email, or collect the visa from the Embassy',
    '/assets/images/visa-heroes/uzbekistan.webp',
    'Cross-checked against e-Visa business-category secondary sourcing for conference/event travel, triangulated across multiple sources (WebFetch blocked this session)', 'https://e-visa.gov.uz', '2026-09-17'
);
SET @uzb8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@uzb8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb8, 'Core Documents', 'Required from every applicant.', 1);
SET @uzb8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@uzb8s1, 'Conference Invitation/Registration Confirmation', NULL, 'both', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @uzb8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@uzb8s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(103, 8, 20.00, 'USD', 'e-Visa Business Single-Entry Fee', 'Same tiered schedule as Tourist/Business (USD 20/35/50 for single/double/multiple entry) is reported to apply.', '2026-09-01', NOW(), 'https://e-visa.gov.uz', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Conference visa category in Uzbekistan?', 'Not as a distinct e-Visa type — conference attendance is typically processed under the existing e-Visa business category, or via a consular visa with an MFA-confirmed invitation for larger official events.', 103, 8, 10370, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — e-Visa Business/Private Category / Consular
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    103, 9, 'UZB-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Uzbekistan.',
    'Indian nationals competing or officiating typically use the e-Visa business category with an event invitation from the organizer/federation, or a consular visa with an MFA-confirmed invitation for larger official tournaments.',
    'Up to 30 days per stay on e-Visa',
    'e-Visa portal (e-visa.gov.uz), business category, or Embassy of Uzbekistan, New Delhi for MFA-confirmed invitations',
    0,
    'e-Visa typically issued within 2-3 working days',
    'Embassy of the Republic of Uzbekistan, New Delhi',
    'Obtain an invitation letter from the host event organizer/sports federation with event details\nGather confirmation of your role (athlete/official/support staff) from your home-country sports association\nApply via the e-Visa business category online, or submit the consular application at the Embassy\nPay the applicable fee\nReceive the e-Visa by email, or collect the visa from the Embassy',
    '/assets/images/visa-heroes/uzbekistan.webp',
    'Cross-checked against e-Visa business-category secondary sourcing for event/sports travel; Sports-specific documentary requirements NOT independently confirmed as a distinct category this session (WebFetch blocked)', 'https://e-visa.gov.uz', '2026-09-17'
);
SET @uzb9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@uzb9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb9, 'Core Documents', 'Required from every applicant.', 1);
SET @uzb9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@uzb9s1, 'Host Event Organizer Invitation Letter', NULL, 'both', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @uzb9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb9s2, 'Home-Country Sports Association/Federation Letter', NULL, 'copy', 0, 1, 0, 1),
(@uzb9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(103, 9, 20.00, 'USD', 'e-Visa Business Single-Entry Fee', 'Same tiered schedule as Tourist/Business (USD 20/35/50 for single/double/multiple entry) is reported to apply, in the absence of a distinct Sports visa category.', '2026-09-01', NOW(), 'https://e-visa.gov.uz', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports visa category for Uzbekistan?', 'Not as a distinct e-Visa type in this session''s research — sporting event travel is typically processed under the existing e-Visa business category, or via a consular visa with an MFA-confirmed invitation for larger official tournaments. Confirm event-specific requirements with the organizer.', 103, 9, 10380, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification / Residence Route
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    103, 10, 'UZB-DEP-IN-10', '2026.09', 'published',
    'Spouse or minor children joining an Indian national legally resident or working in Uzbekistan.',
    'Family members of an Indian national holding a qualifying work permit or residence status in Uzbekistan (e.g. a Highly Qualified Specialist work-permit holder). This session found only general foreigner family-reunification rules, not an India-specific published process — treat details as best-effort structure pending direct confirmation.',
    'Tied to the sponsor''s permit/residence validity',
    'In person at the Embassy of the Republic of Uzbekistan, New Delhi, with the sponsor''s permit and relationship proof',
    1,
    'NOT independently confirmed this session; general residence-permit processing in Uzbekistan is reported to require registration with the Ministry of Internal Affairs within 1 working day of arrival',
    'Embassy of the Republic of Uzbekistan, New Delhi',
    'Confirm the sponsor holds a qualifying work permit or residence status in Uzbekistan\nGather relationship proof (marriage/birth certificates) and the sponsor''s permit copy\nBook an Embassy appointment and submit in person\nTravel to Uzbekistan and register with the Ministry of Internal Affairs within 1 working day of arrival, per general foreigner rules\nApply for the dependent''s own residence registration if staying long-term',
    '/assets/images/visa-heroes/uzbekistan.webp',
    'Cross-checked against general Uzbek foreigner family-reunification and residence-permit secondary sourcing; NOT independently confirmed this session for India-specific process details (WebFetch blocked)', 'https://gov.uz', '2026-09-17'
);
SET @uzb10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@uzb10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb10, 'Core Documents', 'Required from every applicant.', 1);
SET @uzb10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@uzb10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@uzb10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit/status.', 2);
SET @uzb10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@uzb10s2, 'Sponsor''s Work Permit/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@uzb10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(103, 10, NULL, 'USD', 'Confirmed After Assessment', 'No reliable government-quoted Dependent/family-reunification visa fee figure surfaced this session — NOT independently confirmed; contact us or the Embassy to confirm before applying.', '2026-09-01', NOW(), 'https://gov.uz', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Dependent visa process the same for every sponsor type?', 'Not confirmed this session — general Uzbek rules describe family reunification for residents/permit-holders, but an India-specific published Dependent-visa checklist did not surface. Confirm your sponsor''s specific permit category with the Embassy before applying.', 103, 10, 10390, 1);
