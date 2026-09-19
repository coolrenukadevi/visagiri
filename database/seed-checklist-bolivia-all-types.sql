-- Bolivia Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Bolivia's real, distinctive facts verified this session:
--   - Indian passport holders require a paper visa for Bolivia — no
--     visa-free route confirmed.
--   - Two routes: (1) embassy application in New Delhi (by appointment
--     only), or (2) visa-on-arrival, but ONLY at Santa Cruz and La Paz
--     airports (not all ports of entry) — sources disagree on the
--     exact on-arrival fee (USD 55 reported by one source, USD 120 or
--     USD 160 by others), flagged honestly below.
--   - Validity: 30 days single-entry, extendable twice for up to 90
--     days total.
--   - Yellow fever vaccination certificate is required.
--   - Embassy: E Block, E-14/15, Ground Floor, Vasant Vihar, New
--     Delhi — the only Bolivian mission in India, established March
--     2013, open Mon-Fri 08:30-16:30, by appointment only.
--   - Recommended to apply at least 10 days before travel; earliest
--     application is 1 month before travel.
--
-- country_id 198 = Bolivia. visa_type_id: 1=Tourist, 2=Business,
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
    198, 1, 'BOL-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Bolivia.',
    'All Indian citizens require a visa for Bolivia — apply at the Embassy of Bolivia in New Delhi, or via visa-on-arrival at Santa Cruz/La Paz airports only.',
    '30 days, extendable twice for up to 90 days total',
    'Apply by appointment at the Embassy of Bolivia in New Delhi, or use visa-on-arrival at Santa Cruz/La Paz airports',
    1,
    'Recommended at least 10 days before travel; apply no earlier than 1 month before travel',
    'Embassy of Bolivia, E-14/15 Vasant Vihar, New Delhi (or visa-on-arrival at Santa Cruz/La Paz airports only)',
    'Book an appointment with the Embassy of Bolivia in New Delhi (or confirm visa-on-arrival eligibility if arriving at Santa Cruz/La Paz)\nComplete the visa application form\nGather passport, photo, itinerary, hotel booking, flight confirmation, and bank statements\nGet the yellow fever vaccination certificate\nSubmit documents and pay the visa fee',
    '/assets/images/visa-heroes/bolivia.webp',
    'Atlys, iVisa Travel, and On My Canvas secondary sourcing; sources disagree on the exact visa-on-arrival fee', 'https://www.atlys.com/en-US/visa/bolivia-visa', '2026-09-19'
);
SET @bol1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bol1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol1, 'Core Documents', 'Required from every applicant.', 1);
SET @bol1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bol1s1, 'Completed Visa Application Form', NULL, 'original', 1, 0, 1, 2),
(@bol1s1, 'Recent Passport-Size Photograph', NULL, 'original', 1, 0, 1, 3),
(@bol1s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @bol1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol1s2, 'Travel Itinerary', NULL, 'copy', 1, 0, 0, 1),
(@bol1s2, 'Hotel Booking Confirmation', NULL, 'copy', 1, 0, 0, 2),
(@bol1s2, 'Confirmed Flight Tickets (Round Trip)', NULL, 'copy', 1, 0, 0, 3),
(@bol1s2, 'Bank Statements (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(198, 1, 55.00, 'USD', 'Visa-on-Arrival Fee (Santa Cruz/La Paz Only)', 'Sources disagree on the exact figure — reported as USD 55 by one source and USD 120-160 by others. Confirm the current fee with the Embassy of Bolivia before travel. Visa-on-arrival is not available at all ports of entry.', '2026-01-01', NOW(), 'https://ivisatravel.com/bolivia/c/bolivia-tourist-visa-for-indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Bolivia?', 'Yes — all Indian citizens require a visa, either applied for in advance at the Embassy of Bolivia in New Delhi or obtained on arrival at Santa Cruz or La Paz airports only.', 198, 1, 19800, 1),
('Is a yellow fever certificate mandatory for Bolivia?', 'Yes — a yellow fever vaccination certificate is required as part of the visa application.', 198, 1, 19801, 1),
('How long can I stay in Bolivia on a tourist visa?', 'The visa is valid for 30 days and can be extended twice, for a maximum total stay of 90 days.', 198, 1, 19802, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    198, 2, 'BOL-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Bolivia.',
    'Business travellers apply through the same embassy process as tourists, adding a business invitation letter.',
    '30 days, extendable twice for up to 90 days total',
    'Apply by appointment at the Embassy of Bolivia in New Delhi',
    1,
    'Recommended at least 10 days before travel; apply no earlier than 1 month before travel',
    'Embassy of Bolivia, E-14/15 Vasant Vihar, New Delhi',
    'Book an appointment with the Embassy of Bolivia in New Delhi\nObtain a business invitation letter\nGather passport, photo, and supporting documents\nGet the yellow fever vaccination certificate\nSubmit documents and pay the visa fee',
    '/assets/images/visa-heroes/bolivia.webp',
    'Atlys and iVisa Travel secondary sourcing', 'https://www.atlys.com/en-US/visa/bolivia-visa', '2026-09-19'
);
SET @bol2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bol2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol2, 'Core Documents', 'Required from every applicant.', 1);
SET @bol2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bol2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2),
(@bol2s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @bol2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@bol2s2, 'Confirmed Flight Tickets (Round Trip)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(198, 2, NULL, 'USD', 'Confirm at Embassy', 'Business visa fee not independently confirmed this session; confirm with the Embassy of Bolivia in New Delhi.', '2026-09-01', NOW(), 'https://www.atlys.com/en-US/visa/bolivia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can business travellers use the visa-on-arrival route?', 'Not independently confirmed this session — visa-on-arrival is primarily documented for tourism at Santa Cruz/La Paz airports. Business travellers should confirm with the Embassy of Bolivia before relying on it.', 198, 2, 19803, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    198, 3, 'BOL-STUD-IN-01', '2026.09', 'published',
    'Academic study in Bolivia.',
    'Not independently confirmed this session as a distinct standard category; likely requires a student visa beyond the standard tourist visa.',
    'Tied to the academic program duration',
    'Confirm with the Embassy of Bolivia in New Delhi for the student-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Bolivia, E-14/15 Vasant Vihar, New Delhi',
    'Secure admission confirmation from the Bolivian institution\nBook an appointment with the Embassy of Bolivia\nGather proof of financial support and yellow fever certificate\nSubmit the visa application with required documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/bolivia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.atlys.com/en-US/visa/bolivia-visa', '2026-09-19'
);
SET @bol3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bol3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol3, 'Core Documents', 'Required from every applicant.', 1);
SET @bol3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bol3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2),
(@bol3s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @bol3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bol3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(198, 3, NULL, 'USD', 'Confirm at Embassy', 'Student visa fee not independently confirmed this session; confirm with the Embassy of Bolivia.', '2026-09-01', NOW(), 'https://www.atlys.com/en-US/visa/bolivia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for Bolivia?', 'Not independently confirmed this session — longer academic programs likely require a dedicated student visa beyond the standard tourist visa. Confirm with the Embassy of Bolivia.', 198, 3, 19804, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    198, 4, 'BOL-WORK-IN-01', '2026.09', 'published',
    'Employment with a Bolivian company.',
    'Not independently confirmed this session as a distinct standard category; likely requires an employer-sponsored work visa beyond the standard tourist visa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the Embassy of Bolivia for the work-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Bolivia, E-14/15 Vasant Vihar, New Delhi',
    'Secure a signed employment contract from the Bolivian employer\nBook an appointment with the Embassy of Bolivia\nGather proof of qualifications and yellow fever certificate\nSubmit the visa application with required documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/bolivia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.atlys.com/en-US/visa/bolivia-visa', '2026-09-19'
);
SET @bol4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bol4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol4, 'Core Documents', 'Required from every applicant.', 1);
SET @bol4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bol4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@bol4s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @bol4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bol4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(198, 4, NULL, 'USD', 'Confirm at Embassy', 'Work visa fee not independently confirmed this session; confirm with the Embassy of Bolivia.', '2026-09-01', NOW(), 'https://www.atlys.com/en-US/visa/bolivia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work visa for Bolivia beyond the tourist visa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work visa. Confirm with the Embassy of Bolivia.', 198, 4, 19805, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    198, 5, 'BOL-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Bolivia.',
    'Family visits use the same embassy application process as tourism, adding an invitation letter and relationship proof.',
    '30 days, extendable twice for up to 90 days total',
    'Apply by appointment at the Embassy of Bolivia in New Delhi',
    1,
    'Recommended at least 10 days before travel; apply no earlier than 1 month before travel',
    'Embassy of Bolivia, E-14/15 Vasant Vihar, New Delhi',
    'Book an appointment with the Embassy of Bolivia in New Delhi\nObtain an invitation letter from the family member resident in Bolivia\nGather passport, photo, and relationship proof\nGet the yellow fever vaccination certificate\nSubmit documents and pay the visa fee',
    '/assets/images/visa-heroes/bolivia.webp',
    'Atlys and iVisa Travel secondary sourcing', 'https://www.atlys.com/en-US/visa/bolivia-visa', '2026-09-19'
);
SET @bol5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bol5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol5, 'Core Documents', 'Required from every applicant.', 1);
SET @bol5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bol5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2),
(@bol5s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @bol5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@bol5s2, 'Confirmed Flight Tickets (Round Trip)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(198, 5, 55.00, 'USD', 'Visa-on-Arrival Fee (Santa Cruz/La Paz Only)', 'Sources disagree on the exact figure — reported as USD 55 by one source and USD 120-160 by others. Confirm the current fee with the Embassy of Bolivia before travel.', '2026-01-01', NOW(), 'https://ivisatravel.com/bolivia/c/bolivia-tourist-visa-for-indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Bolivia on the standard visa?', 'Yes — family visits use the same embassy application process as tourism, with an invitation letter and relationship proof added.', 198, 5, 19806, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    198, 6, 'BOL-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Bolivia en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard visa or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the Embassy of Bolivia or your airline whether the standard visa applies',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Bolivia, E-14/15 Vasant Vihar, New Delhi',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific visa is required\nContact the Embassy of Bolivia if needed\nSubmit passport and onward ticket for the application\nCarry the yellow fever vaccination certificate',
    '/assets/images/visa-heroes/bolivia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.atlys.com/en-US/visa/bolivia-visa', '2026-09-19'
);
SET @bol6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bol6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol6, 'Core Documents', 'Required from every applicant.', 1);
SET @bol6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bol6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @bol6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(198, 6, NULL, 'USD', 'Confirm at Embassy', 'Transit fee not independently confirmed this session; confirm with the Embassy of Bolivia.', '2026-09-01', NOW(), 'https://www.atlys.com/en-US/visa/bolivia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Bolivia?', 'Not independently confirmed this session — confirm with the Embassy of Bolivia or your airline whether your specific transit routing requires the standard visa.', 198, 6, 19807, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    198, 7, 'BOL-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Bolivia.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa with medical documentation.',
    '30 days, extendable twice for up to 90 days total',
    'Apply by appointment at the Embassy of Bolivia in New Delhi',
    1,
    'Recommended at least 10 days before travel; apply no earlier than 1 month before travel',
    'Embassy of Bolivia, E-14/15 Vasant Vihar, New Delhi',
    'Obtain a medical appointment/admission letter from the hospital\nBook an appointment with the Embassy of Bolivia\nGather passport, photo, and medical documents\nGet the yellow fever vaccination certificate\nSubmit documents and pay the visa fee',
    '/assets/images/visa-heroes/bolivia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.atlys.com/en-US/visa/bolivia-visa', '2026-09-19'
);
SET @bol7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bol7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol7, 'Core Documents', 'Required from every applicant.', 1);
SET @bol7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bol7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2),
(@bol7s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @bol7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@bol7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(198, 7, NULL, 'USD', 'Confirm at Embassy', 'Medical visa fee not independently confirmed this session; confirm with the Embassy of Bolivia.', '2026-09-01', NOW(), 'https://www.atlys.com/en-US/visa/bolivia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Bolivia?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard visa with supporting medical documentation.', 198, 7, 19808, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    198, 8, 'BOL-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Bolivia.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business visa framework with an event invitation.',
    '30 days, extendable twice for up to 90 days total',
    'Apply by appointment at the Embassy of Bolivia in New Delhi',
    1,
    'Recommended at least 10 days before travel; apply no earlier than 1 month before travel',
    'Embassy of Bolivia, E-14/15 Vasant Vihar, New Delhi',
    'Obtain an official invitation letter from the event organiser\nBook an appointment with the Embassy of Bolivia\nGather passport, photo, and event documents\nGet the yellow fever vaccination certificate\nSubmit documents and pay the visa fee',
    '/assets/images/visa-heroes/bolivia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.atlys.com/en-US/visa/bolivia-visa', '2026-09-19'
);
SET @bol8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bol8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol8, 'Core Documents', 'Required from every applicant.', 1);
SET @bol8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bol8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @bol8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(198, 8, NULL, 'USD', 'Confirm at Embassy', 'Conference visa fee not independently confirmed this session; confirm with the Embassy of Bolivia.', '2026-09-01', NOW(), 'https://www.atlys.com/en-US/visa/bolivia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Bolivia?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business visa framework with an official invitation letter.', 198, 8, 19809, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    198, 9, 'BOL-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Bolivia.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa with an event invitation.',
    '30 days, extendable twice for up to 90 days total',
    'Apply by appointment at the Embassy of Bolivia in New Delhi',
    1,
    'Recommended at least 10 days before travel; apply no earlier than 1 month before travel',
    'Embassy of Bolivia, E-14/15 Vasant Vihar, New Delhi',
    'Obtain an official invitation from the sporting federation/event organiser\nBook an appointment with the Embassy of Bolivia\nGather passport, photo, and event documents\nGet the yellow fever vaccination certificate\nSubmit documents and pay the visa fee',
    '/assets/images/visa-heroes/bolivia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.atlys.com/en-US/visa/bolivia-visa', '2026-09-19'
);
SET @bol9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bol9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol9, 'Core Documents', 'Required from every applicant.', 1);
SET @bol9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bol9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @bol9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(198, 9, NULL, 'USD', 'Confirm at Embassy', 'Sports visa fee not independently confirmed this session; confirm with the Embassy of Bolivia.', '2026-09-01', NOW(), 'https://www.atlys.com/en-US/visa/bolivia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Bolivia?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard visa with a federation/event invitation.', 198, 9, 19810, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    198, 10, 'BOL-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Bolivian work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the Embassy of Bolivia for the dependent-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Bolivia, E-14/15 Vasant Vihar, New Delhi',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nBook an appointment with the Embassy of Bolivia\nSubmit passport and supporting documents\nCarry the yellow fever vaccination certificate',
    '/assets/images/visa-heroes/bolivia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.atlys.com/en-US/visa/bolivia-visa', '2026-09-19'
);
SET @bol10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bol10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol10, 'Core Documents', 'Required from every applicant.', 1);
SET @bol10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bol10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bol10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @bol10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bol10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@bol10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(198, 10, NULL, 'USD', 'Confirm at Embassy', 'Dependent visa fee not independently confirmed this session; confirm with the Embassy of Bolivia.', '2026-09-01', NOW(), 'https://www.atlys.com/en-US/visa/bolivia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent visa in Bolivia?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the Embassy of Bolivia.', 198, 10, 19811, 1);
