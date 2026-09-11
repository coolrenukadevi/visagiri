-- Vietnam Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as every other
-- country built this session (see AUDIT.md). hero_image_url points at
-- the real Ha Long Bay photo supplied by the client for this hero.
--
-- Vietnam's real, distinctive facts:
--   - A well-established, genuinely straightforward e-Visa system
--     (evisa.xuatnhapcanh.gov.vn) has covered Indian citizens since
--     August 2023 — 90 days, single or multiple entry, flat USD 25/
--     USD 50 government fee payable ONLY on the official portal
--     (third-party sites often overcharge USD 50-150) — stated
--     honestly rather than glossing over the overcharging risk.
--   - Business genuinely splits into three real paths: the e-Visa
--     (no sponsor needed for short visits), and two distinct
--     traditional visa codes — DN1 (engaging with a Vietnam-registered
--     legal entity) and DN2 (invited by a foreign organization/project
--     operating in Vietnam) — both requiring Immigration Department
--     approval before stamping, and both explicitly NOT work permits.
--   - Work uses a real two-tier LD visa system: LD1 for foreign workers
--     legally exempt from a work permit, and LD2 for those requiring
--     one — LD2 requires the employer to prove via a mandatory local
--     recruitment advertising period that the role could not be filled
--     domestically, a genuine labour-market test.
--   - Transit genuinely depends on exact circumstances: under 24 hours
--     airside needs nothing; over 24 hours, exiting to collect baggage,
--     or needing to clear immigration to reach a domestic terminal all
--     require a visa. A real, dated 2026 development layers on top:
--     since 15 April 2026, Vietnam's "E-Pass" pre-arrival information
--     system is mandatory for all foreign passport holders (transit
--     passengers currently exempted) landing at Tan Son Nhat — separate
--     from, and not a substitute for, any visa requirement.
--   - Medical is documented honestly as having no distinct, widely
--     issued short-stay product — most medical tourists simply use the
--     standard tourist e-Visa; a genuinely longer-stay medical visa
--     exists only for treatment exceeding 90 days or requiring
--     prolonged inpatient care.
--   - Conference genuinely splits into the e-Visa route (no invitation
--     needed for delegates) and the dedicated HN (Hội Nghị) visa,
--     which DOES require a pre-approved invitation letter issued only
--     after conference registration and payment are complete.
--
-- country_id 104 = Vietnam. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    104, 1, 'VNM-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and short personal visits to Vietnam.',
    'Since August 2023, Indian passport holders can obtain a 90-day e-Visa online, with a choice of single or multiple entry. The government fee (USD 25 single-entry / USD 50 multiple-entry) is payable only on the official portal — third-party sites often overcharge USD 50-150 for the same visa.',
    'Up to 90 days, single or multiple entry',
    'Online e-Visa via the official government portal (evisa.xuatnhapcanh.gov.vn)',
    0,
    'Processing is typically 3 working days; first-time entrants pass through a staffed immigration counter on arrival for fingerprint and facial-recognition enrolment',
    'No in-person office visit required — entirely online',
    'Apply online via the official e-Visa portal only\nGather documents against this checklist\nPay the official government fee (USD 25 or USD 50)\nReceive your e-Visa approval before travel\nAttend the staffed immigration counter on arrival for biometric enrolment (first-time entrants)',
    '/assets/images/visa-heroes/vietnam.jpg',
    'Vietnam Immigration Department official e-Visa portal guidance, cross-checked via independent visa-agency sourcing', 'https://evisa.xuatnhapcanh.gov.vn/trang-chu-ttdt', '2026-09-11'
);
SET @vn1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vn1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn1, 'Core Documents', 'Every applicant needs these.', 1);
SET @vn1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn1s1, 'Valid Passport', 'Valid at least 6 months, with 1 blank page.', 'original', 1, 0, 1, 1),
(@vn1s1, 'Digital Photo', NULL, 'original', 1, 0, 1, 2),
(@vn1s1, 'Passport Bio-Page Scan', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn1, 'Application Documents', 'Your formal e-Visa application.', 2);
SET @vn1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn1s2, 'Completed Online e-Visa Application', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(104, 1, 25.00, 'USD', 'e-Visa Fee (Single-Entry)', 'USD 25 single-entry, USD 50 multiple-entry, payable only on the official portal. Third-party sites often overcharge USD 50-150 for the same visa.', '2026-09-01', NOW(), 'https://evisa.xuatnhapcanh.gov.vn/trang-chu-ttdt', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Where should I apply to avoid being overcharged?', 'Only the official government portal (evisa.xuatnhapcanh.gov.vn) charges the true USD 25/50 fee — third-party sites often charge USD 50-150 for the same e-Visa.', 104, 1, 1280, 1),
('Is biometrics collected when I apply online?', 'No — but first-time e-Visa entrants must pass through a staffed immigration counter on arrival for fingerprint and facial-recognition enrolment.', 104, 1, 1281, 1),
('Can I extend my e-Visa from inside Vietnam?', 'No — e-Visas cannot be extended or renewed from inside Vietnam.', 104, 1, 1282, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — e-Visa / DN1 / DN2
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    104, 2, 'VNM-BUS-IN-02', '2026.09', 'published',
    'Short business visits — meetings and negotiations — to Vietnam.',
    'Two real paths exist: the e-Visa with business purpose selected (same USD 25/50, 90-day terms, no sponsor needed), or the traditional DN1 (engaging with a Vietnam-registered legal entity) or DN2 (invited by a foreign organization/project operating in Vietnam) visa — both requiring a Vietnamese sponsor to file an approval-letter request with Immigration. Neither DN1 nor DN2 is a work permit.',
    'e-Visa: up to 90 days. DN1/DN2: up to 12 months, multiple entries',
    'e-Visa online, or DN1/DN2 via sponsor-filed approval-letter request with Immigration',
    0,
    'DN1/DN2 stamping fee is USD 25/50 per Circular 28/2026/TT-BTC, effective 1 April 2026',
    'No in-person office visit required for e-Visa; embassy/consulate stamping for DN1/DN2',
    'Confirm whether the e-Visa or DN1/DN2 suits your trip length\nFor DN1/DN2: your Vietnamese sponsor files an approval-letter request with Immigration\nGather documents against this checklist\nApply (online for e-Visa, at embassy/consulate for DN1/DN2)\nDecision once processed',
    '/assets/images/visa-heroes/vietnam.jpg',
    'Vietnam DN1/DN2 Business Visa guidance and Circular 28/2026/TT-BTC fee schedule', 'https://nhigia.vn/en/news/vietnam-business-visa-for-foreigners-dn1-and-dn2-visa/', '2026-09-11'
);
SET @vn2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vn2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn2, 'Core Documents', 'Every applicant needs these.', 1);
SET @vn2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@vn2s1, 'Digital Photo', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn2, 'DN1/DN2 Documents (For Sponsor-Led Route)', 'If not using the e-Visa business purpose.', 2);
SET @vn2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn2s2, 'Sponsor''s Approval-Letter Request to Immigration', NULL, 'original', 0, 1, 1, 1),
(@vn2s2, 'Covering Letter from Indian Employer', NULL, 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn2, 'Application Documents', 'Your formal application.', 3);
SET @vn2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn2s3, 'Completed Application (e-Visa or DN1/DN2)', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(104, 2, 25.00, 'USD', 'e-Visa / DN1-DN2 Stamping Fee (Single-Entry)', 'USD 25 single-entry / USD 50 multiple-entry, per Circular 28/2026/TT-BTC effective 1 April 2026, whichever route you use.', '2026-04-01', NOW(), 'https://nhigia.vn/en/news/vietnam-business-visa-for-foreigners-dn1-and-dn2-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the difference between DN1 and DN2?', 'DN1 is for those engaging with a Vietnam-registered legal entity; DN2 is for those invited by a foreign organization/project operating in Vietnam — both require Immigration Department approval before stamping.', 104, 2, 1283, 1),
('Are DN1/DN2 work permits?', 'No — they permit business activity like meetings and negotiations, not employment; actual employment requires a separate work permit under the Work visa category.', 104, 2, 1284, 1),
('Can I just use the e-Visa for business trips?', 'Yes, for short visits — select the business purpose on the e-Visa application; no sponsor is needed for that route.', 104, 2, 1285, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — DH Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    104, 3, 'VNM-STU-IN-03', '2026.09', 'published',
    'Full-time study at a licensed Vietnamese educational institution.',
    'Requires a formal acceptance/enrollment letter from a licensed Vietnamese institution, which acts as sponsor and requests an entry approval letter from Immigration. The school''s own approval can take up to 30 days after enrollment, plus up to 14 days for embassy/consulate visa stamping.',
    'Commonly 3 months to 1 year, tied to the study program; long-stay holders convert to a temporary residence card',
    'DH visa via Vietnamese Embassy/Consulate, India, requires prior institution sponsorship',
    1,
    'Apply 4-6 weeks ahead given the combined school-approval and embassy-stamping timeline',
    'Vietnamese Embassy/Consulate, India',
    'Secure admission and receive your acceptance/enrollment letter\nInstitution requests your entry approval letter from Immigration (up to 30 days)\nGather documents against this checklist, including proof of funds and health insurance\nSubmit your application at the embassy/consulate (up to 14 days)\nDecision once processed',
    '/assets/images/visa-heroes/vietnam.jpg',
    'Vietnam Student Visa (DH) guidance', 'https://vnis.edu.vn/en/destinations/study-in-vietnam/vietnam-student-visa-guide/', '2026-09-11'
);
SET @vn3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vn3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn3, 'Core Documents', 'Every applicant needs these.', 1);
SET @vn3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@vn3s1, 'Acceptance/Enrollment Letter', 'From your licensed Vietnamese institution.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn3, 'Financial & Insurance Documents', 'Evidence you can fund your studies.', 2);
SET @vn3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn3s2, 'Proof of Funds', 'Bank statements or sponsorship letter covering tuition and living costs.', 'copy', 1, 0, 1, 1),
(@vn3s2, 'Health Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn3, 'Application Documents', 'Requires prior institution approval.', 3);
SET @vn3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn3s3, 'Entry Approval Letter from Immigration', 'Requested by your institution.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(104, 3, 25.00, 'USD', 'DH Visa Stamping Fee (Indicative)', 'Approximately USD 25-50 depending on entry type, plus your institution''s own approval-letter processing.', '2026-04-01', NOW(), 'https://vnis.edu.vn/en/destinations/study-in-vietnam/vietnam-student-visa-guide/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How far in advance should I apply?', '4-6 weeks ahead, given the school''s own approval can take up to 30 days plus up to 14 days for embassy/consulate stamping.', 104, 3, 1286, 1),
('What happens to my visa for long-stay programs?', 'Long-stay DH visa holders typically convert to a temporary residence card after initial entry.', 104, 3, 1287, 1),
('Who requests my entry approval letter?', 'Your licensed Vietnamese institution, acting as your sponsor, requests it from Immigration on your behalf.', 104, 3, 1288, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — LD Visa (LD1/LD2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    104, 4, 'VNM-WORK-IN-04', '2026.09', 'published',
    'Employer-sponsored employment in Vietnam, under the LD visa''s two-tier system.',
    'A real two-tier system: LD1 for foreign workers legally exempt from a work permit, and LD2 for those requiring one. An LD2 applicant''s employer must first secure a DOLISA work permit, proving via a mandatory local-recruitment advertising period that the role could not be filled domestically, requiring a bachelor''s degree or 3+ years'' relevant experience.',
    'Work permits valid up to 2 years, renewable once for another 2 years (4-year cap); LD visa tied to the employer and role',
    'Employer secures a DOLISA work permit; employee then applies for the LD visa',
    1,
    'Combined work-permit-plus-visa processing commonly takes 30-40 working days, with home-country document legalization adding 2-3 months',
    'Vietnamese Embassy/Consulate, India',
    'Employer secures your DOLISA work permit (LD2) or confirms LD1 exemption\nComplete home-country document legalization (2-3 months)\nGather documents against this checklist\nApply for your LD visa at the embassy/consulate\nDecision once processed',
    '/assets/images/visa-heroes/vietnam.jpg',
    'Vietnam Work Visa (LD1/LD2) and DOLISA work permit guidance', 'https://emerhub.com/vietnam/visas/ld-work-visa/', '2026-09-11'
);
SET @vn4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vn4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn4, 'Core Documents', 'Every applicant needs these.', 1);
SET @vn4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@vn4s1, 'DOLISA Work Permit (LD2) or Exemption Confirmation (LD1)', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn4, 'Employer Sponsorship Documents', 'Evidence of your role.', 2);
SET @vn4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn4s2, 'Employment Contract', NULL, 'copy', 1, 0, 1, 1),
(@vn4s2, 'Local Recruitment Advertising Evidence', 'Showing the role could not be filled domestically (LD2 only).', 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn4, 'Qualification Documents', 'Evidence you meet the role''s requirements.', 3);
SET @vn4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn4s3, 'Legalized Degree Certificate or Experience Evidence', '3+ years'' relevant experience if no bachelor''s degree.', 'copy', 1, 0, 0, 1),
(@vn4s3, 'Clean Criminal Record Certificate & Health Certificate', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(104, 4, NULL, 'USD', 'Confirmed After Assessment', 'Visa stamping fee tracks the standard USD 25/50 schedule, but DOLISA work permit costs are separate and typically arranged by the employer.', '2026-04-01', NOW(), 'https://emerhub.com/vietnam/visas/ld-work-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the difference between LD1 and LD2?', 'LD1 is for foreign workers legally exempt from a work permit; LD2 is for those requiring one, gated by a genuine local-recruitment advertising test.', 104, 4, 1289, 1),
('How long is the full process?', 'Combined work-permit-plus-visa processing commonly takes 30-40 working days, with home-country document legalization adding a further 2-3 months.', 104, 4, 1290, 1),
('How long can I hold an LD2 work permit?', 'Up to 2 years initially, renewable once for another 2 years, for a 4-year cap — the visa itself is tied to that employer and role.', 104, 4, 1291, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — VR Visa / e-Visa (Family Purpose)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    104, 5, 'VNM-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives — grandparents, parents, spouse, or children — in Vietnam.',
    'The VR visa is capped at 6 months validity, requiring your Vietnamese citizen or resident relative to sponsor you by filing an entry approval letter with Immigration (roughly 1 week turnaround). Alternatively, "visiting family" can be selected as an e-Visa purpose for shorter 90-day stays without the sponsor-led step.',
    'VR visa: up to 6 months. e-Visa (family purpose): up to 90 days',
    'VR visa via sponsor-filed entry approval letter; or e-Visa online for shorter stays',
    0,
    'The sponsor''s entry approval letter typically takes around 1 week',
    'Vietnamese Embassy/Consulate, India, for the VR visa; online for the e-Visa route',
    'Confirm whether the e-Visa (90 days) or VR visa (6 months) suits your visit\nFor VR: your Vietnamese relative files an entry approval letter with Immigration\nGather documents against this checklist, including relationship proof\nApply (online for e-Visa, at embassy/consulate for VR)\nDecision once processed',
    '/assets/images/visa-heroes/vietnam.jpg',
    'Vietnam Family Visit Visa (VR) guidance', 'https://tanvanlang.com/en/vietnam-family-visit-visa/', '2026-09-11'
);
SET @vn5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vn5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn5, 'Core Documents', 'Every applicant needs these.', 1);
SET @vn5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@vn5s1, 'Digital Photo', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn5, 'VR Visa Documents (For Longer Stays)', 'If not using the shorter e-Visa route.', 2);
SET @vn5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn5s2, 'Sponsor''s Entry Approval Letter', NULL, 'original', 0, 1, 1, 1),
(@vn5s2, 'Relationship Proof', 'Marriage certificate, household registration, or equivalent legal document.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn5, 'Application Documents', 'Your formal application.', 3);
SET @vn5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn5s3, 'Completed Application (e-Visa or VR)', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(104, 5, 25.00, 'USD', 'e-Visa / VR Stamping Fee (Single-Entry)', 'USD 25 single-entry / USD 50 multiple-entry, whichever route you use.', '2026-04-01', NOW(), 'https://tanvanlang.com/en/vietnam-family-visit-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the difference between the VR visa and the e-Visa for family visits?', 'The VR visa allows up to 6 months but requires your Vietnamese relative to file a sponsor-led entry approval letter; the e-Visa (family purpose) allows up to 90 days without that sponsor-led step.', 104, 5, 1292, 1),
('Who qualifies as a relative for the VR visa?', 'Grandparents, parents, spouse, or children of the Vietnamese citizen or resident host.', 104, 5, 1293, 1),
('How long does the sponsor''s approval letter take?', 'Roughly 1 week turnaround.', 104, 5, 1294, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Transit Exemption / Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    104, 6, 'VNM-TRANS-IN-06', '2026.09', 'published',
    'Passing through Noi Bai (Hanoi) or Tan Son Nhat (Ho Chi Minh City) airports en route to a third country.',
    'No visa is needed if the layover is under 24 hours and you remain airside within the international transit zone. A transit visa (or short-stay e-Visa) is required if the layover exceeds 24 hours, you must exit to collect baggage, or the connection requires clearing immigration to reach a domestic terminal.',
    'Under 24 hours: no visa needed. Over 24 hours or exiting: standard e-Visa/transit visa terms apply',
    'No application for eligible under-24-hour airside connections; e-Visa or transit visa otherwise',
    0,
    'Since 15 April 2026, the mandatory "E-Pass" pre-arrival information system applies to all foreign passport holders landing at Tan Son Nhat, except transit passengers (currently exempted) — a separate requirement from any visa',
    'No in-person office visit required for eligible transit; online for e-Visa if required',
    'Confirm your layover stays under 24 hours within the airside transit zone\nEnsure you have a confirmed onward ticket\nIf exceeding 24 hours or needing to clear immigration, apply for a standard e-Visa or transit visa\nProceed through the transit zone if eligible',
    '/assets/images/visa-heroes/vietnam.jpg',
    'Vietnam transit visa guidance and 15 April 2026 E-Pass pre-arrival system', 'https://asiapioneertravel.com/blog/vietnam-e-pass-2026/', '2026-09-11'
);
SET @vn6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vn6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn6, 'Core Documents', 'For eligible under-24-hour connections.', 1);
SET @vn6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@vn6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn6, 'If Exceeding 24 Hours or Exiting', 'Fall back to a standard visa.', 2);
SET @vn6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn6s2, 'Standard e-Visa or Transit Visa Application', NULL, 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(104, 6, 0.00, 'USD', 'No Fee for Eligible Under-24-Hour Transit', 'No visa or fee is needed for a qualifying under-24-hour airside connection. A standard USD 25/50 fee applies only if you need a full visa.', '2026-04-01', NOW(), 'https://asiapioneertravel.com/blog/vietnam-e-pass-2026/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa for a short layover in Vietnam?', 'Not if you stay airside under 24 hours — no visa is needed for that scenario.', 104, 6, 1295, 1),
('What is the E-Pass and is it a visa?', 'No — it is a separate, mandatory pre-arrival information system for all foreign passport holders landing at Tan Son Nhat since 15 April 2026 (transit passengers currently exempted), not a substitute for any visa requirement.', 104, 6, 1296, 1),
('When would I need a full visa for transit?', 'If your layover exceeds 24 hours, you need to exit to collect baggage, or your connection requires clearing immigration to reach a domestic terminal.', 104, 6, 1297, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Tourist e-Visa / Longer-Stay Medical Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    104, 7, 'VNM-MED-IN-07', '2026.09', 'published',
    'Travelling to Vietnam for medical treatment.',
    'There is no distinct, widely issued "medical visa" for short stays — most medical tourists simply use the standard 30-90 day tourist e-Visa. A genuinely longer-stay medical visa is only needed for treatment exceeding 90 days or requiring prolonged inpatient care, arranged through the embassy/consulate with a hospital invitation.',
    'Short treatment: up to 90 days (tourist e-Visa). Extended treatment: arranged case-by-case',
    'Tourist e-Visa online for most cases; embassy/consulate application for extended treatment',
    0,
    'Vietnam currently imposes no COVID-era health entry requirements (no vaccination proof, tests, or health declarations) as of 2026',
    'No in-person office visit required for short treatment; Vietnamese Embassy/Consulate for extended treatment',
    'Confirm whether your treatment duration fits within the standard tourist e-Visa terms\nIf so, apply online via the e-Visa portal\nFor extended treatment, obtain a hospital invitation and apply at the embassy/consulate\nGather documents against this checklist\nDecision once processed',
    '/assets/images/visa-heroes/vietnam.jpg',
    'Vietnam medical tourism and visa guidance, cross-checked via independent healthcare-travel sourcing', 'https://vietnam-immigrations.org/blog/vietnam-healthcare-medical-guide-travelers', '2026-09-11'
);
SET @vn7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vn7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn7, 'Core Documents', 'Every applicant needs these.', 1);
SET @vn7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@vn7s1, 'Digital Photo', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn7, 'Extended Treatment Documents (Over 90 Days)', 'If your treatment exceeds standard e-Visa terms.', 2);
SET @vn7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn7s2, 'Hospital Invitation Letter', NULL, 'original', 0, 1, 1, 1),
(@vn7s2, 'Proof of Funds for Treatment', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn7, 'Application Documents', 'Your formal application.', 3);
SET @vn7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn7s3, 'Completed Application (e-Visa or Embassy)', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(104, 7, 25.00, 'USD', 'e-Visa Fee (Short Treatment)', 'USD 25/50 for short treatment via the standard tourist e-Visa; extended treatment visa fees vary by mission.', '2026-04-01', NOW(), 'https://vietnam-immigrations.org/blog/vietnam-healthcare-medical-guide-travelers', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Medical Visa for Vietnam?', 'Not for short stays — most medical tourists simply use the standard tourist e-Visa. A genuinely longer-stay medical visa is only needed for treatment exceeding 90 days.', 104, 7, 1298, 1),
('Do I need proof of vaccination to enter Vietnam?', 'No — Vietnam currently imposes no COVID-era health entry requirements as of 2026.', 104, 7, 1299, 1),
('What does extended treatment require?', 'A hospital invitation and application through the embassy/consulate, with requirements varying by mission.', 104, 7, 1300, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — e-Visa / HN (Hội Nghị) Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    104, 8, 'VNM-CONF-IN-08', '2026.09', 'published',
    'Attending a conference or seminar in Vietnam.',
    'Two real options: the e-Visa (business/event purpose) needs no invitation letter for delegates/attendees, following standard USD 25/50, 90-day terms. The dedicated HN (Hội Nghị) conference visa runs up to 90 days, single or multiple entry, but requires a pre-approved invitation letter issued only after conference registration and payment are complete.',
    'Up to 90 days, single or multiple entry',
    'e-Visa online (no invitation needed), or the dedicated HN visa with a pre-approved invitation letter',
    0,
    'HN visa invitation letters are issued only after registration and payment are complete',
    'No in-person office visit required for e-Visa; embassy/consulate for HN visa',
    'Confirm whether the e-Visa or the dedicated HN visa suits your conference\nFor HN: complete conference registration and payment to receive your invitation letter\nGather documents against this checklist\nApply (online for e-Visa, at embassy/consulate for HN)\nDecision once processed',
    '/assets/images/visa-heroes/vietnam.jpg',
    'Vietnam HN (Hội Nghị) Conference Visa guidance', 'https://emerhub.com/vietnam/visas/hn-conference-visa/', '2026-09-11'
);
SET @vn8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vn8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn8, 'Core Documents', 'Every applicant needs these.', 1);
SET @vn8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@vn8s1, 'Digital Photo', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn8, 'HN Visa Documents (Dedicated Conference Route)', 'If not using the e-Visa route.', 2);
SET @vn8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn8s2, 'Pre-Approved Conference Invitation Letter', 'Issued only after registration and payment are complete.', 'original', 0, 1, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn8, 'Application Documents', 'Your formal application.', 3);
SET @vn8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn8s3, 'Completed Application (e-Visa or HN)', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(104, 8, 25.00, 'USD', 'e-Visa / HN Stamping Fee (Single-Entry)', 'USD 25 single-entry / USD 50 multiple-entry, whichever route you use.', '2026-04-01', NOW(), 'https://emerhub.com/vietnam/visas/hn-conference-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do conference delegates need an invitation letter?', 'Not if using the e-Visa business/event purpose route — only the dedicated HN visa requires a pre-approved invitation letter.', 104, 8, 1301, 1),
('When is the HN invitation letter issued?', 'Only after conference registration and payment are complete — the letter supports, but does not guarantee, visa approval.', 104, 8, 1302, 1),
('Which route should I use?', 'The e-Visa is simpler for most delegates; the HN visa may suit longer or more formal conference engagements — we help you choose based on your specific case.', 104, 8, 1303, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — DL Tourism e-Visa / Sponsor-Led Route
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    104, 9, 'VNM-SPORT-IN-09', '2026.09', 'published',
    'Participating in a sporting event in Vietnam as an athlete or official.',
    'There is no separate "sports visa" symbol — foreign athletes and officials typically enter on the DL (tourism) e-Visa or, when invited by an organizing federation/body, follow the same sponsor-led approval-letter route used for conference/business visits.',
    'Up to 90 days',
    'DL tourism e-Visa online, or sponsor-led approval-letter route via the organizing federation',
    0,
    'Vietnam is hosting major 2026 sporting events, including the National Games (Nov-Dec 2026) — confirm event-specific arrangements with the organizer',
    'No in-person office visit required for e-Visa; embassy/consulate for sponsor-led applications',
    'Confirm your event participation basis with the organizing federation/committee\nUse the standard DL tourism e-Visa, or the sponsor-led approval-letter route if invited by a federation\nGather documents against this checklist\nApply accordingly\nDecision once processed',
    '/assets/images/visa-heroes/vietnam.jpg',
    'Vietnam sports-event visa guidance, cross-checked against 2026 sporting calendar sourcing', 'https://www.vietnam-visa.com/vietnam-visa-types/', '2026-09-11'
);
SET @vn9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vn9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn9, 'Core Documents', 'Every applicant needs these.', 1);
SET @vn9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@vn9s1, 'Digital Photo', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn9, 'Event Documents (If Federation-Invited)', 'For sponsor-led applications.', 2);
SET @vn9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn9s2, 'Organizing Federation Invitation/Approval Letter', NULL, 'original', 0, 1, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn9, 'Application Documents', 'Your formal application.', 3);
SET @vn9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn9s3, 'Completed Application (e-Visa or Embassy)', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(104, 9, 25.00, 'USD', 'e-Visa Fee (Single-Entry)', 'USD 25 single-entry / USD 50 multiple-entry if using the standard DL tourism e-Visa route.', '2026-04-01', NOW(), 'https://www.vietnam-visa.com/vietnam-visa-types/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Sports Visa symbol for Vietnam?', 'No — foreign athletes and officials typically use the DL (tourism) e-Visa or the same sponsor-led approval-letter route used for conference/business visits.', 104, 9, 1304, 1),
('What major sporting events is Vietnam hosting in 2026?', 'The National Games (November-December 2026) among others — confirm event-specific arrangements with the organizer.', 104, 9, 1305, 1),
('When would I need the sponsor-led route instead of the e-Visa?', 'When invited directly by an organizing federation or event body rather than attending independently.', 104, 9, 1306, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — TT Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    104, 10, 'VNM-DEP-IN-10', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a qualifying work (LD), student (DH), or other visa in Vietnam.',
    'The TT visa covers spouses and children under 18 of a foreigner legally in Vietnam on a qualifying visa. It does NOT authorize employment — a dependent who wants to work needs their own separate work permit and visa. Long-stay TT holders may convert to a 3-year temporary residence card.',
    'Up to 12 months, tied to the sponsor''s status',
    'Sponsor (the primary visa/resident holder) applies on the dependent''s behalf',
    1,
    'Long-stay TT holders may convert to a 3-year temporary residence card',
    'Vietnamese Embassy/Consulate, India',
    'Confirm the principal visa holder''s qualifying status (work/LD, student/DH, investor, etc.)\nSponsor applies for your TT visa on your behalf\nGather documents against this checklist, including relationship proof\nDecision once processed\nAfter arrival: long-stay holders may convert to a 3-year temporary residence card',
    '/assets/images/visa-heroes/vietnam.jpg',
    'Vietnam TT (Spouse and Family) Visa guidance', 'https://emerhub.com/vietnam/visas/tt-spouse-family-visa/', '2026-09-11'
);
SET @vn10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@vn10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn10, 'Core Documents', 'Every applicant needs these.', 1);
SET @vn10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@vn10s1, 'Principal Holder''s Qualifying Visa Copy', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn10, 'Relationship Documents', 'Evidence of your relationship to the principal holder.', 2);
SET @vn10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn10s2, 'Marriage Certificate', 'For a spouse applicant.', 'copy', 0, 1, 1, 1),
(@vn10s2, 'Birth Certificate', 'For a child applicant under 18.', 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@vn10, 'Application Documents', 'Submitted by your sponsor.', 3);
SET @vn10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@vn10s3, 'Sponsor-Submitted TT Visa Application', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(104, 10, 25.00, 'USD', 'TT Visa Stamping Fee (Indicative)', 'Tracks the standard USD 25/50 visa fee schedule, though confirm the exact figure for the TT category with us.', '2026-04-01', NOW(), 'https://emerhub.com/vietnam/visas/tt-spouse-family-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Vietnam on a TT visa?', 'No — the TT visa does not authorize employment. A dependent who wants to work needs their own separate work permit and visa.', 104, 10, 1307, 1),
('Who can apply on my behalf?', 'The principal visa/resident holder — the sponsor — applies for your TT visa on your behalf.', 104, 10, 1308, 1),
('Can I stay longer than 12 months?', 'Long-stay TT holders may convert to a 3-year temporary residence card after initial entry.', 104, 10, 1309, 1);
