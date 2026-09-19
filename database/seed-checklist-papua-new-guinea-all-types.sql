-- Papua New Guinea Visa Checklist Engine content for all 10 visa types.
--
-- Papua New Guinea's real, distinctive facts verified this session:
--   - No Visa on Arrival for Indian passport holders — all sources
--     reviewed agree an advance visa/eVisa is mandatory.
--   - SOURCING CONFLICT (flagged, not silently resolved): the standard
--     Tourist/Visitor eVisa fee and maximum stay differ across
--     aggregator sources. One set reports ~INR 9,449 (~USD 100) for a
--     max. 30-day stay, ~5 working-day processing. Another set reports
--     USD 50 for up to 60 days, 6-month validity, single entry.
--     Applicants should confirm current terms on the official PNG
--     eVisa portal before paying.
--   - Work Visa is a distinct route (standard eVisa does not permit
--     employment) applied for at the nearest PNG Embassy/Consulate;
--     aggregator-quoted fees range ~INR 9,500-13,000 depending on
--     entry type — not independently confirmed against a first-party
--     PNG government fee schedule this session. Extension fee reported
--     at ~Rs. 10,300 per entry, also not independently confirmed.
--   - High Commission of India, Port Moresby (hcipom.gov.in) is the
--     relevant Indian mission for bilateral consular queries; the visa
--     itself is issued by PNG authorities.
--   - Several categories (Student, Transit, Medical, Sports, Dependent)
--     had no dedicated first-party PNG document checklist located this
--     session — explicitly flagged as sourcing gaps rather than
--     inventing plausible-sounding requirements.
--
-- country_id 191 = Papua New Guinea. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    191, 1, 'PNG-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Papua New Guinea for Indian citizens.',
    'Indian passport holders must obtain a visa in advance; Visa on Arrival is NOT available. SOURCING CONFLICT: fee/stay figures differ across sources reviewed — one set reports ~INR 9,449 (~USD 100) for max. 30-day stay, ~5 working-day processing; another reports USD 50 for up to 60 days, 6-month validity, single entry.',
    'Up to 30 or 60 days depending on eVisa category selected (see sourcing-conflict note); single entry',
    'Apply online via the official PNG eVisa Portal at least 5 working days before travel',
    0,
    'Confirm the current fee and permitted stay directly on the official eVisa portal before paying, given the sourcing conflict noted above.',
    'High Commission of India, Port Moresby (hcipom.gov.in) — for bilateral consular queries; the visa itself is issued by PNG authorities via the eVisa portal',
    'Confirm current eVisa fee/stay terms on the official portal\nGather passport, photo, and supporting documents\nSubmit the online eVisa application\nMake payment via credit/debit card\nAwait eVisa approval by email (approx. 5 working days)\nCarry a printed copy of the eVisa for arrival',
    '/assets/images/visa-heroes/papua-new-guinea.webp',
    'PNG eVisa portal guidance as summarized by visa-assistance aggregators; High Commission of India, Port Moresby', 'https://hcipom.gov.in/', '2026-09-19'
);
SET @png1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@png1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@png1, 'Core Documents', 'Required from every applicant.', 1);
SET @png1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@png1s1, 'Valid Passport (6+ Months Validity, 1+ Blank Page)', NULL, 'original', 1, 0, 1, 1),
(@png1s1, 'Passport-Size Photograph', 'Meeting eVisa portal specifications.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@png1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @png1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@png1s2, 'Confirmed Return/Onward Flight Booking', NULL, 'copy', 1, 0, 0, 1),
(@png1s2, 'Hotel/Accommodation Booking Confirmation', NULL, 'copy', 1, 0, 0, 2),
(@png1s2, 'Bank Statement or Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 3),
(@png1s2, 'Valid Credit/Debit Card', 'For online eVisa fee payment.', 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(191, 1, 100.00, 'USD', 'eVisa Fee (Route A) - Sourcing Conflict', '~INR 9,449 (~USD 100) for max. 30-day stay per some sources; a separate source cites USD 50 for up to 60 days. Confirm on the official portal.', '2026-01-01', NOW(), NULL, 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Visa on Arrival available for Indian citizens in PNG?', 'No. All sources reviewed confirm VOA is not available for Indian passport holders; the eVisa must be obtained in advance.', 191, 1, 19100, 1),
('Why do sources disagree on the tourist eVisa fee and stay duration?', 'Aggregator sources cite different eVisa sub-categories or dates. This has not been independently reconciled this session — verify current terms on the official PNG eVisa portal before applying.', 191, 1, 19101, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    191, 2, 'PNG-BUS-IN-01', '2026.09', 'published',
    'Short-term business visits (meetings, negotiations, conferences) to Papua New Guinea.',
    'Business travellers apply via the same eVisa portal, selecting the business/visitor category, or via the nearest PNG Embassy/Consulate for complex engagements. VOA is not available.',
    'Typically up to 30-60 days depending on eVisa category (see Tourist Visa sourcing-conflict note); single entry',
    'Apply online via the PNG eVisa Portal (business/visitor category), or at the nearest PNG Embassy/Consulate',
    0,
    'An invitation letter from the PNG host company/organization strengthens the application; exact mandatory-document lists were not independently itemized by a first-party source this session.',
    'Nearest PNG Embassy/Consulate for cases requiring in-person processing',
    'Confirm the correct eVisa category for business travel\nGather passport, photo, and business documentation\nSubmit the online eVisa application or embassy application\nAwait approval\nCarry all documents for arrival immigration',
    '/assets/images/visa-heroes/papua-new-guinea.webp',
    'PNG eVisa portal guidance as summarized by visa-assistance aggregators', NULL, '2026-09-19'
);
SET @png2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@png2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@png2, 'Core Documents', 'Required from every applicant.', 1);
SET @png2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@png2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@png2s1, 'Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@png2s1, 'Proof of Employment/Business Ownership in India', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@png2, 'Supporting Documents', 'Evidence of your business travel plans.', 2);
SET @png2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@png2s2, 'Invitation Letter from PNG Host Company/Organization', NULL, 'copy', 0, 1, 0, 1),
(@png2s2, 'Return Flight Booking and Accommodation Confirmation', NULL, 'copy', 1, 0, 0, 2),
(@png2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can the tourist eVisa be used for business meetings?', 'Many PNG eVisa portals offer a combined visitor/business category; select the category matching your purpose and confirm with the official portal, as this was not independently verified this session.', 191, 2, 19200, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    191, 3, 'PNG-STU-IN-01', '2026.09', 'published',
    'Enrollment in a recognized educational institution in Papua New Guinea.',
    'PNG is an uncommon study destination for Indian students. A dedicated Student Visa must be applied for at the nearest PNG Embassy/Consulate (not via the standard eVisa) with proof of admission. Specific document checklists were not located from a first-party source this session.',
    'Duration tied to course length, subject to embassy assessment; not independently confirmed this session',
    'Apply in person or by post at the nearest PNG Embassy/Consulate with admission proof',
    1,
    'Confirm requirements directly with the PNG Embassy/Consulate or High Commission of India, Port Moresby before applying.',
    'Nearest PNG Embassy/Consulate; High Commission of India, Port Moresby (hcipom.gov.in) for bilateral consular assistance',
    'Secure admission to a recognized PNG institution\nGather academic and financial documents\nApply at the nearest PNG Embassy/Consulate\nAwait visa decision\nConfirm accommodation arrangements before travel',
    '/assets/images/visa-heroes/papua-new-guinea.webp',
    'General inference from PNG visa-category structure; not independently confirmed with a dedicated student-visa source this session', NULL, '2026-09-19'
);
SET @png3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@png3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@png3, 'Core Documents', 'Required from every applicant.', 1);
SET @png3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@png3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@png3s1, 'Admission/Enrollment Letter from a Recognized PNG Institution', NULL, 'copy', 1, 0, 1, 2),
(@png3s1, 'Proof of Tuition Fee Payment or Funding Arrangement', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@png3, 'Supporting Documents', 'Academic and accommodation evidence.', 2);
SET @png3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@png3s2, 'Academic Transcripts and Certificates', NULL, 'copy', 1, 0, 0, 1),
(@png3s2, 'Proof of Accommodation Arrangements in PNG', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is PNG a common study destination for Indian students?', 'No — it is uncommon. Contact the PNG Embassy/Consulate or High Commission of India, Port Moresby directly for current, authoritative student-visa requirements, as detailed sourcing was not available this session.', 191, 3, 19300, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    191, 4, 'PNG-WORK-IN-01', '2026.09', 'published',
    'Paid employment in Papua New Guinea for Indian nationals.',
    'The standard Tourist/Visitor eVisa does NOT permit employment. A separate Work Permit/Work Visa is required, applied for at the nearest PNG Embassy/Consulate, typically requiring an employer sponsor and a work permit from PNG''s Department of Labour and Industrial Relations.',
    'Tied to the employment contract/work permit duration; not independently confirmed this session',
    'Employer-sponsored work permit process plus visa application at the nearest PNG Embassy/Consulate',
    1,
    'Aggregator sources report fees of ~INR 9,500-13,000 depending on entry type — not independently confirmed against a first-party fee schedule this session. Extension fee ~Rs. 10,300/entry, also unconfirmed.',
    'Nearest PNG Embassy/Consulate',
    'Secure an employment offer from a PNG-based employer\nEmployer obtains a work permit from the Department of Labour and Industrial Relations\nApply for the Work Visa at the nearest PNG Embassy/Consulate\nComplete medical/police clearance if requested\nAwait visa decision',
    '/assets/images/visa-heroes/papua-new-guinea.webp',
    'Aggregator visa-assistance sources summarizing PNG work-visa fee ranges', NULL, '2026-09-19'
);
SET @png4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@png4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@png4, 'Core Documents', 'Required from every applicant.', 1);
SET @png4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@png4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@png4s1, 'Employment Contract/Offer Letter from PNG-Based Employer', NULL, 'copy', 1, 0, 1, 2),
(@png4s1, 'Work Permit from PNG Department of Labour and Industrial Relations', 'Obtained by the employer.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@png4, 'Supporting Documents', 'Qualification and clearance evidence.', 2);
SET @png4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@png4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@png4s2, 'Medical Fitness Certificate', NULL, 'copy', 0, 1, 0, 2),
(@png4s2, 'Police Clearance Certificate', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(191, 4, 13000.00, 'INR', 'Work Visa Fee (Embassy-Quoted Range, Upper Estimate)', 'Range ~INR 9,500-13,000 depending on single/multiple entry, inclusive of processing/service charges — not independently confirmed against a first-party fee schedule this session.', '2026-01-01', NOW(), NULL, 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in PNG on a standard tourist eVisa?', 'No. The standard visitor eVisa explicitly does not permit employment; a separate employer-sponsored Work Permit/Work Visa is required.', 191, 4, 19400, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    191, 5, 'PNG-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Papua New Guinea.',
    'Indian nationals visiting family in PNG apply via the same eVisa Portal used for tourism (visitor category is generally used for family visits as well, per aggregator sources), or at the nearest PNG Embassy/Consulate.',
    'Similar to the Tourist Visa (see sourcing-conflict note on duration); single entry',
    'Apply online via the PNG eVisa Portal, or at the nearest PNG Embassy/Consulate',
    0,
    'A letter of invitation from the resident family member, along with proof of relationship, is commonly requested though not independently itemized by a first-party source this session.',
    'Nearest PNG Embassy/Consulate',
    'Gather invitation letter and proof of relationship\nSubmit the online eVisa application or embassy application\nAwait approval\nCarry all documents for arrival immigration',
    '/assets/images/visa-heroes/papua-new-guinea.webp',
    'General inference from PNG visa-category structure; not independently confirmed with a dedicated family-visit source this session', NULL, '2026-09-19'
);
SET @png5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@png5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@png5, 'Core Documents', 'Required from every applicant.', 1);
SET @png5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@png5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@png5s1, 'Invitation Letter from Resident Family Member in PNG', NULL, 'copy', 1, 0, 1, 2),
(@png5s1, 'Proof of Relationship (Birth/Marriage Certificates)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@png5, 'Supporting Documents', 'Additional evidence.', 2);
SET @png5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@png5s2, 'Proof of Family Member''s Residency Status in PNG', NULL, 'copy', 0, 1, 0, 1),
(@png5s2, 'Return Flight Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Family Visit Visa category for PNG?', 'A dedicated first-party category was not independently confirmed this session; most aggregator sources indicate the standard visitor eVisa is used for family visits as well.', 191, 5, 19500, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    191, 6, 'PNG-TRAN-IN-01', '2026.09', 'published',
    'Brief transit through Papua New Guinea en route to a third country.',
    'Transit requirements for Indian passport holders passing through PNG were not independently confirmed from a first-party source this session. Given VOA is not available for other categories, travellers should assume a transit visa or the standard eVisa is required even for short stopovers.',
    'Short transit period, typically under 24-72 hours; not independently confirmed this session',
    'Confirm with airline and nearest PNG Embassy/Consulate; may require standard eVisa if leaving the transit area',
    0,
    'Not independently confirmed this session — confirm directly with your airline and the nearest PNG Embassy/Consulate before travel.',
    'Nearest PNG Embassy/Consulate',
    'Confirm transit requirements with your airline\nCheck whether a transit or standard eVisa is needed\nCarry onward flight ticket and destination visa if applicable',
    '/assets/images/visa-heroes/papua-new-guinea.webp',
    'Inference from absence of VOA and general visa structure; not independently confirmed this session', NULL, '2026-09-19'
);
SET @png6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@png6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@png6, 'Core Documents', 'Required from every applicant.', 1);
SET @png6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@png6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@png6s1, 'Onward Flight Ticket to Final Destination', NULL, 'copy', 1, 0, 1, 2),
(@png6s1, 'Visa for Final Destination Country', NULL, 'copy', 0, 1, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through PNG airports?', 'This was not independently confirmed this session — given VOA is unavailable for other categories, confirm transit requirements with your airline and the nearest PNG Embassy/Consulate before travel.', 191, 6, 19600, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    191, 7, 'PNG-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Papua New Guinea for Indian nationals.',
    'PNG is not a typical medical-tourism destination for Indian nationals (the reverse flow — PNG patients travelling to India for treatment — is far more common). A dedicated first-party Medical Visa checklist was not located this session.',
    'Tied to treatment duration; not independently confirmed this session',
    'Apply via the standard visitor eVisa or at the nearest PNG Embassy/Consulate with hospital documentation',
    0,
    'Confirm category-specific requirements directly with the nearest PNG Embassy/Consulate.',
    'Nearest PNG Embassy/Consulate',
    'Obtain hospital admission/treatment confirmation from a PNG hospital\nApply via the standard eVisa or embassy\nGather proof of funds for treatment and stay',
    '/assets/images/visa-heroes/papua-new-guinea.webp',
    'Inference; not independently confirmed with a dedicated medical-visa source this session', NULL, '2026-09-19'
);
SET @png7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@png7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@png7, 'Core Documents', 'Required from every applicant.', 1);
SET @png7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@png7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@png7s1, 'Hospital Admission Letter/Treatment Confirmation from PNG Hospital', NULL, 'copy', 1, 0, 1, 2),
(@png7s1, 'Proof of Funds for Treatment and Stay', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is PNG a common destination for medical treatment from India?', 'No — the more common travel flow is PNG patients seeking treatment in India. This category is included for completeness but was not independently sourced this session.', 191, 7, 19700, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    191, 8, 'PNG-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Papua New Guinea.',
    'Indian delegates typically apply via the eVisa Portal''s business/visitor category, per aggregator sources reviewed.',
    'Similar to the Business Visa duration (see sourcing-conflict note); single entry',
    'Apply online via the PNG eVisa Portal (business/visitor category), or at the nearest PNG Embassy/Consulate',
    0,
    'A formal invitation letter from the conference organizer is commonly expected though not independently itemized by a first-party source this session.',
    'Nearest PNG Embassy/Consulate',
    'Obtain formal invitation letter from the conference organizer\nGather proof of event registration\nSubmit the online eVisa application or embassy application\nAwait approval',
    '/assets/images/visa-heroes/papua-new-guinea.webp',
    'General inference from PNG visa-category structure; not independently confirmed with a dedicated conference-visa source this session', NULL, '2026-09-19'
);
SET @png8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@png8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@png8, 'Core Documents', 'Required from every applicant.', 1);
SET @png8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@png8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@png8s1, 'Formal Invitation Letter from Conference/Event Organizer', NULL, 'copy', 1, 0, 1, 2),
(@png8s1, 'Proof of Registration/Participation in the Event', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@png8, 'Supporting Documents', 'Travel evidence.', 2);
SET @png8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@png8s2, 'Return Flight Booking and Accommodation Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Conference Visa for PNG?', 'A dedicated first-party category was not independently confirmed this session; the business/visitor eVisa category is generally used.', 191, 8, 19800, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    191, 9, 'PNG-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Papua New Guinea.',
    'A dedicated Sports Visa category for PNG was not located from a first-party source this session. Indian athletes/officials would likely apply via the business/visitor eVisa category with event-specific documentation.',
    'Tied to the event duration; not independently confirmed this session',
    'Apply via the standard eVisa Portal (business/visitor category), or at the nearest PNG Embassy/Consulate',
    0,
    'Confirm the appropriate category with the nearest PNG Embassy/Consulate before applying.',
    'Nearest PNG Embassy/Consulate',
    'Obtain letter from sports federation/event organizer confirming participation\nGather proof of accommodation and travel arrangements\nSubmit the eVisa or embassy application',
    '/assets/images/visa-heroes/papua-new-guinea.webp',
    'Inference; not independently confirmed with a dedicated sports-visa source this session', NULL, '2026-09-19'
);
SET @png9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@png9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@png9, 'Core Documents', 'Required from every applicant.', 1);
SET @png9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@png9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@png9s1, 'Letter from Sports Federation/Event Organizer Confirming Participation', NULL, 'copy', 1, 0, 1, 2),
(@png9s1, 'Proof of Accommodation and Travel Arrangements', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports Visa for PNG?', 'Not independently confirmed this session — athletes/officials should confirm the appropriate category with the nearest PNG Embassy/Consulate before applying.', 191, 9, 19900, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    191, 10, 'PNG-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse/family member who holds a PNG Work Visa or long-term residency.',
    'Dependents of Indian nationals working in PNG typically apply through a process linked to the primary Work Visa holder''s employer sponsorship, per general inference from PNG''s visa structure. A dedicated first-party checklist was not located this session.',
    'Typically matches the primary visa holder''s permit duration; not independently confirmed this session',
    'Employer/sponsor-linked application at the nearest PNG Embassy/Consulate',
    1,
    'Coordinate with the sponsoring employer and the nearest PNG Embassy/Consulate for the correct process.',
    'Nearest PNG Embassy/Consulate',
    'Confirm sponsorship arrangement with the primary visa holder''s employer\nGather proof of relationship and primary visa holder''s documents\nApply at the nearest PNG Embassy/Consulate\nAwait visa decision',
    '/assets/images/visa-heroes/papua-new-guinea.webp',
    'Inference; not independently confirmed with a dedicated dependent-visa source this session', NULL, '2026-09-19'
);
SET @png10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@png10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@png10, 'Core Documents', 'Required from every applicant.', 1);
SET @png10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@png10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@png10s1, 'Proof of Relationship to Primary Work Visa Holder (Marriage/Birth Certificate)', NULL, 'copy', 1, 0, 1, 2),
(@png10s1, 'Copy of Primary Visa Holder''s Work Visa/Work Permit', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@png10, 'Supporting Documents', 'Employer-related documents.', 2);
SET @png10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@png10s2, 'Employer Sponsorship Letter Covering Dependents', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependents of a PNG Work Visa holder apply directly?', 'This was not independently confirmed this session — dependents should coordinate with the sponsoring employer and the nearest PNG Embassy/Consulate for the correct process.', 191, 10, 191000, 1);
