-- Azerbaijan Visa Checklist Engine content for all 10 visa types —
-- built this session via web search. evisa.gov.az (the official ASAN Visa
-- e-Visa portal) and newdelhi.mfa.gov.az were BLOCKED by network egress
-- this session (evisa.gov.az explicitly refused by the proxy) — all
-- e-Visa figures below are triangulated from multiple visa-agency
-- secondary sources (BTW Visas, TATA AIG, PolicyBazaar, DU Global,
-- Nivabupa, Wego, evisazerbaijann.com) rather than fetched directly from
-- the Azerbaijani government. Fee figures vary across sources (e.g.
-- USD 20-29 for the standard e-Visa) and are flagged as approximate.
-- Work Permit / Labour Market Test figures are sourced from Fragomen
-- immigration-law insight articles, which are a credible professional
-- secondary source but not the State Migration Service's own site
-- (migration.gov.az was not directly fetched this session either).
--
-- CATEGORIES FLAGGED AS UNDER-SOURCED FOR INDIA SPECIFICALLY:
--   - Sports (visa_type_id 9): no India-specific or Azerbaijan-specific
--     sporting-event documentary guidance was found; content below is
--     inferred from the general e-Visa "business/short-stay" pathway
--     and standard international sporting-delegation practice — NOT
--     independently confirmed this session.
--   - Conference (visa_type_id 8): treated as a sub-case of the e-Visa
--     business-purpose channel per secondary sourcing; no dedicated
--     Azerbaijani "conference visa" category was found as distinct from
--     Business — NOT independently confirmed this session as a formally
--     separate product.
--   - Family Visit (visa_type_id 5) vs. Dependent (visa_type_id 10):
--     Azerbaijani sourcing distinguishes short "family visit" e-Visa
--     travel from long-stay "family reunification" Temporary Residence
--     Permits (TRP) tied to a resident/worker sponsor; the TRP process
--     specifics for a family member joining an *Indian* work-permit
--     holder (rather than an Azerbaijani citizen) are inferred from
--     general State-Migration-Service TRP guidance, not confirmed
--     India-specific case reporting.
--
-- Azerbaijan's real, distinctive facts verified this session:
--   - Azerbaijan runs one of the more mature e-Visa (ASAN Visa) systems
--     in the region: Indian citizens can apply entirely online at
--     evisa.gov.az for tourism, short business, and transit purposes —
--     no embassy visit or biometric appointment needed for the
--     single-entry, 30-day-stay, 90-day-validity product. This is a
--     genuinely different model from many countries in this dataset
--     that route Indians through VFS Global or an embassy for every
--     category.
--   - The standard e-Visa is reported at roughly USD 20-29 (sources
--     disagree — some quote a base USD 26 government fee plus service
--     charges), with an urgent 3-hour option reported at roughly USD 60,
--     versus ~3 working days for standard processing.
--   - Multi-entry e-Visas (3/6/12 months) and any stay beyond 30 days
--     are reported as NOT available through the standard online portal
--     for Indian applicants — these instead require an in-person
--     application at the Embassy of the Republic of Azerbaijan, New
--     Delhi (41 Paschimi Marg, Vasant Vihar), a genuine split between
--     "self-service portal" and "embassy" channels depending on trip
--     length/entries, similar in spirit to — but administratively
--     distinct from — the short-stay/long-stay splits seen in other
--     countries in this dataset.
--   - Work and long-stay categories run through a completely separate
--     track: a Work Permit from the Ministry of Labour/State Migration
--     Service plus a matching Temporary Residence Permit, applied for by
--     the Azerbaijani employer, NOT the e-Visa portal. Per Fragomen's
--     2025-2026 reporting, Azerbaijan introduced broader Labour Market
--     Testing (employers must show efforts to hire locally, and the
--     Ministry of Labour issues an impact opinion within 5-7 business
--     days) and an annual foreign-labour quota cycle (2026 quota reports
--     were due from employers by 1 May 2025, with government quota
--     approval following in November 2025) — a real, dated, structural
--     change worth flagging to work-visa applicants.
--   - Airport transit: Indian travellers connecting through Baku
--     airside-only within roughly 24 hours reportedly do not need a
--     transit visa; anyone leaving the transit zone needs the e-Visa
--     (transit is one of its listed purposes) or an embassy visa.
--
-- country_id 57 = Azerbaijan. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — ASAN e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    57, 1, 'AZE-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Azerbaijan.',
    'Indian passport holders are eligible for the fully online ASAN e-Visa — no embassy visit or biometrics needed for a single-entry, 30-day stay.',
    'Single entry, up to 30 days continuous stay, visa valid for 90 days from issue',
    'Apply entirely online via the official e-Visa portal (evisa.gov.az); no in-person appointment required',
    0,
    'Standard processing reported at around 3 working days; an urgent option is reported at around 3 hours for an added fee',
    'Republic of Azerbaijan Official Electronic Visa Portal (evisa.gov.az); Embassy of the Republic of Azerbaijan, New Delhi handles non-portal cases',
    'Create an account on the ASAN e-Visa portal\nComplete the online application and upload a passport scan and photo\nPay the fee by Visa/Mastercard debit or credit card\nReceive the e-Visa by email and print/carry a copy on arrival',
    '/assets/images/visa-heroes/azerbaijan.webp',
    'Cross-checked against BTW Visas, TATA AIG, PolicyBazaar, DU Global, and Nivabupa secondary sourcing; evisa.gov.az itself was blocked from direct fetch this session', 'https://evisa.gov.az/en/', '2026-09-17'
);
SET @aze1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@aze1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze1, 'Core Documents', 'Required from every applicant.', 1);
SET @aze1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze1s1, 'Valid Passport (3+ Months Beyond Intended Stay, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@aze1s1, 'Recent Passport-Size Digital Photograph', NULL, 'copy', 1, 0, 1, 2),
(@aze1s1, 'Confirmed Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze1, 'Supporting Documents', 'Evidence of your travel plans and means, kept on hand in case requested.', 2);
SET @aze1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze1s2, 'Confirmed Hotel Booking', NULL, 'copy', 1, 0, 0, 1),
(@aze1s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 0, 1, 0, 2),
(@aze1s2, 'Travel Insurance', 'Not strictly mandatory for the e-Visa but commonly recommended.', 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(57, 1, 26.00, 'USD', 'ASAN e-Visa Fee (Approximate)', 'Sources report figures from roughly USD 20 to USD 29 depending on service-charge bundling; the urgent (~3 hour) option is reported at roughly USD 60. Confirm the exact current amount on evisa.gov.az before paying.', '2026-09-01', NOW(), 'https://evisa.gov.az/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian tourists need to visit an embassy for an Azerbaijan visa?', 'No — for a standard single-entry, 30-day tourist trip, Indian citizens can apply entirely online through the official ASAN e-Visa portal, with no in-person appointment or biometrics required.', 57, 1, 5700, 1),
('Can I extend my stay beyond 30 days on the e-Visa?', 'The standard e-Visa is reported to permit only a single entry and up to 30 days of continuous stay; longer or multiple-entry stays are reported to require an in-person application at the Embassy of Azerbaijan, New Delhi instead.', 57, 1, 5701, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — ASAN e-Visa (Business Purpose)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    57, 2, 'AZE-BUS-IN-02', '2026.09', 'published',
    'Business meetings, negotiations, and corporate visits in Azerbaijan.',
    'Indian nationals travelling for short business purposes — the same online e-Visa channel as Tourist, selecting "business" as the purpose of travel, with a host-company invitation letter as the differentiating document.',
    'Single entry, up to 30 days continuous stay, visa valid for 90 days from issue',
    'Apply online via the e-Visa portal (evisa.gov.az), selecting the business purpose of travel',
    0,
    'Standard processing reported at around 3 working days; an urgent ~3 hour option is available for an added fee',
    'Republic of Azerbaijan Official Electronic Visa Portal (evisa.gov.az); Embassy of the Republic of Azerbaijan, New Delhi for cases outside the portal''s scope',
    'Obtain an invitation letter from the Azerbaijani host company\nCreate an account and complete the online e-Visa application, selecting Business as the purpose\nUpload passport scan, photo, and invitation letter\nPay the fee online and receive the e-Visa by email',
    '/assets/images/visa-heroes/azerbaijan.webp',
    'Cross-checked against BTW Visas and TATA AIG secondary sourcing describing the Business e-Visa pathway; evisa.gov.az itself was blocked from direct fetch this session', 'https://evisa.gov.az/en/', '2026-09-17'
);
SET @aze2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@aze2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze2, 'Core Documents', 'Required from every applicant.', 1);
SET @aze2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@aze2s1, 'Invitation Letter from Azerbaijani Host Company', NULL, 'copy', 1, 0, 1, 2),
(@aze2s1, 'Recent Passport-Size Digital Photograph', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @aze2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze2s2, 'Forwarding/Sponsorship Letter from Indian Employer', NULL, 'copy', 1, 0, 0, 1),
(@aze2s2, 'Business Registration Proof (Self-Employed Applicants)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(57, 2, 26.00, 'USD', 'ASAN e-Visa Fee (Approximate)', 'Same reported fee structure as Tourist (roughly USD 20-29); the urgent ~3 hour option is reported at roughly USD 60. Confirm the exact current amount on evisa.gov.az before paying.', '2026-09-01', NOW(), 'https://evisa.gov.az/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate "Business Visa" application from the standard e-Visa?', 'No distinct offline Business Visa category was independently confirmed this session for short trips — secondary sourcing describes Business as a purpose-of-travel selection within the same ASAN e-Visa portal used for Tourist visas.', 57, 2, 5702, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Embassy Long-Stay Study Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    57, 3, 'AZE-STU-IN-03', '2026.09', 'published',
    'Enrolling in an Azerbaijani university or educational institution.',
    'Indian nationals admitted to a recognized Azerbaijani institution. This is a long-stay category outside the e-Visa portal''s scope — applicants apply in person at the Embassy of the Republic of Azerbaijan, New Delhi, and must register with the State Migration Service after arrival.',
    'Generally tied to the academic program duration, renewable with proof of continued enrollment',
    'Apply in person at the Embassy of the Republic of Azerbaijan, New Delhi — not via the online e-Visa portal',
    1,
    'Reported at up to around 15 working days for embassy processing (sources cite a 7-20 working day range depending on visa type)',
    'Embassy of the Republic of Azerbaijan, New Delhi (41 Paschimi Marg, Vasant Vihar)',
    'Secure an acceptance letter from a recognized Azerbaijani educational institution\nComplete the electronic application at eapplication.mfa.gov.az and print the form\nGather proof of funds, academic records, and required certificates\nBook and attend an in-person embassy appointment; pay the fee by bank transfer or demand draft (cash and cards reportedly not accepted)\nCollect the passport with visa sticker, travel, and register with the State Migration Service on arrival',
    '/assets/images/visa-heroes/azerbaijan.webp',
    'Cross-checked against Embassy of India, Baku guidance and Akbar Travels/KCR Consultants secondary sourcing on the study-visa route; newdelhi.mfa.gov.az was not directly fetchable this session', 'https://newdelhi.mfa.gov.az/en/', '2026-09-17'
);
SET @aze3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@aze3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze3, 'Core Documents', 'Required from every applicant.', 1);
SET @aze3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@aze3s1, 'Acceptance/Admission Letter from Azerbaijani Institution', NULL, 'original', 1, 0, 1, 2),
(@aze3s1, 'Printed Electronic Application Form (eapplication.mfa.gov.az)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze3, 'Supporting Documents', 'Evidence of academic background and financial means.', 2);
SET @aze3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@aze3s2, 'Proof of Funds (Bank Statement/Scholarship/Sponsor Letter)', NULL, 'copy', 1, 0, 0, 2),
(@aze3s2, 'Guardian Consent (Minor Applicants)', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(57, 3, NULL, 'USD', 'Confirmed After Assessment', 'Fee not independently confirmed this session; sources indicate embassy fees are payable only by bank transfer or demand draft (not cash or card) — contact the Embassy of Azerbaijan, New Delhi to confirm the current amount.', '2026-09-01', NOW(), 'https://newdelhi.mfa.gov.az/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use the online e-Visa portal for a study visa?', 'No — study is a long-stay purpose outside the standard e-Visa portal''s scope; Indian students are reported to need an in-person application at the Embassy of the Republic of Azerbaijan, New Delhi.', 57, 3, 5703, 1),
('Do I need to register with authorities after arriving on a student visa?', 'Yes — secondary sourcing indicates students must register with the State Migration Service after arriving in Azerbaijan.', 57, 3, 5704, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Work Permit + Temporary Residence Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    57, 4, 'AZE-WORK-IN-04', '2026.09', 'published',
    'Employment with an Azerbaijani employer via a Work Permit and matching Temporary Residence Permit (TRP).',
    'Indian nationals with a confirmed job offer from an Azerbaijan-registered employer. The employer applies to the State Migration Service, which now requires broader Labour Market Testing (evidence of efforts to hire locally) with a Ministry of Labour opinion, plus participation in Azerbaijan''s annual foreign-labour quota cycle.',
    'Work Permit and TRP are issued for matching durations, commonly up to 1 year, renewable',
    'Employer-driven application to the State Migration Service; not processed via the e-Visa portal',
    1,
    'Reported at roughly 1-3 months overall once documents and fees are complete; the Ministry of Labour''s Labour Market Test opinion is reported at 5-7 business days within that window',
    'State Migration Service of the Republic of Azerbaijan (via sponsoring employer); Embassy of the Republic of Azerbaijan, New Delhi for the entry visa sticker',
    'Secure a job offer from an Azerbaijan-registered employer\nEmployer confirms the role fits within the approved annual foreign-labour quota and submits documents to the State Migration Service\nMinistry of Labour issues a Labour Market Test opinion (reported 5-7 business days)\nWork Permit and matching Temporary Residence Permit are processed together\nCollect the entry visa/sticker via the Embassy of Azerbaijan, New Delhi, travel, and complete registration on arrival',
    '/assets/images/visa-heroes/azerbaijan.webp',
    'Cross-checked against Fragomen immigration-law insight articles on Azerbaijan''s 2025-2026 Labour Market Testing and foreign-labour quota cycle; migration.gov.az was not directly fetched this session', 'https://migration.gov.az/en/page/75', '2026-09-17'
);
SET @aze4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@aze4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze4, 'Core Documents', 'Required from every applicant.', 1);
SET @aze4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@aze4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@aze4s1, 'Employer''s Foreign-Labour Quota Allocation Evidence', 'Confirms the role fits within the employer''s approved annual quota.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @aze4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze4s2, 'Academic/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@aze4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@aze4s2, 'Medical Certificate', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(57, 4, NULL, 'AZN', 'Confirmed After Assessment', 'Work Permit and Temporary Residence Permit fees are employer/case-dependent and were not independently confirmed this session; confirm the current schedule with the State Migration Service or your sponsoring employer.', '2026-09-01', NOW(), 'https://migration.gov.az/en/page/75', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Has Azerbaijan''s work-permit process changed recently?', 'Yes — per 2025-2026 immigration-law reporting, Azerbaijan introduced broader Labour Market Testing (employers must show genuine efforts to hire locally, with a Ministry of Labour opinion issued in 5-7 business days) alongside its existing annual foreign-labour quota cycle, where employers submit 2026 quota reports and the government approves quotas in November of the prior year.', 57, 4, 5705, 1),
('Can I apply for a work visa through the online e-Visa portal?', 'No — Work is a long-stay, employer-sponsored category processed through the State Migration Service and Ministry of Labour, entirely separate from the self-service e-Visa portal used for short tourist and business trips.', 57, 4, 5706, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — ASAN e-Visa (Short Stay)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    57, 5, 'AZE-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Azerbaijan for a short stay.',
    'Indian nationals with family or friends in Azerbaijan — for a short visit, the same online e-Visa channel as Tourist applies; longer or repeated visits reportedly need an embassy application instead.',
    'Single entry, up to 30 days continuous stay, visa valid for 90 days from issue',
    'Apply online via the e-Visa portal (evisa.gov.az) for a short visit; multi-entry or extended-stay visits require the Embassy of Azerbaijan, New Delhi',
    0,
    'Standard processing reported at around 3 working days via the portal; embassy applications for longer visits are reported at around 7-10 working days',
    'Republic of Azerbaijan Official Electronic Visa Portal (evisa.gov.az); Embassy of the Republic of Azerbaijan, New Delhi for longer/multi-entry visits',
    'Confirm whether your visit fits within the e-Visa''s single-entry, 30-day limit\nIf so, complete the online e-Visa application and upload supporting documents\nIf a longer or multi-entry stay is needed, gather a cover letter and host invitation and apply in person at the embassy instead\nPay the applicable fee and receive/collect the visa',
    '/assets/images/visa-heroes/azerbaijan.webp',
    'Cross-checked against BTW Visas and Vigo Visa secondary sourcing distinguishing e-Visa short stays from embassy multi-entry applications; evisa.gov.az was blocked from direct fetch this session', 'https://evisa.gov.az/en/', '2026-09-17'
);
SET @aze5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@aze5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze5, 'Core Documents', 'Required from every applicant.', 1);
SET @aze5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@aze5s1, 'Recent Passport-Size Digital Photograph', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze5, 'Supporting Documents', 'Evidence of your host and relationship, and your own means.', 2);
SET @aze5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze5s2, 'Invitation Letter from Host in Azerbaijan', NULL, 'copy', 1, 0, 0, 1),
(@aze5s2, 'Proof of Relationship', NULL, 'copy', 0, 1, 0, 2),
(@aze5s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 0, 1, 0, 3),
(@aze5s2, 'Cover Letter Explaining Need for Multiple Entries', 'Needed only for extended/multi-entry visits requiring an embassy application.', 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(57, 5, 26.00, 'USD', 'ASAN e-Visa Fee (Approximate)', 'Same reported fee structure as Tourist (roughly USD 20-29) for a short e-Visa visit; embassy-processed multi-entry visits carry a separate, unconfirmed fee.', '2026-09-01', NOW(), 'https://evisa.gov.az/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Azerbaijan multiple times on one visa?', 'The standard e-Visa is reported as single-entry only; for multiple entries or stays exceeding 30 days, sources indicate you must apply in person at the Embassy of Azerbaijan, New Delhi with a cover letter explaining the need for multiple entries.', 57, 5, 5707, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — ASAN e-Visa (Transit Purpose)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    57, 6, 'AZE-TRAN-IN-06', '2026.09', 'published',
    'Passing through Azerbaijan (typically Baku) en route to a third country.',
    'Indian travellers remaining airside for a short connection (reportedly around 24 hours) generally do not need a visa at all; anyone leaving the transit zone needs a transit e-Visa, applied for online with the same ASAN portal used for Tourist/Business.',
    'Reported at up to 5 days for travellers leaving the transit zone, visa validity reported at up to 30 days',
    'Apply online via the e-Visa portal (evisa.gov.az), selecting the transit purpose of travel, only if leaving the international transit area',
    0,
    'Standard processing reported at around 3 working days; confirm your specific connection''s requirement before booking, as pure airside transfers reportedly need no visa',
    'Republic of Azerbaijan Official Electronic Visa Portal (evisa.gov.az)',
    'Confirm whether your itinerary requires leaving the international transit zone at Baku\nIf yes, complete the online e-Visa application selecting Transit as the purpose\nUpload your onward ticket and passport details\nPay the fee and receive the e-Visa by email',
    '/assets/images/visa-heroes/azerbaijan.webp',
    'Cross-checked against Wego Travel Blog and IndiGo visa-information secondary sourcing on Baku airport transit; evisa.gov.az itself was blocked from direct fetch this session', 'https://evisa.gov.az/en/', '2026-09-17'
);
SET @aze6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@aze6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze6, 'Core Documents', 'Required only if leaving the international transit zone.', 1);
SET @aze6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@aze6s1, 'Onward/Connecting Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze6, 'Supporting Documents', 'Additional evidence for your onward journey.', 2);
SET @aze6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(57, 6, 26.00, 'USD', 'ASAN e-Visa Fee (Approximate)', 'Reported in line with the standard e-Visa fee (roughly USD 20-29); no separate lower transit-specific figure was independently confirmed this session.', '2026-09-01', NOW(), 'https://evisa.gov.az/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa if I never leave Baku airport during my layover?', 'Reportedly no — Indian travellers who remain airside and connect within roughly 24 hours are generally not required to obtain a visa; a transit e-Visa is only needed if you plan to leave the international transit zone.', 57, 6, 5708, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — ASAN e-Visa / Embassy for Extended Care
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    57, 7, 'AZE-MED-IN-07', '2026.09', 'published',
    'Travel to Azerbaijan for medical treatment.',
    'Indian nationals travelling for treatment fitting within a 30-day stay can generally use the standard e-Visa with a treatment confirmation letter; longer courses of treatment are expected to need embassy processing, per general practice — not independently confirmed as a distinct formal Medical e-Visa category this session.',
    'Single entry, up to 30 days continuous stay under the e-Visa; longer treatment courses need embassy processing',
    'Apply online via the e-Visa portal (evisa.gov.az) for short treatment; Embassy of the Republic of Azerbaijan, New Delhi for extended care',
    0,
    'Standard e-Visa processing reported at around 3 working days; embassy processing for extended treatment reported at around 7-10 working days',
    'Republic of Azerbaijan Official Electronic Visa Portal (evisa.gov.az); Embassy of the Republic of Azerbaijan, New Delhi for extended treatment',
    'Obtain a treatment confirmation letter from the Azerbaijani hospital/clinic\nIf your treatment fits within 30 days, complete the online e-Visa application\nFor longer treatment, apply in person at the embassy with the same supporting documents\nPay the applicable fee and receive/collect the visa',
    '/assets/images/visa-heroes/azerbaijan.webp',
    'Inferred from general e-Visa/embassy secondary sourcing; a dedicated Medical visa was NOT independently confirmed this session as distinct from Business/Tourist', 'https://evisa.gov.az/en/', '2026-09-17'
);
SET @aze7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@aze7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze7, 'Core Documents', 'Required from every applicant.', 1);
SET @aze7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@aze7s1, 'Treatment Confirmation Letter from Azerbaijani Hospital/Clinic', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @aze7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze7s2, 'Medical Records/Referral from India', NULL, 'copy', 1, 0, 0, 1),
(@aze7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2),
(@aze7s2, 'Attendant/Companion Passport Copy (If Travelling Together)', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(57, 7, 26.00, 'USD', 'ASAN e-Visa Fee (Approximate)', 'Reported in line with the standard e-Visa fee (roughly USD 20-29) for treatment fitting within 30 days; extended-treatment embassy cases carry a separate, unconfirmed fee.', '2026-09-01', NOW(), 'https://evisa.gov.az/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Medical Visa category for Azerbaijan?', 'A formally distinct Medical e-Visa category was not independently confirmed this session — short medical trips appear to fit within the standard e-Visa''s 30-day stay using a treatment confirmation letter, while longer treatment is expected to need embassy processing similar to other long-stay categories.', 57, 7, 5709, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — ASAN e-Visa (Business Purpose)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    57, 8, 'AZE-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade fairs in Azerbaijan.',
    'Indian nationals attending a conference or trade fair — sourced this session as a sub-case of the Business purpose within the same e-Visa portal, rather than a formally separate "Conference Visa" product; treat accordingly and confirm before applying.',
    'Single entry, up to 30 days continuous stay, visa valid for 90 days from issue',
    'Apply online via the e-Visa portal (evisa.gov.az), selecting the business purpose of travel',
    0,
    'Standard processing reported at around 3 working days; an urgent ~3 hour option is available for an added fee',
    'Republic of Azerbaijan Official Electronic Visa Portal (evisa.gov.az)',
    'Obtain a conference invitation or registration confirmation\nComplete the online e-Visa application, selecting Business as the purpose\nUpload the invitation/registration document alongside standard supporting documents\nPay the fee and receive the e-Visa by email',
    '/assets/images/visa-heroes/azerbaijan.webp',
    'Inferred from the general e-Visa "purposes of travel" list (tourism/business/study/work/transit) reported by Air India and BTW Visas secondary sourcing — a formally distinct Conference category was NOT independently confirmed this session', 'https://evisa.gov.az/en/', '2026-09-17'
);
SET @aze8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@aze8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze8, 'Core Documents', 'Required from every applicant.', 1);
SET @aze8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@aze8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @aze8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@aze8s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(57, 8, 26.00, 'USD', 'ASAN e-Visa Fee (Approximate)', 'Same reported fee structure as Business/Tourist (roughly USD 20-29), since Conference is treated here as a Business sub-case.', '2026-09-01', NOW(), 'https://evisa.gov.az/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is "Conference" its own visa type in Azerbaijan?', 'Not confirmed as a formally separate category this session — the e-Visa portal''s purpose-of-travel options are reported as tourism, business, study, work, and transit, so conference attendance is treated here as falling under the business purpose. Confirm with the current portal before applying.', 57, 8, 5710, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — ASAN e-Visa (Business Purpose, Inferred)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    57, 9, 'AZE-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in or attending sporting events hosted in Azerbaijan.',
    'NOT independently confirmed this session as a distinct product — content is inferred from the general e-Visa "business/short-stay" purpose and standard international sporting-delegation documentation practice, since no India- or Azerbaijan-specific Sports visa reporting was found.',
    'Single entry, up to 30 days continuous stay, visa valid for 90 days from issue (inferred, matching the standard e-Visa)',
    'Apply online via the e-Visa portal (evisa.gov.az), selecting the closest available purpose (typically business); confirm current guidance first',
    0,
    'Standard e-Visa processing reported at around 3 working days for comparable purposes; not independently confirmed for this specific category',
    'Republic of Azerbaijan Official Electronic Visa Portal (evisa.gov.az)',
    'Obtain a letter from your home-country sports association confirming your role\nObtain an invitation letter from the host event organizer in Azerbaijan\nComplete the online e-Visa application, selecting the closest available purpose\nPay the fee and receive the e-Visa by email',
    '/assets/images/visa-heroes/azerbaijan.webp',
    'NOT independently confirmed this session — no dedicated India- or Azerbaijan-specific Sports visa documentation was located; structure inferred from the general e-Visa purpose-of-travel model and standard delegation practice', 'https://evisa.gov.az/en/', '2026-09-17'
);
SET @aze9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@aze9, '2026.09', 'Initial published checklist — Sports content flagged as inferred/under-sourced.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze9, 'Core Documents', 'Required from every applicant (inferred).', 1);
SET @aze9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@aze9s1, 'Home-Country Sports Association Letter', 'Confirms role and, where applicable, no-employment status.', 'original', 1, 0, 1, 2),
(@aze9s1, 'Host Event Organizer Invitation Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @aze9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(57, 9, NULL, 'USD', 'Confirmed After Assessment', 'No Sports-specific fee was found this session; likely to align with the standard e-Visa fee (roughly USD 20-29) if processed under the business purpose, but not confirmed — contact us to verify before applying.', '2026-09-01', NOW(), 'https://evisa.gov.az/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports Visa for Azerbaijan?', 'This was not independently confirmed this session — no Azerbaijan-specific Sports visa category was located in available sourcing. Athletes and delegations should contact the Embassy of Azerbaijan, New Delhi, or check the e-Visa portal directly for the correct purpose-of-travel category before applying.', 57, 9, 5711, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Temporary Residence Permit (Family)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    57, 10, 'AZE-DEP-IN-10', '2026.09', 'published',
    'Spouse, minor children, or in limited cases dependent parents joining an Indian national who holds a valid Azerbaijani work permit or residence permit.',
    'Family members of an Indian national already legally resident in Azerbaijan (e.g. on a Work Permit + Temporary Residence Permit). The dependent applies for their own family-reunification Temporary Residence Permit (TRP); case specifics for family of a foreign (non-Azerbaijani) sponsor are inferred from general State Migration Service TRP guidance, not confirmed India-specific reporting.',
    'Tied to the sponsor''s Work Permit/Temporary Residence Permit validity, commonly up to 1 year, renewable',
    'Apply through the State Migration Service of Azerbaijan on the strength of the sponsor''s valid permit; not processed via the e-Visa portal',
    1,
    'Reported at roughly 15-20 working days for the TRP itself, following entry on the appropriate visa',
    'State Migration Service of the Republic of Azerbaijan; Embassy of the Republic of Azerbaijan, New Delhi for the initial entry visa',
    'Confirm the sponsor holds a valid, current Work Permit and Temporary Residence Permit\nGather relationship proof (marriage/birth certificates), apostilled/consular-legalized as Azerbaijan reportedly requires foreign civil documents to be\nObtain the appropriate entry visa via the Embassy of Azerbaijan, New Delhi\nApply for the dependent''s own Temporary Residence Permit through the State Migration Service after arrival\nRegister and collect the Temporary Residence Card',
    '/assets/images/visa-heroes/azerbaijan.webp',
    'Cross-checked against State Migration Service TRP secondary sourcing (acon.az, ismayilzade.az, smeltd.az); case specifics for dependents of a foreign sponsor are inferred, not confirmed India-specific', 'https://migration.gov.az/en/page/73', '2026-09-17'
);
SET @aze10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@aze10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze10, 'Core Documents', 'Required from every applicant.', 1);
SET @aze10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@aze10s1, 'Proof of Relationship to Sponsor (Marriage/Birth Certificate, Apostilled)', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@aze10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit and financial means.', 2);
SET @aze10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@aze10s2, 'Sponsor''s Work Permit/Temporary Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@aze10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@aze10s2, 'Guardian Consent (Minor Dependents, If Applicable)', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(57, 10, NULL, 'AZN', 'Confirmed After Assessment', 'Temporary Residence Permit fees for dependents were not independently confirmed this session; confirm the current schedule with the State Migration Service.', '2026-09-01', NOW(), 'https://migration.gov.az/en/page/73', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can a dependent work in Azerbaijan on a family Temporary Residence Permit?', 'Reportedly not automatically — a Temporary Residence Permit does not by itself authorize paid employment in every case, and a separate work permit is generally needed unless a statutory exemption applies. Confirm the current rule for your specific situation before assuming work rights.', 57, 10, 5712, 1),
('Do foreign civil documents need special certification for a dependent TRP?', 'Yes — secondary sourcing indicates Azerbaijan generally requires foreign documents such as marriage or birth certificates to be notarized and apostilled (or consular legalized) to be accepted as proof of relationship.', 57, 10, 5713, 1);
