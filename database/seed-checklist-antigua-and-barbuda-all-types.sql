-- Antigua and Barbuda Visa Checklist Engine content for all 10 visa
-- types — built fresh this session via web search. hero_image_url
-- left NULL pattern-consistent with other batches.
--
-- SOURCING CAVEAT: official Antigua and Barbuda immigration domains
-- were not directly fetchable this session (egress-proxy blocked);
-- findings triangulated from Akbar Travels, VisaHQ, and Joinsherpa
-- secondary sourcing.
--
-- Antigua and Barbuda's real, distinctive facts verified this session:
--   - Indian citizens are eligible for an eVisa, processed entirely
--     online with no passport stamping/submission required — a
--     genuinely convenient, fully digital process.
--   - Proof of onward travel is a stated basic requirement.
--   - Agency-reported fee starts around INR 8,199 (Akbar Travels
--     pricing, not necessarily the official government fee).
--
-- country_id 154 = Antigua and Barbuda. visa_type_id: 1=Tourist,
-- 2=Business, 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical,
-- 8=Conference, 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    154, 1, 'ATG-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Antigua and Barbuda.',
    'Indian passport holders are eligible for an eVisa, processed entirely online with no passport stamping/submission required.',
    'Confirm duration on the eVisa approval; short-stay tourism is the primary use case',
    'Apply online for the eVisa — no embassy visit or passport submission needed',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Antigua and Barbuda eVisa Portal (online) — no in-person appearance required',
    'Create an account on the official eVisa portal\nUpload passport bio page, photo, and travel itinerary\nProvide proof of onward travel\nPay the eVisa fee online\nReceive the eVisa confirmation electronically and carry it alongside your passport',
    '/assets/images/visa-heroes/antigua-and-barbuda.webp',
    'Akbar Travels and Joinsherpa secondary sourcing; official Antigua and Barbuda government domains not directly fetchable this session', 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', '2026-09-19'
);
SET @atg1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@atg1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg1, 'Core Documents', 'Required from every applicant.', 1);
SET @atg1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@atg1s1, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@atg1s1, 'Completed Online eVisa Application', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @atg1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg1s2, 'Proof of Onward Travel', NULL, 'copy', 1, 0, 0, 1),
(@atg1s2, 'Confirmed Accommodation Booking', NULL, 'copy', 1, 0, 0, 2),
(@atg1s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(154, 1, 8199.00, 'INR', 'eVisa Fee (Agency-Reported Starting Price)', 'Reported starting price via Akbar Travels; this is a travel agency price, not necessarily the official government fee. Confirm the exact amount on the official eVisa portal before paying.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need to submit my passport for an Antigua and Barbuda eVisa?', 'No — the eVisa is processed entirely online, and you receive the approval electronically without submitting your passport for stamping.', 154, 1, 15400, 1),
('What proof do I need to show for an Antigua and Barbuda eVisa?', 'Proof of onward travel is a core requirement, alongside passport, photo, and standard supporting documents.', 154, 1, 15401, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    154, 2, 'ATG-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Antigua and Barbuda.',
    'Business travellers use the same eVisa framework as tourists, typically adding a business invitation letter.',
    'Confirm duration on the eVisa approval',
    'Apply online for the eVisa — no embassy visit or passport submission needed',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Antigua and Barbuda eVisa Portal (online) — no in-person appearance required',
    'Create an account on the official eVisa portal\nUpload passport bio page, photo, and business invitation letter\nProvide proof of onward travel\nPay the eVisa fee online\nReceive the eVisa confirmation electronically and carry it alongside your passport',
    '/assets/images/visa-heroes/antigua-and-barbuda.webp',
    'Akbar Travels secondary sourcing; official Antigua and Barbuda government domains not directly fetchable this session', 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', '2026-09-19'
);
SET @atg2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@atg2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg2, 'Core Documents', 'Required from every applicant.', 1);
SET @atg2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@atg2s1, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@atg2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @atg2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@atg2s2, 'Proof of Onward Travel', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(154, 2, 8199.00, 'INR', 'eVisa Fee (Agency-Reported Starting Price)', 'Reported starting price via Akbar Travels; this is a travel agency price, not necessarily the official government fee. Confirm on the official eVisa portal before paying.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do business travellers use the same eVisa as tourists?', 'Yes — business travel uses the same eVisa framework as tourism, with a business invitation letter added to the supporting documents.', 154, 2, 15402, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    154, 3, 'ATG-STUD-IN-01', '2026.09', 'published',
    'Academic study in Antigua and Barbuda.',
    'Not independently confirmed this session as a distinct standard eVisa category for long-term study; likely requires a longer-stay student permit beyond the standard eVisa.',
    'Tied to the academic program duration',
    'Confirm with the nearest Antigua and Barbuda diplomatic mission or the eVisa portal whether a separate student permit is required',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Antigua and Barbuda eVisa Portal (online); confirm student-permit process with the relevant mission',
    'Secure admission confirmation from the Antigua and Barbuda institution\nCheck whether the standard eVisa or a separate student permit applies\nGather proof of financial support\nApply via the eVisa portal or relevant mission\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/antigua-and-barbuda.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', '2026-09-19'
);
SET @atg3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@atg3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg3, 'Core Documents', 'Required from every applicant.', 1);
SET @atg3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@atg3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @atg3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@atg3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(154, 3, NULL, 'INR', 'Confirm at Mission/Portal', 'Student permit fee not independently confirmed this session; confirm with the relevant mission or eVisa portal.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I study in Antigua and Barbuda on the standard eVisa?', 'Not independently confirmed this session — long-term study may require a separate student permit beyond the standard tourist/business eVisa. Confirm with the relevant mission.', 154, 3, 15403, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    154, 4, 'ATG-WORK-IN-01', '2026.09', 'published',
    'Employment with an Antigua and Barbuda company.',
    'Not independently confirmed this session as a distinct standard eVisa category; likely requires a work permit sponsored by the employer beyond the standard eVisa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the nearest Antigua and Barbuda diplomatic mission for the work permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Antigua and Barbuda eVisa Portal (online); confirm work-permit process with the relevant mission',
    'Secure a signed employment contract from the Antigua and Barbuda employer\nCheck whether a separate work permit is required beyond the eVisa\nGather proof of qualifications\nApply via the relevant mission or portal\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/antigua-and-barbuda.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', '2026-09-19'
);
SET @atg4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@atg4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg4, 'Core Documents', 'Required from every applicant.', 1);
SET @atg4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@atg4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @atg4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@atg4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(154, 4, NULL, 'INR', 'Confirm at Mission/Portal', 'Work permit fee not independently confirmed this session; confirm with the relevant mission or portal.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit beyond the eVisa to work in Antigua and Barbuda?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit beyond the standard eVisa. Confirm with the relevant mission.', 154, 4, 15404, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    154, 5, 'ATG-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Antigua and Barbuda.',
    'Family visits are explicitly noted as an appropriate use case for the standard eVisa, alongside tourism and business.',
    'Confirm duration on the eVisa approval',
    'Apply online for the eVisa — no embassy visit or passport submission needed',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Antigua and Barbuda eVisa Portal (online) — no in-person appearance required',
    'Obtain an invitation letter from the family member resident in Antigua and Barbuda\nCreate an account on the official eVisa portal\nUpload passport bio page, photo, and relationship proof\nPay the eVisa fee online\nReceive the eVisa confirmation electronically',
    '/assets/images/visa-heroes/antigua-and-barbuda.webp',
    'Akbar Travels secondary sourcing; official Antigua and Barbuda government domains not directly fetchable this session', 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', '2026-09-19'
);
SET @atg5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@atg5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg5, 'Core Documents', 'Required from every applicant.', 1);
SET @atg5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@atg5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @atg5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@atg5s2, 'Proof of Onward Travel', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(154, 5, 8199.00, 'INR', 'eVisa Fee (Agency-Reported Starting Price)', 'Reported starting price via Akbar Travels; this is a travel agency price, not necessarily the official government fee.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Antigua and Barbuda on the standard eVisa?', 'Yes — short family visits are explicitly noted as an appropriate use case for the standard eVisa alongside tourism and business.', 154, 5, 15405, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    154, 6, 'ATG-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Antigua and Barbuda en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard eVisa or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the eVisa portal or your airline whether the standard eVisa applies for transit',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Antigua and Barbuda eVisa Portal (online) — no in-person appearance required',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific eVisa is required\nCreate an account on the eVisa portal if needed\nUpload passport, photo, and onward ticket\nReceive the eVisa confirmation electronically if applicable',
    '/assets/images/visa-heroes/antigua-and-barbuda.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', '2026-09-19'
);
SET @atg6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@atg6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg6, 'Core Documents', 'Required from every applicant.', 1);
SET @atg6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@atg6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @atg6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(154, 6, NULL, 'INR', 'Confirm at Portal', 'Transit fee not independently confirmed this session; confirm on the official eVisa portal.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Antigua and Barbuda?', 'Not independently confirmed this session — confirm with the eVisa portal or your airline whether your specific transit routing requires the standard eVisa.', 154, 6, 15406, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    154, 7, 'ATG-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Antigua and Barbuda.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with medical documentation.',
    'Confirm duration on the eVisa approval',
    'Apply online for the eVisa — no embassy visit or passport submission needed',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Antigua and Barbuda eVisa Portal (online) — no in-person appearance required',
    'Obtain a medical appointment/admission letter from the hospital\nCreate an account on the official eVisa portal\nUpload passport, photo, and medical documents\nPay the eVisa fee online\nReceive the eVisa confirmation electronically',
    '/assets/images/visa-heroes/antigua-and-barbuda.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', '2026-09-19'
);
SET @atg7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@atg7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg7, 'Core Documents', 'Required from every applicant.', 1);
SET @atg7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@atg7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @atg7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@atg7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(154, 7, 8199.00, 'INR', 'eVisa Fee (Agency-Reported Starting Price)', 'Reported starting price via Akbar Travels; this is a travel agency price, not necessarily the official government fee.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Antigua and Barbuda?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard eVisa with supporting medical documentation.', 154, 7, 15407, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    154, 8, 'ATG-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Antigua and Barbuda.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business eVisa framework with an event invitation.',
    'Confirm duration on the eVisa approval',
    'Apply online for the eVisa — no embassy visit or passport submission needed',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Antigua and Barbuda eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation letter from the event organiser\nCreate an account on the official eVisa portal\nUpload passport, photo, and event documents\nPay the eVisa fee online\nReceive the eVisa confirmation electronically',
    '/assets/images/visa-heroes/antigua-and-barbuda.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', '2026-09-19'
);
SET @atg8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@atg8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg8, 'Core Documents', 'Required from every applicant.', 1);
SET @atg8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@atg8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @atg8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(154, 8, 8199.00, 'INR', 'eVisa Fee (Agency-Reported Starting Price)', 'Reported starting price via Akbar Travels; this is a travel agency price, not necessarily the official government fee.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Antigua and Barbuda?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business eVisa framework with an official invitation letter.', 154, 8, 15408, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    154, 9, 'ATG-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Antigua and Barbuda.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard eVisa with an event invitation.',
    'Confirm duration on the eVisa approval',
    'Apply online for the eVisa — no embassy visit or passport submission needed',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Antigua and Barbuda eVisa Portal (online) — no in-person appearance required',
    'Obtain an official invitation from the sporting federation/event organiser\nCreate an account on the official eVisa portal\nUpload passport, photo, and event documents\nPay the eVisa fee online\nReceive the eVisa confirmation electronically',
    '/assets/images/visa-heroes/antigua-and-barbuda.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', '2026-09-19'
);
SET @atg9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@atg9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg9, 'Core Documents', 'Required from every applicant.', 1);
SET @atg9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@atg9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @atg9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(154, 9, 8199.00, 'INR', 'eVisa Fee (Agency-Reported Starting Price)', 'Reported starting price via Akbar Travels; this is a travel agency price, not necessarily the official government fee.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Antigua and Barbuda?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard eVisa with a federation/event invitation.', 154, 9, 15409, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    154, 10, 'ATG-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Antigua and Barbuda work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent permit application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the relevant mission or eVisa portal for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Antigua and Barbuda eVisa Portal (online); confirm dependent-permit process with the relevant mission',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply via the relevant mission or portal\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/antigua-and-barbuda.webp',
    'Best-effort structure built from the confirmed general eVisa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', '2026-09-19'
);
SET @atg10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@atg10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg10, 'Core Documents', 'Required from every applicant.', 1);
SET @atg10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@atg10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@atg10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @atg10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@atg10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@atg10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(154, 10, NULL, 'INR', 'Confirm at Mission/Portal', 'Dependent permit fee not independently confirmed this session; confirm with the relevant mission or portal.', '2026-09-01', NOW(), 'https://www.akbartravels.com/visa/antiguaandbarbuda-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Antigua and Barbuda?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the relevant mission or eVisa portal.', 154, 10, 15410, 1);
