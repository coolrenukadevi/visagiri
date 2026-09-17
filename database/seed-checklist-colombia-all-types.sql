-- Colombia Visa Checklist Engine content for all 10 visa types — built this
-- session via web search (WebSearch). Direct WebFetch access to primary
-- sources (cancilleria.gov.co, eoibogota.gov.in, btwvisas.com, visago.dev,
-- Wikipedia, and others) was BLOCKED by network egress policy for this
-- session — every fetch attempt returned EGRESS_BLOCKED. All content below
-- is therefore triangulated from WebSearch result snippets only (Skyscanner,
-- BTW Visas, Acko, Tata AIG, Playroll, Medellin Lawyer/Guru, Colombian Visa
-- Services, VisaHQ, Nivabupa, and similar secondary/visa-agency sourcing),
-- never a direct primary-source fetch. The WebSearch quota for this session
-- was exhausted (200/200 calls used) partway through research, before
-- Family Visit, Transit, Medical, Conference, Sports, and Dependent could
-- be searched with Colombia-specific, Indian-citizen-specific queries.
--
-- SOURCING STATUS PER CATEGORY:
--   Tourist, Business, Student, Work — reasonably well sourced this session
--     (multiple corroborating WebSearch snippets each).
--   Family Visit, Dependent — structure built from Colombia's general
--     Migrant (M) "beneficiary" visa mechanism (a spouse/child/dependent of
--     an M- or R-visa principal holder), which is well-established Colombian
--     visa architecture, but NOT independently confirmed this session with
--     Indian-citizen-specific figures — flagged accordingly below.
--   Transit, Medical, Conference, Sports — NOT independently confirmed this
--     session. Colombia's Visitor (V) visa system is known to include
--     purpose-specific subcategories along these lines, but exact codes,
--     fees, and processing times for these four could not be verified via
--     WebSearch before the quota was exhausted. Built to the same
--     structural pattern as the confirmed categories, with fee rows left as
--     NULL/"Confirmed After Assessment" and explicit caveats in each
--     checklist's `source` field. Treat these four as provisional pending a
--     follow-up research pass with direct access to cancilleria.gov.co.
--
-- Colombia's real, distinctive facts verified this session:
--   - Indian nationals holding a valid US visa (any category except C-1
--     transit) or a valid Schengen visa, with a minimum of 180 days'
--     remaining validity at the time of entry, may enter Colombia
--     VISA-FREE for up to 90 days — a genuine third-country-visa waiver.
--     All other Indian passport holders must obtain a Colombian visa in
--     advance; there is no visa-on-arrival for Indian citizens.
--   - Colombia's visa system uses three letter-prefixed classes: V
--     (Visitante/short-stay visitor visas), M (Migrante/long-stay visas
--     tied to an ongoing purpose such as work or study), and R (Residente).
--   - Many Migrant (M) visa subcategories peg their financial thresholds to
--     multiples of the SMMLV (Salario Mínimo Mensual Legal Vigente,
--     Colombia's statutory monthly minimum wage), which is revised each
--     year — reported as having risen again for 2026, so any SMMLV-linked
--     multiple should be reconfirmed at application time rather than
--     treated as a fixed USD/COP figure.
--   - Check-Mig, Migración Colombia's pre-arrival online travel
--     declaration, is reported as no longer strictly mandatory since
--     January 2025, though completing it is still strongly recommended.
--   - The M-5 Work Visa requires Colombian-employer sponsorship, and the
--     employer must register the foreign worker on TWO separate government
--     platforms — RUTEC (Ministry of Labour) and SIRE (Migración
--     Colombia) — a two-system registration step that is easy to miss.
--   - Any Colombian visa issued for longer than 3 months requires the
--     holder to register in person for a Cédula de Extranjería (foreigner
--     ID card) with Migración Colombia within 15 calendar days of entry.
--   - The Embassy of India, Bogotá explicitly advises that ALL Indian
--     travellers to Colombia must carry a valid International Yellow Fever
--     Vaccination Certificate regardless of age (exempting only children
--     under 6 months) — a health-entry requirement distinct from the visa
--     itself, included here as a general applicant note.
--
-- country_id 201 = Colombia. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Visitor (V) Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    201, 1, 'COL-TOUR-IN-01', '2026.09', 'published',
    'Leisure, sightseeing, and tourism travel to Colombia.',
    'Indian passport holders generally need a Visitor (V) tourist visa in advance — there is no visa-on-arrival for Indians. Exception: Indians holding a valid US visa (any category except C-1 transit) or valid Schengen visa with 180+ days remaining validity may enter visa-free for up to 90 days.',
    'Up to 90 days, reportedly extendable to a combined 180 days within Colombia per year',
    'Apply online via the Cancillería e-visa portal, or through the Embassy of Colombia, New Delhi',
    0,
    'Reported range of about 5-15 business days for a complete application; some sources cite up to 30 days is possible',
    'Embassy of Colombia, New Delhi (visa authority for applicants who do not use the online e-visa portal)',
    'Check whether you qualify for the US/Schengen-visa-holder visa-free entry (180+ days remaining validity)\nIf not exempt, apply online via the Cancillería e-visa portal or through the Embassy of Colombia, New Delhi\nUpload passport, photo, and supporting documents\nPay the visa fee\nTrack application status and receive the e-visa by email\nCarry a valid International Yellow Fever Vaccination Certificate when travelling',
    '/assets/images/visa-heroes/colombia.webp',
    'Triangulated from WebSearch snippets (BTW Visas, Skyscanner, Acko, Embassy of India Bogotá reporting); direct fetch of cancilleria.gov.co and eoibogota.gov.in was blocked this session', 'https://www.cancilleria.gov.co/en/tourist-visa', '2026-09-17'
);
SET @col1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@col1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col1, 'Core Documents', 'Required from every applicant.', 1);
SET @col1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col1s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@col1s1, 'Completed Online Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@col1s1, 'Recent Passport-Size Photograph (3x3cm, White Background)', NULL, 'original', 1, 0, 1, 3),
(@col1s1, 'International Yellow Fever Vaccination Certificate', 'Required for all Indian travellers regardless of age, except children under 6 months.', 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @col1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@col1s2, 'Confirmed Hotel Booking or Accommodation Proof', NULL, 'copy', 1, 0, 0, 2),
(@col1s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@col1s2, 'Travel Medical Insurance', NULL, 'original', 1, 0, 0, 4),
(@col1s2, 'Proof of Valid US or Schengen Visa (180+ Days Validity)', 'Only if claiming visa-free entry instead of applying for a Colombian visa.', 'copy', 0, 1, 0, 5);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(201, 1, 50.00, 'USD', 'Tourist (V) Visa Fee (Approximate)', 'Reported figures range from roughly USD 45 to USD 82 depending on source and processing option; treat as approximate and confirm on the Cancillería portal before applying. Not applicable to travellers using visa-free entry via a US/Schengen visa.', '2026-09-01', NOW(), 'https://www.cancilleria.gov.co/en/tourist-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do all Indian citizens need a visa to visit Colombia?', 'Not necessarily. Indians holding a valid US visa (any category except C-1 transit) or a valid Schengen visa with at least 180 days remaining validity can enter Colombia visa-free for up to 90 days. All other Indian passport holders must obtain a Colombian visa in advance — there is no visa-on-arrival.', 201, 1, 20100, 1),
('Is the Yellow Fever certificate required even for a short tourist trip?', 'Yes — the Embassy of India, Bogotá states that all Indian travellers to Colombia must carry a valid International Yellow Fever Vaccination Certificate regardless of age, with the only exception being children under 6 months old.', 201, 1, 20101, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Visitor (V) Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    201, 2, 'COL-BUS-IN-02', '2026.09', 'published',
    'Short-term commercial activity in Colombia: meetings, negotiations, and trade shows.',
    'Indian nationals travelling for business purposes — a Visitor (V) business visa distinct from Tourist, requiring an invitation/support letter from the Colombian host company plus proof of the applicant''s own employment or business standing in India.',
    'Up to 90 days per entry, subject to approval and the documents submitted',
    'Apply online via the Cancillería e-visa portal, or through the Embassy of Colombia, New Delhi',
    0,
    'Reported range of about 10-15 business days for a complete application; clean applications are sometimes decided within 5-10 business days',
    'Embassy of Colombia, New Delhi',
    'Obtain an invitation/support letter from the Colombian host company\nGather proof of your own employment or business ownership in India\nApply online via the Cancillería e-visa portal or through the Embassy of Colombia, New Delhi\nUpload documents and pay the visa fee\nTrack application status and receive the e-visa by email',
    '/assets/images/visa-heroes/colombia.webp',
    'Triangulated from WebSearch snippets (BTW Visas, MakeMyTrip Visa, general Visitor-visa reporting); direct fetch of cancilleria.gov.co was blocked this session, so the exact business-visa subcode and fee are not independently confirmed', 'https://www.cancilleria.gov.co/en/tt_ss/1-classes-or-categories-visas-colombia', '2026-09-17'
);
SET @col2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@col2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col2, 'Core Documents', 'Required from every applicant.', 1);
SET @col2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@col2s1, 'Invitation/Support Letter from Colombian Host Company', NULL, 'original', 1, 0, 1, 2),
(@col2s1, 'Completed Online Visa Application Form', NULL, 'copy', 1, 0, 1, 3),
(@col2s1, 'International Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col2, 'Supporting Documents', 'Evidence of your own employment and financial standing.', 2);
SET @col2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col2s2, 'Forwarding/Sponsorship Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@col2s2, 'Business Registration Proof', 'For applicants travelling on their own behalf rather than as an employee.', 'copy', 0, 1, 0, 2),
(@col2s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@col2s2, 'Return Flight Ticket', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(201, 2, NULL, 'USD', 'Confirmed After Assessment', 'Reported in the same broad range as the Tourist visa (roughly USD 45-82), but the exact business-visa fee was not independently confirmed this session — confirm on the Cancillería portal or with the Embassy of Colombia, New Delhi before applying.', '2026-09-01', NOW(), 'https://www.cancilleria.gov.co/en/tt_ss/1-classes-or-categories-visas-colombia', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use a Business visa for paid work in Colombia?', 'No — the Business (Visitor) visa covers short-term commercial activity such as meetings and negotiations, not paid employment with a Colombian entity. Paid work requires an employer-sponsored Migrant (M) Work visa instead.', 201, 2, 20110, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Temporary Student Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    201, 3, 'COL-STU-IN-03', '2026.09', 'published',
    'Enrolling in a recognized Colombian university, school, or non-degree study program.',
    'Indian nationals admitted to a Colombian-government-recognized institution, taking at least 10 hours of classes per week. Since Resolution 5477, higher-education and non-degree study generally falls under the Visitor (V) category, while elementary/middle/undergraduate study can also fall under a Migrant (M) study subcategory — sources are not fully consistent on the exact code, so confirm your specific case with the institution or embassy.',
    'Up to 2 years, depending on the duration of the study program',
    'Apply online via the Cancillería e-visa portal, or through the Embassy of Colombia, New Delhi',
    0,
    'Not independently confirmed this session; general Visitor/Migrant visa processing is reported in the 10-15 business day range, but student-specific timelines were not separately verified',
    'Embassy of Colombia, New Delhi',
    'Secure admission at a Colombian-government-recognized institution (minimum 10 hours of classes/week)\nObtain the institution''s enrollment/admission certificate and certificate of existence\nGather proof of funds and mandatory health insurance\nApply online via the Cancillería e-visa portal or through the Embassy of Colombia, New Delhi\nAfter arrival, register for a Cédula de Extranjería with Migración Colombia within 15 days if the visa exceeds 3 months',
    '/assets/images/visa-heroes/colombia.webp',
    'Triangulated from WebSearch snippets (Medellin Lawyer, Medellin Guru, Colombian Visa Services); cancilleria.gov.co fetch blocked, exact subcode/fee figures conflicting', 'https://www.cancilleria.gov.co/en/temporary-students-visa-0', '2026-09-17'
);
SET @col3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@col3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col3, 'Core Documents', 'Required from every applicant.', 1);
SET @col3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@col3s1, 'Admission/Enrollment Certificate from Colombian Institution', 'Must specify the study program and weekly class hours (minimum 10 hours/week).', 'original', 1, 0, 1, 2),
(@col3s1, 'Certificate of Existence and Legal Representation of the Institution', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @col3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@col3s2, 'ICFES or Equivalent State Test Results', 'For bachelor''s-level admission, if applicable.', 'copy', 0, 1, 0, 2),
(@col3s2, 'Proof of Funds for Living and Study Expenses', NULL, 'copy', 1, 0, 0, 3),
(@col3s2, 'Health Insurance Valid in Colombia', NULL, 'original', 1, 0, 0, 4),
(@col3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 5);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(201, 3, NULL, 'USD', 'Confirmed After Assessment', 'One secondary source reports a figure around USD 67 for a student-visa subcategory, but exact fee and visa-code labelling were inconsistent across sources this session — confirm the current fee on the Cancillería portal.', '2026-09-01', NOW(), 'https://www.cancilleria.gov.co/en/temporary-students-visa-0', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work while studying in Colombia on a Student visa?', 'This was not independently confirmed this session. Colombian Student visa rules on part-time work vary by institution and visa subcategory — confirm directly with Migración Colombia or your institution before assuming any work rights.', 201, 3, 20120, 1),
('Do I need to register with Migración Colombia after arriving to study?', 'Yes — any Colombian visa valid for more than 3 months, including most Student visas, requires the holder to register in person for a Cédula de Extranjería with Migración Colombia within 15 calendar days of entering Colombia.', 201, 3, 20121, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Migrant (M-5) Work Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    201, 4, 'COL-WORK-IN-04', '2026.09', 'published',
    'Employment with a Colombian employer under the Migrant (M-5) Work Visa.',
    'Indian nationals with a confirmed job offer from a Colombian company. The employer must sponsor the application and justify hiring a foreign national over a Colombian citizen, then register the worker with BOTH the Ministry of Labour''s RUTEC system and Migración Colombia''s SIRE system.',
    'Tied to the employment contract duration; commonly issued for up to the contract term, renewable',
    'Employer-sponsored; applicant applies online via the Cancillería e-visa portal, or through the Embassy of Colombia, New Delhi',
    0,
    'Not independently confirmed this session for India-specific timelines; general Migrant-visa processing commonly reported in the 10-15+ business day range',
    'Embassy of Colombia, New Delhi',
    'Secure a job offer from a Colombian employer willing to sponsor the M-5 visa\nEmployer justifies the need to hire a foreign national and prepares the sponsorship documents\nApply online via the Cancillería e-visa portal or through the Embassy of Colombia, New Delhi\nAfter approval and arrival, employer registers the worker on RUTEC (Ministry of Labour) and SIRE (Migración Colombia)\nRegister for a Cédula de Extranjería with Migración Colombia within 15 days of entry',
    '/assets/images/visa-heroes/colombia.webp',
    'Triangulated from WebSearch snippets (Playroll, Deel, Rippling, Globalization Partners, Rio Times, ABIL Colombia employer-of-record and immigration-law reporting); direct fetch of cancilleria.gov.co was blocked this session', 'https://www.cancilleria.gov.co/en/tt_ss/1-classes-or-categories-visas-colombia', '2026-09-17'
);
SET @col4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@col4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col4, 'Core Documents', 'Required from every applicant.', 1);
SET @col4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@col4s1, 'Employment Contract with Colombian Employer', NULL, 'copy', 1, 0, 1, 2),
(@col4s1, 'Employer Sponsorship/Justification Letter', 'Explains why a foreign national is being hired for the role.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @col4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@col4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@col4s2, 'Proof of Employer''s Legal Registration in Colombia', NULL, 'copy', 1, 0, 0, 3),
(@col4s2, 'Health Insurance Valid in Colombia', NULL, 'original', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(201, 4, NULL, 'USD', 'Confirmed After Assessment', 'Work-visa fees were not independently confirmed this session; several Migrant (M) visa subcategories peg costs/thresholds to multiples of Colombia''s SMMLV (statutory minimum wage), which is revised annually — confirm the current figure with the Embassy of Colombia before applying.', '2026-09-01', NOW(), 'https://www.cancilleria.gov.co/en/tt_ss/1-classes-or-categories-visas-colombia', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does my employer need to do anything after I arrive in Colombia?', 'Yes — the sponsoring employer must register the worker on two separate government platforms: RUTEC (the Ministry of Labour''s foreign-worker registry) and SIRE (Migración Colombia''s foreign-national reporting system). Missing either can cause fines or complications with future visa applications.', 201, 4, 20130, 1),
('Do I need a foreigner ID card once I start working?', 'Yes — any Colombian visa valid for more than 3 months, including the M-5 Work Visa, requires registering in person for a Cédula de Extranjería with Migración Colombia within 15 calendar days of entering Colombia.', 201, 4, 20131, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Visitor (V) Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    201, 5, 'COL-FAM-IN-05', '2026.09', 'published',
    'Visiting family or friends resident in Colombia.',
    'Indian nationals with family or friends in Colombia — NOT independently confirmed this session with India-specific figures. Built on the general expectation that this falls under the same Visitor (V) visa track as Tourist, differentiated by an invitation letter and proof of relationship.',
    'Up to 90 days per entry, in line with general Visitor (V) visa practice',
    'Apply online via the Cancillería e-visa portal, or through the Embassy of Colombia, New Delhi',
    0,
    'Not independently confirmed this session; general Visitor-visa processing commonly reported in the 5-15 business day range',
    'Embassy of Colombia, New Delhi',
    'Obtain an invitation letter from your host resident in Colombia\nGather documents proving the family or personal relationship\nApply online via the Cancillería e-visa portal or through the Embassy of Colombia, New Delhi\nUpload documents and pay the applicable fee\nTrack application status and receive the e-visa by email',
    '/assets/images/visa-heroes/colombia.webp',
    'NOT independently confirmed this session — built from general Colombian Visitor (V) visa architecture rather than an India-specific Family Visit source; the WebSearch quota was exhausted before a dedicated query could be run', 'https://www.cancilleria.gov.co/en/tt_ss/1-classes-or-categories-visas-colombia', '2026-09-17'
);
SET @col5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@col5, '2026.09', 'Initial published checklist; category flagged for follow-up sourcing.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col5, 'Core Documents', 'Required from every applicant.', 1);
SET @col5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@col5s1, 'Invitation Letter from Host in Colombia', NULL, 'original', 1, 0, 1, 2),
(@col5s1, 'Proof of Relationship to Host', NULL, 'copy', 1, 0, 1, 3),
(@col5s1, 'International Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col5, 'Supporting Documents', 'Evidence of your own means and travel plans.', 2);
SET @col5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col5s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@col5s2, 'Return Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@col5s2, 'Host''s Colombian ID/Visa/Residency Proof', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(201, 5, NULL, 'USD', 'Confirmed After Assessment', 'NOT independently confirmed this session. Likely similar to the Tourist visa fee range (roughly USD 45-82) given the shared Visitor (V) category, but this has not been verified against a Family-Visit-specific source — confirm with the Embassy of Colombia, New Delhi.', '2026-09-01', NOW(), 'https://www.cancilleria.gov.co/en/tt_ss/1-classes-or-categories-visas-colombia', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Family Visit visa different from a Tourist visa in Colombia?', 'This was not independently confirmed this session. Both are expected to fall under Colombia''s general Visitor (V) visa class, with the Family Visit route additionally requiring an invitation letter and proof of relationship from your Colombia-based host — confirm the current requirement with the Embassy of Colombia, New Delhi.', 201, 5, 20140, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Visitor (V) Transit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    201, 6, 'COL-TRAN-IN-06', '2026.09', 'published',
    'Passing through Colombia en route to a third country.',
    'NOT independently confirmed this session. Indian nationals connecting through a Colombian airport may need a transit-purpose Visitor (V) visa depending on layover length and whether they leave the international transit area; confirm requirements directly with the Embassy of Colombia before booking a connection through Colombia.',
    'Limited to the transit window; not independently confirmed this session',
    'Apply online via the Cancillería e-visa portal, or through the Embassy of Colombia, New Delhi, if a transit visa is genuinely required',
    0,
    'Not independently confirmed this session',
    'Embassy of Colombia, New Delhi',
    'Confirm with your airline and the Embassy of Colombia whether your specific connection requires a transit visa\nIf required, apply online via the Cancillería e-visa portal or through the Embassy of Colombia, New Delhi\nGather your onward ticket and itinerary\nSubmit documents and pay the applicable fee',
    '/assets/images/visa-heroes/colombia.webp',
    'NOT independently confirmed this session — the WebSearch quota was exhausted before a dedicated Transit-visa query for Indian citizens could be run; content is structural only, built on the general Colombian Visitor (V) visa pattern', 'https://www.cancilleria.gov.co/en/tt_ss/1-classes-or-categories-visas-colombia', '2026-09-17'
);
SET @col6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@col6, '2026.09', 'Initial published checklist; category flagged for follow-up sourcing.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col6, 'Core Documents', 'Required if a transit visa is genuinely needed.', 1);
SET @col6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@col6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @col6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1),
(@col6s2, 'International Yellow Fever Vaccination Certificate', 'Confirm applicability for transit-only travel.', 'original', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(201, 6, NULL, 'USD', 'Confirmed After Assessment', 'NOT independently confirmed this session — contact the Embassy of Colombia, New Delhi for current transit-visa fee and eligibility.', '2026-09-01', NOW(), 'https://www.cancilleria.gov.co/en/tt_ss/1-classes-or-categories-visas-colombia', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do all Indian travellers connecting through Colombia need a transit visa?', 'This was not independently confirmed this session. Requirements typically depend on whether you remain in the international transit area versus passing through immigration — confirm your specific itinerary with your airline and the Embassy of Colombia, New Delhi before travelling.', 201, 6, 20150, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Visitor (V) Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    201, 7, 'COL-MED-IN-07', '2026.09', 'published',
    'Travel to Colombia for medical treatment.',
    'NOT independently confirmed this session with India-specific figures. Built on the expectation that medical treatment falls under a purpose-specific Visitor (V) visa, requiring a certificate from the treating Colombian doctor/institution confirming the need for specific treatment.',
    'Tied to the treatment duration; not independently confirmed this session',
    'Apply online via the Cancillería e-visa portal, or through the Embassy of Colombia, New Delhi',
    0,
    'Not independently confirmed this session',
    'Embassy of Colombia, New Delhi',
    'Obtain a certificate from the treating Colombian doctor/institution confirming the need for treatment\nArrange travel/medical insurance covering the treatment period\nApply online via the Cancillería e-visa portal or through the Embassy of Colombia, New Delhi\nSubmit documents and pay the applicable fee',
    '/assets/images/visa-heroes/colombia.webp',
    'NOT independently confirmed this session — the WebSearch quota was exhausted before a dedicated Medical-visa query for Indian citizens could be run; content is structural only, built on the general Colombian Visitor (V) visa pattern', 'https://www.cancilleria.gov.co/en/tt_ss/1-classes-or-categories-visas-colombia', '2026-09-17'
);
SET @col7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@col7, '2026.09', 'Initial published checklist; category flagged for follow-up sourcing.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col7, 'Core Documents', 'Required from every applicant.', 1);
SET @col7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@col7s1, 'Medical Certificate/Treatment Confirmation from Colombian Institution', NULL, 'original', 1, 0, 1, 2),
(@col7s1, 'Travel/Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @col7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col7s2, 'Medical Records/Referral from Home Doctor', NULL, 'copy', 1, 0, 0, 1),
(@col7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(201, 7, NULL, 'USD', 'Confirmed After Assessment', 'NOT independently confirmed this session — contact the Embassy of Colombia, New Delhi for current medical-visa fee and eligibility.', '2026-09-01', NOW(), 'https://www.cancilleria.gov.co/en/tt_ss/1-classes-or-categories-visas-colombia', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What documentation does a Colombian hospital need to provide for a Medical visa?', 'This was not independently confirmed this session. Generally expect a certificate confirming the diagnosis, the treatment planned, and its expected duration — confirm the exact format required with the Embassy of Colombia, New Delhi.', 201, 7, 20160, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Visitor (V) Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    201, 8, 'COL-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade fairs in Colombia.',
    'NOT independently confirmed this session with India-specific figures. Built on the expectation that conference attendance falls under the same Visitor (V) visa track as Business, differentiated by a conference invitation/registration document.',
    'Up to 90 days per entry, in line with general Visitor (V) visa practice',
    'Apply online via the Cancillería e-visa portal, or through the Embassy of Colombia, New Delhi',
    0,
    'Not independently confirmed this session',
    'Embassy of Colombia, New Delhi',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nApply online via the Cancillería e-visa portal or through the Embassy of Colombia, New Delhi\nSubmit documents and pay the applicable fee',
    '/assets/images/visa-heroes/colombia.webp',
    'NOT independently confirmed this session — the WebSearch quota was exhausted before a dedicated Conference-visa query for Indian citizens could be run; content is structural only, built on the general Colombian Visitor (V) visa pattern', 'https://www.cancilleria.gov.co/en/tt_ss/1-classes-or-categories-visas-colombia', '2026-09-17'
);
SET @col8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@col8, '2026.09', 'Initial published checklist; category flagged for follow-up sourcing.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col8, 'Core Documents', 'Required from every applicant.', 1);
SET @col8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@col8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col8, 'Supporting Documents', 'Additional employer-side and financial evidence.', 2);
SET @col8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@col8s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 2),
(@col8s2, 'Return Flight Ticket', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(201, 8, NULL, 'USD', 'Confirmed After Assessment', 'NOT independently confirmed this session — contact the Embassy of Colombia, New Delhi for current conference-visa fee and eligibility.', '2026-09-01', NOW(), 'https://www.cancilleria.gov.co/en/tt_ss/1-classes-or-categories-visas-colombia', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Conference visa the same category as the Business visa?', 'This was not independently confirmed this session. Both are expected to sit under Colombia''s general Visitor (V) visa class with overlapping documentation, but treat them as distinct purposes until confirmed with the Embassy of Colombia, New Delhi.', 201, 8, 20170, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Visitor (V) Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    201, 9, 'COL-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Colombia.',
    'NOT independently confirmed this session with India-specific figures. Built on the expectation that sports-event participation falls under the same Visitor (V) visa track as Conference, requiring a letter from the home-country sports association and an invitation from the host event organizer.',
    'Up to 90 days per entry, in line with general Visitor (V) visa practice',
    'Apply online via the Cancillería e-visa portal, or through the Embassy of Colombia, New Delhi',
    0,
    'Not independently confirmed this session',
    'Embassy of Colombia, New Delhi',
    'Obtain a letter from your home-country sports association confirming your role\nObtain an invitation letter from the host event organizer with event details\nApply online via the Cancillería e-visa portal or through the Embassy of Colombia, New Delhi\nSubmit documents and pay the applicable fee',
    '/assets/images/visa-heroes/colombia.webp',
    'NOT independently confirmed this session — the WebSearch quota was exhausted before a dedicated Sports-visa query for Indian citizens could be run; content is structural only, built on the general Colombian Visitor (V) visa pattern', 'https://www.cancilleria.gov.co/en/tt_ss/1-classes-or-categories-visas-colombia', '2026-09-17'
);
SET @col9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@col9, '2026.09', 'Initial published checklist; category flagged for follow-up sourcing.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col9, 'Core Documents', 'Required from every applicant.', 1);
SET @col9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@col9s1, 'Home-Country Sports Association Letter', 'Confirms role and no-employment status.', 'original', 1, 0, 1, 2),
(@col9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @col9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1),
(@col9s2, 'Return Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(201, 9, NULL, 'USD', 'Confirmed After Assessment', 'NOT independently confirmed this session — contact the Embassy of Colombia, New Delhi for current sports-visa fee and eligibility.', '2026-09-01', NOW(), 'https://www.cancilleria.gov.co/en/tt_ss/1-classes-or-categories-visas-colombia', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the Sports visa require documentation beyond a normal invitation letter?', 'This was not independently confirmed this session for Colombia specifically. As a general practice in comparable visa systems, expect to need both a letter from your home-country sports association and a separate invitation from the host event organizer — confirm the current Colombian requirement with the Embassy of Colombia, New Delhi.', 201, 9, 20180, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Migrant (M) Beneficiary Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    201, 10, 'COL-DEP-IN-10', '2026.09', 'published',
    'Spouse, minor children, or dependent family members joining an Indian national who holds a Colombian Migrant (M) visa, such as the M-5 Work Visa.',
    'Family members of an Indian national holding a qualifying Migrant (M) visa. Colombia''s general visa architecture allows dependants of an M-visa principal to apply as "beneficiaries" of that visa, but India-specific figures were NOT independently confirmed this session.',
    'Tied to the principal (sponsor) visa holder''s visa validity',
    'Apply online via the Cancillería e-visa portal, or through the Embassy of Colombia, New Delhi, as beneficiary of the principal''s visa',
    0,
    'Not independently confirmed this session',
    'Embassy of Colombia, New Delhi',
    'Confirm the sponsor holds a qualifying Migrant (M) visa (e.g. Work, Study)\nGather relationship proof (marriage/birth certificates) and the sponsor''s visa copy\nApply online via the Cancillería e-visa portal or through the Embassy of Colombia, New Delhi, as a beneficiary\nSubmit documents and pay the applicable fee\nAfter arrival, register for a Cédula de Extranjería with Migración Colombia within 15 days if the visa exceeds 3 months',
    '/assets/images/visa-heroes/colombia.webp',
    'Triangulated from general WebSearch snippets on Colombia''s Migrant (M) visa "beneficiary" mechanism; India-specific figures NOT independently confirmed this session (quota exhausted)', 'https://www.cancilleria.gov.co/en/tt_ss/1-classes-or-categories-visas-colombia', '2026-09-17'
);
SET @col10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@col10, '2026.09', 'Initial published checklist; category flagged for follow-up sourcing.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col10, 'Core Documents', 'Required from every applicant.', 1);
SET @col10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@col10s1, 'Proof of Relationship to Sponsor', 'Marriage certificate, birth certificate, or equivalent.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@col10, 'Supporting Documents', 'Evidence tied to the sponsor''s visa.', 2);
SET @col10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@col10s2, 'Sponsor''s Migrant (M) Visa Copy', NULL, 'copy', 1, 0, 0, 1),
(@col10s2, 'Sponsor''s Cédula de Extranjería (If Already Registered)', NULL, 'copy', 0, 1, 0, 2),
(@col10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(201, 10, NULL, 'USD', 'Confirmed After Assessment', 'NOT independently confirmed this session — contact the Embassy of Colombia, New Delhi for the current beneficiary/dependant visa fee.', '2026-09-01', NOW(), 'https://www.cancilleria.gov.co/en/tt_ss/1-classes-or-categories-visas-colombia', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can any Colombian visa holder sponsor a dependant?', 'This was not independently confirmed this session for every visa category. Generally, Migrant (M) visa holders — such as M-5 Work Visa holders — can sponsor a spouse, minor children, or other qualifying dependants as "beneficiaries" of their visa; confirm eligibility for your specific sponsor visa with the Embassy of Colombia, New Delhi.', 201, 10, 20190, 1);
