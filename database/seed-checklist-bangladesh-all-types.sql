-- Bangladesh Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. No hero photo has been supplied
-- yet at write time — hero_image_url is set once the batch-5 photo
-- bundle is wired in during the apply step; left NULL here as a
-- placeholder consistent with every other batch-5 file at authoring
-- time.
--
-- IMPORTANT SOURCING CAVEAT: Bangladesh's e-visa portal and the Indian
-- High Commission Dhaka's own site were not directly fetchable this
-- session (network egress blocked) — findings triangulated from
-- web-search-indexed news reporting (repeated 2024-2026 coverage of the
-- diplomatic relationship) and visa-agency secondary sourcing.
--
-- Bangladesh's real, distinctive facts:
--   - Since the August 2024 political change in Bangladesh and the
--     resulting diplomatic strain, India has repeatedly SUSPENDED and
--     partially restored visa services for Bangladeshi nationals across
--     2024-2026 — this file documents the checklist for Indians
--     traveling TO Bangladesh, which has remained comparatively stable,
--     but the note fields flag the volatile bilateral context because
--     it affects processing reliability and consular capacity on both
--     sides.
--   - During the most severe restriction periods, Business and
--     Employment-linked visa processing were the categories kept
--     flowing on a priority basis, while Tourist/Medical/Student new
--     issuance saw the sharpest slowdowns — this is reflected honestly
--     in each category's processing_note.
--   - Nearly every category carries a headline government visa fee of
--     ₹0 (fee-waiver arrangement under bilateral agreements) but a
--     separate visa-service/processing charge of roughly ₹800-850
--     collected by the outsourced visa application centre (IVAC-style
--     service partner) — modeled here as govt fee ₹0 plus a documented
--     service charge in the note, not as a single blended number.
--   - Medical-visa traffic between the two countries runs overwhelmingly
--     BANGLADESH → INDIA (Bangladeshi patients seeking treatment in
--     Indian hospitals), not the reverse — this file honestly notes
--     that Bangladesh's inbound Medical Visa product for Indians is a
--     comparatively thin, lightly-documented category rather than
--     inventing a robust medical-tourism workflow that doesn't reflect
--     real travel patterns.
--
-- country_id 59 = Bangladesh. visa_type_id: 1=Tourist, 2=Business,
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
    59, 1, 'BGD-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Bangladesh.',
    'Indian passport holders travelling for tourism; visa on a sticker/e-visa basis issued by the Bangladesh High Commission/consulates or their outsourced visa centres in India.',
    'Typically single or multiple entry up to 90 days per visit, subject to the visa granted',
    'Apply online via the Bangladesh e-visa/visa-application portal, then submit biometrics/documents at the visa application centre',
    1,
    'Standard processing has been affected by the volatile 2024-2026 bilateral diplomatic climate; expect longer-than-usual turnaround and confirm current wait times with the centre before travel',
    'Bangladesh High Commission, New Delhi, and Assistant High Commissions/visa centres in other Indian cities',
    'Complete the online visa application form\nUpload passport and photograph per the portal''s specifications\nBook an appointment at the nearest visa application centre\nSubmit biometrics and supporting documents in person\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/bangladesh.jpg',
    'Cross-checked against Bangladesh e-visa portal guidance and Indian visa-agency secondary sourcing, triangulated against 2024-2026 bilateral relations reporting not directly fetchable this session', 'https://www.bdhcdelhi.gov.bd/', '2026-09-11'
);
SET @bd1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bd1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd1, 'Core Documents', 'Required from every applicant.', 1);
SET @bd1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bd1s1, 'Passport-Size Photograph', 'Per the e-visa portal''s specification.', 'copy', 1, 0, 1, 2),
(@bd1s1, 'Completed Online Visa Application Form', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @bd1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd1s2, 'Confirmed Hotel Booking', NULL, 'copy', 1, 0, 0, 1),
(@bd1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@bd1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(59, 1, 0.00, 'INR', 'No Government Visa Fee', 'A separate visa-processing/service charge of approximately INR 800-850 is collected by the outsourced visa application centre — this is not a government visa fee.', '2026-09-01', NOW(), 'https://www.bdhcdelhi.gov.bd/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a government visa fee for Indians visiting Bangladesh?', 'The government visa fee is typically waived under bilateral arrangements, though a separate visa-processing/service charge (roughly INR 800-850) is collected by the visa application centre.', 59, 1, 5900, 1),
('Has the 2024-2026 diplomatic situation affected tourist visa processing?', 'Yes — processing times for new Tourist visas have seen periods of slowdown during the more strained phases of the bilateral relationship. Confirm current wait times with the visa centre before finalizing travel plans.', 59, 1, 5901, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    59, 2, 'BGD-BUS-IN-02', '2026.09', 'published',
    'Trade, investment, factory/office visits, and commercial meetings in Bangladesh.',
    'Indian nationals travelling for business purposes with an invitation from a registered Bangladeshi company or chamber of commerce.',
    'Typically multiple-entry, 6 months to 1 year validity, up to 90 days per visit',
    'Apply via the visa application centre with a company invitation letter',
    1,
    'Business visas were among the categories kept processing on a comparative priority basis during the more restricted 2024-2026 periods, though delays are still possible — confirm current timelines before travel',
    'Bangladesh High Commission, New Delhi, and Assistant High Commissions/visa centres in other Indian cities',
    'Obtain an invitation letter from the Bangladeshi host company or chamber of commerce\nComplete the online visa application form\nSubmit documents and biometrics at the visa application centre\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/bangladesh.jpg',
    'Cross-checked against Bangladesh e-visa portal guidance and 2024-2026 bilateral trade-visa reporting, triangulated against secondary visa-agency sourcing', 'https://www.bdhcdelhi.gov.bd/', '2026-09-11'
);
SET @bd2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bd2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd2, 'Core Documents', 'Required from every applicant.', 1);
SET @bd2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bd2s1, 'Invitation Letter from Bangladeshi Company/Chamber', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd2, 'Employer/Company Documents', 'Evidence of your own employment or business standing.', 2);
SET @bd2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd2s2, 'Forwarding Letter from Indian Employer/Company', NULL, 'original', 1, 0, 0, 1),
(@bd2s2, 'Company Registration/Incorporation Proof (If Self-Employed)', NULL, 'copy', 0, 1, 0, 2),
(@bd2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(59, 2, 0.00, 'INR', 'No Government Visa Fee', 'A separate visa-processing/service charge of approximately INR 800-850 applies, collected by the visa application centre.', '2026-09-01', NOW(), 'https://www.bdhcdelhi.gov.bd/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Were Business visas affected by the 2024-2026 visa restrictions?', 'Business and employment-linked visas were generally kept processing on a priority basis compared to other categories during the more restricted periods, though some delay is still possible.', 59, 2, 5902, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    59, 3, 'BGD-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Bangladeshi educational institution.',
    'Indian nationals admitted to a recognized Bangladeshi university or institution; a comparatively uncommon travel direction, since study flows predominantly run Bangladesh-to-India rather than the reverse.',
    'Tied to course duration, renewable',
    'Apply at the visa application centre with the institution''s admission letter and Ministry of Education permission where required',
    1,
    'A thinly-travelled category with limited public documentation found this session — confirm current requirements directly with the High Commission before applying',
    'Bangladesh High Commission, New Delhi',
    'Secure admission at a recognized Bangladeshi institution\nObtain any required Ministry of Education clearance for the institution to host a foreign student\nSubmit the visa application with admission proof and financial documents\nAttend the visa application centre for biometrics',
    '/assets/images/visa-heroes/bangladesh.jpg',
    'Limited secondary sourcing found this session for the Indian-to-Bangladesh study direction, which is far less common than the reverse — recommend direct confirmation with the High Commission', 'https://www.bdhcdelhi.gov.bd/', '2026-09-11'
);
SET @bd3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bd3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd3, 'Core Documents', 'Required from every applicant.', 1);
SET @bd3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bd3s1, 'Admission Letter from Bangladeshi Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd3, 'Supporting Documents', 'Evidence of your academic background and means.', 2);
SET @bd3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bd3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@bd3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(59, 3, NULL, 'INR', 'Confirmed After Assessment', 'Fee not clearly confirmed for this comparatively rare travel direction this session — contact us or the High Commission to confirm.', '2026-09-01', NOW(), 'https://www.bdhcdelhi.gov.bd/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How common is it for Indian students to study in Bangladesh?', 'It is a comparatively uncommon direction — most student travel between the two countries runs the other way, from Bangladesh to India. Documentation for this category is thinner as a result; confirm current requirements directly with the High Commission.', 59, 3, 5903, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    59, 4, 'BGD-WORK-IN-04', '2026.09', 'published',
    'Employment with a Bangladeshi employer, often in the garments, IT, or industrial sectors where Indian technical staff are commonly hired.',
    'Indian nationals with a confirmed job offer from a Bangladeshi employer, requiring both an Employment Visa and a separate Work Permit from the Bangladesh Investment Development Authority (BIDA) or Bangladesh Export Processing Zones Authority (BEPZA) for EPZ-based roles.',
    'Tied to the employment contract, typically 1 year, renewable',
    'Employer applies for the work permit (BIDA/BEPZA) first, then the employee applies for the Employment Visa referencing the permit',
    1,
    'This category was kept processing on a priority basis during the more restricted 2024-2026 periods, alongside Business visas',
    'Bangladesh High Commission, New Delhi, and Assistant High Commissions/visa centres in other Indian cities',
    'Employer secures a work permit via BIDA (or BEPZA for EPZ roles)\nEmployee applies for the Employment Visa referencing the approved work permit\nSubmit documents and biometrics at the visa application centre\nRegister with local authorities after arrival, per Bangladeshi immigration rules',
    '/assets/images/visa-heroes/bangladesh.jpg',
    'Cross-checked against BIDA/BEPZA work-permit guidance and 2024-2026 bilateral employment-visa reporting, triangulated against secondary visa-agency sourcing', 'https://www.bdhcdelhi.gov.bd/', '2026-09-11'
);
SET @bd4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bd4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd4, 'Core Documents', 'Required from every applicant.', 1);
SET @bd4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bd4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@bd4s1, 'Approved Work Permit (BIDA/BEPZA)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd4, 'Supporting Documents', 'Additional employer- and applicant-side evidence.', 2);
SET @bd4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bd4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@bd4s2, 'Medical Fitness Certificate', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(59, 4, NULL, 'INR', 'Confirmed After Assessment', 'Work-permit and visa fees vary by sector (general BIDA vs. BEPZA/EPZ) and were not consistently confirmed this session — contact us to confirm current figures.', '2026-09-01', NOW(), 'https://www.bdhcdelhi.gov.bd/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit as well as a visa to work in Bangladesh?', 'Yes — your employer must first secure a work permit through BIDA (or BEPZA for Export Processing Zone roles) before you apply for the Employment Visa referencing that approved permit.', 59, 4, 5904, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    59, 5, 'BGD-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives resident in Bangladesh.',
    'Indian nationals with family members residing in Bangladesh, supported by an invitation and proof of relationship.',
    'Typically up to 90 days per visit, single or multiple entry',
    'Apply via the visa application centre with a family invitation letter and relationship proof',
    1,
    'Processed similarly to Tourist visas; expect similar timelines and confirm current wait times given the volatile 2024-2026 bilateral climate',
    'Bangladesh High Commission, New Delhi, and Assistant High Commissions/visa centres in other Indian cities',
    'Obtain an invitation letter from your relative in Bangladesh\nGather documents proving the family relationship\nComplete the online visa application form\nSubmit documents and biometrics at the visa application centre',
    '/assets/images/visa-heroes/bangladesh.jpg',
    'Cross-checked against Bangladesh e-visa portal guidance and secondary visa-agency sourcing', 'https://www.bdhcdelhi.gov.bd/', '2026-09-11'
);
SET @bd5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bd5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd5, 'Core Documents', 'Required from every applicant.', 1);
SET @bd5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bd5s1, 'Invitation Letter from Relative in Bangladesh', NULL, 'original', 1, 0, 1, 2),
(@bd5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd5, 'Supporting Documents', 'Evidence of your own means and identity.', 2);
SET @bd5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@bd5s2, 'Relative''s Bangladeshi ID/Residency Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(59, 5, 0.00, 'INR', 'No Government Visa Fee', 'A separate visa-processing/service charge of approximately INR 800-850 applies, collected by the visa application centre.', '2026-09-01', NOW(), 'https://www.bdhcdelhi.gov.bd/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What proof of relationship is accepted for a Family Visit visa?', 'Birth certificates, marriage certificates, or other official documents establishing the family relationship, along with an invitation letter from your relative in Bangladesh.', 59, 5, 5905, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    59, 6, 'BGD-TRANS-IN-06', '2026.09', 'published',
    'Passing through Bangladesh en route to a third country, most relevant at Dhaka''s Hazrat Shahjalal International Airport.',
    'Indian nationals with a confirmed onward connection who need to clear immigration or stay briefly in Bangladesh between flights.',
    'Short stay, typically up to 48-72 hours',
    'Apply via the visa application centre; some transit movements may be handled airside without a separate visa — confirm with your airline',
    1,
    'A lightly-documented category this session; confirm current transit-visa requirements directly with the High Commission or your airline before travel',
    'Bangladesh High Commission, New Delhi',
    'Confirm whether your connection requires a Transit Visa or can be handled airside\nIf required, submit the visa application with onward ticket and passport\nAttend the visa application centre for biometrics',
    '/assets/images/visa-heroes/bangladesh.jpg',
    'Limited direct sourcing found this session for transit-specific rules; recommend confirming with airline and High Commission before travel', 'https://www.bdhcdelhi.gov.bd/', '2026-09-11'
);
SET @bd6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bd6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd6, 'Core Documents', 'Required from every applicant.', 1);
SET @bd6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bd6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @bd6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(59, 6, NULL, 'INR', 'Confirmed After Assessment', 'Fee not clearly confirmed this session for transit-specific processing — contact us to confirm.', '2026-09-01', NOW(), 'https://www.bdhcdelhi.gov.bd/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I always need a visa to transit through Dhaka airport?', 'Not always — some connections can be handled airside without a separate visa depending on the airline and connection time. Confirm with your airline and the Bangladesh High Commission before travel.', 59, 6, 5906, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    59, 7, 'BGD-MED-IN-07', '2026.09', 'published',
    'Travel to Bangladesh for medical treatment.',
    'A comparatively thin category — medical-tourism traffic between the two countries runs overwhelmingly the other direction (Bangladeshi patients travelling to India), so Bangladesh''s inbound Medical Visa product for Indians is lightly documented. This is stated honestly rather than building out a robust medical-tourism workflow that doesn''t reflect real travel patterns.',
    'Tied to the treatment period, extendable with hospital documentation',
    'Apply via the visa application centre with hospital appointment confirmation',
    1,
    'Limited public documentation found this session for this specific, lightly-travelled direction — confirm current requirements directly with the High Commission',
    'Bangladesh High Commission, New Delhi',
    'Obtain a hospital appointment/admission confirmation letter from the treating Bangladeshi hospital\nSubmit the visa application with medical records and the hospital letter\nAttend the visa application centre for biometrics',
    '/assets/images/visa-heroes/bangladesh.jpg',
    'Limited secondary sourcing found this session; recommend direct confirmation with the High Commission given how thin this specific travel direction is', 'https://www.bdhcdelhi.gov.bd/', '2026-09-11'
);
SET @bd7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bd7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd7, 'Core Documents', 'Required from every applicant.', 1);
SET @bd7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bd7s1, 'Hospital Appointment/Admission Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @bd7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@bd7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2),
(@bd7s2, 'Attendant Visa Documents (If Accompanying)', 'For one accompanying attendant, if applicable.', 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(59, 7, NULL, 'INR', 'Confirmed After Assessment', 'Fee not clearly confirmed this session for this lightly-travelled direction — contact us to confirm.', '2026-09-01', NOW(), 'https://www.bdhcdelhi.gov.bd/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Bangladesh a common medical-tourism destination for Indians?', 'No — medical-tourism traffic between the two countries runs predominantly from Bangladesh to India, not the reverse. Documentation for Indians travelling to Bangladesh for treatment is comparatively thin; confirm current requirements directly with the High Commission.', 59, 7, 5907, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    59, 8, 'BGD-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, or official delegations in Bangladesh.',
    'Indian nationals attending a conference or official event, supported by an invitation from the host organization.',
    'Typically up to 30 days per visit',
    'Apply via the visa application centre with the event invitation letter',
    1,
    'Processed similarly to Business visas; confirm current timelines given the volatile 2024-2026 bilateral climate',
    'Bangladesh High Commission, New Delhi, and Assistant High Commissions/visa centres in other Indian cities',
    'Obtain an invitation letter from the conference organizer/host institution\nComplete the online visa application form\nSubmit documents and biometrics at the visa application centre',
    '/assets/images/visa-heroes/bangladesh.jpg',
    'Cross-checked against Bangladesh e-visa portal guidance and secondary visa-agency sourcing', 'https://www.bdhcdelhi.gov.bd/', '2026-09-11'
);
SET @bd8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bd8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd8, 'Core Documents', 'Required from every applicant.', 1);
SET @bd8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bd8s1, 'Conference/Event Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd8, 'Supporting Documents', 'Additional employer- and applicant-side evidence.', 2);
SET @bd8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd8s2, 'Forwarding Letter from Employer (If Applicable)', NULL, 'original', 0, 1, 0, 1),
(@bd8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(59, 8, 0.00, 'INR', 'No Government Visa Fee', 'A separate visa-processing/service charge of approximately INR 800-850 applies, collected by the visa application centre.', '2026-09-01', NOW(), 'https://www.bdhcdelhi.gov.bd/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What supports a Conference visa application to Bangladesh?', 'An invitation letter from the conference organizer or host institution, along with your own supporting documents (employer forwarding letter, bank statement).', 59, 8, 5908, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    59, 9, 'BGD-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Bangladesh.',
    'Indian nationals travelling as part of a sports delegation, supported by federation/tournament accreditation.',
    'Tied to the tournament schedule',
    'Apply via the visa application centre with the sports federation''s accreditation letter',
    1,
    'A lightly-documented category this session — no dedicated public Sports Visa product page was located; likely processed as a Business/official-delegation visa sub-case',
    'Bangladesh High Commission, New Delhi',
    'Obtain accreditation from the relevant sports federation or tournament organizer\nSubmit the visa application with the accreditation letter\nAttend the visa application centre for biometrics',
    '/assets/images/visa-heroes/bangladesh.jpg',
    'Limited direct sourcing found this session for a distinct Sports Visa product; likely modeled as a Business/official-delegation sub-case — recommend direct confirmation with the High Commission', 'https://www.bdhcdelhi.gov.bd/', '2026-09-11'
);
SET @bd9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bd9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd9, 'Core Documents', 'Required from every applicant.', 1);
SET @bd9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bd9s1, 'Sports Federation/Tournament Accreditation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @bd9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(59, 9, NULL, 'INR', 'Confirmed After Assessment', 'No dedicated Sports Visa fee was confirmed this session — contact us to confirm, or check whether your travel is processed as a Business/official visa.', '2026-09-01', NOW(), 'https://www.bdhcdelhi.gov.bd/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Sports Visa for Bangladesh?', 'No dedicated public Sports Visa product page was located this session — sports delegations are likely processed under the Business/official-delegation visa route with federation accreditation as supporting evidence.', 59, 9, 5909, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    59, 10, 'BGD-DEP-IN-10', '2026.09', 'published',
    'Spouse/children accompanying an Indian Work or Student visa holder in Bangladesh.',
    'Family members of an Indian national already working or studying in Bangladesh under a valid visa.',
    'Tied to the principal visa holder''s visa validity',
    'Apply via the visa application centre alongside or after the principal applicant, with relationship proof',
    1,
    'A lightly-documented category this session — processed as a Dependent/accompanying-family sub-case of the principal''s Work or Student visa rather than a fully distinct product',
    'Bangladesh High Commission, New Delhi',
    'Confirm the principal applicant''s Work or Student visa is approved or in process\nGather documents proving the family relationship\nSubmit the dependent visa application with relationship proof and the principal''s visa/permit copy',
    '/assets/images/visa-heroes/bangladesh.jpg',
    'Limited direct sourcing found this session for a fully distinct Dependent Visa product; recommend direct confirmation with the High Commission', 'https://www.bdhcdelhi.gov.bd/', '2026-09-11'
);
SET @bd10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bd10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd10, 'Core Documents', 'Required from every applicant.', 1);
SET @bd10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bd10s1, 'Proof of Relationship to Principal Visa Holder', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bd10, 'Supporting Documents', 'Evidence tied to the principal applicant''s visa.', 2);
SET @bd10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bd10s2, 'Principal Applicant''s Visa/Work Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@bd10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(59, 10, NULL, 'INR', 'Confirmed After Assessment', 'Fee not clearly confirmed this session — contact us to confirm current figures.', '2026-09-01', NOW(), 'https://www.bdhcdelhi.gov.bd/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my family accompany me on a Work or Student visa to Bangladesh?', 'Yes, as dependants — the application is filed alongside or after your own visa, with proof of relationship and a copy of your approved visa or work permit.', 59, 10, 5910, 1);
