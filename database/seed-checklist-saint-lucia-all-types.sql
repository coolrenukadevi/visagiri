-- Saint Lucia Visa Checklist Engine content for all 10 visa types.
--
-- Saint Lucia's real, distinctive facts verified this session:
--   - SOURCING CONFLICT (flagged, not silently resolved): some sources
--     state Indian citizens can enter visa-free for up to 6 weeks;
--     others state a visa IS required for tourism/business, available
--     as a Visa on Arrival, with Akbar Travels listing single-entry
--     (~Rs. 4,899, 3-month permission) and multiple-entry (~Rs. 6,799,
--     6-month permission) fees. Given a specific fee schedule is cited
--     by a travel agency source, this checklist treats a visa as
--     likely required (obtainable on arrival) and recommends
--     travellers verify current visa-free eligibility directly with
--     the Honorary Consulate of Saint Lucia in New Delhi before
--     assuming visa-free entry.
--   - Work permits are issued by the Department of Labour, with a
--     modest application fee of EC$100 — a distinctively low,
--     specifically-sourced figure among Batch 12 countries.
--   - A standard visitor visa/visa-free entry does NOT permit
--     employment.
--
-- country_id 177 = Saint Lucia. visa_type_id: 1=Tourist, 2=Business,
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
    177, 1, 'LCA-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Saint Lucia for Indian citizens.',
    'SOURCING CONFLICT: some sources describe visa-free entry up to 6 weeks; others state a visa is required, obtainable as a Visa on Arrival, with fees of ~Rs. 4,899 (single entry, 3 months) or ~Rs. 6,799 (multiple entry, 6 months). Verify current requirements directly before travel.',
    'Up to 6 weeks if visa-free applies; otherwise up to 3 months (single entry) or 6 months (multiple entry) per visa granted',
    'Confirm current requirement with the Honorary Consulate of Saint Lucia, New Delhi; if a visa is required, obtain it on arrival or apply in advance',
    0,
    'Given the sourcing conflict, carry all standard visa documents in case a Visa on Arrival application is required at the port of entry.',
    'Honorary Consulate of Saint Lucia, New Delhi (for bilateral queries); visa on arrival issued by Saint Lucian immigration',
    'Confirm current visa-free/visa-required status given conflicting sources\nGather passport, return ticket, and accommodation proof\nIf a visa is required, complete the Visa on Arrival application at the port of entry or apply in advance\nPresent documents to immigration',
    '/assets/images/visa-heroes/saint-lucia.webp',
    'akbartravels.com, atlys.com, embassyinformation.com (conflicting on visa-free status)', 'https://www.akbartravels.com/visa/saintlucia-visa', '2026-09-19'
);
SET @lca1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lca1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lca1, 'Core Documents', 'Required from every applicant.', 1);
SET @lca1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lca1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lca1s1, 'Passport-Size Photograph (If Visa Required)', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lca1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lca1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lca1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@lca1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 2),
(@lca1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(177, 1, 4899.00, 'INR', 'Single-Entry Tourist Visa Fee (If Required)', 'Approx. Rs. 4,899 for single entry (3-month permission); Rs. 6,799 for multiple entry (6-month permission). Some sources describe visa-free entry instead — verify before paying.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/saintlucia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Saint Lucia?', 'Sources disagree: some describe visa-free entry for up to 6 weeks, while others state a visa is required (obtainable on arrival) with specific fees listed. This was not independently reconciled this session — confirm directly with the Honorary Consulate of Saint Lucia, New Delhi before travel.', 177, 1, 17700, 1),
('Can I obtain a Saint Lucia visa on arrival?', 'Some sources indicate Visa on Arrival is available for Indian citizens at the port of entry, if a visa is indeed required — confirm this directly before travel.', 177, 1, 17701, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    177, 2, 'LCA-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Saint Lucia.',
    'The same visa/visa-free sourcing conflict applies to business travel as tourism; a business invitation letter is recommended as supporting evidence.',
    'Up to 6 weeks if visa-free applies; otherwise per visa granted (see Tourist Visa note)',
    'Confirm current requirement with the Honorary Consulate of Saint Lucia, New Delhi',
    0,
    'Given the sourcing conflict, carry a business invitation letter and standard visa documents.',
    'Honorary Consulate of Saint Lucia, New Delhi',
    'Confirm current visa-free/visa-required status\nGather business invitation letter and company documents\nApply for the visa if required, or present documents at the port of entry',
    '/assets/images/visa-heroes/saint-lucia.webp',
    'akbartravels.com secondary sourcing (tourism/business visa fees listed together)', NULL, '2026-09-19'
);
SET @lca2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lca2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lca2, 'Core Documents', 'Required from every applicant.', 1);
SET @lca2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lca2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lca2s1, 'Business Invitation Letter from Saint Lucia Host Company', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lca2, 'Supporting Documents', 'Company evidence.', 2);
SET @lca2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lca2s2, 'Proof of Employment/Business Ownership in India', NULL, 'copy', 1, 0, 0, 1),
(@lca2s2, 'Return Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Saint Lucia business visa fee the same as the tourist visa?', 'Akbar Travels lists tourism and business visa fees together (~Rs. 4,899 single entry / ~Rs. 6,799 multiple entry) — though the general visa-free-vs-visa-required conflict applies here too.', 177, 2, 17800, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    177, 3, 'LCA-STU-IN-01', '2026.09', 'published',
    'Enrollment in a recognized educational institution in Saint Lucia.',
    'Saint Lucia is an uncommon study destination for Indian students. A dedicated Student Visa must be applied for with proof of admission. Specific document checklists were not located from a first-party source this session.',
    'Duration tied to course length, subject to immigration assessment; not independently confirmed this session',
    'Apply via the Honorary Consulate of Saint Lucia, New Delhi with admission proof',
    1,
    'Confirm requirements directly with the institution and Saint Lucian immigration authorities before applying.',
    'Honorary Consulate of Saint Lucia, New Delhi',
    'Secure admission to a recognized Saint Lucian institution\nGather academic and financial documents\nApply for the Student Visa\nAwait visa decision',
    '/assets/images/visa-heroes/saint-lucia.webp',
    'General inference from Saint Lucia visa-category structure; not independently confirmed with a dedicated student-visa source this session', NULL, '2026-09-19'
);
SET @lca3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lca3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lca3, 'Core Documents', 'Required from every applicant.', 1);
SET @lca3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lca3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lca3s1, 'Admission/Enrollment Letter from a Recognized Institution', NULL, 'copy', 1, 0, 1, 2),
(@lca3s1, 'Proof of Tuition Fee Payment or Funding Arrangement', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lca3, 'Supporting Documents', 'Academic evidence.', 2);
SET @lca3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lca3s2, 'Academic Transcripts and Certificates', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Saint Lucia a common study destination for Indian students?', 'No — it is uncommon. Contact the Honorary Consulate of Saint Lucia, New Delhi directly for current requirements.', 177, 3, 17900, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    177, 4, 'LCA-WORK-IN-01', '2026.09', 'published',
    'Paid employment in Saint Lucia for Indian nationals.',
    'A standard visitor visa or visa-free entry does NOT permit employment. Any non-citizen wishing to work in Saint Lucia must obtain a work permit from the Department of Labour before commencing employment, with a modest application fee of EC$100.',
    'Tied to the employment contract/work permit duration',
    'Employer-sponsored work permit application through the Department of Labour',
    1,
    'Apply well in advance through the Saint Lucia embassy/consulate, as a standard visitor visa does not cover employment.',
    'Department of Labour, Saint Lucia; Honorary Consulate of Saint Lucia, New Delhi',
    'Secure an employment offer from a Saint Lucia-based employer\nEmployer/applicant applies for a work permit from the Department of Labour\nPay the EC$100 application fee\nGather qualification documents\nAwait work-permit decision',
    '/assets/images/visa-heroes/saint-lucia.webp',
    'stlucia.studio (St. Lucia Business Guide) secondary sourcing on work-permit process', 'https://stlucia.studio/immigration', '2026-09-19'
);
SET @lca4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lca4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lca4, 'Core Documents', 'Required from every applicant.', 1);
SET @lca4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lca4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lca4s1, 'Employment Offer Letter from Saint Lucia-Based Employer', NULL, 'copy', 1, 0, 1, 2),
(@lca4s1, 'Work Permit Application (Department of Labour)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lca4, 'Supporting Documents', 'Qualification evidence.', 2);
SET @lca4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lca4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(177, 4, 100.00, 'XCD', 'Work Permit Application Fee', 'EC$100 application fee, payable to the Department of Labour.', '2026-01-01', NOW(), 'https://stlucia.studio/immigration', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Saint Lucia on a standard visitor visa?', 'No. A standard visitor visa or visa-free entry does not permit employment; a separate work permit from the Department of Labour (EC$100 fee) is required.', 177, 4, 18000, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    177, 5, 'LCA-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Saint Lucia.',
    'Indian nationals visiting family use the same visa/visa-free framework as tourists (see Tourist Visa sourcing-conflict note); an invitation letter from the resident family member supports the application.',
    'Up to 6 weeks if visa-free applies; otherwise per visa granted',
    'Confirm current requirement with the Honorary Consulate of Saint Lucia, New Delhi',
    0,
    'Given the sourcing conflict, carry all standard documents in case a visa application is required.',
    'Honorary Consulate of Saint Lucia, New Delhi',
    'Confirm current visa-free/visa-required status\nGather invitation letter and proof of relationship\nApply for the visa if required, or present documents at the port of entry',
    '/assets/images/visa-heroes/saint-lucia.webp',
    'General inference from Saint Lucia visa-category structure', NULL, '2026-09-19'
);
SET @lca5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lca5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lca5, 'Core Documents', 'Required from every applicant.', 1);
SET @lca5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lca5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lca5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 0, 1, 1, 2),
(@lca5s1, 'Proof of Relationship (Birth/Marriage Certificates)', NULL, 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lca5, 'Supporting Documents', 'Additional evidence.', 2);
SET @lca5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lca5s2, 'Return Flight Ticket', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Family Visit Visa for Saint Lucia?', 'A dedicated first-party category was not independently confirmed this session; the same visa/visa-free framework used for tourism applies.', 177, 5, 18100, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    177, 6, 'LCA-TRAN-IN-01', '2026.09', 'published',
    'Brief transit through Saint Lucia en route to a third country.',
    'Transit requirements for Indian passport holders were not independently confirmed from a first-party source this session. Given the general visa-requirement sourcing conflict, travellers should confirm with their airline before travel.',
    'Short transit period; not independently confirmed this session',
    'Confirm with airline and, if needed, the Honorary Consulate of Saint Lucia, New Delhi',
    0,
    'Not independently confirmed this session — confirm directly before travel.',
    'Honorary Consulate of Saint Lucia, New Delhi',
    'Confirm transit requirements with your airline\nCheck current visa/entry rules given sourcing conflict\nCarry onward flight ticket and destination visa if applicable',
    '/assets/images/visa-heroes/saint-lucia.webp',
    'Inference from general entry-requirement sourcing conflict; not independently confirmed this session', NULL, '2026-09-19'
);
SET @lca6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lca6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lca6, 'Core Documents', 'Required from every applicant.', 1);
SET @lca6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lca6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lca6s1, 'Onward Flight Ticket to Final Destination', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Saint Lucia?', 'This was not independently confirmed this session — confirm transit requirements with your airline before travel.', 177, 6, 18200, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    177, 7, 'LCA-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Saint Lucia for Indian nationals.',
    'Saint Lucia is not a typical medical-tourism destination for Indian nationals. A dedicated first-party Medical Visa checklist was not located this session; the standard visa/visa-free process with hospital documentation would likely apply.',
    'Tied to treatment duration; not independently confirmed this session',
    'Confirm visa requirement with the Honorary Consulate of Saint Lucia, New Delhi; apply with hospital documentation if required',
    0,
    'Confirm category-specific requirements directly with the Honorary Consulate of Saint Lucia, New Delhi.',
    'Honorary Consulate of Saint Lucia, New Delhi',
    'Obtain hospital admission/treatment confirmation from a Saint Lucian hospital\nConfirm current visa requirement\nApply for the visa if required',
    '/assets/images/visa-heroes/saint-lucia.webp',
    'Inference; not independently confirmed with a dedicated medical-visa source this session', NULL, '2026-09-19'
);
SET @lca7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lca7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lca7, 'Core Documents', 'Required from every applicant.', 1);
SET @lca7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lca7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lca7s1, 'Hospital Admission Letter/Treatment Confirmation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Saint Lucia a common destination for medical treatment from India?', 'No — this was not independently sourced this session.', 177, 7, 18300, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    177, 8, 'LCA-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Saint Lucia.',
    'Conference attendees likely use the same visa/visa-free framework as business travellers (see Tourist/Business Visa sourcing-conflict note).',
    'Up to 6 weeks if visa-free applies; otherwise per visa granted',
    'Confirm current requirement with the Honorary Consulate of Saint Lucia, New Delhi',
    0,
    'A formal invitation letter from the conference organizer is recommended supporting evidence.',
    'Honorary Consulate of Saint Lucia, New Delhi',
    'Confirm current visa-free/visa-required status\nObtain formal invitation letter from the conference organizer\nApply for the visa if required',
    '/assets/images/visa-heroes/saint-lucia.webp',
    'General inference from Saint Lucia visa-category structure', NULL, '2026-09-19'
);
SET @lca8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lca8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lca8, 'Core Documents', 'Required from every applicant.', 1);
SET @lca8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lca8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lca8s1, 'Formal Invitation Letter from Conference/Event Organizer', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Conference Visa for Saint Lucia?', 'A dedicated first-party category was not independently confirmed this session; the same visa/visa-free framework applies.', 177, 8, 18400, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    177, 9, 'LCA-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Saint Lucia.',
    'A dedicated Sports Visa category was not located from a first-party source this session. Indian athletes/officials would likely use the same visa/visa-free framework as tourists.',
    'Up to 6 weeks if visa-free applies; otherwise per visa granted',
    'Confirm current requirement with the Honorary Consulate of Saint Lucia, New Delhi',
    0,
    'Confirm the appropriate category with the Honorary Consulate of Saint Lucia, New Delhi before applying.',
    'Honorary Consulate of Saint Lucia, New Delhi',
    'Confirm current visa-free/visa-required status\nObtain letter from sports federation/event organizer confirming participation\nApply for the visa if required',
    '/assets/images/visa-heroes/saint-lucia.webp',
    'Inference; not independently confirmed with a dedicated sports-visa source this session', NULL, '2026-09-19'
);
SET @lca9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lca9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lca9, 'Core Documents', 'Required from every applicant.', 1);
SET @lca9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lca9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lca9s1, 'Letter from Sports Federation/Event Organizer Confirming Participation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports Visa for Saint Lucia?', 'Not independently confirmed this session — athletes/officials should confirm the appropriate requirement with the Honorary Consulate of Saint Lucia, New Delhi.', 177, 9, 18500, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    177, 10, 'LCA-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse/family member who holds a Saint Lucia work permit or long-term residency.',
    'Dependents of Indian nationals working in Saint Lucia typically apply through a process linked to the primary work-permit holder''s employer sponsorship. A dedicated first-party checklist was not located this session.',
    'Typically matches the primary permit holder''s duration; not independently confirmed this session',
    'Employer/sponsor-linked application through the Department of Labour or Honorary Consulate',
    1,
    'Coordinate with the sponsoring employer and the Department of Labour for the correct process.',
    'Department of Labour, Saint Lucia; Honorary Consulate of Saint Lucia, New Delhi',
    'Confirm sponsorship arrangement with the primary permit holder''s employer\nGather proof of relationship and primary permit holder''s documents\nApply through the Department of Labour\nAwait decision',
    '/assets/images/visa-heroes/saint-lucia.webp',
    'Inference; not independently confirmed with a dedicated dependent-visa source this session', NULL, '2026-09-19'
);
SET @lca10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lca10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lca10, 'Core Documents', 'Required from every applicant.', 1);
SET @lca10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lca10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lca10s1, 'Proof of Relationship to Primary Permit Holder (Marriage/Birth Certificate)', NULL, 'copy', 1, 0, 1, 2),
(@lca10s1, 'Copy of Primary Permit Holder''s Work Permit', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependents of a Saint Lucia work-permit holder apply directly?', 'This was not independently confirmed this session — dependents should coordinate with the sponsoring employer and the Department of Labour for the correct process.', 177, 10, 18600, 1);
