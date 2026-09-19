-- Comoros Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- SOURCING CAVEAT: sources disagree on Comoros' exact visa position
-- for Indian citizens — one source (dated April 2026) claims visa-free
-- leisure entry, while others describe a required visa-on-arrival (up
-- to 45 days) or an embassy visa (up to 30 days, USD 25 fee, 3-5 day
-- processing). Visa-on-arrival is used below as the primary path
-- since it is the majority-sourced and most commonly documented
-- position for Comoros generally, but this conflict is flagged
-- honestly rather than silently resolved.
--
-- Comoros' real, distinctive facts verified this session:
--   - Visa-on-arrival: up to 45 days, requiring passport (6+ months
--     validity, 2 blank pages), photo, return/onward ticket, proof of
--     funds, and accommodation proof.
--   - Embassy visa alternative: USD 25 government fee, 3-5 day
--     processing, up to 30 days stay.
--
-- country_id 11 = Comoros. visa_type_id: 1=Tourist, 2=Business,
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
    11, 1, 'COM-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Comoros.',
    'Sources disagree — most describe a visa-on-arrival requirement (up to 45 days); one source suggests visa-free leisure entry. Verify the current position with official Comoros sources before booking.',
    'Up to 45 days (visa-on-arrival) or up to 30 days (embassy visa alternative)',
    'Visa-on-arrival at the port of entry, or apply for an embassy visa in advance',
    1,
    'Visa-on-arrival processed on the spot; embassy visa reported at 3-5 days',
    'Comoros port-of-entry immigration counter, or nearest Comoros embassy for the alternative route',
    'Verify current visa requirement with official Comoros sources\nCarry passport (6+ months validity, 2 blank pages), photo, and travel documents\nPresent documents at the visa-on-arrival counter on arrival\nPay the visa-on-arrival fee\nAlternatively, apply for an embassy visa in advance if preferred',
    '/assets/images/visa-heroes/comoros.webp',
    'ixigo and passportsandvisas.com secondary sourcing; sources disagree on whether a visa is required at all', 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', '2026-09-19'
);
SET @com1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@com1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com1, 'Core Documents', 'Required from every traveller.', 1);
SET @com1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com1s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@com1s1, 'Recent Passport-Size Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @com1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com1s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@com1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2),
(@com1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(11, 1, 25.00, 'USD', 'Embassy Visa Fee (Alternative Route)', 'Visa-on-arrival fee not independently confirmed this session with an exact figure; the embassy visa alternative is USD 25 with 3-5 day processing. Sources disagree on whether a visa is required at all — verify with official Comoros sources.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Comoros?', 'Sources disagree — most describe a required visa-on-arrival (up to 45 days) or an embassy visa (USD 25, up to 30 days), while one source suggests visa-free leisure entry. Verify the current position with official Comoros sources before booking.', 11, 1, 1100, 1),
('How long can I stay in Comoros on the visa-on-arrival?', 'The visa-on-arrival reportedly allows a stay of up to 45 days, longer than the 30-day embassy visa alternative.', 11, 1, 1101, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Visa on Arrival
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    11, 2, 'COM-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Comoros.',
    'Business travellers use the same visa-on-arrival/embassy-visa framework as tourists, adding a business invitation letter; sources disagree on whether a visa is required at all.',
    'Up to 45 days (visa-on-arrival) or up to 30 days (embassy visa alternative)',
    'Visa-on-arrival at the port of entry, or apply for an embassy visa in advance',
    1,
    'Visa-on-arrival processed on the spot; embassy visa reported at 3-5 days',
    'Comoros port-of-entry immigration counter, or nearest Comoros embassy for the alternative route',
    'Verify current visa requirement with official Comoros sources\nObtain a business invitation letter\nCarry passport, photo, and supporting documents\nPresent documents at the visa-on-arrival counter, or apply via embassy in advance\nPay the applicable visa fee',
    '/assets/images/visa-heroes/comoros.webp',
    'passportsandvisas.com secondary sourcing; official Comoros government domains not directly fetchable this session', 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', '2026-09-19'
);
SET @com2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@com2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com2, 'Core Documents', 'Required from every applicant.', 1);
SET @com2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com2s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@com2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @com2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@com2s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(11, 2, 25.00, 'USD', 'Embassy Visa Fee (Alternative Route)', 'Visa-on-arrival fee not independently confirmed this session with an exact figure. Sources disagree on whether a visa is even required for business travel.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can business travellers use the visa-on-arrival route in Comoros?', 'Reportedly yes, with the same documentation as tourism plus a business invitation letter — verify with official Comoros sources before travel.', 11, 2, 1102, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    11, 3, 'COM-STUD-IN-01', '2026.09', 'published',
    'Academic study in Comoros.',
    'Not independently confirmed this session as a distinct standard category; likely requires a long-stay visa beyond the standard visa-on-arrival.',
    'Tied to the academic program duration',
    'Confirm with the nearest Comoros embassy for the student-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Comoros diplomatic mission (confirm current jurisdiction serving India)',
    'Secure admission confirmation from the Comorian institution\nCheck whether the standard visa-on-arrival or a separate student visa applies\nGather proof of financial support\nApply via the relevant mission\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/comoros.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', '2026-09-19'
);
SET @com3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@com3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com3, 'Core Documents', 'Required from every applicant.', 1);
SET @com3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com3s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@com3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @com3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@com3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(11, 3, NULL, 'USD', 'Confirm at Mission', 'Student visa fee not independently confirmed this session; confirm with the relevant Comoros mission.', '2026-09-01', NOW(), 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for Comoros?', 'Not independently confirmed this session — longer academic programs likely require a long-stay visa beyond the standard visa-on-arrival. Confirm with the relevant mission.', 11, 3, 1103, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    11, 4, 'COM-WORK-IN-01', '2026.09', 'published',
    'Employment with a Comorian company.',
    'Not independently confirmed this session as a distinct standard category; likely requires an employer-sponsored work permit beyond the standard visa-on-arrival.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the nearest Comoros embassy for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Comoros diplomatic mission (confirm current jurisdiction serving India)',
    'Secure a signed employment contract from the Comorian employer\nCheck whether a separate work permit is required beyond the visa-on-arrival\nGather proof of qualifications\nApply via the relevant mission\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/comoros.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', '2026-09-19'
);
SET @com4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@com4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com4, 'Core Documents', 'Required from every applicant.', 1);
SET @com4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com4s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@com4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @com4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@com4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(11, 4, NULL, 'USD', 'Confirm at Mission', 'Work permit fee not independently confirmed this session; confirm with the relevant Comoros mission.', '2026-09-01', NOW(), 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for Comoros beyond the visa-on-arrival?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit. Confirm with the relevant mission.', 11, 4, 1104, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Visa on Arrival
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    11, 5, 'COM-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Comoros.',
    'Family visits use the same visa-on-arrival/embassy-visa framework as tourism, adding an invitation letter and relationship proof.',
    'Up to 45 days (visa-on-arrival) or up to 30 days (embassy visa alternative)',
    'Visa-on-arrival at the port of entry, or apply for an embassy visa in advance',
    1,
    'Visa-on-arrival processed on the spot; embassy visa reported at 3-5 days',
    'Comoros port-of-entry immigration counter, or nearest Comoros embassy for the alternative route',
    'Obtain an invitation letter from the family member resident in Comoros\nVerify current visa requirement with official Comoros sources\nCarry passport, photo, and relationship proof\nPresent documents at the visa-on-arrival counter, or apply via embassy in advance\nPay the applicable visa fee',
    '/assets/images/visa-heroes/comoros.webp',
    'passportsandvisas.com secondary sourcing; official Comoros government domains not directly fetchable this session', 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', '2026-09-19'
);
SET @com5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@com5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com5, 'Core Documents', 'Required from every applicant.', 1);
SET @com5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com5s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@com5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @com5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@com5s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(11, 5, 25.00, 'USD', 'Embassy Visa Fee (Alternative Route)', 'Visa-on-arrival fee not independently confirmed this session with an exact figure.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Comoros on the visa-on-arrival route?', 'Reportedly yes — the same documentation as tourism applies, plus an invitation letter and relationship proof.', 11, 5, 1105, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    11, 6, 'COM-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Comoros en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard visa-on-arrival or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the port-of-entry authorities or your airline whether the standard visa-on-arrival applies',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Comoros port-of-entry immigration counter',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific provision applies\nCarry passport and onward ticket\nPresent documents at the visa-on-arrival counter if disembarking\nConfirm requirements with your airline before travel',
    '/assets/images/visa-heroes/comoros.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', '2026-09-19'
);
SET @com6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@com6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com6, 'Core Documents', 'Required from every applicant.', 1);
SET @com6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com6s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@com6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @com6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(11, 6, NULL, 'USD', 'Confirm at Port of Entry', 'Transit fee not independently confirmed this session; confirm with Comoros immigration.', '2026-09-01', NOW(), 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Comoros?', 'Not independently confirmed this session — confirm with Comoros port-of-entry authorities or your airline whether your specific transit routing requires the standard visa-on-arrival.', 11, 6, 1106, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    11, 7, 'COM-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Comoros.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa-on-arrival with medical documentation.',
    'Up to 45 days (visa-on-arrival) or up to 30 days (embassy visa alternative)',
    'Visa-on-arrival at the port of entry, or apply for an embassy visa in advance',
    1,
    'Visa-on-arrival processed on the spot; embassy visa reported at 3-5 days',
    'Comoros port-of-entry immigration counter, or nearest Comoros embassy for the alternative route',
    'Obtain a medical appointment/admission letter from the hospital\nVerify current visa requirement with official Comoros sources\nCarry passport, photo, and medical documents\nPresent documents at the visa-on-arrival counter, or apply via embassy in advance\nPay the applicable visa fee',
    '/assets/images/visa-heroes/comoros.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', '2026-09-19'
);
SET @com7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@com7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com7, 'Core Documents', 'Required from every applicant.', 1);
SET @com7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com7s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@com7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @com7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@com7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(11, 7, 25.00, 'USD', 'Embassy Visa Fee (Alternative Route)', 'Visa-on-arrival fee not independently confirmed this session with an exact figure.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Comoros?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard visa-on-arrival with supporting medical documentation.', 11, 7, 1107, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    11, 8, 'COM-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Comoros.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business visa-on-arrival framework with an event invitation.',
    'Up to 45 days (visa-on-arrival) or up to 30 days (embassy visa alternative)',
    'Visa-on-arrival at the port of entry, or apply for an embassy visa in advance',
    1,
    'Visa-on-arrival processed on the spot; embassy visa reported at 3-5 days',
    'Comoros port-of-entry immigration counter, or nearest Comoros embassy for the alternative route',
    'Obtain an official invitation letter from the event organiser\nVerify current visa requirement with official Comoros sources\nCarry passport, photo, and event documents\nPresent documents at the visa-on-arrival counter, or apply via embassy in advance\nPay the applicable visa fee',
    '/assets/images/visa-heroes/comoros.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', '2026-09-19'
);
SET @com8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@com8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com8, 'Core Documents', 'Required from every applicant.', 1);
SET @com8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com8s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@com8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @com8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(11, 8, 25.00, 'USD', 'Embassy Visa Fee (Alternative Route)', 'Visa-on-arrival fee not independently confirmed this session with an exact figure.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Comoros?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business visa-on-arrival framework with an official invitation letter.', 11, 8, 1108, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    11, 9, 'COM-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Comoros.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa-on-arrival with an event invitation.',
    'Up to 45 days (visa-on-arrival) or up to 30 days (embassy visa alternative)',
    'Visa-on-arrival at the port of entry, or apply for an embassy visa in advance',
    1,
    'Visa-on-arrival processed on the spot; embassy visa reported at 3-5 days',
    'Comoros port-of-entry immigration counter, or nearest Comoros embassy for the alternative route',
    'Obtain an official invitation from the sporting federation/event organiser\nVerify current visa requirement with official Comoros sources\nCarry passport, photo, and event documents\nPresent documents at the visa-on-arrival counter, or apply via embassy in advance\nPay the applicable visa fee',
    '/assets/images/visa-heroes/comoros.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', '2026-09-19'
);
SET @com9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@com9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com9, 'Core Documents', 'Required from every applicant.', 1);
SET @com9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com9s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@com9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @com9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(11, 9, 25.00, 'USD', 'Embassy Visa Fee (Alternative Route)', 'Visa-on-arrival fee not independently confirmed this session with an exact figure.', '2026-01-01', NOW(), 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Comoros?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard visa-on-arrival with a federation/event invitation.', 11, 9, 1109, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    11, 10, 'COM-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Comorian work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the nearest Comoros embassy for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Comoros diplomatic mission (confirm current jurisdiction serving India)',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply via the relevant mission\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/comoros.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', '2026-09-19'
);
SET @com10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@com10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com10, 'Core Documents', 'Required from every applicant.', 1);
SET @com10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com10s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@com10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@com10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @com10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@com10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@com10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(11, 10, NULL, 'USD', 'Confirm at Mission', 'Dependent permit fee not independently confirmed this session; confirm with the relevant Comoros mission.', '2026-09-01', NOW(), 'https://www.passportsandvisas.com/visas/comoros/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Comoros?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the relevant mission.', 11, 10, 1110, 1);
