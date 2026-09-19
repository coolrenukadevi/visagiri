-- Burundi Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Burundi's real, distinctive facts verified this session:
--   - All nationalities, including India, receive visa-on-arrival at
--     Bujumbura International Airport and all land borders — no
--     advance application or eVisa needed for the on-arrival route.
--   - Maximum stay: 1 month (30 days).
--   - Fee: sources show some discrepancy — USD 40 single-entry / USD
--     90 multiple-entry per one source; USD 90 single-entry per
--     another. Flagged honestly; carry exact USD or EUR 40 notes as
--     change is often unavailable at the visa counter.
--   - Yellow fever vaccination certificate is required for entry.
--
-- country_id 6 = Burundi. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Visa on Arrival
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    6, 1, 'BDI-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Burundi.',
    'Indian citizens receive visa-on-arrival at Bujumbura International Airport and all land borders — no advance application needed.',
    'Up to 1 month (30 days)',
    'Visa-on-arrival at Bujumbura International Airport or any land border — no advance application required',
    1,
    'Processed on the spot at the port of entry',
    'Bujumbura International Airport or any Burundi land border immigration counter',
    'Get the yellow fever vaccination before travel (mandatory)\nCarry your passport, photo, and exact USD/EUR cash for the fee\nPresent documents at the visa-on-arrival counter on arrival\nPay the visa fee (small change is often unavailable — bring exact notes)\nReceive your visa stamp and proceed through immigration',
    '/assets/images/visa-heroes/burundi.webp',
    'thingstodoinburundi.com and Burundi Embassy secondary sourcing; sources disagree on the exact fee figure', 'https://thingstodoinburundi.com/entry-requirements/', '2026-09-19'
);
SET @bdi1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bdi1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi1, 'Core Documents', 'Required from every traveller.', 1);
SET @bdi1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bdi1s1, 'Recent Passport-Size Photograph', NULL, 'original', 1, 0, 1, 2),
(@bdi1s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @bdi1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi1s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 1),
(@bdi1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(6, 1, 40.00, 'USD', 'Single-Entry Visa-on-Arrival Fee', 'Sources disagree — one reports USD 40 single-entry/USD 90 multiple-entry, another reports USD 90 single-entry. Confirm the current fee at the port of entry and carry exact cash.', '2026-01-01', NOW(), 'https://thingstodoinburundi.com/entry-requirements/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa in advance for Burundi?', 'No — Indian citizens receive visa-on-arrival at Bujumbura International Airport and all land borders, valid for up to 1 month.', 6, 1, 600, 1),
('What is the Burundi visa-on-arrival fee?', 'Sources disagree — reported as USD 40 (single-entry) to USD 90 (multiple-entry or single-entry depending on the source). Carry exact USD or EUR 40 notes, as change is often unavailable at the counter.', 6, 1, 601, 1),
('Is a yellow fever certificate mandatory for Burundi?', 'Yes — a yellow fever vaccination certificate is required for entry.', 6, 1, 602, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Visa on Arrival
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    6, 2, 'BDI-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Burundi.',
    'Business travellers use the same visa-on-arrival framework as tourists, adding a business invitation letter.',
    'Up to 1 month (30 days)',
    'Visa-on-arrival at Bujumbura International Airport or any land border — no advance application required',
    1,
    'Processed on the spot at the port of entry',
    'Bujumbura International Airport or any Burundi land border immigration counter',
    'Obtain a business invitation letter\nGet the yellow fever vaccination before travel (mandatory)\nCarry your passport, photo, and exact USD/EUR cash for the fee\nPresent documents at the visa-on-arrival counter on arrival\nPay the visa fee and receive your visa stamp',
    '/assets/images/visa-heroes/burundi.webp',
    'thingstodoinburundi.com and Burundi Embassy secondary sourcing', 'https://thingstodoinburundi.com/entry-requirements/', '2026-09-19'
);
SET @bdi2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bdi2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi2, 'Core Documents', 'Required from every traveller.', 1);
SET @bdi2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bdi2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2),
(@bdi2s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @bdi2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@bdi2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(6, 2, 90.00, 'USD', 'Multiple-Entry Visa-on-Arrival Fee', 'Single-entry is reported at USD 40 by one source. Sources disagree on exact figures — confirm at the port of entry and carry exact cash.', '2026-01-01', NOW(), 'https://thingstodoinburundi.com/entry-requirements/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should business travellers get the multiple-entry visa?', 'If you expect repeat trips to Burundi, the multiple-entry visa-on-arrival may be more convenient than single-entry — confirm current fees at the port of entry.', 6, 2, 603, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    6, 3, 'BDI-STUD-IN-01', '2026.09', 'published',
    'Academic study in Burundi.',
    'Not independently confirmed this session as covered by visa-on-arrival; longer academic programs likely require a residence permit beyond the 30-day entry visa.',
    'Tied to the academic program duration',
    'Confirm with the nearest Burundi mission or immigration authority for the student-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Burundi diplomatic mission (confirm current jurisdiction serving India) or Burundi immigration authority',
    'Secure admission confirmation from the Burundian institution\nCheck whether visa-on-arrival or a separate student permit applies\nGather proof of financial support\nGet the yellow fever vaccination certificate\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/burundi.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://thingstodoinburundi.com/entry-requirements/', '2026-09-19'
);
SET @bdi3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bdi3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi3, 'Core Documents', 'Required from every applicant.', 1);
SET @bdi3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bdi3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2),
(@bdi3s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @bdi3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bdi3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(6, 3, NULL, 'USD', 'Confirm with Immigration', 'Student permit fee not independently confirmed this session; confirm with the relevant Burundi authority.', '2026-09-01', NOW(), 'https://thingstodoinburundi.com/entry-requirements/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student permit for Burundi?', 'Not independently confirmed this session — longer academic programs likely require a residence/student permit beyond the standard 30-day visa-on-arrival. Confirm with the relevant authority.', 6, 3, 604, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    6, 4, 'BDI-WORK-IN-01', '2026.09', 'published',
    'Employment with a Burundian company.',
    'Not independently confirmed this session as covered by visa-on-arrival; likely requires an employer-sponsored work permit beyond the 30-day entry visa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and Burundi immigration authority for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Burundi diplomatic mission (confirm current jurisdiction serving India) or Burundi immigration authority',
    'Secure a signed employment contract from the Burundian employer\nCheck whether a separate work permit is required beyond the entry visa\nGather proof of qualifications\nGet the yellow fever vaccination certificate\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/burundi.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://thingstodoinburundi.com/entry-requirements/', '2026-09-19'
);
SET @bdi4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bdi4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi4, 'Core Documents', 'Required from every applicant.', 1);
SET @bdi4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bdi4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@bdi4s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @bdi4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bdi4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(6, 4, NULL, 'USD', 'Confirm with Immigration', 'Work permit fee not independently confirmed this session; confirm with Burundi immigration authority.', '2026-09-01', NOW(), 'https://thingstodoinburundi.com/entry-requirements/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for Burundi beyond the entry visa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit. Confirm with the relevant authority.', 6, 4, 605, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Visa on Arrival
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    6, 5, 'BDI-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Burundi.',
    'Family visits use the same visa-on-arrival framework as tourism, adding an invitation letter and relationship proof.',
    'Up to 1 month (30 days)',
    'Visa-on-arrival at Bujumbura International Airport or any land border — no advance application required',
    1,
    'Processed on the spot at the port of entry',
    'Bujumbura International Airport or any Burundi land border immigration counter',
    'Obtain an invitation letter from the family member resident in Burundi\nGet the yellow fever vaccination before travel (mandatory)\nCarry your passport, photo, and exact USD/EUR cash for the fee\nPresent documents at the visa-on-arrival counter on arrival\nPay the visa fee and receive your visa stamp',
    '/assets/images/visa-heroes/burundi.webp',
    'thingstodoinburundi.com and Burundi Embassy secondary sourcing', 'https://thingstodoinburundi.com/entry-requirements/', '2026-09-19'
);
SET @bdi5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bdi5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi5, 'Core Documents', 'Required from every traveller.', 1);
SET @bdi5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bdi5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2),
(@bdi5s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @bdi5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@bdi5s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(6, 5, 40.00, 'USD', 'Single-Entry Visa-on-Arrival Fee', 'Sources disagree — one reports USD 40 single-entry/USD 90 multiple-entry, another reports USD 90 single-entry. Confirm the current fee at the port of entry.', '2026-01-01', NOW(), 'https://thingstodoinburundi.com/entry-requirements/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Burundi on the visa-on-arrival route?', 'Yes — family visits use the same visa-on-arrival framework as tourism, with an invitation letter and relationship proof added.', 6, 5, 606, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    6, 6, 'BDI-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Burundi en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard visa-on-arrival or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with Burundi immigration or your airline whether the visa-on-arrival applies to your transit',
    1,
    'Processed on the spot at the port of entry if applicable',
    'Bujumbura International Airport or any Burundi land border immigration counter',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific provision applies\nCarry your passport and onward ticket\nGet the yellow fever vaccination certificate\nConfirm requirements with your airline before travel',
    '/assets/images/visa-heroes/burundi.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://thingstodoinburundi.com/entry-requirements/', '2026-09-19'
);
SET @bdi6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bdi6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi6, 'Core Documents', 'Required from every traveller.', 1);
SET @bdi6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bdi6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @bdi6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(6, 6, NULL, 'USD', 'Confirm at Port of Entry', 'Transit fee not independently confirmed this session; confirm with Burundi immigration.', '2026-09-01', NOW(), 'https://thingstodoinburundi.com/entry-requirements/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Burundi?', 'Not independently confirmed this session — confirm with Burundi immigration or your airline whether your specific transit routing requires a visa.', 6, 6, 607, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    6, 7, 'BDI-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Burundi.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa-on-arrival with medical documentation.',
    'Up to 1 month (30 days)',
    'Visa-on-arrival at Bujumbura International Airport or any land border — no advance application required',
    1,
    'Processed on the spot at the port of entry',
    'Bujumbura International Airport or any Burundi land border immigration counter',
    'Obtain a medical appointment/admission letter from the hospital\nGet the yellow fever vaccination before travel (mandatory)\nCarry your passport, photo, and exact USD/EUR cash for the fee\nPresent documents at the visa-on-arrival counter on arrival\nPay the visa fee and receive your visa stamp',
    '/assets/images/visa-heroes/burundi.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://thingstodoinburundi.com/entry-requirements/', '2026-09-19'
);
SET @bdi7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bdi7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi7, 'Core Documents', 'Required from every traveller.', 1);
SET @bdi7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bdi7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2),
(@bdi7s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @bdi7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@bdi7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(6, 7, 40.00, 'USD', 'Single-Entry Visa-on-Arrival Fee', 'Sources disagree — one reports USD 40 single-entry/USD 90 multiple-entry, another reports USD 90 single-entry. Confirm the current fee at the port of entry.', '2026-01-01', NOW(), 'https://thingstodoinburundi.com/entry-requirements/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Burundi?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard visa-on-arrival with supporting medical documentation.', 6, 7, 608, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    6, 8, 'BDI-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Burundi.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business visa-on-arrival framework with an event invitation.',
    'Up to 1 month (30 days)',
    'Visa-on-arrival at Bujumbura International Airport or any land border — no advance application required',
    1,
    'Processed on the spot at the port of entry',
    'Bujumbura International Airport or any Burundi land border immigration counter',
    'Obtain an official invitation letter from the event organiser\nGet the yellow fever vaccination before travel (mandatory)\nCarry your passport, photo, and exact USD/EUR cash for the fee\nPresent documents at the visa-on-arrival counter on arrival\nPay the visa fee and receive your visa stamp',
    '/assets/images/visa-heroes/burundi.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://thingstodoinburundi.com/entry-requirements/', '2026-09-19'
);
SET @bdi8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bdi8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi8, 'Core Documents', 'Required from every traveller.', 1);
SET @bdi8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bdi8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @bdi8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(6, 8, 90.00, 'USD', 'Multiple-Entry Visa-on-Arrival Fee', 'Single-entry is reported at USD 40 by one source. Confirm at the port of entry.', '2026-01-01', NOW(), 'https://thingstodoinburundi.com/entry-requirements/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Burundi?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business visa-on-arrival framework with an official invitation letter.', 6, 8, 609, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    6, 9, 'BDI-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Burundi.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa-on-arrival with an event invitation.',
    'Up to 1 month (30 days)',
    'Visa-on-arrival at Bujumbura International Airport or any land border — no advance application required',
    1,
    'Processed on the spot at the port of entry',
    'Bujumbura International Airport or any Burundi land border immigration counter',
    'Obtain an official invitation from the sporting federation/event organiser\nGet the yellow fever vaccination before travel (mandatory)\nCarry your passport, photo, and exact USD/EUR cash for the fee\nPresent documents at the visa-on-arrival counter on arrival\nPay the visa fee and receive your visa stamp',
    '/assets/images/visa-heroes/burundi.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://thingstodoinburundi.com/entry-requirements/', '2026-09-19'
);
SET @bdi9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bdi9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi9, 'Core Documents', 'Required from every traveller.', 1);
SET @bdi9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bdi9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @bdi9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(6, 9, 90.00, 'USD', 'Multiple-Entry Visa-on-Arrival Fee', 'Single-entry is reported at USD 40 by one source. Confirm at the port of entry.', '2026-01-01', NOW(), 'https://thingstodoinburundi.com/entry-requirements/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Burundi?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard visa-on-arrival with a federation/event invitation.', 6, 9, 6010, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    6, 10, 'BDI-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Burundi work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with Burundi immigration for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Burundi diplomatic mission (confirm current jurisdiction serving India) or Burundi immigration authority',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nGet the yellow fever vaccination certificate\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/burundi.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://thingstodoinburundi.com/entry-requirements/', '2026-09-19'
);
SET @bdi10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bdi10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi10, 'Core Documents', 'Required from every applicant.', 1);
SET @bdi10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bdi10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bdi10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @bdi10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bdi10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@bdi10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(6, 10, NULL, 'USD', 'Confirm with Immigration', 'Dependent permit fee not independently confirmed this session; confirm with Burundi immigration.', '2026-09-01', NOW(), 'https://thingstodoinburundi.com/entry-requirements/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Burundi?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with Burundi immigration.', 6, 10, 6011, 1);
