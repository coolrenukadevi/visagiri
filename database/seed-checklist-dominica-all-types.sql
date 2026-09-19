-- Dominica Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Dominica's real, distinctive facts verified this session:
--   - Indian citizens can enter visa-free for up to 21 days — no
--     advance visa needed for short stays.
--   - For longer stays or multiple entries, an eVisa (single or
--     multiple entry) is available, applied for entirely online.
--   - Distinctive requirement regardless of route: travellers must
--     complete an online Immigration and Customs Declaration Form
--     within 3 days of arrival, receiving a QR-code confirmation.
--
-- country_id 163 = Dominica. visa_type_id: 1=Tourist, 2=Business,
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
    163, 1, 'DMA-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Dominica.',
    'Indian citizens can enter visa-free for up to 21 days; an eVisa (single or multiple entry) is available for longer or repeat stays.',
    'Up to 21 days visa-free; longer with an eVisa',
    'No visa needed for stays up to 21 days; apply online for the eVisa for longer/multiple-entry stays',
    0,
    'eVisa approval delivered by email; specific processing time not independently confirmed this session',
    'No in-person appearance required — visa-free entry or online eVisa',
    'Confirm your intended stay is 21 days or fewer for visa-free entry\nIf a longer or multiple-entry stay is needed, apply online for the eVisa\nComplete the online Immigration and Customs Declaration Form within 3 days of arrival\nCarry your passport and the QR-code confirmation from the declaration form\nPresent all documents to immigration on arrival',
    '/assets/images/visa-heroes/dominica.webp',
    'Skyscanner and globalcitizensolutions.com secondary sourcing', 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', '2026-09-19'
);
SET @dma1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dma1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma1, 'Core Documents', 'Required from every traveller.', 1);
SET @dma1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dma1s1, 'Online Immigration and Customs Declaration Confirmation (QR Code)', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma1, 'Supporting Documents', 'Evidence of your travel plans.', 2);
SET @dma1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma1s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@dma1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(163, 1, 0.00, 'USD', 'No Fee for Visa-Free Entry (Up to 21 Days)', 'The eVisa route for longer/multiple-entry stays carries its own fee, not independently confirmed this session; confirm current pricing with Dominica immigration.', '2026-01-01', NOW(), 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Dominica?', 'Not for stays up to 21 days — Indian citizens can enter visa-free. For longer stays or multiple entries, an eVisa is available online.', 163, 1, 16300, 1),
('What is the online declaration requirement for Dominica?', 'All travellers must complete an online Immigration and Customs Declaration Form within 3 days of arrival, receiving a QR-code confirmation to present on arrival.', 163, 1, 16301, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    163, 2, 'DMA-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Dominica.',
    'Business travellers use the same visa-free/eVisa framework as tourists, adding a business invitation letter for longer stays.',
    'Up to 21 days visa-free; longer with an eVisa',
    'No visa needed for stays up to 21 days; apply online for the eVisa for longer/multiple-entry stays',
    0,
    'eVisa approval delivered by email; specific processing time not independently confirmed this session',
    'No in-person appearance required — visa-free entry or online eVisa',
    'Confirm your intended stay is 21 days or fewer for visa-free entry\nObtain a business invitation letter if applying for the eVisa\nComplete the online Immigration and Customs Declaration Form within 3 days of arrival\nCarry your passport and the QR-code confirmation\nPresent all documents to immigration on arrival',
    '/assets/images/visa-heroes/dominica.webp',
    'Skyscanner and globalcitizensolutions.com secondary sourcing', 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', '2026-09-19'
);
SET @dma2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dma2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma2, 'Core Documents', 'Required from every traveller.', 1);
SET @dma2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dma2s1, 'Business Invitation Letter (If Applying for eVisa)', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @dma2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@dma2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(163, 2, 0.00, 'USD', 'No Fee for Visa-Free Entry (Up to 21 Days)', 'The eVisa route for longer/multiple-entry stays carries its own fee, not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can business travellers use the visa-free route in Dominica?', 'Yes — the same 21-day visa-free entry applies to business travel; the eVisa is only needed for longer stays or multiple entries.', 163, 2, 16302, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    163, 3, 'DMA-STUD-IN-01', '2026.09', 'published',
    'Academic study in Dominica.',
    'Not independently confirmed this session as covered by visa-free entry; longer academic programs likely require the eVisa or a separate student permit.',
    'Tied to the academic program duration',
    'Apply for the eVisa or confirm the student-permit process with Dominica immigration',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Dominica immigration authority (no dedicated mission confirmed serving India)',
    'Secure admission confirmation from the Dominican institution\nApply online for the eVisa or confirm the student-permit process\nGather proof of financial support\nComplete the online Immigration and Customs Declaration Form within 3 days of arrival\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/dominica.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', '2026-09-19'
);
SET @dma3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dma3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma3, 'Core Documents', 'Required from every applicant.', 1);
SET @dma3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dma3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @dma3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@dma3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(163, 3, NULL, 'USD', 'Confirm with Immigration', 'Student visa/eVisa fee not independently confirmed this session; confirm with Dominica immigration.', '2026-09-01', NOW(), 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a student visa for Dominica?', 'Not independently confirmed this session — longer academic programs likely require the eVisa or a separate student permit beyond the 21-day visa-free allowance.', 163, 3, 16303, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    163, 4, 'DMA-WORK-IN-01', '2026.09', 'published',
    'Employment with a Dominican (Dominica) company.',
    'Not independently confirmed this session as covered by visa-free entry; employment likely requires a work permit sponsored by the employer.',
    'Tied to the work permit validity',
    'Employer applies for the work permit with Dominica immigration',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Dominica immigration authority (no dedicated mission confirmed serving India)',
    'Secure a signed employment offer from the Dominican employer\nHave the employer initiate the work-permit application\nGather proof of qualifications\nComplete the online Immigration and Customs Declaration Form within 3 days of arrival\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/dominica.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', '2026-09-19'
);
SET @dma4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dma4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma4, 'Core Documents', 'Required from every applicant.', 1);
SET @dma4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dma4s1, 'Signed Employment Offer/Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @dma4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@dma4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(163, 4, NULL, 'USD', 'Confirm with Immigration', 'Work permit fee not independently confirmed this session; confirm with Dominica immigration.', '2026-09-01', NOW(), 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Dominica on the visa-free entry?', 'No — employment requires a work permit sponsored by the employer through Dominica immigration; the visa-free route does not authorise work.', 163, 4, 16304, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    163, 5, 'DMA-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Dominica.',
    'Family visits use the same visa-free/eVisa framework as tourism, adding relationship proof for longer stays.',
    'Up to 21 days visa-free; longer with an eVisa',
    'No visa needed for stays up to 21 days; apply online for the eVisa for longer/multiple-entry stays',
    0,
    'eVisa approval delivered by email; specific processing time not independently confirmed this session',
    'No in-person appearance required — visa-free entry or online eVisa',
    'Confirm your intended stay is 21 days or fewer for visa-free entry\nObtain an invitation letter from the resident family member if applying for the eVisa\nComplete the online Immigration and Customs Declaration Form within 3 days of arrival\nCarry your passport and relationship proof\nPresent all documents to immigration on arrival',
    '/assets/images/visa-heroes/dominica.webp',
    'Skyscanner and globalcitizensolutions.com secondary sourcing', 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', '2026-09-19'
);
SET @dma5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dma5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma5, 'Core Documents', 'Required from every traveller.', 1);
SET @dma5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dma5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @dma5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@dma5s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(163, 5, 0.00, 'USD', 'No Fee for Visa-Free Entry (Up to 21 Days)', 'The eVisa route for longer/multiple-entry stays carries its own fee, not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Dominica visa-free?', 'Yes — Indian citizens can visit family in Dominica visa-free for up to 21 days; longer stays require the eVisa.', 163, 5, 16305, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    163, 6, 'DMA-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Dominica en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard visa-free entry rules or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with Dominica immigration or your airline whether the visa-free route applies to your transit',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'No in-person appearance required for visa-free entry',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific provision applies\nComplete the online Immigration and Customs Declaration Form if disembarking\nCarry your passport and onward ticket\nConfirm requirements with your airline before travel',
    '/assets/images/visa-heroes/dominica.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', '2026-09-19'
);
SET @dma6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dma6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma6, 'Core Documents', 'Required from every traveller.', 1);
SET @dma6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dma6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @dma6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(163, 6, NULL, 'USD', 'Confirm with Immigration', 'Transit fee not independently confirmed this session; confirm with Dominica immigration.', '2026-09-01', NOW(), 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Dominica?', 'Not independently confirmed this session — confirm with Dominica immigration or your airline whether your specific transit routing requires the standard visa-free entry rules.', 163, 6, 16306, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    163, 7, 'DMA-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Dominica.',
    'Not independently confirmed this session as a distinct standard category — likely covered under the standard visa-free/eVisa route with medical documentation.',
    'Up to 21 days visa-free; longer with an eVisa',
    'No visa needed for stays up to 21 days; apply online for the eVisa for longer stays',
    0,
    'eVisa approval delivered by email; specific processing time not independently confirmed this session',
    'No in-person appearance required — visa-free entry or online eVisa',
    'Obtain a medical appointment/admission letter from the hospital\nConfirm your intended stay is 21 days or fewer for visa-free entry\nApply online for the eVisa if a longer stay is needed\nComplete the online Immigration and Customs Declaration Form within 3 days of arrival\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/dominica.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', '2026-09-19'
);
SET @dma7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dma7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma7, 'Core Documents', 'Required from every traveller.', 1);
SET @dma7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dma7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @dma7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@dma7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(163, 7, 0.00, 'USD', 'No Fee for Visa-Free Entry (Up to 21 Days)', 'The eVisa route for longer stays carries its own fee, not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Dominica?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely covered under the standard visa-free/eVisa route with supporting medical documentation.', 163, 7, 16307, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    163, 8, 'DMA-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Dominica.',
    'Not independently confirmed this session as a distinct standard category — likely covered under the Business visa-free/eVisa route with an event invitation.',
    'Up to 21 days visa-free; longer with an eVisa',
    'No visa needed for stays up to 21 days; apply online for the eVisa for longer stays',
    0,
    'eVisa approval delivered by email; specific processing time not independently confirmed this session',
    'No in-person appearance required — visa-free entry or online eVisa',
    'Obtain an official invitation letter from the event organiser\nConfirm your intended stay is 21 days or fewer for visa-free entry\nApply online for the eVisa if a longer stay is needed\nComplete the online Immigration and Customs Declaration Form within 3 days of arrival\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/dominica.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', '2026-09-19'
);
SET @dma8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dma8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma8, 'Core Documents', 'Required from every traveller.', 1);
SET @dma8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dma8s1, 'Official Event Invitation Letter', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @dma8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(163, 8, 0.00, 'USD', 'No Fee for Visa-Free Entry (Up to 21 Days)', 'The eVisa route for longer stays carries its own fee, not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Dominica?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely covered under the Business visa-free/eVisa route with an official invitation letter.', 163, 8, 16308, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    163, 9, 'DMA-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Dominica.',
    'Not independently confirmed this session as a distinct standard category — likely covered under the standard visa-free/eVisa route with an event invitation.',
    'Up to 21 days visa-free; longer with an eVisa',
    'No visa needed for stays up to 21 days; apply online for the eVisa for longer stays',
    0,
    'eVisa approval delivered by email; specific processing time not independently confirmed this session',
    'No in-person appearance required — visa-free entry or online eVisa',
    'Obtain an official invitation from the sporting federation/event organiser\nConfirm your intended stay is 21 days or fewer for visa-free entry\nApply online for the eVisa if a longer stay is needed\nComplete the online Immigration and Customs Declaration Form within 3 days of arrival\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/dominica.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', '2026-09-19'
);
SET @dma9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dma9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma9, 'Core Documents', 'Required from every traveller.', 1);
SET @dma9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dma9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @dma9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(163, 9, 0.00, 'USD', 'No Fee for Visa-Free Entry (Up to 21 Days)', 'The eVisa route for longer stays carries its own fee, not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Dominica?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely covered under the standard visa-free/eVisa route with a federation/event invitation.', 163, 9, 16309, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    163, 10, 'DMA-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Dominica work permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s work permit.',
    'Tied to the sponsor''s work permit validity',
    'Confirm with Dominica immigration for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Dominica immigration authority (no dedicated mission confirmed serving India)',
    'Confirm the sponsor holds a qualifying Dominica work permit\nGather relationship proof and the sponsor''s permit copy\nApply via Dominica immigration\nComplete the online Immigration and Customs Declaration Form within 3 days of arrival\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/dominica.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', '2026-09-19'
);
SET @dma10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dma10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma10, 'Core Documents', 'Required from every applicant.', 1);
SET @dma10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dma10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dma10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @dma10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dma10s2, 'Sponsor''s Work Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@dma10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(163, 10, NULL, 'USD', 'Confirm with Immigration', 'Dependent permit fee not independently confirmed this session; confirm with Dominica immigration.', '2026-09-01', NOW(), 'https://www.skyscanner.co.in/destinations/visa/29475412/dominica', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Dominica?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work permit. Confirm the exact procedure with Dominica immigration.', 163, 10, 16310, 1);
