-- Eritrea Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Eritrea's real, distinctive facts verified this session:
--   - All applications (Tourist, Business, Transit) must be submitted
--     to the Embassy of Eritrea in New Delhi — no eVisa or
--     visa-on-arrival. Personal presence of the applicant is
--     mandatory for biometrics and an interview — a genuinely
--     distinctive requirement versus most other countries in this
--     batch.
--   - The "Tourist Visa" category is strictly issued for tourism,
--     leisure, visit, OR business — Eritrea does not run a separate
--     standard Business visa product; both purposes share the same
--     Tourist Visa category.
--   - Transit Visa is strictly limited to 3-4 days.
--   - Validity: up to 90 days. Apply no earlier than 2 months before
--     travel; submit at least 25 days before travel.
--   - Embassy: C-7/9, Vasant Vihar, New Delhi 110057, Mon-Fri
--     9:30am-5:30pm.
--
-- country_id 16 = Eritrea. visa_type_id: 1=Tourist, 2=Business,
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
    16, 1, 'ERI-TOUR-IN-01', '2026.09', 'published',
    'Leisure, sightseeing, visit, or business travel to Eritrea — all covered under the single Eritrean Tourist Visa category.',
    'All Indian citizens require a visa via the Embassy of Eritrea in New Delhi; the Tourist Visa strictly covers tourism, leisure, visit, and business purposes together, with no separate standard Business visa product.',
    'Up to 90 days',
    'Apply in person at the Embassy of Eritrea in New Delhi — personal presence is mandatory for biometrics and an interview',
    1,
    'Apply no earlier than 2 months before travel; submit at least 25 days before travel',
    'Embassy of Eritrea, C-7/9 Vasant Vihar, New Delhi',
    'Complete the visa application form\nBook an appointment at the Embassy of Eritrea in New Delhi\nAttend in person for biometrics and an interview (mandatory — no exceptions)\nGather passport, photo, and travel documents\nSubmit documents and pay the visa fee',
    '/assets/images/visa-heroes/eritrea.webp',
    'Akbar Travels secondary sourcing', 'https://www.akbartravels.com/visa/eritrea-visa', '2026-09-19'
);
SET @eri1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eri1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri1, 'Core Documents', 'Required from every applicant.', 1);
SET @eri1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@eri1s1, 'Completed Visa Application Form', NULL, 'original', 1, 0, 1, 2),
(@eri1s1, 'Recent Passport-Size Photograph', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @eri1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri1s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 1),
(@eri1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(16, 1, NULL, 'INR', 'Confirm at Embassy', 'Fee not independently confirmed this session with an exact figure; confirm current pricing with the Embassy of Eritrea in New Delhi.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/eritrea-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Eritrea?', 'Yes — all Indian citizens require a visa, applied for in person at the Embassy of Eritrea in New Delhi. There is no eVisa or visa-on-arrival.', 16, 1, 1600, 1),
('Is an in-person interview really mandatory for an Eritrea visa?', 'Yes — the applicant''s personal presence is mandatory for biometrics and an interview at the Embassy of Eritrea; this cannot be done by post or through an agent alone.', 16, 1, 1601, 1),
('Does the Tourist Visa cover business travel to Eritrea too?', 'Yes — Eritrea''s Tourist Visa category strictly covers tourism, leisure, visit, and business purposes together, rather than running a separate standard Business visa product.', 16, 1, 1602, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    16, 2, 'ERI-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Eritrea.',
    'Business travel is processed under Eritrea''s single Tourist Visa category, which explicitly covers business purposes — there is no separate standard Business visa product.',
    'Up to 90 days',
    'Apply in person at the Embassy of Eritrea in New Delhi — personal presence is mandatory for biometrics and an interview',
    1,
    'Apply no earlier than 2 months before travel; submit at least 25 days before travel',
    'Embassy of Eritrea, C-7/9 Vasant Vihar, New Delhi',
    'Obtain a business invitation letter\nBook an appointment at the Embassy of Eritrea in New Delhi\nAttend in person for biometrics and an interview\nGather passport, photo, and supporting documents\nSubmit documents and pay the visa fee',
    '/assets/images/visa-heroes/eritrea.webp',
    'Akbar Travels secondary sourcing', 'https://www.akbartravels.com/visa/eritrea-visa', '2026-09-19'
);
SET @eri2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eri2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri2, 'Core Documents', 'Required from every applicant.', 1);
SET @eri2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@eri2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @eri2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@eri2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(16, 2, NULL, 'INR', 'Confirm at Embassy', 'Fee not independently confirmed this session; confirm with the Embassy of Eritrea in New Delhi.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/eritrea-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate business visa for Eritrea?', 'No — business travel is processed under the same Tourist Visa category, which explicitly covers business purposes alongside tourism and leisure.', 16, 2, 1603, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    16, 3, 'ERI-STUD-IN-01', '2026.09', 'published',
    'Academic study in Eritrea.',
    'Not independently confirmed this session as a distinct standard category; likely requires a long-stay visa beyond the standard 90-day Tourist Visa.',
    'Tied to the academic program duration',
    'Apply in person at the Embassy of Eritrea in New Delhi',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Eritrea, C-7/9 Vasant Vihar, New Delhi',
    'Secure admission confirmation from the Eritrean institution\nBook an appointment at the Embassy of Eritrea\nAttend in person for biometrics and an interview\nGather proof of financial support\nSubmit the visa application with required documents',
    '/assets/images/visa-heroes/eritrea.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/eritrea-visa', '2026-09-19'
);
SET @eri3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eri3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri3, 'Core Documents', 'Required from every applicant.', 1);
SET @eri3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@eri3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @eri3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@eri3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(16, 3, NULL, 'INR', 'Confirm at Embassy', 'Student visa fee not independently confirmed this session; confirm with the Embassy of Eritrea.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/eritrea-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for Eritrea?', 'Not independently confirmed this session — longer academic programs likely require a long-stay visa beyond the standard 90-day Tourist Visa. Confirm with the Embassy of Eritrea.', 16, 3, 1604, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    16, 4, 'ERI-WORK-IN-01', '2026.09', 'published',
    'Employment with an Eritrean company.',
    'Not independently confirmed this session as a distinct standard category; likely requires an employer-sponsored work permit beyond the standard Tourist Visa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the Embassy of Eritrea for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Eritrea, C-7/9 Vasant Vihar, New Delhi',
    'Secure a signed employment contract from the Eritrean employer\nBook an appointment at the Embassy of Eritrea\nAttend in person for biometrics and an interview\nGather proof of qualifications\nSubmit the visa application with required documents',
    '/assets/images/visa-heroes/eritrea.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/eritrea-visa', '2026-09-19'
);
SET @eri4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eri4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri4, 'Core Documents', 'Required from every applicant.', 1);
SET @eri4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@eri4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @eri4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@eri4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(16, 4, NULL, 'INR', 'Confirm at Embassy', 'Work permit fee not independently confirmed this session; confirm with the Embassy of Eritrea.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/eritrea-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for Eritrea beyond the Tourist Visa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit. Confirm with the Embassy of Eritrea.', 16, 4, 1605, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    16, 5, 'ERI-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Eritrea.',
    'Family visits are processed under the same Tourist Visa category, adding an invitation letter and relationship proof.',
    'Up to 90 days',
    'Apply in person at the Embassy of Eritrea in New Delhi — personal presence is mandatory for biometrics and an interview',
    1,
    'Apply no earlier than 2 months before travel; submit at least 25 days before travel',
    'Embassy of Eritrea, C-7/9 Vasant Vihar, New Delhi',
    'Obtain an invitation letter from the family member resident in Eritrea\nBook an appointment at the Embassy of Eritrea in New Delhi\nAttend in person for biometrics and an interview\nGather passport, photo, and relationship proof\nSubmit documents and pay the visa fee',
    '/assets/images/visa-heroes/eritrea.webp',
    'Akbar Travels secondary sourcing', 'https://www.akbartravels.com/visa/eritrea-visa', '2026-09-19'
);
SET @eri5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eri5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri5, 'Core Documents', 'Required from every applicant.', 1);
SET @eri5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@eri5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @eri5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@eri5s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(16, 5, NULL, 'INR', 'Confirm at Embassy', 'Fee not independently confirmed this session; confirm with the Embassy of Eritrea.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/eritrea-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Eritrea on the standard Tourist Visa?', 'Yes — family visits are processed under the same Tourist Visa category, with an invitation letter and relationship proof added.', 16, 5, 1606, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    16, 6, 'ERI-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Eritrea en route to a third country.',
    'A distinct Transit Visa category exists, strictly limited to a 3-4 day stay — issued to persons transiting through Eritrea within that window.',
    '3-4 days maximum',
    'Apply in person at the Embassy of Eritrea in New Delhi — personal presence is mandatory for biometrics and an interview',
    1,
    'Apply no earlier than 2 months before travel; submit at least 25 days before travel',
    'Embassy of Eritrea, C-7/9 Vasant Vihar, New Delhi',
    'Confirm onward travel itinerary and connecting flight/transport\nBook an appointment at the Embassy of Eritrea in New Delhi\nAttend in person for biometrics and an interview\nGather passport, photo, and onward ticket\nSubmit documents and pay the visa fee',
    '/assets/images/visa-heroes/eritrea.webp',
    'Akbar Travels secondary sourcing', 'https://www.akbartravels.com/visa/eritrea-visa', '2026-09-19'
);
SET @eri6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eri6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri6, 'Core Documents', 'Required from every applicant.', 1);
SET @eri6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@eri6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @eri6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(16, 6, NULL, 'INR', 'Confirm at Embassy', 'Transit visa fee not independently confirmed this session; confirm with the Embassy of Eritrea.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/eritrea-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How long can I stay in Eritrea on a transit visa?', 'The Eritrea Transit Visa is strictly limited to 3-4 days, issued specifically for travellers passing through en route to a third country.', 16, 6, 1607, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    16, 7, 'ERI-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Eritrea.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard Tourist Visa with medical documentation.',
    'Up to 90 days',
    'Apply in person at the Embassy of Eritrea in New Delhi — personal presence is mandatory for biometrics and an interview',
    1,
    'Apply no earlier than 2 months before travel; submit at least 25 days before travel',
    'Embassy of Eritrea, C-7/9 Vasant Vihar, New Delhi',
    'Obtain a medical appointment/admission letter from the hospital\nBook an appointment at the Embassy of Eritrea in New Delhi\nAttend in person for biometrics and an interview\nGather passport, photo, and medical documents\nSubmit documents and pay the visa fee',
    '/assets/images/visa-heroes/eritrea.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/eritrea-visa', '2026-09-19'
);
SET @eri7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eri7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri7, 'Core Documents', 'Required from every applicant.', 1);
SET @eri7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@eri7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @eri7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@eri7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(16, 7, NULL, 'INR', 'Confirm at Embassy', 'Fee not independently confirmed this session; confirm with the Embassy of Eritrea.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/eritrea-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Eritrea?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard Tourist Visa with supporting medical documentation.', 16, 7, 1608, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    16, 8, 'ERI-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Eritrea.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Tourist Visa (which covers business purposes) with an event invitation.',
    'Up to 90 days',
    'Apply in person at the Embassy of Eritrea in New Delhi — personal presence is mandatory for biometrics and an interview',
    1,
    'Apply no earlier than 2 months before travel; submit at least 25 days before travel',
    'Embassy of Eritrea, C-7/9 Vasant Vihar, New Delhi',
    'Obtain an official invitation letter from the event organiser\nBook an appointment at the Embassy of Eritrea in New Delhi\nAttend in person for biometrics and an interview\nGather passport, photo, and event documents\nSubmit documents and pay the visa fee',
    '/assets/images/visa-heroes/eritrea.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/eritrea-visa', '2026-09-19'
);
SET @eri8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eri8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri8, 'Core Documents', 'Required from every applicant.', 1);
SET @eri8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@eri8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @eri8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(16, 8, NULL, 'INR', 'Confirm at Embassy', 'Fee not independently confirmed this session; confirm with the Embassy of Eritrea.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/eritrea-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Eritrea?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Tourist Visa, which already covers business purposes, with an official invitation letter.', 16, 8, 1609, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    16, 9, 'ERI-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Eritrea.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard Tourist Visa with an event invitation.',
    'Up to 90 days',
    'Apply in person at the Embassy of Eritrea in New Delhi — personal presence is mandatory for biometrics and an interview',
    1,
    'Apply no earlier than 2 months before travel; submit at least 25 days before travel',
    'Embassy of Eritrea, C-7/9 Vasant Vihar, New Delhi',
    'Obtain an official invitation from the sporting federation/event organiser\nBook an appointment at the Embassy of Eritrea in New Delhi\nAttend in person for biometrics and an interview\nGather passport, photo, and event documents\nSubmit documents and pay the visa fee',
    '/assets/images/visa-heroes/eritrea.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/eritrea-visa', '2026-09-19'
);
SET @eri9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eri9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri9, 'Core Documents', 'Required from every applicant.', 1);
SET @eri9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@eri9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @eri9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(16, 9, NULL, 'INR', 'Confirm at Embassy', 'Fee not independently confirmed this session; confirm with the Embassy of Eritrea.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/eritrea-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Eritrea?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard Tourist Visa with a federation/event invitation.', 16, 9, 1610, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    16, 10, 'ERI-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Eritrean work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the Embassy of Eritrea for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Eritrea, C-7/9 Vasant Vihar, New Delhi',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nBook an appointment at the Embassy of Eritrea\nAttend in person for biometrics and an interview\nSubmit passport and supporting documents',
    '/assets/images/visa-heroes/eritrea.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/eritrea-visa', '2026-09-19'
);
SET @eri10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eri10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri10, 'Core Documents', 'Required from every applicant.', 1);
SET @eri10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@eri10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eri10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @eri10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eri10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@eri10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(16, 10, NULL, 'INR', 'Confirm at Embassy', 'Dependent permit fee not independently confirmed this session; confirm with the Embassy of Eritrea.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/eritrea-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Eritrea?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the Embassy of Eritrea.', 16, 10, 1611, 1);
