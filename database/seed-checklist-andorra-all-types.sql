-- Andorra Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url left NULL
-- pattern-consistent with other batches (no photo bundle supplied yet).
--
-- SOURCING CAVEAT: findings triangulated from ixigo and general
-- Schengen-visa secondary sourcing; no dedicated Andorran immigration
-- portal exists to fetch from, since Andorra issues no visa of its own.
--
-- Andorra's real, distinctive fact verified this session:
--   - Andorra has NO visa regime of its own. It is only accessible by
--     land through France or Spain, so Indian citizens must obtain a
--     double- or multiple-entry SCHENGEN VISA from the French or
--     Spanish consulate in India (not an Andorran visa/embassy — none
--     exists) to enter and exit Andorra. Every category below is
--     therefore really "apply for a Schengen visa naming Andorra as
--     part of your itinerary via France or Spain," not a
--     country-specific Andorran process.
--
-- country_id 107 = Andorra. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Schengen visa via France/Spain
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    107, 1, 'AND-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Andorra.',
    'Andorra issues no visa of its own — it is only reachable by land through France or Spain, so Indian citizens must obtain a double- or multiple-entry Schengen visa from the French or Spanish consulate, naming Andorra as part of the itinerary.',
    'Standard Schengen short-stay: up to 90 days within a 180-day period',
    'Apply for a Schengen visa via the Consulate of France or Spain in India — no Andorran mission exists',
    1,
    'Standard Schengen processing, typically 15 calendar days, longer during peak season',
    'Consulate General of France or Consulate General of Spain in India (nearest jurisdiction to your residence)',
    'Decide whether to route your Schengen application via France or Spain based on where you will spend the most days or first enter\nComplete the Schengen visa application form\nBook an appointment with the relevant consulate''s visa center\nSubmit passport, photographs, and supporting documents\nAttend the visa interview and biometrics appointment\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/andorra.webp',
    'ixigo secondary sourcing; no dedicated Andorran immigration portal exists since Andorra issues no visa of its own', 'https://www.ixigo.com/visa-for-indians/andorra-ad', '2026-09-19'
);
SET @and1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@and1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and1, 'Core Documents', 'Required from every applicant.', 1);
SET @and1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and1s1, 'Valid Passport (6+ Months Beyond Stay, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@and1s1, 'Passport-Size Photographs (35x45mm, White Background)', NULL, 'copy', 1, 0, 1, 2),
(@and1s1, 'Completed Schengen Visa Application Form', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @and1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and1s2, 'Confirmed Return/Onward Flight Bookings', NULL, 'copy', 1, 0, 0, 1),
(@and1s2, 'Hotel/Accommodation Reservations or Invitation Letter', NULL, 'copy', 1, 0, 0, 2),
(@and1s2, 'Bank Statements (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@and1s2, 'Salary Slips (Last 3 Months)', NULL, 'copy', 0, 1, 0, 4),
(@and1s2, 'Employment Letter with Approved Leave Dates', NULL, 'copy', 0, 1, 0, 5),
(@and1s2, 'Income Tax Returns (Last 2 Years)', NULL, 'copy', 1, 0, 0, 6),
(@and1s2, 'Schengen Travel Insurance (Minimum EUR 30,000 Coverage)', NULL, 'copy', 1, 0, 0, 7);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(107, 1, NULL, 'EUR', 'Standard Schengen Visa Fee', 'Andorra charges no fee of its own — the applicable fee is the standard Schengen short-stay visa fee charged by whichever consulate (France or Spain) processes the application. Confirm the current fee with the chosen consulate.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/andorra-ad', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Andorra have its own visa or embassy in India?', 'No — Andorra issues no visa of its own and has no dedicated embassy processing visas in India. Since it''s only reachable by land through France or Spain, you apply for a Schengen visa via the French or Spanish consulate instead.', 107, 1, 10700, 1),
('Should I apply via France or Spain for an Andorra trip?', 'Route your Schengen application through whichever country you will spend the most days in, or through which you first enter the Schengen Area — this determines the correct consulate.', 107, 1, 10701, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen visa via France/Spain
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    107, 2, 'AND-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity involving Andorra.',
    'Same Schengen-via-France/Spain framework as tourism, with a business invitation letter added to the supporting documents.',
    'Standard Schengen short-stay: up to 90 days within a 180-day period',
    'Apply for a Schengen visa via the Consulate of France or Spain in India — no Andorran mission exists',
    1,
    'Standard Schengen processing, typically 15 calendar days, longer during peak season',
    'Consulate General of France or Consulate General of Spain in India (nearest jurisdiction to your residence)',
    'Decide whether to route your Schengen application via France or Spain\nComplete the Schengen visa application form\nBook an appointment with the relevant consulate''s visa center\nSubmit passport, photographs, business invitation, and supporting documents\nAttend the visa interview and biometrics appointment\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/andorra.webp',
    'ixigo secondary sourcing; no dedicated Andorran immigration portal exists since Andorra issues no visa of its own', 'https://www.ixigo.com/visa-for-indians/andorra-ad', '2026-09-19'
);
SET @and2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@and2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and2, 'Core Documents', 'Required from every applicant.', 1);
SET @and2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and2s1, 'Valid Passport (6+ Months Beyond Stay, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@and2s1, 'Passport-Size Photographs (35x45mm, White Background)', NULL, 'copy', 1, 0, 1, 2),
(@and2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and2, 'Supporting Documents', 'Evidence of your business purpose and financial means.', 2);
SET @and2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@and2s2, 'Bank Statements (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 2),
(@and2s2, 'Schengen Travel Insurance (Minimum EUR 30,000 Coverage)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(107, 2, NULL, 'EUR', 'Standard Schengen Visa Fee', 'Andorra charges no fee of its own — the applicable fee is the standard Schengen short-stay visa fee charged by whichever consulate (France or Spain) processes the application.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/andorra-ad', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do business travellers to Andorra also need a Schengen visa via France/Spain?', 'Yes — the same France/Spain Schengen routing applies for business travel, with a business invitation letter added to the supporting documents.', 107, 2, 10702, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — long-stay via France/Spain
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    107, 3, 'AND-STUD-IN-01', '2026.09', 'published',
    'Academic study involving Andorra''s small higher-education sector.',
    'Not independently confirmed this session for Andorra''s own long-stay student procedure; likely requires a long-stay visa via France or Spain plus an Andorran residence authorisation given the shared-border access model.',
    'Tied to the academic program duration',
    'Apply for a long-stay visa via France or Spain, then complete Andorran residence formalities in-country',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Consulate General of France or Consulate General of Spain in India (nearest jurisdiction to your residence)',
    'Secure admission confirmation from the Andorran institution\nApply for a long-stay visa via the French or Spanish consulate\nGather proof of financial support and health insurance\nAttend the visa interview and biometrics appointment\nComplete any additional Andorran residence registration after arrival',
    '/assets/images/visa-heroes/andorra.webp',
    'Best-effort structure built from the confirmed general France/Spain routing; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/andorra-ad', '2026-09-19'
);
SET @and3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@and3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and3, 'Core Documents', 'Required from every applicant.', 1);
SET @and3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and3s1, 'Valid Passport (6+ Months Beyond Stay, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@and3s1, 'Admission Confirmation from Andorran Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and3, 'Supporting Documents', 'Evidence of financial and academic standing.', 2);
SET @and3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 1),
(@and3s2, 'Health Insurance Coverage', NULL, 'copy', 1, 0, 0, 2),
(@and3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(107, 3, NULL, 'EUR', 'Confirm at Consulate', 'Long-stay student visa fee not independently confirmed this session; confirm with the French or Spanish consulate before applying.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/andorra-ad', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How do I study in Andorra as an Indian student?', 'Since Andorra has no visa of its own, you would typically apply for a long-stay visa via France or Spain and then complete any additional Andorran residence registration after arrival — confirm the exact procedure with the relevant consulate.', 107, 3, 10703, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — long-stay via France/Spain
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    107, 4, 'AND-WORK-IN-01', '2026.09', 'published',
    'Employment with an Andorran company.',
    'Not independently confirmed this session for Andorra''s own work-authorisation procedure; likely requires a long-stay visa via France or Spain plus an Andorran work/residence authorisation obtained with employer sponsorship.',
    'Tied to the employment contract duration',
    'Apply for a long-stay visa via France or Spain, then complete Andorran work-authorisation formalities in-country',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Consulate General of France or Consulate General of Spain in India (nearest jurisdiction to your residence)',
    'Secure a signed employment contract from the Andorran employer\nApply for a long-stay visa via the French or Spanish consulate\nGather proof of qualifications and employer documents\nAttend the visa interview and biometrics appointment\nComplete Andorran work/residence authorisation after arrival',
    '/assets/images/visa-heroes/andorra.webp',
    'Best-effort structure built from the confirmed general France/Spain routing; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/andorra-ad', '2026-09-19'
);
SET @and4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@and4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and4, 'Core Documents', 'Required from every applicant.', 1);
SET @and4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and4s1, 'Valid Passport (6+ Months Beyond Stay, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@and4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @and4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@and4s2, 'Employer''s Registration Proof (Andorra)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(107, 4, NULL, 'EUR', 'Confirm at Consulate', 'Long-stay work visa fee not independently confirmed this session; confirm with the French or Spanish consulate before applying.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/andorra-ad', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How do I get a work visa for Andorra as an Indian citizen?', 'Since Andorra has no visa of its own, the route typically starts with a long-stay visa via France or Spain, followed by Andorran work/residence authorisation with employer sponsorship — confirm the exact procedure with the relevant consulate.', 107, 4, 10704, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen visa via France/Spain
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    107, 5, 'AND-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Andorra.',
    'Same Schengen-via-France/Spain framework as tourism, with an invitation letter and relationship proof added.',
    'Standard Schengen short-stay: up to 90 days within a 180-day period',
    'Apply for a Schengen visa via the Consulate of France or Spain in India — no Andorran mission exists',
    1,
    'Standard Schengen processing, typically 15 calendar days, longer during peak season',
    'Consulate General of France or Consulate General of Spain in India (nearest jurisdiction to your residence)',
    'Obtain an invitation letter from the family member resident in Andorra\nComplete the Schengen visa application form\nBook an appointment with the relevant consulate''s visa center\nSubmit passport, photographs, and relationship proof\nAttend the visa interview and biometrics appointment\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/andorra.webp',
    'ixigo secondary sourcing; no dedicated Andorran immigration portal exists since Andorra issues no visa of its own', 'https://www.ixigo.com/visa-for-indians/andorra-ad', '2026-09-19'
);
SET @and5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@and5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and5, 'Core Documents', 'Required from every applicant.', 1);
SET @and5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and5s1, 'Valid Passport (6+ Months Beyond Stay, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@and5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @and5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@and5s2, 'Host''s Residence Proof in Andorra', NULL, 'copy', 1, 0, 0, 2),
(@and5s2, 'Schengen Travel Insurance (Minimum EUR 30,000 Coverage)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(107, 5, NULL, 'EUR', 'Standard Schengen Visa Fee', 'Andorra charges no fee of its own — the applicable fee is the standard Schengen short-stay visa fee charged by whichever consulate (France or Spain) processes the application.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/andorra-ad', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Andorra on a Schengen visa via France or Spain?', 'Yes — visiting family in Andorra follows the same France/Spain Schengen routing as tourism, with an invitation letter and relationship proof added.', 107, 5, 10705, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    107, 6, 'AND-TRAN-IN-01', '2026.09', 'published',
    'Transiting through France or Spain en route to Andorra.',
    'Since Andorra has no airport or seaport of its own, all entry is by land through France or Spain — the same Schengen visa used for the main visit also covers this transit.',
    'Short duration tied to the transit itinerary',
    'Apply for a Schengen visa via France or Spain covering the full itinerary including the Andorra leg',
    1,
    'Standard Schengen processing, typically 15 calendar days, longer during peak season',
    'Consulate General of France or Consulate General of Spain in India (nearest jurisdiction to your residence)',
    'Confirm your full itinerary including land transit through France/Spain to Andorra\nComplete the Schengen visa application form\nBook an appointment with the relevant consulate''s visa center\nSubmit passport, photographs, and onward travel proof\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/andorra.webp',
    'Best-effort structure built from the confirmed general France/Spain routing; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/andorra-ad', '2026-09-19'
);
SET @and6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@and6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and6, 'Core Documents', 'Required from every applicant.', 1);
SET @and6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and6s1, 'Valid Passport (6+ Months Beyond Stay, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@and6s1, 'Onward/Connecting Travel Proof', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @and6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and6s2, 'Passport-Size Photographs', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(107, 6, NULL, 'EUR', 'Standard Schengen Visa Fee', 'Andorra charges no fee of its own — the applicable fee is the standard Schengen short-stay visa fee charged by whichever consulate (France or Spain) processes the application.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/andorra-ad', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Andorra have its own airport requiring a separate transit visa?', 'No — Andorra has no airport or seaport; all access is by land through France or Spain, so the same Schengen visa covering your main visit also covers this transit.', 107, 6, 10706, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    107, 7, 'AND-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Andorra.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the same Schengen-via-France/Spain framework with medical documentation.',
    'Up to 90 days under the standard Schengen short-stay framework',
    'Apply for a Schengen visa via the Consulate of France or Spain in India — no Andorran mission exists',
    1,
    'Standard Schengen processing, typically 15 calendar days, longer during peak season',
    'Consulate General of France or Consulate General of Spain in India (nearest jurisdiction to your residence)',
    'Obtain a medical appointment/admission letter from the Andorran hospital\nComplete the Schengen visa application form\nBook an appointment with the relevant consulate''s visa center\nSubmit passport, photographs, and medical documents\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/andorra.webp',
    'Best-effort structure built from the confirmed general France/Spain routing; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/andorra-ad', '2026-09-19'
);
SET @and7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@and7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and7, 'Core Documents', 'Required from every applicant.', 1);
SET @and7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and7s1, 'Valid Passport (6+ Months Beyond Stay, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@and7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @and7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@and7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(107, 7, NULL, 'EUR', 'Standard Schengen Visa Fee', 'Andorra charges no fee of its own — the applicable fee is the standard Schengen short-stay visa fee charged by whichever consulate (France or Spain) processes the application.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/andorra-ad', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Andorra?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the same Schengen-via-France/Spain framework with supporting medical documentation.', 107, 7, 10707, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    107, 8, 'AND-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Andorra.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business (Schengen) framework with an event invitation.',
    'Up to 90 days under the standard Schengen short-stay framework',
    'Apply for a Schengen visa via the Consulate of France or Spain in India — no Andorran mission exists',
    1,
    'Standard Schengen processing, typically 15 calendar days, longer during peak season',
    'Consulate General of France or Consulate General of Spain in India (nearest jurisdiction to your residence)',
    'Obtain an official invitation letter from the event organiser\nComplete the Schengen visa application form\nBook an appointment with the relevant consulate''s visa center\nSubmit passport, photographs, and event documents\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/andorra.webp',
    'Best-effort structure built from the confirmed general France/Spain routing; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/andorra-ad', '2026-09-19'
);
SET @and8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@and8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and8, 'Core Documents', 'Required from every applicant.', 1);
SET @and8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and8s1, 'Valid Passport (6+ Months Beyond Stay, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@and8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @and8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(107, 8, NULL, 'EUR', 'Standard Schengen Visa Fee', 'Andorra charges no fee of its own — the applicable fee is the standard Schengen short-stay visa fee charged by whichever consulate (France or Spain) processes the application.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/andorra-ad', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Andorra?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business (Schengen) framework with an official invitation letter.', 107, 8, 10708, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    107, 9, 'AND-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events in Andorra (notably winter sports/skiing tournaments).',
    'Not independently confirmed this session as a distinct standard category — likely processed under the same Schengen-via-France/Spain framework with an event invitation.',
    'Up to 90 days under the standard Schengen short-stay framework',
    'Apply for a Schengen visa via the Consulate of France or Spain in India — no Andorran mission exists',
    1,
    'Standard Schengen processing, typically 15 calendar days, longer during peak season',
    'Consulate General of France or Consulate General of Spain in India (nearest jurisdiction to your residence)',
    'Obtain an official invitation from the sporting federation/event organiser\nComplete the Schengen visa application form\nBook an appointment with the relevant consulate''s visa center\nSubmit passport, photographs, and event documents\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/andorra.webp',
    'Best-effort structure built from the confirmed general France/Spain routing; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/andorra-ad', '2026-09-19'
);
SET @and9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@and9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and9, 'Core Documents', 'Required from every applicant.', 1);
SET @and9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and9s1, 'Valid Passport (6+ Months Beyond Stay, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@and9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @and9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(107, 9, NULL, 'EUR', 'Standard Schengen Visa Fee', 'Andorra charges no fee of its own — the applicable fee is the standard Schengen short-stay visa fee charged by whichever consulate (France or Spain) processes the application.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/andorra-ad', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Andorra?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel (including Andorra''s winter sports events) is likely processed under the same Schengen-via-France/Spain framework with a federation/event invitation.', 107, 9, 10709, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — long-stay via France/Spain
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    107, 10, 'AND-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Andorran work/residence authorisation.',
    'Family members of an Indian national holding a qualifying Andorran work/residence authorisation, routed via a long-stay visa through France or Spain.',
    'Tied to the sponsor''s authorisation validity',
    'Apply for a long-stay visa via France or Spain, then complete Andorran residence formalities in-country',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Consulate General of France or Consulate General of Spain in India (nearest jurisdiction to your residence)',
    'Confirm the sponsor holds a qualifying Andorran work/residence authorisation\nGather relationship proof and the sponsor''s authorisation copy\nApply for a long-stay visa via the French or Spanish consulate\nAttend the visa interview and biometrics appointment\nComplete Andorran residence registration after arrival',
    '/assets/images/visa-heroes/andorra.webp',
    'Best-effort structure built from the confirmed general France/Spain routing; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/andorra-ad', '2026-09-19'
);
SET @and10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@and10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and10, 'Core Documents', 'Required from every applicant.', 1);
SET @and10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and10s1, 'Valid Passport (6+ Months Beyond Stay, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@and10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@and10, 'Supporting Documents', 'Evidence tied to the sponsor''s authorisation.', 2);
SET @and10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@and10s2, 'Sponsor''s Work/Residence Authorisation Copy', NULL, 'copy', 1, 0, 0, 1),
(@and10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(107, 10, NULL, 'EUR', 'Confirm at Consulate', 'Dependent/long-stay visa fee not independently confirmed this session; confirm with the French or Spanish consulate before applying.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/andorra-ad', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse join me in Andorra on a dependent visa?', 'Yes, in principle — the accompanying family member applies via a long-stay visa through France or Spain, with proof of relationship and the sponsor''s valid Andorran work/residence authorisation. Confirm the exact procedure with the relevant consulate.', 107, 10, 10710, 1);
