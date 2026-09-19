-- Isle of Man Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search.
--
-- Isle of Man's real, distinctive facts verified this session:
--   - The Isle of Man is a UK Crown Dependency with its own
--     immigration rules, separate from the United Kingdom itself, but
--     entry-clearance applications are processed via UK Visas and
--     Immigration (UKVI) under a "Standard Visitor Visa — for UK, Isle
--     of Man, Jersey and Guernsey" route, per legislation.gov.uk and
--     the official visa-fees.homeoffice.gov.uk fee page.
--   - Distinctive reciprocal-recognition rule: since August 2022,
--     holders of a valid UK visitor visa can travel to the Isle of Man
--     within the Common Travel Area without a separate Isle of Man
--     visa for short visits — though sources note this recognition
--     carries restrictions on certain visa categories (not fully
--     detailed in sources reviewed this session).
--   - Confirmed visit-visa fee tiers: GBP 337 (2 years), GBP 612 (5
--     years), GBP 767 (10 years) — the base short-stay/6-month fee
--     figure was not returned by sources reviewed this session and is
--     flagged as not independently confirmed rather than guessed.
--   - Passport requirement: 6+ months validity with at least 2 blank
--     visa pages.
--   - Work/student-specific procedural detail was not extensively
--     sourced this session; both are flagged as routing through the
--     same UKVI Isle-of-Man entry-clearance mechanism as the visitor
--     visa, pending direct confirmation with the Isle of Man
--     Government.
--
-- country_id 125 = Isle of Man. visa_type_id: 1=Tourist, 2=Business,
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
    125, 1, 'IOM-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to the Isle of Man.',
    'Indian citizens need a visa to visit the Isle of Man, applied for via UK Visas and Immigration as a "Standard Visitor Visa — for UK, Isle of Man, Jersey and Guernsey." Holders of a valid UK visitor visa may travel to the Isle of Man without a separate visa for short visits, per the reciprocal Common Travel Area arrangement since August 2022, though some visa categories are excluded from this recognition.',
    'Up to 6 months per visit (visa itself may be issued for 2, 5, or 10 years)',
    'Apply online via UK Visas and Immigration, selecting the UK/Isle of Man/Jersey/Guernsey visitor route',
    0,
    'If you already hold a valid UK visitor visa, check whether it is recognized for the Isle of Man before applying separately — some visa categories are excluded from reciprocal recognition.',
    'UK Visas and Immigration (processes Isle of Man entry clearance); no separate Indian mission for the Isle of Man',
    'Confirm your passport has 6+ months validity and 2+ blank visa pages\nApply online via UK Visas and Immigration for the UK/Isle of Man/Jersey/Guernsey visitor route\nGather proof of accommodation and sufficient funds\nAttend a biometric appointment as required by UKVI\nCheck if your existing UK visa is already recognized before applying separately',
    NULL,
    'gov.im and visa-fees.homeoffice.gov.uk secondary sourcing', 'https://www.gov.im/categories/travel-traffic-and-motoring/immigration/visit/', '2026-09-19'
);
SET @iom1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@iom1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@iom1, 'Core Documents', 'Required from every applicant.', 1);
SET @iom1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@iom1s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@iom1s1, 'UK/Isle of Man/Jersey/Guernsey Visitor Visa Approval', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@iom1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @iom1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@iom1s2, 'Accommodation Reservation', NULL, 'copy', 1, 0, 0, 1),
(@iom1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(125, 1, 337.00, 'GBP', 'Standard Visitor Visa Fee (2-Year Validity)', 'Confirmed tiers: GBP 337 (2 years), GBP 612 (5 years), GBP 767 (10 years). The base short single-visit fee was not independently confirmed this session.', '2026-01-01', NOW(), 'https://visa-fees.homeoffice.gov.uk/y/india/inr/visit/standard-visitor-visa---for-uk-isle-of-man-jersey-and-guernsey/longer-term-valid-for-up-to-5-years', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for the Isle of Man?', 'Yes — applied for via UK Visas and Immigration as a Standard Visitor Visa covering the UK, Isle of Man, Jersey, and Guernsey. If you already hold a valid UK visitor visa, it may already cover the Isle of Man for short visits.', 125, 1, 12500, 1),
('Can I use my existing UK visa to visit the Isle of Man?', 'Since August 2022, holders of a valid UK visitor visa can generally travel to the Isle of Man without a separate visa under the Common Travel Area arrangement — but some visa categories are excluded from this recognition, so verify before travelling.', 125, 1, 12501, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    125, 2, 'IOM-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in the Isle of Man.',
    'Business travellers use the same Standard Visitor Visa route as tourists, also covering business visitor activities under UKVI rules.',
    'Up to 6 months per visit',
    'Apply online via UK Visas and Immigration for the UK/Isle of Man/Jersey/Guernsey visitor route, selecting business visitor purpose',
    0,
    'Same visa covers both tourism and permitted business visitor activities — check UKVI guidance on what business activities are allowed on a visitor visa.',
    'UK Visas and Immigration (processes Isle of Man entry clearance)',
    'Confirm your passport has 6+ months validity and 2+ blank visa pages\nApply online via UK Visas and Immigration, selecting business visitor purpose\nCarry a business invitation letter from the host organization\nGather proof of sufficient funds\nAttend a biometric appointment as required by UKVI',
    NULL,
    'gov.im secondary sourcing', 'https://www.gov.im/categories/travel-traffic-and-motoring/immigration/visit/', '2026-09-19'
);
SET @iom2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@iom2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@iom2, 'Core Documents', 'Required from every applicant.', 1);
SET @iom2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@iom2s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@iom2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@iom2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @iom2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@iom2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@iom2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(125, 2, 337.00, 'GBP', 'Standard Visitor Visa Fee (2-Year Validity)', 'Same fee tiers as the tourist visa apply.', '2026-01-01', NOW(), 'https://visa-fees.homeoffice.gov.uk/y/india/inr/visit/standard-visitor-visa---for-uk-isle-of-man-jersey-and-guernsey/longer-term-valid-for-up-to-5-years', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for the Isle of Man?', 'Yes — the same Standard Visitor Visa route applies, selecting business visitor purpose.', 125, 2, 12520, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    125, 3, 'IOM-STU-IN-01', '2026.09', 'published',
    'Academic study at an Isle of Man educational institution.',
    'Sources reviewed this session did not detail a distinct Isle of Man student-visa process — study visas are expected to route through UKVI\'s Isle of Man entry-clearance mechanism, similar to the visitor route, once sponsored by a licensed Isle of Man institution.',
    'Study-program length',
    'Apply via UK Visas and Immigration once sponsored by a licensed Isle of Man educational institution',
    1,
    'Not independently confirmed this session: exact student-visa category, fee, and sponsor-licensing details — verify directly with the Isle of Man Government and your institution.',
    'UK Visas and Immigration (processes Isle of Man entry clearance)',
    'Confirm admission with a licensed Isle of Man educational institution\nGather passport, admission letter, and proof of funds\nApply via UK Visas and Immigration for Isle of Man entry clearance\nAttend a biometric appointment as required by UKVI\nRegister with the institution and comply with any Isle of Man-specific conditions on arrival',
    NULL,
    'gov.im secondary sourcing', 'https://www.gov.im/categories/travel-traffic-and-motoring/immigration/visit/', '2026-09-19'
);
SET @iom3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@iom3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@iom3, 'Core Documents', 'Required from every applicant.', 1);
SET @iom3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@iom3s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@iom3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@iom3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @iom3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@iom3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@iom3s2, 'Accommodation Reservation', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(125, 3, 0.00, 'GBP', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session — verify with UK Visas and Immigration and the Isle of Man Government.', '2026-01-01', NOW(), 'https://www.gov.im/categories/travel-traffic-and-motoring/immigration/visit/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for the Isle of Man?', 'Not independently confirmed this session — study visas are expected to route through UKVI\'s Isle of Man entry-clearance mechanism once sponsored by a licensed institution; verify directly with the Isle of Man Government.', 125, 3, 12530, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    125, 4, 'IOM-WORK-IN-01', '2026.09', 'published',
    'Employment in the Isle of Man under a local employer.',
    'Sources reviewed this session did not detail a distinct Isle of Man work-visa process — work visas are expected to route through UKVI\'s Isle of Man entry-clearance mechanism once sponsored by a licensed Isle of Man employer, similar to the UK\'s own skilled-worker framework.',
    'Per work-permit/sponsorship validity',
    'Apply via UK Visas and Immigration once sponsored by a licensed Isle of Man employer',
    1,
    'Not independently confirmed this session: exact work-visa category, fee, and sponsor-licensing details — verify directly with the Isle of Man Government and your employer.',
    'UK Visas and Immigration (processes Isle of Man entry clearance)',
    'Secure a job offer from a licensed Isle of Man employer/sponsor\nEmployer confirms sponsorship for Isle of Man entry clearance\nApply via UK Visas and Immigration\nAttend a biometric appointment as required by UKVI\nRegister with local authorities on arrival if required',
    NULL,
    'gov.im secondary sourcing', 'https://www.gov.im/categories/travel-traffic-and-motoring/immigration/visit/', '2026-09-19'
);
SET @iom4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@iom4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@iom4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @iom4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@iom4s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@iom4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@iom4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @iom4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@iom4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@iom4s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(125, 4, 0.00, 'GBP', 'Fee Not Independently Confirmed', 'Work visa fees were not independently confirmed this session — verify with UK Visas and Immigration and the Isle of Man Government.', '2026-01-01', NOW(), 'https://www.gov.im/categories/travel-traffic-and-motoring/immigration/visit/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated work visa for the Isle of Man?', 'Not independently confirmed this session — work visas are expected to route through UKVI\'s Isle of Man entry-clearance mechanism once sponsored by a licensed employer; verify directly with the Isle of Man Government.', 125, 4, 12540, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    125, 5, 'IOM-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in the Isle of Man.',
    'Family visitors use the same Standard Visitor Visa route as tourists.',
    'Up to 6 months per visit',
    'Apply online via UK Visas and Immigration for the UK/Isle of Man/Jersey/Guernsey visitor route',
    0,
    'If you already hold a valid UK visitor visa, check whether it is recognized for the Isle of Man before applying separately.',
    'UK Visas and Immigration (processes Isle of Man entry clearance)',
    'Confirm your passport has 6+ months validity and 2+ blank visa pages\nApply online via UK Visas and Immigration, selecting family visit purpose\nCarry proof of relationship and host contact details\nGather proof of sufficient funds\nAttend a biometric appointment as required by UKVI',
    NULL,
    'gov.im secondary sourcing', 'https://www.gov.im/categories/travel-traffic-and-motoring/immigration/visit/', '2026-09-19'
);
SET @iom5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@iom5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@iom5, 'Core Documents', 'Required from every applicant.', 1);
SET @iom5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@iom5s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@iom5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@iom5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @iom5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@iom5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 1),
(@iom5s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(125, 5, 337.00, 'GBP', 'Standard Visitor Visa Fee (2-Year Validity)', 'Same fee tiers as the tourist visa apply.', '2026-01-01', NOW(), 'https://visa-fees.homeoffice.gov.uk/y/india/inr/visit/standard-visitor-visa---for-uk-isle-of-man-jersey-and-guernsey/longer-term-valid-for-up-to-5-years', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in the Isle of Man?', 'Yes — the same Standard Visitor Visa route applies as for tourist travel.', 125, 5, 12550, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    125, 6, 'IOM-TRAN-IN-01', '2026.09', 'published',
    'Transit through the Isle of Man en route to another destination.',
    'Given the Isle of Man\'s limited international air connectivity (most routes are via the UK mainland), transit needs are expected to be rare. Sources reviewed this session did not describe a dedicated Isle of Man transit-visa category distinct from the general visitor route.',
    'Short transit only',
    'Apply via UK Visas and Immigration for the UK/Isle of Man/Jersey/Guernsey visitor route if clearing immigration',
    0,
    'Not independently confirmed this session whether a dedicated transit exemption exists — verify with your airline before relying on transiting without a visa.',
    'UK Visas and Immigration (processes Isle of Man entry clearance)',
    'Confirm your connecting flight and transit time\nApply for the Standard Visitor Visa in advance if there is any possibility of clearing immigration\nCarry your onward boarding pass and passport\nConfirm transit exemptions directly with your airline',
    NULL,
    'gov.im secondary sourcing (transit exemption not independently confirmed)', 'https://www.gov.im/categories/travel-traffic-and-motoring/immigration/visit/', '2026-09-19'
);
SET @iom6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@iom6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@iom6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @iom6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@iom6s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@iom6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(125, 6, 0.00, 'GBP', 'Fee Not Independently Confirmed', 'Transit visa fee was not independently confirmed this session — verify with UK Visas and Immigration.', '2026-01-01', NOW(), 'https://www.gov.im/categories/travel-traffic-and-motoring/immigration/visit/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for the Isle of Man?', 'Not independently confirmed this session — transit needs are rare given limited direct international connectivity; if clearing immigration, apply for the Standard Visitor Visa in advance.', 125, 6, 12560, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    125, 7, 'IOM-MED-IN-01', '2026.09', 'published',
    'Medical treatment in the Isle of Man.',
    'Medical travellers use the same Standard Visitor Visa route as tourists.',
    'Up to 6 months per visit',
    'Apply online via UK Visas and Immigration for the UK/Isle of Man/Jersey/Guernsey visitor route, selecting medical visitor purpose',
    0,
    'Confirm your treatment and appointment directly with the Isle of Man medical facility before applying.',
    'UK Visas and Immigration (processes Isle of Man entry clearance)',
    'Confirm treatment and appointment directly with the Isle of Man medical facility\nApply online via UK Visas and Immigration, selecting medical visitor purpose\nGather proof of sufficient funds\nAttend a biometric appointment as required by UKVI\nCarry all medical and travel documents for immigration',
    NULL,
    'gov.im secondary sourcing', 'https://www.gov.im/categories/travel-traffic-and-motoring/immigration/visit/', '2026-09-19'
);
SET @iom7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@iom7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@iom7, 'Core Documents', 'Required from every applicant.', 1);
SET @iom7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@iom7s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@iom7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@iom7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @iom7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@iom7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@iom7s2, 'Accommodation Reservation', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(125, 7, 337.00, 'GBP', 'Standard Visitor Visa Fee (2-Year Validity)', 'Same fee tiers as the tourist visa apply.', '2026-01-01', NOW(), 'https://visa-fees.homeoffice.gov.uk/y/india/inr/visit/standard-visitor-visa---for-uk-isle-of-man-jersey-and-guernsey/longer-term-valid-for-up-to-5-years', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for the Isle of Man?', 'No separate medical visa — the same Standard Visitor Visa route applies, selecting medical visitor purpose.', 125, 7, 12570, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    125, 8, 'IOM-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in the Isle of Man.',
    'Conference attendees use the same Standard Visitor Visa route as business travellers.',
    'Up to 6 months per visit',
    'Apply online via UK Visas and Immigration for the UK/Isle of Man/Jersey/Guernsey visitor route',
    0,
    'Same visa covers both tourism and permitted conference/business visitor activities.',
    'UK Visas and Immigration (processes Isle of Man entry clearance)',
    'Confirm your passport has 6+ months validity and 2+ blank visa pages\nCarry conference invitation/registration confirmation\nApply online via UK Visas and Immigration, selecting business visitor purpose\nGather proof of sufficient funds\nAttend a biometric appointment as required by UKVI',
    NULL,
    'gov.im secondary sourcing', 'https://www.gov.im/categories/travel-traffic-and-motoring/immigration/visit/', '2026-09-19'
);
SET @iom8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@iom8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@iom8, 'Core Documents', 'Required from every applicant.', 1);
SET @iom8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@iom8s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@iom8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@iom8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @iom8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@iom8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@iom8s2, 'Accommodation Reservation', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(125, 8, 337.00, 'GBP', 'Standard Visitor Visa Fee (2-Year Validity)', 'Same fee tiers as the tourist visa apply.', '2026-01-01', NOW(), 'https://visa-fees.homeoffice.gov.uk/y/india/inr/visit/standard-visitor-visa---for-uk-isle-of-man-jersey-and-guernsey/longer-term-valid-for-up-to-5-years', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for the Isle of Man?', 'No separate conference visa — the same Standard Visitor Visa route applies as for business travel.', 125, 8, 12580, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    125, 9, 'IOM-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in the Isle of Man (e.g. the Isle of Man TT).',
    'Sports travellers use the same Standard Visitor Visa route as tourists.',
    'Up to 6 months per visit',
    'Apply online via UK Visas and Immigration for the UK/Isle of Man/Jersey/Guernsey visitor route',
    0,
    'Same visa covers both tourism and permitted amateur sporting activities.',
    'UK Visas and Immigration (processes Isle of Man entry clearance)',
    'Confirm your passport has 6+ months validity and 2+ blank visa pages\nCarry event invitation/participation confirmation\nApply online via UK Visas and Immigration, selecting sports visitor purpose\nGather proof of sufficient funds\nAttend a biometric appointment as required by UKVI',
    NULL,
    'gov.im secondary sourcing', 'https://www.gov.im/categories/travel-traffic-and-motoring/immigration/visit/', '2026-09-19'
);
SET @iom9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@iom9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@iom9, 'Core Documents', 'Required from every applicant.', 1);
SET @iom9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@iom9s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@iom9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@iom9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @iom9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@iom9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@iom9s2, 'Accommodation Reservation', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(125, 9, 337.00, 'GBP', 'Standard Visitor Visa Fee (2-Year Validity)', 'Same fee tiers as the tourist visa apply.', '2026-01-01', NOW(), 'https://visa-fees.homeoffice.gov.uk/y/india/inr/visit/standard-visitor-visa---for-uk-isle-of-man-jersey-and-guernsey/longer-term-valid-for-up-to-5-years', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for the Isle of Man?', 'No separate sports visa — the same Standard Visitor Visa route applies as for tourist travel.', 125, 9, 12590, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    125, 10, 'IOM-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds an Isle of Man work/student visa.',
    'Sources reviewed this session did not detail a distinct Isle of Man dependant-visa process — dependants are expected to apply via UKVI\'s Isle of Man entry-clearance mechanism, referencing the primary permit holder\'s sponsorship.',
    'Tied to the primary permit holder\'s visa validity',
    'Apply via UK Visas and Immigration, referencing the primary permit holder\'s Isle of Man sponsorship',
    1,
    'Not independently confirmed this session: exact dependant-visa category, fee, and processing time — verify directly with the Isle of Man Government.',
    'UK Visas and Immigration (processes Isle of Man entry clearance)',
    'Confirm the primary permit holder\'s work/student visa status\nGather proof of relationship (marriage/birth certificate)\nApply via UK Visas and Immigration, referencing the primary permit holder\'s sponsorship\nAttend a biometric appointment as required by UKVI\nRegister with local authorities on arrival if required',
    NULL,
    'gov.im secondary sourcing', 'https://www.gov.im/categories/travel-traffic-and-motoring/immigration/visit/', '2026-09-19'
);
SET @iom10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@iom10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@iom10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @iom10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@iom10s1, 'Valid Passport (6+ Months Validity, 2+ Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@iom10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@iom10s1, 'Primary Permit Holder\'s Visa/Sponsorship Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@iom10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @iom10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@iom10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@iom10s2, 'Accommodation Reservation', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(125, 10, 0.00, 'GBP', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session — verify with UK Visas and Immigration and the Isle of Man Government.', '2026-01-01', NOW(), 'https://www.gov.im/categories/travel-traffic-and-motoring/immigration/visit/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependants accompany a work/student visa holder to the Isle of Man?', 'Expected to be possible via UKVI\'s Isle of Man entry-clearance mechanism, referencing the primary permit holder\'s sponsorship — not independently confirmed this session; verify directly with the Isle of Man Government.', 125, 10, 12500, 1);
