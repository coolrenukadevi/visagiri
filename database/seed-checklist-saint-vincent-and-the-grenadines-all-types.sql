-- Saint Vincent and the Grenadines Visa Checklist Engine content for
-- all 10 visa types.
--
-- Saint Vincent and the Grenadines's real, distinctive facts verified
-- this session:
--   - India's Ministry of External Affairs (MEA) has a published
--     bilateral visa-exemption agreement with Saint Vincent and the
--     Grenadines (mea.gov.in), confirming visa-free entry for
--     tourism/visit/business purposes — one of the stronger first-party
--     confirmations found in Batch 12.
--   - SOURCING CONFLICT (minor, flagged): permitted stay duration is
--     reported as up to 90 days by some sources and up to 1 month by
--     others, with the final duration determined by immigration
--     officials on arrival. The 90-day figure aligns with the general
--     pattern of Caribbean visa-exemption agreements, but travellers
--     should not assume more than what the immigration officer grants
--     on arrival.
--   - Visa-free entry is for tourism/visit/business only; employment
--     requires a separate work permit/visa. A visa fee of EC$200 is
--     cited for those who DO need a visa (i.e., non-exempt purposes or
--     circumstances).
--   - Passport must be valid at least 120 days beyond the date of entry
--     per one source.
--
-- country_id 178 = Saint Vincent and the Grenadines. visa_type_id:
-- 1=Tourist, 2=Business, 3=Student, 4=Work, 5=Family Visit, 6=Transit,
-- 7=Medical, 8=Conference, 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    178, 1, 'VCT-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Saint Vincent and the Grenadines for Indian citizens.',
    'Indian citizens enjoy visa-free entry for tourism, confirmed by a published MEA bilateral visa-exemption agreement. Stay duration is reported as up to 90 days by some sources and up to 1 month by others — the immigration officer on arrival determines the final duration granted.',
    'Up to 90 days (per some sources) or up to 1 month (per others), as determined by immigration on arrival',
    'No visa required for tourism; simply present documents at the port of entry',
    0,
    'Duration figures vary across sources (90 days vs. 1 month) — do not assume the longer figure; confirm the stay granted with the immigration officer on arrival.',
    'Consulate/Honorary Consul of Saint Vincent and the Grenadines accredited to India; MEA visa-exemption agreement (mea.gov.in)',
    'Confirm passport validity of 120+ days beyond entry\nGather proof of accommodation and return ticket\nGather proof of sufficient funds\nPresent documents to immigration on arrival\nNote the stay duration granted',
    '/assets/images/visa-heroes/saint-vincent-and-the-grenadines.webp',
    'MEA visa-exemption agreement (mea.gov.in), peninsulavisa.com, hinterlandtravel.com', 'https://www.mea.gov.in/Images/CPV/visa-exemption/Agreement_copy_of_SVG.pdf', '2026-09-19'
);
SET @vct1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vct1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vct1, 'Core Documents', 'Required from every applicant.', 1);
SET @vct1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vct1s1, 'Valid Passport (120+ Days Beyond Entry Date)', NULL, 'original', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vct1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @vct1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vct1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@vct1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 2),
(@vct1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Saint Vincent and the Grenadines?', 'No. India''s Ministry of External Affairs has a published bilateral visa-exemption agreement with Saint Vincent and the Grenadines confirming visa-free entry for tourism purposes.', 178, 1, 17800, 1),
('How long can Indian citizens stay visa-free?', 'Sources report up to 90 days or up to 1 month — the immigration officer on arrival determines the final duration. Do not assume the longer figure without confirmation.', 178, 1, 17801, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    178, 2, 'VCT-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Saint Vincent and the Grenadines.',
    'Business visits are explicitly covered by the same visa-exemption arrangement as tourism, per sources reviewed (tourism, visit, or business purposes).',
    'Up to 90 days (per some sources) or up to 1 month (per others), as determined by immigration on arrival',
    'No visa required for business visits; simply present documents at the port of entry',
    0,
    'A business invitation letter is recommended as supporting evidence though not confirmed mandatory this session.',
    'Consulate/Honorary Consul of Saint Vincent and the Grenadines accredited to India',
    'Gather business invitation letter and company documents\nGather proof of accommodation and return ticket\nPresent documents to immigration on arrival',
    '/assets/images/visa-heroes/saint-vincent-and-the-grenadines.webp',
    'visitworld.today, MEA visa-exemption agreement (mea.gov.in)', 'https://www.mea.gov.in/Images/CPV/visa-exemption/Agreement_copy_of_SVG.pdf', '2026-09-19'
);
SET @vct2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vct2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vct2, 'Core Documents', 'Required from every applicant.', 1);
SET @vct2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vct2s1, 'Valid Passport (120+ Days Beyond Entry Date)', NULL, 'original', 1, 0, 1, 1),
(@vct2s1, 'Business Invitation Letter', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vct2, 'Supporting Documents', 'Company and travel evidence.', 2);
SET @vct2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vct2s2, 'Proof of Employment/Business Ownership in India', NULL, 'copy', 1, 0, 0, 1),
(@vct2s2, 'Return Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a separate visa needed for business travel to Saint Vincent and the Grenadines?', 'No — the same visa-exemption arrangement covers tourism, visit, and business purposes.', 178, 2, 17900, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    178, 3, 'VCT-STU-IN-01', '2026.09', 'published',
    'Enrollment in a recognized educational institution in Saint Vincent and the Grenadines.',
    'The visa-exemption agreement covers tourism, visit, and business — long-term study likely requires a separate Student Visa/permit beyond the visa-free arrangement. Specific document checklists were not located from a first-party source this session.',
    'Duration tied to course length, subject to immigration assessment; not independently confirmed this session',
    'Apply via the nearest Saint Vincent and the Grenadines mission with admission proof',
    1,
    'Confirm requirements directly with the institution and Vincentian immigration authorities before applying.',
    'Nearest Saint Vincent and the Grenadines mission',
    'Secure admission to a recognized institution\nGather academic and financial documents\nApply for the Student Visa/permit\nAwait visa decision',
    '/assets/images/visa-heroes/saint-vincent-and-the-grenadines.webp',
    'General inference from Saint Vincent and the Grenadines visa-category structure; not independently confirmed with a dedicated student-visa source this session', NULL, '2026-09-19'
);
SET @vct3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vct3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vct3, 'Core Documents', 'Required from every applicant.', 1);
SET @vct3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vct3s1, 'Valid Passport (120+ Days Beyond Entry Date)', NULL, 'original', 1, 0, 1, 1),
(@vct3s1, 'Admission/Enrollment Letter from a Recognized Institution', NULL, 'copy', 1, 0, 1, 2),
(@vct3s1, 'Proof of Tuition Fee Payment or Funding Arrangement', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vct3, 'Supporting Documents', 'Academic evidence.', 2);
SET @vct3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vct3s2, 'Academic Transcripts and Certificates', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Saint Vincent and the Grenadines a common study destination for Indian students?', 'No — it is uncommon, and long-term study likely requires a separate Student Visa beyond the tourism visa-exemption. Contact the nearest mission directly for current requirements.', 178, 3, 18000, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    178, 4, 'VCT-WORK-IN-01', '2026.09', 'published',
    'Paid employment in Saint Vincent and the Grenadines for Indian nationals.',
    'Visa-free entry does NOT extend to employment. Working, volunteering for pay, or business activity is not permitted on tourist entry — a separate work permit/visa is required. A visa fee of EC$200 is cited for those requiring a visa (such as for employment purposes).',
    'Tied to the employment contract/work permit duration',
    'Employer-sponsored work permit application through Vincentian labour authorities',
    1,
    'Fee cited at EC$200 for cases requiring a visa; confirm the exact work-permit fee and process directly with the nearest mission or labour authorities.',
    'Nearest Saint Vincent and the Grenadines mission',
    'Secure an employment offer from a local employer\nEmployer/applicant applies for a work permit\nPay the applicable visa/permit fee\nGather qualification documents\nAwait decision',
    '/assets/images/visa-heroes/saint-vincent-and-the-grenadines.webp',
    'visitworld.today secondary sourcing on work-permit restriction and fee', NULL, '2026-09-19'
);
SET @vct4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vct4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vct4, 'Core Documents', 'Required from every applicant.', 1);
SET @vct4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vct4s1, 'Valid Passport (120+ Days Beyond Entry Date)', NULL, 'original', 1, 0, 1, 1),
(@vct4s1, 'Employment Offer Letter from Local Employer', NULL, 'copy', 1, 0, 1, 2),
(@vct4s1, 'Work Permit Application', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vct4, 'Supporting Documents', 'Qualification evidence.', 2);
SET @vct4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vct4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(178, 4, 200.00, 'XCD', 'Work-Related Visa Fee', 'EC$200 fee cited for those who need a visa (such as for employment purposes) — the tourism visa-exemption does not cover work.', '2026-01-01', NOW(), NULL, 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Saint Vincent and the Grenadines on visa-free entry?', 'No. Working, volunteering for pay, or business activity is not permitted on tourist entry; a separate work permit/visa is required.', 178, 4, 18100, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    178, 5, 'VCT-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Saint Vincent and the Grenadines.',
    'Family visits fall under the same visa-exemption arrangement as tourism ("visit" is explicitly listed as a covered purpose).',
    'Up to 90 days (per some sources) or up to 1 month (per others), as determined by immigration on arrival',
    'No visa required for family visits; simply present documents at the port of entry',
    0,
    'An invitation letter from the resident family member is recommended supporting evidence.',
    'Consulate/Honorary Consul of Saint Vincent and the Grenadines accredited to India',
    'Gather invitation letter and proof of relationship\nGather proof of accommodation and return ticket\nPresent documents to immigration on arrival',
    '/assets/images/visa-heroes/saint-vincent-and-the-grenadines.webp',
    'MEA visa-exemption agreement (mea.gov.in) explicitly lists "visit" as a covered purpose', 'https://www.mea.gov.in/Images/CPV/visa-exemption/Agreement_copy_of_SVG.pdf', '2026-09-19'
);
SET @vct5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vct5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vct5, 'Core Documents', 'Required from every applicant.', 1);
SET @vct5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vct5s1, 'Valid Passport (120+ Days Beyond Entry Date)', NULL, 'original', 1, 0, 1, 1),
(@vct5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 0, 1, 1, 2),
(@vct5s1, 'Proof of Relationship (Birth/Marriage Certificates)', NULL, 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vct5, 'Supporting Documents', 'Additional evidence.', 2);
SET @vct5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vct5s2, 'Return Flight Ticket', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a separate Family Visit Visa needed?', 'No — "visit" is explicitly listed as a purpose covered under the visa-exemption agreement between India and Saint Vincent and the Grenadines.', 178, 5, 18200, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    178, 6, 'VCT-TRAN-IN-01', '2026.09', 'published',
    'Brief transit through Saint Vincent and the Grenadines en route to a third country.',
    'Transit requirements for Indian passport holders were not independently confirmed from a first-party source this session. Given the visa-exemption agreement covers general entry, transit is likely similarly exempt, but travellers should confirm with their airline.',
    'Short transit period; not independently confirmed this session',
    'Confirm with airline before travel',
    0,
    'Not independently confirmed this session — confirm directly before travel.',
    'Nearest Saint Vincent and the Grenadines mission',
    'Confirm transit requirements with your airline\nCarry onward flight ticket and destination visa if applicable',
    '/assets/images/visa-heroes/saint-vincent-and-the-grenadines.webp',
    'Inference from general visa-exemption agreement; not independently confirmed this session', NULL, '2026-09-19'
);
SET @vct6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vct6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vct6, 'Core Documents', 'Required from every applicant.', 1);
SET @vct6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vct6s1, 'Valid Passport (120+ Days Beyond Entry Date)', NULL, 'original', 1, 0, 1, 1),
(@vct6s1, 'Onward Flight Ticket to Final Destination', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Saint Vincent and the Grenadines?', 'This was not independently confirmed this session — the general visa-exemption agreement likely covers transit, but confirm with your airline before travel.', 178, 6, 18300, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    178, 7, 'VCT-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Saint Vincent and the Grenadines for Indian nationals.',
    'Saint Vincent and the Grenadines is not a typical medical-tourism destination for Indian nationals. The general visa-exemption agreement likely covers short medical visits, though a dedicated first-party Medical Visa checklist was not located this session.',
    'Tied to treatment duration; not independently confirmed this session',
    'No visa required for short visits under the exemption agreement; longer treatment may require additional clearance',
    0,
    'Confirm category-specific requirements directly with the nearest Saint Vincent and the Grenadines mission.',
    'Nearest Saint Vincent and the Grenadines mission',
    'Obtain hospital admission/treatment confirmation from a local hospital\nGather proof of funds for treatment and stay\nPresent documents to immigration on arrival',
    '/assets/images/visa-heroes/saint-vincent-and-the-grenadines.webp',
    'Inference from general visa-exemption agreement; not independently confirmed with a dedicated medical-visa source this session', NULL, '2026-09-19'
);
SET @vct7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vct7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vct7, 'Core Documents', 'Required from every applicant.', 1);
SET @vct7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vct7s1, 'Valid Passport (120+ Days Beyond Entry Date)', NULL, 'original', 1, 0, 1, 1),
(@vct7s1, 'Hospital Admission Letter/Treatment Confirmation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Saint Vincent and the Grenadines a common destination for medical treatment from India?', 'No — this was not independently sourced this session.', 178, 7, 18400, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    178, 8, 'VCT-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Saint Vincent and the Grenadines.',
    'Conference attendance falls under the same visa-exemption arrangement as business visits.',
    'Up to 90 days (per some sources) or up to 1 month (per others), as determined by immigration on arrival',
    'No visa required; simply present documents at the port of entry',
    0,
    'A formal invitation letter from the conference organizer is recommended supporting evidence.',
    'Consulate/Honorary Consul of Saint Vincent and the Grenadines accredited to India',
    'Obtain formal invitation letter from the conference organizer\nGather proof of event registration\nPresent documents to immigration on arrival',
    '/assets/images/visa-heroes/saint-vincent-and-the-grenadines.webp',
    'General inference from the visa-exemption agreement covering business purposes', NULL, '2026-09-19'
);
SET @vct8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vct8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vct8, 'Core Documents', 'Required from every applicant.', 1);
SET @vct8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vct8s1, 'Valid Passport (120+ Days Beyond Entry Date)', NULL, 'original', 1, 0, 1, 1),
(@vct8s1, 'Formal Invitation Letter from Conference/Event Organizer', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Conference Visa for Saint Vincent and the Grenadines?', 'No dedicated category was located; conference attendance falls under the general visa-exemption arrangement covering business purposes.', 178, 8, 18500, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    178, 9, 'VCT-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Saint Vincent and the Grenadines.',
    'A dedicated Sports Visa category was not located from a first-party source this session. Athletes/officials would likely use the same visa-exemption arrangement as tourists/business visitors for short participation.',
    'Up to 90 days (per some sources) or up to 1 month (per others), as determined by immigration on arrival',
    'No visa required for short visits; simply present documents at the port of entry',
    0,
    'Confirm the appropriate category with the nearest Saint Vincent and the Grenadines mission before applying.',
    'Nearest Saint Vincent and the Grenadines mission',
    'Obtain letter from sports federation/event organizer confirming participation\nGather proof of accommodation and travel arrangements\nPresent documents to immigration on arrival',
    '/assets/images/visa-heroes/saint-vincent-and-the-grenadines.webp',
    'Inference; not independently confirmed with a dedicated sports-visa source this session', NULL, '2026-09-19'
);
SET @vct9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vct9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vct9, 'Core Documents', 'Required from every applicant.', 1);
SET @vct9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vct9s1, 'Valid Passport (120+ Days Beyond Entry Date)', NULL, 'original', 1, 0, 1, 1),
(@vct9s1, 'Letter from Sports Federation/Event Organizer Confirming Participation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports Visa for Saint Vincent and the Grenadines?', 'Not independently confirmed this session — athletes/officials should confirm the appropriate requirement with the nearest mission.', 178, 9, 18600, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    178, 10, 'VCT-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse/family member who holds a Saint Vincent and the Grenadines work permit or long-term residency.',
    'Dependents of Indian nationals working in Saint Vincent and the Grenadines typically apply through a process linked to the primary work-permit holder''s employer sponsorship. A dedicated first-party checklist was not located this session.',
    'Typically matches the primary permit holder''s duration; not independently confirmed this session',
    'Employer/sponsor-linked application through Vincentian immigration authorities',
    1,
    'Coordinate with the sponsoring employer and local immigration authorities for the correct process.',
    'Nearest Saint Vincent and the Grenadines mission',
    'Confirm sponsorship arrangement with the primary permit holder''s employer\nGather proof of relationship and primary permit holder''s documents\nApply through Vincentian immigration authorities\nAwait decision',
    '/assets/images/visa-heroes/saint-vincent-and-the-grenadines.webp',
    'Inference; not independently confirmed with a dedicated dependent-visa source this session', NULL, '2026-09-19'
);
SET @vct10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vct10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vct10, 'Core Documents', 'Required from every applicant.', 1);
SET @vct10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vct10s1, 'Valid Passport (120+ Days Beyond Entry Date)', NULL, 'original', 1, 0, 1, 1),
(@vct10s1, 'Proof of Relationship to Primary Permit Holder (Marriage/Birth Certificate)', NULL, 'copy', 1, 0, 1, 2),
(@vct10s1, 'Copy of Primary Permit Holder''s Work Permit', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependents of a Saint Vincent and the Grenadines work-permit holder apply directly?', 'This was not independently confirmed this session — dependents should coordinate with the sponsoring employer and local immigration authorities for the correct process.', 178, 10, 18700, 1);
