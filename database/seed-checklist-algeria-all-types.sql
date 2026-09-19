-- Algeria Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url left NULL
-- pattern-consistent with other batches (no photo bundle supplied yet).
--
-- SOURCING CAVEAT: Algerian government/embassy domains were not
-- directly fetchable this session (egress-proxy blocked); findings
-- triangulated from BTW Visas secondary sourcing.
--
-- Algeria's real, distinctive facts verified this session:
--   - No e-Visa or visa-on-arrival for Indian citizens — all visas are
--     physical sticker visas affixed to the passport, applied for
--     in-person.
--   - VFS Global began accepting Algeria visa applications across 5
--     Indian cities (Delhi, Mumbai, Chennai, Kolkata, Hyderabad) from
--     September 2024 — a genuinely useful, relatively recent
--     accessibility improvement over embassy-only processing.
--   - Embassy of Algeria: 2/2, Shanti Niketan, New Delhi - 110021.
--   - Processing time varies meaningfully by route: 3-4 working days
--     direct at the Embassy in Delhi, minimum 7 working days via VFS
--     Delhi, 10-12 working days via VFS in other cities; Work and
--     Student visas take 4-6 weeks.
--   - Fees: single-entry (30 days) INR 8,100; all-categories (90 days)
--     INR 9,700; plus an additional INR 1,600 VFS Global service fee
--     if applying through VFS rather than directly at the Embassy.
--
-- country_id 1 = Algeria. visa_type_id: 1=Tourist, 2=Business,
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
    1, 1, 'DZA-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Algeria.',
    'Indian passport holders must obtain a physical sticker visa before travel — Algeria offers no e-Visa or visa-on-arrival for Indian citizens.',
    'Single-entry up to 30 days, or all-categories visa up to 90 days',
    'Apply in person at the Embassy of Algeria, New Delhi, or via VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, or Hyderabad',
    1,
    '3-4 working days direct at the Embassy in Delhi; minimum 7 working days via VFS Delhi; 10-12 working days via VFS in other cities',
    'Embassy of Algeria, 2/2 Shanti Niketan, New Delhi - 110021 (also VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, Hyderabad)',
    'Complete the visa application form\nBook an appointment at the Embassy or nearest VFS Global center\nSubmit passport, photographs, and supporting documents\nPay the visa fee (plus VFS service fee if applicable)\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/algeria.webp',
    'BTW Visas secondary sourcing; official Algerian Embassy/VFS domains not directly fetchable this session', 'https://btwvisas.com/visa-guide/algeria-tourist-visa', '2026-09-19'
);
SET @dza1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dza1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza1, 'Core Documents', 'Required from every applicant.', 1);
SET @dza1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza1s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@dza1s1, 'Recent Passport-Size Photographs', NULL, 'copy', 1, 0, 1, 2),
(@dza1s1, 'Completed Visa Application Form', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @dza1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza1s2, 'Confirmed Accommodation Booking', NULL, 'copy', 1, 0, 0, 1),
(@dza1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@dza1s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(1, 1, 8100.00, 'INR', 'Single-Entry Visa Fee (30 Days)', 'For the all-categories 90-day visa, the fee is reported at INR 9,700. An additional INR 1,600 VFS Global service fee applies if applying via VFS rather than directly at the Embassy.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/algeria-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens get an Algeria e-Visa or visa on arrival?', 'No — Algeria offers no e-Visa or visa-on-arrival for Indian passport holders. All visas are physical sticker visas requiring an in-person application at the Embassy or a VFS Global center.', 1, 1, 100, 1),
('How much does an Algeria tourist visa cost for Indians?', 'A single-entry visa (30 days) is reported at INR 8,100, while the all-categories visa (90 days) is INR 9,700. An additional INR 1,600 VFS Global service fee applies if applying through VFS.', 1, 1, 101, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    1, 2, 'DZA-BUS-IN-01', '2026.09', 'published',
    'Business meetings, trade, and investment-related travel to Algeria.',
    'Indian business travellers require a physical sticker visa and an invitation from an Algerian company or organisation.',
    'Single-entry up to 30 days, or all-categories visa up to 90 days',
    'Apply in person at the Embassy of Algeria, New Delhi, or via VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, or Hyderabad',
    1,
    '3-4 working days direct at the Embassy in Delhi; minimum 7 working days via VFS Delhi; 10-12 working days via VFS in other cities',
    'Embassy of Algeria, 2/2 Shanti Niketan, New Delhi - 110021 (also VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, Hyderabad)',
    'Obtain a business invitation letter from the host Algerian company\nComplete the visa application form\nBook an appointment at the Embassy or nearest VFS Global center\nSubmit passport, photographs, and supporting documents\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/algeria.webp',
    'BTW Visas secondary sourcing; official Algerian Embassy/VFS domains not directly fetchable this session', 'https://btwvisas.com/visa-guide/algeria-visa/', '2026-09-19'
);
SET @dza2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dza2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza2, 'Core Documents', 'Required from every applicant.', 1);
SET @dza2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza2s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@dza2s1, 'Recent Passport-Size Photographs', NULL, 'copy', 1, 0, 1, 2),
(@dza2s1, 'Business Invitation Letter from Algerian Host', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza2, 'Supporting Documents', 'Evidence of your business purpose and company standing.', 2);
SET @dza2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@dza2s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(1, 2, 9700.00, 'INR', 'All-Categories Visa Fee (90 Days)', 'A shorter single-entry 30-day visa is reported at INR 8,100. An additional INR 1,600 VFS Global service fee applies if applying via VFS rather than directly at the Embassy.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/algeria-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need an invitation letter for an Algeria business visa?', 'Yes — a business invitation letter from the Algerian host company is a core requirement alongside your passport and application form.', 1, 2, 102, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    1, 3, 'DZA-STUD-IN-01', '2026.09', 'published',
    'Academic study in Algeria.',
    'Indian students require a physical sticker visa and admission confirmation from an accredited Algerian institution.',
    'Tied to the academic program duration',
    'Apply in person at the Embassy of Algeria, New Delhi, or via VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, or Hyderabad',
    1,
    'Reported at 4-6 weeks for student visas',
    'Embassy of Algeria, 2/2 Shanti Niketan, New Delhi - 110021 (also VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, Hyderabad)',
    'Secure admission confirmation from the Algerian institution\nComplete the visa application form\nBook an appointment at the Embassy or nearest VFS Global center\nSubmit passport, photographs, and academic documents\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/algeria.webp',
    'BTW Visas secondary sourcing; official Algerian Embassy/VFS domains not directly fetchable this session', 'https://btwvisas.com/visa-guide/algeria-visa/', '2026-09-19'
);
SET @dza3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dza3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza3, 'Core Documents', 'Required from every applicant.', 1);
SET @dza3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza3s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@dza3s1, 'Recent Passport-Size Photographs', NULL, 'copy', 1, 0, 1, 2),
(@dza3s1, 'Admission Confirmation from Algerian Institution', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @dza3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@dza3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(1, 3, NULL, 'INR', 'Confirm at Embassy/VFS', 'Student visa fee not independently broken out this session from the general fee schedule; confirm the current amount at the Embassy or VFS Global before applying.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/algeria-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How long does an Algeria student visa take to process?', 'Student visas are reported to take 4-6 weeks, longer than the standard tourist/business processing times.', 1, 3, 103, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    1, 4, 'DZA-WORK-IN-01', '2026.09', 'published',
    'Employment with an Algerian company.',
    'Indian professionals require a physical sticker work visa backed by an Algerian employer sponsorship.',
    'Tied to the employment contract duration',
    'Apply in person at the Embassy of Algeria, New Delhi, or via VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, or Hyderabad',
    1,
    'Reported at 4-6 weeks for work visas',
    'Embassy of Algeria, 2/2 Shanti Niketan, New Delhi - 110021 (also VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, Hyderabad)',
    'Secure a signed employment contract/sponsorship from the Algerian employer\nComplete the visa application form\nBook an appointment at the Embassy or nearest VFS Global center\nSubmit passport, photographs, and employer documents\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/algeria.webp',
    'BTW Visas secondary sourcing; official Algerian Embassy/VFS domains not directly fetchable this session', 'https://btwvisas.com/visa-guide/algeria-visa/', '2026-09-19'
);
SET @dza4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dza4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza4, 'Core Documents', 'Required from every applicant.', 1);
SET @dza4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza4s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@dza4s1, 'Recent Passport-Size Photographs', NULL, 'copy', 1, 0, 1, 2),
(@dza4s1, 'Signed Employment Contract/Sponsorship Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @dza4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@dza4s2, 'Employer''s Registration Proof (Algeria)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(1, 4, NULL, 'INR', 'Confirm at Embassy/VFS', 'Work visa fee not independently broken out this session from the general fee schedule; confirm the current amount at the Embassy or VFS Global before applying.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/algeria-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How long does an Algeria work visa take to process?', 'Work visas are reported to take 4-6 weeks, longer than the standard tourist/business processing times.', 1, 4, 104, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    1, 5, 'DZA-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Algeria.',
    'Indian nationals visiting relatives in Algeria require a physical sticker visa supported by an invitation from the resident family member.',
    'Single-entry up to 30 days, or all-categories visa up to 90 days',
    'Apply in person at the Embassy of Algeria, New Delhi, or via VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, or Hyderabad',
    1,
    '3-4 working days direct at the Embassy in Delhi; minimum 7 working days via VFS Delhi; 10-12 working days via VFS in other cities',
    'Embassy of Algeria, 2/2 Shanti Niketan, New Delhi - 110021 (also VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, Hyderabad)',
    'Obtain an invitation letter from the family member resident in Algeria\nComplete the visa application form\nBook an appointment at the Embassy or nearest VFS Global center\nSubmit passport, photographs, and relationship proof\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/algeria.webp',
    'BTW Visas secondary sourcing; official Algerian Embassy/VFS domains not directly fetchable this session', 'https://btwvisas.com/visa-guide/algeria-visa/', '2026-09-19'
);
SET @dza5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dza5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza5, 'Core Documents', 'Required from every applicant.', 1);
SET @dza5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza5s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@dza5s1, 'Recent Passport-Size Photographs', NULL, 'copy', 1, 0, 1, 2),
(@dza5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @dza5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@dza5s2, 'Host''s Residence/ID Proof in Algeria', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(1, 5, 8100.00, 'INR', 'Single-Entry Visa Fee (30 Days)', 'For the all-categories 90-day visa, the fee is reported at INR 9,700. An additional INR 1,600 VFS Global service fee applies if applying via VFS rather than directly at the Embassy.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/algeria-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What proof do I need to visit family in Algeria?', 'An invitation letter from the resident family member plus proof of relationship (birth or marriage certificate) are core requirements for the visa application.', 1, 5, 105, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    1, 6, 'DZA-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Algeria en route to a third country.',
    'Indian nationals transiting via Algeria require a physical sticker transit visa with confirmed onward travel.',
    'Short duration tied to the transit itinerary',
    'Apply in person at the Embassy of Algeria, New Delhi, or via VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, or Hyderabad',
    1,
    '3-4 working days direct at the Embassy in Delhi; minimum 7 working days via VFS Delhi; 10-12 working days via VFS in other cities',
    'Embassy of Algeria, 2/2 Shanti Niketan, New Delhi - 110021 (also VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, Hyderabad)',
    'Confirm onward travel itinerary and connecting flight/transport\nComplete the visa application form\nBook an appointment at the Embassy or nearest VFS Global center\nSubmit passport, photographs, and onward ticket\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/algeria.webp',
    'Best-effort structure built from the confirmed general Algerian visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/algeria-visa/', '2026-09-19'
);
SET @dza6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dza6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza6, 'Core Documents', 'Required from every applicant.', 1);
SET @dza6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza6s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@dza6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2),
(@dza6s1, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @dza6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza6s2, 'Recent Passport-Size Photographs', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(1, 6, NULL, 'INR', 'Confirm at Embassy/VFS', 'Transit visa fee not independently broken out this session from the general fee schedule; confirm the current amount at the Embassy or VFS Global before applying.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/algeria-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a transit visa to pass through Algeria?', 'Yes, a transit visa with confirmed onward travel documents is generally required since Algeria offers no e-Visa or visa-on-arrival for Indian citizens.', 1, 6, 106, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    1, 7, 'DZA-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Algeria.',
    'Not independently confirmed this session as a distinct standard visa category — likely processed under the general all-categories visa with medical documentation.',
    'Up to 90 days under the all-categories visa',
    'Apply in person at the Embassy of Algeria, New Delhi, or via VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, or Hyderabad',
    1,
    '3-4 working days direct at the Embassy in Delhi; minimum 7 working days via VFS Delhi; 10-12 working days via VFS in other cities',
    'Embassy of Algeria, 2/2 Shanti Niketan, New Delhi - 110021 (also VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, Hyderabad)',
    'Obtain a medical appointment/admission letter from the Algerian hospital\nComplete the visa application form\nBook an appointment at the Embassy or nearest VFS Global center\nSubmit passport, photographs, and medical documents\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/algeria.webp',
    'Best-effort structure built from the confirmed general Algerian visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/algeria-visa/', '2026-09-19'
);
SET @dza7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dza7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza7, 'Core Documents', 'Required from every applicant.', 1);
SET @dza7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza7s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@dza7s1, 'Recent Passport-Size Photographs', NULL, 'copy', 1, 0, 1, 2),
(@dza7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @dza7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@dza7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(1, 7, 9700.00, 'INR', 'All-Categories Visa Fee (90 Days)', 'A shorter single-entry 30-day visa is reported at INR 8,100. An additional INR 1,600 VFS Global service fee applies if applying via VFS rather than directly at the Embassy.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/algeria-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Algeria?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the general all-categories visa with supporting medical documentation.', 1, 7, 107, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    1, 8, 'DZA-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Algeria.',
    'Not independently confirmed this session as a distinct standard visa category — likely processed under the Business visa framework with an event invitation.',
    'Up to 90 days under the all-categories visa',
    'Apply in person at the Embassy of Algeria, New Delhi, or via VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, or Hyderabad',
    1,
    '3-4 working days direct at the Embassy in Delhi; minimum 7 working days via VFS Delhi; 10-12 working days via VFS in other cities',
    'Embassy of Algeria, 2/2 Shanti Niketan, New Delhi - 110021 (also VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, Hyderabad)',
    'Obtain an official invitation letter from the event organiser\nComplete the visa application form\nBook an appointment at the Embassy or nearest VFS Global center\nSubmit passport, photographs, and event documents\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/algeria.webp',
    'Best-effort structure built from the confirmed general Algerian visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/algeria-visa/', '2026-09-19'
);
SET @dza8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dza8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza8, 'Core Documents', 'Required from every applicant.', 1);
SET @dza8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza8s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@dza8s1, 'Recent Passport-Size Photographs', NULL, 'copy', 1, 0, 1, 2),
(@dza8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @dza8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(1, 8, 9700.00, 'INR', 'All-Categories Visa Fee (90 Days)', 'A shorter single-entry 30-day visa is reported at INR 8,100. An additional INR 1,600 VFS Global service fee applies if applying via VFS rather than directly at the Embassy.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/algeria-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Algeria?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business visa framework with an official invitation letter.', 1, 8, 108, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    1, 9, 'DZA-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Algeria.',
    'Not independently confirmed this session as a distinct standard visa category — likely processed under the general all-categories visa with an event invitation.',
    'Up to 90 days under the all-categories visa',
    'Apply in person at the Embassy of Algeria, New Delhi, or via VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, or Hyderabad',
    1,
    '3-4 working days direct at the Embassy in Delhi; minimum 7 working days via VFS Delhi; 10-12 working days via VFS in other cities',
    'Embassy of Algeria, 2/2 Shanti Niketan, New Delhi - 110021 (also VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, Hyderabad)',
    'Obtain an official invitation from the sporting federation/event organiser\nComplete the visa application form\nBook an appointment at the Embassy or nearest VFS Global center\nSubmit passport, photographs, and event documents\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/algeria.webp',
    'Best-effort structure built from the confirmed general Algerian visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/algeria-visa/', '2026-09-19'
);
SET @dza9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dza9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza9, 'Core Documents', 'Required from every applicant.', 1);
SET @dza9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza9s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@dza9s1, 'Recent Passport-Size Photographs', NULL, 'copy', 1, 0, 1, 2),
(@dza9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @dza9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(1, 9, 9700.00, 'INR', 'All-Categories Visa Fee (90 Days)', 'A shorter single-entry 30-day visa is reported at INR 8,100. An additional INR 1,600 VFS Global service fee applies if applying via VFS rather than directly at the Embassy.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/algeria-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Algeria?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the general all-categories visa with a federation/event invitation.', 1, 9, 109, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    1, 10, 'DZA-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Algerian work or residence visa.',
    'Family members of an Indian national holding a qualifying Algerian work/residence visa.',
    'Tied to the sponsor''s visa validity',
    'Apply in person at the Embassy of Algeria, New Delhi, or via VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, or Hyderabad',
    1,
    'Reported at 4-6 weeks, similar to the work visa route',
    'Embassy of Algeria, 2/2 Shanti Niketan, New Delhi - 110021 (also VFS Global centers in Delhi, Mumbai, Chennai, Kolkata, Hyderabad)',
    'Confirm the sponsor holds a qualifying work/residence visa\nGather relationship proof and the sponsor''s visa copy\nComplete the visa application form\nBook an appointment at the Embassy or nearest VFS Global center\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/algeria.webp',
    'Best-effort structure built from the confirmed general Algerian visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/algeria-visa/', '2026-09-19'
);
SET @dza10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dza10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza10, 'Core Documents', 'Required from every applicant.', 1);
SET @dza10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza10s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@dza10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dza10, 'Supporting Documents', 'Evidence tied to the sponsor''s visa.', 2);
SET @dza10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dza10s2, 'Sponsor''s Work/Residence Visa Copy', NULL, 'copy', 1, 0, 0, 1),
(@dza10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(1, 10, NULL, 'INR', 'Confirm at Embassy/VFS', 'Dependent visa fee not independently broken out this session from the general fee schedule; confirm the current amount at the Embassy or VFS Global before applying.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/algeria-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on an Algeria work visa as a dependent?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence visa. Confirm the exact dependent visa procedure directly with the Embassy or VFS Global.', 1, 10, 110, 1);
