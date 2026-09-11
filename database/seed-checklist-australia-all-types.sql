-- Australia Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as Mexico/Singapore/
-- France/Japan/USA (see AUDIT.md). Australia's real, distinctive facts:
--   - Indian passport holders are NOT eligible for the ETA or eVisitor
--     schemes (those are for select European/other passport holders) —
--     every Indian applicant needs a full visa application via
--     ImmiAccount, whatever the purpose.
--   - Tourist, Business, Family Visit and Sponsored Family all sit
--     inside Subclass 600 Visitor Visa, distinguished by "stream," not
--     separate visa products — each stream carries its own fee,
--     document set, and (for Sponsored Family) an Assurance of Support.
--   - Genuine Temporary Entrant (GTE)/Genuine Student (GS) requirement:
--     Australia decides visitor and student visas heavily on whether
--     the applicant is assessed as a genuine temporary visitor, not
--     just on paperwork completeness — stated honestly rather than
--     presented as a rubber-stamp process.
--   - Sports: the old Subclass 421 Sport Visa is CLOSED (a repealed
--     visa); sportspeople/coaches now use Subclass 408's Sporting
--     Activities stream — this is a real, recent product change, not a
--     copy-paste of an outdated pathway.
--   - Transit (Subclass 771) is one of the only Australian visas with a
--     genuine AUD $0 fee.
--   - Medical: Australia runs two real, distinct pathways — the
--     lighter-touch Subclass 600 Medical Treatment stream, and the more
--     formal standalone Subclass 602 Medical Treatment visa — both
--     documented here rather than picking one and pretending the other
--     doesn't exist.
--   - Dependent: there is no separate "Dependent Visa" product — family
--     members are added to the principal Subclass 482/500 applicant's
--     own application (combined lodgement) or added later via a
--     Subsequent Entrant application once the principal is already in
--     Australia.
--
-- country_id 181 = Australia. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.
--
-- hero_image_url points at the real Sydney Opera House/Harbour Bridge
-- and Australian flag photo supplied by the client for this hero.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Subclass 600, Tourist stream
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    181, 1, 'AUS-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and visiting friends/relatives in Australia.',
    'Indian passport holders are not eligible for Australia''s ETA or eVisitor schemes and must apply for the Subclass 600 Visitor Visa (Tourist stream) via ImmiAccount. The Genuine Temporary Entrant (GTE) requirement is decisive — the officer must be satisfied you intend a genuine, temporary visit.',
    'Typically 3, 6, or 12 months as granted, within a visa validity of up to 12 months',
    'Online application via ImmiAccount, no VFS/visa centre required for most applicants',
    0,
    'Most straightforward applications are decided within a few weeks, though timeframes vary by individual case',
    'Department of Home Affairs — online via ImmiAccount (no in-person office visit required for most applicants)',
    'Initial consultation to confirm Subclass 600 Tourist stream is correct\nCreate/use your ImmiAccount and gather documents against this checklist\nWrite a clear statement addressing the Genuine Temporary Entrant requirement\nSubmit your application and pay the visa application charge online\nSupport responding to any request for additional information\nDecision — most applications are e-visas, no passport stamp required',
    '/assets/images/visa-heroes/australia.jpg',
    'Australian Department of Home Affairs (immi.homeaffairs.gov.au) Visitor Visa Subclass 600 guidance', 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/visitor-600', '2026-09-11'
);
SET @at1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at1, 'Core Documents', 'Every applicant needs these.', 1);
SET @at1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at1s1, 'Valid Passport', 'Valid for your intended stay in Australia.', 'original', 1, 0, 1, 1),
(@at1s1, 'Passport Photograph', 'Recent colour photo per Australian visa photo requirements.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at1, 'Genuine Temporary Entrant & Ties Documents', 'Evidence supporting your genuine, temporary visit.', 2);
SET @at1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at1s2, 'GTE Statement', 'A written statement addressing your circumstances, purpose of visit, and intention to return to India.', 'original', 1, 0, 1, 1),
(@at1s2, 'Proof of Ties to India', 'Employment letter, property documents, or family ties evidence.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at1, 'Financial & Travel Documents', 'Evidence you can support your trip.', 3);
SET @at1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at1s3, 'Bank Statements', 'Last 3-6 months, showing sufficient funds.', 'copy', 1, 0, 0, 1),
(@at1s3, 'Travel Itinerary', 'Indicative flight and accommodation plans.', 'original', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at1, 'Health & Character', 'Standard checks for longer or specific-risk stays.', 4);
SET @at1s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at1s4, 'Health Examination', 'Required only if requested by the Department based on your circumstances.', 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(181, 1, 250.00, 'AUD', 'Visitor Visa Application Charge (Tourist Stream)', 'Effective from 1 July 2026. Paid online via ImmiAccount; non-refundable regardless of outcome.', '2026-07-01', NOW(), 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/visitor-600', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens use Australia''s ETA or eVisitor visa?', 'No — the ETA and eVisitor schemes are limited to select European and other eligible passport holders. Indian passport holders must apply for the full Subclass 600 Visitor Visa.', 181, 1, 830, 1),
('What is the Genuine Temporary Entrant requirement?', 'The visa officer must be satisfied you genuinely intend a temporary visit and will return to India — a written GTE statement and evidence of ties to India materially strengthen your application.', 181, 1, 831, 1),
('Do I need to visit a visa application centre?', 'No — most Subclass 600 applications are submitted entirely online via ImmiAccount, with no requirement to attend an office in person.', 181, 1, 832, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Subclass 600, Business stream
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    181, 2, 'AUS-BUS-IN-02', '2026.09', 'published',
    'Short business visits — meetings, negotiations, and unpaid conference attendance — to Australia.',
    'The Subclass 600 Business stream allows meetings, negotiations, and even unpaid conference attendance, but never paid work in Australia. A clear invitation letter and evidence of the business purpose are central to a successful application.',
    'Typically 3, 6, or 12 months as granted, within a visa validity of up to 12 months',
    'Online application via ImmiAccount',
    0,
    'Most straightforward applications are decided within a few weeks, though timeframes vary by individual case',
    'Department of Home Affairs — online via ImmiAccount',
    'Initial consultation to confirm Subclass 600 Business stream is correct\nObtain an invitation letter from your Australian business contact\nCreate/use your ImmiAccount and gather documents against this checklist\nSubmit your application and pay the visa application charge online\nSupport responding to any request for additional information\nDecision — most applications are e-visas',
    '/assets/images/visa-heroes/australia.jpg',
    'Australian Department of Home Affairs Visitor Visa Subclass 600 (Business stream) guidance', 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/visitor-600/business-visitor', '2026-09-11'
);
SET @at2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at2, 'Core Documents', 'Every applicant needs these.', 1);
SET @at2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at2s1, 'Valid Passport', 'Valid for your intended stay.', 'original', 1, 0, 1, 1),
(@at2s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at2, 'Business Invitation & Purpose', 'Evidence of your business activity.', 2);
SET @at2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at2s2, 'Invitation Letter from Australian Host', 'Stating purpose, duration, and confirming no paid work will occur.', 'original', 1, 0, 1, 1),
(@at2s2, 'Covering Letter from Indian Employer', 'Confirming your role and purpose of travel.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at2, 'Financial & GTE Documents', 'Evidence of funds and genuine intent.', 3);
SET @at2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at2s3, 'Bank Statements', 'Last 3-6 months.', 'copy', 1, 0, 0, 1),
(@at2s3, 'GTE Statement', 'Addressing your genuine intent to return to India.', 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(181, 2, 365.00, 'AUD', 'Visitor Visa Application Charge (Business Stream)', 'Business stream carries a higher fee than Tourist — paid online via ImmiAccount, non-refundable.', '2026-07-01', NOW(), 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/visitor-600/business-visitor', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I do paid work on a Business stream Subclass 600?', 'No — the Business stream permits meetings, negotiations, and even unpaid conference attendance, but never paid work in Australia.', 181, 2, 833, 1),
('Why is the Business stream fee higher than Tourist?', 'Subclass 600''s different streams carry different fees set by the Department of Home Affairs — Business stream is currently AUD 365 versus AUD 250 for Tourist.', 181, 2, 834, 1),
('What makes a strong invitation letter?', 'One on official letterhead, clearly stating purpose, duration, and confirming the visit involves no paid work — vague or generic letters are a common cause of delay or refusal.', 181, 2, 835, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Subclass 500
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    181, 3, 'AUS-STU-IN-03', '2026.09', 'published',
    'Full-time study at a CRICOS-registered Australian education provider.',
    'Requires a Confirmation of Enrolment (CoE) from a CRICOS-registered provider and satisfying the Genuine Student (GS) requirement — built into the online application as short-answer questions, replacing the older separate GTE statement.',
    'Duration of your CRICOS-registered course, plus limited post-course allowance where applicable',
    'Online application via ImmiAccount, requires prior CoE from a CRICOS-registered provider',
    0,
    'Processing times vary by provider risk level and individual circumstances',
    'Department of Home Affairs — online via ImmiAccount',
    'Secure admission and receive your Confirmation of Enrolment (CoE)\nArrange Overseas Student Health Cover (OSHC)\nCreate/use your ImmiAccount and gather documents against this checklist\nAnswer the Genuine Student (GS) short-answer questions\nSubmit your application and pay the visa application charge\nDecision once processed',
    '/assets/images/visa-heroes/australia.jpg',
    'Australian Department of Home Affairs Student Visa Subclass 500 guidance', 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/student-500', '2026-09-11'
);
SET @at3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at3, 'Core Documents', 'Every applicant needs these.', 1);
SET @at3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at3s1, 'Confirmation of Enrolment (CoE)', 'From your CRICOS-registered provider.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at3, 'Genuine Student Documents', 'Evidence supporting the Genuine Student requirement.', 2);
SET @at3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at3s2, 'Genuine Student (GS) Responses', 'Short-answer questions in your online application addressing your study intent and circumstances.', 'original', 1, 0, 1, 1),
(@at3s2, 'Academic Transcripts & Test Scores', 'Prior qualifications and English test scores as required by your course.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at3, 'Financial Documents', 'Evidence you can fund your studies.', 3);
SET @at3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at3s3, 'Financial Capacity Evidence', 'Bank statements/loan sanction covering the annual living-cost benchmark, tuition, and travel.', 'copy', 1, 0, 0, 1),
(@at3s3, 'Overseas Student Health Cover (OSHC)', 'Mandatory health insurance for the full visa duration.', 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(181, 3, 1600.00, 'AUD', 'Student Visa Application Charge', 'Base application charge, 2026. Annual living-cost benchmark for financial capacity is AUD 29,710 (2026 figure) and is separate from this application fee.', '2026-01-01', NOW(), 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/student-500', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What replaced the old GTE statement for students?', 'The Genuine Student (GS) requirement, answered via short-answer questions built directly into the online application, rather than a separate written statement.', 181, 3, 836, 1),
('How much do I need to show for living costs?', 'The 2026 annual living-cost benchmark is AUD 29,710, in addition to tuition fees and return travel funds.', 181, 3, 837, 1),
('Is health insurance mandatory for the full visa period?', 'Yes — Overseas Student Health Cover (OSHC) must be arranged and maintained for the full duration of your student visa.', 181, 3, 838, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Subclass 482, Skills in Demand
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    181, 4, 'AUS-WORK-IN-04', '2026.09', 'published',
    'Skilled employment in Australia, sponsored by an approved employer.',
    'The Skills in Demand visa (Subclass 482, renamed from TSS 482 on 7 December 2024) is entirely employer-sponsored: the employer must be an approved Standard Business Sponsor and lodge a nomination, and the applicant generally needs 1+ year of relevant work experience.',
    'Tied to the nomination term; offers a pathway to permanent residence (Subclass 186) after around 2 years',
    'Employer lodges sponsorship and nomination; employee applies once nomination is approved',
    0,
    'Processing time depends on the nomination and individual application complexity',
    'Department of Home Affairs — online via ImmiAccount',
    'Employer becomes an approved Standard Business Sponsor\nEmployer lodges the nomination for your position\nGather documents against this checklist, including experience evidence\nSubmit your visa application via ImmiAccount once nomination is approved\nSupport responding to any request for additional information\nDecision — pathway to Subclass 186 permanent residence after ~2 years',
    '/assets/images/visa-heroes/australia.jpg',
    'Australian Department of Home Affairs Skills in Demand visa Subclass 482 guidance', 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/skills-in-demand-482', '2026-09-11'
);
SET @at4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at4, 'Core Documents', 'Every applicant needs these.', 1);
SET @at4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at4s1, 'Nomination Approval Notice', 'From the Department, confirming your employer''s nomination.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at4, 'Employer Sponsorship Documents', 'Evidence of the sponsoring employer and role.', 2);
SET @at4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at4s2, 'Standard Business Sponsorship Approval', 'Confirming your employer is an approved sponsor.', 'copy', 1, 0, 1, 2),
(@at4s2, 'Employment Contract & Job Description', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at4, 'Qualification Documents', 'Evidence of your experience and skills.', 3);
SET @at4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at4s3, 'Work Experience Evidence', 'At least 1 year relevant experience, via reference letters and payslips.', 'copy', 1, 0, 0, 1),
(@at4s3, 'Skills Assessment', 'If required for your specific occupation.', 'original', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(181, 4, 2700.00, 'AUD', 'Skills in Demand Visa Application Charge', 'Indicative base application charge; separate employer-side sponsorship and nomination fees also apply and are typically borne by the employer, not the applicant.', '2026-01-01', NOW(), 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/skills-in-demand-482', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for a 482 visa without an employer?', 'No — Subclass 482 is entirely employer-sponsored. Your employer must be an approved Standard Business Sponsor and must lodge a nomination for your specific role before you can apply.', 181, 4, 839, 1),
('Does the 482 visa lead to permanent residence?', 'It can — there is a pathway to permanent residence via Subclass 186 after approximately 2 years, depending on your specific circumstances and occupation.', 181, 4, 840, 1),
('Was Subclass 482 previously called something else?', 'Yes — it was renamed from the Temporary Skill Shortage (TSS) 482 visa to the Skills in Demand visa on 7 December 2024, with updated eligibility settings.', 181, 4, 841, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Subclass 600, Sponsored Family stream
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    181, 5, 'AUS-FAM-IN-05', '2026.09', 'published',
    'Visiting family members settled in Australia.',
    'The Sponsored Family stream of Subclass 600 requires your Australian-based sponsor to be settled for 2+ years and to lodge Form 1149 (Assurance of Support) alongside your application, giving this a distinct sponsor-side requirement Tourist/Business streams do not have.',
    'Typically 3, 6, or 12 months as granted, within a visa validity of up to 12 months',
    'Online application via ImmiAccount, requires an eligible sponsor',
    0,
    'Processing depends on both the sponsor''s eligibility check and your own application',
    'Department of Home Affairs — online via ImmiAccount',
    'Confirm your Australian sponsor has been settled for 2+ years\nSponsor completes Form 1149 (Assurance of Support)\nGather documents against this checklist, including relationship proof\nSubmit your application and pay the visa application charge\nSupport responding to any request for additional information\nDecision once processed',
    '/assets/images/visa-heroes/australia.jpg',
    'Australian Department of Home Affairs Visitor Visa Subclass 600 (Sponsored Family stream) guidance', 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/visitor-600/sponsored-family', '2026-09-11'
);
SET @at5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at5, 'Core Documents', 'Every applicant needs these.', 1);
SET @at5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at5s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at5, 'Sponsorship Documents', 'Evidence of your sponsor''s eligibility and commitment.', 2);
SET @at5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at5s2, 'Form 1149 (Assurance of Support)', 'Completed by your Australian sponsor.', 'original', 1, 0, 1, 1),
(@at5s2, 'Proof of Sponsor''s Settled Status', 'Evidence your sponsor has been settled in Australia for 2+ years.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at5, 'Relationship & Financial Documents', 'Evidence of your relationship and funds.', 3);
SET @at5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at5s3, 'Relationship Proof', 'Birth/marriage certificates establishing the family relationship.', 'copy', 1, 0, 0, 1),
(@at5s3, 'Bank Statements', 'Last 3-6 months.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(181, 5, 195.00, 'AUD', 'Visitor Visa Application Charge (Sponsored Family Stream)', 'Paid online via ImmiAccount; does not include any bond your sponsor may need to lodge under the Assurance of Support.', '2026-07-01', NOW(), 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/visitor-600/sponsored-family', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How long must my sponsor have been settled in Australia?', 'At least 2 years, to be eligible to sponsor you under the Sponsored Family stream of Subclass 600.', 181, 5, 842, 1),
('What is Form 1149?', 'The Assurance of Support form your Australian sponsor completes, formally committing to support your visit financially.', 181, 5, 843, 1),
('Is this the same as the general Tourist Visa?', 'No — the Sponsored Family stream sits within Subclass 600 alongside Tourist and Business, but has its own sponsor-eligibility and Assurance of Support requirements.', 181, 5, 844, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Subclass 771
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    181, 6, 'AUS-TRANS-IN-06', '2026.09', 'published',
    'Passing through Australia en route to a third country.',
    'A Subclass 771 Transit Visa is required for stays up to 72 hours, when leaving the transit zone, or when Transit Without Visa (TWOV) conditions are not met. Travellers under 8 hours who stay airside on a through-checked itinerary may qualify for TWOV instead of a full visa.',
    'Up to 72 hours',
    'Online application via ImmiAccount',
    0,
    'Check first whether your specific itinerary qualifies for Transit Without Visa (TWOV) before applying for a full Subclass 771',
    'Department of Home Affairs — online via ImmiAccount',
    'Confirm whether TWOV applies to your specific itinerary\nIf not, create/use your ImmiAccount and gather documents against this checklist\nSubmit your Subclass 771 application\nSupport responding to any request for additional information\nDecision once processed',
    '/assets/images/visa-heroes/australia.jpg',
    'Australian Department of Home Affairs Transit Visa Subclass 771 guidance', 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/transit-771', '2026-09-11'
);
SET @at6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at6, 'Core Documents', 'Every applicant needs these.', 1);
SET @at6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at6s1, 'Valid Passport', 'Valid for at least 6 months beyond your arrival.', 'original', 1, 0, 1, 1),
(@at6s1, 'Confirmed Onward Travel Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at6, 'Destination Documents', 'Evidence of your final destination.', 2);
SET @at6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at6s2, 'Valid Visa for Destination Country', 'If required by your final destination.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at6, 'Additional Checks', 'Occasionally requested items.', 3);
SET @at6s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at6s3, 'Police/Health Checks', 'Only if specifically requested by the Department.', 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(181, 6, 0.00, 'AUD', 'Transit Visa Application Charge', 'Subclass 771 is one of the few Australian visas with no application charge. Additional costs may apply only if police checks or health exams are specifically requested.', '2026-01-01', NOW(), 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/transit-771', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I always need a transit visa for Australia?', 'Not necessarily — if you are transiting airside for under 8 hours on a through-checked itinerary, you may qualify for Transit Without Visa (TWOV) instead of a full Subclass 771.', 181, 6, 845, 1),
('Is there a fee for the Transit Visa?', 'No — Subclass 771 is genuinely free of an application charge, one of the only Australian visas with a AUD 0 fee.', 181, 6, 846, 1),
('How long can I stay on a Transit Visa?', 'Up to 72 hours, strictly for the purpose of transiting to a third country.', 181, 6, 847, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Subclass 602 / Subclass 600 Medical stream
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    181, 7, 'AUS-MED-IN-07', '2026.09', 'published',
    'Travelling to Australia to receive medical treatment.',
    'Australia genuinely offers two real pathways: the lighter-touch Subclass 600 Medical Treatment stream for simpler/shorter treatment, and the more formal standalone Subclass 602 Medical Treatment visa requiring a detailed treating-doctor letter, cost estimate, and confirmed payment arrangements — we help identify which fits your case.',
    'As needed for the course of treatment',
    'Online application via ImmiAccount',
    0,
    'Processing depends on which stream/visa applies and the completeness of medical documentation',
    'Department of Home Affairs — online via ImmiAccount',
    'Initial consultation to identify the right pathway (Subclass 600 Medical stream vs Subclass 602)\nObtain a treatment letter from the Australian doctor/hospital\nGather documents against this checklist\nSubmit your application and pay the visa application charge\nSupport responding to any request for additional information\nDecision once processed',
    '/assets/images/visa-heroes/australia.jpg',
    'Australian Department of Home Affairs Medical Treatment visa (Subclass 602) and Visitor visa Medical stream guidance', 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/medical-treatment-602', '2026-09-11'
);
SET @at7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at7, 'Core Documents', 'Every applicant needs these.', 1);
SET @at7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at7s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at7, 'Medical Documents', 'Evidence of your treatment plan.', 2);
SET @at7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at7s2, 'Treating Doctor/Hospital Letter', 'Detailing diagnosis, treatment plan, estimated timeframe and cost.', 'original', 1, 0, 1, 1),
(@at7s2, 'Diagnosis Report from Indian Physician', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at7, 'Financial Documents', 'Evidence you can pay for treatment.', 3);
SET @at7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at7s3, 'Confirmed Payment Arrangement', 'Evidence the treating provider is satisfied with your payment arrangements.', 'copy', 1, 0, 0, 1),
(@at7s3, 'Bank Statements/Financial Guarantee', 'Covering treatment, living costs, and return travel.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(181, 7, NULL, 'AUD', 'Confirmed After Assessment', 'Fee depends on which pathway applies (Subclass 600 Medical stream vs standalone Subclass 602) and whether you apply offshore or onshore — we confirm the exact fee once your pathway is identified.', '2026-09-01', NOW(), 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/medical-treatment-602', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Are there two different medical visa options for Australia?', 'Yes — a lighter-touch Subclass 600 Medical Treatment stream for simpler cases, and a more formal standalone Subclass 602 Medical Treatment visa for more involved treatment plans. We help identify which fits your situation.', 181, 7, 848, 1),
('What does the treating doctor letter need to include?', 'The diagnosis, planned treatment, estimated timeframe and cost, and confirmation the provider is satisfied with your payment arrangements.', 181, 7, 849, 1),
('Does Australia''s public healthcare cover visitors?', 'No — as a visitor, you are responsible for the full cost of treatment and must show evidence of ability to pay.', 181, 7, 850, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Subclass 600, Business stream (conference purpose)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    181, 8, 'AUS-CONF-IN-08', '2026.09', 'published',
    'Attending or presenting at a conference, convention, or seminar in Australia.',
    'Conference attendance uses the same Subclass 600 Business stream as general business visits — Australia has no separate conference-visa product. The application should include conference registration confirmation and itinerary, an invitation letter from the host organisation (or employer letter), and evidence of your professional background.',
    'Typically 3, 6, or 12 months as granted, within a visa validity of up to 12 months',
    'Online application via ImmiAccount',
    0,
    'Processing depends on individual circumstances',
    'Department of Home Affairs — online via ImmiAccount',
    'Initial consultation to confirm Subclass 600 Business stream (conference purpose) is correct\nObtain conference registration confirmation and invitation letter\nGather documents against this checklist\nSubmit your application and pay the visa application charge\nSupport responding to any request for additional information\nDecision once processed',
    '/assets/images/visa-heroes/australia.jpg',
    'Australian Department of Home Affairs Visitor Visa Subclass 600 (Business stream) guidance', 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/visitor-600/business-visitor', '2026-09-11'
);
SET @at8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at8, 'Core Documents', 'Every applicant needs these.', 1);
SET @at8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at8s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at8, 'Conference Documents', 'Evidence of the event and your role.', 2);
SET @at8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at8s2, 'Conference Registration Confirmation & Itinerary', NULL, 'original', 1, 0, 1, 1),
(@at8s2, 'Invitation Letter from Host Organisation', 'Or an employer letter explaining the business purpose.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at8, 'Financial & GTE Documents', 'Evidence of funds and genuine intent.', 3);
SET @at8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at8s3, 'Bank Statements', 'Last 3-6 months.', 'copy', 1, 0, 0, 1),
(@at8s3, 'GTE Statement', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(181, 8, 365.00, 'AUD', 'Visitor Visa Application Charge (Business Stream)', 'Conference attendance uses the same Business stream and fee as general Business visits.', '2026-07-01', NOW(), 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/visitor-600/business-visitor', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Conference Visa for Australia?', 'No — conference attendance is processed under the same Subclass 600 Business stream as general business visits.', 181, 8, 851, 1),
('What documents does a conference application specifically need?', 'Conference registration confirmation and itinerary, an invitation letter from the host organisation (or your employer), and evidence of your professional background.', 181, 8, 852, 1),
('Can I present a paper as well as attend?', 'Yes — presenting is a normal part of the conference-purpose Business stream; simply reflect this in your application and any acceptance/registration documents.', 181, 8, 853, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Subclass 408, Sporting Activities stream
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    181, 9, 'AUS-SPORT-IN-09', '2026.09', 'published',
    'Playing or coaching for an Australian team, or undertaking high-level training with an Australian sporting organisation.',
    'The former Subclass 421 Sport Visa is closed to new applications — sportspeople and coaches now use Subclass 408''s Sporting Activities stream, requiring sponsorship from an Australian sporting organisation and evidence of your playing/coaching engagement.',
    'From approximately 3 months up to 4 years, depending on the specific activity and stream',
    'Online application via ImmiAccount, requires sponsorship from an Australian sporting organisation',
    0,
    'Processing depends on the sponsoring organisation and individual circumstances',
    'Department of Home Affairs — online via ImmiAccount',
    'Obtain sponsorship/nomination from an Australian sporting organisation\nGather documents against this checklist, including evidence of your playing/coaching role\nSubmit your Subclass 408 (Sporting Activities stream) application\nSupport responding to any request for additional information\nDecision once processed',
    '/assets/images/visa-heroes/australia.jpg',
    'Australian Department of Home Affairs Temporary Activity visa Subclass 408 (Sporting Activities stream) guidance', 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/temporary-activity-408/sporting-activities', '2026-09-11'
);
SET @at9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at9, 'Core Documents', 'Every applicant needs these.', 1);
SET @at9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at9s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at9, 'Sponsorship & Engagement Documents', 'Evidence of your sporting engagement.', 2);
SET @at9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at9s2, 'Sponsorship/Nomination from Sporting Organisation', NULL, 'original', 1, 0, 1, 1),
(@at9s2, 'Evidence of Playing/Coaching Role', 'Contract, team letter, or training program details.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at9, 'Financial Documents', 'Evidence of funds where required.', 3);
SET @at9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at9s3, 'Bank Statements', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(181, 9, NULL, 'AUD', 'Confirmed After Assessment', 'Subclass 408 fees vary by stream and duration — we confirm the exact fee once your specific sporting engagement is assessed.', '2026-09-01', NOW(), 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/temporary-activity-408/sporting-activities', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the old Sport Visa (Subclass 421) still available?', 'No — Subclass 421 is closed to new applications. Sportspeople and coaches now apply under Subclass 408''s Sporting Activities stream.', 181, 9, 854, 1),
('Do I need a sponsor to apply?', 'Yes — sponsorship or nomination from an Australian sporting organisation is required for the Sporting Activities stream.', 181, 9, 855, 1),
('How long can I stay under Subclass 408 for sport?', 'Roughly 3 months to 4 years, depending on the specific activity and stream your sponsoring organisation applies under.', 181, 9, 856, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Added to principal application / Subsequent Entrant
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    181, 10, 'AUS-DEP-IN-10', '2026.09', 'published',
    'Joining a spouse/partner or parent who holds a Subclass 482 (Skills in Demand) or Subclass 500 (Student) visa in Australia.',
    'Australia has no standalone "Dependent Visa" product — spouse/de facto partners and dependent children are either included at initial lodgement alongside the principal applicant, or added later via a Subsequent Entrant application once the principal is already in Australia.',
    'Matches the validity of the principal visa holder''s visa',
    'Online application via ImmiAccount, either combined with the principal application or as a Subsequent Entrant application',
    0,
    'Subsequent Entrant processing depends on the principal holder''s visa and individual circumstances',
    'Department of Home Affairs — online via ImmiAccount',
    'Confirm the principal visa holder''s visa subclass and status\nGather documents against this checklist, including relationship proof\nSubmit either as a combined application or a Subsequent Entrant application\nSupport responding to any request for additional information\nDecision once processed',
    '/assets/images/visa-heroes/australia.jpg',
    'Australian Department of Home Affairs Skills in Demand visa Subsequent Entrant guidance', 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/skills-in-demand-visa-subclass-482/subsequent-entrant', '2026-09-11'
);
SET @at10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at10, 'Core Documents', 'Every applicant needs these.', 1);
SET @at10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at10s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at10, 'Principal Holder & Relationship Documents', 'Evidence of the principal visa holder you are joining.', 2);
SET @at10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at10s2, 'Principal Holder''s Visa Grant Notice', NULL, 'copy', 1, 0, 1, 1),
(@at10s2, 'Marriage/De Facto Relationship Proof', 'For a spouse/partner applicant.', 'copy', 0, 1, 1, 2),
(@at10s2, 'Birth Certificate', 'For a dependent child applicant.', 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at10, 'Financial Documents', 'Evidence the principal can support you.', 3);
SET @at10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at10s3, 'Principal Holder''s Income/Employment Evidence', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(181, 10, NULL, 'AUD', 'Confirmed After Assessment', 'Fee depends on the principal holder''s visa subclass and whether you apply as a combined applicant or Subsequent Entrant — reported figures vary across sources, so we confirm the exact current fee before you apply.', '2026-09-01', NOW(), 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/skills-in-demand-visa-subclass-482/subsequent-entrant', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Dependent Visa for Australia?', 'No — Australia has no standalone dependent-visa product. Family members are either included in the principal applicant''s own visa application or added later as a Subsequent Entrant.', 181, 10, 857, 1),
('Can I join my spouse after they are already in Australia?', 'Yes — this is the Subsequent Entrant pathway, applied for once the principal visa holder is already in Australia, rather than being included at initial lodgement.', 181, 10, 858, 1),
('What relationship evidence is needed?', 'Marriage or de facto relationship proof for a spouse/partner, or a birth certificate for a dependent child, alongside the principal holder''s visa grant notice.', 181, 10, 859, 1);
