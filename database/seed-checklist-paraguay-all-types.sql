-- Paraguay Visa Checklist Engine content for all 10 visa types.
--
-- Paraguay's real, distinctive facts verified this session:
--   - No Visa on Arrival, eVisa, or visa-free entry for Indian
--     ordinary-passport holders — a full embassy visa is mandatory.
--     (Diplomatic/official/service passport holders get visa-free
--     entry up to 90 days, per Wikipedia visa-policy data — a distinct
--     exception noted here for completeness, not applicable to most
--     travellers.)
--   - Application is fully offline: online form + in-person submission
--     at the Embassy of Paraguay, New Delhi, or via authorized visa
--     agents, at least 30 days before travel.
--   - A Police Clearance Certificate (PCC), notarized and apostilled
--     by the Ministry of External Affairs, is a distinctive requirement
--     not seen in most Batch 12 countries.
--   - Processing time is unusually long: 20-30 working days.
--   - Single-entry fee ~USD 65 (~INR 5,400); multiple-entry fee ~USD
--     100 (~INR 8,500) — both figures cited consistently across
--     sources reviewed.
--
-- country_id 204 = Paraguay. visa_type_id: 1=Tourist, 2=Business,
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
    204, 1, 'PRY-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Paraguay for Indian citizens.',
    'Indian ordinary-passport holders must obtain a visa in advance; no VOA, eVisa, or visa-free entry exists. Diplomatic/official/service passport holders may enter visa-free for up to 90 days.',
    'Per visa grant, typically up to 90 days; single or multiple entry per fee paid',
    'Submit an online application form, then attend in person at the Embassy of Paraguay, New Delhi, or via an authorized visa agent',
    1,
    'Processing takes an unusually long 20-30 working days — apply at least 30 days before travel.',
    'Embassy of Paraguay, New Delhi',
    'Complete the online application form\nGather passport, photos, and financial documents\nObtain an apostilled Police Clearance Certificate\nSchedule an appointment at the Embassy of Paraguay, New Delhi\nSubmit documents in person and pay the fee\nAllow 20-30 working days for processing',
    '/assets/images/visa-heroes/paraguay.webp',
    'btwvisas.com, akbartravels.com, joinsherpa.com secondary sourcing', 'https://btwvisas.com/visa-guide/paraguay-tourist-visa/', '2026-09-19'
);
SET @pry1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pry1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pry1, 'Core Documents', 'Required from every applicant.', 1);
SET @pry1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pry1s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@pry1s1, 'Completed Online Application Form Printout', NULL, 'copy', 1, 0, 1, 2),
(@pry1s1, 'Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 3),
(@pry1s1, 'Apostilled Police Clearance Certificate', 'Notarized and apostilled by the Ministry of External Affairs.', 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pry1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @pry1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pry1s2, 'Bank Statements / Income Tax Returns', 'Proof of sufficient financial resources.', 'copy', 1, 0, 0, 1),
(@pry1s2, 'Return Flight Booking', NULL, 'copy', 1, 0, 0, 2),
(@pry1s2, 'Hotel/Accommodation Booking Confirmation', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(204, 1, 65.00, 'USD', 'Tourist Visa Fee (Single Entry)', 'Approx. USD 65 (~INR 5,400) for single entry; USD 100 (~INR 8,500) for multiple entry.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/paraguay-tourist-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Visa on Arrival or eVisa available for Indians visiting Paraguay?', 'No. Indian ordinary-passport holders must obtain a visa in advance at the Embassy of Paraguay, New Delhi — no VOA, eVisa, or visa-free entry exists.', 204, 1, 20400, 1),
('Why is a Police Clearance Certificate required?', 'Paraguay requires an apostilled PCC as part of the standard visa application, notarized and apostilled by India''s Ministry of External Affairs before submission.', 204, 1, 20401, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    204, 2, 'PRY-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Paraguay.',
    'Business travellers use the same embassy-issued visa process as tourists; the standard fee structure (single/multiple entry) applies equally.',
    'Per visa grant, typically up to 90 days; single or multiple entry per fee paid',
    'Submit an online application form, then attend in person at the Embassy of Paraguay, New Delhi',
    1,
    'Processing takes 20-30 working days — apply at least 30 days before travel. A business invitation letter strengthens the application.',
    'Embassy of Paraguay, New Delhi',
    'Complete the online application form\nGather business invitation letter and company documents\nObtain an apostilled Police Clearance Certificate\nSchedule an appointment at the Embassy of Paraguay, New Delhi\nSubmit documents in person and pay the fee',
    '/assets/images/visa-heroes/paraguay.webp',
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/paraguay-visa', '2026-09-19'
);
SET @pry2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pry2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pry2, 'Core Documents', 'Required from every applicant.', 1);
SET @pry2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pry2s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@pry2s1, 'Business Invitation Letter from Paraguay Host Company', NULL, 'copy', 1, 0, 1, 2),
(@pry2s1, 'Apostilled Police Clearance Certificate', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pry2, 'Supporting Documents', 'Company and travel evidence.', 2);
SET @pry2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pry2s2, 'Proof of Employment/Business Ownership in India', NULL, 'copy', 1, 0, 0, 1),
(@pry2s2, 'Bank Statements / Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@pry2s2, 'Return Flight Booking and Accommodation Confirmation', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the business visa process different from the tourist visa?', 'The application channel and fee structure are the same; a business invitation letter replaces the accommodation booking as the primary supporting document.', 204, 2, 20500, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    204, 3, 'PRY-STU-IN-01', '2026.09', 'published',
    'Enrollment in a recognized educational institution in Paraguay.',
    'Paraguay is an uncommon study destination for Indian students. A dedicated Student Visa must be applied for at the Embassy of Paraguay, New Delhi, with proof of admission. Specific document checklists beyond the standard visa requirements were not located from a first-party source this session.',
    'Duration tied to course length, subject to embassy assessment; not independently confirmed this session',
    'Apply in person at the Embassy of Paraguay, New Delhi, with admission proof',
    1,
    'Confirm requirements directly with the Embassy of Paraguay, New Delhi before applying.',
    'Embassy of Paraguay, New Delhi',
    'Secure admission to a recognized Paraguayan institution\nGather academic and financial documents\nObtain an apostilled Police Clearance Certificate\nApply at the Embassy of Paraguay, New Delhi\nAwait visa decision (20-30 working days)',
    '/assets/images/visa-heroes/paraguay.webp',
    'General inference from Paraguay visa-category structure; not independently confirmed with a dedicated student-visa source this session', NULL, '2026-09-19'
);
SET @pry3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pry3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pry3, 'Core Documents', 'Required from every applicant.', 1);
SET @pry3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pry3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pry3s1, 'Admission/Enrollment Letter from a Recognized Paraguayan Institution', NULL, 'copy', 1, 0, 1, 2),
(@pry3s1, 'Apostilled Police Clearance Certificate', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pry3, 'Supporting Documents', 'Academic and financial evidence.', 2);
SET @pry3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pry3s2, 'Proof of Tuition Fee Payment or Funding Arrangement', NULL, 'copy', 1, 0, 0, 1),
(@pry3s2, 'Academic Transcripts and Certificates', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Paraguay a common study destination for Indian students?', 'No — it is uncommon. Contact the Embassy of Paraguay, New Delhi directly for current, authoritative student-visa requirements, as detailed sourcing was not available this session.', 204, 3, 20600, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    204, 4, 'PRY-WORK-IN-01', '2026.09', 'published',
    'Paid employment and long-term residency in Paraguay for Indian nationals.',
    'A work and residency visa allows Indian nationals to work or remain in Paraguay long-term, distinct from the standard tourist/business visa. Specific fee figures for this category were not located in sources reviewed this session — the standard visa fee range does not necessarily apply.',
    'Longer-term, tied to the work/residency permit; not independently confirmed this session',
    'Apply at the Embassy of Paraguay, New Delhi, typically with an employer sponsor',
    1,
    'Fee and exact document checklist not independently confirmed against a first-party source this session — confirm directly with the embassy.',
    'Embassy of Paraguay, New Delhi',
    'Secure an employment offer from a Paraguay-based employer\nGather qualification and financial documents\nObtain an apostilled Police Clearance Certificate\nApply at the Embassy of Paraguay, New Delhi\nAwait visa decision',
    '/assets/images/visa-heroes/paraguay.webp',
    'btwvisas.com secondary sourcing on work/residency visa category; fee not independently confirmed this session', NULL, '2026-09-19'
);
SET @pry4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pry4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pry4, 'Core Documents', 'Required from every applicant.', 1);
SET @pry4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pry4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pry4s1, 'Employment Contract/Offer Letter from Paraguay-Based Employer', NULL, 'copy', 1, 0, 1, 2),
(@pry4s1, 'Apostilled Police Clearance Certificate', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pry4, 'Supporting Documents', 'Qualification evidence.', 2);
SET @pry4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pry4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@pry4s2, 'Medical Fitness Certificate', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the fee for a Paraguay work/residency visa?', 'Not independently confirmed this session — confirm the current fee schedule directly with the Embassy of Paraguay, New Delhi.', 204, 4, 20700, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    204, 5, 'PRY-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Paraguay.',
    'Indian nationals visiting family in Paraguay apply through the same embassy visa process as tourists, with an invitation letter from the resident family member as supporting evidence.',
    'Per visa grant, typically up to 90 days; single or multiple entry per fee paid',
    'Submit an online application form, then attend in person at the Embassy of Paraguay, New Delhi',
    1,
    'Processing takes 20-30 working days — apply at least 30 days before travel.',
    'Embassy of Paraguay, New Delhi',
    'Gather invitation letter and proof of relationship\nObtain an apostilled Police Clearance Certificate\nSchedule an appointment at the Embassy of Paraguay, New Delhi\nSubmit documents in person and pay the fee',
    '/assets/images/visa-heroes/paraguay.webp',
    'General inference from Paraguay visa-category structure; not independently confirmed with a dedicated family-visit source this session', NULL, '2026-09-19'
);
SET @pry5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pry5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pry5, 'Core Documents', 'Required from every applicant.', 1);
SET @pry5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pry5s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@pry5s1, 'Invitation Letter from Resident Family Member in Paraguay', NULL, 'copy', 1, 0, 1, 2),
(@pry5s1, 'Proof of Relationship (Birth/Marriage Certificates)', NULL, 'copy', 1, 0, 1, 3),
(@pry5s1, 'Apostilled Police Clearance Certificate', NULL, 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pry5, 'Supporting Documents', 'Additional evidence.', 2);
SET @pry5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pry5s2, 'Return Flight Booking', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Family Visit Visa category for Paraguay?', 'A dedicated first-party category was not independently confirmed this session; the standard visa process applies with the addition of family relationship proof.', 204, 5, 20800, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    204, 6, 'PRY-TRAN-IN-01', '2026.09', 'published',
    'Brief transit through Paraguay en route to a third country.',
    'Transit requirements for Indian passport holders passing through Paraguay were not independently confirmed from a first-party source this session. Given no VOA/eVisa exists for other categories, travellers should assume a transit visa is required and confirm with the Embassy of Paraguay well in advance, given the 20-30 working-day processing time.',
    'Short transit period; not independently confirmed this session',
    'Confirm with airline and the Embassy of Paraguay, New Delhi well in advance of travel',
    0,
    'Given 20-30 working-day standard processing, transit visas (if required) should be arranged well ahead of travel.',
    'Embassy of Paraguay, New Delhi',
    'Confirm transit requirements with your airline and the embassy\nApply well in advance given long processing times\nCarry onward flight ticket and destination visa if applicable',
    '/assets/images/visa-heroes/paraguay.webp',
    'Inference from absence of VOA/eVisa and general visa structure; not independently confirmed this session', NULL, '2026-09-19'
);
SET @pry6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pry6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pry6, 'Core Documents', 'Required from every applicant.', 1);
SET @pry6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pry6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pry6s1, 'Onward Flight Ticket to Final Destination', NULL, 'copy', 1, 0, 1, 2),
(@pry6s1, 'Visa for Final Destination Country', NULL, 'copy', 0, 1, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Paraguay?', 'This was not independently confirmed this session — given no VOA/eVisa exists for other categories, confirm transit requirements with your airline and the Embassy of Paraguay well ahead of travel.', 204, 6, 20900, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    204, 7, 'PRY-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Paraguay for Indian nationals.',
    'Paraguay is not a typical medical-tourism destination for Indian nationals. A dedicated first-party Medical Visa checklist was not located this session; applicants should apply via the standard visa process at the Embassy of Paraguay, New Delhi with hospital documentation.',
    'Tied to treatment duration; not independently confirmed this session',
    'Apply via the standard visa process at the Embassy of Paraguay, New Delhi, with hospital documentation',
    1,
    'Confirm category-specific requirements directly with the Embassy of Paraguay, New Delhi.',
    'Embassy of Paraguay, New Delhi',
    'Obtain hospital admission/treatment confirmation from a Paraguayan hospital\nGather standard visa documents including apostilled PCC\nApply at the Embassy of Paraguay, New Delhi',
    '/assets/images/visa-heroes/paraguay.webp',
    'Inference; not independently confirmed with a dedicated medical-visa source this session', NULL, '2026-09-19'
);
SET @pry7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pry7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pry7, 'Core Documents', 'Required from every applicant.', 1);
SET @pry7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pry7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pry7s1, 'Hospital Admission Letter/Treatment Confirmation from Paraguayan Hospital', NULL, 'copy', 1, 0, 1, 2),
(@pry7s1, 'Apostilled Police Clearance Certificate', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Paraguay a common destination for medical treatment from India?', 'No — this was not independently sourced this session. Confirm directly with the Embassy of Paraguay, New Delhi.', 204, 7, 21000, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    204, 8, 'PRY-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Paraguay.',
    'Indian delegates apply via the same standard visa process as business travellers, with a formal invitation letter from the conference organizer.',
    'Per visa grant, typically up to 90 days; single or multiple entry per fee paid',
    'Submit an online application form, then attend in person at the Embassy of Paraguay, New Delhi',
    1,
    'Processing takes 20-30 working days — apply at least 30 days before travel.',
    'Embassy of Paraguay, New Delhi',
    'Obtain formal invitation letter from the conference organizer\nGather proof of event registration\nObtain an apostilled Police Clearance Certificate\nApply at the Embassy of Paraguay, New Delhi',
    '/assets/images/visa-heroes/paraguay.webp',
    'General inference from Paraguay visa-category structure; not independently confirmed with a dedicated conference-visa source this session', NULL, '2026-09-19'
);
SET @pry8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pry8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pry8, 'Core Documents', 'Required from every applicant.', 1);
SET @pry8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pry8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pry8s1, 'Formal Invitation Letter from Conference/Event Organizer', NULL, 'copy', 1, 0, 1, 2),
(@pry8s1, 'Apostilled Police Clearance Certificate', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pry8, 'Supporting Documents', 'Travel evidence.', 2);
SET @pry8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pry8s2, 'Return Flight Booking and Accommodation Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Conference Visa for Paraguay?', 'A dedicated first-party category was not independently confirmed this session; the standard business visa process is generally used.', 204, 8, 21100, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    204, 9, 'PRY-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Paraguay.',
    'A dedicated Sports Visa category for Paraguay was not located from a first-party source this session. Indian athletes/officials would likely apply via the standard visa process with event-specific documentation.',
    'Tied to the event duration; not independently confirmed this session',
    'Apply via the standard visa process at the Embassy of Paraguay, New Delhi',
    1,
    'Confirm the appropriate category with the Embassy of Paraguay, New Delhi before applying.',
    'Embassy of Paraguay, New Delhi',
    'Obtain letter from sports federation/event organizer confirming participation\nGather standard visa documents including apostilled PCC\nApply at the Embassy of Paraguay, New Delhi',
    '/assets/images/visa-heroes/paraguay.webp',
    'Inference; not independently confirmed with a dedicated sports-visa source this session', NULL, '2026-09-19'
);
SET @pry9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pry9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pry9, 'Core Documents', 'Required from every applicant.', 1);
SET @pry9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pry9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pry9s1, 'Letter from Sports Federation/Event Organizer Confirming Participation', NULL, 'copy', 1, 0, 1, 2),
(@pry9s1, 'Apostilled Police Clearance Certificate', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports Visa for Paraguay?', 'Not independently confirmed this session — athletes/officials should confirm the appropriate category with the Embassy of Paraguay, New Delhi before applying.', 204, 9, 21200, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    204, 10, 'PRY-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse/family member who holds a Paraguay Work Visa or residency.',
    'Dependents of Indian nationals working in Paraguay typically apply through a process linked to the primary Work Visa holder''s sponsorship. A dedicated first-party checklist was not located this session.',
    'Typically matches the primary visa holder''s permit duration; not independently confirmed this session',
    'Sponsor-linked application at the Embassy of Paraguay, New Delhi',
    1,
    'Coordinate with the primary visa holder''s sponsor and the Embassy of Paraguay, New Delhi for the correct process.',
    'Embassy of Paraguay, New Delhi',
    'Confirm sponsorship arrangement with the primary visa holder\nGather proof of relationship and primary visa holder''s documents\nObtain an apostilled Police Clearance Certificate\nApply at the Embassy of Paraguay, New Delhi',
    '/assets/images/visa-heroes/paraguay.webp',
    'Inference; not independently confirmed with a dedicated dependent-visa source this session', NULL, '2026-09-19'
);
SET @pry10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pry10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pry10, 'Core Documents', 'Required from every applicant.', 1);
SET @pry10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pry10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pry10s1, 'Proof of Relationship to Primary Visa Holder (Marriage/Birth Certificate)', NULL, 'copy', 1, 0, 1, 2),
(@pry10s1, 'Copy of Primary Visa Holder''s Work Visa/Residency Permit', NULL, 'copy', 1, 0, 1, 3),
(@pry10s1, 'Apostilled Police Clearance Certificate', NULL, 'original', 1, 0, 1, 4);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependents of a Paraguay Work Visa holder apply directly?', 'This was not independently confirmed this session — dependents should coordinate with the sponsor and the Embassy of Paraguay, New Delhi for the correct process.', 204, 10, 21300, 1);
