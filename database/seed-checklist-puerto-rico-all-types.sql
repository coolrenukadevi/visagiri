-- Puerto Rico Visa Checklist Engine content for all 10 visa types.
--
-- Puerto Rico's real, distinctive facts verified this session:
--   - Puerto Rico is an unincorporated U.S. territory — there is no
--     separate "Puerto Rico visa." Indian citizens must hold the same
--     valid U.S. non-immigrant visa (B1/B2, F1, H1B, etc.) required
--     for the U.S. mainland, obtained through the standard U.S.
--     Embassy/Consulate process in India.
--   - India is NOT a Visa Waiver Program (VWP) country, so Indian
--     citizens cannot use ESTA — a full visa application and, in most
--     categories, an in-person interview at a U.S. Embassy/Consulate
--     in India is required.
--   - Passport must remain valid throughout the stay, with at least
--     1 blank page; practical guidance commonly recommends 6-months
--     validity beyond the stay as well.
--   - The standard MRV (visa application) fee for B1/B2 has been
--     reported at USD 185 in prior periods; this was NOT independently
--     re-confirmed against a first-party U.S. Department of State fee
--     schedule this session, so it is flagged as an estimate requiring
--     verification at ustraveldocs.com/in before payment.
--   - Since this platform already maintains a full USA checklist, this
--     Puerto Rico entry exists primarily to clarify that "Puerto Rico"
--     searches route to the identical U.S. visa process, not a
--     separate territorial visa.
--
-- country_id 175 = Puerto Rico. visa_type_id: 1=Tourist, 2=Business,
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
    175, 1, 'PRI-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Puerto Rico for Indian citizens.',
    'Puerto Rico is a U.S. territory; there is no separate Puerto Rico visa. Indian citizens must hold a valid U.S. B1/B2 visitor visa — India is not a VWP country, so ESTA cannot be used.',
    'Determined at the port of entry by U.S. Customs and Border Protection, typically up to 6 months per entry, within the visa''s validity',
    'Apply for a U.S. B1/B2 visitor visa via the standard DS-160 process, U.S. Embassy New Delhi or a Consulate General, including an interview',
    1,
    'MRV visa fee reported at approx. USD 185 in prior periods — NOT independently re-confirmed this session; verify current fee at ustraveldocs.com/in.',
    'U.S. Embassy, New Delhi; U.S. Consulates General in Mumbai, Chennai, Kolkata, and Hyderabad',
    'Complete the DS-160 online application form\nPay the MRV visa fee (verify current amount)\nSchedule a visa interview appointment\nGather passport, photo, and supporting documents\nAttend the interview at the U.S. Embassy/Consulate\nAwait visa issuance',
    '/assets/images/visa-heroes/puerto-rico.webp',
    'skyscanner.co.in, atlys.com, cilawgroup.com secondary sourcing on U.S. territorial visa policy', 'https://www.atlys.com/en-US/visa/puerto-rico-visa', '2026-09-19'
);
SET @pri1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pri1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pri1, 'Core Documents', 'Required from every applicant.', 1);
SET @pri1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pri1s1, 'Valid Passport (Valid Through Stay, 1+ Blank Page)', NULL, 'original', 1, 0, 1, 1),
(@pri1s1, 'DS-160 Confirmation Page', NULL, 'copy', 1, 0, 1, 2),
(@pri1s1, 'Passport-Size Photograph (U.S. Visa Specifications)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pri1, 'Supporting Documents', 'Evidence of your travel plans and ties to India.', 2);
SET @pri1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pri1s2, 'Proof of Onward/Return Travel', NULL, 'copy', 1, 0, 0, 1),
(@pri1s2, 'Bank Statements / Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2),
(@pri1s2, 'Proof of Ties to India (Employment, Property, Family)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(175, 1, 185.00, 'USD', 'B1/B2 Visa Application (MRV) Fee - Estimate', 'Reported at approx. USD 185 in prior periods; NOT independently re-confirmed this session. Verify current fee at ustraveldocs.com/in before paying.', '2026-01-01', NOW(), 'https://www.ustraveldocs.com/in', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate visa for Puerto Rico?', 'No. Puerto Rico is a U.S. territory and Indian citizens must hold the same valid U.S. B1/B2 visitor visa required for the U.S. mainland.', 175, 1, 17500, 1),
('Can Indian citizens use ESTA to visit Puerto Rico?', 'No. India is not a Visa Waiver Program country, so ESTA is not available — a full visa application and interview are required.', 175, 1, 17501, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    175, 2, 'PRI-BUS-IN-01', '2026.09', 'published',
    'Business meetings, conferences, and short-term commercial activity in Puerto Rico.',
    'Business travellers use the same U.S. B1 visa category as the mainland; Puerto Rico has no separate business-visa process.',
    'Determined at port of entry, typically up to 6 months per entry, within the visa''s validity',
    'Apply for a U.S. B1 visitor visa via the standard DS-160 process, U.S. Embassy New Delhi or a Consulate General, including an interview',
    1,
    'MRV visa fee reported at approx. USD 185 in prior periods — NOT independently re-confirmed this session; verify current fee at ustraveldocs.com/in.',
    'U.S. Embassy, New Delhi; U.S. Consulates General in Mumbai, Chennai, Kolkata, and Hyderabad',
    'Complete the DS-160 online application form\nPay the MRV visa fee (verify current amount)\nSchedule a visa interview appointment\nGather business invitation letter and company documents\nAttend the interview at the U.S. Embassy/Consulate\nAwait visa issuance',
    '/assets/images/visa-heroes/puerto-rico.webp',
    'skyscanner.co.in, atlys.com secondary sourcing on U.S. territorial visa policy', NULL, '2026-09-19'
);
SET @pri2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pri2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pri2, 'Core Documents', 'Required from every applicant.', 1);
SET @pri2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pri2s1, 'Valid Passport (Valid Through Stay)', NULL, 'original', 1, 0, 1, 1),
(@pri2s1, 'DS-160 Confirmation Page', NULL, 'copy', 1, 0, 1, 2),
(@pri2s1, 'Business Invitation Letter from Host Company/Organization', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pri2, 'Supporting Documents', 'Company and financial evidence.', 2);
SET @pri2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pri2s2, 'Proof of Employment/Business Ownership in India', NULL, 'copy', 1, 0, 0, 1),
(@pri2s2, 'Bank Statements / Proof of Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the business visa for Puerto Rico different from the standard U.S. B1 visa?', 'No, it is the same B1 visa used for the U.S. mainland.', 175, 2, 17600, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    175, 3, 'PRI-STU-IN-01', '2026.09', 'published',
    'Enrollment in a recognized educational institution in Puerto Rico.',
    'Students attending institutions in Puerto Rico use the standard U.S. F1 (academic) or M1 (vocational) student visa, requiring an I-20 from a SEVP-certified school, identical to mainland U.S. requirements.',
    'Duration of the academic program, subject to F1/M1 visa terms',
    'Apply for a U.S. F1/M1 student visa via DS-160, U.S. Embassy New Delhi or a Consulate General, including an interview',
    1,
    'Requires SEVIS I-901 fee payment in addition to the standard MRV visa fee — figures not independently re-confirmed this session.',
    'U.S. Embassy, New Delhi; U.S. Consulates General in Mumbai, Chennai, Kolkata, and Hyderabad',
    'Secure admission and Form I-20 from a SEVP-certified Puerto Rico institution\nPay the SEVIS I-901 fee\nComplete the DS-160 online application form\nPay the MRV visa fee\nAttend the interview at the U.S. Embassy/Consulate',
    '/assets/images/visa-heroes/puerto-rico.webp',
    'General inference from Puerto Rico''s U.S.-territory visa structure; not independently confirmed with a dedicated Puerto Rico student-visa source this session', NULL, '2026-09-19'
);
SET @pri3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pri3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pri3, 'Core Documents', 'Required from every applicant.', 1);
SET @pri3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pri3s1, 'Valid Passport (Valid Through Stay)', NULL, 'original', 1, 0, 1, 1),
(@pri3s1, 'Form I-20 from SEVP-Certified Puerto Rico Institution', NULL, 'copy', 1, 0, 1, 2),
(@pri3s1, 'SEVIS Fee Payment Receipt', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pri3, 'Supporting Documents', 'Academic and financial evidence.', 2);
SET @pri3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pri3s2, 'Proof of Tuition Fee Payment or Funding Arrangement', NULL, 'copy', 1, 0, 0, 1),
(@pri3s2, 'Academic Transcripts and Certificates', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a special Puerto Rico student visa needed?', 'No — the standard U.S. F1/M1 student visa process applies identically to institutions in Puerto Rico.', 175, 3, 17700, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    175, 4, 'PRI-WORK-IN-01', '2026.09', 'published',
    'Paid employment in Puerto Rico for Indian nationals.',
    'Employment in Puerto Rico requires the same U.S. work-visa categories as the mainland (commonly H1B for specialty occupations), with an employer petition (Form I-129) approved by USCIS before visa application.',
    'Tied to the approved work-visa category and employer petition period',
    'Employer files Form I-129 petition with USCIS; upon approval, apply for the corresponding work visa via DS-160 and interview',
    1,
    'H1B and similar categories are subject to annual caps and lottery selection at the federal level — not independently re-confirmed against current-cycle rules this session.',
    'U.S. Embassy, New Delhi; U.S. Consulates General in Mumbai, Chennai, Kolkata, and Hyderabad',
    'Secure a job offer from a Puerto Rico-based employer\nEmployer files Form I-129 petition with USCIS\nUpon approval, complete the DS-160 online application\nPay the MRV visa fee\nAttend the interview at the U.S. Embassy/Consulate',
    '/assets/images/visa-heroes/puerto-rico.webp',
    'General inference from Puerto Rico''s U.S.-territory visa structure; not independently confirmed with a dedicated Puerto Rico work-visa source this session', NULL, '2026-09-19'
);
SET @pri4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pri4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pri4, 'Core Documents', 'Required from every applicant.', 1);
SET @pri4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pri4s1, 'Valid Passport (Valid Through Stay)', NULL, 'original', 1, 0, 1, 1),
(@pri4s1, 'Approved Form I-129 Petition Notice (Form I-797)', NULL, 'copy', 1, 0, 1, 2),
(@pri4s1, 'Employment Offer Letter from Puerto Rico-Based Employer', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pri4, 'Supporting Documents', 'Qualification evidence.', 2);
SET @pri4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pri4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a separate Puerto Rico work visa required?', 'No — the same federal U.S. work-visa categories (e.g., H1B) apply, with the same USCIS petition process as the mainland.', 175, 4, 17800, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    175, 5, 'PRI-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Puerto Rico.',
    'Indian nationals visiting family in Puerto Rico apply through the same U.S. B2 visitor visa process used for tourism; no separate family-visit category exists.',
    'Determined at port of entry, typically up to 6 months per entry, within the visa''s validity',
    'Apply for a U.S. B2 visitor visa via DS-160, U.S. Embassy New Delhi or a Consulate General, including an interview',
    1,
    'MRV visa fee reported at approx. USD 185 in prior periods — NOT independently re-confirmed this session.',
    'U.S. Embassy, New Delhi; U.S. Consulates General in Mumbai, Chennai, Kolkata, and Hyderabad',
    'Gather invitation letter and proof of relationship from the resident family member\nComplete the DS-160 online application\nPay the MRV visa fee\nAttend the interview at the U.S. Embassy/Consulate',
    '/assets/images/visa-heroes/puerto-rico.webp',
    'General inference from Puerto Rico''s U.S.-territory visa structure', NULL, '2026-09-19'
);
SET @pri5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pri5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pri5, 'Core Documents', 'Required from every applicant.', 1);
SET @pri5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pri5s1, 'Valid Passport (Valid Through Stay)', NULL, 'original', 1, 0, 1, 1),
(@pri5s1, 'Invitation Letter from Resident Family Member in Puerto Rico', NULL, 'copy', 1, 0, 1, 2),
(@pri5s1, 'Proof of Relationship (Birth/Marriage Certificates)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pri5, 'Supporting Documents', 'Additional evidence.', 2);
SET @pri5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pri5s2, 'Proof of Family Member''s Immigration Status in the U.S.', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Family Visit Visa for Puerto Rico?', 'No — the standard U.S. B2 visitor visa is used, identical to the mainland process.', 175, 5, 17900, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    175, 6, 'PRI-TRAN-IN-01', '2026.09', 'published',
    'Brief transit through Puerto Rico en route to a third country.',
    'As Puerto Rico is U.S. territory, transit passengers are subject to the same U.S. transit (C) visa or standard B1/B2 visa rules as mainland transit through a U.S. airport; Indian citizens generally require a visa even for airside transit given the absence of a visa-free transit program for non-VWP nationals.',
    'Short transit period; determined by itinerary',
    'Apply for a U.S. transit (C) visa or hold a valid B1/B2 visa, via DS-160 and interview at U.S. Embassy/Consulate in India',
    1,
    'Not independently re-confirmed this session for Puerto Rico specifically — general U.S. transit-visa rules assumed to apply given territorial status.',
    'U.S. Embassy, New Delhi; U.S. Consulates General in Mumbai, Chennai, Kolkata, and Hyderabad',
    'Confirm transit visa requirements with the U.S. Embassy/Consulate\nComplete the DS-160 online application\nPay the MRV visa fee\nAttend the interview if required',
    '/assets/images/visa-heroes/puerto-rico.webp',
    'Inference from Puerto Rico''s U.S.-territory status and general U.S. transit-visa policy; not independently confirmed this session', NULL, '2026-09-19'
);
SET @pri6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pri6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pri6, 'Core Documents', 'Required from every applicant.', 1);
SET @pri6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pri6s1, 'Valid Passport (Valid Through Stay)', NULL, 'original', 1, 0, 1, 1),
(@pri6s1, 'Onward Flight Ticket to Final Destination', NULL, 'copy', 1, 0, 1, 2),
(@pri6s1, 'Visa for Final Destination Country', NULL, 'copy', 0, 1, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Puerto Rico?', 'Given Puerto Rico''s U.S. territorial status and the absence of a visa-free transit program for non-VWP nationals, a transit or standard B1/B2 visa is generally required — not independently re-confirmed for Puerto Rico specifically this session.', 175, 6, 18000, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    175, 7, 'PRI-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Puerto Rico for Indian nationals.',
    'Medical travellers use the same U.S. B2 visitor visa category (which explicitly covers medical treatment) as the mainland; no separate Puerto Rico medical-visa category exists.',
    'Determined at port of entry, tied to treatment duration, within the visa''s validity',
    'Apply for a U.S. B2 visitor visa via DS-160, U.S. Embassy New Delhi or a Consulate General, including an interview',
    1,
    'Hospital documentation strengthens the B2 medical-purpose application; fee same as standard B1/B2.',
    'U.S. Embassy, New Delhi; U.S. Consulates General in Mumbai, Chennai, Kolkata, and Hyderabad',
    'Obtain hospital admission/treatment confirmation from a Puerto Rico hospital\nComplete the DS-160 online application\nPay the MRV visa fee\nAttend the interview at the U.S. Embassy/Consulate',
    '/assets/images/visa-heroes/puerto-rico.webp',
    'General inference from Puerto Rico''s U.S.-territory visa structure', NULL, '2026-09-19'
);
SET @pri7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pri7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pri7, 'Core Documents', 'Required from every applicant.', 1);
SET @pri7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pri7s1, 'Valid Passport (Valid Through Stay)', NULL, 'original', 1, 0, 1, 1),
(@pri7s1, 'Hospital Admission Letter/Treatment Confirmation from Puerto Rico Hospital', NULL, 'copy', 1, 0, 1, 2),
(@pri7s1, 'Proof of Funds for Treatment and Stay', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Medical Visa for Puerto Rico?', 'No — the standard U.S. B2 visitor visa, which explicitly covers medical treatment, is used.', 175, 7, 18100, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    175, 8, 'PRI-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Puerto Rico.',
    'Conference attendees use the same U.S. B1 visa category as business travellers; no separate Puerto Rico conference-visa category exists.',
    'Determined at port of entry, typically up to 6 months per entry, within the visa''s validity',
    'Apply for a U.S. B1 visitor visa via DS-160, U.S. Embassy New Delhi or a Consulate General, including an interview',
    1,
    'A formal invitation letter from the conference organizer strengthens the application.',
    'U.S. Embassy, New Delhi; U.S. Consulates General in Mumbai, Chennai, Kolkata, and Hyderabad',
    'Obtain formal invitation letter from the conference organizer\nComplete the DS-160 online application\nPay the MRV visa fee\nAttend the interview at the U.S. Embassy/Consulate',
    '/assets/images/visa-heroes/puerto-rico.webp',
    'General inference from Puerto Rico''s U.S.-territory visa structure', NULL, '2026-09-19'
);
SET @pri8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pri8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pri8, 'Core Documents', 'Required from every applicant.', 1);
SET @pri8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pri8s1, 'Valid Passport (Valid Through Stay)', NULL, 'original', 1, 0, 1, 1),
(@pri8s1, 'Formal Invitation Letter from Conference/Event Organizer', NULL, 'copy', 1, 0, 1, 2),
(@pri8s1, 'Proof of Event Registration', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Conference Visa for Puerto Rico?', 'No — the standard U.S. B1 visitor visa applies, identical to the mainland process.', 175, 8, 18200, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    175, 9, 'PRI-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Puerto Rico.',
    'Athletes and officials generally use the U.S. P (athlete) visa category for professional/amateur competitions, or B1 for unpaid/amateur participation; requires the same USCIS petition process as the mainland for the P category.',
    'Tied to the event/competition period, within the visa''s validity',
    'Apply for a U.S. P visa (with USCIS petition) or B1 visa via DS-160, U.S. Embassy New Delhi or a Consulate General',
    1,
    'Category (P vs. B1) depends on whether participation is professional/paid — not independently re-confirmed for Puerto Rico specifically this session.',
    'U.S. Embassy, New Delhi; U.S. Consulates General in Mumbai, Chennai, Kolkata, and Hyderabad',
    'Obtain letter from sports federation/event organizer confirming participation\nIf professional, employer/sponsor files USCIS petition for P visa\nComplete the DS-160 online application\nAttend the interview at the U.S. Embassy/Consulate',
    '/assets/images/visa-heroes/puerto-rico.webp',
    'General inference from Puerto Rico''s U.S.-territory visa structure; not independently confirmed with a dedicated sports-visa source this session', NULL, '2026-09-19'
);
SET @pri9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pri9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pri9, 'Core Documents', 'Required from every applicant.', 1);
SET @pri9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pri9s1, 'Valid Passport (Valid Through Stay)', NULL, 'original', 1, 0, 1, 1),
(@pri9s1, 'Letter from Sports Federation/Event Organizer Confirming Participation', NULL, 'copy', 1, 0, 1, 2),
(@pri9s1, 'Approved USCIS Petition (If Professional/P Visa Category)', NULL, 'copy', 0, 1, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Sports Visa for Puerto Rico?', 'No — the standard U.S. P (athlete) or B1 visa categories apply, identical to the mainland.', 175, 9, 18300, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    175, 10, 'PRI-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse/family member who holds a U.S. work or student visa and resides in Puerto Rico.',
    'Dependents use the corresponding U.S. derivative visa category (e.g., H4 for H1B holders, F2 for F1 holders), identical to mainland U.S. requirements.',
    'Typically matches the primary visa holder''s visa validity',
    'Apply for the corresponding derivative visa (e.g., H4, F2) via DS-160, U.S. Embassy New Delhi or a Consulate General',
    1,
    'Requires the primary visa holder''s valid visa/status documentation.',
    'U.S. Embassy, New Delhi; U.S. Consulates General in Mumbai, Chennai, Kolkata, and Hyderabad',
    'Confirm the primary visa holder''s visa category and status\nGather proof of relationship (marriage/birth certificate)\nComplete the DS-160 online application\nAttend the interview at the U.S. Embassy/Consulate',
    '/assets/images/visa-heroes/puerto-rico.webp',
    'General inference from Puerto Rico''s U.S.-territory visa structure', NULL, '2026-09-19'
);
SET @pri10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pri10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pri10, 'Core Documents', 'Required from every applicant.', 1);
SET @pri10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pri10s1, 'Valid Passport (Valid Through Stay)', NULL, 'original', 1, 0, 1, 1),
(@pri10s1, 'Proof of Relationship to Primary Visa Holder (Marriage/Birth Certificate)', NULL, 'copy', 1, 0, 1, 2),
(@pri10s1, 'Copy of Primary Visa Holder''s Visa/Petition Approval (Form I-797)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Dependent Visa for Puerto Rico?', 'No — standard U.S. derivative visa categories (e.g., H4, F2) apply, identical to the mainland.', 175, 10, 18400, 1);
