-- French Polynesia Visa Checklist Engine content for all 10 visa
-- types — built fresh this session via web search.
--
-- SOURCING CAVEAT: multiple secondary sources describe French
-- Polynesia as "governed by Schengen rules" and requiring "a Schengen
-- visa." This is legally imprecise — French Polynesia is a French
-- overseas collectivity that is NOT part of the Schengen Area or the
-- EU (Schengen only applies to France's European territory). In
-- practice, Indian travellers apply through the same French
-- Embassy/VFS Global channel used for Schengen applications, using
-- similar documents and a comparable fee, but the visa issued is a
-- French national visa specific to French Polynesia (a "visa
-- Polynésie française") — it does NOT grant entry to mainland
-- Schengen Europe, and a Schengen visa for Europe does NOT
-- automatically grant entry to French Polynesia. This distinction is
-- flagged honestly below rather than repeating the imprecise
-- secondary-source framing as fact.
--
-- French Polynesia's real, distinctive facts verified this session:
--   - Apply in person at the French Embassy or VFS Global centre in
--     India (personal appearance required).
--   - Fee: approximately EUR/USD 80; processing 15-30 working days.
--   - Stay: up to 90 days.
--   - Required: travel insurance covering at least EUR 30,000.
--
-- country_id 183 = French Polynesia. visa_type_id: 1=Tourist,
-- 2=Business, 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical,
-- 8=Conference, 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    183, 1, 'PYF-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to French Polynesia (Tahiti and its islands).',
    'Indian citizens require a French national visa specific to French Polynesia, applied through the French Embassy/VFS Global in India. Note: French Polynesia is NOT part of the Schengen Area despite some secondary sources describing it that way — a separate Schengen visa for mainland Europe does not cover it.',
    'Up to 90 days',
    'Apply in person at the French Embassy or VFS Global centre in India',
    1,
    '15-30 working days',
    'French Embassy / VFS Global centres in India',
    'Complete the visa application form for French Polynesia (not a standard Schengen application)\nGather passport, photos, and travel insurance covering at least EUR 30,000\nBook proof of accommodation and confirmed return flights\nAttend the French Embassy or VFS Global centre in person\nSubmit documents and pay the visa fee',
    '/assets/images/visa-heroes/french-polynesia.webp',
    'Atlys and VisaHQ secondary sourcing; flagged discrepancy with the imprecise "Schengen visa" framing used by multiple lower-authority sources', 'https://www.atlys.com/en-US/visa/french-polynesia-visa', '2026-09-19'
);
SET @pyf1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pyf1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf1, 'Core Documents', 'Required from every applicant.', 1);
SET @pyf1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf1s1, 'Valid Passport (6+ Months Validity Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@pyf1s1, 'Completed Visa Application Form', NULL, 'original', 1, 0, 1, 2),
(@pyf1s1, 'Two Recent Passport-Size Photographs', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @pyf1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf1s2, 'Travel Insurance (Minimum EUR 30,000 Coverage)', NULL, 'copy', 1, 0, 0, 1),
(@pyf1s2, 'Proof of Accommodation in French Polynesia', NULL, 'copy', 1, 0, 0, 2),
(@pyf1s2, 'Confirmed Return Flight Tickets', NULL, 'copy', 1, 0, 0, 3),
(@pyf1s2, 'Bank Statements Showing Sufficient Funds', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(183, 1, 80.00, 'USD', 'Visa Fee', 'Approximately EUR 80 equivalent.', '2026-01-01', NOW(), 'https://www.atlys.com/en-US/visa/french-polynesia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Schengen visa valid for French Polynesia?', 'No — despite some sources describing French Polynesia as governed by Schengen rules, it is a French overseas collectivity outside the Schengen Area. A separate French national visa specific to French Polynesia is required.', 183, 1, 18300, 1),
('Where do Indian citizens apply for a French Polynesia visa?', 'At the French Embassy or an authorised VFS Global centre in India, with the applicant attending in person.', 183, 1, 18301, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    183, 2, 'PYF-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in French Polynesia.',
    'Business travellers apply through the same French Embassy/VFS Global process as tourists, adding a business invitation letter and proof of employment/business.',
    'Up to 90 days',
    'Apply in person at the French Embassy or VFS Global centre in India',
    1,
    '15-30 working days',
    'French Embassy / VFS Global centres in India',
    'Obtain a business invitation letter\nGather passport, photos, and travel insurance covering at least EUR 30,000\nAttend the French Embassy or VFS Global centre in person\nSubmit proof of employment or business ownership\nPay the visa fee',
    '/assets/images/visa-heroes/french-polynesia.webp',
    'Atlys and VisaHQ secondary sourcing', 'https://www.atlys.com/en-US/visa/french-polynesia-visa', '2026-09-19'
);
SET @pyf2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pyf2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf2, 'Core Documents', 'Required from every applicant.', 1);
SET @pyf2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf2s1, 'Valid Passport (6+ Months Validity Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@pyf2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @pyf2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf2s2, 'Proof of Employment or Business Ownership (India)', NULL, 'copy', 1, 0, 0, 1),
(@pyf2s2, 'Travel Insurance (Minimum EUR 30,000 Coverage)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(183, 2, 80.00, 'USD', 'Visa Fee', 'Approximately EUR 80 equivalent.', '2026-01-01', NOW(), 'https://www.atlys.com/en-US/visa/french-polynesia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can business travellers apply through VFS Global for French Polynesia?', 'Yes — the same French Embassy/VFS Global application channel used for tourism also handles business visas, with a business invitation letter added.', 183, 2, 18302, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    183, 3, 'PYF-STUD-IN-01', '2026.09', 'published',
    'Academic study in French Polynesia.',
    'Not independently confirmed this session as a distinct standard category; likely requires a French long-stay visa beyond the standard 90-day allowance.',
    'Tied to the academic program duration',
    'Apply at the French Embassy in India for the appropriate long-stay visa',
    1,
    'Not independently confirmed this session for a specific working-day figure beyond the standard 15-30 working days',
    'French Embassy / VFS Global centres in India',
    'Secure admission confirmation from the French Polynesian institution\nAttend the French Embassy in person to confirm the long-stay visa process\nGather proof of financial support\nSubmit the visa application with required documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/french-polynesia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.atlys.com/en-US/visa/french-polynesia-visa', '2026-09-19'
);
SET @pyf3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pyf3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf3, 'Core Documents', 'Required from every applicant.', 1);
SET @pyf3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf3s1, 'Valid Passport (6+ Months Validity Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@pyf3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @pyf3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@pyf3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(183, 3, NULL, 'USD', 'Confirm at Embassy', 'Student visa fee not independently confirmed this session; confirm with the French Embassy.', '2026-09-01', NOW(), 'https://www.atlys.com/en-US/visa/french-polynesia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for French Polynesia?', 'Not independently confirmed this session — longer academic programs likely require a French long-stay visa beyond the standard 90-day allowance. Confirm with the French Embassy.', 183, 3, 18303, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    183, 4, 'PYF-WORK-IN-01', '2026.09', 'published',
    'Employment with a French Polynesian company.',
    'Not independently confirmed this session as a distinct standard category; likely requires an employer-sponsored French long-stay work visa beyond the standard 90-day allowance.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the French Embassy for the work-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure beyond the standard 15-30 working days',
    'French Embassy / VFS Global centres in India',
    'Secure a signed employment contract from the French Polynesian employer\nAttend the French Embassy in person to confirm the work-visa process\nGather proof of qualifications\nSubmit the visa application with required documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/french-polynesia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.atlys.com/en-US/visa/french-polynesia-visa', '2026-09-19'
);
SET @pyf4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pyf4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf4, 'Core Documents', 'Required from every applicant.', 1);
SET @pyf4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf4s1, 'Valid Passport (6+ Months Validity Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@pyf4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @pyf4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@pyf4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(183, 4, NULL, 'USD', 'Confirm at Embassy', 'Work visa fee not independently confirmed this session; confirm with the French Embassy.', '2026-09-01', NOW(), 'https://www.atlys.com/en-US/visa/french-polynesia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work visa for French Polynesia beyond the standard visa?', 'Not independently confirmed this session — employment likely requires a separate French long-stay work visa. Confirm with the French Embassy.', 183, 4, 18304, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    183, 5, 'PYF-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in French Polynesia.',
    'Family visits use the same French Embassy/VFS Global process as tourism, adding an invitation letter and relationship proof.',
    'Up to 90 days',
    'Apply in person at the French Embassy or VFS Global centre in India',
    1,
    '15-30 working days',
    'French Embassy / VFS Global centres in India',
    'Obtain an invitation letter from the family member resident in French Polynesia\nGather passport, photos, and travel insurance covering at least EUR 30,000\nAttend the French Embassy or VFS Global centre in person\nSubmit relationship proof\nPay the visa fee',
    '/assets/images/visa-heroes/french-polynesia.webp',
    'Atlys and VisaHQ secondary sourcing', 'https://www.atlys.com/en-US/visa/french-polynesia-visa', '2026-09-19'
);
SET @pyf5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pyf5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf5, 'Core Documents', 'Required from every applicant.', 1);
SET @pyf5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf5s1, 'Valid Passport (6+ Months Validity Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@pyf5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @pyf5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@pyf5s2, 'Travel Insurance (Minimum EUR 30,000 Coverage)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(183, 5, 80.00, 'USD', 'Visa Fee', 'Approximately EUR 80 equivalent.', '2026-01-01', NOW(), 'https://www.atlys.com/en-US/visa/french-polynesia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in French Polynesia on the standard visa?', 'Yes — family visits use the same French Embassy/VFS Global process as tourism, with an invitation letter and relationship proof added.', 183, 5, 18305, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    183, 6, 'PYF-TRAN-IN-01', '2026.09', 'published',
    'Transiting through French Polynesia en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard visa or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the French Embassy or your airline whether the standard visa applies',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'French Embassy / VFS Global centres in India',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific visa is required\nContact the French Embassy if needed\nSubmit passport and onward ticket for the application\nConfirm requirements with your airline before travel',
    '/assets/images/visa-heroes/french-polynesia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.atlys.com/en-US/visa/french-polynesia-visa', '2026-09-19'
);
SET @pyf6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pyf6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf6, 'Core Documents', 'Required from every applicant.', 1);
SET @pyf6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf6s1, 'Valid Passport (6+ Months Validity Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@pyf6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @pyf6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(183, 6, NULL, 'USD', 'Confirm at Embassy', 'Transit fee not independently confirmed this session; confirm with the French Embassy.', '2026-09-01', NOW(), 'https://www.atlys.com/en-US/visa/french-polynesia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through French Polynesia?', 'Not independently confirmed this session — confirm with the French Embassy or your airline whether your specific transit routing requires the standard visa.', 183, 6, 18306, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    183, 7, 'PYF-MED-IN-01', '2026.09', 'published',
    'Medical treatment in French Polynesia.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa with medical documentation.',
    'Up to 90 days',
    'Apply in person at the French Embassy or VFS Global centre in India',
    1,
    '15-30 working days',
    'French Embassy / VFS Global centres in India',
    'Obtain a medical appointment/admission letter from the hospital\nGather passport, photos, and travel insurance covering at least EUR 30,000\nAttend the French Embassy or VFS Global centre in person\nSubmit documents and pay the visa fee\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/french-polynesia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.atlys.com/en-US/visa/french-polynesia-visa', '2026-09-19'
);
SET @pyf7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pyf7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf7, 'Core Documents', 'Required from every applicant.', 1);
SET @pyf7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf7s1, 'Valid Passport (6+ Months Validity Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@pyf7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @pyf7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@pyf7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(183, 7, 80.00, 'USD', 'Visa Fee', 'Approximately EUR 80 equivalent.', '2026-01-01', NOW(), 'https://www.atlys.com/en-US/visa/french-polynesia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for French Polynesia?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard visa with supporting medical documentation.', 183, 7, 18307, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    183, 8, 'PYF-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in French Polynesia.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business visa framework with an event invitation.',
    'Up to 90 days',
    'Apply in person at the French Embassy or VFS Global centre in India',
    1,
    '15-30 working days',
    'French Embassy / VFS Global centres in India',
    'Obtain an official invitation letter from the event organiser\nGather passport, photos, and travel insurance covering at least EUR 30,000\nAttend the French Embassy or VFS Global centre in person\nSubmit documents and pay the visa fee\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/french-polynesia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.atlys.com/en-US/visa/french-polynesia-visa', '2026-09-19'
);
SET @pyf8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pyf8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf8, 'Core Documents', 'Required from every applicant.', 1);
SET @pyf8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf8s1, 'Valid Passport (6+ Months Validity Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@pyf8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @pyf8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(183, 8, 80.00, 'USD', 'Visa Fee', 'Approximately EUR 80 equivalent.', '2026-01-01', NOW(), 'https://www.atlys.com/en-US/visa/french-polynesia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for French Polynesia?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business visa framework with an official invitation letter.', 183, 8, 18308, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    183, 9, 'PYF-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in French Polynesia.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa with an event invitation.',
    'Up to 90 days',
    'Apply in person at the French Embassy or VFS Global centre in India',
    1,
    '15-30 working days',
    'French Embassy / VFS Global centres in India',
    'Obtain an official invitation from the sporting federation/event organiser\nGather passport, photos, and travel insurance covering at least EUR 30,000\nAttend the French Embassy or VFS Global centre in person\nSubmit documents and pay the visa fee\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/french-polynesia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.atlys.com/en-US/visa/french-polynesia-visa', '2026-09-19'
);
SET @pyf9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pyf9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf9, 'Core Documents', 'Required from every applicant.', 1);
SET @pyf9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf9s1, 'Valid Passport (6+ Months Validity Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@pyf9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @pyf9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(183, 9, 80.00, 'USD', 'Visa Fee', 'Approximately EUR 80 equivalent.', '2026-01-01', NOW(), 'https://www.atlys.com/en-US/visa/french-polynesia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for French Polynesia?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard visa with a federation/event invitation.', 183, 9, 18309, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    183, 10, 'PYF-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid French Polynesia work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the French Embassy for the dependent-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'French Embassy / VFS Global centres in India',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nAttend the French Embassy in person\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/french-polynesia.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://www.atlys.com/en-US/visa/french-polynesia-visa', '2026-09-19'
);
SET @pyf10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pyf10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf10, 'Core Documents', 'Required from every applicant.', 1);
SET @pyf10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf10s1, 'Valid Passport (6+ Months Validity Beyond Stay)', NULL, 'original', 1, 0, 1, 1),
(@pyf10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pyf10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @pyf10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pyf10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@pyf10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(183, 10, NULL, 'USD', 'Confirm at Embassy', 'Dependent visa fee not independently confirmed this session; confirm with the French Embassy.', '2026-09-01', NOW(), 'https://www.atlys.com/en-US/visa/french-polynesia-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent visa in French Polynesia?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the French Embassy.', 183, 10, 18310, 1);
