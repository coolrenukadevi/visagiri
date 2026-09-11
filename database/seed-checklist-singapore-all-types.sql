-- Singapore Visa Checklist Engine content for all 10 visa types —
-- migrates the country's EXISTING real, officially-sourced content
-- (visa_requirements rows, built in an earlier session from ICA/MFA
-- government pages, not third-party agent sites) into the new
-- structured checklist engine (visa_checklists/sections/documents),
-- the same "Mexico pattern" used elsewhere in this file. Nine of the
-- ten types below are a restructuring of that existing real content,
-- not fresh fabrication; only Sports Visa had no prior row and was
-- freshly researched this session, following the same rule as
-- Mexico's Medical/Sports entries: state honestly that no distinct
-- category exists rather than inventing one.
--
-- Real, distinctive facts carried over from the source rows (see
-- source_url on each row below, all ica.gov.sg or mfa.gov.sg):
--   - Singapore's short-visit categories are a fully online e-visa
--     via ICA's SAVE system, submitted through an ICA-authorised visa
--     agent — NO personal appearance, biometrics, or interview for
--     Tourist/Business/Family/Transit/Medical/Conference/Sports.
--   - Student's Pass applications are filed by the institution via
--     ICA's SOLAR system, not independently by the student.
--   - "Work Visa" in Singapore means the Employment Pass (MOM, not
--     ICA) — a materially different authority/process from a visit
--     visa, sponsored by the employer via MOM's EP Online system.
--   - "Dependent Visa" means the Dependant's Pass (MOM), sponsored by
--     a qualifying Employment/S Pass holder for spouse/children under
--     21 — separate from ICA's short-stay Family Visit Visa.
--   - Transit: a same-terminal Changi connection commonly needs no
--     visa at all; travellers who want to leave the airport may
--     qualify for the Visa Free Transit Facility (VFTF, up to ~96
--     hours) instead of a full visa.
--   - No fixed government visa fee is published/disclosed — ICA fees
--     can change without notice and Visagiri confirms a written quote
--     before billing, so visa_fees.amount is deliberately NULL here
--     (a genuine "ask us" answer, not a missing number) rather than a
--     fabricated figure.
--
-- country_id 92 = Singapore. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical,
-- 8=Conference, 9=Sports, 10=Dependent.
--
-- hero_image_url points at the real Marina Bay Sands/Merlion/Singapore
-- flag photo supplied by the client for this hero, converted to JPEG
-- the same way as Mexico's (see AUDIT.md).

