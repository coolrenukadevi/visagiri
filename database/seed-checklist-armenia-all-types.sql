-- Armenia Visa Checklist Engine content for all 10 visa types — researched
-- via live web search this session (WebSearch tool available; WebFetch was
-- blocked for india.mfa.am and evisa.mfa.am by the network egress proxy).
-- Findings triangulated from indexed secondary sources: Armenia Ministry
-- of Foreign Affairs e-Visa portal summaries, Armenian immigration-law
-- firms (armenian-lawyer.com, mblegal.am, Vardanyan & Partners), and
-- Indian visa agencies (BTW Visas, MakeMyTrip, PolicyBazaar, Acko).
-- AMD fee figures were corroborated across 3+ independent sources; USD/INR
-- equivalents are approximate market-rate conversions, not official
-- Armenian figures.
--
-- GENUINE SOURCING CONFLICT FLAGGED: sources disagree on whether Indian
-- nationals can still complete the e-Visa (evisa.mfa.am) process fully
-- online. Government Decision No. 1692-N (October 2024) tightened e-Visa
-- document requirements specifically for India, Iraq, and Egypt (mandatory
-- travel health insurance, plus either a qualifying third-country visa/
-- residence permit OR a return ticket + Armenian-entity invitation letter
-- + bank statement) — several sources describe this as e-Visa access
-- narrowing, not ending. Other sources report e-Visas were suspended
-- outright for these three nationalities in October 2024, requiring
-- embassy application instead. Both channels are documented below;
-- applicants should confirm the live channel with the Embassy of the
-- Republic of Armenia, New Delhi immediately before applying.
--
-- Armenia's real, distinctive facts verified this session:
--   - No visa-on-arrival for Indians per Embassy-of-Armenia-sourced
--     reporting — yet other secondary sources claim VOA is offered at
--     Zvartnots Intl Airport. Flagged as a live discrepancy; the e-Visa/
--     embassy route is presented as the reliable path throughout.
--   - Mandatory travel health insurance became a specific, named baseline
--     requirement for Indian (plus Iraqi and Egyptian) applicants only,
--     under Government Decision No. 1692-N, dated October 2024.
--   - A temporary visa-free window: 1 Jan - 1 Jul 2026, Indian nationals
--     holding a valid residence permit from the US, EU/Schengen, UK, UAE,
--     Bahrain, Qatar, Saudi Arabia, Kuwait, or Oman may enter Armenia
--     visa-free for up to 180 days — a genuinely dated, narrow exception.
--   - Work authorization issues as a single combined work-and-residence
--     card (not two separate documents), administered end-to-end through
--     the Workpermit.am electronic platform under Migration Service
--     supervision.
--   - Armenia has no formal "digital nomad visa"; remote workers commonly
--     register as a Private Entrepreneur for a 1-year temporary residence
--     permit instead — a structurally different route from a work permit.
--   - From 1 August 2026, amendments to Armenia's "On Foreigners" law
--     introduce a new unified electronic residency platform; extended-
--     family sponsorship (siblings/grandparents/grandchildren by permanent
--     residents) is separately reported to end 1 November 2026 — both
--     dated, upcoming changes relevant to Family Visit/Dependent seekers.
--   - Armenia is a popular MBBS destination for Indian students (NEET
--     qualification compulsory, Class 12 PCB required) — a distinct
--     pattern versus most European destinations in this dataset.
--   - Armenia's e-Visa system does not formally split Medical, Conference,
--     or Sports into separate visa categories the way some countries do;
--     these route through the same Tourist/Business e-Visa category with
--     a purpose-specific invitation letter, which is reflected below.
--
-- country_id 56 = Armenia. visa_type_id: 1=Tourist, 2=Business, 3=Student,
-- 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference, 9=Sports,
-- 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — e-Visa / Embassy Short-Stay
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    56, 1, 'ARM-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Armenia.',
    'Indian passport holders — apply via the e-Visa portal (single-entry, 21 or 120 days) or, per some sources, directly at the Embassy of Armenia, New Delhi. Mandatory travel health insurance applies specifically to Indian nationals since a October 2024 government decision tightened requirements.',
    'Single entry, up to 21 or 120 days depending on the e-Visa tier chosen',
    'e-Visa via evisa.mfa.am, or in person at the Embassy of Armenia, New Delhi — confirm the current channel before applying',
    1,
    'e-Visa typically processed within 3 working days; the embassy route is reported at around 10 working days',
    'Embassy of the Republic of Armenia, New Delhi (E-8/12, Vasant Vihar)',
    'Confirm whether the e-Visa portal or embassy is the live channel for Indian applicants\nGather a qualifying third-country visa/residence permit copy, or a return ticket + invitation + bank statement\nArrange mandatory travel health insurance\nSubmit the application online or at the embassy\nReceive the e-Visa by email, or collect the visa from the embassy',
    '/assets/images/visa-heroes/armenia.webp',
    'Cross-checked against Embassy of Armenia to India and e-Visa portal secondary sourcing, and Indian visa-agency guidance; india.mfa.am and evisa.mfa.am were blocked to direct fetch this session',
    'https://india.mfa.am/en/visaforindians/',
    '2026-09-17'
);
SET @arm1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@arm1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm1, 'Core Documents', 'Required from every applicant.', 1);
SET @arm1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@arm1s1, 'Completed e-Visa or Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@arm1s1, 'Recent Digital Passport-Size Photograph', NULL, 'original', 1, 0, 1, 3),
(@arm1s1, 'Travel Health Insurance', 'Mandatory specifically for Indian nationals since October 2024.', 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm1, 'Supporting Documents', 'Evidence of your travel plans, funds, and eligibility route.', 2);
SET @arm1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@arm1s2, 'Proof of Qualifying Visa/Residence Permit (US, EU/Schengen, UK, GCC, etc.)', 'Exempts you from the invitation-letter/bank-statement route.', 'copy', 0, 1, 0, 2),
(@arm1s2, 'Invitation Letter from an Armenia-Registered Entity', 'Required only if you lack a qualifying third-country visa/residence permit.', 'original', 0, 1, 0, 3),
(@arm1s2, 'Bank Statement (Last 3 Months)', NULL, 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(56, 1, 15000.00, 'AMD', '120-Day Single-Entry e-Visa Fee', 'A shorter 21-day single-entry tier is also available for AMD 3,000 (~USD 8). The 120-day tier costs roughly USD 38. Confirm the current fee on evisa.mfa.am before paying.', '2026-09-01', NOW(), 'https://evisa.mfa.am/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens get a visa on arrival in Armenia?', 'Reporting conflicts on this point. The Embassy of Armenia to India has been cited as saying visa-on-arrival is not offered to Indian nationals, while some travel-agency sources claim it is available at Zvartnots International Airport. Apply for the e-Visa or embassy visa in advance rather than relying on arrival processing.', 56, 1, 5600, 1),
('Is travel insurance really mandatory for Indian tourists?', 'Yes — under a Government Decision (No. 1692-N) reported from October 2024, Armenia specifically added mandatory travel health insurance as a baseline e-Visa requirement for Indian, Iraqi, and Egyptian nationals.', 56, 1, 5601, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — e-Visa / Embassy Short-Stay
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    56, 2, 'ARM-BUS-IN-02', '2026.09', 'published',
    'Trade, negotiations, and commercial meetings in Armenia.',
    'Indian nationals travelling for business use the same e-Visa/embassy channel as Tourist, distinguished by a business invitation letter from an Armenia-registered company. Mandatory travel health insurance applies to Indian applicants.',
    'Single entry, up to 21 or 120 days depending on the e-Visa tier chosen',
    'e-Visa via evisa.mfa.am with a business invitation letter, or in person at the Embassy of Armenia, New Delhi',
    1,
    'e-Visa typically processed within 3 working days; the embassy route is reported at around 10 working days',
    'Embassy of the Republic of Armenia, New Delhi',
    'Obtain a business invitation letter from the Armenian host company\nGather the Indian employer sponsorship/forwarding letter\nArrange mandatory travel health insurance\nSubmit the e-Visa application or apply at the embassy',
    '/assets/images/visa-heroes/armenia.webp',
    'Cross-checked against e-Visa portal secondary sourcing and Indian visa-agency guidance; evisa.mfa.am was blocked to direct fetch this session',
    'https://evisa.mfa.am/',
    '2026-09-17'
);
SET @arm2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@arm2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm2, 'Core Documents', 'Required from every applicant.', 1);
SET @arm2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@arm2s1, 'Business Invitation Letter from Armenian Host Company', 'On official letterhead, signed and sealed.', 'original', 1, 0, 1, 2),
(@arm2s1, 'Travel Health Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm2, 'Supporting Documents', 'Evidence of your own employment and financial standing.', 2);
SET @arm2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@arm2s2, 'Bank Statement (Last 3 Months)', NULL, 'copy', 0, 1, 0, 2),
(@arm2s2, 'Business Registration Proof', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(56, 2, 15000.00, 'AMD', '120-Day Single-Entry e-Visa Fee', 'Same fee structure as Tourist. A 21-day tier is available for AMD 3,000 (~USD 8).', '2026-09-01', NOW(), 'https://evisa.mfa.am/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Armenia have a separate Business e-Visa category?', 'Not a formally distinct one — Business applications use the same e-Visa system as Tourist, differentiated mainly by the invitation letter and purpose declared.', 56, 2, 5610, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Long-Term/Embassy Route
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    56, 3, 'ARM-STU-IN-03', '2026.09', 'published',
    'Enrolling in an Armenian university or institution, including MBBS/medical programs.',
    'Indian nationals admitted to an Armenian institution — popular for MBBS, requiring Class 12 PCB and a compulsory NEET qualification. Apply in person at the Embassy of Armenia, New Delhi with the university admission letter, then convert to a residence permit after arrival.',
    'Student visa typically issued for around 90 days initially, then converted to a renewable temporary residence permit for the program duration',
    'Apply in person at the Embassy of the Republic of Armenia, New Delhi with the university admission/invitation letter',
    1,
    'Reported at 7-15 working days from the Embassy of Armenia, New Delhi',
    'Embassy of the Republic of Armenia, New Delhi',
    'Secure admission at a recognized Armenian institution and receive the invitation letter (reported within ~4 working days of applying)\nGather NEET scorecard and academic records (for MBBS/medical applicants)\nBook an embassy appointment in New Delhi\nSubmit the application and required documents in person\nTravel and register for a temporary residence permit in Armenia',
    '/assets/images/visa-heroes/armenia.webp',
    'Cross-checked against Indian MBBS-in-Armenia education consultancy sourcing and Embassy of Armenia secondary reporting; india.mfa.am was blocked to direct fetch this session',
    'https://india.mfa.am/en/visaforindians/',
    '2026-09-17'
);
SET @arm3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@arm3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm3, 'Core Documents', 'Required from every applicant.', 1);
SET @arm3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@arm3s1, 'Admission/Invitation Letter from Armenian Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm3, 'Supporting Documents', 'Evidence of academic eligibility, funds, and health cover.', 2);
SET @arm3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm3s2, 'Class 12 Mark Sheet (PCB) and Academic Transcripts', NULL, 'copy', 1, 0, 0, 1),
(@arm3s2, 'NEET Scorecard', 'Compulsory for MBBS/medical program applicants.', 'copy', 0, 1, 0, 2),
(@arm3s2, 'Proof of Funds/Tuition Payment', NULL, 'copy', 1, 0, 0, 3),
(@arm3s2, 'Medical Fitness Certificate', NULL, 'original', 1, 0, 0, 4),
(@arm3s2, 'Guardian Consent Letter (Minors)', NULL, 'original', 0, 1, 0, 5);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(56, 3, NULL, 'INR', 'Confirmed After Assessment', 'Reported in the INR 10,000-15,000 range depending on institution and duration; figures vary across sources, contact us to confirm the current embassy fee.', '2026-09-01', NOW(), 'https://india.mfa.am/en/visaforindians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Why is Armenia popular with Indian medical students?', 'Armenia hosts several MBBS programs favoured by Indian students; eligibility commonly requires Class 12 with Physics, Chemistry, and Biology (at least 50%, 40% for SC/ST/OBC) and a compulsory NEET qualification.', 56, 3, 5620, 1),
('Do I need a separate residence permit after my student visa?', 'Yes — the initial student visa is short-term (around 90 days); students are expected to convert to a renewable temporary residence permit in Armenia to cover the full program duration.', 56, 3, 5621, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Combined Work-and-Residence Card
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    56, 4, 'ARM-WORK-IN-04', '2026.09', 'published',
    'Employment with an Armenian employer via a combined work-and-residence permit.',
    'Indian nationals with a confirmed job offer. The employer generally must first prove the role cannot be filled by an Armenian citizen (market test) and posts the vacancy via Workpermit.am; approval from the Ministry of Labour and Social Affairs follows, and the employment contract must be signed within 15 working days of receiving residence status.',
    'Combined work-and-residence card valid up to 1 year, renewable',
    'Employer-driven application through the Workpermit.am electronic platform, under Migration Service supervision',
    1,
    'Work-permit portion reported at around 14 business days once the Ministry of Labour and Social Affairs receives complete documents',
    'Migration Service of Armenia / Workpermit.am platform, Yerevan; Embassy of Armenia, New Delhi for the entry visa if required',
    'Secure a job offer from an Armenian employer\nEmployer posts the vacancy on Workpermit.am and completes the market test (unless exempt)\nMinistry of Labour and Social Affairs reviews and approves\nSign the employment contract within 15 working days of receiving residence status\nCollect the combined work-and-residence card',
    '/assets/images/visa-heroes/armenia.webp',
    'Cross-checked against Armenian immigration-law-firm reporting (armenian-lawyer.com, EURAXESS Armenia) and Workpermit.am platform secondary sourcing; direct fetch of workpermit.am was not attempted this session',
    'https://workpermit.am/en/home',
    '2026-09-17'
);
SET @arm4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@arm4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm4, 'Core Documents', 'Required from every applicant.', 1);
SET @arm4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@arm4s1, 'Employment Contract', 'Must cover transport, insurance, accommodation, and return arrangements per Armenian labour law.', 'copy', 1, 0, 1, 2),
(@arm4s1, 'Vacancy/Market-Test Confirmation from Workpermit.am', 'Unless the role is exempt from the market test.', 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @arm4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@arm4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@arm4s2, 'Medical Fitness Certificate', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(56, 4, 130000.00, 'AMD', 'Combined Work Permit + Temporary Residence Permit Fee (Approximate)', 'Reported as roughly AMD 25,000 (~USD 65) for the work permit plus AMD 105,000 (~USD 275) for the temporary residence permit; figures vary across sources, contact us to confirm.', '2026-09-01', NOW(), 'https://workpermit.am/en/home', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Armenia issue a separate work permit and residence permit?', 'No — Armenia issues a single combined work-and-residence card rather than two separate documents, a genuine structural difference from many other countries.', 56, 4, 5630, 1),
('Can Indians work remotely from Armenia without this Work visa?', 'Armenia has no formal digital nomad visa; remote workers commonly register as a Private Entrepreneur for a 1-year temporary residence permit instead, which is a structurally different route from this employer-sponsored Work permit.', 56, 4, 5631, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — e-Visa / Embassy Short-Stay
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    56, 5, 'ARM-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Armenia.',
    'Indian nationals with family or friends in Armenia use the same e-Visa/embassy channel as Tourist, with an invitation letter from the host and proof of relationship. Mandatory travel health insurance applies to Indian applicants.',
    'Single entry, up to 21 or 120 days depending on the e-Visa tier chosen',
    'e-Visa via evisa.mfa.am with a host invitation letter, or in person at the Embassy of Armenia, New Delhi',
    1,
    'e-Visa typically processed within 3 working days; the embassy route is reported at around 10 working days',
    'Embassy of the Republic of Armenia, New Delhi',
    'Obtain an invitation letter from your host in Armenia\nGather documents proving the family or personal relationship\nArrange mandatory travel health insurance\nSubmit the e-Visa application or apply at the embassy',
    '/assets/images/visa-heroes/armenia.webp',
    'Cross-checked against e-Visa portal secondary sourcing and Indian visa-agency guidance; evisa.mfa.am was blocked to direct fetch this session',
    'https://evisa.mfa.am/',
    '2026-09-17'
);
SET @arm5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@arm5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm5, 'Core Documents', 'Required from every applicant.', 1);
SET @arm5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@arm5s1, 'Invitation Letter from Host in Armenia', NULL, 'original', 1, 0, 1, 2),
(@arm5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3),
(@arm5s1, 'Travel Health Insurance', NULL, 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @arm5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm5s2, 'Bank Statement (Last 3 Months)', NULL, 'copy', 0, 1, 0, 1),
(@arm5s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(56, 5, 15000.00, 'AMD', '120-Day Single-Entry e-Visa Fee', 'Same fee structure as Tourist. A 21-day tier is available for AMD 3,000 (~USD 8).', '2026-09-01', NOW(), 'https://evisa.mfa.am/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does my host in Armenia need to be an Armenian citizen?', 'Invitations can come from organisations, government bodies, or individuals in Armenia; secondary sourcing does not indicate the host must hold Armenian citizenship, but they should be able to document their address/status there.', 56, 5, 5640, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    56, 6, 'ARM-TRAN-IN-06', '2026.09', 'published',
    'Passing through Armenia, typically via Zvartnots International Airport, toward an onward destination.',
    'A distinct Transit Visa allowing a stay of up to 3 days if you leave the airport transit zone; not required for a purely airside connection with matching flights, per secondary sourcing.',
    'Up to 3 days',
    'Apply via evisa.mfa.am or at the Embassy of Armenia, New Delhi, only if your connection requires leaving the transit zone',
    1,
    'Reported similarly to the standard e-Visa, around 3 working days',
    'Embassy of the Republic of Armenia, New Delhi',
    'Confirm whether your specific connection requires a Transit Visa (only if leaving the airport transit zone)\nIf required, gather your onward ticket and, if needed, a visa for your final destination\nSubmit the e-Visa application or apply at the embassy\nArrange mandatory travel health insurance',
    '/assets/images/visa-heroes/armenia.webp',
    'Cross-checked against Zvartnots International Airport and e-Visa portal secondary sourcing; evisa.mfa.am was blocked to direct fetch this session — fee figure not independently confirmed this session',
    'https://evisa.mfa.am/',
    '2026-09-17'
);
SET @arm6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@arm6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm6, 'Core Documents', 'Required if a Transit Visa is genuinely needed.', 1);
SET @arm6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@arm6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @arm6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1),
(@arm6s2, 'Travel Health Insurance', NULL, 'original', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(56, 6, NULL, 'AMD', 'Confirmed After Assessment', 'Not independently confirmed this session — secondary sources describe a Transit Visa as generally cheaper than the standard e-Visa tiers; confirm the current fee on evisa.mfa.am before travel.', '2026-09-01', NOW(), 'https://evisa.mfa.am/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa just to change planes at Zvartnots Airport?', 'Not necessarily — a Transit Visa is generally only required if you leave the airport''s international transit zone; a purely airside connection on matching flights is commonly exempt, but confirm with your airline and the embassy before travel.', 56, 6, 5650, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Routed via e-Visa/Embassy
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    56, 7, 'ARM-MED-IN-07', '2026.09', 'published',
    'Travel to Armenia for medical treatment.',
    'Armenia does not operate a formally distinct Medical visa category — Indian nationals travelling for treatment use the same e-Visa/embassy channel as Tourist, submitting a medical certificate or hospital invitation letter in place of a standard invitation.',
    'Single entry, up to 21 or 120 days depending on the e-Visa tier chosen',
    'e-Visa via evisa.mfa.am with a hospital/medical invitation letter, or in person at the Embassy of Armenia, New Delhi',
    1,
    'e-Visa typically processed within 3 working days; allow longer if documentation is incomplete',
    'Embassy of the Republic of Armenia, New Delhi',
    'Obtain a certificate or invitation letter from the treating Armenian hospital/clinic\nArrange mandatory travel health insurance\nGather proof of funds for treatment\nSubmit the e-Visa application or apply at the embassy',
    '/assets/images/visa-heroes/armenia.webp',
    'Cross-checked against e-Visa portal secondary sourcing and general medical-travel guidance; evisa.mfa.am was blocked to direct fetch this session — this category is not independently confirmed as a distinct government visa type',
    'https://evisa.mfa.am/',
    '2026-09-17'
);
SET @arm7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@arm7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm7, 'Core Documents', 'Required from every applicant.', 1);
SET @arm7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@arm7s1, 'Medical Certificate/Hospital Invitation Letter', NULL, 'original', 1, 0, 1, 2),
(@arm7s1, 'Travel Health Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @arm7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@arm7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(56, 7, 15000.00, 'AMD', '120-Day Single-Entry e-Visa Fee', 'Medical travel is not fee-differentiated from the standard e-Visa tiers in the sourcing available this session. A 21-day tier is available for AMD 3,000 (~USD 8).', '2026-09-01', NOW(), 'https://evisa.mfa.am/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Medical visa category for Armenia?', 'Not independently confirmed as a formally distinct government category this session — medical travellers appear to use the standard e-Visa/embassy channel with a hospital invitation letter substituted for a standard one.', 56, 7, 5660, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Routed via Business e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    56, 8, 'ARM-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade fairs in Armenia.',
    'Armenia does not operate a formally distinct Conference visa category — Indian nationals attending a conference use the same Business e-Visa/embassy channel, submitting a conference invitation or registration confirmation.',
    'Single entry, up to 21 or 120 days depending on the e-Visa tier chosen',
    'e-Visa via evisa.mfa.am with a conference invitation/registration confirmation, or in person at the Embassy of Armenia, New Delhi',
    1,
    'e-Visa typically processed within 3 working days; the embassy route is reported at around 10 working days',
    'Embassy of the Republic of Armenia, New Delhi',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nArrange mandatory travel health insurance\nSubmit the e-Visa application or apply at the embassy',
    '/assets/images/visa-heroes/armenia.webp',
    'Cross-checked against e-Visa portal secondary sourcing and Indian visa-agency guidance; evisa.mfa.am was blocked to direct fetch this session — this category is not independently confirmed as a distinct government visa type',
    'https://evisa.mfa.am/',
    '2026-09-17'
);
SET @arm8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@arm8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm8, 'Core Documents', 'Required from every applicant.', 1);
SET @arm8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@arm8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2),
(@arm8s1, 'Travel Health Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @arm8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@arm8s2, 'Bank Statement (Last 3 Months)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(56, 8, 15000.00, 'AMD', '120-Day Single-Entry e-Visa Fee', 'Same fee structure as Business. A 21-day tier is available for AMD 3,000 (~USD 8).', '2026-09-01', NOW(), 'https://evisa.mfa.am/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Conference visa category for Armenia?', 'Not independently confirmed as a formally distinct government category this session — conference attendees appear to use the Business e-Visa/embassy channel with a conference invitation letter.', 56, 8, 5670, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Routed via Business e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    56, 9, 'ARM-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Armenia.',
    'Armenia does not operate a formally distinct Sports visa category — competitors use the same Business/Tourist e-Visa/embassy channel, submitting a letter from their sports federation plus a host-event invitation.',
    'Single entry, up to 21 or 120 days depending on the e-Visa tier chosen',
    'e-Visa via evisa.mfa.am with a federation letter and host-organizer invitation, or in person at the Embassy of Armenia, New Delhi',
    1,
    'e-Visa typically processed within 3 working days; the embassy route is reported at around 10 working days',
    'Embassy of the Republic of Armenia, New Delhi',
    'Obtain a letter from your home sports federation confirming your role\nObtain an invitation letter from the host event organizer in Armenia\nArrange mandatory travel health insurance\nSubmit the e-Visa application or apply at the embassy',
    '/assets/images/visa-heroes/armenia.webp',
    'Cross-checked against e-Visa portal secondary sourcing and Indian visa-agency guidance; evisa.mfa.am was blocked to direct fetch this session — this category is not independently confirmed as a distinct government visa type',
    'https://evisa.mfa.am/',
    '2026-09-17'
);
SET @arm9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@arm9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm9, 'Core Documents', 'Required from every applicant.', 1);
SET @arm9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@arm9s1, 'Home-Country Sports Federation Letter', 'Confirms your role and no-employment status.', 'original', 1, 0, 1, 2),
(@arm9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3),
(@arm9s1, 'Travel Health Insurance', NULL, 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @arm9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(56, 9, 15000.00, 'AMD', '120-Day Single-Entry e-Visa Fee', 'Same fee structure as Business. A 21-day tier is available for AMD 3,000 (~USD 8).', '2026-09-01', NOW(), 'https://evisa.mfa.am/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports visa category for Armenia?', 'Not independently confirmed as a formally distinct government category this session — athletes and officials appear to use the Business/Tourist e-Visa/embassy channel with sports-specific invitation letters.', 56, 9, 5680, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification Residence Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    56, 10, 'ARM-DEP-IN-10', '2026.09', 'published',
    'Spouse, minor children, or dependent parents joining an Armenia-based citizen or resident sponsor.',
    'Family members of an Indian national (or other sponsor) holding Armenian citizenship or a valid residence permit. Temporary-status holders may sponsor a spouse, parent, or child; permanent residents may additionally sponsor siblings, grandparents, or grandchildren, though this extended-family route is reported to end 1 November 2026.',
    'Tied to the sponsor''s residence status; typically 1 year, renewable',
    'Apply via Armenia''s residency e-platform (migration.e-gov.am), sponsored by the Armenia-based family member',
    1,
    'Timelines vary by sponsor status; a new unified electronic residency platform is reported to take effect 1 August 2026',
    'Migration Service of Armenia (residency e-platform); Embassy of Armenia, New Delhi for the entry visa if required',
    'Confirm the sponsor holds qualifying citizenship or a residence permit\nGather relationship proof (marriage/birth certificates) and the sponsor''s permit/citizenship copy\nSubmit the family-reunification application via the residency e-platform\nAttend any required biometrics/interview\nCollect the dependent residence permit',
    '/assets/images/visa-heroes/armenia.webp',
    'Cross-checked against Armenian immigration-law-firm reporting (mblegal.am, Repat Armenia, armanestan.org) on family-reunification residence permits; migration.e-gov.am was not directly fetched this session',
    'https://migration.e-gov.am/en/service/residency_application/info',
    '2026-09-17'
);
SET @arm10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@arm10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm10, 'Core Documents', 'Required from every applicant.', 1);
SET @arm10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@arm10s1, 'Proof of Relationship to Sponsor', 'Marriage certificate for spouses, birth certificate for children/dependents.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@arm10, 'Supporting Documents', 'Evidence tied to the sponsor''s status.', 2);
SET @arm10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@arm10s2, 'Sponsor''s Residence Permit/Citizenship Copy', NULL, 'copy', 1, 0, 0, 1),
(@arm10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@arm10s2, 'Medical Fitness Certificate', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(56, 10, 105000.00, 'AMD', 'Temporary Residence Permit Fee (Approximate)', 'Reported at roughly AMD 105,000 (~USD 275), the same general temporary residence permit fee cited for Work; family-reunification-specific figures were not separately confirmed this session.', '2026-09-01', NOW(), 'https://migration.e-gov.am/en/service/residency_application/info', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can any Armenian resident sponsor extended family members?', 'Only permanent residents (not temporary-status holders) are reported able to sponsor siblings, grandparents, or grandchildren, and this extended-family sponsorship route is separately reported to end on 1 November 2026 — confirm current eligibility before applying.', 56, 10, 5690, 1),
('Is there a new residency system coming for family sponsorship?', 'Yes — amendments to Armenia''s "On Foreigners" law are reported to introduce a new unified electronic residency platform from 1 August 2026, which may change the application process described here.', 56, 10, 5691, 1);
