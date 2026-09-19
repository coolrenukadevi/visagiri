-- Gabon Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Gabon's real, distinctive facts verified this session:
--   - Indian citizens apply for an eVisa online; airside transit
--     (staying within the airport) is permitted without a separate
--     visa.
--   - Fee: INR 8,038 (~USD 85) for a 90-day stay.
--   - Processing: 3-5 working days; apply at least 5 days before
--     travel.
--   - Distinctive requirement: eVisa holders must arrive specifically
--     via Libreville International Airport.
--
-- country_id 19 = Gabon. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    19, 1, 'GAB-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Gabon.',
    'Indian citizens require an eVisa before travel; apply entirely online, with arrival specifically via Libreville International Airport.',
    'Up to 90 days',
    'Apply online for the eVisa via the official portal',
    0,
    '3-5 working days; apply at least 5 days before travel',
    'Gabon eVisa Portal (online) — no in-person appearance required',
    'Complete the online eVisa application form\nUpload passport bio-data page scan and JPG/JPEG passport-size photo\nPay the INR 8,038 eVisa fee online\nReceive the eVisa by email and carry it with your passport\nArrive specifically via Libreville International Airport',
    '/assets/images/visa-heroes/gabon.webp',
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/gabon-ga', '2026-09-19'
);
SET @gab1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gab1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab1, 'Core Documents', 'Required from every applicant.', 1);
SET @gab1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gab1s1, 'Passport-Size Photograph (JPG/JPEG)', NULL, 'copy', 1, 0, 1, 2),
(@gab1s1, 'Completed Online eVisa Application', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @gab1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab1s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 1),
(@gab1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(19, 1, 8038.00, 'INR', 'eVisa Fee', 'Approximately USD 85 equivalent, for a 90-day stay.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/gabon-ga', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Gabon?', 'Yes — an eVisa is required, applied for entirely online, with a fee of INR 8,038 for a 90-day stay.', 19, 1, 1900, 1),
('Which airport must I arrive at with a Gabon eVisa?', 'eVisa holders must arrive specifically via Libreville International Airport.', 19, 1, 1901, 1),
('Do I need a visa if I''m just transiting through Gabon without leaving the airport?', 'No — airside transit (staying within the airport) is permitted without a separate visa.', 19, 1, 1902, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    19, 2, 'GAB-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Gabon.',
    'Business travellers use the same eVisa framework as tourists, adding a business invitation letter.',
    'Up to 90 days',
    'Apply online for the eVisa via the official portal',
    0,
    '3-5 working days; apply at least 5 days before travel',
    'Gabon eVisa Portal (online) — no in-person appearance required',
    'Obtain a business invitation letter\nComplete the online eVisa application form\nUpload passport, photo, and supporting documents\nPay the eVisa fee online\nArrive specifically via Libreville International Airport',
    '/assets/images/visa-heroes/gabon.webp',
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/gabon-ga', '2026-09-19'
);
SET @gab2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gab2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab2, 'Core Documents', 'Required from every applicant.', 1);
SET @gab2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gab2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @gab2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@gab2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(19, 2, 8038.00, 'INR', 'eVisa Fee', 'Approximately USD 85 equivalent, for a 90-day stay.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/gabon-ga', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use the same eVisa portal for business travel to Gabon?', 'Yes — business travellers use the same eVisa framework as tourists, adding a business invitation letter.', 19, 2, 1903, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    19, 3, 'GAB-STUD-IN-01', '2026.09', 'published',
    'Academic study in Gabon.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires a long-stay visa beyond the standard 90-day eVisa.',
    'Tied to the academic program duration',
    'Confirm with the nearest Gabon mission for the student-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Gabon diplomatic mission (confirm current jurisdiction serving India)',
    'Secure admission confirmation from the Gabonese institution\nCheck whether the standard eVisa or a separate student visa applies\nGather proof of financial support\nApply via the relevant mission or eVisa portal\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/gabon.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/gabon-ga', '2026-09-19'
);
SET @gab3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gab3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab3, 'Core Documents', 'Required from every applicant.', 1);
SET @gab3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gab3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @gab3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@gab3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(19, 3, NULL, 'INR', 'Confirm at Mission', 'Student visa fee not independently confirmed this session; confirm with the relevant Gabon mission.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/gabon-ga', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for Gabon?', 'Not independently confirmed this session — longer academic programs likely require a long-stay visa beyond the standard 90-day eVisa. Confirm with the relevant mission.', 19, 3, 1904, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    19, 4, 'GAB-WORK-IN-01', '2026.09', 'published',
    'Employment with a Gabonese company.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires an employer-sponsored work permit beyond the standard eVisa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the nearest Gabon mission for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Gabon diplomatic mission (confirm current jurisdiction serving India)',
    'Secure a signed employment contract from the Gabonese employer\nCheck whether a separate work permit is required beyond the eVisa\nGather proof of qualifications\nApply via the relevant mission\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/gabon.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/gabon-ga', '2026-09-19'
);
SET @gab4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gab4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab4, 'Core Documents', 'Required from every applicant.', 1);
SET @gab4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gab4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @gab4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@gab4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(19, 4, NULL, 'INR', 'Confirm at Mission', 'Work permit fee not independently confirmed this session; confirm with the relevant Gabon mission.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/gabon-ga', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for Gabon beyond the eVisa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit. Confirm with the relevant mission.', 19, 4, 1905, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    19, 5, 'GAB-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Gabon.',
    'Family visits use the same eVisa framework as tourism, adding an invitation letter and relationship proof.',
    'Up to 90 days',
    'Apply online for the eVisa via the official portal',
    0,
    '3-5 working days; apply at least 5 days before travel',
    'Gabon eVisa Portal (online) — no in-person appearance required',
    'Obtain an invitation letter from the family member resident in Gabon\nComplete the online eVisa application form\nUpload passport, photo, and relationship proof\nPay the eVisa fee online\nArrive specifically via Libreville International Airport',
    '/assets/images/visa-heroes/gabon.webp',
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/gabon-ga', '2026-09-19'
);
SET @gab5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gab5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab5, 'Core Documents', 'Required from every applicant.', 1);
SET @gab5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gab5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @gab5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@gab5s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(19, 5, 8038.00, 'INR', 'eVisa Fee', 'Approximately USD 85 equivalent, for a 90-day stay.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/gabon-ga', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Gabon on the standard eVisa?', 'Yes — family visits use the same eVisa framework as tourism, with an invitation letter and relationship proof added.', 19, 5, 1906, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    19, 6, 'GAB-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Gabon en route to a third country.',
    'Airside transit (staying within the airport) is permitted without a separate visa; leaving the airport likely requires the standard eVisa.',
    'Short duration tied to the transit itinerary',
    'No visa needed for airside transit; apply for the standard eVisa if leaving the airport',
    0,
    'Not applicable for airside transit; 3-5 working days if the standard eVisa is needed',
    'Gabon eVisa Portal (online) — no in-person appearance required if applying',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether you will remain airside or need to leave the airport\nIf leaving the airport, apply for the standard eVisa online\nCarry your passport and onward ticket\nConfirm requirements with your airline before travel',
    '/assets/images/visa-heroes/gabon.webp',
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/gabon-ga', '2026-09-19'
);
SET @gab6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gab6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab6, 'Core Documents', 'Required from every applicant.', 1);
SET @gab6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gab6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @gab6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(19, 6, 0.00, 'INR', 'No Fee for Airside Transit', 'A standard eVisa fee (INR 8,038) applies only if leaving the airport.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/gabon-ga', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Gabon?', 'Not if you stay airside within the airport — this is permitted without a separate visa. If you need to leave the airport, the standard eVisa applies.', 19, 6, 1907, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    19, 7, 'GAB-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Gabon.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with medical documentation.',
    'Up to 90 days',
    'Apply online for the eVisa via the official portal',
    0,
    '3-5 working days; apply at least 5 days before travel',
    'Gabon eVisa Portal (online) — no in-person appearance required',
    'Obtain a medical appointment/admission letter from the hospital\nComplete the online eVisa application form\nUpload passport, photo, and medical documents\nPay the eVisa fee online\nArrive specifically via Libreville International Airport',
    '/assets/images/visa-heroes/gabon.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/gabon-ga', '2026-09-19'
);
SET @gab7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gab7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab7, 'Core Documents', 'Required from every applicant.', 1);
SET @gab7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gab7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @gab7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@gab7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(19, 7, 8038.00, 'INR', 'eVisa Fee', 'Approximately USD 85 equivalent, for a 90-day stay.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/gabon-ga', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Gabon?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard eVisa with supporting medical documentation.', 19, 7, 1908, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    19, 8, 'GAB-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Gabon.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business eVisa framework with an event invitation.',
    'Up to 90 days',
    'Apply online for the eVisa via the official portal',
    0,
    '3-5 working days; apply at least 5 days before travel',
    'Gabon eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation letter from the event organiser\nComplete the online eVisa application form\nUpload passport, photo, and event documents\nPay the eVisa fee online\nArrive specifically via Libreville International Airport',
    '/assets/images/visa-heroes/gabon.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/gabon-ga', '2026-09-19'
);
SET @gab8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gab8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab8, 'Core Documents', 'Required from every applicant.', 1);
SET @gab8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gab8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @gab8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(19, 8, 8038.00, 'INR', 'eVisa Fee', 'Approximately USD 85 equivalent, for a 90-day stay.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/gabon-ga', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Gabon?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business eVisa framework with an official invitation letter.', 19, 8, 1909, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    19, 9, 'GAB-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Gabon.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with an event invitation.',
    'Up to 90 days',
    'Apply online for the eVisa via the official portal',
    0,
    '3-5 working days; apply at least 5 days before travel',
    'Gabon eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation from the sporting federation/event organiser\nComplete the online eVisa application form\nUpload passport, photo, and event documents\nPay the eVisa fee online\nArrive specifically via Libreville International Airport',
    '/assets/images/visa-heroes/gabon.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/gabon-ga', '2026-09-19'
);
SET @gab9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gab9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab9, 'Core Documents', 'Required from every applicant.', 1);
SET @gab9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gab9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @gab9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(19, 9, 8038.00, 'INR', 'eVisa Fee', 'Approximately USD 85 equivalent, for a 90-day stay.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/gabon-ga', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Gabon?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard eVisa with a federation/event invitation.', 19, 9, 1910, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    19, 10, 'GAB-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Gabonese work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the nearest Gabon mission for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Gabon diplomatic mission (confirm current jurisdiction serving India)',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply via the relevant mission\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/gabon.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/gabon-ga', '2026-09-19'
);
SET @gab10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gab10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab10, 'Core Documents', 'Required from every applicant.', 1);
SET @gab10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gab10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gab10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @gab10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gab10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@gab10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(19, 10, NULL, 'INR', 'Confirm at Mission', 'Dependent permit fee not independently confirmed this session; confirm with the relevant Gabon mission.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/gabon-ga', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Gabon?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the relevant mission.', 19, 10, 1911, 1);
