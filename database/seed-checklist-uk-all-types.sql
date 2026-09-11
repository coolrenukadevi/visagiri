-- United Kingdom Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search, same standard as Mexico/
-- Singapore/France/Japan/USA/Australia/Canada/Germany/New Zealand/
-- Russia (see AUDIT.md). hero_image_url points at the real Big Ben/
-- Houses of Parliament and Union Jack photo supplied by the client for
-- this hero.
--
-- The UK's real, distinctive facts:
--   - Tourist, Business, Family Visit, Medical, and Conference are NOT
--     five separate visa products — all five are the same Standard
--     Visitor visa (GBP 135 for up to 6 months), distinguished only by
--     purpose-specific documents, confirmed directly against gov.uk's
--     own Standard Visitor guidance.
--   - India is explicitly EXCLUDED from the UK's Electronic Travel
--     Authorisation (ETA) scheme — ETA is only for visa-exempt
--     nationals; Indian citizens must always obtain a full visa, never
--     just an ETA, a genuinely different starting point from several
--     other countries built this session.
--   - Since 25 February 2026 the UK moved fully to eVisas (digital
--     immigration status, no physical visa sticker) for Indian
--     travellers — the application and VFS biometrics process is
--     otherwise unchanged, but the end product is now purely digital.
--   - A real April 2026 Home Office fee round raised nearly every visa
--     fee (Standard Visitor GBP 127 to GBP 135; Student GBP 524 to GBP
--     558), reflected here as the current 2026 figures rather than the
--     superseded pre-April numbers.
--   - Transit genuinely splits into two different products: the Direct
--     Airside Transit Visa (DATV, GBP 41.50, for travellers staying
--     airside who never pass UK border control) and the "Visitor in
--     Transit" category of the Standard Visitor visa (GBP 135, for
--     travellers who must pass through border control) — not one
--     product with two names.
--   - Sports genuinely splits by payment status: amateur/unpaid
--     competitors use the Standard Visitor visa, while paid/contracted
--     sportspeople and their support staff must use the distinct
--     International Sportsperson visa (which replaced the old Tier 2
--     Sportsperson/Tier 5 routes in October 2021), requiring governing
--     body endorsement.
--   - Work (Skilled Worker) carries a real, current GBP 41,700/year
--     minimum salary threshold (from 22 July 2025, still current in
--     2026) and a mandatory Certificate of Sponsorship from a licensed
--     employer — genuinely different sponsor-side costs (CoS fee,
--     Immigration Skills Charge) are noted as employer-borne, not
--     folded into the applicant's own fee.
--   - Dependant eligibility for Skilled Worker has been restricted
--     since 2024-2025 rule changes — most care workers and many
--     medium-skilled occupations can no longer bring dependants at
--     all, a real and current eligibility gate stated honestly rather
--     than assumed automatic.
--
-- country_id 152 = United Kingdom. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Standard Visitor Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    152, 1, 'GBR-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and visiting friends/relatives in the United Kingdom.',
    'Indian passport holders are explicitly excluded from the UK''s Electronic Travel Authorisation (ETA) scheme, which is reserved for visa-exempt nationals — a full Standard Visitor visa is always required. Since 25 February 2026 the visa is issued as a digital eVisa rather than a physical sticker.',
    'Up to 6 months per visit (visa itself can be valid 6 months, 2, 5, or 10 years for multiple entries)',
    'Online application via gov.uk, biometrics at a VFS Global Visa Application Centre',
    1,
    'Processing typically runs around 3 weeks, though this can vary by season',
    'VFS Global UK Visa Application Centre, India',
    'Initial consultation to confirm Standard Visitor (Tourist) is correct\nGather documents against this checklist\nSubmit your application online via gov.uk\nAttend a VFS Global centre for biometrics\nSupport responding to any additional-information request\nDecision — digital eVisa issued once approved',
    '/assets/images/visa-heroes/uk.jpg',
    'UK Home Office (gov.uk) Standard Visitor visa guidance and April 2026 fee schedule', 'https://www.gov.uk/standard-visitor', '2026-09-11'
);
SET @gt1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gt1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt1, 'Core Documents', 'Every applicant needs these.', 1);
SET @gt1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt1s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@gt1s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt1, 'Financial & Ties Documents', 'Evidence of funds and ties to India.', 2);
SET @gt1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt1s2, 'Bank Statements', 'Last 6 months.', 'copy', 1, 0, 1, 1),
(@gt1s2, 'Proof of Ties to India', 'Employment letter, property documents, or family ties evidence.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt1, 'Travel Documents', 'Evidence of your trip.', 3);
SET @gt1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt1s3, 'Travel Itinerary & Accommodation', NULL, 'original', 0, 1, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt1, 'Application & Biometrics', 'Booking your VFS appointment.', 4);
SET @gt1s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt1s4, 'Biometrics Appointment', 'At a VFS Global centre in India.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(152, 1, 135.00, 'GBP', 'Standard Visitor Visa Fee', 'GBP 135 for up to 6 months, effective from the 8 April 2026 fee round (up from GBP 127). Longer multi-entry options: GBP 432 (2yr), GBP 771 (5yr), GBP 963 (10yr) — each still capping individual stays at 6 months.', '2026-04-08', NOW(), 'https://www.gov.uk/standard-visitor', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens use the UK''s ETA instead of a full visa?', 'No — the Electronic Travel Authorisation (ETA) scheme is only for visa-exempt nationals. Indian passport holders must always obtain a full Standard Visitor visa.', 152, 1, 980, 1),
('Is the UK visa now digital?', 'Yes — since 25 February 2026, approved visas are issued as a digital eVisa rather than a physical sticker in your passport, though the application and biometrics process is unchanged.', 152, 1, 981, 1),
('How long can I stay per visit?', 'Up to 6 months per visit, even if you hold a longer multi-entry visa (2, 5, or 10 years) that allows repeated visits.', 152, 1, 982, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Standard Visitor Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    152, 2, 'GBR-BUS-IN-02', '2026.09', 'published',
    'Short business visits — meetings, negotiations, and contract signing — to the United Kingdom.',
    'Business travel uses the same Standard Visitor visa as Tourist — the UK has no separate "business visa." Permitted activities include meetings, negotiating/signing contracts, and site visits; some paid engagements for recognized experts are also allowed under specific visitor rules.',
    'Up to 6 months per visit',
    'Online application via gov.uk, biometrics at a VFS Global centre',
    1,
    'Processing typically runs around 3 weeks',
    'VFS Global UK Visa Application Centre, India',
    'Initial consultation to confirm the trip is a genuine business visit\nObtain an invitation letter from your UK host company\nGather documents against this checklist\nSubmit your application online via gov.uk\nAttend a VFS Global centre for biometrics\nDecision — digital eVisa issued once approved',
    '/assets/images/visa-heroes/uk.jpg',
    'UK Home Office Standard Visitor visa (business activities) guidance', 'https://www.gov.uk/standard-visitor', '2026-09-11'
);
SET @gt2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gt2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt2, 'Core Documents', 'Every applicant needs these.', 1);
SET @gt2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@gt2s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt2, 'Business Invitation & Purpose', 'Evidence of who you are meeting and why.', 2);
SET @gt2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt2s2, 'Invitation Letter from UK Host Company', NULL, 'original', 1, 0, 1, 1),
(@gt2s2, 'Employer Letter from India', 'Confirming your role, salary, and purpose of travel.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt2, 'Financial & Ties Documents', 'Evidence of funds and ties to India.', 3);
SET @gt2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt2s3, 'Bank Statements', 'Last 6 months.', 'copy', 1, 0, 0, 1),
(@gt2s3, 'Proof of Ties to India', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(152, 2, 135.00, 'GBP', 'Standard Visitor Visa Fee', 'Same fee structure as Tourist — Business is the same Standard Visitor visa.', '2026-04-08', NOW(), 'https://www.gov.uk/standard-visitor', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Business Visa for the UK?', 'No — Business travel uses the same Standard Visitor visa as Tourist, distinguished by purpose-specific documents like an invitation letter.', 152, 2, 983, 1),
('Can I be paid during a UK business visit?', 'Generally no regular salary from a UK source, though limited paid engagements for recognized experts are allowed under specific visitor rules — we assess your specific case.', 152, 2, 984, 1),
('What activities are permitted on a Business visitor visa?', 'Meetings, negotiating and signing contracts, and site visits are all permitted business activities under the Standard Visitor visa.', 152, 2, 985, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Student Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    152, 3, 'GBR-STU-IN-03', '2026.09', 'published',
    'Full-time study at a Home Office-licensed UK education provider.',
    'Requires a valid Confirmation of Acceptance for Studies (CAS) reference number from a licensed Student sponsor, issued no more than 6 months before you apply, plus maintenance funds (course fee balance and living costs) held for 28 consecutive days unless CAS-exempt or financially sponsored.',
    'Duration of your course, plus a standard post-study period where applicable',
    'Online application via gov.uk, biometrics at a VFS Global centre, requires prior CAS',
    1,
    'Apply as early as possible once your CAS is issued',
    'VFS Global UK Visa Application Centre, India',
    'Secure admission and receive your CAS reference number\nArrange your maintenance funds, held 28 consecutive days\nPay the Immigration Health Surcharge (IHS) upfront\nGather documents against this checklist\nSubmit your application online via gov.uk\nAttend a VFS Global centre for biometrics\nDecision — digital eVisa issued once approved',
    '/assets/images/visa-heroes/uk.jpg',
    'UK Home Office Student visa guidance and financial evidence rules', 'https://www.gov.uk/student-visa', '2026-09-11'
);
SET @gt3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gt3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt3, 'Core Documents', 'Every applicant needs these.', 1);
SET @gt3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@gt3s1, 'CAS Reference Number', 'From your licensed Student sponsor, issued within 6 months of application.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt3, 'Financial Documents', 'Evidence you can fund your studies.', 2);
SET @gt3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt3s2, 'Maintenance Funds Evidence', 'Course fee balance plus GBP 1,483/month (outside London) or GBP 1,796/month (London) living costs, held 28 consecutive days.', 'copy', 1, 0, 1, 1),
(@gt3s2, 'IHS Payment Receipt', 'GBP 776/year student rate, paid upfront for the full course.', 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt3, 'Academic Documents', 'Evidence of your admission.', 3);
SET @gt3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt3s3, 'Academic Transcripts & English Test Scores', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(152, 3, 558.00, 'GBP', 'Student Visa Application Fee', 'Effective from the 8 April 2026 fee round (up from GBP 524). Plus a separate Immigration Health Surcharge of GBP 776/year (student rate), paid upfront for your full course duration.', '2026-04-08', NOW(), 'https://www.gov.uk/student-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is a CAS and do I need it before applying?', 'A Confirmation of Acceptance for Studies reference number from your licensed UK sponsor, issued no more than 6 months before your application — yes, you must have it before you can apply.', 152, 3, 986, 1),
('How much do I need in maintenance funds?', 'Your course fee balance plus living costs of GBP 1,483/month outside London or GBP 1,796/month in London (up to 9 months), held for 28 consecutive days, unless CAS-exempt or financially sponsored.', 152, 3, 987, 1),
('Is the Immigration Health Surcharge separate from the visa fee?', 'Yes — the IHS (GBP 776/year at the student rate) is paid separately, upfront, for your entire course duration, in addition to the GBP 558 visa application fee.', 152, 3, 988, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Skilled Worker Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    152, 4, 'GBR-WORK-IN-04', '2026.09', 'published',
    'Skilled employment in the United Kingdom, sponsored by a licensed employer.',
    'Requires a Certificate of Sponsorship (CoS) from a Home Office-licensed sponsor for an eligible occupation, plus a minimum salary of GBP 41,700/year (or 100% of the role''s going rate, whichever is higher, from 22 July 2025) — lower thresholds apply to some New Entrant, health-care, and shortage roles.',
    'Tied to the CoS; up to 5 years, extendable, with a pathway to settlement',
    'Employer obtains a sponsor licence and issues a CoS; employee then applies via gov.uk',
    1,
    'Processing timelines depend on the sponsor and individual circumstances',
    'VFS Global UK Visa Application Centre, India',
    'Employer becomes a licensed sponsor and issues your Certificate of Sponsorship\nPay the Immigration Health Surcharge upfront\nGather documents against this checklist\nSubmit your application online via gov.uk\nAttend a VFS Global centre for biometrics\nDecision — digital eVisa issued once approved',
    '/assets/images/visa-heroes/uk.jpg',
    'UK Home Office Skilled Worker visa guidance', 'https://www.gov.uk/skilled-worker-visa', '2026-09-11'
);
SET @gt4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gt4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt4, 'Core Documents', 'Every applicant needs these.', 1);
SET @gt4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@gt4s1, 'Certificate of Sponsorship Reference', 'From your licensed UK employer.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt4, 'Employer Sponsorship Documents', 'Evidence of your job offer and salary.', 2);
SET @gt4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt4s2, 'Employment Contract & Job Description', 'Confirming your salary meets the GBP 41,700 threshold or applicable going rate.', 'copy', 1, 0, 1, 1),
(@gt4s2, 'IHS Payment Receipt', 'GBP 1,035/year, standard rate.', 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt4, 'Qualification Documents', 'Evidence you meet the role''s requirements.', 3);
SET @gt4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt4s3, 'Educational Credentials & Resume', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(152, 4, 319.00, 'GBP', 'Skilled Worker Visa Fee (Up to 3 Years)', 'GBP 319 for stays up to 3 years, GBP 769 for longer. Plus IHS of GBP 1,035/year. Separate employer-side costs (Certificate of Sponsorship fee GBP 525, Immigration Skills Charge) are borne by the sponsoring employer, not the applicant.', '2026-04-08', NOW(), 'https://www.gov.uk/skilled-worker-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the current minimum salary for a Skilled Worker visa?', 'GBP 41,700/year (or 100% of the role''s going rate, whichever is higher), effective from 22 July 2025 and still current in 2026 — lower thresholds apply to some New Entrant, health-care, and shortage occupations.', 152, 4, 989, 1),
('Who pays the Certificate of Sponsorship fee?', 'Your sponsoring employer, not you — along with the Immigration Skills Charge, both are employer-side costs separate from your own application fee.', 152, 4, 990, 1),
('Can I apply without a job offer?', 'No — Skilled Worker requires a Certificate of Sponsorship from a licensed UK employer for an eligible occupation before you can apply.', 152, 4, 991, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Standard Visitor Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    152, 5, 'GBR-FAM-IN-05', '2026.09', 'published',
    'Visiting family members in the United Kingdom.',
    'Family visits use the same Standard Visitor visa as Tourist — the UK has no distinct "family visa." An invitation letter from your UK-based family member, relationship proof, and evidence of your host''s immigration status are the differentiating documents.',
    'Up to 6 months per visit',
    'Online application via gov.uk, biometrics at a VFS Global centre',
    1,
    'Processing typically runs around 3 weeks',
    'VFS Global UK Visa Application Centre, India',
    'Initial consultation to confirm Standard Visitor (Family Visit) is correct\nObtain an invitation letter and relationship proof from your UK host\nGather documents against this checklist\nSubmit your application online via gov.uk\nAttend a VFS Global centre for biometrics\nDecision — digital eVisa issued once approved',
    '/assets/images/visa-heroes/uk.jpg',
    'UK Home Office Standard Visitor visa (family visits) guidance', 'https://www.gov.uk/standard-visitor', '2026-09-11'
);
SET @gt5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gt5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt5, 'Core Documents', 'Every applicant needs these.', 1);
SET @gt5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@gt5s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt5, 'Host Invitation & Relationship Proof', 'Evidence of who you are visiting.', 2);
SET @gt5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt5s2, 'Invitation Letter from UK Family Member', NULL, 'original', 1, 0, 1, 1),
(@gt5s2, 'Proof of Host''s UK Immigration Status', NULL, 'copy', 1, 0, 1, 2),
(@gt5s2, 'Relationship Proof', 'Birth/marriage certificates.', 'copy', 1, 0, 0, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt5, 'Financial Documents', 'Evidence of funds.', 3);
SET @gt5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt5s3, 'Bank Statements', 'Last 6 months.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(152, 5, 135.00, 'GBP', 'Standard Visitor Visa Fee', 'Same fee structure as Tourist — Family Visit is the same Standard Visitor visa.', '2026-04-08', NOW(), 'https://www.gov.uk/standard-visitor', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Family Visit visa for the UK?', 'No — it uses the same Standard Visitor visa as Tourist, with the addition of your host''s invitation letter and relationship proof.', 152, 5, 992, 1),
('What proof of my host''s status is needed?', 'A copy of their UK passport, visa, or residence document confirming their right to be in the UK.', 152, 5, 993, 1),
('How long can I stay visiting family?', 'Up to 6 months per visit, the same as any Standard Visitor visa.', 152, 5, 994, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — DATV / Visitor in Transit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    152, 6, 'GBR-TRANS-IN-06', '2026.09', 'published',
    'Passing through the United Kingdom en route to a third country.',
    'Two genuinely different products exist: a Direct Airside Transit Visa (DATV) for travellers who stay airside and never pass UK border control, and a "Visitor in Transit" (part of the Standard Visitor visa) for those who must pass through border control (e.g. changing terminals/airports). India is on the DATV national list, so most Indian transit passengers need one or the other.',
    'DATV: airside only, no entry to the UK. Visitor in Transit: up to 6 months validity, used briefly for your connection',
    'Online application via gov.uk, biometrics at a VFS Global centre',
    1,
    'Confirm which product your specific routing needs before applying',
    'VFS Global UK Visa Application Centre, India',
    'Confirm whether you need a DATV (airside only) or Visitor in Transit (passing border control)\nCheck if you qualify for a DATV exemption (e.g. valid US/Canada/Australia/NZ visa)\nGather documents against this checklist\nSubmit your application online via gov.uk\nAttend a VFS Global centre for biometrics\nDecision — digital eVisa issued once approved',
    '/assets/images/visa-heroes/uk.jpg',
    'UK Home Office Transit visa (DATV and Visitor in Transit) guidance', 'https://www.gov.uk/transit-visa', '2026-09-11'
);
SET @gt6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gt6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt6, 'Core Documents', 'Every applicant needs these.', 1);
SET @gt6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@gt6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt6, 'DATV Exemption Documents', 'If you qualify for a DATV exemption.', 2);
SET @gt6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt6s2, 'Valid US/Canada/Australia/NZ Visa or Green Card', 'Qualifies you for a DATV exemption.', 'copy', 0, 1, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt6, 'Destination Documents', 'Evidence of your final destination.', 3);
SET @gt6s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt6s3, 'Valid Visa for Final Destination', 'If required.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(152, 6, 41.50, 'GBP', 'Direct Airside Transit Visa (DATV) Fee', 'GBP 41.50 for a DATV (airside only, never passing border control). If you must pass through UK border control instead, the Visitor in Transit fee is GBP 135, the same as Standard Visitor.', '2026-04-08', NOW(), 'https://www.gov.uk/transit-visa/direct-airside-transit-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the difference between a DATV and Visitor in Transit?', 'A DATV (GBP 41.50) is for travellers who stay airside and never pass UK border control; Visitor in Transit (GBP 135) is needed if you must pass through border control, such as changing terminals or airports.', 152, 6, 995, 1),
('Am I exempt from needing a DATV?', 'You may be exempt if you already hold a valid US, Canada, Australia, or New Zealand visa or green card, or already hold a valid UK Standard Visitor visa.', 152, 6, 996, 1),
('Does a DATV let me enter the UK?', 'No — a DATV is explicitly not entry clearance and does not authorize you to enter the UK, only to remain airside during your connection.', 152, 6, 997, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Standard Visitor Visa (Medical Treatment)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    152, 7, 'GBR-MED-IN-07', '2026.09', 'published',
    'Travelling to the United Kingdom to receive medical treatment.',
    'Uses the same Standard Visitor visa as Tourist, under its medical treatment provision. A UK doctor/clinic letter confirming the consultation or treatment, its estimated cost and duration, and proof of funds are the key differentiating documents. Stays can, with justification, extend beyond 6 months — up to 11 months for cosmetic/private medical treatment cases.',
    'Up to 6 months, extendable up to 11 months for private/cosmetic treatment with justification',
    'Online application via gov.uk, biometrics at a VFS Global centre',
    1,
    'Processing typically runs around 3 weeks',
    'VFS Global UK Visa Application Centre, India',
    'Obtain a treatment letter from the UK doctor or clinic\nGather documents against this checklist\nSubmit your application online via gov.uk\nAttend a VFS Global centre for biometrics\nDecision — digital eVisa issued once approved',
    '/assets/images/visa-heroes/uk.jpg',
    'UK Home Office Standard Visitor visa (medical treatment) guidance', 'https://www.gov.uk/standard-visitor', '2026-09-11'
);
SET @gt7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gt7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt7, 'Core Documents', 'Every applicant needs these.', 1);
SET @gt7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@gt7s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt7, 'Medical Documents', 'Evidence of your treatment plan.', 2);
SET @gt7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt7s2, 'UK Doctor/Clinic Treatment Letter', 'Confirming diagnosis, treatment, estimated cost and duration.', 'original', 1, 0, 1, 1),
(@gt7s2, 'Referral from Doctor in India', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt7, 'Financial Documents', 'Evidence you can pay for treatment.', 3);
SET @gt7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt7s3, 'Proof of Funds for Treatment & Living Costs', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(152, 7, 135.00, 'GBP', 'Standard Visitor Visa Fee', 'Same fee structure as Tourist — Medical treatment is a Standard Visitor visa purpose, not a separate visa.', '2026-04-08', NOW(), 'https://www.gov.uk/standard-visitor', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Medical Visa for the UK?', 'No — it uses the same Standard Visitor visa, with treatment-specific documents like a doctor/clinic letter.', 152, 7, 998, 1),
('Can I stay longer than 6 months for treatment?', 'Yes — with justification, stays can extend up to 11 months for private or cosmetic medical treatment cases.', 152, 7, 999, 1),
('Does the UK''s NHS cover visitors?', 'No — as a visitor, you are generally responsible for the cost of private treatment, so proof of funds is required.', 152, 7, 1000, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Standard Visitor Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    152, 8, 'GBR-CONF-IN-08', '2026.09', 'published',
    'Attending or presenting at a conference or convention in the United Kingdom.',
    'Uses the same Standard Visitor visa as Business, as a permitted business activity. A conference invitation/registration confirmation from the UK organizer is the key differentiating document; speakers should also be able to show they are not a main organizer or UK-based employee, since paid work for a UK entity is restricted under visitor rules.',
    'Up to 6 months per visit',
    'Online application via gov.uk, biometrics at a VFS Global centre',
    1,
    'Processing typically runs around 3 weeks',
    'VFS Global UK Visa Application Centre, India',
    'Obtain your conference invitation/registration confirmation\nGather documents against this checklist\nSubmit your application online via gov.uk\nAttend a VFS Global centre for biometrics\nDecision — digital eVisa issued once approved',
    '/assets/images/visa-heroes/uk.jpg',
    'UK Home Office Standard Visitor visa (business activities, conferences) guidance', 'https://www.gov.uk/standard-visitor', '2026-09-11'
);
SET @gt8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gt8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt8, 'Core Documents', 'Every applicant needs these.', 1);
SET @gt8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@gt8s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt8, 'Conference Documents', 'Evidence of the event and your role.', 2);
SET @gt8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt8s2, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 1),
(@gt8s2, 'Employer Letter from India', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt8, 'Financial Documents', 'Evidence of funds.', 3);
SET @gt8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt8s3, 'Bank Statements', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(152, 8, 135.00, 'GBP', 'Standard Visitor Visa Fee', 'Same fee structure as Business — Conference is a Standard Visitor visa purpose.', '2026-04-08', NOW(), 'https://www.gov.uk/standard-visitor', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Conference a separate visa category for the UK?', 'No — it uses the same Standard Visitor visa as Business, as a permitted business activity.', 152, 8, 1001, 1),
('Can I be paid to speak at a UK conference?', 'Limited paid engagements for recognized experts are allowed under specific visitor rules — we assess this case by case.', 152, 8, 1002, 1),
('What document specifically supports a conference application?', 'Your conference invitation or registration confirmation from the UK organizer, alongside your employer letter from India.', 152, 8, 1003, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Standard Visitor Visa / International Sportsperson Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    152, 9, 'GBR-SPORT-IN-09', '2026.09', 'published',
    'Competing as an amateur, or as a paid/contracted sportsperson or support staff, in the United Kingdom.',
    'Genuinely splits by payment status: amateur/unpaid competitors (beyond expenses) use the Standard Visitor visa, while paid/contracted sportspeople and their support staff must use the distinct International Sportsperson visa (which replaced the old Tier 2 Sportsperson/Tier 5 routes in October 2021), requiring endorsement from the sport''s governing body.',
    'Amateur: up to 6 months under Standard Visitor. Sportsperson: tied to the endorsement/contract, up to 12 months or longer',
    'Amateur: standard Visitor visa application. Sportsperson: International Sportsperson visa via gov.uk, requires governing body endorsement',
    1,
    'Confirm your amateur/professional status first — it determines which visa and fee applies',
    'VFS Global UK Visa Application Centre, India',
    'Confirm whether your participation is amateur/unpaid or paid/contracted\nFor Sportsperson: obtain endorsement from your sport''s governing body\nGather documents against this checklist for the applicable pathway\nSubmit your application online via gov.uk\nAttend a VFS Global centre for biometrics\nDecision — digital eVisa issued once approved',
    '/assets/images/visa-heroes/uk.jpg',
    'UK Home Office Standard Visitor (amateur sport) and International Sportsperson visa guidance', 'https://www.gov.uk/standard-visitor', '2026-09-11'
);
SET @gt9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gt9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt9, 'Core Documents', 'Every applicant needs these.', 1);
SET @gt9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@gt9s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt9, 'Amateur Event Documents', 'For unpaid competitors.', 2);
SET @gt9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt9s2, 'Invitation from UK Sporting Body/Event', NULL, 'original', 0, 1, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt9, 'International Sportsperson Documents', 'For paid/contracted sportspeople and support staff.', 3);
SET @gt9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt9s3, 'Governing Body Endorsement', NULL, 'copy', 0, 1, 0, 1),
(@gt9s3, 'IHS Payment Receipt', 'GBP 1,035/year adult, GBP 776/year child.', 'original', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(152, 9, NULL, 'GBP', 'Confirmed After Assessment', 'GBP 135 (Standard Visitor) for amateur competitors, or GBP 319/GBP 769 (International Sportsperson) for paid/contracted sportspeople — confirmed once your status is assessed.', '2026-04-08', NOW(), 'https://www.gov.uk/standard-visitor', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do all athletes need the International Sportsperson visa?', 'No — only paid/contracted sportspeople and their support staff. Amateur/unpaid competitors use the standard Standard Visitor visa instead.', 152, 9, 1004, 1),
('What replaced the old Tier 2 Sportsperson and Tier 5 routes?', 'The International Sportsperson visa, introduced in October 2021, requiring endorsement from the applicant''s sport''s governing body.', 152, 9, 1005, 1),
('Does the Sportsperson visa require the Immigration Health Surcharge?', 'Yes — GBP 1,035/year for adults, GBP 776/year for children, in addition to the visa application fee.', 152, 9, 1006, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Dependant Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    152, 10, 'GBR-DEP-IN-10', '2026.09', 'published',
    'Joining a spouse/partner or parent who holds a UK Skilled Worker or Student visa.',
    'Since 2024-2025 rule changes, dependant eligibility for Skilled Worker is occupation/RQF-level restricted — most care workers and many medium-skilled occupations can no longer bring dependants at all. Fees and IHS track the principal''s route rather than one flat figure.',
    'Matches the validity of the principal visa holder''s visa',
    'Online application via gov.uk, biometrics at a VFS Global centre',
    1,
    'Confirm the principal holder''s occupation/route is dependant-eligible before applying',
    'VFS Global UK Visa Application Centre, India',
    'Confirm the principal visa holder''s route and dependant eligibility\nGather documents against this checklist, including relationship proof\nPay the Immigration Health Surcharge for each dependant\nSubmit your application online via gov.uk\nAttend a VFS Global centre for biometrics\nDecision — digital eVisa issued once approved',
    '/assets/images/visa-heroes/uk.jpg',
    'UK Home Office Skilled Worker and Student dependant visa guidance', 'https://www.gov.uk/skilled-worker-visa', '2026-09-11'
);
SET @gt10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gt10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt10, 'Core Documents', 'Every applicant needs these.', 1);
SET @gt10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@gt10s1, 'Principal Holder''s Visa/CoS Reference', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt10, 'Relationship Documents', 'Evidence of your relationship to the principal holder.', 2);
SET @gt10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt10s2, 'Marriage/Partnership Certificate', 'For a spouse/partner applicant.', 'copy', 0, 1, 1, 1),
(@gt10s2, 'Birth Certificate', 'For a child applicant.', 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gt10, 'Financial Documents', 'Evidence of funds.', 3);
SET @gt10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gt10s3, 'Maintenance Funds Evidence', 'GBP 285 (partner) plus GBP 315 (first child) plus GBP 200 (each further child) for Skilled Worker dependants, held 28 days, unless sponsor-certified.', 'copy', 1, 0, 0, 1),
(@gt10s3, 'IHS Payment Receipt', 'Per dependant, same rate as the principal.', 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(152, 10, 827.00, 'GBP', 'Skilled Worker Dependant Fee (Up to 3 Years)', 'GBP 827 for Skilled Worker dependants (CoS up to 3 years), GBP 1,636 for longer. Student dependant fee mirrors the GBP 558 main applicant fee. IHS charged per dependant at the principal''s rate.', '2026-04-08', NOW(), 'https://www.gov.uk/skilled-worker-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can every Skilled Worker bring dependants?', 'No — since 2024-2025 rule changes, dependant eligibility is restricted by occupation/RQF level; most care workers and many medium-skilled roles can no longer bring dependants at all.', 152, 10, 1007, 1),
('How much in funds do I need per dependant?', 'For Skilled Worker dependants: GBP 285 for a partner, plus GBP 315 for the first child, plus GBP 200 for each further child, held 28 consecutive days, unless the sponsor certifies maintenance.', 152, 10, 1008, 1),
('Does each dependant pay the Immigration Health Surcharge separately?', 'Yes — IHS is charged per dependant, at the same rate as the principal visa holder''s own route.', 152, 10, 1009, 1);
