-- Rwanda Visa Checklist Engine content for all 10 visa types.
--
-- Rwanda's real, distinctive facts verified this session:
--   - Rwanda offers BOTH a free Visa on Arrival at ports of entry
--     (airports, land borders) AND a paid eVisa (~USD 50, 3-5
--     business-day processing) for Indian citizens — a genuinely
--     visitor-friendly policy among Batch 12 countries.
--   - Visa validity: single-entry, valid 90 days from issue for entry,
--     with a 30-day stay period beginning on arrival.
--   - Government-capped standard visa fees: not exceeding USD 50 for
--     single entry or USD 70 for multiple entry; other visa categories
--     (work, official, etc.) can run up to USD 300 depending on type.
--   - High Commission of India, Kigali (hcikigali.gov.in) publishes its
--     own visa-fee page — a useful first-party bilateral reference.
--   - Recommended application lead time: at least 8 days before
--     departure, even though VOA exists, to allow for document
--     corrections.
--
-- country_id 40 = Rwanda. visa_type_id: 1=Tourist, 2=Business,
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
    40, 1, 'RWA-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Rwanda for Indian citizens.',
    'Indian citizens can obtain a free Visa on Arrival at Rwandan ports of entry, or apply in advance for a paid eVisa (~USD 50, 3-5 business days). Both routes lead to a single-entry visa valid 90 days for entry, with a 30-day stay.',
    '30 days from arrival, single entry, within a 90-day validity window',
    'Apply online for the eVisa in advance, or obtain a free Visa on Arrival at the port of entry',
    0,
    'Applying in advance (at least 8 days before departure) is recommended even though VOA exists, to allow time for any document corrections.',
    'High Commission of India, Kigali (hcikigali.gov.in) for bilateral consular queries; visa issued by Rwandan immigration',
    'Choose between the free VOA or the paid eVisa\nIf eVisa, complete the online application and pay the fee\nGather passport and photo\nIf VOA, present documents at the port of entry\nReceive visa stamp/approval',
    '/assets/images/visa-heroes/rwanda.webp',
    'passportsandvisas.com, migration.gov.rw, hcikigali.gov.in secondary and first-party sourcing', 'https://www.migration.gov.rw/visa/visitors-visa', '2026-09-19'
);
SET @rwa1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rwa1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rwa1, 'Core Documents', 'Required from every applicant.', 1);
SET @rwa1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rwa1s1, 'Valid Passport (6+ Months Validity, 1+ Blank Page)', NULL, 'original', 1, 0, 1, 1),
(@rwa1s1, 'Passport-Size Photograph (Rwanda Visa Specifications)', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rwa1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @rwa1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rwa1s2, 'Confirmed Return/Onward Flight Booking', NULL, 'copy', 1, 0, 0, 1),
(@rwa1s2, 'Hotel/Accommodation Booking Confirmation', NULL, 'copy', 1, 0, 0, 2),
(@rwa1s2, 'Proof of Sufficient Funds', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(40, 1, 50.00, 'USD', 'eVisa/VOA Fee (Single Entry)', 'eVisa costs ~USD 50; Visa on Arrival is free of charge. Multiple-entry visas are capped at USD 70 by Rwandan regulation.', '2026-01-01', NOW(), 'https://www.migration.gov.rw/visa/visitors-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Visa on Arrival available for Indian citizens in Rwanda?', 'Yes. Rwanda offers a free Visa on Arrival at ports of entry, in addition to a paid eVisa option (~USD 50) for advance application.', 40, 1, 4000, 1),
('Should I apply for the eVisa in advance even though VOA is free?', 'It is recommended to apply at least 8 days before departure to allow time for any document corrections, even though VOA exists as a fallback.', 40, 1, 4001, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    40, 2, 'RWA-BUS-IN-01', '2026.09', 'published',
    'Business meetings, conferences, and short-term commercial activity in Rwanda.',
    'Business travellers apply for a dedicated Business Visa via the same eVisa portal or at the High Commission of India, Kigali equivalent process, ideal for shorter business meeting stays per Akbar Travels'' category description.',
    'Per visa grant; single-entry visas typically 30 days, within a 90-day validity window',
    'Apply online via the eVisa portal (Business Visa category)',
    0,
    'A business invitation letter from the Rwandan host company strengthens the application.',
    'Rwanda Directorate General of Immigration and Emigration (migration.gov.rw)',
    'Complete the online eVisa application (Business category)\nGather business invitation letter and company documents\nPay the visa fee\nAwait approval (3-5 business days)',
    '/assets/images/visa-heroes/rwanda.webp',
    'akbartravels.com, migration.gov.rw secondary and first-party sourcing', 'https://www.akbartravels.com/visa/rwanda-visa', '2026-09-19'
);
SET @rwa2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rwa2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rwa2, 'Core Documents', 'Required from every applicant.', 1);
SET @rwa2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rwa2s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@rwa2s1, 'Business Invitation Letter from Rwandan Host Company', NULL, 'copy', 1, 0, 1, 2),
(@rwa2s1, 'Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rwa2, 'Supporting Documents', 'Company and travel evidence.', 2);
SET @rwa2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rwa2s2, 'Proof of Employment/Business Ownership in India', NULL, 'copy', 1, 0, 0, 1),
(@rwa2s2, 'Return Flight Booking and Accommodation Confirmation', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(40, 2, 50.00, 'USD', 'Business Visa Fee (Single Entry)', 'Standard single-entry visa fee capped at USD 50 by Rwandan regulation.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/rwanda-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use the tourist eVisa for business meetings in Rwanda?', 'A dedicated Business Visa category exists and is recommended for business travel; select the correct category on the eVisa portal.', 40, 2, 4100, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    40, 3, 'RWA-STU-IN-01', '2026.09', 'published',
    'Enrollment in a recognized educational institution in Rwanda.',
    'Rwanda offers a dedicated Student/Research Visa category, applied for with proof of admission to a recognized Rwandan institution. Specific document checklists beyond standard visa requirements were not fully itemized by a first-party source this session.',
    'Duration tied to course length, subject to immigration assessment; not independently confirmed this session',
    'Apply via the Rwanda Directorate General of Immigration and Emigration with admission proof',
    1,
    'Confirm requirements directly with Rwandan immigration authorities or the High Commission of India, Kigali before applying.',
    'Rwanda Directorate General of Immigration and Emigration; High Commission of India, Kigali (hcikigali.gov.in)',
    'Secure admission to a recognized Rwandan institution\nGather academic and financial documents\nApply via the Student/Research Visa category\nAwait visa decision',
    '/assets/images/visa-heroes/rwanda.webp',
    'migration.gov.rw category listing; not independently confirmed with a dedicated student-visa document checklist this session', NULL, '2026-09-19'
);
SET @rwa3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rwa3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rwa3, 'Core Documents', 'Required from every applicant.', 1);
SET @rwa3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rwa3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@rwa3s1, 'Admission/Enrollment Letter from a Recognized Rwandan Institution', NULL, 'copy', 1, 0, 1, 2),
(@rwa3s1, 'Proof of Tuition Fee Payment or Funding Arrangement', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rwa3, 'Supporting Documents', 'Academic evidence.', 2);
SET @rwa3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rwa3s2, 'Academic Transcripts and Certificates', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Rwanda have a dedicated Student Visa category?', 'Yes, a Student/Research Visa category is listed by Rwandan immigration authorities, though the full document checklist was not independently itemized this session.', 40, 3, 4200, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    40, 4, 'RWA-WORK-IN-01', '2026.09', 'published',
    'Paid employment in Rwanda for Indian nationals.',
    'The Rwanda Work Visa/Work Permit is issued to foreign nationals taking up employment or paid professional activity, distinct from the tourist eVisa/VOA. Requires an employment letter and financial proof; fees for this category can run up to USD 300 depending on permit type.',
    'Tied to the employment contract/work permit duration',
    'Employer-sponsored application via Rwanda immigration authorities',
    1,
    'Work-category fees range up to USD 300 depending on permit type — confirm the exact figure for your specific permit with Rwandan immigration.',
    'Rwanda Directorate General of Immigration and Emigration',
    'Secure an employment offer from a Rwanda-based employer\nGather employment letter and financial proof documents\nApply for the Work Permit/Work Visa\nAwait visa decision',
    '/assets/images/visa-heroes/rwanda.webp',
    'akbartravels.com, globalization-partners.com secondary sourcing on Rwanda work-visa category', 'https://www.akbartravels.com/in/visas/rwanda-work-visa', '2026-09-19'
);
SET @rwa4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rwa4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rwa4, 'Core Documents', 'Required from every applicant.', 1);
SET @rwa4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rwa4s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@rwa4s1, 'Employment Letter from Rwanda-Based Employer', NULL, 'copy', 1, 0, 1, 2),
(@rwa4s1, 'Financial Proof', NULL, 'copy', 1, 0, 1, 3),
(@rwa4s1, 'Photograph Matching Rwanda Visa Photo Specifications', NULL, 'copy', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rwa4, 'Supporting Documents', 'Qualification evidence.', 2);
SET @rwa4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rwa4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(40, 4, 300.00, 'USD', 'Work Visa/Permit Fee (Upper Estimate)', 'Rwanda work-category visa fees range from USD 50 to USD 300 depending on permit type — confirm the exact figure for your specific case with Rwandan immigration.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/rwanda-work-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Rwanda on the tourist eVisa or VOA?', 'No. A separate Work Visa/Work Permit is required for employment or paid professional activity.', 40, 4, 4300, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    40, 5, 'RWA-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Rwanda.',
    'Indian nationals visiting family in Rwanda can use the same free VOA or paid eVisa (Visit Visa category) used for tourism. An invitation letter from the resident family member supports the application.',
    '30 days from arrival, single entry, within a 90-day validity window',
    'Apply online via the eVisa portal (Visit Visa category), or obtain a free Visa on Arrival',
    0,
    'A letter of invitation from the resident family member, along with proof of relationship, strengthens the application.',
    'Rwanda Directorate General of Immigration and Emigration',
    'Choose between the free VOA or the paid eVisa\nGather invitation letter and proof of relationship\nComplete the application or present documents at the port of entry\nReceive visa stamp/approval',
    '/assets/images/visa-heroes/rwanda.webp',
    'migration.gov.rw visitors-visa category listing', 'https://www.migration.gov.rw/visa/visitors-visa', '2026-09-19'
);
SET @rwa5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rwa5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rwa5, 'Core Documents', 'Required from every applicant.', 1);
SET @rwa5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rwa5s1, 'Valid Passport (6+ Months Validity, 1+ Blank Page)', NULL, 'original', 1, 0, 1, 1),
(@rwa5s1, 'Invitation Letter from Resident Family Member in Rwanda', NULL, 'copy', 1, 0, 1, 2),
(@rwa5s1, 'Proof of Relationship (Birth/Marriage Certificates)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rwa5, 'Supporting Documents', 'Additional evidence.', 2);
SET @rwa5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rwa5s2, 'Return Flight Booking', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Family Visit Visa category for Rwanda?', 'The "Visit Visa" category listed by Rwandan immigration covers general visits including family visits, using the same VOA/eVisa process as tourism.', 40, 5, 4400, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    40, 6, 'RWA-TRAN-IN-01', '2026.09', 'published',
    'Brief transit through Rwanda en route to a third country.',
    'Rwanda lists a dedicated Transit Visa category among its visa types. Specific fee and document requirements for this category were not independently itemized by a first-party source this session.',
    'Short transit period, typically under 24-72 hours; not independently confirmed this session',
    'Apply via the Rwanda immigration authorities (Transit Visa category) or confirm with airline',
    0,
    'Confirm current transit-visa requirements directly with Rwandan immigration authorities or your airline before travel.',
    'Rwanda Directorate General of Immigration and Emigration',
    'Confirm transit requirements with your airline\nApply for the Transit Visa category if required\nCarry onward flight ticket and destination visa if applicable',
    '/assets/images/visa-heroes/rwanda.webp',
    'akbartravels.com visa-category listing mentioning Transit Visa; fee/documents not independently confirmed this session', NULL, '2026-09-19'
);
SET @rwa6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rwa6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rwa6, 'Core Documents', 'Required from every applicant.', 1);
SET @rwa6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rwa6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@rwa6s1, 'Onward Flight Ticket to Final Destination', NULL, 'copy', 1, 0, 1, 2),
(@rwa6s1, 'Visa for Final Destination Country', NULL, 'copy', 0, 1, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Rwanda have a dedicated Transit Visa?', 'Yes, a Transit Visa category is listed among Rwandan visa types, though specific fee/document details were not independently confirmed this session.', 40, 6, 4500, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    40, 7, 'RWA-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Rwanda for Indian nationals.',
    'Rwanda is not a typical medical-tourism destination for Indian nationals (the reverse flow — Rwandan patients travelling to India — is more common). A dedicated first-party Medical Visa checklist was not located this session; the standard VOA/eVisa process with hospital documentation would likely apply.',
    'Tied to treatment duration, within visa validity; not independently confirmed this session',
    'Apply via the eVisa portal or VOA, with hospital documentation',
    0,
    'Confirm category-specific requirements directly with Rwandan immigration authorities.',
    'Rwanda Directorate General of Immigration and Emigration',
    'Obtain hospital admission/treatment confirmation from a Rwandan hospital\nApply via the eVisa portal or VOA\nGather proof of funds for treatment and stay',
    '/assets/images/visa-heroes/rwanda.webp',
    'Inference; not independently confirmed with a dedicated medical-visa source this session', NULL, '2026-09-19'
);
SET @rwa7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rwa7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rwa7, 'Core Documents', 'Required from every applicant.', 1);
SET @rwa7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rwa7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@rwa7s1, 'Hospital Admission Letter/Treatment Confirmation from Rwandan Hospital', NULL, 'copy', 1, 0, 1, 2),
(@rwa7s1, 'Proof of Funds for Treatment and Stay', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Rwanda a common destination for medical treatment from India?', 'No — the more common flow is Rwandan patients seeking treatment in India. This category is included for completeness but was not independently sourced this session.', 40, 7, 4600, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    40, 8, 'RWA-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Rwanda. Rwanda is a notable regional conference hub (Kigali hosts many international summits).',
    'Indian delegates apply via the Business Visa category on the eVisa portal, or use VOA, with a formal invitation letter from the conference organizer.',
    '30 days from arrival, single entry, within a 90-day validity window',
    'Apply online via the eVisa portal (Business Visa category), or obtain a free Visa on Arrival',
    0,
    'A formal invitation letter from the conference organizer strengthens the application.',
    'Rwanda Directorate General of Immigration and Emigration',
    'Obtain formal invitation letter from the conference organizer\nGather proof of event registration\nApply via eVisa (Business category) or use VOA\nAwait approval',
    '/assets/images/visa-heroes/rwanda.webp',
    'General inference from Rwanda''s visa-category structure and its status as a regional conference hub', NULL, '2026-09-19'
);
SET @rwa8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rwa8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rwa8, 'Core Documents', 'Required from every applicant.', 1);
SET @rwa8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rwa8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@rwa8s1, 'Formal Invitation Letter from Conference/Event Organizer', NULL, 'copy', 1, 0, 1, 2),
(@rwa8s1, 'Proof of Event Registration', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Rwanda a common conference destination?', 'Yes — Kigali hosts numerous international summits and conferences, making Rwanda a notable regional conference hub.', 40, 8, 4700, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    40, 9, 'RWA-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Rwanda.',
    'A dedicated Sports Visa category for Rwanda was not located from a first-party source this session. Indian athletes/officials would likely apply via VOA or the eVisa Business/Visit category with event-specific documentation.',
    'Tied to the event duration, within visa validity',
    'Apply via VOA or the eVisa portal, with event documentation',
    0,
    'Confirm the appropriate category with Rwandan immigration authorities before applying.',
    'Rwanda Directorate General of Immigration and Emigration',
    'Obtain letter from sports federation/event organizer confirming participation\nApply via VOA or eVisa\nGather proof of accommodation and travel arrangements',
    '/assets/images/visa-heroes/rwanda.webp',
    'Inference; not independently confirmed with a dedicated sports-visa source this session', NULL, '2026-09-19'
);
SET @rwa9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rwa9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rwa9, 'Core Documents', 'Required from every applicant.', 1);
SET @rwa9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rwa9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@rwa9s1, 'Letter from Sports Federation/Event Organizer Confirming Participation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports Visa for Rwanda?', 'Not independently confirmed this session — athletes/officials should confirm the appropriate category with Rwandan immigration authorities.', 40, 9, 4800, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    40, 10, 'RWA-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse/family member who holds a Rwanda Work Visa or long-term residency.',
    'Dependents of Indian nationals working in Rwanda typically apply through a process linked to the primary Work Visa holder''s employer sponsorship. A dedicated first-party checklist was not located this session.',
    'Typically matches the primary visa holder''s permit duration; not independently confirmed this session',
    'Employer/sponsor-linked application via Rwanda immigration authorities',
    1,
    'Coordinate with the sponsoring employer and Rwandan immigration authorities for the correct process.',
    'Rwanda Directorate General of Immigration and Emigration',
    'Confirm sponsorship arrangement with the primary visa holder''s employer\nGather proof of relationship and primary visa holder''s documents\nApply via Rwanda immigration authorities\nAwait visa decision',
    '/assets/images/visa-heroes/rwanda.webp',
    'Inference; not independently confirmed with a dedicated dependent-visa source this session', NULL, '2026-09-19'
);
SET @rwa10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rwa10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rwa10, 'Core Documents', 'Required from every applicant.', 1);
SET @rwa10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rwa10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@rwa10s1, 'Proof of Relationship to Primary Work Visa Holder (Marriage/Birth Certificate)', NULL, 'copy', 1, 0, 1, 2),
(@rwa10s1, 'Copy of Primary Visa Holder''s Work Visa/Work Permit', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependents of a Rwanda Work Visa holder apply directly?', 'This was not independently confirmed this session — dependents should coordinate with the sponsoring employer and Rwandan immigration authorities for the correct process.', 40, 10, 4900, 1);
