-- Guinea-Bissau Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search.
--
-- SOURCING CAVEAT: sources disagree — one describes Guinea-Bissau as
-- visa-free for Indian citizens, while others describe a required
-- visa obtainable on arrival or via eVisa. Visa-on-arrival is used
-- below as the primary path since it is the more specifically
-- documented position (named airport plus 4 named land border
-- posts), but the visa-free claim is flagged honestly rather than
-- silently dismissed.
--
-- Guinea-Bissau's real, distinctive facts verified this session:
--   - Visa-on-arrival available at Osvaldo Vieira International
--     Airport (Bissau) or at 4 named land border posts: Djegue II
--     (São Domingos), Cambadju (Bafatá), Pirada, and Bruntuma (Gabú).
--   - An eVisa (Electronic Visa Application website) is also
--     available as an alternative to visa-on-arrival.
--   - Fee: USD 120 or EUR 85, cash only (EUR, USD, or West African
--     CFA francs) — card payments are not accepted, so exact cash is
--     recommended.
--
-- country_id 23 = Guinea-Bissau. visa_type_id: 1=Tourist, 2=Business,
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
    23, 1, 'GNB-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Guinea-Bissau.',
    'Sources disagree — most describe a required visa, obtainable on arrival or via eVisa; one source suggests visa-free entry. Verify the current position with official Guinea-Bissau sources before booking.',
    'Not independently confirmed this session for an exact stay duration',
    'Visa-on-arrival at Osvaldo Vieira International Airport or one of 4 named land border posts, or apply for the eVisa in advance',
    1,
    'Visa-on-arrival processed on the spot; eVisa processing time not independently confirmed this session',
    'Osvaldo Vieira International Airport (Bissau), or land border posts: Djegue II, Cambadju, Pirada, Bruntuma',
    'Verify current visa requirement with official Guinea-Bissau sources\nCarry passport (6+ months validity), photo, and travel documents\nCarry exact cash (EUR, USD, or CFA francs) — card payments are not accepted\nPresent documents and pay the visa fee at the port of entry, or apply for the eVisa in advance\nCarry proof of return ticket and accommodation',
    '/assets/images/visa-heroes/guinea-bissau.webp',
    'dontstopliving.net and Akbar Travels secondary sourcing; sources disagree on whether a visa is required at all', 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', '2026-09-19'
);
SET @gnb1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnb1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb1, 'Core Documents', 'Required from every traveller.', 1);
SET @gnb1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnb1s1, 'Recent Passport-Size Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @gnb1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb1s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@gnb1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(23, 1, 120.00, 'USD', 'Visa-on-Arrival Fee', 'Equivalent to EUR 85. Cash only (EUR, USD, or West African CFA francs) — card payments not accepted; bring exact cash.', '2026-01-01', NOW(), 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Guinea-Bissau?', 'Sources disagree — most describe a required visa, obtainable on arrival at Bissau International Airport or select land border posts, or in advance via eVisa. One source suggests visa-free entry. Verify with official Guinea-Bissau sources before travel.', 23, 1, 2300, 1),
('Can I pay for the Guinea-Bissau visa by card?', 'No — visa-on-arrival is cash only (EUR, USD, or West African CFA francs). Bring exact cash, as change may not be available.', 23, 1, 2301, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Visa on Arrival
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    23, 2, 'GNB-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Guinea-Bissau.',
    'Business travellers use the same visa-on-arrival/eVisa framework as tourists, adding a business invitation letter; sources disagree on whether a visa is required at all.',
    'Not independently confirmed this session for an exact stay duration',
    'Visa-on-arrival at Osvaldo Vieira International Airport or one of 4 named land border posts, or apply for the eVisa in advance',
    1,
    'Visa-on-arrival processed on the spot; eVisa processing time not independently confirmed this session',
    'Osvaldo Vieira International Airport (Bissau), or land border posts: Djegue II, Cambadju, Pirada, Bruntuma',
    'Verify current visa requirement with official Guinea-Bissau sources\nObtain a business invitation letter\nCarry exact cash (EUR, USD, or CFA francs) — card payments not accepted\nPresent documents and pay the visa fee at the port of entry, or apply for the eVisa in advance\nCarry proof of return ticket',
    '/assets/images/visa-heroes/guinea-bissau.webp',
    'dontstopliving.net and Akbar Travels secondary sourcing', 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', '2026-09-19'
);
SET @gnb2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnb2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb2, 'Core Documents', 'Required from every applicant.', 1);
SET @gnb2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnb2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @gnb2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@gnb2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(23, 2, 120.00, 'USD', 'Visa-on-Arrival Fee', 'Equivalent to EUR 85. Cash only — card payments not accepted.', '2026-01-01', NOW(), 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can business travellers use the visa-on-arrival route in Guinea-Bissau?', 'Reportedly yes, with the same documentation as tourism plus a business invitation letter — verify with official Guinea-Bissau sources before travel.', 23, 2, 2302, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    23, 3, 'GNB-STUD-IN-01', '2026.09', 'published',
    'Academic study in Guinea-Bissau.',
    'Not independently confirmed this session as a distinct standard category; likely requires a long-stay visa beyond the standard visa-on-arrival.',
    'Tied to the academic program duration',
    'Confirm with the nearest Guinea-Bissau mission for the student-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Guinea-Bissau diplomatic mission (confirm current jurisdiction serving India)',
    'Secure admission confirmation from the Guinea-Bissau institution\nCheck whether the standard visa-on-arrival or a separate student visa applies\nGather proof of financial support\nApply via the relevant mission\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/guinea-bissau.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', '2026-09-19'
);
SET @gnb3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnb3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb3, 'Core Documents', 'Required from every applicant.', 1);
SET @gnb3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnb3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @gnb3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@gnb3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(23, 3, NULL, 'USD', 'Confirm at Mission', 'Student visa fee not independently confirmed this session; confirm with the relevant Guinea-Bissau mission.', '2026-09-01', NOW(), 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for Guinea-Bissau?', 'Not independently confirmed this session — longer academic programs likely require a long-stay visa beyond the standard visa-on-arrival. Confirm with the relevant mission.', 23, 3, 2303, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    23, 4, 'GNB-WORK-IN-01', '2026.09', 'published',
    'Employment with a Guinea-Bissau company.',
    'Not independently confirmed this session as a distinct standard category; likely requires an employer-sponsored work permit beyond the standard visa-on-arrival.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the nearest Guinea-Bissau mission for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Guinea-Bissau diplomatic mission (confirm current jurisdiction serving India)',
    'Secure a signed employment contract from the Guinea-Bissau employer\nCheck whether a separate work permit is required beyond the visa-on-arrival\nGather proof of qualifications\nApply via the relevant mission\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/guinea-bissau.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', '2026-09-19'
);
SET @gnb4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnb4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb4, 'Core Documents', 'Required from every applicant.', 1);
SET @gnb4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnb4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @gnb4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@gnb4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(23, 4, NULL, 'USD', 'Confirm at Mission', 'Work permit fee not independently confirmed this session; confirm with the relevant Guinea-Bissau mission.', '2026-09-01', NOW(), 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for Guinea-Bissau beyond the visa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit. Confirm with the relevant mission.', 23, 4, 2304, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Visa on Arrival
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    23, 5, 'GNB-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Guinea-Bissau.',
    'Family visits use the same visa-on-arrival/eVisa framework as tourism, adding an invitation letter and relationship proof.',
    'Not independently confirmed this session for an exact stay duration',
    'Visa-on-arrival at Osvaldo Vieira International Airport or one of 4 named land border posts, or apply for the eVisa in advance',
    1,
    'Visa-on-arrival processed on the spot; eVisa processing time not independently confirmed this session',
    'Osvaldo Vieira International Airport (Bissau), or land border posts: Djegue II, Cambadju, Pirada, Bruntuma',
    'Obtain an invitation letter from the family member resident in Guinea-Bissau\nVerify current visa requirement with official Guinea-Bissau sources\nCarry exact cash (EUR, USD, or CFA francs) — card payments not accepted\nPresent documents and pay the visa fee at the port of entry, or apply for the eVisa in advance\nCarry proof of relationship',
    '/assets/images/visa-heroes/guinea-bissau.webp',
    'dontstopliving.net and Akbar Travels secondary sourcing', 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', '2026-09-19'
);
SET @gnb5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnb5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb5, 'Core Documents', 'Required from every applicant.', 1);
SET @gnb5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnb5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @gnb5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@gnb5s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(23, 5, 120.00, 'USD', 'Visa-on-Arrival Fee', 'Equivalent to EUR 85. Cash only — card payments not accepted.', '2026-01-01', NOW(), 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Guinea-Bissau on the visa-on-arrival route?', 'Reportedly yes — the same documentation as tourism applies, plus an invitation letter and relationship proof.', 23, 5, 2305, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    23, 6, 'GNB-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Guinea-Bissau en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard visa-on-arrival or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the port-of-entry authorities or your airline whether the standard visa-on-arrival applies',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Osvaldo Vieira International Airport (Bissau)',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific provision applies\nCarry passport and onward ticket\nPresent documents at the visa-on-arrival counter if disembarking\nConfirm requirements with your airline before travel',
    '/assets/images/visa-heroes/guinea-bissau.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', '2026-09-19'
);
SET @gnb6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnb6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb6, 'Core Documents', 'Required from every applicant.', 1);
SET @gnb6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnb6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @gnb6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(23, 6, NULL, 'USD', 'Confirm at Port of Entry', 'Transit fee not independently confirmed this session; confirm with Guinea-Bissau immigration.', '2026-09-01', NOW(), 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Guinea-Bissau?', 'Not independently confirmed this session — confirm with Guinea-Bissau immigration or your airline whether your specific transit routing requires the standard visa-on-arrival.', 23, 6, 2306, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    23, 7, 'GNB-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Guinea-Bissau.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa-on-arrival with medical documentation.',
    'Not independently confirmed this session for an exact stay duration',
    'Visa-on-arrival at Osvaldo Vieira International Airport or one of 4 named land border posts, or apply for the eVisa in advance',
    1,
    'Visa-on-arrival processed on the spot; eVisa processing time not independently confirmed this session',
    'Osvaldo Vieira International Airport (Bissau), or land border posts: Djegue II, Cambadju, Pirada, Bruntuma',
    'Obtain a medical appointment/admission letter from the hospital\nVerify current visa requirement with official Guinea-Bissau sources\nCarry exact cash (EUR, USD, or CFA francs) — card payments not accepted\nPresent documents and pay the visa fee at the port of entry, or apply for the eVisa in advance\nCarry proof of financial means for treatment',
    '/assets/images/visa-heroes/guinea-bissau.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', '2026-09-19'
);
SET @gnb7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnb7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb7, 'Core Documents', 'Required from every applicant.', 1);
SET @gnb7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnb7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @gnb7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@gnb7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(23, 7, 120.00, 'USD', 'Visa-on-Arrival Fee', 'Equivalent to EUR 85. Cash only — card payments not accepted.', '2026-01-01', NOW(), 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Guinea-Bissau?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard visa-on-arrival with supporting medical documentation.', 23, 7, 2307, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    23, 8, 'GNB-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Guinea-Bissau.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business visa-on-arrival framework with an event invitation.',
    'Not independently confirmed this session for an exact stay duration',
    'Visa-on-arrival at Osvaldo Vieira International Airport or one of 4 named land border posts, or apply for the eVisa in advance',
    1,
    'Visa-on-arrival processed on the spot; eVisa processing time not independently confirmed this session',
    'Osvaldo Vieira International Airport (Bissau), or land border posts: Djegue II, Cambadju, Pirada, Bruntuma',
    'Obtain an official invitation letter from the event organiser\nVerify current visa requirement with official Guinea-Bissau sources\nCarry exact cash (EUR, USD, or CFA francs) — card payments not accepted\nPresent documents and pay the visa fee at the port of entry, or apply for the eVisa in advance\nCarry all documents for immigration',
    '/assets/images/visa-heroes/guinea-bissau.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', '2026-09-19'
);
SET @gnb8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnb8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb8, 'Core Documents', 'Required from every applicant.', 1);
SET @gnb8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnb8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @gnb8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(23, 8, 120.00, 'USD', 'Visa-on-Arrival Fee', 'Equivalent to EUR 85. Cash only — card payments not accepted.', '2026-01-01', NOW(), 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Guinea-Bissau?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business visa-on-arrival framework with an official invitation letter.', 23, 8, 2308, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    23, 9, 'GNB-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Guinea-Bissau.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa-on-arrival with an event invitation.',
    'Not independently confirmed this session for an exact stay duration',
    'Visa-on-arrival at Osvaldo Vieira International Airport or one of 4 named land border posts, or apply for the eVisa in advance',
    1,
    'Visa-on-arrival processed on the spot; eVisa processing time not independently confirmed this session',
    'Osvaldo Vieira International Airport (Bissau), or land border posts: Djegue II, Cambadju, Pirada, Bruntuma',
    'Obtain an official invitation from the sporting federation/event organiser\nVerify current visa requirement with official Guinea-Bissau sources\nCarry exact cash (EUR, USD, or CFA francs) — card payments not accepted\nPresent documents and pay the visa fee at the port of entry, or apply for the eVisa in advance\nCarry all documents for immigration',
    '/assets/images/visa-heroes/guinea-bissau.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', '2026-09-19'
);
SET @gnb9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnb9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb9, 'Core Documents', 'Required from every applicant.', 1);
SET @gnb9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnb9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @gnb9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(23, 9, 120.00, 'USD', 'Visa-on-Arrival Fee', 'Equivalent to EUR 85. Cash only — card payments not accepted.', '2026-01-01', NOW(), 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Guinea-Bissau?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard visa-on-arrival with a federation/event invitation.', 23, 9, 2309, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    23, 10, 'GNB-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Guinea-Bissau work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the nearest Guinea-Bissau mission for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Guinea-Bissau diplomatic mission (confirm current jurisdiction serving India)',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply via the relevant mission\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/guinea-bissau.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', '2026-09-19'
);
SET @gnb10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gnb10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb10, 'Core Documents', 'Required from every applicant.', 1);
SET @gnb10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gnb10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gnb10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @gnb10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gnb10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@gnb10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(23, 10, NULL, 'USD', 'Confirm at Mission', 'Dependent permit fee not independently confirmed this session; confirm with the relevant Guinea-Bissau mission.', '2026-09-01', NOW(), 'https://dontstopliving.net/how-to-get-a-guinea-bissau-visa-on-arrival-at-bissau-international-airport/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Guinea-Bissau?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the relevant mission.', 23, 10, 2310, 1);
