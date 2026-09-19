-- Samoa Visa Checklist Engine content for all 10 visa types.
--
-- Samoa's real, distinctive facts verified this session:
--   - Indian citizens enjoy visa-free entry for tourism/business, with
--     a visitor permit stamp issued automatically upon arrival — no
--     advance visa application needed.
--   - Minor sourcing conflict on duration: most sources say up to 60
--     days; one source says up to 90 days. The 60-day figure is used
--     as the primary/safer figure since it is more commonly cited,
--     with the conflict noted explicitly.
--   - The visitor permit can be extended for an additional 60 days for
--     a fee of WST 100 (Samoan Tala) — a specific, sourced figure.
--   - Work is explicitly NOT permitted on a Visitor Permit; a separate
--     work permit/visa is required for employment.
--   - A distinct Business Visa category exists for foreign nationals
--     visiting for short-term business activities without residing or
--     working in Samoa — though most Indian business travellers likely
--     use the standard visa-free visitor permit given its business
--     coverage.
--
-- country_id 192 = Samoa. visa_type_id: 1=Tourist, 2=Business,
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
    192, 1, 'WSM-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Samoa for Indian citizens.',
    'Indian citizens enjoy visa-free entry for tourism, with a visitor permit stamp issued automatically upon arrival. Most sources report up to 60 days; one source cites up to 90 days — the 60-day figure is used as the primary estimate given it is more commonly cited.',
    'Up to 60 days (primary estimate; one source cites up to 90 days), extendable by 60 more days for WST 100',
    'No visa required; simply present documents at the port of entry to receive a visitor permit stamp',
    0,
    'Duration figures vary slightly across sources (60 vs. 90 days) — confirm the stay granted with the immigration officer on arrival.',
    'Samoa High Commission/Consulate accredited to India (where applicable); Samoa Immigration',
    'Confirm passport validity of 6+ months\nGather return/onward flight ticket and proof of funds\nPresent documents to immigration on arrival\nReceive the visitor permit stamp',
    '/assets/images/visa-heroes/samoa.webp',
    'ixigo.com, atlys.com, peninsulavisa.com secondary sourcing', 'https://www.atlys.com/en-US/visa/samoa-visa', '2026-09-19'
);
SET @wsm1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@wsm1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wsm1, 'Core Documents', 'Required from every applicant.', 1);
SET @wsm1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@wsm1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wsm1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @wsm1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@wsm1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@wsm1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(192, 1, 100.00, 'WST', 'Visitor Permit Extension Fee (60 Additional Days)', 'WST 100 fee to extend the visitor permit by an additional 60 days beyond the initial visa-free period.', '2026-01-01', NOW(), NULL, 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Samoa?', 'No. Indian citizens enjoy visa-free entry with a visitor permit stamp issued automatically upon arrival for tourism or business purposes.', 192, 1, 19200, 1),
('Can the Samoa visitor permit be extended?', 'Yes, for an additional 60 days for a fee of WST 100.', 192, 1, 19201, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    192, 2, 'WSM-BUS-IN-01', '2026.09', 'published',
    'Short-term business visits to Samoa for foreign nationals who do not reside or work in Samoa.',
    'Business visits are covered under the same visa-free visitor permit as tourism. A distinct Business Visa category also exists for those visiting specifically for short-term business activities, though the standard visa-free visitor permit covers most Indian business travellers.',
    'Up to 60 days (primary estimate; one source cites up to 90 days), extendable by 60 more days for WST 100',
    'No visa required for standard business visits; simply present documents at the port of entry',
    0,
    'A business invitation letter is recommended as supporting evidence though not confirmed mandatory for the visa-free route.',
    'Samoa High Commission/Consulate accredited to India (where applicable); Samoa Immigration',
    'Gather business invitation letter and company documents\nGather return flight ticket and proof of funds\nPresent documents to immigration on arrival',
    '/assets/images/visa-heroes/samoa.webp',
    'stampthepassport.com secondary sourcing on distinct Samoa Business Visa category', 'https://stampthepassport.com/visa/samoa-visa-online/samoa-business', '2026-09-19'
);
SET @wsm2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@wsm2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wsm2, 'Core Documents', 'Required from every applicant.', 1);
SET @wsm2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@wsm2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@wsm2s1, 'Business Invitation Letter', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wsm2, 'Supporting Documents', 'Company and travel evidence.', 2);
SET @wsm2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@wsm2s2, 'Proof of Employment/Business Ownership in India', NULL, 'copy', 1, 0, 0, 1),
(@wsm2s2, 'Return Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Business Visa for Samoa?', 'A distinct Business Visa category exists for foreign nationals not residing/working in Samoa, though the standard visa-free visitor permit covers most short-term business visits by Indian travellers.', 192, 2, 19300, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    192, 3, 'WSM-STU-IN-01', '2026.09', 'published',
    'Enrollment in a recognized educational institution in Samoa.',
    'Samoa is an uncommon study destination for Indian students. Long-term study requires a Student Visa/permit beyond the visa-free visitor entry, with proof of admission. Specific document checklists were not located from a first-party source this session.',
    'Duration tied to course length, subject to immigration assessment; not independently confirmed this session',
    'Apply via Samoa Immigration or the nearest accredited mission with admission proof',
    1,
    'Confirm requirements directly with the institution and Samoa Immigration before applying.',
    'Samoa Immigration; Samoa High Commission/Consulate accredited to India (where applicable)',
    'Secure admission to a recognized Samoan institution\nGather academic and financial documents\nApply for the Student Visa/permit\nAwait visa decision',
    '/assets/images/visa-heroes/samoa.webp',
    'General inference from Samoa visa-category structure; not independently confirmed with a dedicated student-visa source this session', NULL, '2026-09-19'
);
SET @wsm3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@wsm3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wsm3, 'Core Documents', 'Required from every applicant.', 1);
SET @wsm3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@wsm3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@wsm3s1, 'Admission/Enrollment Letter from a Recognized Samoan Institution', NULL, 'copy', 1, 0, 1, 2),
(@wsm3s1, 'Proof of Tuition Fee Payment or Funding Arrangement', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wsm3, 'Supporting Documents', 'Academic evidence.', 2);
SET @wsm3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@wsm3s2, 'Academic Transcripts and Certificates', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Samoa a common study destination for Indian students?', 'No — it is uncommon. Contact Samoa Immigration or the nearest accredited mission directly for current requirements.', 192, 3, 19400, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    192, 4, 'WSM-WORK-IN-01', '2026.09', 'published',
    'Paid employment in Samoa for Indian nationals.',
    'Work is explicitly NOT permitted on a Visitor Permit. A separate work permit/visa is required for employment, typically with an employer sponsor. Specific fee figures for the work-permit category were not located in sources reviewed this session.',
    'Tied to the employment contract/work permit duration',
    'Employer-sponsored work permit application through Samoa Immigration',
    1,
    'Fee and exact document checklist not independently confirmed against a first-party source this session — confirm directly with Samoa Immigration.',
    'Samoa Immigration',
    'Secure an employment offer from a Samoa-based employer\nEmployer/applicant applies for a work permit through Samoa Immigration\nGather qualification documents\nAwait decision',
    '/assets/images/visa-heroes/samoa.webp',
    'visitworld.today secondary sourcing on work-permit restriction; fee not independently confirmed this session', NULL, '2026-09-19'
);
SET @wsm4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@wsm4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wsm4, 'Core Documents', 'Required from every applicant.', 1);
SET @wsm4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@wsm4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@wsm4s1, 'Employment Offer Letter from Samoa-Based Employer', NULL, 'copy', 1, 0, 1, 2),
(@wsm4s1, 'Work Permit Application', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wsm4, 'Supporting Documents', 'Qualification evidence.', 2);
SET @wsm4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@wsm4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Samoa on the visa-free Visitor Permit?', 'No. Work is explicitly not permitted on a Visitor Permit; a separate work permit/visa is required.', 192, 4, 19500, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    192, 5, 'WSM-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Samoa.',
    'Indian nationals visiting family use the same visa-free Visitor Permit as tourists.',
    'Up to 60 days (primary estimate; one source cites up to 90 days), extendable by 60 more days for WST 100',
    'No visa required; simply present documents at the port of entry',
    0,
    'An invitation letter from the resident family member is recommended supporting evidence.',
    'Samoa High Commission/Consulate accredited to India (where applicable); Samoa Immigration',
    'Gather invitation letter and proof of relationship\nGather return flight ticket and proof of funds\nPresent documents to immigration on arrival',
    '/assets/images/visa-heroes/samoa.webp',
    'General inference from Samoa visa-category structure', NULL, '2026-09-19'
);
SET @wsm5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@wsm5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wsm5, 'Core Documents', 'Required from every applicant.', 1);
SET @wsm5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@wsm5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@wsm5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 0, 1, 1, 2),
(@wsm5s1, 'Proof of Relationship (Birth/Marriage Certificates)', NULL, 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wsm5, 'Supporting Documents', 'Additional evidence.', 2);
SET @wsm5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@wsm5s2, 'Return Flight Ticket', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Family Visit Visa for Samoa?', 'A dedicated first-party category was not independently confirmed this session; the same visa-free Visitor Permit used for tourism applies.', 192, 5, 19600, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    192, 6, 'WSM-TRAN-IN-01', '2026.09', 'published',
    'Brief transit through Samoa en route to a third country.',
    'Transit requirements for Indian passport holders were not independently confirmed from a first-party source this session. Given the general visa-free entry policy, transit is likely similarly exempt, but travellers should confirm with their airline.',
    'Short transit period; not independently confirmed this session',
    'Confirm with airline before travel',
    0,
    'Not independently confirmed this session — confirm directly before travel.',
    'Samoa Immigration',
    'Confirm transit requirements with your airline\nCarry onward flight ticket and destination visa if applicable',
    '/assets/images/visa-heroes/samoa.webp',
    'Inference from general visa-free entry policy; not independently confirmed this session', NULL, '2026-09-19'
);
SET @wsm6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@wsm6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wsm6, 'Core Documents', 'Required from every applicant.', 1);
SET @wsm6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@wsm6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@wsm6s1, 'Onward Flight Ticket to Final Destination', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Samoa?', 'This was not independently confirmed this session — the general visa-free policy likely covers transit, but confirm with your airline before travel.', 192, 6, 19700, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    192, 7, 'WSM-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Samoa for Indian nationals.',
    'Samoa is not a typical medical-tourism destination for Indian nationals. The visa-free Visitor Permit likely covers short medical visits, though a dedicated first-party Medical Visa checklist was not located this session.',
    'Tied to treatment duration; not independently confirmed this session',
    'No visa required for short visits under the visa-free policy; longer treatment may require additional clearance',
    0,
    'Confirm category-specific requirements directly with Samoa Immigration.',
    'Samoa Immigration',
    'Obtain hospital admission/treatment confirmation from a local hospital\nGather proof of funds for treatment and stay\nPresent documents to immigration on arrival',
    '/assets/images/visa-heroes/samoa.webp',
    'Inference from general visa-free entry policy; not independently confirmed with a dedicated medical-visa source this session', NULL, '2026-09-19'
);
SET @wsm7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@wsm7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wsm7, 'Core Documents', 'Required from every applicant.', 1);
SET @wsm7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@wsm7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@wsm7s1, 'Hospital Admission Letter/Treatment Confirmation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Samoa a common destination for medical treatment from India?', 'No — this was not independently sourced this session.', 192, 7, 19800, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    192, 8, 'WSM-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Samoa.',
    'Conference attendance falls under the same visa-free Visitor Permit as business visits.',
    'Up to 60 days (primary estimate; one source cites up to 90 days), extendable by 60 more days for WST 100',
    'No visa required; simply present documents at the port of entry',
    0,
    'A formal invitation letter from the conference organizer is recommended supporting evidence.',
    'Samoa High Commission/Consulate accredited to India (where applicable); Samoa Immigration',
    'Obtain formal invitation letter from the conference organizer\nGather proof of event registration\nPresent documents to immigration on arrival',
    '/assets/images/visa-heroes/samoa.webp',
    'General inference from the visa-free policy covering business purposes', NULL, '2026-09-19'
);
SET @wsm8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@wsm8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wsm8, 'Core Documents', 'Required from every applicant.', 1);
SET @wsm8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@wsm8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@wsm8s1, 'Formal Invitation Letter from Conference/Event Organizer', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Conference Visa for Samoa?', 'No dedicated category was located; conference attendance falls under the general visa-free Visitor Permit covering business purposes.', 192, 8, 19900, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    192, 9, 'WSM-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Samoa.',
    'A dedicated Sports Visa category was not located from a first-party source this session. Athletes/officials would likely use the same visa-free Visitor Permit as tourists/business visitors.',
    'Up to 60 days (primary estimate; one source cites up to 90 days), extendable by 60 more days for WST 100',
    'No visa required for short participation; simply present documents at the port of entry',
    0,
    'Confirm the appropriate category with Samoa Immigration before applying.',
    'Samoa Immigration',
    'Obtain letter from sports federation/event organizer confirming participation\nGather proof of accommodation and travel arrangements\nPresent documents to immigration on arrival',
    '/assets/images/visa-heroes/samoa.webp',
    'Inference; not independently confirmed with a dedicated sports-visa source this session', NULL, '2026-09-19'
);
SET @wsm9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@wsm9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wsm9, 'Core Documents', 'Required from every applicant.', 1);
SET @wsm9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@wsm9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@wsm9s1, 'Letter from Sports Federation/Event Organizer Confirming Participation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports Visa for Samoa?', 'Not independently confirmed this session — athletes/officials should confirm the appropriate requirement with Samoa Immigration.', 192, 9, 20000, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    192, 10, 'WSM-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse/family member who holds a Samoa work permit or long-term residency.',
    'Dependents of Indian nationals working in Samoa typically apply through a process linked to the primary work-permit holder''s employer sponsorship. A dedicated first-party checklist was not located this session.',
    'Typically matches the primary permit holder''s duration; not independently confirmed this session',
    'Employer/sponsor-linked application through Samoa Immigration',
    1,
    'Coordinate with the sponsoring employer and Samoa Immigration for the correct process.',
    'Samoa Immigration',
    'Confirm sponsorship arrangement with the primary permit holder''s employer\nGather proof of relationship and primary permit holder''s documents\nApply through Samoa Immigration\nAwait decision',
    '/assets/images/visa-heroes/samoa.webp',
    'Inference; not independently confirmed with a dedicated dependent-visa source this session', NULL, '2026-09-19'
);
SET @wsm10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@wsm10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wsm10, 'Core Documents', 'Required from every applicant.', 1);
SET @wsm10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@wsm10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@wsm10s1, 'Proof of Relationship to Primary Permit Holder (Marriage/Birth Certificate)', NULL, 'copy', 1, 0, 1, 2),
(@wsm10s1, 'Copy of Primary Permit Holder''s Work Permit', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependents of a Samoa work-permit holder apply directly?', 'This was not independently confirmed this session — dependents should coordinate with the sponsoring employer and Samoa Immigration for the correct process.', 192, 10, 20100, 1);
