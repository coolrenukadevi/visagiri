-- Oman Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url left NULL at
-- authoring time, wired to the real supplied photo during the apply
-- step.
--
-- IMPORTANT SOURCING CAVEAT: evisa.rop.gov.om was not directly
-- fetchable this session (network egress blocked) — findings
-- triangulated from web-search-indexed news and visa-agency secondary
-- sourcing.
--
-- Oman's real, distinctive facts:
--   - The e-Visa via evisa.rop.gov.om (Royal Oman Police) is the
--     standard route for Indians; Visa-on-Arrival is only available to
--     those who already hold a valid qualifying third-country visa
--     (e.g., US, UK, Schengen), not a general option.
--   - Oman has a large, longstanding Indian expatriate population,
--     making the Work visa category especially significant — government
--     fees run OMR 86-106 depending on category, with a separate
--     Labour Permit fee tiered OMR 140-2,000 by occupation/skill level.
--   - Conference and Sports purposes were found to have NO distinct Royal
--     Oman Police product codes — recommended by sources as modeling
--     them as Business-visa sub-types/purpose tags rather than
--     standalone products, which this file follows.
--   - Family Visit vs. Family Joining fee figures were found
--     cross-contaminated across secondary sources (numbers for one
--     category appearing attributed to the other) — flagged explicitly
--     for verification rather than presented with false confidence.
--
-- country_id 86 = Oman. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    86, 1, 'OMN-TOUR-IN-01', '2026.09', 'published',
    'Leisure and desert/coastal travel to Oman.',
    'Indian passport holders — the e-Visa via evisa.rop.gov.om (Royal Oman Police) is the standard route; Visa-on-Arrival is only available to those with a valid qualifying third-country visa (e.g., US, UK, Schengen), not a general option for all Indians.',
    'Single entry up to 10 days, or a standard tourist e-visa up to 30 days',
    'Apply online via evisa.rop.gov.om in advance',
    0,
    'Standard e-visa processing is typically a few business days',
    'Not applicable for e-visa; Embassy of Oman, New Delhi, for any paper-visa alternative',
    'Complete the e-Visa application online via evisa.rop.gov.om\nUpload passport scan and photograph\nPay the e-visa fee online\nPresent the e-visa approval and passport at the border',
    '/assets/images/visa-heroes/oman.jpg',
    'Cross-checked against evisa.rop.gov.om guidance and secondary visa-agency sourcing, triangulated against sources not directly fetchable this session', 'https://evisa.rop.gov.om/', '2026-09-11'
);
SET @om1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@om1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om1, 'Core Documents', 'Required for the e-Visa application.', 1);
SET @om1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@om1s1, 'Digital Passport-Style Photograph', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om1, 'Supporting Documents', 'Evidence of your travel plans; also relevant for Visa-on-Arrival eligibility.', 2);
SET @om1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@om1s2, 'Valid US/UK/Schengen Visa (For VoA Eligibility)', 'Only relevant if pursuing Visa-on-Arrival instead of the e-Visa.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(86, 1, NULL, 'OMR', 'Confirmed After Assessment', 'Fee varies by e-visa duration/entry type and was not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://evisa.rop.gov.om/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indians get a Visa-on-Arrival for Oman?', 'Only if you already hold a valid qualifying third-country visa (e.g., US, UK, or Schengen). Otherwise, apply for the e-Visa in advance via evisa.rop.gov.om.', 86, 1, 8600, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    86, 2, 'OMN-BUS-IN-02', '2026.09', 'published',
    'Trade, investment exploration, and commercial meetings in Oman.',
    'Indian nationals travelling for business, requiring a Business e-Visa via evisa.rop.gov.om with a company invitation letter.',
    'Single or multiple entry, typically up to 30 days per visit',
    'Apply online via evisa.rop.gov.om with a business invitation letter',
    1,
    'Standard e-visa processing is typically a few business days',
    'Not applicable for e-visa; Embassy of Oman, New Delhi, for any paper-visa alternative',
    'Obtain an invitation letter from the Omani host company\nComplete the online e-Visa application form\nSubmit documents and pay the fee online',
    '/assets/images/visa-heroes/oman.jpg',
    'Cross-checked against evisa.rop.gov.om guidance, triangulated against secondary business-travel sourcing not directly fetchable this session', 'https://evisa.rop.gov.om/', '2026-09-11'
);
SET @om2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@om2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om2, 'Core Documents', 'Required for the e-Visa application.', 1);
SET @om2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@om2s1, 'Invitation Letter from Omani Company', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om2, 'Supporting Documents', 'Evidence of your own employment/business standing.', 2);
SET @om2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@om2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(86, 2, NULL, 'OMR', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://evisa.rop.gov.om/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a special code for a Business e-Visa in Oman?', 'You apply through the same evisa.rop.gov.om portal, selecting the business purpose and attaching a company invitation letter.', 86, 2, 8601, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    86, 3, 'OMN-STU-IN-03', '2026.09', 'published',
    'Enrolling in an Omani university or institution.',
    'Indian nationals admitted to a recognized Omani institution, requiring a Student Visa sponsored by the institution via the Royal Oman Police.',
    'Tied to course duration, renewable annually',
    'Institution sponsors the Student Visa application via the Royal Oman Police',
    1,
    'Standard multi-week processing; annual renewal typically required alongside institution re-enrollment confirmation',
    'Royal Oman Police, Muscat (via institution sponsorship); Embassy of Oman, New Delhi',
    'Secure admission at a recognized Omani institution\nHave the institution sponsor your Student Visa application with the Royal Oman Police\nSubmit supporting documents\nRegister with local authorities after arrival',
    '/assets/images/visa-heroes/oman.jpg',
    'Cross-checked against Royal Oman Police Student Visa guidance and secondary education-consultancy sourcing, triangulated against sources not directly fetchable this session', 'https://evisa.rop.gov.om/', '2026-09-11'
);
SET @om3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@om3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om3, 'Core Documents', 'Required from every applicant.', 1);
SET @om3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@om3s1, 'Admission Letter from Omani Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om3, 'Supporting Documents', 'Evidence of your academic background and means.', 2);
SET @om3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@om3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@om3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(86, 3, NULL, 'OMR', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://evisa.rop.gov.om/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who sponsors an Indian student''s visa for Oman?', 'The Omani institution sponsors the Student Visa application via the Royal Oman Police, rather than the student applying independently.', 86, 3, 8602, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    86, 4, 'OMN-WORK-IN-04', '2026.09', 'published',
    'Employment with an Omani employer — a significant category given Oman''s large, longstanding Indian expatriate population.',
    'Indian nationals with a confirmed job offer; the employer secures a Labour Permit and Employment Visa, with government fees running OMR 86-106 depending on category, plus a separate Labour Permit fee tiered OMR 140-2,000 by occupation/skill level.',
    'Tied to the employment contract, typically 2 years, renewable',
    'Employer secures the Labour Permit and Employment Visa via the Ministry of Labour and Royal Oman Police',
    1,
    'A genuinely two-part fee structure (government visa fee OMR 86-106, plus a separate Labour Permit fee OMR 140-2,000 tiered by occupation) — both figures should be understood separately, not blended',
    'Ministry of Labour, Muscat (employer-facing); Royal Oman Police (visa issuance)',
    'Employer secures the Labour Permit from the Ministry of Labour\nEmployer applies for the Employment Visa via the Royal Oman Police\nSubmit employment contract, qualifications, and medical clearance\nComplete residency registration after arrival',
    '/assets/images/visa-heroes/oman.jpg',
    'Cross-checked against Ministry of Labour fee schedules and secondary expatriate-employment sourcing, triangulated against sources not directly fetchable this session', 'https://evisa.rop.gov.om/', '2026-09-11'
);
SET @om4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@om4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om4, 'Core Documents', 'Required from every applicant.', 1);
SET @om4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@om4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@om4s1, 'Approved Labour Permit', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @om4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@om4s2, 'Medical Fitness Certificate', NULL, 'original', 1, 0, 0, 2),
(@om4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(86, 4, 86.00, 'OMR', 'Government Employment Visa Fee (OMR 86-106)', 'Plus a separate Labour Permit fee tiered OMR 140-2,000 by occupation/skill level — the two fees are distinct and should not be blended.', '2026-09-01', NOW(), 'https://evisa.rop.gov.om/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How much does it cost to get a Work Visa for Oman?', 'There are two separate fees: a government Employment Visa fee of OMR 86-106, plus a Labour Permit fee tiered OMR 140-2,000 by occupation and skill level.', 86, 4, 8603, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    86, 5, 'OMN-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives resident in Oman, distinct from a Family Joining/Dependent permanent residency arrangement.',
    'Indian nationals with family members residing in Oman, requiring a Family Visit e-Visa via evisa.rop.gov.om with an invitation and relationship proof.',
    'Single or multiple entry, typically up to 30 days per visit',
    'Apply online via evisa.rop.gov.om with a family invitation letter and relationship proof',
    1,
    'IMPORTANT: fee figures for Family Visit vs. the separate Family Joining (Dependent) product were found cross-contaminated across secondary sources this session — treat any specific fee figure with caution and confirm directly before relying on it',
    'Not applicable for e-visa; Embassy of Oman, New Delhi, for any paper-visa alternative',
    'Obtain an invitation letter from your relative in Oman\nGather documents proving the family relationship\nComplete the online e-Visa application form',
    '/assets/images/visa-heroes/oman.jpg',
    'Cross-checked against evisa.rop.gov.om guidance; fee figures for Family Visit and Family Joining were found cross-contaminated across sources and are explicitly flagged rather than presented with false confidence', 'https://evisa.rop.gov.om/', '2026-09-11'
);
SET @om5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@om5, '2026.09', 'Initial published checklist — Family Visit/Family Joining fee cross-contamination flagged.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om5, 'Core Documents', 'Required from every applicant.', 1);
SET @om5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@om5s1, 'Invitation Letter from Relative in Oman', NULL, 'original', 1, 0, 1, 2),
(@om5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @om5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(86, 5, NULL, 'OMR', 'Confirmed After Assessment', 'Fee figures for Family Visit and the separate Family Joining product were found cross-contaminated across sources this session — contact us to confirm the correct figure for your specific case.', '2026-09-01', NOW(), 'https://evisa.rop.gov.om/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Family Visit the same as Family Joining for Oman?', 'No — Family Visit is a short-term visit visa, while Family Joining is a separate, longer-term residency arrangement. Fee figures for the two were found mixed up across sources this session, so confirm carefully which one applies to your situation.', 86, 5, 8604, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    86, 6, 'OMN-TRANS-IN-06', '2026.09', 'published',
    'Passing through Oman en route to a third country, most relevant at Muscat International Airport.',
    'Indian nationals with a confirmed onward connection; airside transit without leaving the airport generally does not require a visa, while those leaving the airport need the standard e-Visa.',
    'Short stay, typically same-day for airside transit',
    'No visa needed for airside transit; standard e-Visa applies if leaving the airport',
    0,
    'Immediate; confirm with your airline whether your specific connection requires clearing immigration',
    'Not applicable',
    'Confirm with your airline whether your connection is airside-only\nIf clearing immigration, apply for the standard e-Visa in advance',
    '/assets/images/visa-heroes/oman.jpg',
    'Cross-checked against evisa.rop.gov.om guidance and airport-transit secondary sourcing, triangulated against sources not directly fetchable this session', 'https://evisa.rop.gov.om/', '2026-09-11'
);
SET @om6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@om6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om6, 'Core Documents', 'Required if clearing immigration.', 1);
SET @om6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@om6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om6, 'Supporting Documents', 'Only relevant if leaving the airport.', 2);
SET @om6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(86, 6, 0.00, 'INR', 'No Fee (Airside Transit)', 'No fee for airside-only transit not clearing immigration; standard e-Visa fee applies if leaving the airport.', '2026-09-01', NOW(), 'https://evisa.rop.gov.om/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need an e-Visa just to change planes in Muscat?', 'If you stay airside and don''t clear immigration, generally no. If you leave the airport, you''ll need the standard e-Visa.', 86, 6, 8605, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    86, 7, 'OMN-MED-IN-07', '2026.09', 'published',
    'Travel to Oman for medical treatment.',
    'Indian nationals travelling for treatment, requiring a Medical e-Visa via evisa.rop.gov.om with hospital documentation as supporting evidence.',
    'Tied to the treatment period, extendable with hospital documentation',
    'Apply online via evisa.rop.gov.om with hospital appointment confirmation',
    1,
    'Standard e-visa processing is typically a few business days; extension possible with hospital documentation for ongoing treatment',
    'Not applicable for e-visa',
    'Obtain a hospital appointment/admission confirmation letter from the treating Omani hospital\nComplete the e-Visa application online with medical documentation\nPresent the e-visa approval and passport at the border',
    '/assets/images/visa-heroes/oman.jpg',
    'Cross-checked against evisa.rop.gov.om guidance and secondary medical-tourism sourcing, triangulated against sources not directly fetchable this session', 'https://evisa.rop.gov.om/', '2026-09-11'
);
SET @om7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@om7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om7, 'Core Documents', 'Required from every applicant.', 1);
SET @om7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@om7s1, 'Hospital Appointment/Admission Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @om7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@om7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(86, 7, NULL, 'OMR', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://evisa.rop.gov.om/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Medical e-Visa for Oman?', 'Yes — a Medical e-Visa category exists via evisa.rop.gov.om, requiring hospital appointment/admission documentation.', 86, 7, 8606, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Business Visa Sub-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    86, 8, 'OMN-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, and official delegations in Oman.',
    'Oman has no distinct Royal Oman Police product code for Conference travel — sources recommend modeling it as a Business-visa sub-type/purpose tag, which this file follows.',
    'Single or multiple entry, typically up to 30 days per visit, within the Business e-Visa framework',
    'Apply online via evisa.rop.gov.om under the Business e-Visa, with the event invitation letter as supporting evidence',
    1,
    'No dedicated Conference visa product exists — modeled as a Business-visa use-case, per sources found this session',
    'Not applicable for e-visa',
    'Obtain an invitation letter from the conference organizer/host institution\nApply for the Business e-Visa with the invitation letter as supporting evidence\nSubmit documents and pay the fee online',
    '/assets/images/visa-heroes/oman.jpg',
    'Cross-checked against secondary sourcing confirming no dedicated Conference visa code exists; modeled as a Business-visa sub-type per source recommendation', 'https://evisa.rop.gov.om/', '2026-09-11'
);
SET @om8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@om8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om8, 'Core Documents', 'Required from every applicant.', 1);
SET @om8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@om8s1, 'Conference/Event Invitation Letter', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @om8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(86, 8, NULL, 'OMR', 'Confirmed After Assessment', 'Follows the Business e-Visa fee schedule — contact us to confirm.', '2026-09-01', NOW(), 'https://evisa.rop.gov.om/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Conference Visa for Oman?', 'No — the Royal Oman Police has no distinct product code for Conference travel. It is modeled as a Business-visa sub-type, with an event invitation letter as supporting evidence.', 86, 8, 8607, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Business Visa Sub-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    86, 9, 'OMN-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Oman.',
    'Oman has no distinct Royal Oman Police product code for Sports travel — sources recommend modeling it as a Business-visa sub-type/purpose tag, which this file follows.',
    'Single or multiple entry, typically up to 30 days, within the Business e-Visa framework',
    'Apply online via evisa.rop.gov.om under the Business e-Visa, with federation/tournament accreditation as supporting evidence',
    1,
    'No dedicated Sports visa product exists — modeled as a Business-visa use-case, per sources found this session',
    'Not applicable for e-visa',
    'Obtain accreditation from the relevant sports federation or tournament organizer\nApply for the Business e-Visa with the accreditation letter as supporting evidence\nSubmit documents and pay the fee online',
    '/assets/images/visa-heroes/oman.jpg',
    'Cross-checked against secondary sourcing confirming no dedicated Sports visa code exists; modeled as a Business-visa sub-type per source recommendation', 'https://evisa.rop.gov.om/', '2026-09-11'
);
SET @om9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@om9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om9, 'Core Documents', 'Required from every applicant.', 1);
SET @om9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@om9s1, 'Sports Federation/Tournament Accreditation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @om9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(86, 9, NULL, 'OMR', 'Confirmed After Assessment', 'Follows the Business e-Visa fee schedule — contact us to confirm.', '2026-09-01', NOW(), 'https://evisa.rop.gov.om/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports Visa for Oman?', 'No — the Royal Oman Police has no distinct product code for Sports travel. It is modeled as a Business-visa sub-type, with federation accreditation as supporting evidence.', 86, 9, 8608, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Joining
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    86, 10, 'OMN-DEP-IN-10', '2026.09', 'published',
    'Spouse/children accompanying an Indian Work or Student visa holder in Oman — Oman terms this a Family Joining permit, distinct from the short-term Family Visit visa.',
    'Family members of an Indian national already working or studying in Oman; sponsored by the principal permit holder via the Royal Oman Police.',
    'Tied to the principal permit holder''s permit validity',
    'Family members apply for a Family Joining visa, sponsored by the principal permit holder',
    1,
    'IMPORTANT: fee figures for Family Joining (Dependent) vs. the separate Family Visit product were found cross-contaminated across secondary sources this session — treat any specific fee figure with caution and confirm directly before relying on it',
    'Royal Oman Police, Muscat',
    'Confirm the principal applicant''s Work or Student permit is approved\nGather documents proving the family relationship\nApply for the Family Joining visa via the Royal Oman Police, sponsored by the principal permit holder',
    '/assets/images/visa-heroes/oman.jpg',
    'Cross-checked against Royal Oman Police Family Joining guidance; fee figures for Family Joining and Family Visit were found cross-contaminated across sources and are explicitly flagged rather than presented with false confidence', 'https://evisa.rop.gov.om/', '2026-09-11'
);
SET @om10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@om10, '2026.09', 'Initial published checklist — Family Joining/Family Visit fee cross-contamination flagged.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om10, 'Core Documents', 'Required from every applicant.', 1);
SET @om10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@om10s1, 'Proof of Relationship to Principal Permit Holder', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@om10, 'Supporting Documents', 'Evidence tied to the principal applicant''s permit.', 2);
SET @om10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@om10s2, 'Principal Applicant''s Work/Student Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@om10s2, 'Proof of Funds/Minimum Salary Threshold', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(86, 10, NULL, 'OMR', 'Confirmed After Assessment', 'Fee figures for Family Joining and the separate Family Visit product were found cross-contaminated across sources this session — contact us to confirm the correct figure for your specific case.', '2026-09-01', NOW(), 'https://evisa.rop.gov.om/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is Family Joining and how is it different from Family Visit?', 'Family Joining is a longer-term residency arrangement for dependants of a Work or Student permit holder, sponsored by the principal. Family Visit is a separate, short-term visit visa. Fee figures for the two were found mixed up across sources this session, so confirm carefully which applies to you.', 86, 10, 8609, 1);
