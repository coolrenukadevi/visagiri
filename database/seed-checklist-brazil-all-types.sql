-- Brazil Visa Checklist Engine content for all 10 visa types — built this
-- session via WebSearch (WebFetch was blocked by the network egress proxy
-- for every target domain attempted: eoibrasilia.gov.in, visa.vfsglobal.com,
-- businesstoday.in, btwvisas.com, en.wikipedia.org). All facts below come
-- from WebSearch result summaries, cross-checked across 2+ independent
-- results where possible. The WebSearch budget was exhausted mid-session
-- (200/200 calls used, some by earlier activity in this environment), so
-- a few narrower sub-questions could not be run down with a fresh query —
-- those gaps are flagged explicitly per category below and in-line in
-- processing_note/note fields rather than being invented.
--
-- IMPORTANT SOURCING CAVEAT: no figures here were confirmed against a
-- primary Brazilian government page (Itamaraty/MRE, Polícia Federal, or
-- the Embassy/Consulate fee pages) because those domains were unreachable
-- this session. Fee figures in particular are reported ranges from
-- secondary visa-agency sites (BTW Visas, Goodreturns, VisaHQ, Policybazaar,
-- ItzEazy) and are flagged "Approximate"/"Confirmed After Assessment"
-- throughout. One claim surfaced by a search summary — a "DigiLocker
-- Aadhaar e-sign" business e-visa for Brazil — was judged implausible
-- (DigiLocker is an Indian government platform; a Brazilian consular
-- product would not plausibly integrate with it) and was deliberately
-- NOT included anywhere in this file.
--
-- Brazil's real, distinctive, cross-source-corroborated facts:
--   - Brazil has NO eVisa, visa-free entry, or visa-on-arrival for Indian
--     citizens. The Brazilian eVisa system (via VFS-operated portals) is
--     restricted to US, Canadian, and Australian passport holders only —
--     Indians must go through the full traditional consular process.
--   - Unlike many countries covered in this database, Brazil visa
--     applications from India do NOT route through VFS Global. Brazil
--     runs its own official "e-Consular" online portal
--     (ec-mumbai.itamaraty.gov.br and equivalent for New Delhi) for
--     scheduling and case management, with the applicant appearing in
--     person at the Embassy of Brazil (New Delhi) or the Consulate
--     General of Brazil (Mumbai) directly.
--   - On 16 January 2026 India and Brazil signed a reciprocal agreement
--     extending visitor-visa validity from 5 years to up to 10 years;
--     it went operational on 5 February 2026 when both countries updated
--     their visa-issuing systems. This is a genuine, dated, recently
--     implemented policy change (multiple independent reports:
--     BusinessToday, VisaHQ News, Diplomacy & Beyond, TV BRICS, Erickson
--     Immigration Group).
--   - Under that same framework, Business (VIVIS) visits are reported to
--     allow continuous stays of up to 180 days per entry, versus 90 days
--     for Tourist — a real difference in permitted stay length between
--     two visa purposes issued under the same visa category.
--   - Brazil's visa architecture is genuinely two-tier: VIVIS (Visitor
--     Visa) covers short-stay purposes up to 90/180 days — tourism,
--     business, family visits, conferences and seminars are explicitly
--     named together under VIVIS by consular sourcing. VITEM (Temporary
--     Visa) is a numbered series for stays over 90 days: VITEM I
--     (academic research/teaching), VITEM II (medical treatment),
--     VITEM IV (student), VITEM V (work), VITEM XI (family reunion),
--     among others.
--   - Any VITEM (long-stay) visa holder must register in person with
--     Brazil's Federal Police (Polícia Federal) within 90 days of first
--     entry to obtain a CRNM (Registro Nacional Migratório) card — this
--     is a real, distinct third step beyond the consular visa itself.
--   - Work authorization is genuinely employer-driven and runs through a
--     specific body — the CGIg (Coordenação-Geral de Imigração) at
--     Brazil's Ministry of Labour and Employment — in three sequential
--     stages: (1) labour-ministry work-authorization approval, (2)
--     consular visa issuance, (3) Federal Police registration on arrival.
--   - FLAGGED AS NOT INDEPENDENTLY CONFIRMED THIS SESSION: exact Transit
--     visa requirement/exemption details for Indian citizens transiting
--     Brazilian airports; the precise official BRL/consular fee schedule
--     for VITEM categories (Student/Work/Family Reunion/Dependent); and
--     whether Sports-event travel has its own named sub-category or is
--     simply processed under the general VIVIS Visitor Visa (assumed
--     here, per absence of a separate category in sourcing found).
--
-- country_id 199 = Brazil. visa_type_id: 1=Tourist, 2=Business, 3=Student,
-- 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference, 9=Sports,
-- 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Visitor Visa (VIVIS)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    199, 1, 'BRA-TOUR-IN-01', '2026.09', 'published',
    'Leisure, sightseeing, and tourism travel to Brazil.',
    'Indian passport holders — Brazil has no eVisa, visa-free entry, or visa-on-arrival for India (that eVisa route is US/Canada/Australia only), so the Visitor Visa (VIVIS) must be obtained in advance through the full consular process.',
    'Up to 90 days per visit (continuous); multiple-entry visas may now be issued valid up to 10 years since a Feb 2026 India-Brazil reciprocal agreement',
    'Apply via Brazil''s official e-Consular portal with an in-person appointment at the Embassy (New Delhi) or Consulate (Mumbai) — NOT via VFS Global',
    1,
    'Reported at roughly 10-15 working days; current sourcing suggests biometrics are not required for this category, but confirm at booking',
    'Embassy of Brazil, New Delhi (all India & Bhutan except Goa/Maharashtra/Karnataka), or Consulate General of Brazil, Mumbai (Goa/Maharashtra/Karnataka)',
    'Register on the Brazil e-Consular portal and complete the online visa application\nBook an in-person appointment at the Embassy (New Delhi) or Consulate General (Mumbai)\nGather supporting documents\nAttend the appointment and submit your passport\nTrack status via the e-Consular portal and collect your passport',
    '/assets/images/visa-heroes/brazil.webp',
    'Cross-checked across VFS Global eVisa scope notices, the Consulate General of Brazil Mumbai e-Consular listing, and 2026 reciprocal-visa news reporting; embassy fee pages were blocked from direct fetch this session', 'https://ec-mumbai.itamaraty.gov.br/', '2026-09-17'
);
SET @bra1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bra1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra1, 'Core Documents', 'Required from every applicant.', 1);
SET @bra1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra1s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@bra1s1, 'Completed Online Visa Application (e-Consular Portal)', NULL, 'copy', 1, 0, 1, 2),
(@bra1s1, 'Recent Passport-Size Photograph (White Background)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @bra1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra1s2, 'Confirmed Hotel Booking or Invitation', NULL, 'copy', 1, 0, 0, 1),
(@bra1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@bra1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@bra1s2, 'Travel Medical Insurance', NULL, 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(199, 1, 80.00, 'USD', 'Visitor Visa (VIVIS) Fee (Approximate)', 'Secondary sourcing cites roughly INR 8,000-10,000 (about USD 80 equivalent); this was not confirmed against a primary embassy/consulate fee page this session, so treat as approximate and reconfirm before applying.', '2026-09-01', NOW(), 'https://ec-mumbai.itamaraty.gov.br/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens get a Brazil eVisa or visa-on-arrival?', 'No — Brazil''s eVisa system is currently limited to US, Canadian, and Australian passport holders. Indian citizens must apply for a full Visitor Visa (VIVIS) in advance through Brazil''s e-Consular process.', 199, 1, 19900, 1),
('Is a Brazil tourist visa really valid for 10 years now?', 'Under a reciprocal India-Brazil agreement signed 16 January 2026 and operational from 5 February 2026, multiple-entry visitor visas may now be issued valid for up to 10 years, with continuous stays of up to 90 days per visit — confirm your specific visa''s validity on the sticker/approval.', 199, 1, 19901, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Visitor Visa (VIVIS)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    199, 2, 'BRA-BUS-IN-02', '2026.09', 'published',
    'Trade meetings, negotiations, and commercial activity in Brazil (no local employment).',
    'Indian nationals travelling for business — the same Visitor Visa (VIVIS) category as Tourist, but reportedly permitting a longer continuous stay of up to 180 days per entry rather than 90, with an invitation letter from the Brazilian host company as the differentiating document.',
    'Up to 180 days per entry (continuous), reported under the Feb 2026 reciprocal 10-year multiple-entry framework',
    'Apply via Brazil''s e-Consular portal with an in-person Embassy (New Delhi)/Consulate (Mumbai) appointment — NOT via VFS Global',
    1,
    'Reported at roughly 10-15 working days, similar to Tourist processing',
    'Embassy of Brazil, New Delhi, or Consulate General of Brazil, Mumbai',
    'Obtain an invitation letter from the Brazilian host company\nGather Indian employer sponsorship/forwarding letter\nRegister and complete the application on the e-Consular portal\nAttend the in-person appointment and submit your passport',
    '/assets/images/visa-heroes/brazil.webp',
    'Cross-checked against 2026 reciprocal-visa news reporting describing a 180-day business stay allowance, and general e-Consular process sourcing; not confirmed against a primary consulate fee page this session', 'https://ec-mumbai.itamaraty.gov.br/', '2026-09-17'
);
SET @bra2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bra2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra2, 'Core Documents', 'Required from every applicant.', 1);
SET @bra2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra2s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@bra2s1, 'Invitation Letter from Brazilian Host Company', NULL, 'original', 1, 0, 1, 2),
(@bra2s1, 'Completed Online Visa Application (e-Consular Portal)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @bra2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@bra2s2, 'Business Registration/Company Proof', NULL, 'copy', 0, 1, 0, 2),
(@bra2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(199, 2, 80.00, 'USD', 'Visitor Visa (VIVIS) Fee (Approximate)', 'Reported similar to the Tourist VIVIS fee (roughly INR 8,000-10,000 equivalent); not confirmed against a primary consulate fee page this session, so treat as approximate.', '2026-09-01', NOW(), 'https://ec-mumbai.itamaraty.gov.br/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I stay in Brazil longer on a Business visa than a Tourist visa?', 'Reported sourcing indicates Business (VIVIS) entries may allow a continuous stay of up to 180 days versus 90 days for Tourist — but both are issued under the same Visitor Visa category, so confirm the exact permitted stay printed on your visa.', 199, 2, 19910, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Temporary Visa (VITEM IV)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    199, 3, 'BRA-STU-IN-03', '2026.09', 'published',
    'Enrolling in an educational course or academic program in Brazil lasting more than 90 days.',
    'Indian nationals admitted to a recognized Brazilian institution requiring more than 90 days of study use the VITEM IV Temporary Visa (short courses under 90 days may instead use the Visitor Visa). Holders must register with Brazil''s Federal Police within 90 days of arrival.',
    'Tied to course/program duration; requires Federal Police (Polícia Federal) registration for a CRNM card within 90 days of first entry',
    'Apply via Brazil''s e-Consular portal with an in-person Embassy (New Delhi)/Consulate (Mumbai) appointment — NOT via VFS Global',
    1,
    'Processing timeline for VITEM (temporary/long-stay) categories was not independently confirmed this session; expect longer than the short-stay Visitor Visa window — confirm current timing when booking',
    'Embassy of Brazil, New Delhi, or Consulate General of Brazil, Mumbai',
    'Secure admission at a recognized Brazilian institution for a course exceeding 90 days\nGather proof of funds and academic documents\nRegister and complete the VITEM IV application on the e-Consular portal\nAttend the in-person appointment and submit your passport\nAfter arrival, register with the Federal Police within 90 days for a CRNM card',
    '/assets/images/visa-heroes/brazil.webp',
    'Cross-checked against secondary consular-visa-type sourcing describing the VITEM I-XI numbered temporary visa series and the Federal Police post-arrival registration requirement; not confirmed against a primary embassy/consulate page this session', 'https://ec-mumbai.itamaraty.gov.br/', '2026-09-17'
);
SET @bra3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bra3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra3, 'Core Documents', 'Required from every applicant.', 1);
SET @bra3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra3s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@bra3s1, 'Admission Letter from Brazilian Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra3, 'Supporting Documents', 'Evidence of your academic background and funds.', 2);
SET @bra3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bra3s2, 'Proof of Funds/Scholarship Letter', NULL, 'copy', 1, 0, 0, 2),
(@bra3s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 3),
(@bra3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(199, 3, NULL, 'USD', 'Confirmed After Assessment', 'Secondary sourcing reports a general temporary-visa (VITEM) fee band of roughly INR 10,000, but a Student-specific figure was not confirmed against a primary source this session — contact us or the consulate to confirm.', '2026-09-01', NOW(), 'https://ec-mumbai.itamaraty.gov.br/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need to register with anyone after arriving in Brazil to study?', 'Yes — VITEM (temporary/long-stay) visa holders, including students, must register in person with Brazil''s Federal Police within 90 days of first entry to obtain a CRNM (Registro Nacional Migratório) card.', 199, 3, 19920, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Temporary Visa (VITEM V)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    199, 4, 'BRA-WORK-IN-04', '2026.09', 'published',
    'Employment, technical assistance, or technology-transfer work with a Brazilian employer.',
    'Indian nationals with a confirmed job offer from a Brazilian employer. The employer must first obtain work authorization from CGIg (Coordenacao-Geral de Imigracao) at Brazil''s Ministry of Labour and Employment before the applicant can apply for the VITEM V visa at a consulate.',
    'Commonly up to 2 years initially, renewable, tied to the employment contract',
    'Employer files with CGIg/Ministry of Labour first; applicant then applies via the e-Consular portal, in person — NOT via VFS Global',
    1,
    'Reported in three stages: labour-ministry work authorization roughly 30-60 days, consular visa issuance roughly 5-10 business days, then Federal Police registration on arrival; total often cited around 4-8 weeks for the authorization stage alone',
    'Embassy of Brazil, New Delhi, or Consulate General of Brazil, Mumbai (visa issuance); Federal Police (registration after arrival)',
    'Secure a job offer from a Brazilian employer\nEmployer files the work-authorization request with CGIg at the Ministry of Labour and Employment\nOnce authorized, apply for the VITEM V visa via the e-Consular portal\nAttend the in-person consular appointment and submit your passport\nAfter arrival, register with the Federal Police within 90 days for a CRNM card',
    '/assets/images/visa-heroes/brazil.webp',
    'Cross-checked against multiple secondary employer-of-record and immigration-law sourcing describing the CGIg/Ministry of Labour authorization process and VITEM V category; not confirmed against a primary Brazilian government page this session', 'https://ec-mumbai.itamaraty.gov.br/', '2026-09-17'
);
SET @bra4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bra4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra4, 'Core Documents', 'Required from every applicant.', 1);
SET @bra4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra4s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@bra4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@bra4s1, 'CGIg Work Authorization Approval', 'Obtained by the employer from the Ministry of Labour and Employment before the visa application.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @bra4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bra4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@bra4s2, 'Employer Company Registration Proof', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(199, 4, NULL, 'USD', 'Confirmed After Assessment', 'A confirmed official fee figure for VITEM V was not found via a primary source this session; contact us or the consulate to confirm the current amount.', '2026-09-01', NOW(), 'https://ec-mumbai.itamaraty.gov.br/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Which body approves my Brazil work authorization before the visa?', 'Your Brazilian employer files the work-authorization request with CGIg (Coordenacao-Geral de Imigracao) at the Ministry of Labour and Employment. Only after that approval can you apply for the VITEM V visa at the consulate.', 199, 4, 19930, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Visitor Visa (VIVIS)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    199, 5, 'BRA-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Brazil for a short stay.',
    'Indian nationals with family/friends in Brazil — the same Visitor Visa (VIVIS) category as Tourist, sourcing explicitly names family visits among its covered short-stay purposes, alongside an invitation letter and relationship proof.',
    'Up to 90 days per visit (continuous)',
    'Apply via Brazil''s e-Consular portal with an in-person Embassy (New Delhi)/Consulate (Mumbai) appointment — NOT via VFS Global',
    1,
    'Reported at roughly 10-15 working days, similar to Tourist processing',
    'Embassy of Brazil, New Delhi, or Consulate General of Brazil, Mumbai',
    'Obtain an invitation letter from your host in Brazil\nGather documents proving the family relationship\nRegister and complete the application on the e-Consular portal\nAttend the in-person appointment and submit your passport',
    '/assets/images/visa-heroes/brazil.webp',
    'Cross-checked against consular sourcing that groups tourism, business, family visits, and conferences/seminars together under the Visitor Visa (VIVIS) category; not confirmed against a primary consulate fee page this session', 'https://ec-mumbai.itamaraty.gov.br/', '2026-09-17'
);
SET @bra5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bra5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra5, 'Core Documents', 'Required from every applicant.', 1);
SET @bra5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra5s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@bra5s1, 'Invitation Letter from Host in Brazil', NULL, 'original', 1, 0, 1, 2),
(@bra5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @bra5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@bra5s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(199, 5, 80.00, 'USD', 'Visitor Visa (VIVIS) Fee (Approximate)', 'Reported similar to the Tourist VIVIS fee (roughly INR 8,000-10,000 equivalent); not confirmed against a primary consulate fee page this session, so treat as approximate.', '2026-09-01', NOW(), 'https://ec-mumbai.itamaraty.gov.br/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Family Visit visa different from the Dependent visa?', 'Yes — Family Visit uses the short-stay Visitor Visa (VIVIS, up to 90 days) for visiting relatives in Brazil, while Dependent uses the long-stay VITEM XI Family Reunion visa for actually residing with a sponsor in Brazil.', 199, 5, 19940, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    199, 6, 'BRA-TRAN-IN-06', '2026.09', 'published',
    'Passing through a Brazilian airport en route to a third country.',
    'Indian nationals connecting through Brazil. NOT INDEPENDENTLY CONFIRMED THIS SESSION: whether Brazil requires a separate transit visa for Indian passport holders, or under what conditions (e.g. leaving the international transit area, changing airports) one is needed — confirm directly with the Embassy/Consulate before assuming any exemption.',
    'Limited to the connection window; duration not independently confirmed this session',
    'If required: apply via Brazil''s e-Consular portal with an in-person Embassy/Consulate appointment — NOT via VFS Global',
    1,
    'Not independently confirmed this session — confirm current timing directly with the Embassy/Consulate before travel',
    'Embassy of Brazil, New Delhi, or Consulate General of Brazil, Mumbai',
    'Confirm directly with the Embassy/Consulate whether your specific connection requires a transit visa\nIf required, register and complete the application on the e-Consular portal\nGather itinerary/onward ticket\nAttend the in-person appointment if biometrics/interview is required',
    '/assets/images/visa-heroes/brazil.webp',
    'Not independently confirmed this session — the WebSearch budget was exhausted and WebFetch was blocked before a dedicated Transit-visa query could be run; structure is best-effort pending direct confirmation', 'https://ec-mumbai.itamaraty.gov.br/', '2026-09-17'
);
SET @bra6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bra6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra6, 'Core Documents', 'Required if a transit visa is confirmed necessary for your itinerary.', 1);
SET @bra6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bra6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @bra6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(199, 6, NULL, 'USD', 'Confirmed After Assessment', 'No fee figure was independently confirmed this session; whether a transit visa is even required for Indian citizens was not confirmed either — contact the Embassy/Consulate directly.', '2026-09-01', NOW(), 'https://ec-mumbai.itamaraty.gov.br/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do all Indian travellers connecting through a Brazilian airport need a transit visa?', 'This was not independently confirmed this session. Because Brazil has no eVisa or visa-free arrangement for India in any other category, do not assume an exemption — confirm directly with the Embassy of Brazil or the Consulate General before booking a connection.', 199, 6, 19950, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Temporary Visa (VITEM II)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    199, 7, 'BRA-MED-IN-07', '2026.09', 'published',
    'Travel to Brazil for medical treatment.',
    'Indian nationals travelling for treatment. Sourcing identifies VITEM II as Brazil''s specific temporary-visa category for medical treatment; short treatment visits under 90 days may instead fall under the general Visitor Visa (VIVIS) — confirm which applies to your case.',
    'Tied to treatment duration; VITEM II holders exceeding 90 days must register with the Federal Police',
    'Apply via Brazil''s e-Consular portal with an in-person Embassy (New Delhi)/Consulate (Mumbai) appointment — NOT via VFS Global',
    1,
    'Processing timeline not independently confirmed this session for this specific category — confirm current timing when booking',
    'Embassy of Brazil, New Delhi, or Consulate General of Brazil, Mumbai',
    'Obtain a certificate from the treating Brazilian doctor/institution\nGather proof of funds for treatment\nRegister and complete the application on the e-Consular portal (VITEM II, or VIVIS if under 90 days)\nAttend the in-person appointment and submit your passport',
    '/assets/images/visa-heroes/brazil.webp',
    'Cross-checked against secondary sourcing describing the VITEM I-XI numbered temporary-visa series, which names VITEM II as the medical-treatment category; not confirmed against a primary embassy/consulate page this session', 'https://ec-mumbai.itamaraty.gov.br/', '2026-09-17'
);
SET @bra7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bra7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra7, 'Core Documents', 'Required from every applicant.', 1);
SET @bra7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra7s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@bra7s1, 'Medical Certificate/Institution Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @bra7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@bra7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2),
(@bra7s2, 'Attendant''s Documents (If Accompanying)', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(199, 7, NULL, 'USD', 'Confirmed After Assessment', 'A confirmed official fee figure for VITEM II was not found via a primary source this session; contact us or the consulate to confirm.', '2026-09-01', NOW(), 'https://ec-mumbai.itamaraty.gov.br/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Which visa category applies for medical treatment in Brazil?', 'Secondary sourcing identifies VITEM II as Brazil''s dedicated temporary visa for medical treatment. If your treatment visit is genuinely under 90 days, confirm with the consulate whether the general Visitor Visa (VIVIS) may apply instead.', 199, 7, 19960, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Visitor Visa (VIVIS)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    199, 8, 'BRA-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, and congresses in Brazil.',
    'Indian nationals attending a conference — the same Visitor Visa (VIVIS) category as Tourist. Sourcing explicitly names conferences and seminars among VIVIS''s covered short-stay purposes, alongside tourism, business, and family visits.',
    'Up to 90 days per visit (continuous)',
    'Apply via Brazil''s e-Consular portal with an in-person Embassy (New Delhi)/Consulate (Mumbai) appointment — NOT via VFS Global',
    1,
    'Reported at roughly 10-15 working days, similar to Tourist processing',
    'Embassy of Brazil, New Delhi, or Consulate General of Brazil, Mumbai',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nRegister and complete the application on the e-Consular portal\nAttend the in-person appointment and submit your passport',
    '/assets/images/visa-heroes/brazil.webp',
    'Cross-checked against consular sourcing that groups tourism, business, family visits, and conferences/seminars together under the Visitor Visa (VIVIS) category; not confirmed against a primary consulate fee page this session', 'https://ec-mumbai.itamaraty.gov.br/', '2026-09-17'
);
SET @bra8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bra8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra8, 'Core Documents', 'Required from every applicant.', 1);
SET @bra8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra8s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@bra8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @bra8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@bra8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(199, 8, 80.00, 'USD', 'Visitor Visa (VIVIS) Fee (Approximate)', 'Reported similar to the Tourist VIVIS fee (roughly INR 8,000-10,000 equivalent); not confirmed against a primary consulate fee page this session, so treat as approximate.', '2026-09-01', NOW(), 'https://ec-mumbai.itamaraty.gov.br/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Conference visa a separate category from Tourist in Brazil?', 'No — sourcing indicates conferences and seminars are processed under the same Visitor Visa (VIVIS) category as Tourist, Business, and Family Visit, so the documentary requirements are broadly similar.', 199, 8, 19970, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Visitor Visa (VIVIS, assumed)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    199, 9, 'BRA-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Brazil.',
    'Indian nationals competing or officiating. NOT INDEPENDENTLY CONFIRMED THIS SESSION: sourcing found named tourism, business, family visits, and conferences/seminars under the Visitor Visa (VIVIS) category, but did not explicitly name sporting events — this checklist assumes the same VIVIS route pending direct confirmation.',
    'Up to 90 days per visit (continuous), assumed under the general Visitor Visa framework',
    'Apply via Brazil''s e-Consular portal with an in-person Embassy (New Delhi)/Consulate (Mumbai) appointment — NOT via VFS Global',
    1,
    'Not independently confirmed this session for this specific category — reported at roughly 10-15 working days for the general Visitor Visa, but confirm current timing when booking',
    'Embassy of Brazil, New Delhi, or Consulate General of Brazil, Mumbai',
    'Confirm with the Embassy/Consulate whether the event requires the general Visitor Visa or a specific event accreditation\nObtain a letter from your home-country sports association confirming your role\nObtain an invitation letter from the host event organizer\nRegister and complete the application on the e-Consular portal\nAttend the in-person appointment and submit your passport',
    '/assets/images/visa-heroes/brazil.webp',
    'Not independently confirmed this session — sourcing on Brazil''s VIVIS/VITEM categories did not explicitly name sports events as a covered purpose; structure is best-effort pending direct confirmation with the Embassy/Consulate', 'https://ec-mumbai.itamaraty.gov.br/', '2026-09-17'
);
SET @bra9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bra9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra9, 'Core Documents', 'Required from every applicant.', 1);
SET @bra9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra9s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@bra9s1, 'Home-Country Sports Association Letter', 'Confirms role and no-employment status.', 'original', 1, 0, 1, 2),
(@bra9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @bra9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(199, 9, NULL, 'USD', 'Confirmed After Assessment', 'Sports-event visa classification and fee were not independently confirmed this session; contact us or the consulate to confirm before applying.', '2026-09-01', NOW(), 'https://ec-mumbai.itamaraty.gov.br/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Brazil have a dedicated Sports Event visa category?', 'This was not independently confirmed this session. Available sourcing on Brazil''s Visitor Visa (VIVIS) named tourism, business, family visits, and conferences/seminars, but not sporting events specifically — confirm directly with the Embassy/Consulate before applying.', 199, 9, 19980, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunion Temporary Visa (VITEM XI)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    199, 10, 'BRA-DEP-IN-10', '2026.09', 'published',
    'Spouses/partners, children, parents, siblings, grandparents, or grandchildren joining a sponsor legally resident in Brazil.',
    'Family members of an Indian national (or other foreign national) holding legal residency status in Brazil, such as a VITEM V work-visa or permanent-residency holder, using the VITEM XI Family Reunion visa. This is distinct from the short-stay Family Visit (VIVIS) category.',
    'Tied to the sponsor''s residency status; requires Federal Police registration for a CRNM card within 90 days of arrival',
    'Apply via Brazil''s e-Consular portal with an in-person Embassy (New Delhi)/Consulate (Mumbai) appointment — NOT via VFS Global',
    1,
    'Processing timeline not independently confirmed this session for this specific category — expect longer than short-stay VIVIS processing; confirm current timing when booking',
    'Embassy of Brazil, New Delhi, or Consulate General of Brazil, Mumbai',
    'Confirm the sponsor holds qualifying legal residency status in Brazil\nGather relationship proof (marriage/birth certificates) and the sponsor''s residency document copy\nRegister and complete the VITEM XI application on the e-Consular portal\nAttend the in-person appointment and submit your passport\nAfter arrival, register with the Federal Police within 90 days for a CRNM card',
    '/assets/images/visa-heroes/brazil.webp',
    'Cross-checked against secondary sourcing describing VITEM XI''s covered relations (spouse, children, parents, siblings, grandparents/grandchildren); not confirmed against a primary embassy/consulate page this session', 'https://ec-mumbai.itamaraty.gov.br/', '2026-09-17'
);
SET @bra10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bra10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra10, 'Core Documents', 'Required from every applicant.', 1);
SET @bra10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra10s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@bra10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bra10, 'Supporting Documents', 'Evidence tied to the sponsor''s residency status.', 2);
SET @bra10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bra10s2, 'Sponsor''s CRNM/Residency Document Copy', NULL, 'copy', 1, 0, 0, 1),
(@bra10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(199, 10, NULL, 'USD', 'Confirmed After Assessment', 'A confirmed official fee figure for VITEM XI was not found via a primary source this session; contact us or the consulate to confirm the current amount.', '2026-09-01', NOW(), 'https://ec-mumbai.itamaraty.gov.br/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Which relatives qualify for Brazil''s Family Reunion (Dependent) visa?', 'Secondary sourcing describes VITEM XI as covering spouses/partners, children, parents, siblings, grandparents, and grandchildren of a Brazilian national or a foreign national with legal residency status in Brazil — confirm your specific relationship qualifies before applying.', 199, 10, 19990, 1);
