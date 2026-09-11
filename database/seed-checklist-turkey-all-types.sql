-- Turkey Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as every other
-- country built this session (see AUDIT.md). hero_image_url points at
-- the real Istanbul Blue Mosque photo supplied by the client for this
-- hero.
--
-- IMPORTANT SOURCING CAVEAT: official primary sources (evisa.gov.tr,
-- mfa.gov.tr, goturkiye.com, visa.vfsglobal.com) were not directly
-- fetchable in this session's research pass (network egress blocked
-- every .gov.tr and vfsglobal.com domain) — findings were triangulated
-- from web-search-indexed content across a wide set of independent
-- visa-consultancy and immigration-law sources. Fee figures especially
-- conflicted between sources and should be re-verified against
-- evisa.gov.tr/mfa.gov.tr before being treated as final; several are
-- deliberately marked "Confirmed After Assessment" below rather than
-- guessed.
--
-- Turkey's real, distinctive facts:
--   - A genuinely conditional e-Visa eligibility rule: Indian citizens
--     only qualify for Turkey's e-Visa (evisa.gov.tr) if they already
--     hold a valid Schengen, US, UK, or Ireland visa or residence
--     permit — without one of those, a full sticker visa via the
--     consulate/VFS is required instead, a genuinely different
--     starting point from most e-Visa systems already built this
--     session.
--   - Turkey runs its own, fully independent 90-days-in-180-days
--     stay rule — despite bordering the EU, time spent in Turkey does
--     NOT count against (or get counted by) a traveller's Schengen
--     clock, and Turkey is not in the EU or Schengen Area at all
--     despite NATO membership and EU-candidate status.
--   - Work uses a genuinely distinctive combined document: Turkey's
--     work permit (çalışma izni) doubles as the residence permit for
--     its full validity, so no separate residence-permit application
--     is needed on top of it — unlike most countries built this
--     session, which require two separate documents.
--   - A real, dated (2025) biometrics mandate specifically targets
--     Work and Student visa applicants — in-person fingerprinting,
--     applications via agents/representatives no longer accepted —
--     layered on top of the general sticker-visa biometrics rule.
--   - Dependent (family reunification) explicitly EXCLUDES parents,
--     siblings, and grandparents — only a spouse and dependent/minor
--     children of a Turkish citizen or valid permit-holder qualify, a
--     genuinely narrower definition than several other countries.
--   - Transit is NOT a general-purpose stand-alone visa: most
--     travellers who stay airside need nothing at all, and those who
--     must leave the terminal apply for a full tourist visa instead —
--     the one narrow exception is a real, dated (April 2025) e-ATV
--     specifically for transit onward to Mexico, Venezuela, Colombia,
--     or Panama.
--
-- country_id 100 = Turkey. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — e-Visa (conditional) or Sticker Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    100, 1, 'TUR-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and visiting friends/family informally in Turkey.',
    'Open to all Indian ordinary-passport holders. The e-Visa route requires the applicant to already hold a valid Schengen, US, UK, or Ireland visa or residence permit; without one, a sticker visa from the consulate/VFS is required instead.',
    'Up to 90 days within any 180-day period, independent of the Schengen 90/180 clock',
    'e-Visa online (evisa.gov.tr) if eligible via an existing Schengen/US/UK/Ireland visa, otherwise sticker visa via VFS Global on behalf of the consulate',
    0,
    'e-Visa typically approved within 24-72 hours; sticker visa usually takes 10-15 working days',
    'Turkish Embassy, New Delhi or Consulate, Mumbai/Hyderabad, via VFS Global centres across India',
    'Check whether you hold a valid Schengen/US/UK/Ireland visa or residence permit to confirm e-Visa eligibility\nGather documents against this checklist\nApply online via evisa.gov.tr, or book a VFS Global appointment for the sticker visa route\nAttend biometrics at VFS if applying for the sticker visa\nReceive your e-Visa by email or collect your passport with the sticker visa affixed',
    '/assets/images/visa-heroes/turkey.jpg',
    'Cross-checked visa-consultancy and immigration-advisory sourcing (BTW Visas, Teleport, Atlys, Y-Axis) triangulated against evisa.gov.tr/mfa.gov.tr guidance not directly fetchable this session', 'https://www.evisa.gov.tr/en/', '2026-09-11'
);
SET @tr1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tr1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr1, 'Core Documents', 'Every traveller needs these.', 1);
SET @tr1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr1s1, 'Valid Passport', 'Valid at least 6 months, with blank pages.', 'original', 1, 0, 1, 1),
(@tr1s1, 'Passport-Size Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr1, 'Travel & Accommodation Documents', 'Confirming your trip plan.', 2);
SET @tr1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr1s2, 'Confirmed Round-Trip Flight Tickets', NULL, 'copy', 1, 0, 1, 1),
(@tr1s2, 'Hotel/Accommodation Booking', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr1, 'e-Visa Eligibility & Financial Documents', 'Only relevant for the sticker-visa route.', 3);
SET @tr1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr1s3, 'Existing Valid Schengen/US/UK/Ireland Visa or Residence Permit', 'Required to qualify for the e-Visa route.', 'copy', 0, 1, 0, 1),
(@tr1s3, 'Bank Statements (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 2),
(@tr1s3, 'Travel/Medical Insurance Certificate', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(100, 1, 43.00, 'USD', 'e-Visa Fee (Indicative)', 'Most 2026 secondary sources cite approximately USD 43 for the e-Visa; the sticker-visa route via VFS carries a separately quoted service charge. Not independently confirmed against evisa.gov.tr directly this session — verify before relying on this figure.', '2026-09-01', NOW(), 'https://www.evisa.gov.tr/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can every Indian traveller apply for Turkey''s e-Visa?', 'No — the e-Visa route requires you to already hold a valid Schengen, US, UK, or Ireland visa or residence permit. Without one, you must apply for a sticker visa via the consulate/VFS instead.', 100, 1, 1300, 1),
('Does time in Turkey count against my Schengen 90/180 day limit?', 'No. Turkey runs its own, fully separate 90-days-in-180-days rule — time spent there is never counted against your Schengen clock.', 100, 1, 1301, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    100, 2, 'TUR-BUS-IN-02', '2026.09', 'published',
    'Business meetings, negotiations, and trade-fair attendance in Turkey (not employment).',
    'Requires proof of business purpose such as an invitation from a Turkish company or an employer letter. Same Schengen/US/UK/Ireland-visa eligibility rule as Tourist applies for the e-Visa route; a multiple-entry sticker business visa is available via the consulate for longer-validity needs.',
    'Up to 90 days within any 180-day period; single-entry typical for e-Visa, multiple-entry available via sticker visa',
    'e-Visa (business purpose) if eligible, or embassy/VFS sticker visa for multiple-entry or longer-validity needs',
    0,
    'e-Visa typically approved within 24-72 hours; sticker visa usually takes 10-15 working days',
    'Turkish Embassy, New Delhi or Consulate, Mumbai/Hyderabad, via VFS Global centres across India',
    'Secure an invitation letter from your Turkish host company\nGather documents against this checklist\nApply online via evisa.gov.tr if eligible, or book a VFS Global appointment for the sticker visa\nAttend biometrics at VFS if applying for the sticker visa\nReceive your visa',
    '/assets/images/visa-heroes/turkey.jpg',
    'Cross-checked visa-consultancy sourcing (BTW Visas, Teleport) triangulated against official guidance not directly fetchable this session', 'https://www.evisa.gov.tr/en/', '2026-09-11'
);
SET @tr2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tr2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr2, 'Core Documents', 'Every applicant needs these.', 1);
SET @tr2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr2s1, 'Valid Passport', 'Valid at least 6 months.', 'original', 1, 0, 1, 1),
(@tr2s1, 'Passport-Size Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr2, 'Business Invitation Documents', 'Evidence of your Turkish host and travel plan.', 2);
SET @tr2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr2s2, 'Confirmed Round-Trip Flight Tickets', NULL, 'copy', 1, 0, 1, 1),
(@tr2s2, 'Hotel Booking', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr2, 'Sponsorship & Financial Documents', 'Evidence of the business relationship.', 3);
SET @tr2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr2s3, 'Invitation Letter from Turkish Host Company', 'Should include company registration/tax details.', 'original', 1, 0, 0, 1),
(@tr2s3, 'Employer Authorization/Sponsorship Letter', NULL, 'original', 1, 0, 0, 2),
(@tr2s3, 'Bank Statements', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(100, 2, NULL, 'USD', 'Confirmed After Assessment', 'Business e-Visa/sticker-visa fees varied significantly between sources this session (from roughly USD 43 up to reported figures over USD 80 with service charges) — contact us to confirm the exact current figure for your specific entry type.', '2026-09-01', NOW(), 'https://www.evisa.gov.tr/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What does a Turkish company invitation letter need to include?', 'Company registration and tax details, along with the purpose and duration of your visit — this strengthens your business visa application.', 100, 2, 1302, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Öğrenci Vizesi
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    100, 3, 'TUR-STU-IN-03', '2026.09', 'published',
    'Enrollment in a Turkish university, school, or language course.',
    'Requires a confirmed admission/acceptance letter from a Turkish institution. Not available via e-Visa — required whenever the stay exceeds 90 days or involves a degree programme.',
    'Initial entry visa is short-validity; the study period itself is covered by a Student Residence Permit, valid 1 year and renewable',
    'Sticker visa via the Turkish Embassy/Consulate/VFS, followed by a Student Residence Permit application within 30 days of arrival in Turkey',
    1,
    'General sticker-visa timelines of 10-15 working days likely apply, though document verification for student visas can extend this',
    'Turkish Embassy, New Delhi or Consulate, Mumbai/Hyderabad',
    'Secure your university acceptance letter\nGather documents against this checklist\nApply online and book a consulate/VFS appointment\nAttend in person for biometrics — agents/representatives are not accepted for student visa applications\nReceive your entry visa and travel to Turkey\nApply for your Student Residence Permit at the Directorate General of Migration Management within 30 days of arrival',
    '/assets/images/visa-heroes/turkey.jpg',
    'Cross-checked study-abroad consultancy sourcing (Metaapply, Studee) and a 2025-dated biometrics-mandate report triangulated against official guidance not directly fetchable this session', 'https://www.mfa.gov.tr/', '2026-09-11'
);
SET @tr3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tr3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr3, 'Core Documents', 'Every applicant needs these.', 1);
SET @tr3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@tr3s1, 'University Acceptance/Admission Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr3, 'Academic & Financial Documents', 'Verifying your study plan and means.', 2);
SET @tr3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr3s2, 'No-Objection Certificate from Current Institution', NULL, 'original', 0, 1, 0, 1),
(@tr3s2, 'Academic Transcripts', NULL, 'copy', 1, 0, 0, 2),
(@tr3s2, 'Proof of Financial Means or Scholarship', NULL, 'copy', 1, 0, 0, 3),
(@tr3s2, 'Health Insurance Valid in Turkey', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(100, 3, NULL, 'USD', 'Confirmed After Assessment', 'No specific student-visa fee figure could be independently confirmed this session — contact us for the current consulate fee schedule.', '2026-09-01', NOW(), 'https://www.mfa.gov.tr/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need to apply for anything after I arrive in Turkey?', 'Yes — you must apply for a Student Residence Permit at the Directorate General of Migration Management within 30 days of arrival, which then covers your actual study period.', 100, 3, 1303, 1),
('Can my education agent submit my biometrics for me?', 'No. As of a 2025 rule, student-visa applicants must submit biometric fingerprints in person — applications via agents or representatives are not accepted.', 100, 3, 1304, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Çalışma İzni (Work Permit)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    100, 4, 'TUR-WORK-IN-04', '2026.09', 'published',
    'Employment with a Turkish employer under Law No. 6735 on International Labour Force.',
    'Employer-sponsored. The employer generally needs a minimum paid-up capital and must employ a minimum ratio of Turkish citizens per foreign work-permit holder. The work permit itself functions as the residence permit for its full validity.',
    'Up to 1 year on first application, up to 2 years on first extension, up to 3 years on subsequent extensions with the same employer',
    'Employer files via the Ministry of Labour''s e-İzin system; applicant may need to apply concurrently at the consulate for an entry visa',
    1,
    'Two-track process — Ministry of Labour adjudicates the permit itself, alongside any consulate-level entry visa; timelines vary by case',
    'Turkish Embassy/Consulate in India for the entry visa; Ministry of Labour and Social Security, Ankara, via e-İzin for the permit itself',
    'Secure Turkish employer sponsorship and an employment contract\nEmployer initiates the work-permit application via e-İzin using an electronic signature\nApply concurrently at the Turkish consulate in India for an entry visa if required\nAttend an in-person biometrics appointment\nMinistry of Labour reviews and approves the permit\nTravel to Turkey and register your address — the permit itself covers your residence',
    '/assets/images/visa-heroes/turkey.jpg',
    'Cross-checked immigration-law advisory sourcing (Sozer Cizmeci, PILC, Employsome) triangulated against official guidance not directly fetchable this session', 'https://www.mfa.gov.tr/', '2026-09-11'
);
SET @tr4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tr4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr4, 'Core Documents', 'Every applicant needs these.', 1);
SET @tr4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@tr4s1, 'Employment Contract/Job Offer Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr4, 'Employer Sponsorship Documents', 'Evidence of your Turkish employer''s eligibility.', 2);
SET @tr4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr4s2, 'Employer Company Registration & Capital Documents', NULL, 'copy', 1, 0, 0, 1),
(@tr4s2, 'Proof of Turkish-to-Foreign Employee Ratio Compliance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr4, 'Qualification Documents', 'Verifying your professional background.', 3);
SET @tr4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr4s3, 'Educational/Professional Qualification Certificates', 'Often needs apostille and notarized Turkish translation.', 'original', 1, 0, 0, 1),
(@tr4s3, 'Curriculum Vitae', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(100, 4, NULL, 'TRY', 'Confirmed After Assessment', 'One legal-consultancy source cited roughly TRY 12,575 state fee plus a TRY 964 card fee for a permit up to 1 year — this is a secondary (law-firm) figure, not verified against the Ministry''s own schedule, so contact us to confirm the current amount.', '2026-09-01', NOW(), 'https://www.mfa.gov.tr/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate residence permit alongside my work permit?', 'No — the Turkish work permit itself functions as your residence permit for its full validity, unlike many countries that require two separate documents.', 100, 4, 1305, 1),
('Who submits the work permit application — me or my employer?', 'Your employer submits it electronically through the Ministry of Labour and Social Security''s e-İzin system using an electronic signature.', 100, 4, 1306, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    100, 5, 'TUR-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends residing in Turkey for a short period.',
    'Same general eligibility rules as Tourist — e-Visa route available if you already hold a valid Schengen/US/UK/Ireland visa or residence permit and the purpose is a short visit; otherwise a sticker visa with a host invitation is required.',
    'Up to 90 days within any 180-day period, same as Tourist',
    'e-Visa if eligible, or embassy/VFS sticker visa with a host invitation letter',
    0,
    'e-Visa typically approved within 24-72 hours; sticker visa usually takes 10-15 working days',
    'Turkish Embassy, New Delhi or Consulate, Mumbai/Hyderabad, via VFS Global centres across India',
    'Ask your host in Turkey for a notarized invitation letter\nGather documents against this checklist\nApply online via evisa.gov.tr if eligible, or book a VFS Global appointment for the sticker visa\nAttend biometrics at VFS if applying for the sticker visa\nReceive your visa',
    '/assets/images/visa-heroes/turkey.jpg',
    'Cross-checked visa-consultancy sourcing (BTW Visas, Flamingo Travels) triangulated against official guidance not directly fetchable this session', 'https://www.evisa.gov.tr/en/', '2026-09-11'
);
SET @tr5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tr5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr5, 'Core Documents', 'Every applicant needs these.', 1);
SET @tr5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@tr5s1, 'Confirmed Round-Trip Flight Tickets', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr5, 'Host Invitation Documents', 'Evidence of your relationship to your Turkish host.', 2);
SET @tr5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr5s2, 'Notarized Invitation Letter from Turkish Host', 'Must include host''s full name, Turkish ID number, address, and contact info.', 'original', 1, 0, 0, 1),
(@tr5s2, 'Copy of Host''s Turkish ID/Passport or Residence Permit', NULL, 'copy', 1, 0, 0, 2),
(@tr5s2, 'Guardianship Consent Documents', 'Required if a minor is travelling with a single parent.', 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(100, 5, NULL, 'USD', 'Confirmed After Assessment', 'Fee not distinctly differentiated from the Tourist visa fee in sources found this session — contact us to confirm the current figure.', '2026-09-01', NOW(), 'https://www.evisa.gov.tr/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What must my host''s invitation letter include?', 'Their full name, Turkish ID number, address, and contact information, along with a copy of their Turkish ID card, passport, or residence permit.', 100, 5, 1307, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    100, 6, 'TUR-TRANS-IN-06', '2026.09', 'published',
    'Passing through Istanbul Airport en route to a third country.',
    'Not needed at all if staying airside in the international transit zone with a single through-checked ticket. Needed only if changing airports, self-transferring with baggage claim, or leaving the terminal — in which case a full tourist visa is required, except for a narrow e-ATV route onward to specific countries.',
    'No defined stay for airside transit; a full tourist visa follows the standard 90/180-day rule if used instead',
    'e-ATV via evisa.gov.tr for eligible onward destinations, or a full tourist e-Visa/sticker visa if leaving the terminal for other reasons',
    0,
    'e-ATV processing time not separately confirmed; likely similar to the standard e-Visa (24-72 hours)',
    'Not applicable for airside transit; embassy/VFS if a sticker tourist visa is needed instead',
    'Confirm whether you need to leave the terminal during your layover\nIf not, no visa is needed at all\nIf yes, and your onward destination is Mexico, Venezuela, Colombia, or Panama, apply for the e-ATV via evisa.gov.tr\nOtherwise, apply for a full tourist visa instead\nPresent your documents at immigration on arrival',
    '/assets/images/visa-heroes/turkey.jpg',
    'Cross-checked visa-consultancy sourcing (Akbar Travels, TataAIG, Istanbul Airport) triangulated against official guidance not directly fetchable this session', 'https://www.evisa.gov.tr/en/', '2026-09-11'
);
SET @tr6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tr6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr6, 'Core Documents', 'Every traveller needs these.', 1);
SET @tr6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr6s1, 'Valid Passport', 'Valid at least 6 months.', 'original', 1, 0, 1, 1),
(@tr6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr6, 'e-ATV / Through-Check Documents', 'Only relevant if you need to leave the terminal.', 2);
SET @tr6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr6s2, 'Visa for Final Destination (If Required There)', NULL, 'copy', 0, 1, 0, 1),
(@tr6s2, 'Boarding Passes for Both Legs', NULL, 'copy', 0, 1, 0, 2),
(@tr6s2, 'Proof of Through-Checked Baggage Status', 'Supports a through-transit exemption claim.', 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(100, 6, NULL, 'USD', 'Confirmed After Assessment', 'No distinct transit-visa/e-ATV fee figure could be independently confirmed this session — contact us for current pricing.', '2026-09-01', NOW(), 'https://www.evisa.gov.tr/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa if I never leave Istanbul Airport during my layover?', 'No — if you stay airside in the international transit zone with a single through-checked ticket, no visa is required at all.', 100, 6, 1308, 1),
('What is the e-ATV?', 'A narrow Electronic Airport Transit Visa introduced in April 2025, specifically for Indian citizens transiting Istanbul Airport onward to Mexico, Venezuela, Colombia, or Panama.', 100, 6, 1309, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    100, 7, 'TUR-MED-IN-07', '2026.09', 'published',
    'Medical treatment and health tourism in Turkey — a genuinely large market, especially for hair-transplant and cosmetic/dental procedures.',
    'Requires documentation from a Turkish hospital or clinic confirming treatment. No formally distinct "Medical Visa" application track was found this session — it is routed through the standard e-Visa or sticker-visa process, commonly with a hospital-partnered facilitator''s assistance.',
    'Tied to treatment/recovery period; standard 90/180-day rule applies if using the e-Visa route',
    'e-Visa if otherwise eligible, or embassy/consulate application; often routed through a hospital-partnered facilitator',
    0,
    'Not separately confirmed this session; general sticker-visa or e-Visa timelines likely apply',
    'Turkish Embassy, New Delhi or Consulate, Mumbai/Hyderabad, via VFS Global centres across India',
    'Confirm your treatment plan with a licensed Turkish hospital/clinic and obtain a confirmation letter\nGather documents against this checklist\nApply for a visa via the e-Visa route if eligible, or the sticker-visa route otherwise\nProvide financial proof of ability to pay for treatment\nTravel to Turkey for your procedure',
    '/assets/images/visa-heroes/turkey.jpg',
    'Cross-checked medical-tourism facilitator and visa-consultancy sourcing triangulated against official guidance not directly fetchable this session', 'https://www.evisa.gov.tr/en/', '2026-09-11'
);
SET @tr7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tr7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr7, 'Core Documents', 'Every applicant needs these.', 1);
SET @tr7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@tr7s1, 'Confirmed Round-Trip Flight Tickets', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr7, 'Medical Documents', 'Evidence of your treatment plan.', 2);
SET @tr7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr7s2, 'Official Treatment Confirmation Letter from Turkish Hospital/Clinic', NULL, 'original', 1, 0, 0, 1),
(@tr7s2, 'Medical Reports/Diagnosis from Indian Doctor', NULL, 'copy', 1, 0, 0, 2),
(@tr7s2, 'Proof of Financial Capacity to Pay for Treatment', NULL, 'copy', 1, 0, 0, 3),
(@tr7s2, 'Travel Medical Insurance', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(100, 7, NULL, 'USD', 'Confirmed After Assessment', 'No distinct medical-visa fee found — likely the same as the e-Visa/sticker-visa fee if routed that way. Contact us to confirm.', '2026-09-01', NOW(), 'https://www.evisa.gov.tr/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Medical Visa category for Turkey?', 'No formally distinct Medical Visa track was confirmed — medical travellers apply through the standard e-Visa or sticker-visa process, typically with a hospital confirmation letter as supporting evidence.', 100, 7, 1310, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    100, 8, 'TUR-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, meetings, and exhibitions in Turkey.',
    'Requires an invitation letter from the conference organizer. VFS Global lists "Conference/Seminar/Meeting Visa" and "Festival/Fair/Exhibition Visa" as distinct named categories from generic tourist/business visas.',
    'Short-term, tied to event dates, within the standard 90/180-day framework',
    'Sticker visa via embassy/VFS with the conference invitation letter',
    1,
    'Not separately confirmed this session; likely aligned to the standard 10-15 working day sticker-visa timeline',
    'Turkish Embassy, New Delhi or Consulate, Mumbai/Hyderabad, via VFS Global centres across India',
    'Register for the conference and request an invitation letter from the organizer\nGather documents against this checklist\nApply for the visa with your invitation letter\nAttend a VFS appointment for biometrics\nTravel to Turkey for the event',
    '/assets/images/visa-heroes/turkey.jpg',
    'Cross-checked VFS category naming and invitation-letter conventions triangulated against official guidance not directly fetchable this session', 'https://www.evisa.gov.tr/en/', '2026-09-11'
);
SET @tr8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tr8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr8, 'Core Documents', 'Every applicant needs these.', 1);
SET @tr8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@tr8s1, 'Conference Registration Confirmation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr8, 'Event Invitation Documents', 'Evidence of your reason for attending.', 2);
SET @tr8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr8s2, 'Formal Invitation Letter from Event Organizer', 'Should include event name, dates, venue, and purpose.', 'original', 1, 0, 0, 1),
(@tr8s2, 'Employer Sponsorship Letter', 'Required if attending in a professional capacity.', 'copy', 0, 1, 0, 2),
(@tr8s2, 'Bank Statements', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(100, 8, NULL, 'USD', 'Confirmed After Assessment', 'No distinct conference-visa fee found — likely aligned with the business sticker-visa fee range. Contact us to confirm.', '2026-09-01', NOW(), 'https://www.evisa.gov.tr/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What should my conference invitation letter include?', 'The event name, dates, venue, purpose, and the organizer''s signatory contact information.', 100, 8, 1311, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    100, 9, 'TUR-SPORT-IN-09', '2026.09', 'published',
    'Athletes, coaches, and support staff participating in sporting competitions or events in Turkey.',
    'Requires an official invitation from the event organizer or the relevant Turkish sports federation hosting the competition. VFS Global separately names a "Sportive Activity Visa" category.',
    'Event-duration based, within the standard 90/180-day window',
    'Sticker visa via embassy/VFS with event documentation',
    1,
    'Not separately confirmed this session; likely aligned to the standard 10-15 working day sticker-visa timeline',
    'Turkish Embassy, New Delhi or Consulate, Mumbai/Hyderabad, via VFS Global centres across India',
    'Obtain an invitation from the organizing federation or club\nGather documents against this checklist\nApply with your event documentation\nAttend a VFS appointment for biometrics\nTravel to Turkey for the competition',
    '/assets/images/visa-heroes/turkey.jpg',
    'Cross-checked VFS category naming and sports-federation invitation conventions triangulated against official guidance not directly fetchable this session', 'https://www.evisa.gov.tr/en/', '2026-09-11'
);
SET @tr9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tr9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr9, 'Core Documents', 'Every applicant needs these.', 1);
SET @tr9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@tr9s1, 'Event Registration/Participation Confirmation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr9, 'Federation & Event Documents', 'Evidence of your athletic affiliation.', 2);
SET @tr9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr9s2, 'Official Invitation from Turkish Sports Federation/Organizer', NULL, 'original', 1, 0, 0, 1),
(@tr9s2, 'Proof of Athlete/Team Affiliation', 'National federation certification.', 'copy', 1, 0, 0, 2),
(@tr9s2, 'Itinerary of Turkey Activities', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(100, 9, NULL, 'USD', 'Confirmed After Assessment', 'No distinct sports-visa fee found this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.evisa.gov.tr/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who can invite me for a Turkey Sports Visa?', 'The event organizer or the relevant Turkish sports federation hosting the competition — VFS Global lists this as its own "Sportive Activity Visa" category.', 100, 9, 1312, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification / Spouse Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    100, 10, 'TUR-DEP-IN-10', '2026.09', 'published',
    'Joining a spouse (Turkish citizen or foreign resident with a valid Turkish residence permit) or as a dependent minor/adult child, for stays longer than 90 days.',
    'Sponsor must be a Turkish citizen, or a foreigner holding a valid residence permit (at least 1 year for a foreign sponsor), refugee, or subsidiary-protection holder. Eligible dependents are limited to a spouse and unemancipated/dependent children under 18 — parents, siblings, and grandparents are explicitly NOT eligible under the standard family-reunification framework.',
    'Family Residence Permit valid up to 3 years, renewable as long as the sponsor''s own permit remains valid',
    'Online application at visa.gov.tr, followed by an in-person interview, then a separate Family Residence Permit application after arrival',
    1,
    'Not separately confirmed for the entry-visa stage this session',
    'Turkish Embassy/Consulate per applicant''s Indian jurisdiction',
    'Start your online application at visa.gov.tr\nUpload your documents\nSchedule an interview appointment\nAttend the interview in person with hard-copy documents and biometrics\nReceive your entry visa and travel to Turkey\nApply for your Family Residence Permit at the local Directorate of Migration Management',
    '/assets/images/visa-heroes/turkey.jpg',
    'Cross-checked immigration-law advisory sourcing (Global Citizen Solutions, Sadaret Hukuk) triangulated against official guidance not directly fetchable this session', 'https://www.mfa.gov.tr/', '2026-09-11'
);
SET @tr10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tr10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr10, 'Core Documents', 'Every applicant needs these.', 1);
SET @tr10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr10s1, 'Valid Passport', 'Valid at least 60 days beyond intended stay, with a blank visa page.', 'original', 1, 0, 1, 1),
(@tr10s1, 'Recent Passport-Size Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tr10, 'Relationship & Sponsor Documents', 'Evidence of your relationship and your sponsor''s status.', 2);
SET @tr10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tr10s2, 'Marriage Certificate (Apostilled & Translated)', 'Apostille and notarized Turkish translation required for certificates issued in India.', 'original', 1, 0, 0, 1),
(@tr10s2, 'Sponsor''s Residence Permit or Citizenship Documents', NULL, 'copy', 1, 0, 0, 2),
(@tr10s2, 'Proof of Sponsor''s Sufficient Monthly Income', NULL, 'copy', 1, 0, 0, 3),
(@tr10s2, 'Proof of Suitable Housing', NULL, 'copy', 1, 0, 0, 4),
(@tr10s2, 'Comprehensive Health Insurance for All Family Members', NULL, 'copy', 1, 0, 0, 5),
(@tr10s2, 'Sponsor''s Clean Criminal Record (Past 5 Years)', NULL, 'copy', 1, 0, 0, 6);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(100, 10, NULL, 'USD', 'Confirmed After Assessment', 'No specific dependent-visa fee figure could be independently confirmed this session — contact us for the current consulate fee schedule.', '2026-09-01', NOW(), 'https://www.mfa.gov.tr/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my parents or siblings join me in Turkey on a Dependent Visa?', 'No — Turkey''s family-reunification framework explicitly limits eligible dependents to a spouse and unemancipated/dependent children under 18. Parents, siblings, and grandparents do not qualify under this category.', 100, 10, 1313, 1),
('What does my Indian marriage certificate need before I can use it in Turkey?', 'It needs to be apostilled and accompanied by a notarized Turkish translation before it will be accepted for your Family Residence Permit application.', 100, 10, 1314, 1);
