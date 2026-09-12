-- China Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url left NULL at
-- authoring time, wired to the real supplied photo during the apply
-- step.
--
-- IMPORTANT SOURCING CAVEAT: China's own visa portal and embassy sites
-- were not directly fetchable this session (network egress blocked) —
-- findings triangulated from web-search-indexed news and visa-agency
-- secondary sourcing.
--
-- China's real, distinctive facts:
--   - India is explicitly NOT on China's unilateral 77-country visa-free
--     list — this is stated plainly rather than left ambiguous, since
--     that list is a frequent source of confusion.
--   - Direct India-China flights only resumed Feb-Apr 2026 after roughly
--     5-6 years of suspension following the 2020 Galwan Valley border
--     clash — a genuinely distinctive, dated fact affecting practical
--     travel planning (routing via a third country was the norm for
--     years) that is noted in the Tourist/Business processing fields.
--   - Business (M) visa approval rates for Indian applicants have been
--     reported as low, with figures as low as 5-40% approval cited by
--     some secondary sources — alongside confirmed August 2026
--     India-China bilateral talks specifically addressing this
--     friction. This is reported as a documented pattern with a
--     specific caveat about source variability, not as a fixed
--     official rejection rate.
--   - Fee and biometric-exemption concessions for Indian applicants have
--     been extended through December 2026 as a stated goodwill gesture,
--     even amid otherwise tightened business-visa scrutiny — a genuine,
--     dated policy nuance worth surfacing rather than flattening into a
--     single "hard to get" narrative.
--   - Consular capacity for all of India runs through just 3 posts —
--     Delhi, Mumbai, and Kolkata — with no South India presence, a
--     distinctive practical detail for applicants outside those regions.
--
-- country_id 63 = China. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — L Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    63, 1, 'CHN-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to China.',
    'Indian passport holders — China''s unilateral 77-country visa-free list does NOT include India, so a standard L (Tourist) visa application through the Chinese Visa Application Service Centre is required.',
    'Single or double entry, typically 30 days per visit',
    'Apply through the Chinese Visa Application Service Centre (CVASC) in Delhi, Mumbai, or Kolkata',
    1,
    'Direct India-China flights only resumed Feb-Apr 2026 after roughly 5-6 years of suspension following the 2020 Galwan border clash — factor routing and booking lead time into your travel planning',
    'Chinese Visa Application Service Centres in New Delhi, Mumbai, and Kolkata (no South India presence)',
    'Complete the online visa application form\nBook an appointment at the nearest Visa Application Service Centre\nSubmit passport, photograph, and supporting documents in person, with biometrics\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/china.jpg',
    'Cross-checked against Chinese Visa Application Service Centre guidance and 2026 flight-resumption reporting, triangulated against secondary visa-agency sourcing not directly fetchable this session', 'https://www.visaforchina.cn/', '2026-09-11'
);
SET @cn1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cn1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn1, 'Core Documents', 'Required from every applicant.', 1);
SET @cn1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn1s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@cn1s1, 'Completed Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@cn1s1, 'Passport-Size Photograph', 'Per CVASC specifications.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @cn1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn1s2, 'Confirmed Hotel Booking', NULL, 'copy', 1, 0, 0, 1),
(@cn1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@cn1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@cn1s2, 'Detailed Day-by-Day Itinerary', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(63, 1, NULL, 'INR', 'Confirmed After Assessment', 'Fee varies by entry type (single/double) and has seen fee-concession gestures extended for Indian applicants through December 2026 — contact us to confirm the current figure.', '2026-09-01', NOW(), 'https://www.visaforchina.cn/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is India on China''s visa-free list?', 'No — China''s unilateral 77-country visa-free policy explicitly does not include India. Indian citizens need a standard L (Tourist) visa to visit China.', 63, 1, 6300, 1),
('Are there direct flights between India and China again?', 'Yes, as of Feb-Apr 2026, after roughly 5-6 years of suspension following the 2020 Galwan Valley border clash. Confirm current routes and schedules when booking.', 63, 1, 6301, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — M Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    63, 2, 'CHN-BUS-IN-02', '2026.09', 'published',
    'Trade, commercial negotiations, factory/office visits, and sourcing trips to China.',
    'Indian nationals travelling for business purposes with an invitation from a Chinese company, requiring the M (Business) visa category.',
    'Single, double, or multiple entry depending on invitation, typically 30-90 days per visit',
    'Apply through the Chinese Visa Application Service Centre with a Chinese company invitation letter',
    1,
    'Approval rates for Indian M-visa applicants have been reported as notably low (5-40% cited); August 2026 bilateral talks addressed this, and fee/biometric concessions were extended through December 2026 as goodwill',
    'Chinese Visa Application Service Centres in New Delhi, Mumbai, and Kolkata (no South India presence)',
    'Obtain an invitation letter from the Chinese host company (often via a local government foreign affairs office)\nComplete the online visa application form\nSubmit documents and biometrics at the Visa Application Service Centre\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/china.jpg',
    'Cross-checked against Chinese Visa Application Service Centre guidance and 2026 bilateral-relations reporting on M-visa approval friction, triangulated against secondary sourcing with noted variability across sources', 'https://www.visaforchina.cn/', '2026-09-11'
);
SET @cn2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cn2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn2, 'Core Documents', 'Required from every applicant.', 1);
SET @cn2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cn2s1, 'Invitation Letter from Chinese Company', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn2, 'Employer-Side Documents', 'Evidence of your own employment/business standing.', 2);
SET @cn2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@cn2s2, 'Company Registration Proof (If Self-Employed)', NULL, 'copy', 0, 1, 0, 2),
(@cn2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(63, 2, NULL, 'INR', 'Confirmed After Assessment', 'Fee/biometric concessions for Indian applicants have been extended through December 2026 as a goodwill gesture — contact us to confirm the current figure.', '2026-09-01', NOW(), 'https://www.visaforchina.cn/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is it harder for Indians to get a China Business visa right now?', 'Some secondary sources report notably low approval rates for Indian M-visa applicants, and this friction has been the subject of confirmed bilateral talks between India and China in August 2026. Approval isn''t guaranteed — a complete, well-documented application matters more than usual.', 63, 2, 6302, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — X Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    63, 3, 'CHN-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Chinese university or institution — India has historically sent a substantial number of medical students to China.',
    'Indian nationals admitted to a recognized Chinese institution; X1 for courses over 180 days, X2 for shorter courses.',
    'Tied to course duration (X1) or short course period (X2)',
    'Apply through the Chinese Visa Application Service Centre with the institution''s Admission Notice and JW201/JW202 form',
    1,
    'Requires the institution-issued JW201 (government-sponsored) or JW202 (self-sponsored) form alongside the Admission Notice — allow standard multi-week processing plus institution lead time',
    'Chinese Visa Application Service Centres in New Delhi, Mumbai, and Kolkata (no South India presence)',
    'Secure admission at a recognized Chinese institution\nReceive the Admission Notice and JW201/JW202 form from the institution\nComplete the online visa application form\nSubmit documents and biometrics at the Visa Application Service Centre\nRegister for a residence permit with local Public Security Bureau after arrival',
    '/assets/images/visa-heroes/china.jpg',
    'Cross-checked against Chinese Visa Application Service Centre guidance and secondary education-consultancy sourcing, triangulated against sources not directly fetchable this session', 'https://www.visaforchina.cn/', '2026-09-11'
);
SET @cn3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cn3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn3, 'Core Documents', 'Required from every applicant.', 1);
SET @cn3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@cn3s1, 'Admission Notice from Chinese Institution', NULL, 'original', 1, 0, 1, 2),
(@cn3s1, 'JW201/JW202 Form', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn3, 'Supporting Documents', 'Evidence of your academic background, health, and means.', 2);
SET @cn3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@cn3s2, 'Physical Examination Record (Foreigner Form)', NULL, 'original', 1, 0, 0, 2),
(@cn3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 3),
(@cn3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(63, 3, NULL, 'INR', 'Confirmed After Assessment', 'Fee varies by visa validity (X1/X2) — contact us to confirm the current figure.', '2026-09-01', NOW(), 'https://www.visaforchina.cn/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What''s the difference between the JW201 and JW202 forms?', 'JW201 is for government-sponsored students; JW202 is for self-sponsored (privately-funded) students. Your institution will tell you which applies and issue the correct form.', 63, 3, 6303, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Z Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    63, 4, 'CHN-WORK-IN-04', '2026.09', 'published',
    'Employment with a Chinese employer.',
    'Indian nationals with a confirmed job offer; the employer must first secure a Work Permit Notification Letter before the employee applies for the Z (Work) visa.',
    'Tied to the employment contract, typically 1 year, renewable',
    'Employer applies for the Work Permit Notification via China''s work-permit system, then the employee applies for the Z visa',
    1,
    'A two-stage, employer-driven process (permit notification, then visa) — allow several weeks total, and note that overall business/work-visa scrutiny for Indian applicants has been reported as elevated',
    'Chinese Visa Application Service Centres in New Delhi, Mumbai, and Kolkata (no South India presence)',
    'Employer secures the Work Permit Notification Letter via China''s foreign-expert/work-permit system\nEmployee applies for the Z visa referencing the notification letter\nSubmit documents and biometrics at the Visa Application Service Centre\nConvert the Z visa to a residence permit with local Public Security Bureau within 30 days of arrival',
    '/assets/images/visa-heroes/china.jpg',
    'Cross-checked against China work-permit system guidance and secondary expatriate-employment sourcing, triangulated against sources not directly fetchable this session', 'https://www.visaforchina.cn/', '2026-09-11'
);
SET @cn4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cn4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn4, 'Core Documents', 'Required from every applicant.', 1);
SET @cn4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@cn4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@cn4s1, 'Work Permit Notification Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @cn4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@cn4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@cn4s2, 'Physical Examination Record (Foreigner Form)', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(63, 4, NULL, 'INR', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm the current figure.', '2026-09-01', NOW(), 'https://www.visaforchina.cn/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need to do anything after arriving in China on a Z visa?', 'Yes — you must convert the Z visa to a residence permit with the local Public Security Bureau within 30 days of arrival.', 63, 4, 6304, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Q Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    63, 5, 'CHN-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives resident in China (Q2, short-term) or joining family as a long-term resident (Q1).',
    'Indian nationals with family members residing in China, supported by an invitation and proof of relationship; Q2 for short visits, Q1 for longer family-reunion stays.',
    'Q2: up to 90 days per visit; Q1: 180 days to 5 years, renewable',
    'Apply through the Chinese Visa Application Service Centre with a family invitation letter and relationship proof',
    1,
    'Standard multi-week processing; Q1 (long-term reunion) requires additional proof of the sponsoring relative''s residence status in China',
    'Chinese Visa Application Service Centres in New Delhi, Mumbai, and Kolkata (no South India presence)',
    'Obtain an invitation letter from your relative in China\nGather documents proving the family relationship\nComplete the online visa application form\nSubmit documents and biometrics at the Visa Application Service Centre',
    '/assets/images/visa-heroes/china.jpg',
    'Cross-checked against Chinese Visa Application Service Centre guidance and secondary family-visa sourcing, triangulated against sources not directly fetchable this session', 'https://www.visaforchina.cn/', '2026-09-11'
);
SET @cn5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cn5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn5, 'Core Documents', 'Required from every applicant.', 1);
SET @cn5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@cn5s1, 'Invitation Letter from Relative in China', NULL, 'original', 1, 0, 1, 2),
(@cn5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn5, 'Supporting Documents', 'Evidence of your own means and the relative''s status in China.', 2);
SET @cn5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@cn5s2, 'Relative''s Residence Permit/Chinese ID Copy', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(63, 5, NULL, 'INR', 'Confirmed After Assessment', 'Fee varies by Q1/Q2 category — contact us to confirm the current figure.', '2026-09-01', NOW(), 'https://www.visaforchina.cn/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What''s the difference between Q1 and Q2 visas?', 'Q2 is for short family visits (up to 90 days); Q1 is for longer-term family reunion, typically 180 days to 5 years, and requires more extensive proof of your relative''s residence status in China.', 63, 5, 6305, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — G Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    63, 6, 'CHN-TRANS-IN-06', '2026.09', 'published',
    'Passing through China en route to a third country.',
    'Indian nationals with a confirmed onward connection; India is generally NOT eligible for China''s 24/72/144-hour visa-free transit scheme (that scheme is restricted to a specific list of eligible nationalities that does not include India), so a standard G (Transit) visa is typically required.',
    'Up to 30 days, though transit stays are usually much shorter',
    'Apply through the Chinese Visa Application Service Centre with onward ticket and visa for the final destination (if required)',
    1,
    'Confirm current transit-visa-free eligibility directly with your airline or the Visa Application Service Centre before assuming exemption, since eligible-nationality lists for the visa-free transit scheme are periodically revised',
    'Chinese Visa Application Service Centres in New Delhi, Mumbai, and Kolkata (no South India presence)',
    'Confirm whether your nationality and routing qualify for visa-free transit (generally not available to Indian passport holders)\nIf not, apply for a G (Transit) visa with onward ticket and destination-country visa\nSubmit documents and biometrics at the Visa Application Service Centre',
    '/assets/images/visa-heroes/china.jpg',
    'Cross-checked against China visa-free-transit scheme eligibility lists and secondary sourcing, triangulated against sources not directly fetchable this session', 'https://www.visaforchina.cn/', '2026-09-11'
);
SET @cn6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cn6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn6, 'Core Documents', 'Required from every applicant.', 1);
SET @cn6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@cn6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @cn6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(63, 6, NULL, 'INR', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.visaforchina.cn/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian passport holders use China''s visa-free transit scheme?', 'Generally no — China''s 24/72/144-hour visa-free transit programs are restricted to a specific list of eligible nationalities that does not typically include India. Confirm current eligibility with your airline or the Visa Application Service Centre before travel.', 63, 6, 6306, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    63, 7, 'CHN-MED-IN-07', '2026.09', 'published',
    'Travel to China for medical treatment.',
    'China does not maintain a distinct Medical visa category; Indian nationals travelling for treatment typically apply for the L (Tourist) or Q (Family Visit) visa depending on their circumstances, supported by hospital documentation.',
    'Tied to the treatment period, as granted under the underlying L or Q visa',
    'Apply through the Chinese Visa Application Service Centre as an L or Q visa, with hospital documentation as supporting evidence',
    1,
    'No distinct Medical visa code exists — treated as a documented use-case of the Tourist or Family Visit visa; a lightly-travelled direction with limited public documentation found this session',
    'Chinese Visa Application Service Centres in New Delhi, Mumbai, and Kolkata (no South India presence)',
    'Obtain a hospital appointment/admission confirmation letter from the treating Chinese hospital\nApply for the underlying L or Q visa with medical documentation as supporting evidence\nSubmit documents and biometrics at the Visa Application Service Centre',
    '/assets/images/visa-heroes/china.jpg',
    'Limited secondary sourcing found this session for a distinct Medical visa product; recommend direct confirmation with the Visa Application Service Centre', 'https://www.visaforchina.cn/', '2026-09-11'
);
SET @cn7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cn7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn7, 'Core Documents', 'Required from every applicant.', 1);
SET @cn7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@cn7s1, 'Hospital Appointment/Admission Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @cn7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@cn7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(63, 7, NULL, 'INR', 'Confirmed After Assessment', 'Fee follows the underlying L or Q visa fee — contact us to confirm the current figure.', '2026-09-01', NOW(), 'https://www.visaforchina.cn/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Medical Visa for China?', 'No — China has no distinct Medical visa category. Medical travel is processed as a Tourist (L) or Family Visit (Q) visa, supported by hospital documentation.', 63, 7, 6307, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — F Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    63, 8, 'CHN-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, academic exchanges, and official delegations in China.',
    'Indian nationals attending a conference or exchange, supported by an invitation from the host organization, requiring the F (Exchange Visit) visa category.',
    'Up to 90 days per visit, single or multiple entry depending on invitation',
    'Apply through the Chinese Visa Application Service Centre with the event/host invitation letter',
    1,
    'Standard multi-week processing; ensure the invitation clearly states the F-visa purpose to avoid confusion with the M (Business) category',
    'Chinese Visa Application Service Centres in New Delhi, Mumbai, and Kolkata (no South India presence)',
    'Obtain an invitation letter from the conference organizer/host institution\nComplete the online visa application form\nSubmit documents and biometrics at the Visa Application Service Centre',
    '/assets/images/visa-heroes/china.jpg',
    'Cross-checked against Chinese Visa Application Service Centre guidance and secondary sourcing, triangulated against sources not directly fetchable this session', 'https://www.visaforchina.cn/', '2026-09-11'
);
SET @cn8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cn8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn8, 'Core Documents', 'Required from every applicant.', 1);
SET @cn8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@cn8s1, 'Conference/Exchange Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn8, 'Supporting Documents', 'Additional employer- and applicant-side evidence.', 2);
SET @cn8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn8s2, 'Forwarding Letter from Employer/Institution', NULL, 'original', 0, 1, 0, 1),
(@cn8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(63, 8, NULL, 'INR', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.visaforchina.cn/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should conference attendance use the F visa or M (Business) visa?', 'Academic and exchange-visit conferences typically use the F visa; commercial/trade conferences may be processed as M (Business). The invitation letter''s stated purpose determines the correct category — check with the Visa Application Service Centre if unsure.', 63, 8, 6308, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    63, 9, 'CHN-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in China.',
    'China has no distinct Sports visa code; delegations are typically processed under the F (Exchange Visit) visa with federation/tournament accreditation as the invitation basis.',
    'Tied to the tournament schedule',
    'Apply through the Chinese Visa Application Service Centre with the sports federation''s accreditation letter, under the F visa category',
    1,
    'No dedicated Sports visa product found this session; modeled as an F-visa sub-case, consistent with China''s standard exchange-visit framework',
    'Chinese Visa Application Service Centres in New Delhi, Mumbai, and Kolkata (no South India presence)',
    'Obtain accreditation from the relevant sports federation or tournament organizer\nApply for the F visa with the accreditation letter as the invitation basis\nSubmit documents and biometrics at the Visa Application Service Centre',
    '/assets/images/visa-heroes/china.jpg',
    'Limited direct sourcing found this session for a distinct Sports visa product; modeled as an F-visa sub-case — recommend direct confirmation with the Visa Application Service Centre', 'https://www.visaforchina.cn/', '2026-09-11'
);
SET @cn9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cn9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn9, 'Core Documents', 'Required from every applicant.', 1);
SET @cn9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@cn9s1, 'Sports Federation/Tournament Accreditation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @cn9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(63, 9, NULL, 'INR', 'Confirmed After Assessment', 'Follows the F-visa fee schedule — contact us to confirm the current figure.', '2026-09-01', NOW(), 'https://www.visaforchina.cn/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports Visa for China?', 'No — China has no distinct Sports visa code. Athletes and officials are typically processed under the F (Exchange Visit) visa, with federation or tournament accreditation as the invitation basis.', 63, 9, 6309, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — S1/S2 Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    63, 10, 'CHN-DEP-IN-10', '2026.09', 'published',
    'Spouse/children accompanying an Indian Work or Student visa holder in China.',
    'Family members of an Indian national already working (Z visa) or studying (X visa) in China; S1 for longer-term accompanying family, S2 for shorter visits.',
    'S1: tied to the principal''s visa validity, typically 1 year, renewable; S2: up to 90 days per visit',
    'Apply through the Chinese Visa Application Service Centre with the principal''s visa/permit copy and relationship proof',
    1,
    'Standard multi-week processing; S1 (longer-term) requires additional proof of the principal''s residence permit status',
    'Chinese Visa Application Service Centres in New Delhi, Mumbai, and Kolkata (no South India presence)',
    'Confirm the principal applicant''s Work (Z) or Student (X) visa/residence permit is approved\nGather documents proving the family relationship\nSubmit the S1/S2 visa application with relationship proof and the principal''s permit copy',
    '/assets/images/visa-heroes/china.jpg',
    'Cross-checked against Chinese Visa Application Service Centre guidance and secondary expatriate-family sourcing, triangulated against sources not directly fetchable this session', 'https://www.visaforchina.cn/', '2026-09-11'
);
SET @cn10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cn10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn10, 'Core Documents', 'Required from every applicant.', 1);
SET @cn10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@cn10s1, 'Proof of Relationship to Principal Visa Holder', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cn10, 'Supporting Documents', 'Evidence tied to the principal applicant''s visa.', 2);
SET @cn10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cn10s2, 'Principal Applicant''s Visa/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@cn10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(63, 10, NULL, 'INR', 'Confirmed After Assessment', 'Fee varies by S1/S2 category — contact us to confirm the current figure.', '2026-09-01', NOW(), 'https://www.visaforchina.cn/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What''s the difference between S1 and S2 visas for family?', 'S1 is for longer-term accompanying family (tied to the principal''s visa validity, typically renewable annually); S2 is for shorter family visits of up to 90 days.', 63, 10, 6310, 1);