-- =====================================================================
-- TOURIST VISA (visa_type_id 1)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    92, 1, 'SGP-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and short personal visits to Singapore.',
    'Indian passport holders sit on ICA''s Assessment Level I list — a visa is required for every visit. Applied for online via ICA''s SAVE system through an authorised agent; no personal appearance, biometrics, or interview.',
    'Commonly up to 30 days per entry (at ICA''s discretion)',
    'Online via ICA''s SAVE system, through an ICA-authorised visa agent',
    0,
    '3-5 working days (indicative — ICA does not guarantee a fixed timeline)',
    'Immigration & Checkpoints Authority (ICA), Singapore',
    'Initial consultation to confirm Tourist Visa is the right category\nDocument assessment against ICA''s current checklist\nApplication preparation and formatting\nDocument verification\nSubmission through an ICA-authorised Singapore visa agent via SAVE\nSupport responding to any additional-information request\nDecision — e-visa issued as an electronic PDF once approved\nSubmit Singapore''s free SG Arrival Card online within 3 days of departure',
    '/assets/images/visa-heroes/singapore.jpg',
    'Immigration & Checkpoints Authority (ICA) Singapore, official visa requirements page for India', 'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india', '2026-09-10'
);
SET @sgt1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sgt1, '2026.09', 'Migrated from existing visa_requirements content into the checklist engine.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt1, 'Core Documents', 'Every applicant needs these.', 1);
SET @t1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t1s1, 'Valid Passport', 'Valid at least 6 months beyond intended departure from Singapore, with at least one blank page.', 'original', 1, 0, 1, 1),
(@t1s1, 'Passport-Size Photograph', 'Recent, meeting Singapore visa photo specifications.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt1, 'Travel & Accommodation Documents', 'Your travel and stay arrangements.', 2);
SET @t1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t1s2, 'Confirmed Return/Onward Flight Tickets', NULL, 'copy', 1, 0, 1, 1),
(@t1s2, 'Proof of Accommodation', 'Hotel booking, or an invitation letter from your host if staying with them.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt1, 'Financial Documents', 'Evidence you can support your trip.', 3);
SET @t1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t1s3, 'Bank Statement', 'Last 3-6 months, showing sufficient funds.', 'copy', 1, 0, 0, 1),
(@t1s3, 'Proof of Employment or Business', 'ID card/appointment letter, or business registration proof for self-employed applicants.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt1, 'Application Documents', 'Your formal application paperwork.', 4);
SET @t1s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t1s4, 'Completed SAVE/ICA Visa Application Form', NULL, 'original', 1, 0, 0, 1),
(@t1s4, 'Cover Letter & Travel Itinerary', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(92, 1, NULL, 'INR', 'Confirmed After Assessment', 'ICA''s government fee and agent charges can change without notice — we confirm a written quote before you apply and never bill without it.', '2026-09-10', NOW(), 'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need to visit an embassy in person for a Singapore tourist visa?', 'No — Singapore''s Tourist Visa is a fully online e-visa processed through ICA''s SAVE system by an authorised agent; no personal appearance, biometrics, or interview is required.', 92, 1, 500, 1),
('How much does a Singapore tourist visa cost?', 'ICA does not publish a fixed fee, and it can change without notice — we confirm a current, written quote (government fee plus our service fee) before you apply.', 92, 1, 501, 1),
('How long does a Singapore tourist visa take to process?', 'Commonly around 3-5 working days for a complete application, though ICA does not guarantee a fixed timeline — apply well ahead of your travel date.', 92, 1, 502, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    92, 2, 'SGP-BUS-IN-02', '2026.09', 'published',
    'Short commercial visits — meetings, negotiations, and trade fairs — that do not involve local employment or payment by a Singapore entity.',
    'Issued under the same ICA Visit Pass framework as the Tourist Visa, with business-specific documents. Does NOT authorise employment — that needs a work pass from Singapore''s Ministry of Manpower instead (see our Work Visa page).',
    'Commonly up to 30 days per entry; frequent business travellers may be considered for longer multi-entry validity',
    'Online via ICA''s SAVE system, through an ICA-authorised visa agent',
    0,
    '3-5 working days (indicative — ICA does not guarantee a fixed timeline)',
    'Immigration & Checkpoints Authority (ICA), Singapore',
    'Initial consultation to confirm this is a genuine business visit, not an employment situation\nDocument assessment against ICA''s business-visit checklist\nApplication preparation, including formatting the invitation and covering letters\nDocument verification\nSubmission through an ICA-authorised Singapore visa agent\nSupport responding to any additional-information request\nDecision — e-visa issued as a PDF once approved\nSubmit the SG Arrival Card online within 3 days of departure',
    '/assets/images/visa-heroes/singapore.jpg',
    'Immigration & Checkpoints Authority (ICA) Singapore, official visa requirements page for India', 'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india', '2026-09-10'
);
SET @sgt2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sgt2, '2026.09', 'Migrated from existing visa_requirements content into the checklist engine.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt2, 'Core Documents', 'Every applicant needs these.', 1);
SET @t2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t2s1, 'Valid Passport', 'Valid at least 6 months beyond intended departure, with a blank page.', 'original', 1, 0, 1, 1),
(@t2s1, 'Passport-Size Photograph', 'Recent, meeting Singapore visa photo specifications.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt2, 'Business Invitation & Purpose', 'Evidence of who you are meeting and why.', 2);
SET @t2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t2s2, 'Invitation Letter', 'From the Singapore host company (on letterhead, stating purpose, dates, contact details) or trade-event/conference registration confirmation.', 'original', 1, 0, 1, 1),
(@t2s2, 'Covering Letter from Employer', 'From your employer in India, confirming your role, purpose of travel, and that your salary/expenses continue during the trip.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt2, 'Financial Documents', 'Evidence you can support your trip.', 3);
SET @t2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t2s3, 'Bank Statement', 'Last 3-6 months.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt2, 'Employment / Professional Documents', 'For self-employed or business-owner applicants.', 4);
SET @t2s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t2s4, 'Company Registration Proof', 'For self-employed or business-owner applicants, in place of an employer''s covering letter.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt2, 'Travel & Application Documents', 'Your travel arrangements and formal paperwork.', 5);
SET @t2s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t2s5, 'Confirmed Return/Onward Flight Tickets', NULL, 'copy', 1, 0, 0, 1),
(@t2s5, 'Completed SAVE/ICA Visa Application Form', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(92, 2, NULL, 'INR', 'Confirmed After Assessment', 'Government visa fees can change without notice — we confirm a current, written quote covering both the ICA fee and our service fee before you commit.', '2026-09-10', NOW(), 'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Singapore on a Business Visa?', 'No — a Business Visa only covers short commercial visits like meetings and trade fairs. Being employed or paid by a Singapore entity requires a work pass from the Ministry of Manpower instead.', 92, 2, 510, 1),
('What should the invitation letter from my Singapore host include?', 'It should be on the host company''s letterhead, stating the purpose, dates, and contact details — or a trade-event/conference registration confirmation if you don''t have a specific host.', 92, 2, 511, 1),
('Do frequent business travellers get longer visa validity?', 'Possibly — ICA may consider longer multiple-entry validity for travellers with a strong prior travel history, at its discretion.', 92, 2, 512, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Student's Pass via SOLAR
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    92, 3, 'SGP-STU-IN-03', '2026.09', 'published',
    'Full-time study at a Singapore institution of higher learning (IHL), via a Student''s Pass.',
    'Unlike a tourist or business visa, this application is initiated by your Singapore institution via ICA''s SOLAR system — you do not file it independently.',
    'Duration of your enrolled course, subject to a valid Student''s Pass',
    'Submitted via ICA''s SOLAR system by your Singapore institution on your behalf',
    1,
    'Several weeks (indicative) — ICA suggests applying as early as your institution''s SOLAR deadline allows',
    'Immigration & Checkpoints Authority (ICA), Singapore — via SOLAR',
    'Initial consultation once you have (or are close to receiving) your Singapore institution offer\nConfirming your institution will initiate the SOLAR application on your behalf\nDocument assessment — gathering academic and financial documents your institution''s SOLAR submission needs\nApplication preparation — completing eForm16 details and supporting paperwork\nDocument verification before your institution submits\nSubmission support while your institution files via SOLAR\nIn-Principle Approval (IPA) — travel to Singapore is only possible once this is issued\nAfter arrival: medical check and Student''s Pass issuance at ICA',
    '/assets/images/visa-heroes/singapore.jpg',
    'Immigration & Checkpoints Authority (ICA) Singapore, official visa requirements page for India', 'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india', '2026-09-10'
);
SET @sgt3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sgt3, '2026.09', 'Migrated from existing visa_requirements content into the checklist engine.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt3, 'Core Documents', 'Every applicant needs these.', 1);
SET @t3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t3s1, 'Valid Passport', 'Valid well beyond your course duration.', 'original', 1, 0, 1, 1),
(@t3s1, 'Passport-Size Photograph', 'Recent, meeting Singapore visa photo specifications.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt3, 'Admission & Academic Documents', 'Proof of your place at a Singapore institution.', 2);
SET @t3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t3s2, 'Offer / Admission Letter', 'From your Singapore institution of higher learning.', 'original', 1, 0, 1, 1),
(@t3s2, 'Academic Transcripts & Certificates', 'From your previous education.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt3, 'Financial Documents', 'Evidence you can fund tuition and living costs.', 3);
SET @t3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t3s3, 'Proof of Funds / Financial Support', 'Covering tuition and living costs for your course.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt3, 'SOLAR Application Documents', 'What your institution submits on your behalf.', 4);
SET @t3s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t3s4, 'Completed eForm16', 'Submitted via SOLAR by your institution.', 'original', 1, 0, 0, 1),
(@t3s4, 'In-Principle Approval (IPA) Letter', 'Issued once your SOLAR application is approved — required before travelling to Singapore.', 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt3, 'Post-Arrival Requirement', 'Completed after you land in Singapore.', 5);
SET @t3s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t3s5, 'Medical Examination Report', 'Required after arrival, before ICA issues your physical Student''s Pass, for most students.', 'original', 1, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(92, 3, NULL, 'INR', 'Confirmed After Assessment', 'SOLAR processing carries its own ICA/institution fees separate from our consultancy fee — we confirm both clearly before you proceed.', '2026-09-10', NOW(), 'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for a Singapore Student''s Pass myself?', 'No — the SOLAR application is initiated by your Singapore institution of higher learning on your behalf, not filed independently by the student.', 92, 3, 520, 1),
('Can I travel to Singapore before my Student''s Pass is approved?', 'No — you need your In-Principle Approval (IPA) letter before travelling; the physical Student''s Pass is issued after arrival, following a medical check.', 92, 3, 521, 1),
('How long does a Singapore Student''s Pass application take?', 'ICA suggests allowing several weeks for SOLAR processing once your institution submits — apply as early as your institution''s own deadline allows.', 92, 3, 522, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Employment Pass (MOM, not ICA)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    92, 4, 'SGP-WORK-IN-04', '2026.09', 'published',
    'Employment in Singapore under a confirmed job offer, via an Employment Pass sponsored by your employer.',
    'Not a tourist/business visit pass — the Employment Pass is issued by Singapore''s Ministry of Manpower (MOM), a different authority and process from ICA''s short-visit visas, for professionals, managers, and executives with a confirmed job offer.',
    'Commonly up to 2 years initially for first-time holders, renewable subject to MOM''s criteria',
    'Employer-sponsored via MOM''s Employment Pass Online (EPOL) system',
    1,
    'Several weeks (indicative) — MOM does not publish a fixed turnaround',
    'Ministry of Manpower (MOM), Singapore',
    'Initial consultation once you have (or are close to receiving) a Singapore job offer\nConfirming your employer will sponsor and submit the Employment Pass application via MOM''s EP Online system\nDocument assessment — gathering your qualification and employment-history documents\nApplication preparation, supporting your employer''s submission\nDocument verification before submission\nSubmission support while your employer files with MOM\nSupport through MOM''s assessment, including any additional-document requests\nDecision — MOM issues the Employment Pass (or an In-Principle Approval) once approved',
    '/assets/images/visa-heroes/singapore.jpg',
    'Ministry of Foreign Affairs (MFA) Singapore, Consular Services — Employment Pass / Dependant''s Pass guidance', 'https://www.mfa.gov.sg/Overseas-Mission/Mumbai/Consular-Services/Employment-Pass--Dependent-Pass', '2026-09-10'
);
SET @sgt4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sgt4, '2026.09', 'Migrated from existing visa_requirements content into the checklist engine.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt4, 'Core Documents', 'Every applicant needs these.', 1);
SET @t4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t4s1, 'Valid Passport', 'Valid well beyond your intended employment period.', 'original', 1, 0, 1, 1),
(@t4s1, 'Passport-Size Photograph', 'Recent, meeting Singapore visa photo specifications.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt4, 'Employer Sponsorship Documents', 'Proof your Singapore employer has sponsored your application.', 2);
SET @t4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t4s2, 'Confirmed Job Offer / Employment Contract', 'From your Singapore-registered employer.', 'original', 1, 0, 1, 1),
(@t4s2, 'Employer''s EP Online Submission', 'Completed by your employer through MOM''s EP Online system, not by you directly.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt4, 'Employment / Professional Documents', 'Your qualifications for the role.', 3);
SET @t4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t4s3, 'Educational Qualification Certificates', 'Degrees and transcripts relevant to the role.', 'copy', 1, 0, 0, 1),
(@t4s3, 'Employment History Documentation', 'Resume and past employer references.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt4, 'Additional Documents', 'Whatever MOM requests during its own assessment.', 4);
SET @t4s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t4s4, 'Additional MOM-Requested Documents', 'Any further supporting documents MOM asks for during assessment.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(92, 4, NULL, 'INR', 'Confirmed After Assessment', 'MOM sets its own government processing fees, paid by the sponsoring employer, separate from our consultancy fee for helping you prepare your side of the application.', '2026-09-10', NOW(), 'https://www.mfa.gov.sg/Overseas-Mission/Mumbai/Consular-Services/Employment-Pass--Dependent-Pass', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Singapore work visa the same as a tourist/business visa?', 'No — working in Singapore requires an Employment Pass issued by the Ministry of Manpower (MOM), a completely different authority and process from ICA''s short-visit visas.', 92, 4, 530, 1),
('Can I apply for an Employment Pass myself?', 'No — your Singapore employer must submit the application through MOM''s EP Online system; you cannot file it independently.', 92, 4, 531, 1),
('How long is a first Employment Pass valid for?', 'Commonly up to 2 years for first-time holders, renewable if you continue to meet MOM''s criteria at renewal.', 92, 4, 532, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    92, 5, 'SGP-FAM-IN-05', '2026.09', 'published',
    'Short visits to family members already living in or based in Singapore.',
    'A short-stay Visit Pass — different from the long-term Dependant''s Pass that lets immediate family of certain work-pass holders actually reside in Singapore (see our Dependent Visa page for that category).',
    'Commonly up to 30 days per entry (at ICA''s discretion)',
    'Online via ICA''s SAVE system, through an ICA-authorised visa agent',
    0,
    '3-5 working days (indicative — ICA does not guarantee a fixed timeline)',
    'Immigration & Checkpoints Authority (ICA), Singapore',
    'Initial consultation to confirm the relationship and purpose fit this category\nDocument assessment, including your host''s residence-status proof\nApplication preparation\nDocument verification\nSubmission through an ICA-authorised Singapore visa agent\nSupport responding to any additional-information request\nDecision — e-visa issued as a PDF once approved\nSubmit the SG Arrival Card online within 3 days of departure',
    '/assets/images/visa-heroes/singapore.jpg',
    'Immigration & Checkpoints Authority (ICA) Singapore, official visa requirements page for India', 'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india', '2026-09-10'
);
SET @sgt5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sgt5, '2026.09', 'Migrated from existing visa_requirements content into the checklist engine.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt5, 'Core Documents', 'Every applicant needs these.', 1);
SET @t5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t5s1, 'Valid Passport', 'Valid at least 6 months beyond intended departure.', 'original', 1, 0, 1, 1),
(@t5s1, 'Passport-Size Photograph', 'Recent, meeting Singapore visa photo specifications.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt5, 'Invitation & Host Documents', 'Evidence of who you are visiting.', 2);
SET @t5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t5s2, 'Invitation Letter from Host', 'From your family member/host in Singapore, including their contact details and residence status.', 'original', 1, 0, 1, 1),
(@t5s2, 'Host''s Residence Status Proof', 'Citizenship, PR, or valid long-term pass copy.', 'copy', 1, 0, 1, 2),
(@t5s2, 'Proof of Family Relationship', 'E.g. marriage or birth certificate, where relevant.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt5, 'Financial Documents', 'Evidence you can support your trip.', 3);
SET @t5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t5s3, 'Bank Statement', 'Last 3-6 months.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt5, 'Travel & Application Documents', 'Your travel arrangements and formal paperwork.', 4);
SET @t5s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t5s4, 'Confirmed Return/Onward Flight Tickets', NULL, 'copy', 1, 0, 0, 1),
(@t5s4, 'Completed SAVE/ICA Visa Application Form', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(92, 5, NULL, 'INR', 'Confirmed After Assessment', 'Government visa fees can change without notice — we confirm the current total (government fee plus our service fee) before you apply.', '2026-09-10', NOW(), 'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What proof do I need of my host''s status in Singapore?', 'A copy showing their citizenship, permanent residence, or a valid long-term pass, plus an invitation letter with their contact details.', 92, 5, 540, 1),
('Is Family Visit Visa the same as the Dependant''s Pass?', 'No — Family Visit Visa is a short-stay Visit Pass; the Dependant''s Pass is a separate, long-term category for immediate family of certain work-pass holders to actually live in Singapore.', 92, 5, 541, 1),
('Do I need to prove the family relationship?', 'Yes, where relevant — e.g. a marriage or birth certificate showing your relationship to the host.', 92, 5, 542, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    92, 6, 'SGP-TRANS-IN-06', '2026.09', 'published',
    'Connecting through Changi Airport, with or without leaving the transit area, en route to a third country.',
    'A same-terminal connection without leaving the transit area commonly needs no visa. Travellers who want to briefly leave the airport may qualify for the Visa Free Transit Facility (VFTF) instead of a full visa, subject to specific conditions.',
    'Up to 96 hours under VFTF; ICA sets the duration for a standard visa',
    'Assessed at the checkpoint for VFTF; online via SAVE for a standard visa',
    0,
    '3-5 working days if a standard visa is needed; VFTF is assessed at the checkpoint, not in advance',
    'Immigration & Checkpoints Authority (ICA), Singapore',
    'Initial consultation to work out whether you qualify for visa-free transit or need a standard visa\nEligibility check against current VFTF conditions for your itinerary\nDocument assessment for whichever pathway applies\nApplication preparation, if a standard visa is needed\nDocument verification\nSubmission through an ICA-authorised Singapore visa agent, where a visa application is required\nSupport responding to any additional-information request\nOutcome — either VFTF entry assessed at the checkpoint, or a decision on your submitted visa',
    '/assets/images/visa-heroes/singapore.jpg',
    'Immigration & Checkpoints Authority (ICA) Singapore, official visa requirements page for India', 'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india', '2026-09-10'
);
SET @sgt6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sgt6, '2026.09', 'Migrated from existing visa_requirements content into the checklist engine.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt6, 'Core Documents', 'Every applicant needs these.', 1);
SET @t6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t6s1, 'Valid Passport', 'Valid at least 6 months beyond your travel dates.', 'original', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt6, 'Onward Journey Documents', 'Evidence of your connecting flight and eligibility.', 2);
SET @t6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t6s2, 'Confirmed Onward Ticket to Third Country', 'Within the eligible transit window.', 'copy', 1, 0, 1, 1),
(@t6s2, 'VFTF Qualifying Evidence', 'Evidence of the qualifying visa/residence permit, if applying under VFTF conditions that require one.', 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt6, 'If Leaving the Airport', 'Only needed if you plan to exit the transit area.', 3);
SET @t6s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t6s3, 'Proof of Accommodation or Itinerary', 'For the transit period, if leaving the airport.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt6, 'If VFTF Conditions Are Not Met', 'Falls back to the standard Tourist Visa document set.', 4);
SET @t6s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t6s4, 'Standard Tourist Visa Documents', 'If you don''t meet VFTF conditions, the same documents as a standard Tourist Visa application apply — see our Tourist Visa checklist.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(92, 6, NULL, 'INR', 'Confirmed After Assessment', 'No government fee applies if you qualify for VFTF; if not, standard visa fees apply and can change without notice. We confirm which pathway applies before quoting.', '2026-09-10', NOW(), 'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa just to connect through Changi Airport?', 'Commonly not, if you stay within the transit area on a same-terminal connection. Leaving the airport may qualify you for the Visa Free Transit Facility (VFTF) instead of a full visa, or require a standard visa if you don''t meet VFTF conditions.', 92, 6, 550, 1),
('What is the Visa Free Transit Facility (VFTF)?', 'A facility letting eligible travellers briefly leave Changi Airport during a longer connection, for up to around 96 hours, without a full visa — subject to specific conditions we can check against your itinerary.', 92, 6, 551, 1),
('Is VFTF eligibility confirmed in advance?', 'No — VFTF is assessed at the checkpoint on arrival, not through advance processing, so we help you prepare the right documents but the final call is ICA''s at entry.', 92, 6, 552, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    92, 7, 'SGP-MED-IN-07', '2026.09', 'published',
    'Medical treatment in Singapore, supported by hospital/clinic documentation.',
    'Handled through the same Visit Pass framework as tourism/business travel. Visagiri assists only with the visa application, not with treatment decisions.',
    'Commonly up to 30 days per entry, though ICA may consider the treatment plan',
    'Online via ICA''s SAVE system, through an ICA-authorised visa agent',
    0,
    '3-5 working days (indicative) — start as early as your hospital appointment allows for time-sensitive treatment',
    'Immigration & Checkpoints Authority (ICA), Singapore',
    'Initial consultation once you have (or are arranging) a hospital appointment in Singapore\nVisa category selection for patient and attendant applications\nDocument assessment of your hospital documentation and financial proof\nApplication preparation\nDocument verification\nSubmission through an ICA-authorised Singapore visa agent\nSupport responding to any additional-information request\nDecision — e-visa issued as a PDF once approved',
    '/assets/images/visa-heroes/singapore.jpg',
    'Immigration & Checkpoints Authority (ICA) Singapore, official visa requirements page for India', 'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india', '2026-09-10'
);
SET @sgt7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sgt7, '2026.09', 'Migrated from existing visa_requirements content into the checklist engine.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt7, 'Core Documents', 'Every applicant (and any accompanying attendant) needs these.', 1);
SET @t7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t7s1, 'Valid Passport', 'For the patient, and any accompanying attendant — valid at least 6 months beyond intended departure.', 'original', 1, 0, 1, 1),
(@t7s1, 'Passport-Size Photograph', 'Recent, meeting Singapore visa photo specifications.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt7, 'Medical Purpose Documents', 'Evidence of your treatment in Singapore.', 2);
SET @t7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t7s2, 'Hospital Appointment / Admission Letter', 'From the treating Singapore hospital/clinic, including estimated treatment dates.', 'original', 1, 0, 1, 1),
(@t7s2, 'Medical Reports / Referral Summary', 'Supporting the treatment being sought.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt7, 'Financial Documents', 'Evidence you can fund treatment and stay.', 3);
SET @t7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t7s3, 'Proof of Funds or Payment-Guarantee Documentation', 'For treatment and stay.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt7, 'Attendant Documents', 'If someone is accompanying the patient.', 4);
SET @t7s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t7s4, 'Proof of Relationship for Attendant', 'For any accompanying attendant.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt7, 'Travel & Application Documents', 'Your travel arrangements and formal paperwork.', 5);
SET @t7s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t7s5, 'Confirmed Return/Onward Flight Tickets', 'Where the treatment plan allows a fixed return date.', 'copy', 0, 1, 0, 1),
(@t7s5, 'Completed SAVE/ICA Visa Application Form', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(92, 7, NULL, 'INR', 'Confirmed After Assessment', 'Government visa fees can change without notice — we confirm the current total before you apply. Treatment costs are set by your Singapore hospital, not by us or ICA.', '2026-09-10', NOW(), 'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Singapore have a separate medical visa category?', 'It''s handled through the same Visit Pass framework as tourism/business travel, supported by hospital/clinic documentation — not a distinct legal category with its own rules.', 92, 7, 560, 1),
('Can a family member accompany me for treatment?', 'Yes — an accompanying attendant can apply alongside you, with proof of their relationship to you as part of the documents.', 92, 7, 561, 1),
('Does Visagiri help arrange the medical treatment itself?', 'No — we assist only with the visa application; treatment arrangements and decisions are between you and your Singapore hospital.', 92, 7, 562, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    92, 8, 'SGP-CONF-IN-08', '2026.09', 'published',
    'Attending a conference, exhibition, trade fair, or professional event in Singapore.',
    'Handled through the same ICA Visit Pass framework as business travel, supported by your event registration and any sponsoring-company documentation.',
    'Commonly up to 30 days per entry, or matched to the event duration plus reasonable travel days',
    'Online via ICA''s SAVE system, through an ICA-authorised visa agent',
    0,
    '3-5 working days (indicative) — apply as soon as your registration and travel dates are confirmed',
    'Immigration & Checkpoints Authority (ICA), Singapore',
    'Initial consultation once your conference registration is confirmed\nDocument assessment of your registration and invitation documents\nApplication preparation\nDocument verification\nSubmission through an ICA-authorised Singapore visa agent\nSupport responding to any additional-information request\nDecision — e-visa issued as a PDF once approved\nSubmit the SG Arrival Card online within 3 days of departure',
    '/assets/images/visa-heroes/singapore.jpg',
    'Immigration & Checkpoints Authority (ICA) Singapore, official visa requirements page for India', 'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india', '2026-09-10'
);
SET @sgt8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sgt8, '2026.09', 'Migrated from existing visa_requirements content into the checklist engine.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt8, 'Core Documents', 'Every applicant needs these.', 1);
SET @t8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t8s1, 'Valid Passport', 'Valid at least 6 months beyond intended departure.', 'original', 1, 0, 1, 1),
(@t8s1, 'Passport-Size Photograph', 'Recent, meeting Singapore visa photo specifications.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt8, 'Conference Documents', 'Evidence of the event you are attending.', 2);
SET @t8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t8s2, 'Conference/Event Registration Confirmation', 'Including dates and venue.', 'copy', 1, 0, 1, 1),
(@t8s2, 'Invitation Letter from Organiser', 'From the event organiser or hosting company, where available.', 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt8, 'Financial Documents', 'Evidence you can support your trip.', 3);
SET @t8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t8s3, 'Bank Statement', 'Last 3-6 months.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt8, 'Employment Documents', 'Confirming this is a work-related trip.', 4);
SET @t8s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t8s4, 'Covering Letter from Employer', 'Confirming your attendance is work-related.', 'original', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt8, 'Travel & Application Documents', 'Your travel arrangements and formal paperwork.', 5);
SET @t8s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t8s5, 'Confirmed Return/Onward Flight Tickets', NULL, 'copy', 1, 0, 0, 1),
(@t8s5, 'Completed SAVE/ICA Visa Application Form', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(92, 8, NULL, 'INR', 'Confirmed After Assessment', 'Government visa fees can change without notice — we confirm the current total before you apply.', '2026-09-10', NOW(), 'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need an invitation letter to attend a Singapore conference?', 'A conference/event registration confirmation is required; an invitation letter from the organiser or hosting company helps but isn''t always available or mandatory.', 92, 8, 570, 1),
('How early should I apply for a conference visa?', 'As soon as your registration and travel dates are confirmed — especially for large trade events with high visa demand around the same dates.', 92, 8, 571, 1),
('Do I need proof I will return to India after the conference?', 'Yes — a covering letter from your employer confirming your ongoing role and that the trip is work-related is a standard part of the application.', 92, 8, 572, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Singapore has no distinct sports-visa
-- category; athletes/officials apply under the standard Visit Pass
-- with event/federation documentation. Freshly researched this
-- session (no prior visa_requirements row existed for this type).
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    92, 9, 'SGP-SPORT-IN-09', '2026.09', 'published',
    'Participating in a sporting event, tournament, or training camp in Singapore.',
    'Singapore does not operate a distinct "sports visa" category — Indian athletes/officials apply under the standard Visit Pass with event-specific documentation, via the same ICA SAVE system as other short visits.',
    'Commonly up to 30 days per entry, or matched to the event duration',
    'Online via ICA''s SAVE system, through an ICA-authorised visa agent',
    0,
    '3-5 working days (indicative) — ICA does not guarantee a fixed timeline',
    'Immigration & Checkpoints Authority (ICA), Singapore',
    'Confirm your event/federation invitation and gather event details\nInitial consultation to confirm the right visa category\nDocument assessment against ICA''s Visit Pass checklist\nApplication preparation\nDocument verification\nSubmission through an ICA-authorised Singapore visa agent\nSupport responding to any additional-information request\nDecision — e-visa issued as a PDF once approved',
    '/assets/images/visa-heroes/singapore.jpg',
    'Immigration & Checkpoints Authority (ICA) Singapore, official visa requirements page for India', 'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india', '2026-09-11'
);
SET @sgt9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sgt9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt9, 'Core Documents', 'Every applicant needs these.', 1);
SET @t9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t9s1, 'Valid Passport', 'Valid at least 6 months beyond intended departure.', 'original', 1, 0, 1, 1),
(@t9s1, 'Passport-Size Photograph', 'Recent, meeting Singapore visa photo specifications.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt9, 'Sporting Event Documents', 'Evidence of the event you are attending.', 2);
SET @t9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t9s2, 'Federation / Event Invitation or Nomination Letter', 'From the sports federation or event organiser.', 'original', 1, 0, 1, 1),
(@t9s2, 'Event Schedule & Details', 'Dates, venue, and nature of the event.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt9, 'Financial Documents', 'Evidence you can support your trip.', 3);
SET @t9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t9s3, 'Bank Statement', 'Last 3-6 months.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt9, 'Travel & Application Documents', 'Your travel arrangements and formal paperwork.', 4);
SET @t9s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t9s4, 'Confirmed Return/Onward Flight Tickets', NULL, 'copy', 1, 0, 0, 1),
(@t9s4, 'Completed SAVE/ICA Visa Application Form', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(92, 9, NULL, 'INR', 'Confirmed After Assessment', 'Standard Visit Pass fee — Singapore has no separate sports-visa fee category, and ICA does not publish a fixed fee.', '2026-09-11', NOW(), 'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Singapore have a separate sports visa?', 'No — Singapore does not have a distinct sports-visa category. Athletes and officials apply under the standard Visit Pass, supported by a federation or event invitation.', 92, 9, 580, 1),
('What proof of the event do I need?', 'A letter from your sports federation or the event organiser confirming your participation, plus the event''s schedule and venue details.', 92, 9, 581, 1),
('Do I need to appear in person for a Singapore sports-related visa?', 'No — like other short-visit categories, this is processed online via ICA''s SAVE system with no personal appearance required.', 92, 9, 582, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Dependant's Pass (MOM, not ICA)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    92, 10, 'SGP-DEP-IN-10', '2026.09', 'published',
    'Joining a spouse (married) or child under 21 who holds a qualifying Singapore work pass, via a Dependant''s Pass.',
    'A long-term MOM pass, separate from ICA''s short-visit Family Visit Visa. Sponsored by the work-pass holder, not applied for independently by the dependant.',
    'Matches the sponsor''s Employment Pass/S Pass validity',
    'Sponsor-submitted via MOM''s Dependant''s Pass system',
    1,
    'Several weeks (indicative) — MOM does not publish a fixed turnaround',
    'Ministry of Manpower (MOM), Singapore',
    'Initial consultation with the sponsoring work-pass holder to confirm dependant eligibility\nConfirming the sponsor meets MOM''s current qualifying-salary threshold for dependant sponsorship\nDocument assessment — relationship proof and sponsor employment documentation\nApplication preparation\nDocument verification before submission\nSubmission support for the MOM Dependant''s Pass application\nSupport through MOM''s assessment, including any additional-document requests\nDecision — MOM issues the Dependant''s Pass once approved',
    '/assets/images/visa-heroes/singapore.jpg',
    'Ministry of Foreign Affairs (MFA) Singapore, Consular Services — Employment Pass / Dependant''s Pass guidance', 'https://www.mfa.gov.sg/Overseas-Mission/Mumbai/Consular-Services/Employment-Pass--Dependent-Pass', '2026-09-10'
);
SET @sgt10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sgt10, '2026.09', 'Migrated from existing visa_requirements content into the checklist engine.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt10, 'Core Documents', 'Every applicant needs these.', 1);
SET @t10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t10s1, 'Valid Passport of the Dependant', 'Valid well beyond the intended stay.', 'original', 1, 0, 1, 1),
(@t10s1, 'Passport-Size Photograph', 'Recent photograph of the dependant.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt10, 'Sponsor & Relationship Documents', 'Proof of your relationship to the sponsor.', 2);
SET @t10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t10s2, 'Proof of Relationship', 'Marriage certificate for a spouse, birth certificate for a child.', 'original', 1, 0, 1, 1),
(@t10s2, 'Sponsor''s Employment Pass / S Pass Details', 'And proof of their current employment.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt10, 'Financial Documents', 'Proving the sponsor meets MOM''s threshold.', 3);
SET @t10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t10s3, 'Sponsor''s Salary Documentation', 'Supporting the minimum qualifying threshold MOM sets for dependant sponsorship.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sgt10, 'Application Documents', 'What the sponsor submits to MOM.', 4);
SET @t10s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t10s4, 'Completed MOM Dependant''s Pass Application', 'Submitted by or on behalf of the sponsor.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(92, 10, NULL, 'INR', 'Confirmed After Assessment', 'MOM sets its own government fees for Dependant''s Pass applications, separate from our consultancy fee for helping prepare the application.', '2026-09-10', NOW(), 'https://www.mfa.gov.sg/Overseas-Mission/Mumbai/Consular-Services/Employment-Pass--Dependent-Pass', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who can be sponsored on a Singapore Dependant''s Pass?', 'A married spouse or a child under 21 of a qualifying Employment Pass or S Pass holder — sponsored by the work-pass holder, not applied for independently.', 92, 10, 590, 1),
('Does the sponsor need a minimum salary to bring dependants?', 'Yes — MOM sets a qualifying salary threshold for dependant sponsorship, which we confirm against the sponsor''s current pay before applying.', 92, 10, 591, 1),
('How long does a Dependant''s Pass application take?', 'MOM does not publish a fixed turnaround — plan for several weeks and avoid booking irreversible travel before approval is confirmed.', 92, 10, 592, 1);
