-- Central African Republic Visa Checklist Engine content for all 10
-- visa types — built fresh this session via web search.
--
-- Central African Republic's real, distinctive facts verified this
-- session:
--   - Only a paper/embassy visa is available for Indian citizens — no
--     eVisa or visa-on-arrival option confirmed.
--   - Distinctive gap: CAR has NO diplomatic mission in India at all
--     (no embassy or consulate in New Delhi or elsewhere in India).
--     Indian applicants must apply through the nearest CAR mission
--     abroad — options include Cameroon (Yaoundé), Chad (N'Djamena),
--     Ethiopia (Addis Ababa), Egypt (Cairo), or another CAR embassy
--     reachable from India.
--   - Fee, processing time, and stay duration were not independently
--     confirmed this session — flagged honestly throughout, since no
--     official CAR visa portal or in-India mission exists to verify
--     against.
--
-- country_id 9 = Central African Republic. visa_type_id: 1=Tourist,
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
    9, 1, 'CAF-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to the Central African Republic.',
    'A paper visa is required — the Central African Republic has no diplomatic mission in India, so applicants must apply through the nearest CAR embassy abroad (e.g. Cameroon, Chad, Ethiopia).',
    'Not independently confirmed this session',
    'Apply for a paper visa at the nearest Central African Republic embassy abroad (no CAR mission exists in India)',
    1,
    'Not independently confirmed this session — no in-India mission exists to verify against',
    'Nearest Central African Republic embassy abroad (e.g. Yaoundé, N''Djamena, Addis Ababa, Cairo) — none in India',
    'Identify the nearest CAR embassy reachable from India (e.g. Cameroon, Chad, Ethiopia, Egypt)\nContact that embassy to confirm current visa requirements and fees\nGather passport, photo, and travel documents\nSubmit the application in person at that embassy\nAllow extra time given the lack of an in-India mission',
    '/assets/images/visa-heroes/central-african-republic.webp',
    'Akbar Travels and embassies.net secondary sourcing; no official CAR visa portal or in-India mission exists to verify against', 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', '2026-09-19'
);
SET @caf1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@caf1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf1, 'Core Documents', 'Required from every applicant.', 1);
SET @caf1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@caf1s1, 'Completed Visa Application Form', NULL, 'original', 1, 0, 1, 2),
(@caf1s1, 'Recent Passport-Size Photograph', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @caf1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf1s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 1),
(@caf1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(9, 1, NULL, 'USD', 'Confirm at Embassy Abroad', 'Fee not independently confirmed this session; the Central African Republic has no mission in India, so confirm with the nearest CAR embassy abroad.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Where do Indian citizens apply for a Central African Republic visa?', 'The Central African Republic has no embassy or consulate in India. Applicants must apply at the nearest CAR mission abroad, such as in Cameroon, Chad, Ethiopia, or Egypt.', 9, 1, 900, 1),
('Is there an eVisa for the Central African Republic?', 'Not independently confirmed this session — only a paper/embassy visa is documented for Indian citizens, with no eVisa or visa-on-arrival option found.', 9, 1, 901, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    9, 2, 'CAF-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in the Central African Republic.',
    'Business travellers apply through the same paper-visa process as tourists, adding a business invitation letter, at the nearest CAR embassy abroad.',
    'Not independently confirmed this session',
    'Apply for a paper visa at the nearest Central African Republic embassy abroad (no CAR mission exists in India)',
    1,
    'Not independently confirmed this session — no in-India mission exists to verify against',
    'Nearest Central African Republic embassy abroad (e.g. Yaoundé, N''Djamena, Addis Ababa, Cairo) — none in India',
    'Identify the nearest CAR embassy reachable from India\nObtain a business invitation letter\nGather passport, photo, and supporting documents\nSubmit the application in person at that embassy\nAllow extra time given the lack of an in-India mission',
    '/assets/images/visa-heroes/central-african-republic.webp',
    'Akbar Travels and embassies.net secondary sourcing; no official CAR visa portal or in-India mission exists to verify against', 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', '2026-09-19'
);
SET @caf2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@caf2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf2, 'Core Documents', 'Required from every applicant.', 1);
SET @caf2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@caf2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @caf2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@caf2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(9, 2, NULL, 'USD', 'Confirm at Embassy Abroad', 'Fee not independently confirmed this session; confirm with the nearest CAR embassy abroad.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Which CAR embassy should business travellers from India use?', 'Not independently confirmed this session which mission is most convenient — check the CAR embassies in Cameroon, Chad, Ethiopia, or Egypt for the one best suited to your travel plans.', 9, 2, 902, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    9, 3, 'CAF-STUD-IN-01', '2026.09', 'published',
    'Academic study in the Central African Republic.',
    'Not independently confirmed this session as a distinct standard category; likely requires a long-stay visa applied for at the nearest CAR embassy abroad.',
    'Tied to the academic program duration',
    'Apply for a paper visa at the nearest Central African Republic embassy abroad (no CAR mission exists in India)',
    1,
    'Not independently confirmed this session',
    'Nearest Central African Republic embassy abroad — none in India',
    'Secure admission confirmation from the CAR institution\nIdentify the nearest CAR embassy reachable from India\nGather proof of financial support\nSubmit the visa application with required documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/central-african-republic.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', '2026-09-19'
);
SET @caf3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@caf3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf3, 'Core Documents', 'Required from every applicant.', 1);
SET @caf3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@caf3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @caf3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@caf3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(9, 3, NULL, 'USD', 'Confirm at Embassy Abroad', 'Student visa fee not independently confirmed this session; confirm with the nearest CAR embassy abroad.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for the Central African Republic?', 'Not independently confirmed this session — confirm with the nearest CAR embassy abroad, since no mission exists in India.', 9, 3, 903, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    9, 4, 'CAF-WORK-IN-01', '2026.09', 'published',
    'Employment with a Central African Republic company.',
    'Not independently confirmed this session as a distinct standard category; likely requires an employer-sponsored work permit applied for at the nearest CAR embassy abroad.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the nearest Central African Republic embassy abroad for the work-permit process',
    1,
    'Not independently confirmed this session',
    'Nearest Central African Republic embassy abroad — none in India',
    'Secure a signed employment contract from the CAR employer\nIdentify the nearest CAR embassy reachable from India\nGather proof of qualifications\nSubmit the visa application with required documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/central-african-republic.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', '2026-09-19'
);
SET @caf4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@caf4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf4, 'Core Documents', 'Required from every applicant.', 1);
SET @caf4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@caf4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @caf4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@caf4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(9, 4, NULL, 'USD', 'Confirm at Embassy Abroad', 'Work permit fee not independently confirmed this session; confirm with the nearest CAR embassy abroad.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for the Central African Republic beyond the visa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit. Confirm with the nearest CAR embassy abroad.', 9, 4, 904, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    9, 5, 'CAF-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in the Central African Republic.',
    'Family visits use the same paper-visa process as tourism, adding an invitation letter and relationship proof, at the nearest CAR embassy abroad.',
    'Not independently confirmed this session',
    'Apply for a paper visa at the nearest Central African Republic embassy abroad (no CAR mission exists in India)',
    1,
    'Not independently confirmed this session',
    'Nearest Central African Republic embassy abroad — none in India',
    'Obtain an invitation letter from the family member resident in CAR\nIdentify the nearest CAR embassy reachable from India\nGather passport, photo, and relationship proof\nSubmit the application in person at that embassy\nAllow extra time given the lack of an in-India mission',
    '/assets/images/visa-heroes/central-african-republic.webp',
    'Akbar Travels and embassies.net secondary sourcing; no official CAR visa portal or in-India mission exists to verify against', 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', '2026-09-19'
);
SET @caf5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@caf5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf5, 'Core Documents', 'Required from every applicant.', 1);
SET @caf5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@caf5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @caf5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@caf5s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(9, 5, NULL, 'USD', 'Confirm at Embassy Abroad', 'Fee not independently confirmed this session; confirm with the nearest CAR embassy abroad.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in the Central African Republic on the standard visa?', 'Yes — family visits use the same paper-visa process as tourism, with an invitation letter and relationship proof added, applied for at the nearest CAR embassy abroad.', 9, 5, 905, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    9, 6, 'CAF-TRAN-IN-01', '2026.09', 'published',
    'Transiting through the Central African Republic en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard visa or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the nearest CAR embassy abroad or your airline whether the standard visa applies',
    1,
    'Not independently confirmed this session',
    'Nearest Central African Republic embassy abroad — none in India',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific visa is required\nContact the nearest CAR embassy abroad if needed\nSubmit passport and onward ticket for the application\nConfirm requirements with your airline before travel',
    '/assets/images/visa-heroes/central-african-republic.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', '2026-09-19'
);
SET @caf6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@caf6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf6, 'Core Documents', 'Required from every applicant.', 1);
SET @caf6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@caf6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @caf6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(9, 6, NULL, 'USD', 'Confirm at Embassy Abroad', 'Transit fee not independently confirmed this session; confirm with the nearest CAR embassy abroad.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through the Central African Republic?', 'Not independently confirmed this session — confirm with the nearest CAR embassy abroad or your airline whether your specific transit routing requires a visa.', 9, 6, 906, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    9, 7, 'CAF-MED-IN-01', '2026.09', 'published',
    'Medical treatment in the Central African Republic.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa with medical documentation.',
    'Not independently confirmed this session',
    'Apply for a paper visa at the nearest Central African Republic embassy abroad (no CAR mission exists in India)',
    1,
    'Not independently confirmed this session',
    'Nearest Central African Republic embassy abroad — none in India',
    'Obtain a medical appointment/admission letter from the hospital\nIdentify the nearest CAR embassy reachable from India\nGather passport, photo, and medical documents\nSubmit the application in person at that embassy\nAllow extra time given the lack of an in-India mission',
    '/assets/images/visa-heroes/central-african-republic.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', '2026-09-19'
);
SET @caf7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@caf7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf7, 'Core Documents', 'Required from every applicant.', 1);
SET @caf7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@caf7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @caf7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@caf7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(9, 7, NULL, 'USD', 'Confirm at Embassy Abroad', 'Fee not independently confirmed this session; confirm with the nearest CAR embassy abroad.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for the Central African Republic?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard visa with supporting medical documentation, applied for at the nearest CAR embassy abroad.', 9, 7, 907, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    9, 8, 'CAF-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in the Central African Republic.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business visa framework with an event invitation.',
    'Not independently confirmed this session',
    'Apply for a paper visa at the nearest Central African Republic embassy abroad (no CAR mission exists in India)',
    1,
    'Not independently confirmed this session',
    'Nearest Central African Republic embassy abroad — none in India',
    'Obtain an official invitation letter from the event organiser\nIdentify the nearest CAR embassy reachable from India\nGather passport, photo, and event documents\nSubmit the application in person at that embassy\nAllow extra time given the lack of an in-India mission',
    '/assets/images/visa-heroes/central-african-republic.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', '2026-09-19'
);
SET @caf8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@caf8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf8, 'Core Documents', 'Required from every applicant.', 1);
SET @caf8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@caf8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @caf8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(9, 8, NULL, 'USD', 'Confirm at Embassy Abroad', 'Fee not independently confirmed this session; confirm with the nearest CAR embassy abroad.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for the Central African Republic?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business visa framework with an official invitation letter.', 9, 8, 908, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    9, 9, 'CAF-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in the Central African Republic.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa with an event invitation.',
    'Not independently confirmed this session',
    'Apply for a paper visa at the nearest Central African Republic embassy abroad (no CAR mission exists in India)',
    1,
    'Not independently confirmed this session',
    'Nearest Central African Republic embassy abroad — none in India',
    'Obtain an official invitation from the sporting federation/event organiser\nIdentify the nearest CAR embassy reachable from India\nGather passport, photo, and event documents\nSubmit the application in person at that embassy\nAllow extra time given the lack of an in-India mission',
    '/assets/images/visa-heroes/central-african-republic.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', '2026-09-19'
);
SET @caf9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@caf9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf9, 'Core Documents', 'Required from every applicant.', 1);
SET @caf9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@caf9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @caf9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(9, 9, NULL, 'USD', 'Confirm at Embassy Abroad', 'Fee not independently confirmed this session; confirm with the nearest CAR embassy abroad.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for the Central African Republic?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard visa with a federation/event invitation.', 9, 9, 909, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    9, 10, 'CAF-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Central African Republic work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the nearest Central African Republic embassy abroad for the dependent-visa process',
    1,
    'Not independently confirmed this session',
    'Nearest Central African Republic embassy abroad — none in India',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nIdentify the nearest CAR embassy reachable from India\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/central-african-republic.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', '2026-09-19'
);
SET @caf10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@caf10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf10, 'Core Documents', 'Required from every applicant.', 1);
SET @caf10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@caf10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@caf10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @caf10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@caf10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@caf10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(9, 10, NULL, 'USD', 'Confirm at Embassy Abroad', 'Dependent visa fee not independently confirmed this session; confirm with the nearest CAR embassy abroad.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/centralafricanrepublic-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent visa in the Central African Republic?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the nearest CAR embassy abroad.', 9, 10, 9010, 1);
