-- Albania Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url left NULL
-- pattern-consistent with other batches (no photo bundle supplied yet).
--
-- SOURCING CAVEAT: e-visa.al and Albanian government domains were not
-- directly fetchable this session (egress-proxy blocked); findings
-- triangulated from BTW Visas, Rivermate, Citizen Remote, VisaFalcon,
-- Himara.net and albania-evisa.org secondary sourcing.
--
-- Albania's real, distinctive facts verified this session:
--   - Indian passport holders who ALREADY hold a valid multiple-entry
--     Schengen, US, or UK visa can enter Albania visa-free — a
--     genuinely distinctive and highly relevant shortcut for Indian
--     travellers who often already hold one of these.
--   - For everyone else, Albania runs its own Type C e-visa (short
--     stay, up to 90 days) entirely online via e-visa.al — no embassy
--     visit needed. Flat fee reported at EUR 60, ~15 working days
--     processing.
--   - Long-stay purposes (work, study, family reunification beyond 90
--     days) require a Type D visa (valid up to 1 year), followed by a
--     residence permit application at the Regional Directorate of
--     Border and Migration within 90 days of arrival.
--
-- country_id 106 = Albania. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Type C e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    106, 1, 'ALB-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Albania.',
    'Indian passport holders who already hold a valid multiple-entry Schengen, US, or UK visa can enter Albania visa-free. Everyone else applies for Albania''s own Type C e-Visa entirely online.',
    'Up to 90 days, single/double/multiple entry depending on the e-Visa granted',
    'Apply online at e-visa.al (no embassy visit needed) — or travel visa-free if holding a valid Schengen/US/UK multiple-entry visa',
    0,
    'Reported approximately 15 working days for the Type C e-Visa',
    'Albania e-Visa Portal (e-visa.al) — no in-person appearance required for the e-Visa itself',
    'Check whether you already hold a valid multiple-entry Schengen/US/UK visa (visa-free entry)\nIf not, create an account on e-visa.al\nUpload passport bio page, photo, and travel itinerary\nPay the EUR 60 e-Visa fee online\nPrint the e-Visa approval and carry it alongside your passport on arrival',
    '/assets/images/visa-heroes/albania.webp',
    'Triangulated from BTW Visas and albania-evisa.org secondary sourcing; official e-visa.al domain not directly fetchable this session', 'https://btwvisas.com/visa-guide/albania-tourist-visa/', '2026-09-19'
);
SET @alb1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@alb1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb1, 'Core Documents', 'Required from every applicant.', 1);
SET @alb1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb1s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@alb1s1, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@alb1s1, 'Completed Online Type C e-Visa Application', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @alb1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb1s2, 'Confirmed Accommodation Booking', NULL, 'copy', 1, 0, 0, 1),
(@alb1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@alb1s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@alb1s2, 'Valid Multiple-Entry Schengen/US/UK Visa (If Using Visa-Free Route)', 'Presenting this instead qualifies you for visa-free entry, skipping the e-Visa entirely.', 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(106, 1, 60.00, 'EUR', 'Type C e-Visa Fee', 'Flat fee for the online Type C e-Visa covering up to 90 days; not applicable if travelling visa-free on a valid Schengen/US/UK visa.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/albania-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I enter Albania visa-free as an Indian citizen?', 'Yes, if you already hold a valid multiple-entry Schengen, US, or UK visa, you can enter Albania visa-free. Otherwise, you''ll need Albania''s own Type C e-Visa, applied for entirely online.', 106, 1, 10600, 1),
('How long does the Albania e-Visa take?', 'The Type C e-Visa is reported to take approximately 15 working days, applied for entirely online at e-visa.al with no embassy visit needed.', 106, 1, 10601, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Type C e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    106, 2, 'ALB-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Albania.',
    'Indian business travellers use the same Type C e-Visa framework as tourists (or travel visa-free with a valid Schengen/US/UK visa), typically adding a business invitation letter.',
    'Up to 90 days, single/double/multiple entry depending on the e-Visa granted',
    'Apply online at e-visa.al — or travel visa-free if holding a valid Schengen/US/UK multiple-entry visa',
    0,
    'Reported approximately 15 working days for the Type C e-Visa',
    'Albania e-Visa Portal (e-visa.al) — no in-person appearance required for the e-Visa itself',
    'Check whether you already hold a valid multiple-entry Schengen/US/UK visa (visa-free entry)\nIf not, create an account on e-visa.al\nUpload passport bio page, photo, and business invitation letter\nPay the EUR 60 e-Visa fee online\nPrint the e-Visa approval and carry it alongside your passport on arrival',
    '/assets/images/visa-heroes/albania.webp',
    'Triangulated from BTW Visas secondary sourcing; official e-visa.al domain not directly fetchable this session', 'https://btwvisas.com/visa-guide/albania-visa', '2026-09-19'
);
SET @alb2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@alb2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb2, 'Core Documents', 'Required from every applicant.', 1);
SET @alb2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb2s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@alb2s1, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@alb2s1, 'Business Invitation Letter from Albanian Host', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb2, 'Supporting Documents', 'Evidence of your business purpose and company standing.', 2);
SET @alb2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@alb2s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(106, 2, 60.00, 'EUR', 'Type C e-Visa Fee', 'Flat fee for the online Type C e-Visa covering up to 90 days; not applicable if travelling visa-free on a valid Schengen/US/UK visa.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/albania-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do business travellers use the same e-Visa as tourists?', 'Yes — business travel to Albania typically uses the same Type C e-Visa framework, with a business invitation letter added to the supporting documents.', 106, 2, 10602, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Type D
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    106, 3, 'ALB-STUD-IN-01', '2026.09', 'published',
    'Academic study in Albania for programs longer than 90 days.',
    'Indian students enrolling in a recognised Albanian institution for more than 90 days require a Type D long-stay visa, followed by a residence permit within 90 days of arrival.',
    'Type D visa valid up to 1 year; convert to a residence permit within 90 days of arrival',
    'Apply for the Type D visa at the Albanian Embassy/Consulate serving India before travel',
    1,
    'Type D visa: not independently confirmed this session for a specific working-day figure. Residence permit: reported up to 12 weeks, with results often available in 15-30 days',
    'Embassy of Albania serving India (nearest mission — confirm current jurisdiction)',
    'Secure a letter of acceptance from a recognised Albanian educational institution\nGather proof of financial support and health insurance\nApply for the Type D long-stay visa at the Embassy/Consulate\nTravel to Albania and apply for a residence permit within 90 days of arrival\nCollect the residence permit at the Regional Directorate of Border and Migration',
    '/assets/images/visa-heroes/albania.webp',
    'Triangulated from albania-evisa.org and Himara.net secondary sourcing; official Albanian government domains not directly fetchable this session', 'https://albania-evisa.org/albania-long-stay-visa-type-d/', '2026-09-19'
);
SET @alb3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@alb3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb3, 'Core Documents', 'Required from every applicant.', 1);
SET @alb3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb3s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@alb3s1, 'Letter of Acceptance from Albanian Institution', NULL, 'copy', 1, 0, 1, 2),
(@alb3s1, 'Completed Type D Visa Application Form', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb3, 'Supporting Documents', 'Evidence of financial, medical, and academic standing.', 2);
SET @alb3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 1),
(@alb3s2, 'Health Insurance Coverage', NULL, 'copy', 1, 0, 0, 2),
(@alb3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(106, 3, NULL, 'EUR', 'Confirm at Embassy/Consulate', 'Type D visa and residence permit fees were not independently confirmed this session; confirm the current fee schedule with the Albanian Embassy/Consulate before applying.', '2026-09-01', NOW(), 'https://himara.net/blog/albania-residence-permit-2026', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a residence permit after arriving in Albania on a student visa?', 'Yes — after entering on the Type D long-stay visa, you must apply for a residence permit at the Regional Directorate of Border and Migration within 90 days of arrival.', 106, 3, 10603, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Type D
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    106, 4, 'ALB-WORK-IN-01', '2026.09', 'published',
    'Employment with an Albanian company for longer than 90 days.',
    'Indian professionals with an Albanian job offer require a Type D long-stay work visa, followed by a Unique (work + residence) Permit application after arrival.',
    'Type D visa valid up to 1 year; convert to a Unique Permit within 90 days of arrival',
    'Apply for the Type D visa at the Albanian Embassy/Consulate serving India before travel',
    1,
    'Type D visa: not independently confirmed this session for a specific working-day figure. Unique Permit: reported up to 12 weeks, with results often available in 15-30 days',
    'Embassy of Albania serving India (nearest mission — confirm current jurisdiction)',
    'Secure a signed employment contract/job offer from the Albanian employer\nGather proof of qualifications and the employer''s supporting documents\nApply for the Type D long-stay visa at the Embassy/Consulate\nTravel to Albania and apply for the Unique Permit within 90 days of arrival\nCollect the Unique Permit at the Regional Directorate of Border and Migration',
    '/assets/images/visa-heroes/albania.webp',
    'Triangulated from Rivermate and RemotePeople secondary sourcing; official Albanian government domains not directly fetchable this session', 'https://rivermate.com/guides/albania/work-permits-and-visas', '2026-09-19'
);
SET @alb4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@alb4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb4, 'Core Documents', 'Required from every applicant.', 1);
SET @alb4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb4s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@alb4s1, 'Signed Employment Contract/Job Offer', NULL, 'copy', 1, 0, 1, 2),
(@alb4s1, 'Completed Type D Visa Application Form', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @alb4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@alb4s2, 'Employer''s Registration Proof (Albania)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(106, 4, NULL, 'EUR', 'Confirm at Embassy/Consulate', 'Type D visa and Unique Permit fees were not independently confirmed this session; confirm the current fee schedule with the Albanian Embassy/Consulate before applying.', '2026-09-01', NOW(), 'https://rivermate.com/guides/albania/work-permits-and-visas', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What happens after I arrive in Albania on a work visa?', 'You must apply for a Unique Permit (combined work and residence permit) at the Regional Directorate of Border and Migration within 90 days of arrival to legally continue working.', 106, 4, 10604, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Type C e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    106, 5, 'ALB-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Albania for up to 90 days.',
    'Indian nationals visiting relatives in Albania for a short stay use the Type C e-Visa (or travel visa-free with a valid Schengen/US/UK visa), adding an invitation letter and relationship proof.',
    'Up to 90 days, single/double/multiple entry depending on the e-Visa granted',
    'Apply online at e-visa.al — or travel visa-free if holding a valid Schengen/US/UK multiple-entry visa',
    0,
    'Reported approximately 15 working days for the Type C e-Visa',
    'Albania e-Visa Portal (e-visa.al) — no in-person appearance required for the e-Visa itself',
    'Obtain an invitation letter from the family member resident in Albania\nCreate an account on e-visa.al\nUpload passport bio page, photo, and relationship proof\nPay the EUR 60 e-Visa fee online\nPrint the e-Visa approval and carry it alongside your passport on arrival',
    '/assets/images/visa-heroes/albania.webp',
    'Triangulated from BTW Visas secondary sourcing; official e-visa.al domain not directly fetchable this session', 'https://btwvisas.com/visa-guide/albania-visa', '2026-09-19'
);
SET @alb5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@alb5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb5, 'Core Documents', 'Required from every applicant.', 1);
SET @alb5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb5s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@alb5s1, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@alb5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @alb5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@alb5s2, 'Host''s Residence Proof in Albania', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(106, 5, 60.00, 'EUR', 'Type C e-Visa Fee', 'Flat fee for the online Type C e-Visa covering up to 90 days; not applicable if travelling visa-free on a valid Schengen/US/UK visa.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/albania-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Albania on the same e-Visa as tourists?', 'Yes — visiting family for up to 90 days uses the same Type C e-Visa framework as tourism, with an invitation letter and relationship proof added.', 106, 5, 10605, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    106, 6, 'ALB-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Albania en route to a third country.',
    'Indian nationals transiting via Albania generally use the same Type C e-Visa or visa-free route (valid Schengen/US/UK visa), with confirmed onward travel.',
    'Short duration tied to the transit itinerary',
    'Apply online at e-visa.al — or travel visa-free if holding a valid Schengen/US/UK multiple-entry visa',
    0,
    'Reported approximately 15 working days for the Type C e-Visa',
    'Albania e-Visa Portal (e-visa.al) — no in-person appearance required for the e-Visa itself',
    'Confirm onward travel itinerary and connecting flight/transport\nCreate an account on e-visa.al if not travelling visa-free\nUpload passport bio page, photo, and onward ticket\nPay the EUR 60 e-Visa fee online (if applicable)\nPrint the e-Visa approval and carry it alongside your passport',
    '/assets/images/visa-heroes/albania.webp',
    'Best-effort structure built from the confirmed general Albanian e-Visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/albania-visa', '2026-09-19'
);
SET @alb6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@alb6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb6, 'Core Documents', 'Required from every applicant.', 1);
SET @alb6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb6s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@alb6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2),
(@alb6s1, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @alb6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb6s2, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(106, 6, 60.00, 'EUR', 'Type C e-Visa Fee', 'Flat fee for the online Type C e-Visa; not applicable if travelling visa-free on a valid Schengen/US/UK visa.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/albania-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Albania?', 'Generally the same Type C e-Visa (or visa-free route on a valid Schengen/US/UK visa) applies to transit as to tourism — confirm your specific routing requirements before travel.', 106, 6, 10606, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Type C e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    106, 7, 'ALB-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Albania for up to 90 days.',
    'Not independently confirmed this session as a distinct standard visa category — likely processed under the Type C e-Visa framework with medical documentation for stays up to 90 days.',
    'Up to 90 days under the Type C e-Visa framework',
    'Apply online at e-visa.al — or travel visa-free if holding a valid Schengen/US/UK multiple-entry visa',
    0,
    'Reported approximately 15 working days for the Type C e-Visa',
    'Albania e-Visa Portal (e-visa.al) — no in-person appearance required for the e-Visa itself',
    'Obtain a medical appointment/admission letter from the Albanian hospital\nCreate an account on e-visa.al\nUpload passport bio page, photo, and medical documents\nPay the EUR 60 e-Visa fee online\nPrint the e-Visa approval and carry it alongside your passport on arrival',
    '/assets/images/visa-heroes/albania.webp',
    'Best-effort structure built from the confirmed general Albanian e-Visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/albania-visa', '2026-09-19'
);
SET @alb7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@alb7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb7, 'Core Documents', 'Required from every applicant.', 1);
SET @alb7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb7s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@alb7s1, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@alb7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @alb7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@alb7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(106, 7, 60.00, 'EUR', 'Type C e-Visa Fee', 'Flat fee for the online Type C e-Visa covering up to 90 days; not applicable if travelling visa-free on a valid Schengen/US/UK visa.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/albania-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Albania?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel for up to 90 days is likely processed under the Type C e-Visa framework with supporting medical documentation.', 106, 7, 10607, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Type C e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    106, 8, 'ALB-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Albania.',
    'Not independently confirmed this session as a distinct standard visa category — likely processed under the Type C e-Visa (business) framework with an event invitation.',
    'Up to 90 days under the Type C e-Visa framework',
    'Apply online at e-visa.al — or travel visa-free if holding a valid Schengen/US/UK multiple-entry visa',
    0,
    'Reported approximately 15 working days for the Type C e-Visa',
    'Albania e-Visa Portal (e-visa.al) — no in-person appearance required for the e-Visa itself',
    'Obtain an official invitation letter from the event organiser\nCreate an account on e-visa.al\nUpload passport bio page, photo, and event documents\nPay the EUR 60 e-Visa fee online\nPrint the e-Visa approval and carry it alongside your passport on arrival',
    '/assets/images/visa-heroes/albania.webp',
    'Best-effort structure built from the confirmed general Albanian e-Visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/albania-visa', '2026-09-19'
);
SET @alb8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@alb8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb8, 'Core Documents', 'Required from every applicant.', 1);
SET @alb8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb8s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@alb8s1, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@alb8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @alb8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(106, 8, 60.00, 'EUR', 'Type C e-Visa Fee', 'Flat fee for the online Type C e-Visa covering up to 90 days; not applicable if travelling visa-free on a valid Schengen/US/UK visa.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/albania-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Albania?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Type C e-Visa (business) framework with an official invitation letter.', 106, 8, 10608, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Type C e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    106, 9, 'ALB-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Albania.',
    'Not independently confirmed this session as a distinct standard visa category — likely processed under the Type C e-Visa framework with an event invitation.',
    'Up to 90 days under the Type C e-Visa framework',
    'Apply online at e-visa.al — or travel visa-free if holding a valid Schengen/US/UK multiple-entry visa',
    0,
    'Reported approximately 15 working days for the Type C e-Visa',
    'Albania e-Visa Portal (e-visa.al) — no in-person appearance required for the e-Visa itself',
    'Obtain an official invitation from the sporting federation/event organiser\nCreate an account on e-visa.al\nUpload passport bio page, photo, and event documents\nPay the EUR 60 e-Visa fee online\nPrint the e-Visa approval and carry it alongside your passport on arrival',
    '/assets/images/visa-heroes/albania.webp',
    'Best-effort structure built from the confirmed general Albanian e-Visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/albania-visa', '2026-09-19'
);
SET @alb9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@alb9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb9, 'Core Documents', 'Required from every applicant.', 1);
SET @alb9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb9s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@alb9s1, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@alb9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @alb9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(106, 9, 60.00, 'EUR', 'Type C e-Visa Fee', 'Flat fee for the online Type C e-Visa covering up to 90 days; not applicable if travelling visa-free on a valid Schengen/US/UK visa.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/albania-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Albania?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the Type C e-Visa framework with a federation/event invitation.', 106, 9, 10609, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Type D
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    106, 10, 'ALB-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Albanian Type D visa/residence permit.',
    'Family members of an Indian national holding a qualifying Type D visa/Unique Permit can apply for family reunification under the same long-stay framework.',
    'Tied to the sponsor''s permit validity',
    'Apply for the Type D visa at the Albanian Embassy/Consulate serving India before travel',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Albania serving India (nearest mission — confirm current jurisdiction)',
    'Confirm the sponsor holds a qualifying Type D visa/Unique Permit\nGather relationship proof (marriage/birth certificates) and the sponsor''s permit copy\nApply for the Type D visa at the Embassy/Consulate\nTravel to Albania and apply for a residence permit within 90 days of arrival\nCollect the residence permit at the Regional Directorate of Border and Migration',
    '/assets/images/visa-heroes/albania.webp',
    'Best-effort structure built from the confirmed general Albanian long-stay/residence framework; category-specific detail not independently confirmed this session', 'https://himara.net/blog/albania-residence-permit-2026', '2026-09-19'
);
SET @alb10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@alb10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb10, 'Core Documents', 'Required from every applicant.', 1);
SET @alb10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb10s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@alb10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@alb10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @alb10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@alb10s2, 'Sponsor''s Type D Visa/Unique Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@alb10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(106, 10, NULL, 'EUR', 'Confirm at Embassy/Consulate', 'Dependent/family reunification visa fees were not independently confirmed this session; confirm the current fee schedule with the Albanian Embassy/Consulate before applying.', '2026-09-01', NOW(), 'https://himara.net/blog/albania-residence-permit-2026', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse join me in Albania on a dependent visa?', 'Yes, in principle, under family reunification — the accompanying family member applies with proof of relationship and the sponsor''s valid Type D visa/Unique Permit. Confirm the exact procedure directly with the Embassy.', 106, 10, 10610, 1);
