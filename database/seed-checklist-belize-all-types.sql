-- Belize Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Belize's real, distinctive facts verified this session:
--   - Visa-free entry (up to 30 days): Indian passport holders with a
--     valid multiple-entry US visa, US Green Card, valid Canada
--     visa/PR, or valid Schengen visa can enter without a Belizean
--     visa; the visa fee is waived under this route.
--   - Standard visa (when the visa-free route doesn't apply): BZD 750
--     single-entry / BZD 1000 multiple-entry, fee paid via Demand
--     Draft, processed through the Belize mission.
--   - Mandatory Repatriation Fee: ALL Indian citizens — visa-free or
--     not — must pay BZD 1200 (~USD 600) in cash or by card at the
--     port-of-entry immigration counter on arrival. This is a
--     universal entry cost, not a visa fee, and applies regardless of
--     visa category.
--   - Representation in India: Honorary Consulate of Belize, 98 Nehru
--     Place, New Delhi (tel 11-4250 4847 / 11-2642 1245); no separate
--     Mumbai office confirmed. Processing reported at approximately
--     30 business days.
--
-- country_id 157 = Belize. visa_type_id: 1=Tourist, 2=Business,
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
    157, 1, 'BLZ-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Belize.',
    'Visa-free for up to 30 days if holding a valid multiple-entry US visa, US Green Card, Canada visa/PR, or Schengen visa; otherwise a standard visa is required via the Honorary Consulate.',
    'Up to 30 days (visa-free route) or as endorsed on the standard visa',
    'Enter visa-free with a qualifying US/Canada/Schengen visa, or apply for a standard visa via the Honorary Consulate in New Delhi',
    1,
    'Standard visa reported at approximately 30 business days',
    'Honorary Consulate of Belize, 98 Nehru Place, New Delhi',
    'Check whether you hold a qualifying US, Canada, or Schengen visa/PR for visa-free entry\nIf not, apply for a standard visa at the Honorary Consulate in New Delhi\nPay the visa fee via Demand Draft if applying for a standard visa\nBudget for the mandatory BZD 1200 repatriation fee payable in cash/card on arrival\nCarry your passport and all supporting documents for immigration',
    '/assets/images/visa-heroes/belize.webp',
    'Belize Immigration Act requirements and BTW Visas secondary sourcing', 'https://btwvisas.com/visa-guide/belize-visa/', '2026-09-19'
);
SET @blz1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blz1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz1, 'Core Documents', 'Required from every applicant.', 1);
SET @blz1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz1s1, 'Valid Passport (6+ Months Validity, 2-3 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blz1s1, 'Completed Belize Visa Application Form', NULL, 'original', 0, 1, 1, 2),
(@blz1s1, 'Two Recent Passport-Size Colour Photographs', NULL, 'original', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz1, 'Supporting Documents', 'Evidence of your travel plans, means, and visa-free eligibility.', 2);
SET @blz1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz1s2, 'Valid US/Canada/Schengen Visa or Green Card/PR (If Using Visa-Free Route)', NULL, 'copy', 0, 1, 0, 1),
(@blz1s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2),
(@blz1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(157, 1, 750.00, 'BZD', 'Single-Entry Visa Fee (Standard Route)', 'Waived if entering visa-free with a qualifying US/Canada/Schengen visa. Multiple-entry is BZD 1000. A separate mandatory BZD 1200 repatriation fee applies to ALL Indian citizens at the port of entry regardless of route.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/belize-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Belize?', 'Not if you hold a valid multiple-entry US visa, US Green Card, Canada visa/PR, or Schengen visa — you can enter visa-free for up to 30 days. Otherwise, a standard visa (BZD 750 single-entry / BZD 1000 multiple-entry) is required via the Honorary Consulate in New Delhi.', 157, 1, 15700, 1),
('Is there any fee I must pay even with a visa-free entry?', 'Yes — all Indian citizens, regardless of visa status, must pay a mandatory BZD 1200 (~USD 600) repatriation fee in cash or by card at the port-of-entry immigration counter.', 157, 1, 15701, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    157, 2, 'BLZ-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Belize.',
    'Business travellers follow the same visa-free/standard-visa framework as tourists, adding a business invitation letter for the standard route.',
    'Up to 30 days (visa-free route) or as endorsed on the standard visa',
    'Enter visa-free with a qualifying US/Canada/Schengen visa, or apply for a standard visa via the Honorary Consulate in New Delhi',
    1,
    'Standard visa reported at approximately 30 business days',
    'Honorary Consulate of Belize, 98 Nehru Place, New Delhi',
    'Check whether you hold a qualifying US, Canada, or Schengen visa/PR for visa-free entry\nIf not, apply for a standard visa with a business invitation letter\nPay the visa fee via Demand Draft if applying for a standard visa\nBudget for the mandatory BZD 1200 repatriation fee payable on arrival\nCarry your passport and all supporting documents for immigration',
    '/assets/images/visa-heroes/belize.webp',
    'Belize Immigration Act requirements and BTW Visas secondary sourcing', 'https://btwvisas.com/visa-guide/belize-visa/', '2026-09-19'
);
SET @blz2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blz2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz2, 'Core Documents', 'Required from every applicant.', 1);
SET @blz2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz2s1, 'Valid Passport (6+ Months Validity, 2-3 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blz2s1, 'Business Invitation Letter (If Applying for Standard Visa)', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @blz2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@blz2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(157, 2, 1000.00, 'BZD', 'Multiple-Entry Visa Fee (Standard Route)', 'Single-entry is BZD 750; waived if entering visa-free with a qualifying US/Canada/Schengen visa. The mandatory BZD 1200 repatriation fee applies separately at the port of entry.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/belize-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should business travellers apply for multiple-entry?', 'If you expect repeat trips to Belize, the multiple-entry visa (BZD 1000) may be more convenient than single-entry (BZD 750) — though it is only needed if you don''t already qualify for visa-free entry.', 157, 2, 15702, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    157, 3, 'BLZ-STUD-IN-01', '2026.09', 'published',
    'Academic study in Belize.',
    'Not independently confirmed this session as a distinct standard visa category; longer academic programs likely require a student permit beyond the standard visa.',
    'Tied to the academic program duration',
    'Apply via the Honorary Consulate in New Delhi and confirm the student-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Honorary Consulate of Belize, 98 Nehru Place, New Delhi',
    'Secure admission confirmation from the Belizean institution\nContact the Honorary Consulate to confirm the student-permit process\nGather proof of financial support\nSubmit the visa application with required documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/belize.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/belize-visa/', '2026-09-19'
);
SET @blz3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blz3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz3, 'Core Documents', 'Required from every applicant.', 1);
SET @blz3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz3s1, 'Valid Passport (6+ Months Validity, 2-3 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blz3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @blz3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@blz3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(157, 3, NULL, 'BZD', 'Confirm at Consulate', 'Student permit fee not independently confirmed this session; confirm with the Honorary Consulate.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/belize-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for Belize?', 'Not independently confirmed this session — longer academic programs likely require a student permit beyond the standard visa. Confirm with the Honorary Consulate in New Delhi.', 157, 3, 15703, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    157, 4, 'BLZ-WORK-IN-01', '2026.09', 'published',
    'Employment with a Belizean company.',
    'Not independently confirmed this session as a distinct standard visa category; likely requires an employer-sponsored work permit beyond the standard visa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the Honorary Consulate for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Honorary Consulate of Belize, 98 Nehru Place, New Delhi',
    'Secure a signed employment contract from the Belizean employer\nCheck whether a separate work permit is required beyond the standard visa\nGather proof of qualifications\nApply via the Honorary Consulate\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/belize.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/belize-visa/', '2026-09-19'
);
SET @blz4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blz4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz4, 'Core Documents', 'Required from every applicant.', 1);
SET @blz4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz4s1, 'Valid Passport (6+ Months Validity, 2-3 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blz4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @blz4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@blz4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(157, 4, NULL, 'BZD', 'Confirm at Consulate', 'Work permit fee not independently confirmed this session; confirm with the Honorary Consulate.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/belize-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for Belize beyond the standard visa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit. Confirm with the Honorary Consulate.', 157, 4, 15704, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    157, 5, 'BLZ-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Belize.',
    'Family visits use the same visa-free/standard-visa framework as tourism, adding an invitation letter and relationship proof for the standard route.',
    'Up to 30 days (visa-free route) or as endorsed on the standard visa',
    'Enter visa-free with a qualifying US/Canada/Schengen visa, or apply for a standard visa via the Honorary Consulate',
    1,
    'Standard visa reported at approximately 30 business days',
    'Honorary Consulate of Belize, 98 Nehru Place, New Delhi',
    'Obtain an invitation letter from the family member resident in Belize\nCheck visa-free eligibility via a qualifying US/Canada/Schengen visa\nIf applying for a standard visa, submit the application with relationship proof\nBudget for the mandatory BZD 1200 repatriation fee payable on arrival\nCarry all documents for immigration',
    '/assets/images/visa-heroes/belize.webp',
    'Belize Immigration Act requirements and BTW Visas secondary sourcing', 'https://btwvisas.com/visa-guide/belize-visa/', '2026-09-19'
);
SET @blz5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blz5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz5, 'Core Documents', 'Required from every applicant.', 1);
SET @blz5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz5s1, 'Valid Passport (6+ Months Validity, 2-3 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blz5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @blz5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@blz5s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(157, 5, 750.00, 'BZD', 'Single-Entry Visa Fee (Standard Route)', 'Waived if entering visa-free with a qualifying US/Canada/Schengen visa. The mandatory BZD 1200 repatriation fee applies separately at the port of entry.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/belize-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Belize on the visa-free route?', 'Yes — if you hold a qualifying US/Canada/Schengen visa or PR/Green Card, you can visit family visa-free for up to 30 days; otherwise a standard visa with relationship proof is required.', 157, 5, 15705, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    157, 6, 'BLZ-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Belize en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard visa or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the Honorary Consulate or your airline whether the standard visa applies',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Honorary Consulate of Belize, 98 Nehru Place, New Delhi',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific visa is required\nContact the Honorary Consulate if needed\nSubmit passport and onward ticket for the application\nBudget for the mandatory BZD 1200 repatriation fee if applicable',
    '/assets/images/visa-heroes/belize.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/belize-visa/', '2026-09-19'
);
SET @blz6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blz6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz6, 'Core Documents', 'Required from every applicant.', 1);
SET @blz6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz6s1, 'Valid Passport (6+ Months Validity, 2-3 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blz6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @blz6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(157, 6, NULL, 'BZD', 'Confirm at Consulate', 'Transit fee not independently confirmed this session; confirm with the Honorary Consulate.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/belize-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Belize?', 'Not independently confirmed this session — confirm with the Honorary Consulate or your airline whether your specific transit routing requires the standard visa.', 157, 6, 15706, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    157, 7, 'BLZ-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Belize.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa with medical documentation.',
    'Up to 30 days (visa-free route) or as endorsed on the standard visa',
    'Enter visa-free with a qualifying US/Canada/Schengen visa, or apply for a standard visa via the Honorary Consulate',
    1,
    'Standard visa reported at approximately 30 business days',
    'Honorary Consulate of Belize, 98 Nehru Place, New Delhi',
    'Obtain a medical appointment/admission letter from the hospital\nCheck visa-free eligibility via a qualifying US/Canada/Schengen visa\nIf applying for a standard visa, submit the application with medical documents\nBudget for the mandatory BZD 1200 repatriation fee payable on arrival\nCarry all documents for immigration',
    '/assets/images/visa-heroes/belize.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/belize-visa/', '2026-09-19'
);
SET @blz7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blz7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz7, 'Core Documents', 'Required from every applicant.', 1);
SET @blz7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz7s1, 'Valid Passport (6+ Months Validity, 2-3 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blz7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @blz7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@blz7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(157, 7, 750.00, 'BZD', 'Single-Entry Visa Fee (Standard Route)', 'Waived if entering visa-free with a qualifying US/Canada/Schengen visa. The mandatory BZD 1200 repatriation fee applies separately at the port of entry.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/belize-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Belize?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard visa/visa-free route with supporting medical documentation.', 157, 7, 15707, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    157, 8, 'BLZ-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Belize.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business visa framework with an event invitation.',
    'Up to 30 days (visa-free route) or as endorsed on the standard visa',
    'Enter visa-free with a qualifying US/Canada/Schengen visa, or apply for a standard visa via the Honorary Consulate',
    1,
    'Standard visa reported at approximately 30 business days',
    'Honorary Consulate of Belize, 98 Nehru Place, New Delhi',
    'Obtain an official invitation letter from the event organiser\nCheck visa-free eligibility via a qualifying US/Canada/Schengen visa\nIf applying for a standard visa, submit the application with event documents\nBudget for the mandatory BZD 1200 repatriation fee payable on arrival\nCarry all documents for immigration',
    '/assets/images/visa-heroes/belize.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/belize-visa/', '2026-09-19'
);
SET @blz8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blz8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz8, 'Core Documents', 'Required from every applicant.', 1);
SET @blz8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz8s1, 'Valid Passport (6+ Months Validity, 2-3 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blz8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @blz8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(157, 8, 750.00, 'BZD', 'Single-Entry Visa Fee (Standard Route)', 'Waived if entering visa-free with a qualifying US/Canada/Schengen visa. The mandatory BZD 1200 repatriation fee applies separately at the port of entry.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/belize-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Belize?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business visa framework with an official invitation letter.', 157, 8, 15708, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    157, 9, 'BLZ-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Belize.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa with an event invitation.',
    'Up to 30 days (visa-free route) or as endorsed on the standard visa',
    'Enter visa-free with a qualifying US/Canada/Schengen visa, or apply for a standard visa via the Honorary Consulate',
    1,
    'Standard visa reported at approximately 30 business days',
    'Honorary Consulate of Belize, 98 Nehru Place, New Delhi',
    'Obtain an official invitation from the sporting federation/event organiser\nCheck visa-free eligibility via a qualifying US/Canada/Schengen visa\nIf applying for a standard visa, submit the application with event documents\nBudget for the mandatory BZD 1200 repatriation fee payable on arrival\nCarry all documents for immigration',
    '/assets/images/visa-heroes/belize.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/belize-visa/', '2026-09-19'
);
SET @blz9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blz9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz9, 'Core Documents', 'Required from every applicant.', 1);
SET @blz9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz9s1, 'Valid Passport (6+ Months Validity, 2-3 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blz9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @blz9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(157, 9, 750.00, 'BZD', 'Single-Entry Visa Fee (Standard Route)', 'Waived if entering visa-free with a qualifying US/Canada/Schengen visa. The mandatory BZD 1200 repatriation fee applies separately at the port of entry.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/belize-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Belize?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard visa with a federation/event invitation.', 157, 9, 15709, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    157, 10, 'BLZ-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Belizean work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the Honorary Consulate for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Honorary Consulate of Belize, 98 Nehru Place, New Delhi',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply via the Honorary Consulate\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/belize.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/belize-visa/', '2026-09-19'
);
SET @blz10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blz10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz10, 'Core Documents', 'Required from every applicant.', 1);
SET @blz10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz10s1, 'Valid Passport (6+ Months Validity, 2-3 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blz10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blz10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @blz10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blz10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@blz10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(157, 10, NULL, 'BZD', 'Confirm at Consulate', 'Dependent permit fee not independently confirmed this session; confirm with the Honorary Consulate.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/belize-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Belize?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the Honorary Consulate.', 157, 10, 15710, 1);
