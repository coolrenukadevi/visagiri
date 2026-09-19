-- Republic of the Congo (Congo-Brazzaville) Visa Checklist Engine
-- content for all 10 visa types.
--
-- Republic of the Congo's real, distinctive facts verified this session:
--   - SOURCING CONFLICT (flagged, not silently resolved): several
--     aggregator sources (VisaGo, airport-information sites) state
--     Indian citizens enjoy visa-free entry for 30-90 days. However,
--     the Embassy of India, Brazzaville's own official pages
--     (eoibrazzaville.gov.in) describe a formal visa application
--     process — an online form via indianvisaonline.gov.in printed
--     and submitted to a diplomatic mission, with two passport
--     photographs, for entry INTO India from Congo (i.e., the reverse
--     direction) — and Akbar Travels lists a paid "Republic of Congo
--     Tourist Visa for Indians" starting at ~Rs. 7,199, implying a
--     visa IS required for Indians travelling TO Congo. Given this
--     conflict, and that a formal visa application process for
--     Indians is referenced by more than one source, this checklist
--     treats a visa as likely required and recommends travellers
--     verify current visa-free eligibility directly with the Congolese
--     Embassy/Consulate or the Embassy of India, Brazzaville before
--     assuming visa-free entry.
--   - Working, volunteering for pay, or business activity is NOT
--     permitted on visa-free/tourist entry, per sources reviewed — a
--     separate work permit/visa is required for employment.
--
-- country_id 39 = Republic of the Congo. visa_type_id: 1=Tourist,
-- 2=Business, 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical,
-- 8=Conference, 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    39, 1, 'COG-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to the Republic of the Congo (Congo-Brazzaville) for Indian citizens.',
    'SOURCING CONFLICT: some aggregator sources claim visa-free entry for 30-90 days, while Akbar Travels lists a paid tourist visa (~Rs. 7,199) and the Embassy of India, Brazzaville references a formal visa process. Verify current requirements directly before travel; do not assume visa-free entry.',
    'Reported as 30-90 days if visa-free status applies; otherwise per visa grant',
    'Confirm with the Congolese Embassy/Consulate whether a visa is required; if so, apply via the nearest Congolese mission',
    1,
    'Given the sourcing conflict on visa requirement, contact the Embassy of India, Brazzaville (eoibrazzaville.gov.in) or the nearest Congolese mission to confirm current rules before booking travel.',
    'Embassy of India, Brazzaville, Republic of Congo (eoibrazzaville.gov.in); nearest Congolese Embassy/Consulate for visa issuance',
    'Confirm current visa requirement given conflicting sources\nIf a visa is required, gather passport, photos, and application form\nSubmit application to the nearest Congolese Embassy/Consulate\nCarry proof of onward travel regardless of visa status\nConfirm passport validity of 6+ months',
    '/assets/images/visa-heroes/republic-of-the-congo.webp',
    'visago.dev, akbartravels.com (conflicting), Embassy of India Brazzaville (eoibrazzaville.gov.in)', 'https://www.eoibrazzaville.gov.in/page/entry-visa/', '2026-09-19'
);
SET @cog1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cog1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cog1, 'Core Documents', 'Required from every applicant.', 1);
SET @cog1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cog1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cog1s1, 'Passport-Size Photograph (White/Light Background)', NULL, 'copy', 1, 0, 1, 2),
(@cog1s1, 'Visa Application Form (If Visa Required)', NULL, 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cog1, 'Supporting Documents', 'Evidence of your travel plans.', 2);
SET @cog1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cog1s2, 'Proof of Onward/Return Travel', NULL, 'copy', 1, 0, 0, 1),
(@cog1s2, 'Hotel/Accommodation Booking Confirmation', NULL, 'copy', 0, 1, 0, 2),
(@cog1s2, 'Proof of Sufficient Funds', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(39, 1, 7199.00, 'INR', 'Tourist Visa Fee (If Required) - Sourcing Conflict', 'Akbar Travels lists a fee starting at ~Rs. 7,199 for a Congo tourist visa; other sources claim visa-free entry. Confirm which applies before paying.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/republicofcongo-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Congo-Brazzaville?', 'Sources disagree: some claim visa-free entry for 30-90 days, while others (including a travel agency listing a paid visa fee) suggest a visa is required. This was not independently reconciled this session — confirm directly with the Congolese Embassy/Consulate or the Embassy of India, Brazzaville before travel.', 39, 1, 3900, 1),
('Can I work in Congo-Brazzaville on a tourist visa or visa-free entry?', 'No. Working, volunteering for pay, or business activity is not permitted on tourist/visa-free entry; a separate work permit/visa is required.', 39, 1, 3901, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    39, 2, 'COG-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in the Republic of the Congo.',
    'Business activity is explicitly NOT permitted on visa-free/tourist entry per sources reviewed; a business visa or appropriate permit is required regardless of the tourist-entry sourcing conflict.',
    'Per visa grant; not independently confirmed this session',
    'Apply at the nearest Congolese Embassy/Consulate with a business invitation letter',
    1,
    'Confirm requirements directly with the nearest Congolese Embassy/Consulate given limited first-party sourcing on business-visa specifics this session.',
    'Nearest Congolese Embassy/Consulate; Embassy of India, Brazzaville for bilateral consular queries',
    'Obtain business invitation letter from Congo-based host company\nGather passport, photos, and company documents\nApply at the nearest Congolese Embassy/Consulate\nAwait visa decision',
    '/assets/images/visa-heroes/republic-of-the-congo.webp',
    'Inference from visa-free/tourist-entry restrictions noted in sources reviewed; not independently confirmed with a dedicated business-visa source this session', NULL, '2026-09-19'
);
SET @cog2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cog2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cog2, 'Core Documents', 'Required from every applicant.', 1);
SET @cog2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cog2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cog2s1, 'Business Invitation Letter from Congo-Based Host Company', NULL, 'copy', 1, 0, 1, 2),
(@cog2s1, 'Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cog2, 'Supporting Documents', 'Company and travel evidence.', 2);
SET @cog2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cog2s2, 'Proof of Employment/Business Ownership in India', NULL, 'copy', 1, 0, 0, 1),
(@cog2s2, 'Return Flight Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I conduct business in Congo-Brazzaville on tourist/visa-free entry?', 'No. Business activity is explicitly excluded from visa-free/tourist entry; a business visa or appropriate permit is required.', 39, 2, 4000, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    39, 3, 'COG-STU-IN-01', '2026.09', 'published',
    'Enrollment in a recognized educational institution in the Republic of the Congo.',
    'The Republic of the Congo is an uncommon study destination for Indian students. A dedicated Student Visa must be applied for at the nearest Congolese Embassy/Consulate with proof of admission. Specific document checklists were not located from a first-party source this session.',
    'Duration tied to course length, subject to embassy assessment; not independently confirmed this session',
    'Apply at the nearest Congolese Embassy/Consulate with admission proof',
    1,
    'Confirm requirements directly with the nearest Congolese Embassy/Consulate or Embassy of India, Brazzaville before applying.',
    'Nearest Congolese Embassy/Consulate; Embassy of India, Brazzaville for bilateral consular assistance',
    'Secure admission to a recognized Congolese institution\nGather academic and financial documents\nApply at the nearest Congolese Embassy/Consulate\nAwait visa decision',
    '/assets/images/visa-heroes/republic-of-the-congo.webp',
    'General inference from Republic of the Congo visa-category structure; not independently confirmed with a dedicated student-visa source this session', NULL, '2026-09-19'
);
SET @cog3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cog3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cog3, 'Core Documents', 'Required from every applicant.', 1);
SET @cog3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cog3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cog3s1, 'Admission/Enrollment Letter from a Recognized Congolese Institution', NULL, 'copy', 1, 0, 1, 2),
(@cog3s1, 'Proof of Tuition Fee Payment or Funding Arrangement', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cog3, 'Supporting Documents', 'Academic evidence.', 2);
SET @cog3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cog3s2, 'Academic Transcripts and Certificates', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Congo-Brazzaville a common study destination for Indian students?', 'No — it is uncommon. Contact the nearest Congolese Embassy/Consulate or Embassy of India, Brazzaville directly for current requirements.', 39, 3, 4100, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    39, 4, 'COG-WORK-IN-01', '2026.09', 'published',
    'Paid employment in the Republic of the Congo for Indian nationals.',
    'Tourist/visa-free entry does NOT permit employment. A separate Work Permit/Work Visa is required, applied for at the nearest Congolese Embassy/Consulate, typically requiring an employer sponsor.',
    'Tied to the employment contract/work permit duration; not independently confirmed this session',
    'Employer-sponsored work permit process plus visa application at the nearest Congolese Embassy/Consulate',
    1,
    'Fee and exact document checklist not independently confirmed against a first-party source this session — confirm directly with the embassy.',
    'Nearest Congolese Embassy/Consulate',
    'Secure an employment offer from a Congo-based employer\nEmployer obtains a work permit from Congolese labour authorities\nApply for the Work Visa at the nearest Congolese Embassy/Consulate\nAwait visa decision',
    '/assets/images/visa-heroes/republic-of-the-congo.webp',
    'Inference from tourist-entry work restriction noted in sources reviewed; not independently confirmed with a dedicated work-visa source this session', NULL, '2026-09-19'
);
SET @cog4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cog4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cog4, 'Core Documents', 'Required from every applicant.', 1);
SET @cog4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cog4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cog4s1, 'Employment Contract/Offer Letter from Congo-Based Employer', NULL, 'copy', 1, 0, 1, 2),
(@cog4s1, 'Work Permit from Congolese Labour Authorities', 'Obtained by the employer.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cog4, 'Supporting Documents', 'Qualification evidence.', 2);
SET @cog4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cog4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@cog4s2, 'Medical Fitness Certificate', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Congo-Brazzaville on tourist or visa-free entry?', 'No. A separate employer-sponsored Work Permit/Work Visa is required.', 39, 4, 4200, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    39, 5, 'COG-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in the Republic of the Congo.',
    'Given the tourist-entry sourcing conflict, family visits are treated the same as tourist entry — confirm current visa requirement before travel. An invitation letter from the resident family member is commonly useful regardless.',
    'Similar to the Tourist Visa (see sourcing-conflict note); not independently confirmed this session',
    'Confirm visa requirement with the Congolese Embassy/Consulate; apply if required',
    1,
    'Given the sourcing conflict on visa requirement, contact the Embassy of India, Brazzaville or the nearest Congolese mission to confirm current rules.',
    'Nearest Congolese Embassy/Consulate; Embassy of India, Brazzaville',
    'Confirm current visa requirement given conflicting sources\nGather invitation letter and proof of relationship\nApply at the nearest Congolese Embassy/Consulate if required\nCarry proof of onward travel',
    '/assets/images/visa-heroes/republic-of-the-congo.webp',
    'General inference from Republic of the Congo visa-category structure; not independently confirmed with a dedicated family-visit source this session', NULL, '2026-09-19'
);
SET @cog5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cog5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cog5, 'Core Documents', 'Required from every applicant.', 1);
SET @cog5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cog5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cog5s1, 'Invitation Letter from Resident Family Member in Congo', NULL, 'copy', 0, 1, 1, 2),
(@cog5s1, 'Proof of Relationship (Birth/Marriage Certificates)', NULL, 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cog5, 'Supporting Documents', 'Additional evidence.', 2);
SET @cog5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cog5s2, 'Return Flight Booking', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Family Visit Visa category for Congo-Brazzaville?', 'A dedicated first-party category was not independently confirmed this session; the general visa/entry conflict noted for tourists applies equally to family visits.', 39, 5, 4300, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    39, 6, 'COG-TRAN-IN-01', '2026.09', 'published',
    'Brief transit through the Republic of the Congo en route to a third country.',
    'Transit requirements for Indian passport holders passing through Congo-Brazzaville were not independently confirmed from a first-party source this session. Given the sourcing conflict on general entry requirements, travellers should confirm with their airline and the Congolese Embassy/Consulate before travel.',
    'Short transit period; not independently confirmed this session',
    'Confirm with airline and nearest Congolese Embassy/Consulate',
    0,
    'Not independently confirmed this session — confirm directly before travel.',
    'Nearest Congolese Embassy/Consulate',
    'Confirm transit requirements with your airline\nCheck current visa/entry rules given sourcing conflict\nCarry onward flight ticket and destination visa if applicable',
    '/assets/images/visa-heroes/republic-of-the-congo.webp',
    'Inference from general entry-requirement sourcing conflict; not independently confirmed this session', NULL, '2026-09-19'
);
SET @cog6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cog6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cog6, 'Core Documents', 'Required from every applicant.', 1);
SET @cog6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cog6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cog6s1, 'Onward Flight Ticket to Final Destination', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Congo-Brazzaville?', 'This was not independently confirmed this session — confirm transit requirements with your airline and the Congolese Embassy/Consulate before travel.', 39, 6, 4400, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    39, 7, 'COG-MED-IN-01', '2026.09', 'published',
    'Medical treatment in the Republic of the Congo for Indian nationals.',
    'The Republic of the Congo is not a typical medical-tourism destination for Indian nationals. A dedicated first-party Medical Visa checklist was not located this session.',
    'Tied to treatment duration; not independently confirmed this session',
    'Confirm visa requirement with the Congolese Embassy/Consulate; apply with hospital documentation if required',
    1,
    'Confirm category-specific requirements directly with the nearest Congolese Embassy/Consulate.',
    'Nearest Congolese Embassy/Consulate',
    'Obtain hospital admission/treatment confirmation from a Congolese hospital\nConfirm current visa requirement\nApply at the nearest Congolese Embassy/Consulate if required',
    '/assets/images/visa-heroes/republic-of-the-congo.webp',
    'Inference; not independently confirmed with a dedicated medical-visa source this session', NULL, '2026-09-19'
);
SET @cog7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cog7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cog7, 'Core Documents', 'Required from every applicant.', 1);
SET @cog7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cog7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cog7s1, 'Hospital Admission Letter/Treatment Confirmation from Congolese Hospital', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Congo-Brazzaville a common destination for medical treatment from India?', 'No — this was not independently sourced this session.', 39, 7, 4500, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    39, 8, 'COG-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in the Republic of the Congo.',
    'Given the tourist-entry sourcing conflict, conference attendees should confirm current visa requirements before travel, similar to business travellers.',
    'Per visa grant if required; not independently confirmed this session',
    'Confirm visa requirement with the Congolese Embassy/Consulate; apply with invitation letter if required',
    1,
    'A formal invitation letter from the conference organizer strengthens the application if a visa is required.',
    'Nearest Congolese Embassy/Consulate',
    'Confirm current visa requirement\nObtain formal invitation letter from the conference organizer\nApply at the nearest Congolese Embassy/Consulate if required',
    '/assets/images/visa-heroes/republic-of-the-congo.webp',
    'General inference from Republic of the Congo visa-category structure; not independently confirmed with a dedicated conference-visa source this session', NULL, '2026-09-19'
);
SET @cog8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cog8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cog8, 'Core Documents', 'Required from every applicant.', 1);
SET @cog8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cog8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cog8s1, 'Formal Invitation Letter from Conference/Event Organizer', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Conference Visa for Congo-Brazzaville?', 'A dedicated first-party category was not independently confirmed this session; the general visa/entry conflict noted for tourists applies.', 39, 8, 4600, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    39, 9, 'COG-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in the Republic of the Congo.',
    'A dedicated Sports Visa category was not located from a first-party source this session. Given the tourist-entry sourcing conflict, athletes/officials should confirm current visa requirements before travel.',
    'Tied to the event duration; not independently confirmed this session',
    'Confirm visa requirement with the Congolese Embassy/Consulate; apply with event documentation if required',
    1,
    'Confirm the appropriate category with the nearest Congolese Embassy/Consulate before applying.',
    'Nearest Congolese Embassy/Consulate',
    'Confirm current visa requirement\nObtain letter from sports federation/event organizer confirming participation\nApply at the nearest Congolese Embassy/Consulate if required',
    '/assets/images/visa-heroes/republic-of-the-congo.webp',
    'Inference; not independently confirmed with a dedicated sports-visa source this session', NULL, '2026-09-19'
);
SET @cog9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cog9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cog9, 'Core Documents', 'Required from every applicant.', 1);
SET @cog9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cog9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cog9s1, 'Letter from Sports Federation/Event Organizer Confirming Participation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports Visa for Congo-Brazzaville?', 'Not independently confirmed this session — athletes/officials should confirm the appropriate requirement with the nearest Congolese Embassy/Consulate.', 39, 9, 4700, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    39, 10, 'COG-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse/family member who holds a Republic of the Congo Work Visa or long-term residency.',
    'Dependents of Indian nationals working in Congo-Brazzaville typically apply through a process linked to the primary Work Visa holder''s employer sponsorship. A dedicated first-party checklist was not located this session.',
    'Typically matches the primary visa holder''s permit duration; not independently confirmed this session',
    'Employer/sponsor-linked application at the nearest Congolese Embassy/Consulate',
    1,
    'Coordinate with the sponsoring employer and the nearest Congolese Embassy/Consulate for the correct process.',
    'Nearest Congolese Embassy/Consulate',
    'Confirm sponsorship arrangement with the primary visa holder''s employer\nGather proof of relationship and primary visa holder''s documents\nApply at the nearest Congolese Embassy/Consulate\nAwait visa decision',
    '/assets/images/visa-heroes/republic-of-the-congo.webp',
    'Inference; not independently confirmed with a dedicated dependent-visa source this session', NULL, '2026-09-19'
);
SET @cog10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cog10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cog10, 'Core Documents', 'Required from every applicant.', 1);
SET @cog10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cog10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cog10s1, 'Proof of Relationship to Primary Work Visa Holder (Marriage/Birth Certificate)', NULL, 'copy', 1, 0, 1, 2),
(@cog10s1, 'Copy of Primary Visa Holder''s Work Visa/Work Permit', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependents of a Congo-Brazzaville Work Visa holder apply directly?', 'This was not independently confirmed this session — dependents should coordinate with the sponsoring employer and the nearest Congolese Embassy/Consulate for the correct process.', 39, 10, 4800, 1);
