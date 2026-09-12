-- Cambodia Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url left NULL at
-- authoring time, wired to the real supplied photo during the apply
-- step.
--
-- IMPORTANT SOURCING CAVEAT: evisa.gov.kh was not directly fetchable
-- this session (network egress blocked) — findings triangulated from
-- web-search-indexed news and visa-agency secondary sourcing.
--
-- Cambodia's real, distinctive facts:
--   - Cambodia's e-Visa system cut its fees effective 1 January 2025:
--     Tourist (T) e-visa $36 → $30, and Business/Ordinary (E) e-visa
--     $42 → $35 — a genuinely dated, specific fee-reduction event, not
--     a static long-standing number.
--   - A mandatory "e-Arrival" digital arrival card has been required
--     since 1 September 2024 for air arrivals, filed online before
--     travel — a distinct, separate requirement from the e-Visa itself,
--     modeled here as an additional step rather than folded silently
--     into the visa application.
--   - Cambodia legally has only TWO visa classes: T (Tourist) and E
--     (Ordinary/everything else — business, work, retirement, study).
--     Every other "category" (Student, Work, Medical, Conference,
--     Sports, Family Visit, Dependent) is genuinely a USE-CASE of the E
--     visa, differentiated by the supporting purpose documentation and
--     post-arrival extension/permit type, not by a separate legal visa
--     code — this file states that structural fact honestly in each
--     non-Tourist category rather than inventing distinct visa codes
--     that don't exist.
--   - Transit for most air travellers connecting through Phnom Penh or
--     Siem Reap without leaving the airport does not require a visa at
--     all.
--
-- country_id 62 = Cambodia. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — T Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    62, 1, 'KHM-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Cambodia (Angkor Wat and beyond).',
    'Indian passport holders — the T (Tourist) e-visa, single entry, applied online via the official e-Visa portal.',
    'Single entry, up to 30 days',
    'Apply online via the official e-Visa portal (evisa.gov.kh); visa-on-arrival is also available but the e-visa is generally recommended',
    0,
    'Standard e-visa processing is typically 3 business days; the e-Visa fee was reduced from $36 to $30 effective 1 January 2025',
    'Not applicable for e-visa; Royal Embassy of Cambodia, New Delhi, for any paper-visa alternative',
    'Complete the e-Visa application online with passport scan and photo\nPay the e-visa fee online\nFile the separate mandatory e-Arrival digital arrival card before travel (required since 1 September 2024 for air arrivals)\nPresent the printed e-visa approval and e-Arrival confirmation at the border',
    '/assets/images/visa-heroes/cambodia.jpg',
    'Cross-checked against Cambodia e-Visa portal fee-reduction reporting and e-Arrival mandate reporting, triangulated against secondary visa-agency sourcing not directly fetchable this session', 'https://www.evisa.gov.kh/', '2026-09-11'
);
SET @kh1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kh1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh1, 'Core Documents', 'Required for the e-Visa application.', 1);
SET @kh1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kh1s1, 'Digital Passport-Style Photograph', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh1, 'Separate Mandatory Requirement', 'A distinct step from the e-Visa itself, required since 1 September 2024.', 2);
SET @kh1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh1s2, 'e-Arrival Digital Arrival Card', 'Filed online before travel for all air arrivals.', 'copy', 1, 0, 0, 1),
(@kh1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(62, 1, 2500.00, 'INR', 'T e-Visa Fee (~USD 30)', 'Reduced from USD 36 to USD 30 effective 1 January 2025; INR equivalent approximate and subject to exchange-rate fluctuation.', '2026-09-01', NOW(), 'https://www.evisa.gov.kh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Did Cambodia''s Tourist e-Visa fee change recently?', 'Yes — effective 1 January 2025, the T (Tourist) e-visa fee was reduced from USD 36 to USD 30.', 62, 1, 6200, 1),
('What is the e-Arrival card and is it different from the e-Visa?', 'Yes, it''s a separate, mandatory digital arrival card required since 1 September 2024 for all air arrivals — filed online before travel, in addition to (not instead of) the e-Visa.', 62, 1, 6201, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — E Visa (Ordinary)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    62, 2, 'KHM-BUS-IN-02', '2026.09', 'published',
    'Trade, investment exploration, and commercial meetings in Cambodia.',
    'Indian nationals travelling for business — Cambodia''s Ordinary (E) e-visa is the correct product; it is a general-purpose visa, not a business-specific code, extendable and convertible to a longer-term business/work permit after arrival.',
    'Single entry, up to 30 days on the initial e-visa; extendable after arrival',
    'Apply online via the official e-Visa portal, selecting the E (Ordinary) visa type',
    0,
    'Standard e-visa processing is typically 3 business days; the e-visa fee was reduced from $42 to $35 effective 1 January 2025',
    'Not applicable for e-visa; Royal Embassy of Cambodia, New Delhi, for any paper-visa alternative',
    'Complete the e-Visa application online, selecting the E (Ordinary) visa type\nPay the e-visa fee online\nFile the separate mandatory e-Arrival digital arrival card before travel\nPresent the printed e-visa approval at the border\nExtend or convert to a business/work permit after arrival if staying longer',
    '/assets/images/visa-heroes/cambodia.jpg',
    'Cross-checked against Cambodia e-Visa portal fee-reduction reporting, triangulated against secondary business-travel sourcing not directly fetchable this session', 'https://www.evisa.gov.kh/', '2026-09-11'
);
SET @kh2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kh2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh2, 'Core Documents', 'Required for the e-Visa application.', 1);
SET @kh2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kh2s1, 'Digital Passport-Style Photograph', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh2, 'Supporting Documents', 'Business-specific evidence and the mandatory arrival step.', 2);
SET @kh2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh2s2, 'Business Invitation Letter', NULL, 'copy', 0, 1, 0, 1),
(@kh2s2, 'e-Arrival Digital Arrival Card', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(62, 2, 2900.00, 'INR', 'E e-Visa Fee (~USD 35)', 'Reduced from USD 42 to USD 35 effective 1 January 2025; INR equivalent approximate and subject to exchange-rate fluctuation.', '2026-09-01', NOW(), 'https://www.evisa.gov.kh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Business Visa code for Cambodia?', 'No — Cambodia legally has only two visa classes, T (Tourist) and E (Ordinary). Business travel uses the E visa, which is extendable and convertible to longer-term permits after arrival.', 62, 2, 6202, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — E Visa (Ordinary, Study Use-Case)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    62, 3, 'KHM-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Cambodian educational institution.',
    'Indian nationals admitted to a recognized Cambodian institution — there is no separate Student visa code; the E (Ordinary) visa is obtained, then converted to a Student-purpose Extension of Stay (EOS) via the Ministry of Interior after arrival, referencing the institution''s enrollment documents.',
    'Tied to course duration, via annual EOS renewal',
    'Enter on the E (Ordinary) e-visa, then apply for a Student-purpose Extension of Stay with the Ministry of Interior after arrival',
    1,
    'A genuine two-step structure: E visa first, then Student-purpose EOS conversion — not a distinct pre-arrival Student visa product',
    'Ministry of Interior, Department of Immigration, Phnom Penh (for the EOS conversion)',
    'Secure admission at a recognized Cambodian institution\nApply for the E (Ordinary) e-visa online\nAfter arrival, apply for a Student-purpose Extension of Stay (EOS) with the Ministry of Interior, referencing the enrollment letter',
    '/assets/images/visa-heroes/cambodia.jpg',
    'Cross-checked against Cambodia Ministry of Interior EOS guidance and secondary education-consultancy sourcing, triangulated against sources not directly fetchable this session', 'https://www.evisa.gov.kh/', '2026-09-11'
);
SET @kh3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kh3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh3, 'Core Documents (Entry E-Visa)', 'Same as the general E visa.', 1);
SET @kh3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kh3s1, 'Admission Letter from Cambodian Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh3, 'For the Post-Arrival Student EOS', 'Filed with the Ministry of Interior after arrival.', 2);
SET @kh3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@kh3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@kh3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(62, 3, NULL, 'INR', 'Confirmed After Assessment', 'Entry e-visa fee follows the E-visa schedule; the separate Student-purpose EOS fee was not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.evisa.gov.kh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Student e-Visa for Cambodia?', 'No — you enter on the general E (Ordinary) e-visa, then convert to a Student-purpose Extension of Stay with the Ministry of Interior after arrival.', 62, 3, 6203, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — E Visa (Ordinary, Work Use-Case)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    62, 4, 'KHM-WORK-IN-04', '2026.09', 'published',
    'Employment with a Cambodian employer.',
    'Indian nationals with a confirmed job offer — enter on the E (Ordinary) e-visa, then the employer secures a Labour Book and Work Permit from the Ministry of Labour, and the employee applies for a Work-purpose Extension of Stay.',
    'Tied to the employment contract, typically 1 year via annual EOS/Work Permit renewal',
    'Employer secures the Labour Book/Work Permit from the Ministry of Labour after the employee''s E-visa entry, then files the Work-purpose EOS',
    1,
    'A genuine multi-step structure: E visa entry, then employer-driven work-permit and EOS conversion — not a distinct pre-arrival Work visa product',
    'Ministry of Labour and Vocational Training (work permit); Ministry of Interior, Department of Immigration (EOS), Phnom Penh',
    'Enter Cambodia on the E (Ordinary) e-visa\nEmployer secures the Labour Book and Work Permit from the Ministry of Labour\nApply for a Work-purpose Extension of Stay (EOS) with the Ministry of Interior',
    '/assets/images/visa-heroes/cambodia.jpg',
    'Cross-checked against Cambodia Ministry of Labour work-permit guidance and secondary expatriate-employment sourcing, triangulated against sources not directly fetchable this session', 'https://www.evisa.gov.kh/', '2026-09-11'
);
SET @kh4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kh4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh4, 'Core Documents (Entry E-Visa)', 'Same as the general E visa.', 1);
SET @kh4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kh4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh4, 'For the Post-Arrival Work Permit/EOS', 'Filed with the Ministry of Labour and Ministry of Interior after arrival.', 2);
SET @kh4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@kh4s2, 'Medical Certificate', NULL, 'original', 1, 0, 0, 2),
(@kh4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(62, 4, NULL, 'INR', 'Confirmed After Assessment', 'Entry e-visa fee follows the E-visa schedule; Labour Book/Work Permit fees were not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.evisa.gov.kh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate Work Visa to work in Cambodia?', 'There''s no distinct pre-arrival Work visa — you enter on the E (Ordinary) e-visa, then your employer secures a Labour Book and Work Permit, and you convert to a Work-purpose Extension of Stay.', 62, 4, 6204, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — E Visa (Ordinary, Family Use-Case)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    62, 5, 'KHM-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives resident in Cambodia.',
    'No distinct Family Visit visa code — either the T (Tourist) e-visa for short visits or the E (Ordinary) e-visa for longer stays, depending on your intended duration.',
    'Up to 30 days on the T e-visa; longer via the E e-visa and post-arrival extension',
    'Apply online via the official e-Visa portal, choosing T or E based on intended stay length',
    0,
    'Standard e-visa processing is typically 3 business days',
    'Not applicable for e-visa',
    'Complete the e-Visa application online, selecting T (short visit) or E (longer stay)\nPay the e-visa fee online\nFile the separate mandatory e-Arrival digital arrival card before travel\nPresent the printed e-visa approval at the border',
    '/assets/images/visa-heroes/cambodia.jpg',
    'Cross-checked against Cambodia e-Visa portal guidance, triangulated against secondary sourcing not directly fetchable this session', 'https://www.evisa.gov.kh/', '2026-09-11'
);
SET @kh5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kh5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh5, 'Core Documents', 'Required for the e-Visa application.', 1);
SET @kh5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kh5s1, 'Digital Passport-Style Photograph', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh5, 'Supporting Documents', 'Family-visit-specific evidence and the mandatory arrival step.', 2);
SET @kh5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh5s2, 'Proof of Relationship', NULL, 'copy', 0, 1, 0, 1),
(@kh5s2, 'e-Arrival Digital Arrival Card', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(62, 5, 2500.00, 'INR', 'T e-Visa Fee (~USD 30)', 'For short family visits under the T e-visa; longer stays use the E e-visa (~USD 35). INR figures approximate.', '2026-09-01', NOW(), 'https://www.evisa.gov.kh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Which e-visa should I choose to visit family in Cambodia?', 'For a short visit, the T (Tourist) e-visa works fine. If you plan a longer stay, choose the E (Ordinary) e-visa, which can be extended after arrival.', 62, 5, 6205, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    62, 6, 'KHM-TRANS-IN-06', '2026.09', 'published',
    'Passing through Phnom Penh or Siem Reap airports for a connecting flight.',
    'Passengers staying airside without clearing immigration generally do not require a visa; those leaving the airport need the standard T or E e-visa, same as any other entry purpose.',
    'Short stay, typically same-day for airside transit',
    'No visa needed for airside transit; standard T/E e-visa applies if leaving the airport',
    0,
    'Immediate; confirm with your airline whether your specific connection requires clearing immigration',
    'Not applicable',
    'Confirm with your airline whether your connection is airside-only\nIf clearing immigration, apply for the standard T or E e-visa in advance',
    '/assets/images/visa-heroes/cambodia.jpg',
    'Cross-checked against Cambodia e-Visa portal guidance and airport-transit secondary sourcing, triangulated against sources not directly fetchable this session', 'https://www.evisa.gov.kh/', '2026-09-11'
);
SET @kh6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kh6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh6, 'Core Documents', 'Required if clearing immigration.', 1);
SET @kh6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kh6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh6, 'Supporting Documents', 'Only relevant if leaving the airport.', 2);
SET @kh6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh6s2, 'e-Arrival Digital Arrival Card', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(62, 6, 0.00, 'INR', 'No Fee (Airside Transit)', 'No visa fee for airside-only transit not clearing immigration; standard T/E e-visa fee applies if leaving the airport.', '2026-09-01', NOW(), 'https://www.evisa.gov.kh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa just to change planes in Phnom Penh or Siem Reap?', 'If you stay airside and don''t clear immigration, generally no. If you leave the airport, you''ll need the standard T or E e-visa like any other entry.', 62, 6, 6206, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — E Visa (Ordinary, Medical Use-Case)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    62, 7, 'KHM-MED-IN-07', '2026.09', 'published',
    'Travel to Cambodia for medical treatment — a comparatively uncommon direction, since Cambodian medical-tourism traffic runs predominantly to India, Thailand, and Vietnam rather than the reverse.',
    'No distinct Medical visa code — the T or E e-visa is used depending on treatment duration, supported by hospital documentation.',
    'Up to 30 days on T; longer treatment via E and post-arrival extension',
    'Apply online via the official e-Visa portal, choosing T or E based on treatment duration',
    0,
    'Standard e-visa processing is typically 3 business days; a lightly-travelled category with limited public documentation found this session',
    'Not applicable for e-visa',
    'Obtain a hospital appointment/admission confirmation letter from the treating Cambodian hospital\nComplete the e-Visa application online, selecting T or E based on treatment duration\nFile the separate mandatory e-Arrival digital arrival card before travel',
    '/assets/images/visa-heroes/cambodia.jpg',
    'Limited secondary sourcing found this session for this uncommon travel direction; treated as covered under the general T/E e-visa framework', 'https://www.evisa.gov.kh/', '2026-09-11'
);
SET @kh7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kh7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh7, 'Core Documents', 'Required for the e-Visa application.', 1);
SET @kh7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kh7s1, 'Hospital Appointment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh7, 'Supporting Documents', 'Medical-specific evidence and the mandatory arrival step.', 2);
SET @kh7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh7s2, 'Medical Records/Referral', NULL, 'copy', 0, 1, 0, 1),
(@kh7s2, 'e-Arrival Digital Arrival Card', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(62, 7, 2500.00, 'INR', 'T e-Visa Fee (~USD 30)', 'For short treatment visits; longer stays use the E e-visa (~USD 35). INR figures approximate.', '2026-09-01', NOW(), 'https://www.evisa.gov.kh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Cambodia a common medical-tourism destination for Indians?', 'No — medical-tourism traffic runs predominantly the other way, with Cambodians travelling to India, Thailand, and Vietnam for treatment. Indians travelling to Cambodia for treatment use the standard T or E e-visa.', 62, 7, 6207, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — E Visa (Ordinary Use-Case)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    62, 8, 'KHM-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, and official delegations in Cambodia.',
    'No distinct Conference visa code — the T or E e-visa is used depending on the length of your visit.',
    'Up to 30 days on T; longer via E and post-arrival extension',
    'Apply online via the official e-Visa portal, choosing T or E based on visit length',
    0,
    'Standard e-visa processing is typically 3 business days',
    'Not applicable for e-visa',
    'Complete the e-Visa application online, selecting T or E based on visit length\nFile the separate mandatory e-Arrival digital arrival card before travel\nCarry a conference invitation letter as supporting evidence',
    '/assets/images/visa-heroes/cambodia.jpg',
    'Cross-checked against Cambodia e-Visa portal guidance, triangulated against secondary sourcing not directly fetchable this session', 'https://www.evisa.gov.kh/', '2026-09-11'
);
SET @kh8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kh8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh8, 'Core Documents', 'Required for the e-Visa application.', 1);
SET @kh8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kh8s1, 'Conference/Event Invitation Letter', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh8, 'Supporting Documents', 'The mandatory arrival step.', 2);
SET @kh8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh8s2, 'e-Arrival Digital Arrival Card', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(62, 8, 2500.00, 'INR', 'T e-Visa Fee (~USD 30)', 'For short conference visits; longer stays use the E e-visa (~USD 35). INR figures approximate.', '2026-09-01', NOW(), 'https://www.evisa.gov.kh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Conference Visa for Cambodia?', 'No — Cambodia has only two visa classes (T and E), and conference attendance uses whichever fits your intended stay length.', 62, 8, 6208, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — E Visa (Ordinary Use-Case)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    62, 9, 'KHM-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Cambodia.',
    'No distinct Sports visa code — the T or E e-visa is used depending on the tournament''s length.',
    'Up to 30 days on T; longer via E and post-arrival extension',
    'Apply online via the official e-Visa portal, choosing T or E based on tournament length',
    0,
    'Standard e-visa processing is typically 3 business days',
    'Not applicable for e-visa',
    'Complete the e-Visa application online, selecting T or E based on tournament length\nFile the separate mandatory e-Arrival digital arrival card before travel\nCarry federation/tournament accreditation as supporting evidence',
    '/assets/images/visa-heroes/cambodia.jpg',
    'Cross-checked against Cambodia e-Visa portal guidance, triangulated against secondary sourcing not directly fetchable this session', 'https://www.evisa.gov.kh/', '2026-09-11'
);
SET @kh9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kh9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh9, 'Core Documents', 'Required for the e-Visa application.', 1);
SET @kh9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kh9s1, 'Sports Federation/Tournament Accreditation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh9, 'Supporting Documents', 'The mandatory arrival step.', 2);
SET @kh9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh9s2, 'e-Arrival Digital Arrival Card', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(62, 9, 2500.00, 'INR', 'T e-Visa Fee (~USD 30)', 'For short tournament visits; longer stays use the E e-visa (~USD 35). INR figures approximate.', '2026-09-01', NOW(), 'https://www.evisa.gov.kh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Sports Visa for Cambodia?', 'No — Cambodia has only two visa classes (T and E), and sports delegations use whichever fits their intended stay length.', 62, 9, 6209, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — E Visa (Ordinary Use-Case)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    62, 10, 'KHM-DEP-IN-10', '2026.09', 'published',
    'Spouse/children accompanying an Indian Work or Student visa holder in Cambodia.',
    'No distinct Dependent visa code — family members enter on their own E (Ordinary) e-visa, then convert to a Dependent-purpose Extension of Stay tied to the principal permit holder, via the same Ministry of Interior process.',
    'Tied to the principal permit holder''s Extension of Stay validity',
    'Family members enter on the E e-visa, then apply for a Dependent-purpose Extension of Stay with the Ministry of Interior',
    1,
    'A genuine two-step structure, mirroring the principal applicant''s own Work/Student EOS conversion process',
    'Ministry of Interior, Department of Immigration, Phnom Penh',
    'Family members enter Cambodia on the E (Ordinary) e-visa\nGather documents proving the family relationship\nApply for a Dependent-purpose Extension of Stay with the Ministry of Interior, referencing the principal permit holder''s status',
    '/assets/images/visa-heroes/cambodia.jpg',
    'Cross-checked against Cambodia Ministry of Interior EOS guidance and secondary expatriate-family sourcing, triangulated against sources not directly fetchable this session', 'https://www.evisa.gov.kh/', '2026-09-11'
);
SET @kh10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kh10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh10, 'Core Documents (Entry E-Visa)', 'Same as the general E visa.', 1);
SET @kh10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@kh10s1, 'Proof of Relationship to Principal Permit Holder', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kh10, 'For the Post-Arrival Dependent EOS', 'Filed with the Ministry of Interior after arrival.', 2);
SET @kh10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kh10s2, 'Principal Applicant''s Extension of Stay Copy', NULL, 'copy', 1, 0, 0, 1),
(@kh10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(62, 10, NULL, 'INR', 'Confirmed After Assessment', 'Entry e-visa fee follows the E-visa schedule; the separate Dependent-purpose EOS fee was not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.evisa.gov.kh/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my family join me while I work or study in Cambodia?', 'Yes — they enter on the E (Ordinary) e-visa and then convert to a Dependent-purpose Extension of Stay tied to your own Work or Student permit.', 62, 10, 6210, 1);
