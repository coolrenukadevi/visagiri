-- Gambia Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Gambia's real, distinctive facts verified this session:
--   - Applications from India are processed through BLS International
--     visa application centres (gmb.blsinternational.com) — a
--     genuinely distinctive outsourced-partner arrangement, alongside
--     an eVisa option and a visa-on-arrival route.
--   - Visa-on-arrival fee: USD 100-105, payable in cash (USD or
--     dalasi) only.
--   - Distinctive additional cost: a separate USD 20 security fee is
--     charged BOTH on entry AND on departure from Gambia, payable in
--     cash only.
--   - Yellow fever vaccination certificate (original + photocopy) is
--     mandatory.
--   - BLS processing: reported as minimum 72 hours by one source, up
--     to 7 working days by another.
--   - A sponsorship letter from a friend/relative and a covering
--     letter stating the clear purpose of visit are both required —
--     visas are issued strictly according to the stated purpose.
--
-- country_id 20 = Gambia. visa_type_id: 1=Tourist, 2=Business,
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
    20, 1, 'GMB-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Gambia.',
    'Indian citizens require a visa — apply via BLS International visa centres, an eVisa, or visa-on-arrival (all requiring a clearly stated purpose of visit).',
    'As endorsed on the visa',
    'Apply via BLS International visa application centres in India, the eVisa portal, or obtain a visa-on-arrival',
    1,
    'BLS processing reported at 72 hours to 7 working days',
    'BLS International Gambia Visa Application Centre (gmb.blsinternational.com)',
    'Complete the visa application form clearly stating your purpose of visit\nGather a covering letter and a sponsorship letter from a friend/relative in Gambia\nGet an original Yellow Fever Vaccination Certificate (mandatory)\nSubmit documents at a BLS International centre, online for the eVisa, or on arrival\nBudget for the separate USD 20 security fee charged on both entry and departure (cash only)',
    '/assets/images/visa-heroes/gambia.webp',
    'BLS International Gambia visa portal and Akbar Travels secondary sourcing', 'https://gmb.blsinternational.com/tourist_visa.php', '2026-09-19'
);
SET @gmb1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gmb1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb1, 'Core Documents', 'Required from every applicant.', 1);
SET @gmb1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb1s1, 'Valid Passport (6+ Months Validity) + Photocopy', NULL, 'original', 1, 0, 1, 1),
(@gmb1s1, 'Completed and Signed Visa Application Form', NULL, 'original', 1, 0, 1, 2),
(@gmb1s1, 'Covering Letter Stating Purpose of Travel', NULL, 'original', 1, 0, 1, 3),
(@gmb1s1, 'Original Yellow Fever Vaccination Certificate + Photocopy', NULL, 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @gmb1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb1s2, 'Sponsorship Letter from Friend/Relative in Gambia', NULL, 'copy', 1, 0, 0, 1),
(@gmb1s2, 'Hotel Reservation', NULL, 'copy', 1, 0, 0, 2),
(@gmb1s2, 'Bank Statement (Last 3 Months)', NULL, 'copy', 1, 0, 0, 3),
(@gmb1s2, 'Confirmed Return Air Ticket', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(20, 1, 105.00, 'USD', 'Visa-on-Arrival Fee', 'Reported at USD 100-105, payable in cash (USD or dalasi) only. A separate USD 20 security fee applies on both entry and departure, also cash only.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/gambia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How do Indian citizens apply for a Gambia visa?', 'Three routes exist: through BLS International visa application centres in India, an eVisa applied for online, or a visa-on-arrival at the port of entry.', 20, 1, 2000, 1),
('Is there an extra fee besides the visa cost for Gambia?', 'Yes — a separate USD 20 security fee is charged both when entering AND when departing Gambia, payable in cash (USD or dalasi) only.', 20, 1, 2001, 1),
('Is a yellow fever certificate mandatory for Gambia?', 'Yes — an original Yellow Fever Vaccination Certificate plus a photocopy is a mandatory document for the visa application.', 20, 1, 2002, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    20, 2, 'GMB-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Gambia.',
    'Business travellers apply through the same BLS International/eVisa/visa-on-arrival framework as tourists, adding a business invitation letter.',
    'As endorsed on the visa',
    'Apply via BLS International visa application centres in India, the eVisa portal, or obtain a visa-on-arrival',
    1,
    'BLS processing reported at 72 hours to 7 working days',
    'BLS International Gambia Visa Application Centre (gmb.blsinternational.com)',
    'Obtain a business invitation letter clearly stating your purpose of visit\nGet an original Yellow Fever Vaccination Certificate (mandatory)\nSubmit documents at a BLS International centre or online for the eVisa\nBudget for the separate USD 20 security fee charged on both entry and departure\nCarry all documents for immigration',
    '/assets/images/visa-heroes/gambia.webp',
    'BLS International Gambia visa portal and Akbar Travels secondary sourcing', 'https://gmb.blsinternational.com/tourist_visa.php', '2026-09-19'
);
SET @gmb2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gmb2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb2, 'Core Documents', 'Required from every applicant.', 1);
SET @gmb2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb2s1, 'Valid Passport (6+ Months Validity) + Photocopy', NULL, 'original', 1, 0, 1, 1),
(@gmb2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2),
(@gmb2s1, 'Original Yellow Fever Vaccination Certificate + Photocopy', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @gmb2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@gmb2s2, 'Confirmed Return Air Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(20, 2, 105.00, 'USD', 'Visa-on-Arrival Fee', 'Reported at USD 100-105, cash only. A separate USD 20 security fee applies on entry and departure.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/gambia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can business travellers use BLS International for Gambia visas?', 'Yes — BLS International visa centres in India process Gambia business visa applications alongside tourist visas.', 20, 2, 2003, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    20, 3, 'GMB-STUD-IN-01', '2026.09', 'published',
    'Academic study in Gambia.',
    'Not independently confirmed this session as a distinct standard category; likely requires a long-stay visa applied for via BLS International.',
    'Tied to the academic program duration',
    'Apply via BLS International visa application centres in India',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'BLS International Gambia Visa Application Centre (gmb.blsinternational.com)',
    'Secure admission confirmation from the Gambian institution\nSubmit an application via BLS International clearly stating the study purpose\nGet an original Yellow Fever Vaccination Certificate\nGather proof of financial support\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/gambia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://gmb.blsinternational.com/tourist_visa.php', '2026-09-19'
);
SET @gmb3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gmb3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb3, 'Core Documents', 'Required from every applicant.', 1);
SET @gmb3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb3s1, 'Valid Passport (6+ Months Validity) + Photocopy', NULL, 'original', 1, 0, 1, 1),
(@gmb3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @gmb3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@gmb3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(20, 3, NULL, 'USD', 'Confirm at BLS Centre', 'Student visa fee not independently confirmed this session; confirm with BLS International.', '2026-09-01', NOW(), 'https://gmb.blsinternational.com/tourist_visa.php', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for Gambia?', 'Not independently confirmed this session — longer academic programs likely require a long-stay visa applied for via BLS International. Confirm current requirements there.', 20, 3, 2004, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    20, 4, 'GMB-WORK-IN-01', '2026.09', 'published',
    'Employment with a Gambian company.',
    'Not independently confirmed this session as a distinct standard category; likely requires an employer-sponsored work permit beyond the standard visa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and BLS International for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'BLS International Gambia Visa Application Centre (gmb.blsinternational.com)',
    'Secure a signed employment contract from the Gambian employer\nSubmit an application via BLS International clearly stating the employment purpose\nGet an original Yellow Fever Vaccination Certificate\nGather proof of qualifications\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/gambia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://gmb.blsinternational.com/tourist_visa.php', '2026-09-19'
);
SET @gmb4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gmb4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb4, 'Core Documents', 'Required from every applicant.', 1);
SET @gmb4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb4s1, 'Valid Passport (6+ Months Validity) + Photocopy', NULL, 'original', 1, 0, 1, 1),
(@gmb4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @gmb4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@gmb4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(20, 4, NULL, 'USD', 'Confirm at BLS Centre', 'Work permit fee not independently confirmed this session; confirm with BLS International.', '2026-09-01', NOW(), 'https://gmb.blsinternational.com/tourist_visa.php', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for Gambia beyond the standard visa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit. Confirm with BLS International.', 20, 4, 2005, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    20, 5, 'GMB-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Gambia.',
    'Family visits use the same BLS International/eVisa/visa-on-arrival framework as tourism, with the sponsorship letter naturally coming from the resident relative.',
    'As endorsed on the visa',
    'Apply via BLS International visa application centres in India, the eVisa portal, or obtain a visa-on-arrival',
    1,
    'BLS processing reported at 72 hours to 7 working days',
    'BLS International Gambia Visa Application Centre (gmb.blsinternational.com)',
    'Obtain a sponsorship letter from the family member resident in Gambia\nGet an original Yellow Fever Vaccination Certificate (mandatory)\nSubmit documents at a BLS International centre or online for the eVisa\nBudget for the separate USD 20 security fee on entry and departure\nCarry all documents for immigration',
    '/assets/images/visa-heroes/gambia.webp',
    'BLS International Gambia visa portal and Akbar Travels secondary sourcing', 'https://gmb.blsinternational.com/tourist_visa.php', '2026-09-19'
);
SET @gmb5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gmb5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb5, 'Core Documents', 'Required from every applicant.', 1);
SET @gmb5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb5s1, 'Valid Passport (6+ Months Validity) + Photocopy', NULL, 'original', 1, 0, 1, 1),
(@gmb5s1, 'Sponsorship Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2),
(@gmb5s1, 'Original Yellow Fever Vaccination Certificate + Photocopy', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @gmb5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@gmb5s2, 'Confirmed Return Air Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(20, 5, 105.00, 'USD', 'Visa-on-Arrival Fee', 'Reported at USD 100-105, cash only. A separate USD 20 security fee applies on entry and departure.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/gambia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Gambia on the standard visa?', 'Yes — family visits follow the same BLS International/eVisa/visa-on-arrival framework as tourism, with the sponsorship letter naturally coming from your resident relative.', 20, 5, 2006, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    20, 6, 'GMB-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Gambia en route to a third country.',
    'A distinct Transit Visa category exists, also processed via BLS International (gmb.blsinternational.com/transit_visa.php).',
    'Short duration tied to the transit itinerary',
    'Apply via BLS International visa application centres in India',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'BLS International Gambia Visa Application Centre (gmb.blsinternational.com)',
    'Confirm onward travel itinerary and connecting flight/transport\nSubmit a transit visa application via BLS International\nGet an original Yellow Fever Vaccination Certificate\nGather passport and onward ticket\nConfirm requirements with your airline before travel',
    '/assets/images/visa-heroes/gambia.webp',
    'BLS International Gambia transit visa portal', 'https://gmb.blsinternational.com/transit_visa.php', '2026-09-19'
);
SET @gmb6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gmb6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb6, 'Core Documents', 'Required from every applicant.', 1);
SET @gmb6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb6s1, 'Valid Passport (6+ Months Validity) + Photocopy', NULL, 'original', 1, 0, 1, 1),
(@gmb6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @gmb6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(20, 6, NULL, 'USD', 'Confirm at BLS Centre', 'Transit visa fee not independently confirmed this session; confirm with BLS International.', '2026-09-01', NOW(), 'https://gmb.blsinternational.com/transit_visa.php', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated transit visa process for Gambia?', 'Yes — BLS International operates a dedicated transit visa application page separate from the tourist visa process.', 20, 6, 2007, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    20, 7, 'GMB-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Gambia.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa with medical documentation.',
    'As endorsed on the visa',
    'Apply via BLS International visa application centres in India, the eVisa portal, or obtain a visa-on-arrival',
    1,
    'BLS processing reported at 72 hours to 7 working days',
    'BLS International Gambia Visa Application Centre (gmb.blsinternational.com)',
    'Obtain a medical appointment/admission letter from the hospital\nGet an original Yellow Fever Vaccination Certificate (mandatory)\nSubmit documents at a BLS International centre or online for the eVisa\nBudget for the separate USD 20 security fee on entry and departure\nCarry all documents for immigration',
    '/assets/images/visa-heroes/gambia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://gmb.blsinternational.com/tourist_visa.php', '2026-09-19'
);
SET @gmb7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gmb7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb7, 'Core Documents', 'Required from every applicant.', 1);
SET @gmb7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb7s1, 'Valid Passport (6+ Months Validity) + Photocopy', NULL, 'original', 1, 0, 1, 1),
(@gmb7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @gmb7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@gmb7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(20, 7, 105.00, 'USD', 'Visa-on-Arrival Fee', 'Reported at USD 100-105, cash only. A separate USD 20 security fee applies on entry and departure.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/gambia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Gambia?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard visa with supporting medical documentation.', 20, 7, 2008, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    20, 8, 'GMB-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Gambia.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business visa framework with an event invitation.',
    'As endorsed on the visa',
    'Apply via BLS International visa application centres in India, the eVisa portal, or obtain a visa-on-arrival',
    1,
    'BLS processing reported at 72 hours to 7 working days',
    'BLS International Gambia Visa Application Centre (gmb.blsinternational.com)',
    'Obtain an official invitation letter from the event organiser\nGet an original Yellow Fever Vaccination Certificate (mandatory)\nSubmit documents at a BLS International centre or online for the eVisa\nBudget for the separate USD 20 security fee on entry and departure\nCarry all documents for immigration',
    '/assets/images/visa-heroes/gambia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://gmb.blsinternational.com/tourist_visa.php', '2026-09-19'
);
SET @gmb8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gmb8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb8, 'Core Documents', 'Required from every applicant.', 1);
SET @gmb8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb8s1, 'Valid Passport (6+ Months Validity) + Photocopy', NULL, 'original', 1, 0, 1, 1),
(@gmb8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @gmb8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(20, 8, 105.00, 'USD', 'Visa-on-Arrival Fee', 'Reported at USD 100-105, cash only. A separate USD 20 security fee applies on entry and departure.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/gambia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Gambia?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business visa framework with an official invitation letter.', 20, 8, 2009, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    20, 9, 'GMB-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Gambia.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa with an event invitation.',
    'As endorsed on the visa',
    'Apply via BLS International visa application centres in India, the eVisa portal, or obtain a visa-on-arrival',
    1,
    'BLS processing reported at 72 hours to 7 working days',
    'BLS International Gambia Visa Application Centre (gmb.blsinternational.com)',
    'Obtain an official invitation from the sporting federation/event organiser\nGet an original Yellow Fever Vaccination Certificate (mandatory)\nSubmit documents at a BLS International centre or online for the eVisa\nBudget for the separate USD 20 security fee on entry and departure\nCarry all documents for immigration',
    '/assets/images/visa-heroes/gambia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://gmb.blsinternational.com/tourist_visa.php', '2026-09-19'
);
SET @gmb9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gmb9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb9, 'Core Documents', 'Required from every applicant.', 1);
SET @gmb9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb9s1, 'Valid Passport (6+ Months Validity) + Photocopy', NULL, 'original', 1, 0, 1, 1),
(@gmb9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @gmb9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(20, 9, 105.00, 'USD', 'Visa-on-Arrival Fee', 'Reported at USD 100-105, cash only. A separate USD 20 security fee applies on entry and departure.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/gambia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Gambia?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard visa with a federation/event invitation.', 20, 9, 2010, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    20, 10, 'GMB-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Gambian work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with BLS International for the dependent-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'BLS International Gambia Visa Application Centre (gmb.blsinternational.com)',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nSubmit an application via BLS International\nGet an original Yellow Fever Vaccination Certificate\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/gambia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://gmb.blsinternational.com/tourist_visa.php', '2026-09-19'
);
SET @gmb10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gmb10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb10, 'Core Documents', 'Required from every applicant.', 1);
SET @gmb10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb10s1, 'Valid Passport (6+ Months Validity) + Photocopy', NULL, 'original', 1, 0, 1, 1),
(@gmb10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gmb10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @gmb10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gmb10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@gmb10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(20, 10, NULL, 'USD', 'Confirm at BLS Centre', 'Dependent visa fee not independently confirmed this session; confirm with BLS International.', '2026-09-01', NOW(), 'https://gmb.blsinternational.com/tourist_visa.php', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent visa in Gambia?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with BLS International.', 20, 10, 2011, 1);
