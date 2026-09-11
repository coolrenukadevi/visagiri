-- France Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as Mexico/Singapore
-- (see AUDIT.md). France is a Schengen country, so its real, distinctive
-- facts are genuinely different from both Mexico and Singapore:
--   - Indian passport holders need a Schengen visa (Type C, short-stay)
--     for Tourist/Business/Family/Medical/Conference/Sports — there is
--     NO eVisa or visa-on-arrival, and biometric data collection at a
--     VFS Global centre is mandatory (personal_appearance = 1
--     everywhere, unlike Singapore's fully-online model).
--   - France genuinely DOES operate a distinct Schengen "Sports Visa"
--     purpose code (unlike Mexico/Singapore, which have no sports-visa
--     category at all) — stated as a real category here, not flattened
--     to match the other two countries' "no such category" pattern.
--   - Student (VLS-TS) requires the mandatory Campus France procedure
--     first; Work requires the employer to obtain DREETS labour
--     authorisation before the employee applies; Dependent (family
--     reunification) requires the French-resident sponsor to have
--     resided 18+ months and meet OFII income/housing thresholds.
--   - Airport transit: since 10 April 2026, Indian ordinary-passport
--     holders no longer need an Airport Transit Visa (ATV) for a
--     same-airport connection that stays within the international
--     zone — a genuinely time-sensitive fact, not evergreen, stated
--     with its effective date rather than as a blanket "no visa
--     needed."
--   - The Schengen short-stay consular fee (EUR 90) and VLS-TS fee
--     (EUR 99) are both clearly sourced; Work/Dependent/Transit fees
--     were not clearly sourced with confidence, so those show
--     "Confirmed After Assessment" rather than a guessed figure.
--
-- country_id 118 = France. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical,
-- 8=Conference, 9=Sports, 10=Dependent.
--
-- hero_image_url points at the real Eiffel Tower/Seine/French flag
-- photo supplied by the client for this hero.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Schengen short-stay (Type C)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    118, 1, 'FRA-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and short personal visits to France and the wider Schengen area.',
    'Indian passport holders must obtain a Schengen visa before travelling — there is no visa-on-arrival or eVisa for France. Applications are submitted via VFS Global with mandatory biometric data collection.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    '15-20 working days after your VFS appointment (indicative)',
    'VFS Global France Visa Application Centre, India',
    'Initial consultation to confirm Tourist Visa is the right category\nGather documents against this checklist, including a day-by-day itinerary\nBook your VFS Global appointment\nAttend in person for biometrics (mandatory for first-time applicants)\nSubmission of your application and documents\nSupport responding to any additional-information request\nDecision — visa sticker affixed to your passport once approved\nCollect your passport from VFS',
    '/assets/images/visa-heroes/france.jpg',
    'Independent visa-agency guidance and France-Visas/VFS Global sourcing for Schengen short-stay visas issued to Indian passport holders', 'https://btwvisas.com/visa-guide/france-visa/', '2026-09-11'
);
SET @frt1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@frt1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt1, 'Core Documents', 'Every applicant needs these.', 1);
SET @ft1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft1s1, 'Valid Passport', 'Issued within the last 10 years, valid at least 3 months beyond your intended departure from the Schengen area, with at least 2 blank pages.', 'original', 1, 0, 1, 1),
(@ft1s1, 'Passport Photographs', 'Two recent colour photos, 35x45mm, white background.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt1, 'Financial & Travel Documents', 'Evidence you can support your trip.', 2);
SET @ft1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft1s2, 'Bank Statements', 'Last 3 months, showing funds of roughly EUR 120/day of stay (indicative).', 'copy', 1, 0, 1, 1),
(@ft1s2, 'Travel Insurance', 'Minimum EUR 30,000 medical coverage, valid across the whole Schengen area, including evacuation/repatriation.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt1, 'Application Documents', 'Your formal application paperwork.', 3);
SET @ft1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft1s3, 'Completed Schengen Visa Application Form', NULL, 'original', 1, 0, 0, 1),
(@ft1s3, 'Cover Letter & Day-by-Day Itinerary', 'A clear statement of purpose plus your planned itinerary.', 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt1, 'Appointment & Submission', 'Booking and attending your VFS appointment.', 4);
SET @ft1s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft1s4, 'VFS Appointment & Biometrics', 'Mandatory in-person biometric data collection for first-time Schengen applicants.', 'original', 1, 0, 0, 1),
(@ft1s4, 'Visa Fee Payment Receipt', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt1, 'Final Verification', 'What happens after submission.', 5);
SET @ft1s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft1s5, 'Passport Submission Acknowledgement', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(118, 1, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Official consular fee; VFS Global''s separate service charge is additional (commonly around INR 1,100-1,200) — we confirm the full total before you apply.', '2026-09-01', NOW(), 'https://terratern.com/blog/france-visa-fees-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there an eVisa or visa-on-arrival for France?', 'No — Indian passport holders must obtain a Schengen visa in advance through VFS Global; there is no eVisa or visa-on-arrival option for France.', 118, 1, 600, 1),
('How much travel insurance do I need for a France visa?', 'A minimum of EUR 30,000 medical coverage, valid across the entire Schengen area for your full trip, including medical evacuation and repatriation.', 118, 1, 601, 1),
('Do I need to appear in person for a France tourist visa?', 'Yes — biometric data collection at a VFS Global centre is mandatory for first-time Schengen visa applicants.', 118, 1, 602, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen short-stay (Type C)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    118, 2, 'FRA-BUS-IN-02', '2026.09', 'published',
    'Short business visits — meetings, negotiations, and site visits — to France and the wider Schengen area.',
    'A weak or generic invitation letter is a leading rejection reason for Indian applicants; ensure the invitation clearly states purpose, duration, and who covers expenses. France has a real 14%+ rejection rate for Indian applicants, so document quality matters.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    '15-20 working days after your VFS appointment (indicative)',
    'VFS Global France Visa Application Centre, India',
    'Initial consultation to confirm the trip is a genuine business visit\nObtain a clear, detailed invitation letter from your French host company\nGather documents against this checklist\nBook your VFS Global appointment\nAttend in person for biometrics\nSubmission of your application and documents\nSupport responding to any additional-information request\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/france.jpg',
    'Independent visa-agency guidance for France Schengen business visas issued to Indian passport holders', 'https://www.jobbatical.com/solutions/business-visa-india-to-france', '2026-09-11'
);
SET @frt2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@frt2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt2, 'Core Documents', 'Every applicant needs these.', 1);
SET @ft2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft2s1, 'Valid Passport', 'Issued within the last 10 years, valid at least 3 months beyond intended departure, with at least 2 blank pages.', 'original', 1, 0, 1, 1),
(@ft2s1, 'Passport Photographs', 'Two recent colour photos, 35x45mm, white background.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt2, 'Business Invitation & Purpose', 'Evidence of who you are meeting and why.', 2);
SET @ft2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft2s2, 'Invitation Letter from French Host Company', 'On official letterhead with logo, address, registration number and contact details, stating purpose, duration, and who bears expenses.', 'original', 1, 0, 1, 1),
(@ft2s2, 'Covering Letter from Indian Employer', 'Confirming your employment, role, and travel approval.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt2, 'Financial & Travel Documents', 'Evidence you can support your trip.', 3);
SET @ft2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft2s3, 'Bank Statements', 'Last 3 months.', 'copy', 1, 0, 0, 1),
(@ft2s3, 'Travel Insurance', 'Minimum EUR 30,000 medical coverage across the Schengen area.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt2, 'Application Documents', 'Your formal application paperwork.', 4);
SET @ft2s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft2s4, 'Completed Schengen Visa Application Form', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt2, 'Appointment & Submission', 'Booking and attending your VFS appointment.', 5);
SET @ft2s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft2s5, 'VFS Appointment & Biometrics', NULL, 'original', 1, 0, 0, 1),
(@ft2s5, 'Visa Fee Payment Receipt', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt2, 'Final Verification', 'What happens after submission.', 6);
SET @ft2s6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft2s6, 'Passport Submission Acknowledgement', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(118, 2, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Official consular fee; VFS Global''s separate service charge is additional — we confirm the full total before you apply.', '2026-09-01', NOW(), 'https://terratern.com/blog/france-visa-fees-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What makes a strong invitation letter for a France business visa?', 'A short, specific letter with proper contact details and a clear statement of purpose carries more weight than a long, generic cover letter — this is a leading factor in avoiding rejection.', 118, 2, 610, 1),
('Can I work in France on a Business Visa?', 'No — a Business Visa only covers short commercial visits like meetings and negotiations; actual employment requires a separate work visa with employer sponsorship.', 118, 2, 611, 1),
('What is France''s visa rejection rate for Indian applicants?', 'Around 14% based on recent data — document quality (especially the invitation letter) is the biggest factor in avoiding rejection.', 118, 2, 612, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — VLS-TS via mandatory Campus France
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    118, 3, 'FRA-STU-IN-03', '2026.09', 'published',
    'Full-time study at a French university or institution, for courses longer than 3 months, via the VLS-TS long-stay student visa.',
    'The Campus France EEF procedure is MANDATORY for all Indian student applicants before applying for the VLS-TS visa — this is not optional and must be completed first.',
    'Duration of your course (VLS-TS functions as both visa and residence permit)',
    'Mandatory Campus France procedure first, then a VLS-TS long-stay visa application via VFS Global',
    1,
    'Campus France processing plus visa issuance (indicative) — apply well ahead of your intake',
    'Campus France India / VFS Global France Visa Application Centre',
    'Secure admission from a French institution and register with Campus France India\nComplete the mandatory Campus France EEF procedure and obtain your APS Certificate (apply 8+ weeks early)\nGather documents against this checklist\nBook your VFS Global appointment\nAttend in person for biometrics\nSubmission of your VLS-TS application\nCollect your passport from VFS once approved\nValidate your VLS-TS online via ANEF within 3 months of arriving in France',
    '/assets/images/visa-heroes/france.jpg',
    'Campus France and independent visa-agency guidance for the French student visa (VLS-TS) issued to Indian applicants', 'https://gradright.com/france-student-visa-requirements-for-an-international-student-types-and-fees-included/', '2026-09-11'
);
SET @frt3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@frt3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt3, 'Core Documents', 'Every applicant needs these.', 1);
SET @ft3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft3s1, 'Valid Passport', 'Valid well beyond your course duration.', 'original', 1, 0, 1, 1),
(@ft3s1, 'Passport Photographs', 'Two recent colour photos.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt3, 'Admission & Campus France Documents', 'Proof of your place and mandatory Campus France registration.', 2);
SET @ft3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft3s2, 'Offer / Admission Letter', 'From your French institution, official letter of acceptance.', 'original', 1, 0, 1, 1),
(@ft3s2, 'Campus France APS Certificate', 'Mandatory for all Indian student applicants — obtained through the Campus France EEF procedure.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt3, 'Financial Documents', 'Evidence you can fund your studies.', 3);
SET @ft3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft3s3, 'Proof of Funds', 'Roughly EUR 615/month for living costs (indicative) plus tuition, for the full length of your stay.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt3, 'Travel & Supporting Documents', 'Accommodation and insurance.', 4);
SET @ft3s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft3s4, 'Accommodation Proof', 'For your initial months in France.', 'copy', 1, 0, 0, 1),
(@ft3s4, 'International Health Insurance', 'Covering your stay.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt3, 'Application Documents', 'Your formal application paperwork.', 5);
SET @ft3s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft3s5, 'Completed VLS-TS Application Form', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt3, 'Appointment & Submission', 'Booking and attending your VFS appointment.', 6);
SET @ft3s6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft3s6, 'VFS Appointment & Biometrics', NULL, 'original', 1, 0, 0, 1),
(@ft3s6, 'Visa Fee Payment Receipt', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt3, 'Final Verification', 'What happens after submission and arrival.', 7);
SET @ft3s7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft3s7, 'Passport Submission Acknowledgement', NULL, 'original', 1, 0, 0, 1),
(@ft3s7, 'Post-Arrival ANEF Validation Instructions', 'You must validate your VLS-TS online via ANEF within 3 months of arrival and pay a EUR 50 e-stamp.', 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(118, 3, 99.00, 'EUR', 'VLS-TS Long-Stay Visa Fee', 'Plus a separate EUR 50 post-arrival ANEF validation e-stamp. VFS Global''s service charge is additional.', '2026-09-01', NOW(), 'https://gradright.com/france-student-visa-requirements-for-an-international-student-types-and-fees-included/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Campus France registration mandatory for Indian students?', 'Yes — the Campus France EEF procedure and APS Certificate are mandatory for all Indian student applicants before applying for the VLS-TS visa; this is not optional.', 118, 3, 620, 1),
('Can I work while studying in France?', 'Yes — VLS-TS holders can work up to 964 hours per year (about 20 hours/week) alongside their studies.', 118, 3, 621, 1),
('What do I need to do after arriving in France on a student visa?', 'You must validate your VLS-TS online via the ANEF portal within 3 months of arrival and pay a EUR 50 e-stamp — this is required to keep your status valid.', 118, 3, 622, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Employer-sponsored long-stay visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    118, 4, 'FRA-WORK-IN-04', '2026.09', 'published',
    'Employment in France under a confirmed job offer, via an employer-sponsored long-stay work visa.',
    'Your employer must prove you are essential for the role and that no suitable EU candidate is available, then obtain DREETS labour authorisation before you can apply.',
    'Duration of your work contract, renewable',
    'Employer-sponsored long-stay visa; your employer must obtain DREETS labour authorisation before you apply',
    1,
    '4-12 weeks after application, plus 2-4 weeks for your employer''s DREETS authorisation (indicative)',
    'VFS Global France Visa Application Centre, India',
    'Secure a confirmed job offer from a France-based employer\nYour employer applies for DREETS labour authorisation on your behalf\nGather documents against this checklist once authorisation is obtained\nBook your VFS Global appointment\nAttend in person for biometrics\nSubmission of your long-stay visa application\nCollect your passport from VFS once approved\nRegister with OFII within 3 months of arrival in France',
    '/assets/images/visa-heroes/france.jpg',
    'Independent employer-immigration guidance for France work visas issued to Indian passport holders', 'https://peoplemanagingpeople.com/global-hr/france-work-permits-visa/', '2026-09-11'
);
SET @frt4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@frt4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt4, 'Core Documents', 'Every applicant needs these.', 1);
SET @ft4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft4s1, 'Valid Passport', 'Valid at least 6 months beyond your planned stay in France.', 'original', 1, 0, 1, 1),
(@ft4s1, 'Passport Photographs', 'Two recent colour photos.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt4, 'Employer Sponsorship Documents', 'Proof your French employer has sponsored your application.', 2);
SET @ft4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft4s2, 'Approved Work Contract', 'From your France-based employer.', 'original', 1, 0, 1, 1),
(@ft4s2, 'Employer''s DREETS Labour Authorisation', 'Confirming the role has been authorised before you apply.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt4, 'Employment / Professional Documents', 'Your qualifications for the role.', 3);
SET @ft4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft4s3, 'Qualification Certificates', 'Degrees and certifications relevant to the role.', 'copy', 1, 0, 0, 1),
(@ft4s3, 'Employment History', 'Resume and past employer references.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt4, 'Travel & Supporting Documents', 'Insurance for your stay.', 4);
SET @ft4s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft4s4, 'Health Insurance', 'Adequate medical coverage from an authorised supplier for your full stay.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt4, 'Application Documents', 'Your formal application paperwork.', 5);
SET @ft4s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft4s5, 'Completed Long-Stay Visa Application Form', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt4, 'Appointment & Submission', 'Booking and attending your VFS appointment.', 6);
SET @ft4s6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft4s6, 'VFS Appointment & Biometrics', NULL, 'original', 1, 0, 0, 1),
(@ft4s6, 'Visa Fee Payment Receipt', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt4, 'Final Verification', 'What happens after submission and arrival.', 7);
SET @ft4s7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft4s7, 'Passport Submission Acknowledgement', NULL, 'original', 1, 0, 0, 1),
(@ft4s7, 'Post-Arrival OFII Registration Instructions', 'Mandatory for all long-stay visa holders within 3 months of arrival, activating your legal right to reside and work.', 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(118, 4, NULL, 'EUR', 'Confirmed After Assessment', 'Long-stay work visa fees plus separate OFII registration taxes apply — we confirm the current total before you apply.', '2026-09-01', NOW(), 'https://peoplemanagingpeople.com/global-hr/france-work-permits-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for a France work visa without a job offer?', 'No — a confirmed job offer and your employer''s DREETS labour authorisation are both required before you can apply for the visa.', 118, 4, 630, 1),
('What is OFII registration and do I need it?', 'Yes — registering with the Office Français de l''Immigration et de l''Intégration (OFII) within 3 months of arrival is mandatory for all long-stay visa holders and activates your legal right to reside and work.', 118, 4, 631, 1),
('How long does a France work visa take end to end?', 'Commonly 4-12 weeks for the visa itself, plus 2-4 weeks for your employer to first obtain DREETS labour authorisation — plan several months ahead.', 118, 4, 632, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen short-stay (Type C)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    118, 5, 'FRA-FAM-IN-05', '2026.09', 'published',
    'Short visits to family or friends residing in France.',
    'If staying with your host, an original Attestation d''Accueil (certificate of accommodation) issued by the host''s local town hall (mairie) is mandatory — photocopies are not accepted and cause rejection.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    '15-20 working days after your VFS appointment (indicative)',
    'VFS Global France Visa Application Centre, India',
    'Confirm with your host whether an Attestation d''Accueil is needed and have them apply at their local mairie\nGather documents against this checklist\nBook your VFS Global appointment\nAttend in person for biometrics\nSubmission of your application and documents\nSupport responding to any additional-information request\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/france.jpg',
    'Independent visa-agency guidance for France Schengen family-visit visas issued to Indian passport holders', 'https://btwvisas.com/blog/france-attestation-daccueil', '2026-09-11'
);
SET @frt5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@frt5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt5, 'Core Documents', 'Every applicant needs these.', 1);
SET @ft5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft5s1, 'Valid Passport', 'Issued within the last 10 years, valid at least 3 months beyond intended departure.', 'original', 1, 0, 1, 1),
(@ft5s1, 'Passport Photographs', 'Two recent colour photos.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt5, 'Invitation & Host Documents', 'Evidence of who you are visiting.', 2);
SET @ft5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft5s2, 'Original Attestation d''Accueil', 'Certificate of accommodation from the host''s local mairie — mandatory if staying with your host; original only, photocopies are rejected.', 'original', 1, 1, 1, 1),
(@ft5s2, 'Invitation Letter from Host', 'Stating purpose, relationship, and length of stay.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt5, 'Financial & Travel Documents', 'Evidence you can support your trip.', 3);
SET @ft5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft5s3, 'Bank Statements', 'Last 3 months.', 'copy', 1, 0, 0, 1),
(@ft5s3, 'Travel Insurance', 'Minimum EUR 30,000 medical coverage across the Schengen area.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt5, 'Application Documents', 'Your formal application paperwork.', 4);
SET @ft5s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft5s4, 'Completed Schengen Visa Application Form', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt5, 'Appointment & Submission', 'Booking and attending your VFS appointment.', 5);
SET @ft5s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft5s5, 'VFS Appointment & Biometrics', NULL, 'original', 1, 0, 0, 1),
(@ft5s5, 'Visa Fee Payment Receipt', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt5, 'Final Verification', 'What happens after submission.', 6);
SET @ft5s6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft5s6, 'Passport Submission Acknowledgement', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(118, 5, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Official consular fee; VFS Global''s separate service charge is additional. The Attestation d''Accueil itself costs a separate EUR 30 stamp fee, paid by your host in France.', '2026-09-01', NOW(), 'https://btwvisas.com/blog/france-attestation-daccueil', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is an Attestation d''Accueil and do I always need one?', 'It''s a certificate of accommodation issued by your host''s local mairie (town hall) — mandatory if you''ll be staying with your host, but not needed if you''re staying in a hotel instead.', 118, 5, 640, 1),
('Why do so many France family-visit applications get rejected?', 'Around 85% of France visa rejections for Indian citizens are linked to inadequate or incorrect invitation letters — getting the invitation and Attestation d''Accueil right matters a great deal.', 118, 5, 641, 1),
('Can I submit a photocopy of the Attestation d''Accueil?', 'No — only the original document is accepted; a photocopy leads to rejection. Your host must post the original to you in India.', 118, 5, 642, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Airport Transit Visa (ATV)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    118, 6, 'FRA-TRANS-IN-06', '2026.09', 'published',
    'Connecting through a French airport, with or without leaving the international transit zone, en route to a third country.',
    'Since 10 April 2026, Indian ordinary-passport holders NO LONGER need an Airport Transit Visa (ATV) for a same-airport connection to a non-Schengen destination within 24 hours, provided they stay in the international transit zone. A Schengen visa is still needed if you leave the airport, change airports, or stay overnight outside the transit area.',
    'Airside only, same-day connection (exemption); ICA-set duration if a Schengen visa is actually required',
    'No application needed for most connections since 10 April 2026; a standard Schengen visa via VFS Global if your specific itinerary requires one',
    1,
    'No processing needed for exempt connections; 15-20 working days if a Schengen visa is genuinely required',
    'VFS Global France Visa Application Centre, India (only if a visa is required)',
    'Confirm with us whether your specific layover qualifies for the April 2026 exemption\nIf exempt: no visa application needed — just travel with your confirmed onward ticket\nIf not exempt (leaving the airport, changing airports, or overnight stay): gather documents against this checklist\nBook your VFS Global appointment\nAttend in person for biometrics\nSubmission of your application\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/france.jpg',
    'Ministère de l''Europe et des Affaires étrangères (France Diplomatie), announcement on lifting airport transit visa requirements for Indian nationals', 'https://in.diplomatie.gouv.fr/en/france-lifts-airport-transit-visa-requirements-indian-nationals', '2026-09-11'
);
SET @frt6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@frt6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt6, 'Core Documents', 'Needed regardless of whether a visa is required.', 1);
SET @ft6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft6s1, 'Valid Passport', 'An ordinary Indian passport, valid at least 6 months beyond your travel dates.', 'original', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt6, 'Onward Journey Documents', 'Evidence of your connecting flight.', 2);
SET @ft6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft6s2, 'Confirmed Onward Ticket to Third Country', 'Departing the same French airport within 24 hours of arrival.', 'copy', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt6, 'If a Schengen Visa Is Actually Required', 'Only applies if you don''t qualify for the April 2026 exemption.', 3);
SET @ft6s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft6s3, 'Standard Schengen Visa Documents', 'If leaving the airport, changing airports, or staying overnight — see our Tourist Visa checklist for the full document set.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(118, 6, NULL, 'EUR', 'No Fee for Most Travellers', 'Most Indian ordinary-passport holders need no visa at all for a same-airport connection since 10 April 2026. Standard Schengen fees apply only if your specific itinerary requires a visa — we confirm this with you first.', '2026-09-01', NOW(), 'https://in.diplomatie.gouv.fr/en/france-lifts-airport-transit-visa-requirements-indian-nationals', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indians still need a transit visa for French airports?', 'Since 10 April 2026, most Indian ordinary-passport holders no longer need an Airport Transit Visa for a same-airport connection to a non-Schengen destination within 24 hours, as long as they stay in the international transit zone.', 118, 6, 650, 1),
('When would I still need a visa just to transit through France?', 'If you leave the airport, need to change between two airports in the same city, collect and recheck baggage, or stay overnight outside the transit area — any of these still require a standard Schengen visa.', 118, 6, 651, 1),
('Does the transit exemption mean I can enter France freely?', 'No — this is only an exemption from the airport transit visa. If you actually want to enter France or any Schengen country (leave the airport, visit the city, stay with friends), you still need a full Schengen visa.', 118, 6, 652, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen short-stay (Type C)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    118, 7, 'FRA-MED-IN-07', '2026.09', 'published',
    'Medical treatment in France, supported by hospital/clinic documentation.',
    'Handled under the standard Schengen short-stay visa framework, supported by hospital documentation — France does not operate a separate medical-visa category with its own rules.',
    'Up to 90 days within any 180-day period, or as needed for the treatment course',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    '15-20 working days after your VFS appointment (indicative) — start as early as your hospital appointment allows',
    'VFS Global France Visa Application Centre, India',
    'Confirm your treatment/hospital appointment in France and obtain supporting medical documents\nGather documents against this checklist\nBook your VFS Global appointment\nAttend in person for biometrics\nSubmission of your application and documents\nSupport responding to any additional-information request\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/france.jpg',
    'Independent visa-agency guidance for France Schengen visas used for medical treatment by Indian passport holders', 'https://www.nivabupa.com/travel-insurance-articles/france-visa-requirements-for-indian.html', '2026-09-11'
);
SET @frt7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@frt7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt7, 'Core Documents', 'Every applicant needs these.', 1);
SET @ft7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft7s1, 'Valid Passport', 'Issued within the last 10 years, valid at least 3 months beyond intended departure.', 'original', 1, 0, 1, 1),
(@ft7s1, 'Passport Photographs', 'Two recent colour photos.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt7, 'Medical Purpose Documents', 'Evidence of your treatment in France.', 2);
SET @ft7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft7s2, 'Hospital Appointment / Admission Letter', 'From the treating French hospital/clinic, with estimated treatment dates.', 'original', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt7, 'Financial & Travel Documents', 'Evidence you can fund treatment and stay.', 3);
SET @ft7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft7s3, 'Proof of Funds for Treatment', 'Cost estimate from the hospital plus proof you can cover it.', 'copy', 1, 0, 0, 1),
(@ft7s3, 'Travel Insurance', 'Minimum EUR 30,000 medical coverage across the Schengen area.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt7, 'Application Documents', 'Your formal application paperwork.', 4);
SET @ft7s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft7s4, 'Completed Schengen Visa Application Form', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt7, 'Appointment & Submission', 'Booking and attending your VFS appointment.', 5);
SET @ft7s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft7s5, 'VFS Appointment & Biometrics', NULL, 'original', 1, 0, 0, 1),
(@ft7s5, 'Visa Fee Payment Receipt', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt7, 'Final Verification', 'What happens after submission.', 6);
SET @ft7s6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft7s6, 'Passport Submission Acknowledgement', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(118, 7, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Official consular fee; VFS Global''s separate service charge is additional. Treatment costs are set by your French hospital, not by us or the consulate.', '2026-09-01', NOW(), 'https://www.nivabupa.com/travel-insurance-articles/france-visa-requirements-for-indian.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does France have a separate medical visa?', 'No — medical treatment travel is handled under the standard Schengen short-stay visa framework, supported by hospital documentation, not a distinct legal category.', 118, 7, 660, 1),
('What travel insurance do I need for medical treatment travel?', 'The same minimum EUR 30,000 Schengen-wide medical coverage required for any Schengen visa — separate from your treatment costs.', 118, 7, 661, 1),
('Does Visagiri help arrange the medical treatment itself?', 'No — we assist only with the visa application; treatment arrangements are between you and your French hospital.', 118, 7, 662, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Schengen short-stay (Type C)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    118, 8, 'FRA-CONF-IN-08', '2026.09', 'published',
    'Attending a conference, seminar, or trade fair in France.',
    'Falls under the same short-stay Schengen Type C visa as business travel. Apply early — 4-6 weeks ahead off-peak (Oct-Feb), 6-8 weeks ahead during peak season (Apr-Sep).',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    '15-20 working days after your VFS appointment (indicative)',
    'VFS Global France Visa Application Centre, India',
    'Initial consultation once your conference registration is confirmed\nObtain an invitation letter from the conference organiser describing the event, your role, and duration\nGather documents against this checklist\nBook your VFS Global appointment\nAttend in person for biometrics\nSubmission of your application and documents\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/france.jpg',
    'France-Visas official guidance and independent visa-agency sourcing for Schengen business/conference visas issued to Indian applicants', 'https://france-visas.gouv.fr/en/voyage-d-affaires', '2026-09-11'
);
SET @frt8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@frt8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt8, 'Core Documents', 'Every applicant needs these.', 1);
SET @ft8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft8s1, 'Valid Passport', 'Issued within the last 10 years, valid at least 3 months beyond intended departure.', 'original', 1, 0, 1, 1),
(@ft8s1, 'Passport Photographs', 'Two recent colour photos.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt8, 'Conference Documents', 'Evidence of the event you are attending.', 2);
SET @ft8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft8s2, 'Event Registration Confirmation', 'Dates, venue, and your role at the event.', 'copy', 1, 0, 1, 1),
(@ft8s2, 'Invitation Letter from Organiser', 'Describing the activity, purpose, duration, and location — voluntary but strongly recommended, especially with limited Schengen travel history.', 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt8, 'Financial & Travel Documents', 'Evidence you can support your trip.', 3);
SET @ft8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft8s3, 'Bank Statements', 'Last 3 months.', 'copy', 1, 0, 0, 1),
(@ft8s3, 'Travel Insurance', 'Minimum EUR 30,000 medical coverage across the Schengen area.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt8, 'Application Documents', 'Your formal application paperwork.', 4);
SET @ft8s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft8s4, 'Completed Schengen Visa Application Form', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt8, 'Appointment & Submission', 'Booking and attending your VFS appointment.', 5);
SET @ft8s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft8s5, 'VFS Appointment & Biometrics', NULL, 'original', 1, 0, 0, 1),
(@ft8s5, 'Visa Fee Payment Receipt', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt8, 'Final Verification', 'What happens after submission.', 6);
SET @ft8s6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft8s6, 'Passport Submission Acknowledgement', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(118, 8, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Official consular fee; VFS Global''s separate service charge is additional.', '2026-09-01', NOW(), 'https://france-visas.gouv.fr/en/voyage-d-affaires', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How early should I apply for a France conference visa?', 'Apply 4-6 weeks ahead during off-peak season (October-February), or 6-8 weeks ahead during peak season (April-September), given France''s high Schengen application volume.', 118, 8, 670, 1),
('Is an invitation letter mandatory for a conference visa?', 'Not always strictly mandatory, but submitting one from the organiser voluntarily can significantly strengthen your application, especially if you have limited prior Schengen travel history.', 118, 8, 671, 1),
('Why does France receive so many Schengen applications from India?', 'France receives more Schengen visa applications from India than any other Schengen country, making it the busiest Schengen consulate for Indian applicants — plan for correspondingly longer queues at peak times.', 118, 8, 672, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Schengen short-stay (Type C), sport
-- purpose code. France DOES have a genuine, distinct Sports Visa
-- category (unlike Mexico/Singapore) — stated as such.
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    118, 9, 'FRA-SPORT-IN-09', '2026.09', 'published',
    'Participating in a sporting event, tournament, or training programme in France.',
    'France genuinely operates a distinct Schengen Sports Visa purpose code for athletes and sports-related professionals — unlike some other countries, this is a real, named category, not a generic business/tourist visa used informally.',
    'Up to 90 days within any 180-day period, though often matched to the event duration',
    'Short-stay Schengen visa (Type C), sport purpose code, submitted via VFS Global with biometrics',
    1,
    '15-20 working days after your VFS appointment (indicative)',
    'VFS Global France Visa Application Centre, India',
    'Confirm your event/federation invitation and gather event details\nInitial consultation to confirm the Sports Visa category\nGather documents against this checklist\nBook your VFS Global appointment\nAttend in person for biometrics\nSubmission of your application and documents\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/france.jpg',
    'Independent visa-agency guidance for the France/Schengen Sports Visa issued to Indian applicants', 'https://total.law/fr/france-work-visas/france-sport-visa/', '2026-09-11'
);
SET @frt9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@frt9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt9, 'Core Documents', 'Every applicant needs these.', 1);
SET @ft9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft9s1, 'Valid Passport', 'Issued within the last 10 years, valid at least 3 months beyond intended departure.', 'original', 1, 0, 1, 1),
(@ft9s1, 'Passport Photographs', 'Two recent colour photos.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt9, 'Sporting Event Documents', 'Evidence of the event you are attending.', 2);
SET @ft9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft9s2, 'Federation/Event Invitation Letter', 'From your resident-country athletic association or the France-based host, including their name, address, and contact details.', 'original', 1, 0, 1, 1),
(@ft9s2, 'Event Schedule & Details', 'Dates, venue, and nature of the event.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt9, 'Financial & Travel Documents', 'Evidence you can support your trip.', 3);
SET @ft9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft9s3, 'Bank Statements', 'Last 3 months.', 'copy', 1, 0, 0, 1),
(@ft9s3, 'Travel Insurance', 'Minimum EUR 30,000 medical coverage across the Schengen area.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt9, 'Application Documents', 'Your formal application paperwork.', 4);
SET @ft9s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft9s4, 'Completed Schengen Visa Application Form', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt9, 'Appointment & Submission', 'Booking and attending your VFS appointment.', 5);
SET @ft9s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft9s5, 'VFS Appointment & Biometrics', NULL, 'original', 1, 0, 0, 1),
(@ft9s5, 'Visa Fee Payment Receipt', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt9, 'Final Verification', 'What happens after submission.', 6);
SET @ft9s6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft9s6, 'Passport Submission Acknowledgement', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(118, 9, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Official consular fee; VFS Global''s separate service charge is additional.', '2026-09-01', NOW(), 'https://total.law/fr/france-work-visas/france-sport-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does France have a real Sports Visa category?', 'Yes — unlike some countries, France genuinely operates a distinct Schengen Sports Visa purpose code for athletes and sports-related professionals attending events or training programmes.', 118, 9, 680, 1),
('What letter do I need from my sports federation?', 'A letter from your resident-country athletic association (or your France-based host), including their name, complete address, and contact information, describing the nature and purpose of your trip.', 118, 9, 681, 1),
('How long can a Sports Visa last?', 'Up to 90 days within a 180-day period, though the validity granted is often matched more tightly to the actual duration of the event you''re attending.', 118, 9, 682, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family reunification (long-stay)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    118, 10, 'FRA-DEP-IN-10', '2026.09', 'published',
    'Joining a spouse or family member who is legally resident in France, via family reunification.',
    'The French-resident sponsor must have resided legally in France for at least 18 months and show stable income meeting a threshold that scales with family size (roughly EUR 1,823-2,187/month gross), plus adequately-sized housing.',
    'Tied to the sponsor''s residence status; decision within 6 months of a complete file',
    'Family reunification long-stay visa — sponsor applies through OFII and the local prefecture after 18+ months of French residency',
    1,
    'Decision within 6 months of OFII receiving the complete file (indicative)',
    'OFII (Office Français de l''Immigration et de l''Intégration) / VFS Global France Visa Application Centre',
    'Confirm the sponsor has resided in France for at least 18 months and meets the income/housing thresholds\nSponsor files the family reunification request with OFII and the local prefecture\nGather documents against this checklist, including apostilled relationship certificates\nBook your VFS Global appointment once the reunification request is approved\nAttend in person for biometrics\nSubmission of your long-stay visa application\nCollect your passport from VFS once approved\nRegister with OFII after arrival in France',
    '/assets/images/visa-heroes/france.jpg',
    'Service-Public.gouv.fr official guidance on family reunification, applied to Indian applicants', 'https://www.service-public.gouv.fr/particuliers/vosdroits/F35158?lang=en', '2026-09-11'
);
SET @frt10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@frt10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt10, 'Core Documents', 'Every applicant needs these.', 1);
SET @ft10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft10s1, 'Valid Passport', 'Valid well beyond your intended stay.', 'original', 1, 0, 1, 1),
(@ft10s1, 'Passport Photographs', 'Two recent colour photos.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt10, 'Family Relationship Documents', 'Proof of your relationship to the sponsor.', 2);
SET @ft10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft10s2, 'Apostilled Marriage Certificate', 'For a spouse applicant, with certified French translation.', 'original', 0, 1, 1, 1),
(@ft10s2, 'Apostilled Birth Certificate', 'For a dependent child applicant, with certified French translation.', 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt10, 'Sponsor''s Documents', 'Proof the French resident meets the reunification thresholds.', 3);
SET @ft10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft10s3, 'Sponsor''s Residence Card or French Passport', NULL, 'copy', 1, 0, 0, 1),
(@ft10s3, 'Sponsor''s Income & Housing Proof', '12 months of payslips, employment letter, tax return, bank statements, and proof of adequately-sized accommodation.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt10, 'Additional Documents', 'Further requirements for adult applicants.', 4);
SET @ft10s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft10s4, 'Police Clearance Certificate (PCC) from India', 'Required for adult applicants.', 'original', 1, 0, 0, 1),
(@ft10s4, 'Health Insurance', 'Valid in France for at least the first year.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt10, 'Application Documents', 'Your formal application paperwork.', 5);
SET @ft10s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft10s5, 'Completed Family Reunification Visa Form', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt10, 'Appointment & Submission', 'Booking and attending your VFS appointment.', 6);
SET @ft10s6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft10s6, 'VFS Appointment & Biometrics', NULL, 'original', 1, 0, 0, 1),
(@ft10s6, 'Visa Fee Payment Receipt', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@frt10, 'Final Verification', 'What happens after submission and arrival.', 7);
SET @ft10s7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ft10s7, 'Passport Submission Acknowledgement', NULL, 'original', 1, 0, 0, 1),
(@ft10s7, 'Post-Arrival OFII Registration Instructions', 'Required after arrival in France.', 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(118, 10, NULL, 'EUR', 'Confirmed After Assessment', 'Long-stay family reunification visa fees plus OFII registration taxes apply — we confirm the current total before you apply.', '2026-09-01', NOW(), 'https://www.service-public.gouv.fr/particuliers/vosdroits/F35158?lang=en', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How long must my family member live in France before sponsoring me?', 'At least 18 months of legal residence in France is required before they can sponsor a spouse or child for family reunification.', 118, 10, 690, 1),
('What income does the sponsor need?', 'A threshold that scales with family size — roughly EUR 1,823/month gross for a household of 2-3 people, rising to around EUR 2,187/month for 6 or more — confirmed against current rates before applying.', 118, 10, 691, 1),
('Do marriage and birth certificates need special preparation?', 'Yes — they must be apostilled and accompanied by a certified French translation to be accepted.', 118, 10, 692, 1);
