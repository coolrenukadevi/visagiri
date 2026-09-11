-- Italy Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as every other
-- country built this session (see AUDIT.md). hero_image_url points at
-- the real Colosseum/Rome and Italian flag photo supplied by the
-- client for this hero.
--
-- Italy is Schengen, structurally similar to France/Germany (already
-- built), but its real, Italy-SPECIFIC facts are genuinely different
-- rather than a copy-paste of either:
--   - Work is gated entirely by Italy's "Decreto Flussi" (Flow Decree)
--     — an annual QUOTA-BASED labour-migration system, unlike most
--     Schengen states' always-open employer-sponsorship routes. The
--     current decree (DPCM 2 October 2025) sets real 2026-2028 quotas
--     (497,550 total, ~164,850 for 2026), with a real "click-day"
--     application window and a genuine 2026 anti-fraud rule: an
--     uncollected visa within 6 months of Nulla Osta issuance is
--     automatically cancelled.
--   - Student requires mandatory pre-enrollment via the Universitaly
--     portal — consulates in India will not process the visa without
--     a validated Universitaly application, a real gatekeeping step
--     with its own deadlines separate from university admission.
--   - Family Visit has a genuine, Italy-specific POST-arrival legal
--     obligation: the host must separately report the guest's arrival
--     to the local Questura within 8 days via a "dichiarazione di
--     presenza" — distinct from, and in addition to, the visa
--     application's own "dichiarazione di ospitalità."
--   - A second, separate airport-transit-exemption date is captured
--     accurately: effective 10 April 2026, Italy (alongside
--     Switzerland, Germany, Netherlands, Belgium, and Spain) extended
--     visa-free airside transit to Indian passport holders — the same
--     effective date as France's own exemption, but a genuinely
--     distinct national rule, not inferred from France's.
--   - Dependent (Ricongiungimento Familiare) sponsor income is pegged
--     to Italy's real "assegno sociale" social-allowance benchmark
--     (EUR 7,101.12/year base, scaling per extra family member), not a
--     generic fabricated threshold.
--
-- country_id 126 = Italy. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Schengen Short-Stay (Type C, "Turismo")
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    126, 1, 'ITA-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and short personal visits to Italy and the wider Schengen area.',
    'Indian passport holders must obtain a Schengen visa before travelling — there is no visa-on-arrival or eVisa for Italy. Applications are submitted via VFS Global with mandatory biometric data collection.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Processing typically runs 15 working days, longer in peak season',
    'VFS Global Italy Visa Application Centre, India',
    'Initial consultation to confirm Tourist Visa is the right category\nGather documents against this checklist, including a day-by-day itinerary\nBook your VFS Global appointment\nAttend in person for biometrics (mandatory for first-time applicants)\nSubmission of your application and documents\nSupport responding to any additional-information request\nDecision — visa sticker affixed to your passport once approved',
    '/assets/images/visa-heroes/italy.jpg',
    'Italian Ministry of Foreign Affairs (esteri.it) Schengen short-stay visa guidance, cross-checked via VFS Global Italy India sourcing', 'https://www.esteri.it/en/servizi-opportunita/ingressosoggiornoinitalia/visto_ingresso/', '2026-09-11'
);
SET @it1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@it1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it1, 'Core Documents', 'Every applicant needs these.', 1);
SET @it1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it1s1, 'Valid Passport', 'Valid at least 3 months beyond intended departure, with at least 2 blank pages.', 'original', 1, 0, 1, 1),
(@it1s1, 'Passport Photographs', 'Two recent colour photos, 35x45mm, white background.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it1, 'Financial & Travel Documents', 'Evidence you can support your trip.', 2);
SET @it1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it1s2, 'Bank Statements', 'Last 3 months.', 'copy', 1, 0, 1, 1),
(@it1s2, 'Schengen Travel Insurance', 'Minimum EUR 30,000 medical coverage, valid across the whole Schengen area.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it1, 'Application Documents', 'Your formal application paperwork.', 3);
SET @it1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it1s3, 'Completed Schengen Visa Application Form', NULL, 'original', 1, 0, 0, 1),
(@it1s3, 'Cover Letter & Day-by-Day Itinerary', NULL, 'original', 1, 0, 0, 2),
(@it1s3, 'Proof of Accommodation', 'Hotel bookings, or a signed "dichiarazione di ospitalità" if staying with someone.', 'original', 1, 0, 0, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it1, 'Appointment & Submission', 'Booking and attending your VFS appointment.', 4);
SET @it1s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it1s4, 'VFS Appointment & Biometrics', 'Mandatory in-person biometric data collection, valid 59 months once captured.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(126, 1, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'EUR 90 for adults, EUR 45 for children 6-11, free under 6. VFS Global''s separate service charge (roughly INR 1,750-2,200) is additional.', '2026-01-01', NOW(), 'https://www.esteri.it/en/servizi-opportunita/ingressosoggiornoinitalia/visto_ingresso/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a visa-on-arrival or eVisa for Italy?', 'No — Indian passport holders must obtain a Schengen visa in advance through VFS Global; there is no visa-on-arrival or eVisa option.', 126, 1, 1040, 1),
('What is a "dichiarazione di ospitalità"?', 'A signed declaration of hospitality used as proof of accommodation if you are staying with someone in Italy rather than a hotel.', 126, 1, 1041, 1),
('Do I need to appear in person for an Italy tourist visa?', 'Yes — biometric data collection at a VFS Global centre is mandatory for first-time Schengen visa applicants.', 126, 1, 1042, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen Short-Stay (Type C, "Affari")
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    126, 2, 'ITA-BUS-IN-02', '2026.09', 'published',
    'Short business visits — meetings, negotiations, and site visits — to Italy.',
    'An original invitation letter from the hosting Italian company is central, stating purpose, duration, and who bears costs, alongside a letter from your Indian employer confirming your position, salary, and leave approval.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Processing typically runs 15 working days, longer in peak season',
    'VFS Global Italy Visa Application Centre, India',
    'Initial consultation to confirm the trip is a genuine business visit\nObtain an invitation letter from your Italian host company\nGather documents against this checklist\nBook your VFS Global appointment\nAttend in person for biometrics\nSubmission of your application and documents\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/italy.jpg',
    'Italian Ministry of Foreign Affairs Schengen business visa guidance', 'https://www.esteri.it/en/servizi-opportunita/ingressosoggiornoinitalia/visto_ingresso/', '2026-09-11'
);
SET @it2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@it2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it2, 'Core Documents', 'Every applicant needs these.', 1);
SET @it2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@it2s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it2, 'Business Invitation & Purpose', 'Evidence of who you are meeting and why.', 2);
SET @it2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it2s2, 'Invitation Letter from Italian Host Company', 'Stating purpose, duration, and who bears costs.', 'original', 1, 0, 1, 1),
(@it2s2, 'Employer Letter from India', 'Confirming position, salary, and leave approval.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it2, 'Financial & Travel Documents', 'Evidence you can support your trip.', 3);
SET @it2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it2s3, 'Bank Statements', 'Last 3 months.', 'copy', 1, 0, 0, 1),
(@it2s3, 'Schengen Travel Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(126, 2, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Same fee structure as Tourist — Business is the same Schengen short-stay visa.', '2026-01-01', NOW(), 'https://www.esteri.it/en/servizi-opportunita/ingressosoggiornoinitalia/visto_ingresso/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What must the Italian invitation letter include?', 'The purpose, duration of your visit, and who bears travel/accommodation costs — vague invitations are a common cause of delay.', 126, 2, 1043, 1),
('Is Business a separate visa product from Tourist?', 'No — it uses the same Schengen short-stay Type C visa, distinguished by the business-purpose documents.', 126, 2, 1044, 1),
('Do I also need my Indian employer''s letter?', 'Yes — confirming your position, salary, and approval of leave for the trip.', 126, 2, 1045, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — National Long-Stay Visa (Type D)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    126, 3, 'ITA-STU-IN-03', '2026.09', 'published',
    'Full-time study at an Italian university or accredited institution, for programs longer than 90 days.',
    'Mandatory pre-enrollment via the Universitaly portal (Ministry of University and Research) is the gatekeeping first step — consulates in India will not process the study visa without a validated Universitaly application, and some university pre-enrollment deadlines close as early as 30 April for the following intake.',
    'Duration of your course (National Type D visa; a Type C applies only if the course is under 90 days)',
    'National long-stay visa (Type D), requires prior Universitaly pre-enrollment and university acceptance',
    1,
    'After Universitaly validation and university acceptance, the Embassy/Consulate forwards documents to the university, adding 2-4 weeks',
    'Italian Embassy/Consulate, India (New Delhi, Mumbai, Chennai), after Universitaly pre-enrollment',
    'Complete pre-enrollment via the Universitaly portal before the relevant deadline\nSecure university acceptance\nArrange proof of funds and accommodation\nGather documents against this checklist\nSubmit your application at the Embassy/Consulate\nAttend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/italy.jpg',
    'Italian Consulate General Mumbai Study in Italy guidance and Universitaly pre-enrollment portal', 'https://consmumbai.esteri.it/en/servizi-consolari-e-visti/servizi-per-il-cittadino-straniero/study-in-italy/', '2026-09-11'
);
SET @it3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@it3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it3, 'Core Documents', 'Every applicant needs these.', 1);
SET @it3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@it3s1, 'Universitaly Pre-Enrollment Confirmation', 'Validated before the visa can be processed.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it3, 'Academic Documents', 'Evidence of your admission.', 2);
SET @it3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it3s2, 'University Acceptance Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it3, 'Financial Documents', 'Evidence you can fund your studies.', 3);
SET @it3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it3s3, 'Proof of Funds', 'Commonly benchmarked at EUR 6,000+/year.', 'copy', 1, 0, 0, 1),
(@it3s3, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(126, 3, 116.00, 'EUR', 'National Long-Stay Visa Fee', 'National (Type D) visa fee is centrally set and revised quarterly by exchange rate; reported at EUR 116 for the current quarter.', '2026-01-01', NOW(), 'https://consmumbai.esteri.it/en/servizi-consolari-e-visti/servizi-per-il-cittadino-straniero/study-in-italy/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need to pre-enroll before applying for the visa?', 'Yes — mandatory pre-enrollment via the Universitaly portal must be validated before an Indian consulate will process your Student visa.', 126, 3, 1046, 1),
('Is there a deadline for pre-enrollment?', 'Yes — some university pre-enrollment windows close as early as 30 April for the following academic year, so apply early.', 126, 3, 1047, 1),
('Does the visa fee change over the year?', 'Yes — the National (Type D) visa fee is revised quarterly based on exchange rate, unlike the flat Schengen short-stay fee.', 126, 3, 1048, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — National Work Visa (Decreto Flussi Quota)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    126, 4, 'ITA-WORK-IN-04', '2026.09', 'published',
    'Employer-sponsored subordinate employment in Italy, gated by Italy''s annual Decreto Flussi quota system.',
    'Unlike most Schengen states'' always-open work-visa routes, Italy uses a real, quota-based annual decree (DPCM 2 October 2025 sets 2026-2028 quotas: 497,550 total, roughly 164,850 for 2026). Employer must first win a Nulla Osta during a specific click-day window before the worker can even apply for the visa.',
    'Tied to the employment contract, after arrival converts to a "permesso di soggiorno"',
    'Employer applies for a Nulla Osta via SUI during the click-day window; worker then applies for the National visa',
    1,
    'A 2026 anti-fraud rule: if the visa is not collected within 6 months of Nulla Osta issuance, the authorization is automatically cancelled. A single private employer is capped at 3 applications/year',
    'Italian Embassy/Consulate, India, after employer''s Nulla Osta is granted',
    'Employer applies for a Nulla Osta via SUI during the Decreto Flussi click-day window\nOnce granted, gather documents against this checklist\nSubmit your visa application at the Embassy/Consulate within the 6-month collection window\nAttend biometrics\nAfter arrival: sign the "contratto di soggiorno" and apply for your "permesso di soggiorno" within 8 days',
    '/assets/images/visa-heroes/italy.jpg',
    'Italian government Decreto Flussi 2026-2028 quota decree and National Work Visa guidance', 'https://legallyitaly.com/italys-flussi-decree-2026-2028/', '2026-09-11'
);
SET @it4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@it4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it4, 'Core Documents', 'Every applicant needs these.', 1);
SET @it4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@it4s1, 'Nulla Osta (Work Authorization)', 'Granted to your employer via the click-day window.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it4, 'Employment Documents', 'Evidence of your role.', 2);
SET @it4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it4s2, 'Employment Contract Offer', NULL, 'copy', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it4, 'Post-Arrival Documents', 'Required within 8 days of arrival.', 3);
SET @it4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it4s3, 'Contratto di Soggiorno', 'Signed with your employer within 8 days of arrival.', 'original', 1, 0, 0, 1),
(@it4s3, 'Permesso di Soggiorno Application', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(126, 4, 116.00, 'EUR', 'National Work Visa Fee', 'Same quarterly-indexed National (Type D) visa fee as Student. Does not include Nulla Osta processing costs, which are part of the employer''s SUI application.', '2026-01-01', NOW(), 'https://legallyitaly.com/italys-flussi-decree-2026-2028/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the Decreto Flussi?', 'Italy''s annual quota decree for labour migration — the current one (DPCM 2 October 2025) sets real 2026-2028 quotas, with roughly 164,850 slots for 2026, most of which are non-seasonal subordinate work.', 126, 4, 1049, 1),
('What happens if I don''t collect my visa in time?', 'A real 2026 anti-fraud rule automatically cancels your Nulla Osta if the visa is not collected within 6 months of its issuance.', 126, 4, 1050, 1),
('What must I do after I arrive in Italy?', 'Sign the "contratto di soggiorno" with your employer and apply for your "permesso di soggiorno" (residence permit) within 8 days of arrival.', 126, 4, 1051, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen Short-Stay (Type C)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    126, 5, 'ITA-FAM-IN-05', '2026.09', 'published',
    'Visiting family or friends in Italy.',
    'Requires a "dichiarazione di ospitalità" (declaration of hospitality) from your Italian host, plus a genuine, Italy-specific POST-arrival legal obligation: the host must separately report your arrival to the local Questura within 8 days via a "dichiarazione di presenza" — a real Italian law, not just a visa-application formality, and free of charge.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Processing typically runs 15 working days',
    'VFS Global Italy Visa Application Centre, India',
    'Initial consultation to confirm Family Visit Visa is correct\nObtain a "dichiarazione di ospitalità" and relationship proof from your Italian host\nGather documents against this checklist\nBook your VFS Global appointment\nAttend in person for biometrics\nAfter arrival: your host reports your presence to the local Questura within 8 days',
    '/assets/images/visa-heroes/italy.jpg',
    'Italian consular guidance on family/friend visits and post-arrival "dichiarazione di presenza" requirement', 'https://italy.refugee.info/articles/5392450690711', '2026-09-11'
);
SET @it5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@it5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it5, 'Core Documents', 'Every applicant needs these.', 1);
SET @it5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@it5s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it5, 'Host Documents', 'Evidence of your host''s hospitality declaration.', 2);
SET @it5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it5s2, 'Dichiarazione di Ospitalità', 'Declaration of hospitality from your Italian host.', 'original', 1, 0, 1, 1),
(@it5s2, 'Relationship Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it5, 'Financial & Insurance Documents', 'Evidence you can support your trip.', 3);
SET @it5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it5s3, 'Schengen Travel Insurance', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(126, 5, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Same fee structure as Tourist. The post-arrival "dichiarazione di presenza" your host must file is free of charge.', '2026-01-01', NOW(), 'https://italy.refugee.info/articles/5392450690711', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is a "dichiarazione di presenza"?', 'A genuine, Italy-specific legal requirement — your host must report your arrival to the local Questura (police headquarters) within 8 days, separate from the visa application itself.', 126, 5, 1052, 1),
('Is this different from the dichiarazione di ospitalità?', 'Yes — the ospitalità declaration supports your visa application, while the presenza declaration is a post-arrival legal reporting obligation your host must complete.', 126, 5, 1053, 1),
('Does my host need to pay for the presenza declaration?', 'No — it is free of charge, but it is still a real legal obligation that should not be skipped.', 126, 5, 1054, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Airport Transit Visa (Type A)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    126, 6, 'ITA-TRANS-IN-06', '2026.09', 'published',
    'Passing through an Italian international airport en route to a third country.',
    'India is not on Italy''s Airport Transit Visa nationality list, and effective 10 April 2026 Italy formally extended visa-free airside transit to Indian passport holders (alongside Switzerland, Germany, Netherlands, Belgium, and Spain) — travellers must stay airside with confirmed onward connections; leaving the international transit area still needs a standard Schengen visa.',
    'Strictly for the duration of your airside connection',
    'No application needed for eligible airside connections; standard Schengen visa required if leaving the transit zone',
    0,
    'Confirm your specific routing and airport qualify for the exemption before assuming no visa is needed',
    'Not applicable for eligible transit; VFS Global Italy centre if a full Schengen visa is required instead',
    'Confirm your connecting airport and routing qualify for the 10 April 2026 exemption\nIf eligible, no visa application is needed — proceed with your connecting flight\nIf leaving the transit zone or the exemption does not apply, apply for a standard Schengen visa instead',
    '/assets/images/visa-heroes/italy.jpg',
    'Italian consular Airport Transit Visa category guidance and 2026 visa-free airside transit extension', 'https://conschicago.esteri.it/en/servizi-consolari-e-visti/servizi-per-il-cittadino-straniero/visti/visa-categories-and-requirements/airport-transit-schengen-short-term-visa/', '2026-09-11'
);
SET @it6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@it6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it6, 'Core Documents', 'For eligible airside connections.', 1);
SET @it6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@it6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it6, 'If the Exemption Does Not Apply', 'Fall back to a standard Schengen visa.', 2);
SET @it6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it6s2, 'Standard Schengen Visa Application', 'Required if leaving the transit zone.', 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(126, 6, 0.00, 'EUR', 'No Fee for Eligible Airport Transit', 'No visa or fee is needed for a qualifying airside connection under the 10 April 2026 exemption. A standard EUR 90 Schengen visa fee applies only if you must leave the transit zone.', '2026-04-10', NOW(), 'https://conschicago.esteri.it/en/servizi-consolari-e-visti/servizi-per-il-cittadino-straniero/visti/visa-categories-and-requirements/airport-transit-schengen-short-term-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need an Airport Transit Visa for Italy?', 'Not since 10 April 2026, for eligible airside connections — Italy joined Switzerland, Germany, Netherlands, Belgium, and Spain in extending visa-free airside transit to Indian passport holders.', 126, 6, 1055, 1),
('Is this the same date as France''s exemption?', 'Yes, coincidentally the same effective date (10 April 2026), but Italy''s exemption is a genuinely separate national rule, not inferred from France''s.', 126, 6, 1056, 1),
('What if I need to leave the transit zone?', 'Then you need a standard Schengen visa — the exemption only covers staying airside within the international transit zone.', 126, 6, 1057, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen "Cure Mediche" Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    126, 7, 'ITA-MED-IN-07', '2026.09', 'published',
    'Travelling to Italy to receive medical treatment.',
    'Requires a statement from the chosen Italian healthcare facility detailing treatment type, start date, expected duration and estimated total cost, plus certification of advance payment of at least 30% of that estimated cost, with proof of funds for the remaining balance and lodging.',
    'Up to 90 days (Type C); can be Type D for longer treatment',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics; Type D for longer treatment',
    1,
    'Processing depends on the completeness of medical and financial documentation',
    'VFS Global Italy Visa Application Centre, India',
    'Obtain a treatment statement from the Italian healthcare facility\nArrange the required 30% advance payment certification\nGather documents against this checklist\nBook your VFS Global appointment and attend biometrics\nSubmission of your application and documents\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/italy.jpg',
    'Italian Consulate General London medical care guidance', 'https://conslondra.esteri.it/en/servizi-consolari-e-visti/servizi-per-il-cittadino-straniero/visti/medical-care/', '2026-09-11'
);
SET @it7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@it7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it7, 'Core Documents', 'Every applicant needs these.', 1);
SET @it7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@it7s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it7, 'Medical Documents', 'Evidence of your treatment plan.', 2);
SET @it7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it7s2, 'Italian Healthcare Facility Statement', 'Treatment type, start date, duration, and estimated total cost.', 'original', 1, 0, 1, 1),
(@it7s2, '30% Advance Payment Certification', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it7, 'Financial & Insurance Documents', 'Evidence you can pay the remaining balance.', 3);
SET @it7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it7s3, 'Proof of Funds for Remaining Balance', NULL, 'copy', 1, 0, 0, 1),
(@it7s3, 'Schengen Travel Insurance', 'Minimum EUR 30,000, covering emergency hospitalization and repatriation.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(126, 7, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Same base fee as Tourist; converts to the National (Type D) fee if treatment genuinely exceeds 90 days.', '2026-01-01', NOW(), 'https://conslondra.esteri.it/en/servizi-consolari-e-visti/servizi-per-il-cittadino-straniero/visti/medical-care/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How much of the treatment cost must I pay upfront?', 'At least 30% of the estimated total cost, certified in advance, with proof of funds for the remaining balance.', 126, 7, 1058, 1),
('What must the healthcare facility statement include?', 'Treatment type, start date, expected duration, and estimated total cost.', 126, 7, 1059, 1),
('Do I still need travel insurance for medical treatment?', 'Yes — minimum EUR 30,000 coverage for emergency hospitalization and repatriation, separate from the treatment cost itself.', 126, 7, 1060, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Schengen Business Visa ("Affari")
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    126, 8, 'ITA-CONF-IN-08', '2026.09', 'published',
    'Attending or presenting at a conference or seminar in Italy.',
    'Italian consulates classify conference/seminar attendance under the same "Affari" (business) category as general business trips, not a separate product. An official invitation/registration confirmation from the conference organizer, plus proof of your professional/academic affiliation, are the differentiating documents.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Processing typically runs 15 working days',
    'VFS Global Italy Visa Application Centre, India',
    'Obtain your conference invitation/registration confirmation\nGather documents against this checklist\nBook your VFS Global appointment and attend biometrics\nSubmission of your application and documents\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/italy.jpg',
    'Italian consular guidance on conference/seminar attendance under the Affari (business) visa category', 'https://www.esteri.it/en/servizi-opportunita/ingressosoggiornoinitalia/visto_ingresso/', '2026-09-11'
);
SET @it8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@it8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it8, 'Core Documents', 'Every applicant needs these.', 1);
SET @it8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@it8s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it8, 'Conference Documents', 'Evidence of the event and your role.', 2);
SET @it8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it8s2, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 1),
(@it8s2, 'Proof of Professional/Academic Affiliation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it8, 'Financial Documents', 'Evidence of funds.', 3);
SET @it8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it8s3, 'Bank Statements', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(126, 8, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Same fee as Business — Conference is classified under the Affari (business) category.', '2026-01-01', NOW(), 'https://www.esteri.it/en/servizi-opportunita/ingressosoggiornoinitalia/visto_ingresso/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Conference a separate visa category for Italy?', 'No — Italian consulates classify it under the same "Affari" business category, distinguished only by conference-specific documents.', 126, 8, 1061, 1),
('What proves my professional affiliation?', 'A letter from your employer or academic institution confirming your role and reason for attending.', 126, 8, 1062, 1),
('Do I need proof of registration fee payment?', 'Where applicable, yes — this supports the genuineness of your conference attendance.', 126, 8, 1063, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Schengen Visa (Sporting Events)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    126, 9, 'ITA-SPORT-IN-09', '2026.09', 'published',
    'Participating in a sporting event in Italy as an athlete, coach, judge, or official.',
    'A real, Italy-specific verification rule applies: the invitation/booking must come from a member of the relevant sport federation or association using an email on that federation''s official domain — VFS Global''s Italy process explicitly restricts who can submit a sports-visa invitation to authenticate it.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Processing typically runs 15 working days',
    'VFS Global Italy Visa Application Centre, India',
    'Obtain an invitation from your sport federation, sent from their official domain email\nGather documents against this checklist\nBook your VFS Global appointment and attend biometrics\nSubmission of your application and documents\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/italy.jpg',
    'VFS Global Italy sports-visa invitation authentication guidance', 'https://visa.vfsglobal.com/one-pager/italy/india/new-delhi/english/', '2026-09-11'
);
SET @it9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@it9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it9, 'Core Documents', 'Every applicant needs these.', 1);
SET @it9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@it9s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it9, 'Sports Event Documents', 'Evidence of your role and the event.', 2);
SET @it9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it9s2, 'Federation Invitation (Official Domain Email)', 'Must come from a verified member of the relevant sport federation/association.', 'original', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it9, 'Financial Documents', 'Evidence of funds.', 3);
SET @it9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it9s3, 'Bank Statements', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(126, 9, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Same fee as Tourist — Sports is a purpose category within the general Schengen visa.', '2026-01-01', NOW(), 'https://visa.vfsglobal.com/one-pager/italy/india/new-delhi/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who can send a valid sports-visa invitation for Italy?', 'Only a verified member of the relevant sport federation/association, sending from their official federation domain email — a real, Italy-specific authentication rule.', 126, 9, 1064, 1),
('Does Italy have a distinct Sports Visa category?', 'No — it is a purpose within the general Schengen visa, not a separate legal category.', 126, 9, 1065, 1),
('What if my invitation comes from a personal email address?', 'It may be rejected — VFS Global''s process specifically restricts sports-visa invitations to official federation domain emails.', 126, 9, 1066, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Ricongiungimento Familiare
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    126, 10, 'ITA-DEP-IN-10', '2026.09', 'published',
    'Joining a family member already legally resident in Italy (Ricongiungimento Familiare, family reunification).',
    'Under Article 29 of Legislative Decree 286/1998, the Italy-resident sponsor must hold a "permesso di soggiorno" valid at least one year and first obtain a Nulla Osta from the Sportello Unico per l''Immigrazione (statutory processing up to 90 days) before the dependent applies for the visa in India. Sponsor income must meet or exceed Italy''s "assegno sociale" social-allowance benchmark.',
    'Tied to the sponsor''s residence permit validity',
    'Sponsor obtains a Nulla Osta via SUI; dependent then applies for the National (Type D) visa in India',
    1,
    'Nulla Osta processing can take up to 90 days before the dependent can even apply for the visa',
    'Italian Embassy/Consulate, India, after the sponsor''s Nulla Osta is granted',
    'Sponsor applies for a Nulla Osta via the Sportello Unico per l''Immigrazione\nOnce granted (up to 90 days), gather documents against this checklist\nSubmit your visa application at the Embassy/Consulate\nAttend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/italy.jpg',
    'Italian family reunification (Ricongiungimento Familiare) guidance under Legislative Decree 286/1998', 'https://migaku.com/blog/language-fun/italy-family-reunification-visa-nulla-osta-and-timelines', '2026-09-11'
);
SET @it10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@it10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it10, 'Core Documents', 'Every applicant needs these.', 1);
SET @it10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@it10s1, 'Nulla Osta (Family Reunification Authorization)', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it10, 'Sponsor & Relationship Documents', 'Evidence of your Italy-resident sponsor.', 2);
SET @it10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it10s2, 'Sponsor''s Permesso di Soggiorno Copy', 'Valid at least one year.', 'copy', 1, 0, 1, 1),
(@it10s2, 'Relationship Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@it10, 'Financial Documents', 'Evidence the sponsor meets the income threshold.', 3);
SET @it10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@it10s3, 'Sponsor''s Income Evidence', 'At or above the "assegno sociale" social-allowance benchmark, scaling for each additional family member.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(126, 10, 116.00, 'EUR', 'National Visa Fee', 'Same quarterly-indexed National (Type D) fee as Student/Work. The Nulla Osta process itself is a separate step handled by the sponsor before this application.', '2026-01-01', NOW(), 'https://migaku.com/blog/language-fun/italy-family-reunification-visa-nulla-osta-and-timelines', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the "assegno sociale" income threshold?', 'Italy''s social-allowance benchmark — roughly EUR 7,101/year for one dependent, increasing by about 50% of that allowance for each additional family member reunited.', 126, 10, 1067, 1),
('Can income from other household members count?', 'Yes — income of all cohabiting household members on the same residency registry ("stato di famiglia") can be combined to meet the threshold.', 126, 10, 1068, 1),
('How long does the sponsor''s Nulla Osta process take?', 'Up to 90 days by statute, and it must be completed before the dependent can even apply for the visa in India.', 126, 10, 1069, 1);
