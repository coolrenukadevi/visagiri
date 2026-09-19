-- Cuba Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Cuba's real, distinctive facts verified this session:
--   - Indian citizens are ineligible for the standard tourist card —
--     unlike most nationalities, Indians must obtain a full Cuban
--     visa from the Embassy of Cuba in New Delhi. Exception: Indians
--     who ALSO hold a valid US, Canada, or EU member-state visa or
--     residence permit can travel on the tourist card instead.
--   - Embassy: W-124A, Greater Kailash Part I, New Delhi 110048, open
--     Mon-Fri by appointment.
--   - Fees: Tourist Card (if eligible via the US/Canada/EU exception)
--     ₹2,000-3,500; Business/Student visa ₹4,000-6,000.
--   - Processing: Tourist Card 3-5 working days; Business/Student
--     visa 7-15 working days; general guidance is 5-10 working days.
--   - Apply no earlier than 2 months before travel; submit at least
--     10 days before travel.
--
-- country_id 162 = Cuba. visa_type_id: 1=Tourist, 2=Business,
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
    162, 1, 'CUB-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Cuba.',
    'Indian citizens are ineligible for the standard tourist card and must obtain a full Cuban visa from the Embassy of Cuba in New Delhi — unless also holding a valid US, Canada, or EU visa/residence permit, in which case the tourist card applies instead.',
    'As endorsed on the visa or tourist card',
    'Apply at the Embassy of Cuba in New Delhi by appointment, or use the tourist card if holding a qualifying US/Canada/EU visa',
    1,
    'Reported 5-10 working days; Tourist Card (if eligible) 3-5 working days',
    'Embassy of Cuba, W-124A Greater Kailash Part I, New Delhi',
    'Check if you hold a qualifying US, Canada, or EU member-state visa/residence permit for the tourist-card exception\nIf not, book an appointment at the Embassy of Cuba in New Delhi\nComplete the visa application form\nGather passport, photo, and travel documents\nSubmit documents and pay the visa fee',
    '/assets/images/visa-heroes/cuba.webp',
    'itzeazy.in and Akbar Travels secondary sourcing', 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', '2026-09-19'
);
SET @cub1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cub1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub1, 'Core Documents', 'Required from every applicant.', 1);
SET @cub1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cub1s1, 'Completed Visa Application Form', NULL, 'original', 1, 0, 1, 2),
(@cub1s1, 'Recent Passport-Size Photograph', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @cub1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub1s2, 'Valid US/Canada/EU Visa or Residence Permit (If Using Tourist-Card Exception)', NULL, 'copy', 0, 1, 0, 1),
(@cub1s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2),
(@cub1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 3),
(@cub1s2, 'Travel Insurance Confirmation', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(162, 1, 3500.00, 'INR', 'Tourist Card Fee (If Eligible)', 'Only available if holding a qualifying US/Canada/EU visa or residence permit; otherwise a full Business/Student-tier visa (INR 4,000-6,000) applies. Additional agent/courier fees may apply.', '2026-01-01', NOW(), 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens use Cuba''s standard tourist card?', 'Not by default — Indian citizens are ineligible for the standard tourist card and must obtain a full Cuban visa from the Embassy of Cuba in New Delhi. The tourist card is only usable by Indians who also hold a valid US, Canada, or EU member-state visa or residence permit.', 162, 1, 16200, 1),
('Where do Indian citizens apply for a Cuba visa?', 'At the Embassy of Cuba in New Delhi (W-124A, Greater Kailash Part I), open Monday-Friday by appointment.', 162, 1, 16201, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    162, 2, 'CUB-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Cuba.',
    'Business travellers apply for a Cuban business visa at the Embassy of Cuba in New Delhi, adding a business invitation letter.',
    'As endorsed on the visa',
    'Apply at the Embassy of Cuba in New Delhi by appointment',
    1,
    'Reported 7-15 working days',
    'Embassy of Cuba, W-124A Greater Kailash Part I, New Delhi',
    'Book an appointment at the Embassy of Cuba in New Delhi\nObtain a business invitation letter\nGather passport, photo, and supporting documents\nSubmit documents and pay the visa fee\nCollect the visa before travel',
    '/assets/images/visa-heroes/cuba.webp',
    'itzeazy.in and Akbar Travels secondary sourcing', 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', '2026-09-19'
);
SET @cub2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cub2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub2, 'Core Documents', 'Required from every applicant.', 1);
SET @cub2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cub2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @cub2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@cub2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(162, 2, 6000.00, 'INR', 'Business Visa Fee', 'Range reported at INR 4,000-6,000 depending on agency/service charges.', '2026-01-01', NOW(), 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How long does a Cuba business visa take to process?', 'Reportedly 7-15 working days depending on documentation and embassy workload — apply well in advance of your travel date.', 162, 2, 16202, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    162, 3, 'CUB-STUD-IN-01', '2026.09', 'published',
    'Academic study in Cuba.',
    'Student visas are processed at the Embassy of Cuba in New Delhi alongside business visas, requiring admission confirmation from the Cuban institution.',
    'Tied to the academic program duration',
    'Apply at the Embassy of Cuba in New Delhi by appointment',
    1,
    'Reported 7-15 working days',
    'Embassy of Cuba, W-124A Greater Kailash Part I, New Delhi',
    'Secure admission confirmation from the Cuban institution\nBook an appointment at the Embassy of Cuba in New Delhi\nGather proof of financial support\nSubmit the visa application with required documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/cuba.webp',
    'itzeazy.in and Akbar Travels secondary sourcing', 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', '2026-09-19'
);
SET @cub3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cub3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub3, 'Core Documents', 'Required from every applicant.', 1);
SET @cub3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cub3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @cub3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@cub3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(162, 3, 6000.00, 'INR', 'Student Visa Fee', 'Range reported at INR 4,000-6,000 depending on agency/service charges.', '2026-01-01', NOW(), 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for Cuba?', 'Yes — apply at the Embassy of Cuba in New Delhi with admission confirmation from your Cuban institution; the tourist card is not usable for study purposes.', 162, 3, 16203, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    162, 4, 'CUB-WORK-IN-01', '2026.09', 'published',
    'Employment with a Cuban company or organisation.',
    'Not independently confirmed this session as a distinct standard category; likely requires an employer-sponsored work visa applied for at the Embassy of Cuba in New Delhi.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the Embassy of Cuba in New Delhi for the work-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Cuba, W-124A Greater Kailash Part I, New Delhi',
    'Secure a signed employment contract from the Cuban employer\nBook an appointment at the Embassy of Cuba in New Delhi\nGather proof of qualifications\nSubmit the visa application with required documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/cuba.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', '2026-09-19'
);
SET @cub4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cub4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub4, 'Core Documents', 'Required from every applicant.', 1);
SET @cub4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cub4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @cub4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@cub4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(162, 4, NULL, 'INR', 'Confirm at Embassy', 'Work visa fee not independently confirmed this session; confirm with the Embassy of Cuba in New Delhi.', '2026-09-01', NOW(), 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work visa for Cuba?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work visa via the Embassy of Cuba in New Delhi.', 162, 4, 16204, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    162, 5, 'CUB-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Cuba.',
    'Family visits use the same embassy application process as tourism, adding an invitation letter and relationship proof — the tourist-card exception route (US/Canada/EU visa holders) applies here too.',
    'As endorsed on the visa or tourist card',
    'Apply at the Embassy of Cuba in New Delhi by appointment, or use the tourist card if holding a qualifying US/Canada/EU visa',
    1,
    'Reported 5-10 working days; Tourist Card (if eligible) 3-5 working days',
    'Embassy of Cuba, W-124A Greater Kailash Part I, New Delhi',
    'Check if you hold a qualifying US, Canada, or EU visa/residence permit for the tourist-card exception\nObtain an invitation letter from the family member resident in Cuba\nBook an appointment at the Embassy of Cuba if not eligible for the exception\nGather passport, photo, and relationship proof\nSubmit documents and pay the visa fee',
    '/assets/images/visa-heroes/cuba.webp',
    'itzeazy.in and Akbar Travels secondary sourcing', 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', '2026-09-19'
);
SET @cub5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cub5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub5, 'Core Documents', 'Required from every applicant.', 1);
SET @cub5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cub5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @cub5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@cub5s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(162, 5, 3500.00, 'INR', 'Tourist Card Fee (If Eligible)', 'Only available if holding a qualifying US/Canada/EU visa or residence permit; otherwise a full visa (INR 4,000-6,000) applies.', '2026-01-01', NOW(), 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Cuba on the tourist card?', 'Only if you also hold a valid US, Canada, or EU member-state visa or residence permit — otherwise, a full Cuban visa from the Embassy of Cuba in New Delhi is required.', 162, 5, 16205, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    162, 6, 'CUB-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Cuba en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard visa or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the Embassy of Cuba or your airline whether the standard visa applies',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Cuba, W-124A Greater Kailash Part I, New Delhi',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific visa is required\nContact the Embassy of Cuba if needed\nSubmit passport and onward ticket for the application\nConfirm requirements with your airline before travel',
    '/assets/images/visa-heroes/cuba.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', '2026-09-19'
);
SET @cub6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cub6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub6, 'Core Documents', 'Required from every applicant.', 1);
SET @cub6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cub6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @cub6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(162, 6, NULL, 'INR', 'Confirm at Embassy', 'Transit fee not independently confirmed this session; confirm with the Embassy of Cuba.', '2026-09-01', NOW(), 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Cuba?', 'Not independently confirmed this session — confirm with the Embassy of Cuba or your airline whether your specific transit routing requires the standard visa.', 162, 6, 16206, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    162, 7, 'CUB-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Cuba, known for its medical tourism sector.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa with medical documentation.',
    'As endorsed on the visa',
    'Apply at the Embassy of Cuba in New Delhi by appointment',
    1,
    'Reported 5-10 working days',
    'Embassy of Cuba, W-124A Greater Kailash Part I, New Delhi',
    'Obtain a medical appointment/admission letter from the Cuban hospital or clinic\nBook an appointment at the Embassy of Cuba in New Delhi\nGather passport, photo, and medical documents\nSubmit documents and pay the visa fee\nCollect the visa before travel',
    '/assets/images/visa-heroes/cuba.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', '2026-09-19'
);
SET @cub7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cub7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub7, 'Core Documents', 'Required from every applicant.', 1);
SET @cub7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cub7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @cub7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@cub7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(162, 7, 6000.00, 'INR', 'Medical Visa Fee', 'Range reported at INR 4,000-6,000, following the Business/Student visa tier.', '2026-01-01', NOW(), 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Cuba?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard visa with supporting medical documentation, given Cuba''s established medical tourism sector.', 162, 7, 16207, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    162, 8, 'CUB-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Cuba.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business visa framework with an event invitation.',
    'As endorsed on the visa',
    'Apply at the Embassy of Cuba in New Delhi by appointment',
    1,
    'Reported 7-15 working days',
    'Embassy of Cuba, W-124A Greater Kailash Part I, New Delhi',
    'Obtain an official invitation letter from the event organiser\nBook an appointment at the Embassy of Cuba in New Delhi\nGather passport, photo, and event documents\nSubmit documents and pay the visa fee\nCollect the visa before travel',
    '/assets/images/visa-heroes/cuba.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', '2026-09-19'
);
SET @cub8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cub8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub8, 'Core Documents', 'Required from every applicant.', 1);
SET @cub8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cub8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @cub8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(162, 8, 6000.00, 'INR', 'Conference Visa Fee', 'Range reported at INR 4,000-6,000, following the Business visa tier.', '2026-01-01', NOW(), 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Cuba?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business visa framework with an official invitation letter.', 162, 8, 16208, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    162, 9, 'CUB-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Cuba.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa with an event invitation.',
    'As endorsed on the visa',
    'Apply at the Embassy of Cuba in New Delhi by appointment',
    1,
    'Reported 7-15 working days',
    'Embassy of Cuba, W-124A Greater Kailash Part I, New Delhi',
    'Obtain an official invitation from the sporting federation/event organiser\nBook an appointment at the Embassy of Cuba in New Delhi\nGather passport, photo, and event documents\nSubmit documents and pay the visa fee\nCollect the visa before travel',
    '/assets/images/visa-heroes/cuba.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', '2026-09-19'
);
SET @cub9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cub9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub9, 'Core Documents', 'Required from every applicant.', 1);
SET @cub9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cub9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @cub9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(162, 9, 6000.00, 'INR', 'Sports Visa Fee', 'Range reported at INR 4,000-6,000, following the Business visa tier.', '2026-01-01', NOW(), 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Cuba?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard visa with a federation/event invitation.', 162, 9, 16209, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    162, 10, 'CUB-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Cuban work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the Embassy of Cuba in New Delhi for the dependent-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Cuba, W-124A Greater Kailash Part I, New Delhi',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nBook an appointment at the Embassy of Cuba\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/cuba.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', '2026-09-19'
);
SET @cub10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cub10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub10, 'Core Documents', 'Required from every applicant.', 1);
SET @cub10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cub10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cub10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @cub10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cub10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@cub10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(162, 10, NULL, 'INR', 'Confirm at Embassy', 'Dependent visa fee not independently confirmed this session; confirm with the Embassy of Cuba.', '2026-09-01', NOW(), 'https://itzeazy.in/blog/2026/02/18/cuba-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent visa in Cuba?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the Embassy of Cuba.', 162, 10, 16210, 1);
