-- Equatorial Guinea Visa Checklist Engine content for all 10 visa
-- types — built fresh this session via web search.
--
-- Equatorial Guinea's real, distinctive facts verified this session:
--   - eVisa system live since 1 July 2023; fee USD 75, approval
--     normally within 24-72 hours (one source cites up to 10 days).
--   - Distinctive requirement: eVisa holders must arrive specifically
--     via Malabo International Airport — other ports of entry are
--     not confirmed to accept the eVisa.
--   - Single-entry only. Sources disagree on exact validity — one
--     describes a 90-day stay from entry, another a 30-day
--     validity/30-day max stay — flagged honestly rather than
--     resolved.
--   - Yellow fever AND polio vaccination certificates are both
--     mandatory for all travellers regardless of origin, and are
--     strictly checked on arrival.
--
-- country_id 15 = Equatorial Guinea. visa_type_id: 1=Tourist,
-- 2=Business, 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical,
-- 8=Conference, 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    15, 1, 'GNQ-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Equatorial Guinea.',
    'Indian citizens require an eVisa, applied for entirely online — approved eVisa holders must arrive specifically via Malabo International Airport.',
    'Sources disagree — reported as either up to 90 days from entry, or 30 days validity/30-day max stay',
    'Apply online for the eVisa via the official portal — single entry only',
    0,
    'Normally 24-72 hours; one source reports up to 10 days',
    'Equatorial Guinea eVisa Portal (online) — no in-person appearance required',
    'Complete the online eVisa application form\nUpload passport bio page and white-background photo\nGet yellow fever AND polio vaccination certificates (both mandatory)\nPay the USD 75 eVisa fee online\nPrint the eVisa approval confirmation and arrive via Malabo International Airport',
    '/assets/images/visa-heroes/equatorial-guinea.webp',
    'evisaguides.com and visaja.com secondary sourcing; sources disagree on exact validity period', 'https://evisaguides.com/en/destination/equatorial-guinea/', '2026-09-19'
);
SET @gnq1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnq1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq1, 'Core Documents', 'Required from every applicant.', 1);
SET @gnq1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnq1s1, 'Passport-Size Photograph (White Background)', NULL, 'copy', 1, 0, 1, 2),
(@gnq1s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 3),
(@gnq1s1, 'Polio Vaccination Certificate', NULL, 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq1, 'Supporting Documents', 'Evidence of your travel plans.', 2);
SET @gnq1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq1s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@gnq1s2, 'Printed eVisa Approval Confirmation', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(15, 1, 75.00, 'USD', 'eVisa Fee (Single-Entry)', 'Single entry only via the eVisa portal; arrival must be via Malabo International Airport.', '2026-01-01', NOW(), 'https://evisaguides.com/en/destination/equatorial-guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Equatorial Guinea?', 'Yes — an eVisa is required, applied for entirely online since it launched on 1 July 2023.', 15, 1, 1500, 1),
('Can I arrive at any airport with an Equatorial Guinea eVisa?', 'No — eVisa holders must arrive specifically via Malabo International Airport; other ports of entry are not confirmed to accept the eVisa.', 15, 1, 1501, 1),
('Are vaccinations mandatory for Equatorial Guinea?', 'Yes — both yellow fever and polio vaccination certificates are mandatory for all travellers regardless of origin, and are strictly checked on arrival.', 15, 1, 1502, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    15, 2, 'GNQ-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Equatorial Guinea.',
    'Business travellers use the same eVisa framework as tourists, adding a business invitation letter.',
    'Sources disagree — reported as either up to 90 days from entry, or 30 days validity/30-day max stay',
    'Apply online for the eVisa via the official portal — single entry only',
    0,
    'Normally 24-72 hours; one source reports up to 10 days',
    'Equatorial Guinea eVisa Portal (online) — no in-person appearance required',
    'Obtain a business invitation letter\nComplete the online eVisa application form\nGet yellow fever AND polio vaccination certificates\nPay the USD 75 eVisa fee online\nPrint the eVisa approval confirmation and arrive via Malabo International Airport',
    '/assets/images/visa-heroes/equatorial-guinea.webp',
    'evisaguides.com and visaja.com secondary sourcing', 'https://evisaguides.com/en/destination/equatorial-guinea/', '2026-09-19'
);
SET @gnq2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnq2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq2, 'Core Documents', 'Required from every applicant.', 1);
SET @gnq2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnq2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2),
(@gnq2s1, 'Yellow Fever and Polio Vaccination Certificates', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @gnq2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@gnq2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(15, 2, 75.00, 'USD', 'eVisa Fee (Single-Entry)', 'Single entry only; arrival must be via Malabo International Airport.', '2026-01-01', NOW(), 'https://evisaguides.com/en/destination/equatorial-guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can business travellers get a multiple-entry eVisa for Equatorial Guinea?', 'Not independently confirmed this session — the eVisa is documented as single-entry only. Confirm current multiple-entry options with the official portal if needed.', 15, 2, 1503, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    15, 3, 'GNQ-STUD-IN-01', '2026.09', 'published',
    'Academic study in Equatorial Guinea.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires a long-stay visa beyond the standard eVisa.',
    'Tied to the academic program duration',
    'Confirm with the nearest Equatorial Guinea mission for the student-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Equatorial Guinea diplomatic mission (confirm current jurisdiction serving India)',
    'Secure admission confirmation from the Equatoguinean institution\nCheck whether the standard eVisa or a separate student visa applies\nGather proof of financial support\nGet yellow fever and polio vaccination certificates\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/equatorial-guinea.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisaguides.com/en/destination/equatorial-guinea/', '2026-09-19'
);
SET @gnq3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnq3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq3, 'Core Documents', 'Required from every applicant.', 1);
SET @gnq3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnq3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @gnq3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@gnq3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(15, 3, NULL, 'USD', 'Confirm at Mission', 'Student visa fee not independently confirmed this session; confirm with the relevant Equatorial Guinea mission.', '2026-09-01', NOW(), 'https://evisaguides.com/en/destination/equatorial-guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for Equatorial Guinea?', 'Not independently confirmed this session — longer academic programs likely require a long-stay visa beyond the standard eVisa. Confirm with the relevant mission.', 15, 3, 1504, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    15, 4, 'GNQ-WORK-IN-01', '2026.09', 'published',
    'Employment with an Equatorial Guinean company (notably the country''s oil and gas sector).',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires an employer-sponsored work permit beyond the standard eVisa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the nearest Equatorial Guinea mission for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Equatorial Guinea diplomatic mission (confirm current jurisdiction serving India)',
    'Secure a signed employment contract from the Equatoguinean employer\nCheck whether a separate work permit is required beyond the eVisa\nGather proof of qualifications\nGet yellow fever and polio vaccination certificates\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/equatorial-guinea.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisaguides.com/en/destination/equatorial-guinea/', '2026-09-19'
);
SET @gnq4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnq4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq4, 'Core Documents', 'Required from every applicant.', 1);
SET @gnq4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnq4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @gnq4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@gnq4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(15, 4, NULL, 'USD', 'Confirm at Mission', 'Work permit fee not independently confirmed this session; confirm with the relevant Equatorial Guinea mission.', '2026-09-01', NOW(), 'https://evisaguides.com/en/destination/equatorial-guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for Equatorial Guinea beyond the eVisa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit. Confirm with the relevant mission.', 15, 4, 1505, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    15, 5, 'GNQ-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Equatorial Guinea.',
    'Family visits use the same eVisa framework as tourism, adding an invitation letter and relationship proof.',
    'Sources disagree — reported as either up to 90 days from entry, or 30 days validity/30-day max stay',
    'Apply online for the eVisa via the official portal — single entry only',
    0,
    'Normally 24-72 hours; one source reports up to 10 days',
    'Equatorial Guinea eVisa Portal (online) — no in-person appearance required',
    'Obtain an invitation letter from the family member resident in Equatorial Guinea\nComplete the online eVisa application form\nGet yellow fever and polio vaccination certificates\nPay the USD 75 eVisa fee online\nPrint the eVisa approval confirmation and arrive via Malabo International Airport',
    '/assets/images/visa-heroes/equatorial-guinea.webp',
    'evisaguides.com and visaja.com secondary sourcing', 'https://evisaguides.com/en/destination/equatorial-guinea/', '2026-09-19'
);
SET @gnq5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnq5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq5, 'Core Documents', 'Required from every applicant.', 1);
SET @gnq5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnq5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @gnq5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@gnq5s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(15, 5, 75.00, 'USD', 'eVisa Fee (Single-Entry)', 'Single entry only; arrival must be via Malabo International Airport.', '2026-01-01', NOW(), 'https://evisaguides.com/en/destination/equatorial-guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Equatorial Guinea on the standard eVisa?', 'Yes — family visits use the same eVisa framework as tourism, with an invitation letter and relationship proof added.', 15, 5, 1506, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    15, 6, 'GNQ-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Equatorial Guinea en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard eVisa or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the eVisa portal or your airline whether the standard eVisa applies',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Equatorial Guinea eVisa Portal (online) — no in-person appearance required',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific eVisa is required\nComplete the online application if needed\nGet yellow fever and polio vaccination certificates\nConfirm requirements with your airline before travel',
    '/assets/images/visa-heroes/equatorial-guinea.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisaguides.com/en/destination/equatorial-guinea/', '2026-09-19'
);
SET @gnq6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnq6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq6, 'Core Documents', 'Required from every applicant.', 1);
SET @gnq6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnq6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @gnq6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(15, 6, NULL, 'USD', 'Confirm at Portal', 'Transit fee not independently confirmed this session; confirm on the official eVisa portal.', '2026-09-01', NOW(), 'https://evisaguides.com/en/destination/equatorial-guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Equatorial Guinea?', 'Not independently confirmed this session — confirm with the eVisa portal or your airline whether your specific transit routing requires the standard eVisa.', 15, 6, 1507, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    15, 7, 'GNQ-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Equatorial Guinea.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with medical documentation.',
    'Sources disagree — reported as either up to 90 days from entry, or 30 days validity/30-day max stay',
    'Apply online for the eVisa via the official portal — single entry only',
    0,
    'Normally 24-72 hours; one source reports up to 10 days',
    'Equatorial Guinea eVisa Portal (online) — no in-person appearance required',
    'Obtain a medical appointment/admission letter from the hospital\nComplete the online eVisa application form\nGet yellow fever and polio vaccination certificates\nPay the USD 75 eVisa fee online\nPrint the eVisa approval confirmation and arrive via Malabo International Airport',
    '/assets/images/visa-heroes/equatorial-guinea.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisaguides.com/en/destination/equatorial-guinea/', '2026-09-19'
);
SET @gnq7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnq7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq7, 'Core Documents', 'Required from every applicant.', 1);
SET @gnq7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnq7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @gnq7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@gnq7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(15, 7, 75.00, 'USD', 'eVisa Fee (Single-Entry)', 'Single entry only; arrival must be via Malabo International Airport.', '2026-01-01', NOW(), 'https://evisaguides.com/en/destination/equatorial-guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Equatorial Guinea?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard eVisa with supporting medical documentation.', 15, 7, 1508, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    15, 8, 'GNQ-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Equatorial Guinea.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business eVisa framework with an event invitation.',
    'Sources disagree — reported as either up to 90 days from entry, or 30 days validity/30-day max stay',
    'Apply online for the eVisa via the official portal — single entry only',
    0,
    'Normally 24-72 hours; one source reports up to 10 days',
    'Equatorial Guinea eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation letter from the event organiser\nComplete the online eVisa application form\nGet yellow fever and polio vaccination certificates\nPay the USD 75 eVisa fee online\nPrint the eVisa approval confirmation and arrive via Malabo International Airport',
    '/assets/images/visa-heroes/equatorial-guinea.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisaguides.com/en/destination/equatorial-guinea/', '2026-09-19'
);
SET @gnq8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnq8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq8, 'Core Documents', 'Required from every applicant.', 1);
SET @gnq8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnq8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @gnq8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(15, 8, 75.00, 'USD', 'eVisa Fee (Single-Entry)', 'Single entry only; arrival must be via Malabo International Airport.', '2026-01-01', NOW(), 'https://evisaguides.com/en/destination/equatorial-guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Equatorial Guinea?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business eVisa framework with an official invitation letter.', 15, 8, 1509, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    15, 9, 'GNQ-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Equatorial Guinea.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with an event invitation.',
    'Sources disagree — reported as either up to 90 days from entry, or 30 days validity/30-day max stay',
    'Apply online for the eVisa via the official portal — single entry only',
    0,
    'Normally 24-72 hours; one source reports up to 10 days',
    'Equatorial Guinea eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation from the sporting federation/event organiser\nComplete the online eVisa application form\nGet yellow fever and polio vaccination certificates\nPay the USD 75 eVisa fee online\nPrint the eVisa approval confirmation and arrive via Malabo International Airport',
    '/assets/images/visa-heroes/equatorial-guinea.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisaguides.com/en/destination/equatorial-guinea/', '2026-09-19'
);
SET @gnq9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnq9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq9, 'Core Documents', 'Required from every applicant.', 1);
SET @gnq9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnq9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @gnq9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(15, 9, 75.00, 'USD', 'eVisa Fee (Single-Entry)', 'Single entry only; arrival must be via Malabo International Airport.', '2026-01-01', NOW(), 'https://evisaguides.com/en/destination/equatorial-guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Equatorial Guinea?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard eVisa with a federation/event invitation.', 15, 9, 1510, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    15, 10, 'GNQ-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Equatorial Guinea work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the nearest Equatorial Guinea mission for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Equatorial Guinea diplomatic mission (confirm current jurisdiction serving India)',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply via the relevant mission\nGet yellow fever and polio vaccination certificates\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/equatorial-guinea.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://evisaguides.com/en/destination/equatorial-guinea/', '2026-09-19'
);
SET @gnq10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnq10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq10, 'Core Documents', 'Required from every applicant.', 1);
SET @gnq10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnq10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnq10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @gnq10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnq10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@gnq10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(15, 10, NULL, 'USD', 'Confirm at Mission', 'Dependent permit fee not independently confirmed this session; confirm with the relevant Equatorial Guinea mission.', '2026-09-01', NOW(), 'https://evisaguides.com/en/destination/equatorial-guinea/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Equatorial Guinea?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the relevant mission.', 15, 10, 1511, 1);
