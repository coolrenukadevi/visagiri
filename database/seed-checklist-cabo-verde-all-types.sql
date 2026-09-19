-- Cabo Verde Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Cabo Verde's real, distinctive facts verified this session:
--   - IMPORTANT POLICY CHANGE: effective 1 January 2026, Cabo Verde
--     suspended its visa-on-arrival (the "EASE" portal scheme) for
--     citizens of 96 countries, including India, citing border
--     security. The EASE portal no longer accepts online payment for
--     visa-on-arrival. Older sourcing describing visa-free/VOA entry
--     for Indians is now OUT OF DATE — flagged explicitly.
--   - Indian travellers must now obtain a visa BEFORE departure from
--     a Cabo Verde embassy or consulate.
--   - Consulate General of Cabo Verde in New Delhi (Honorary
--     Consulate General) — the only Cabo Verdean mission in India —
--     6/24, 1st Floor, Shanti Niketan, New Delhi 110021; by
--     appointment only.
--
-- country_id 7 = Cabo Verde. visa_type_id: 1=Tourist, 2=Business,
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
    7, 1, 'CPV-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Cabo Verde.',
    'Since 1 January 2026, visa-on-arrival is suspended for Indian citizens — a visa must be obtained in advance from the Consulate General of Cabo Verde in New Delhi. Older sourcing describing visa-free/VOA entry is now out of date.',
    'Up to 30 days (previous VOA norm; confirm current validity with the consulate)',
    'Apply in advance at the Consulate General of Cabo Verde in New Delhi — visa-on-arrival is no longer available',
    1,
    'Not independently confirmed this session for a specific working-day figure under the new pre-departure regime',
    'Consulate General of Cabo Verde, 6/24 Shanti Niketan, New Delhi',
    'Book an appointment with the Consulate General of Cabo Verde in New Delhi\nComplete the visa application form\nGather passport, photo, and travel documents\nSubmit documents in person (the EASE portal no longer accepts VOA payment)\nPay the visa fee and collect the visa before departure',
    '/assets/images/visa-heroes/cabo-verde.webp',
    'VisasNews and Passe/Port reporting on the 1 January 2026 EASE visa-on-arrival suspension; Cabo Verde consulate contact details from BTW Visas/embassypages', 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', '2026-09-19'
);
SET @cpv1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cpv1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv1, 'Core Documents', 'Required from every applicant.', 1);
SET @cpv1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cpv1s1, 'Completed Visa Application Form', NULL, 'original', 1, 0, 1, 2),
(@cpv1s1, 'Recent Passport-Size Photograph', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @cpv1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv1s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 1),
(@cpv1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(7, 1, NULL, 'EUR', 'Confirm at Consulate', 'Fee not independently confirmed this session under the new post-1-January-2026 pre-departure visa regime; confirm with the Consulate General of Cabo Verde in New Delhi.', '2026-01-01', NOW(), 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens still get a Cabo Verde visa on arrival?', 'No — effective 1 January 2026, Cabo Verde suspended visa-on-arrival for Indian citizens along with 95 other nationalities. A visa must now be obtained in advance from the Consulate General of Cabo Verde in New Delhi.', 7, 1, 700, 1),
('I read that Indians could enter Cabo Verde visa-free — is that still true?', 'That information is out of date. Since 1 January 2026 the visa-on-arrival/EASE scheme no longer applies to Indian citizens; a pre-departure visa is now required.', 7, 1, 701, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    7, 2, 'CPV-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Cabo Verde.',
    'Since 1 January 2026, business travellers must also obtain a visa in advance from the Consulate General of Cabo Verde in New Delhi, adding a business invitation letter.',
    'Up to 30 days (previous VOA norm; confirm current validity with the consulate)',
    'Apply in advance at the Consulate General of Cabo Verde in New Delhi — visa-on-arrival is no longer available',
    1,
    'Not independently confirmed this session for a specific working-day figure under the new pre-departure regime',
    'Consulate General of Cabo Verde, 6/24 Shanti Niketan, New Delhi',
    'Book an appointment with the Consulate General of Cabo Verde in New Delhi\nObtain a business invitation letter\nGather passport, photo, and supporting documents\nSubmit documents in person\nPay the visa fee and collect the visa before departure',
    '/assets/images/visa-heroes/cabo-verde.webp',
    'VisasNews reporting on the 1 January 2026 EASE visa-on-arrival suspension', 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', '2026-09-19'
);
SET @cpv2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cpv2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv2, 'Core Documents', 'Required from every applicant.', 1);
SET @cpv2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cpv2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @cpv2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@cpv2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(7, 2, NULL, 'EUR', 'Confirm at Consulate', 'Fee not independently confirmed this session under the new post-1-January-2026 pre-departure visa regime; confirm with the Consulate General of Cabo Verde in New Delhi.', '2026-01-01', NOW(), 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the visa-on-arrival suspension affect business travellers too?', 'Yes — the suspension applies to all Indian travellers regardless of purpose. Business travellers must also obtain a visa in advance from the Consulate General in New Delhi.', 7, 2, 702, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    7, 3, 'CPV-STUD-IN-01', '2026.09', 'published',
    'Academic study in Cabo Verde.',
    'Not independently confirmed this session as a distinct standard category; likely requires a long-stay/residence visa beyond the standard visa.',
    'Tied to the academic program duration',
    'Confirm with the Consulate General of Cabo Verde in New Delhi for the student-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Consulate General of Cabo Verde, 6/24 Shanti Niketan, New Delhi',
    'Secure admission confirmation from the Cabo Verdean institution\nBook an appointment with the Consulate General\nGather proof of financial support\nSubmit the visa application with required documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/cabo-verde.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', '2026-09-19'
);
SET @cpv3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cpv3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv3, 'Core Documents', 'Required from every applicant.', 1);
SET @cpv3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cpv3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @cpv3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@cpv3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(7, 3, NULL, 'EUR', 'Confirm at Consulate', 'Student visa fee not independently confirmed this session; confirm with the Consulate General of Cabo Verde.', '2026-09-01', NOW(), 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for Cabo Verde?', 'Not independently confirmed this session — longer academic programs likely require a long-stay/residence visa beyond the standard visa. Confirm with the Consulate General.', 7, 3, 703, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    7, 4, 'CPV-WORK-IN-01', '2026.09', 'published',
    'Employment with a Cabo Verdean company.',
    'Not independently confirmed this session as a distinct standard category; likely requires an employer-sponsored work/residence visa beyond the standard visa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the Consulate General of Cabo Verde for the work-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Consulate General of Cabo Verde, 6/24 Shanti Niketan, New Delhi',
    'Secure a signed employment contract from the Cabo Verdean employer\nCheck whether a separate work/residence visa is required\nGather proof of qualifications\nSubmit the visa application at the Consulate General\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/cabo-verde.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', '2026-09-19'
);
SET @cpv4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cpv4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv4, 'Core Documents', 'Required from every applicant.', 1);
SET @cpv4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cpv4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @cpv4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@cpv4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(7, 4, NULL, 'EUR', 'Confirm at Consulate', 'Work visa fee not independently confirmed this session; confirm with the Consulate General of Cabo Verde.', '2026-09-01', NOW(), 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work visa for Cabo Verde beyond the standard visa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work/residence visa. Confirm with the Consulate General.', 7, 4, 704, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    7, 5, 'CPV-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Cabo Verde.',
    'Since 1 January 2026, family-visit travellers must also obtain a visa in advance from the Consulate General of Cabo Verde in New Delhi, adding an invitation letter and relationship proof.',
    'Up to 30 days (previous VOA norm; confirm current validity with the consulate)',
    'Apply in advance at the Consulate General of Cabo Verde in New Delhi — visa-on-arrival is no longer available',
    1,
    'Not independently confirmed this session for a specific working-day figure under the new pre-departure regime',
    'Consulate General of Cabo Verde, 6/24 Shanti Niketan, New Delhi',
    'Book an appointment with the Consulate General of Cabo Verde in New Delhi\nObtain an invitation letter from the family member resident in Cabo Verde\nGather passport, photo, and relationship proof\nSubmit documents in person\nPay the visa fee and collect the visa before departure',
    '/assets/images/visa-heroes/cabo-verde.webp',
    'VisasNews reporting on the 1 January 2026 EASE visa-on-arrival suspension', 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', '2026-09-19'
);
SET @cpv5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cpv5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv5, 'Core Documents', 'Required from every applicant.', 1);
SET @cpv5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cpv5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @cpv5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@cpv5s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(7, 5, NULL, 'EUR', 'Confirm at Consulate', 'Fee not independently confirmed this session under the new post-1-January-2026 pre-departure visa regime; confirm with the Consulate General of Cabo Verde.', '2026-01-01', NOW(), 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I still visit family in Cabo Verde without a pre-arranged visa?', 'No — since 1 January 2026 the visa-on-arrival suspension applies to family visits as well. A visa must be obtained in advance from the Consulate General in New Delhi.', 7, 5, 705, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    7, 6, 'CPV-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Cabo Verde en route to a third country.',
    'Not independently confirmed this session whether transit is exempt from the new pre-departure visa requirement — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the Consulate General of Cabo Verde or your airline whether transit requires the pre-departure visa',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Consulate General of Cabo Verde, 6/24 Shanti Niketan, New Delhi',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific exemption applies post-1-January-2026\nContact the Consulate General if needed\nSubmit passport and onward ticket for the application\nConfirm requirements with your airline before travel',
    '/assets/images/visa-heroes/cabo-verde.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', '2026-09-19'
);
SET @cpv6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cpv6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv6, 'Core Documents', 'Required from every applicant.', 1);
SET @cpv6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cpv6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @cpv6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(7, 6, NULL, 'EUR', 'Confirm at Consulate', 'Transit fee not independently confirmed this session; confirm with the Consulate General of Cabo Verde.', '2026-09-01', NOW(), 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Cabo Verde?', 'Not independently confirmed this session — confirm with the Consulate General of Cabo Verde or your airline whether your specific transit routing requires the new pre-departure visa.', 7, 6, 706, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    7, 7, 'CPV-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Cabo Verde.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard pre-departure visa with medical documentation.',
    'Up to 30 days (previous VOA norm; confirm current validity with the consulate)',
    'Apply in advance at the Consulate General of Cabo Verde in New Delhi',
    1,
    'Not independently confirmed this session for a specific working-day figure under the new pre-departure regime',
    'Consulate General of Cabo Verde, 6/24 Shanti Niketan, New Delhi',
    'Obtain a medical appointment/admission letter from the hospital\nBook an appointment with the Consulate General\nGather passport, photo, and medical documents\nSubmit documents in person\nPay the visa fee and collect the visa before departure',
    '/assets/images/visa-heroes/cabo-verde.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', '2026-09-19'
);
SET @cpv7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cpv7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv7, 'Core Documents', 'Required from every applicant.', 1);
SET @cpv7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cpv7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @cpv7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@cpv7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(7, 7, NULL, 'EUR', 'Confirm at Consulate', 'Fee not independently confirmed this session; confirm with the Consulate General of Cabo Verde.', '2026-09-01', NOW(), 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Cabo Verde?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard pre-departure visa with supporting medical documentation.', 7, 7, 707, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    7, 8, 'CPV-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Cabo Verde.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business visa framework with an event invitation.',
    'Up to 30 days (previous VOA norm; confirm current validity with the consulate)',
    'Apply in advance at the Consulate General of Cabo Verde in New Delhi',
    1,
    'Not independently confirmed this session for a specific working-day figure under the new pre-departure regime',
    'Consulate General of Cabo Verde, 6/24 Shanti Niketan, New Delhi',
    'Obtain an official invitation letter from the event organiser\nBook an appointment with the Consulate General\nGather passport, photo, and event documents\nSubmit documents in person\nPay the visa fee and collect the visa before departure',
    '/assets/images/visa-heroes/cabo-verde.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', '2026-09-19'
);
SET @cpv8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cpv8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv8, 'Core Documents', 'Required from every applicant.', 1);
SET @cpv8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cpv8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @cpv8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(7, 8, NULL, 'EUR', 'Confirm at Consulate', 'Fee not independently confirmed this session; confirm with the Consulate General of Cabo Verde.', '2026-09-01', NOW(), 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Cabo Verde?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business visa framework with an official invitation letter.', 7, 8, 708, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    7, 9, 'CPV-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Cabo Verde.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa with an event invitation.',
    'Up to 30 days (previous VOA norm; confirm current validity with the consulate)',
    'Apply in advance at the Consulate General of Cabo Verde in New Delhi',
    1,
    'Not independently confirmed this session for a specific working-day figure under the new pre-departure regime',
    'Consulate General of Cabo Verde, 6/24 Shanti Niketan, New Delhi',
    'Obtain an official invitation from the sporting federation/event organiser\nBook an appointment with the Consulate General\nGather passport, photo, and event documents\nSubmit documents in person\nPay the visa fee and collect the visa before departure',
    '/assets/images/visa-heroes/cabo-verde.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', '2026-09-19'
);
SET @cpv9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cpv9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv9, 'Core Documents', 'Required from every applicant.', 1);
SET @cpv9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cpv9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @cpv9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(7, 9, NULL, 'EUR', 'Confirm at Consulate', 'Fee not independently confirmed this session; confirm with the Consulate General of Cabo Verde.', '2026-09-01', NOW(), 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Cabo Verde?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard visa with a federation/event invitation.', 7, 9, 709, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    7, 10, 'CPV-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Cabo Verde work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the Consulate General of Cabo Verde for the dependent-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Consulate General of Cabo Verde, 6/24 Shanti Niketan, New Delhi',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply via the Consulate General of Cabo Verde\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/cabo-verde.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', '2026-09-19'
);
SET @cpv10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cpv10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv10, 'Core Documents', 'Required from every applicant.', 1);
SET @cpv10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cpv10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cpv10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @cpv10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cpv10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@cpv10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(7, 10, NULL, 'EUR', 'Confirm at Consulate', 'Dependent visa fee not independently confirmed this session; confirm with the Consulate General of Cabo Verde.', '2026-09-01', NOW(), 'https://visasnews.com/en/cape-verde-visa-on-arrival-suspended-for-citizens-of-96-countries/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent visa in Cabo Verde?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the Consulate General of Cabo Verde.', 7, 10, 7010, 1);
