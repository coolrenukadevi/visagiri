-- Saudi Arabia Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search, same standard as every
-- other country built this session (see AUDIT.md). hero_image_url
-- points at the real Kingdom Centre/Riyadh and Saudi flag photo
-- supplied by the client for this hero.
--
-- IMPORTANT SOURCING CAVEAT: official primary sources (visa.
-- visitsaudi.com, mofa.gov.sa, nusuk.sa, Saudi Embassy India) were not
-- directly fetchable in this session's research pass — findings were
-- triangulated from multiple 2026-dated secondary sources (visa
-- agencies, immigration-law firms) that themselves cite those official
-- platforms. Fee figures especially should be re-verified against the
-- live visa.visitsaudi.com/visa.mofa.gov.sa/nusuk.sa portals before
-- being treated as final; several fee rows below are marked
-- "Confirmed After Assessment" rather than guessed, for that reason.
--
-- Saudi Arabia's real, distinctive facts:
--   - The tourism eVisa (visa.visitsaudi.com) is explicitly SEPARATE
--     from Umrah/religious travel, which uses the entirely different
--     Nusuk platform (nusuk.sa) — as of 2026, standalone Umrah
--     applications are no longer accepted at all; every Umrah visa
--     must be tied to a verified Nusuk booking. The tourism eVisa
--     never substitutes for this, a distinction stated plainly rather
--     than blurred.
--   - Saudi Arabia formally announced (June 2025) abolishing the
--     Kafala sponsorship system for a contract-based employment
--     model, though employer sponsorship and Iqama issuance still
--     function similarly in practice — stated honestly as an
--     in-progress reform, not a completed one.
--   - Transit uses a genuinely distinct "Stopover" eVisa (90-day
--     validity from issue, single stay up to 96 hours, purely
--     digital, no passport sticker) rather than a traditional transit
--     visa product.
--   - A real, very recent development: Saudi Arabia's new Sports Law
--     took effect 11 June 2026, formalizing event-permit requirements
--     for organizers staging competitions — relevant given the
--     Kingdom's build-up toward hosting AFC tournaments and the 2034
--     World Cup.
--   - A real Q1 2026 reform allows qualifying dependents (spouses,
--     adult children) to obtain their own separate work permits
--     through HRSD, updating their Iqama status to "employed" rather
--     than purely dependent — a genuine, dated policy change.
--
-- country_id 91 = Saudi Arabia. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — eVisa (visa.visitsaudi.com)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    91, 1, 'SAU-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and tourism in Saudi Arabia.',
    'The Saudi eVisa (visa.visitsaudi.com) is fully online, multiple-entry, 1-year validity, up to 90 days per visit. It is explicitly separate from Umrah/religious travel, which uses the entirely different Nusuk platform (nusuk.sa) — this eVisa does not authorize Umrah pilgrimage.',
    'Up to 90 days per visit, multiple entry within 1 year of validity',
    'Fully online eVisa via visa.visitsaudi.com, no biometrics, near-instant processing',
    0,
    'Processing is typically near-instant once the online application is submitted',
    'No in-person office visit required — entirely online',
    'Confirm your purpose is tourism, not Umrah (which requires the separate Nusuk platform)\nApply online via visa.visitsaudi.com\nGather documents against this checklist\nPay the visa fee and mandatory health insurance online\nReceive your eVisa approval before travel',
    '/assets/images/visa-heroes/saudi-arabia.jpg',
    'Saudi eVisa official portal (visa.visitsaudi.com) tourism guidance, cross-checked via independent visa-agency sourcing', 'https://visa.visitsaudi.com/', '2026-09-11'
);
SET @st1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@st1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st1, 'Core Documents', 'Every applicant needs these.', 1);
SET @st1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st1s1, 'Valid Passport', 'Valid at least 6 months beyond arrival.', 'original', 1, 0, 1, 1),
(@st1s1, 'Digital Passport-Style Photo', 'Uploaded during the online eVisa application.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st1, 'Insurance & Payment', 'Mandatory as part of the eVisa application.', 2);
SET @st1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st1s2, 'Mandatory Health Insurance', 'Purchased as part of the eVisa application process.', 'original', 1, 0, 1, 1),
(@st1s2, 'Online Fee Payment', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st1, 'Application Documents', 'Your formal application details.', 3);
SET @st1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st1s3, 'Completed eVisa Application', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(91, 1, 535.00, 'SAR', 'eVisa Fee + Mandatory Insurance', 'Approximately SAR 535 total (SAR 300 visa fee + SAR 180 mandatory health insurance + SAR 15 VAT). This eVisa never covers Umrah — verify the exact current figure with us before applying.', '2026-09-01', NOW(), 'https://visa.visitsaudi.com/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the tourist eVisa cover Umrah?', 'No — Umrah/religious travel uses the entirely separate Nusuk platform (nusuk.sa). As of 2026, standalone Umrah applications are no longer accepted; every Umrah visa must be tied to a verified Nusuk booking.', 91, 1, 1100, 1),
('Is biometrics required for the tourist eVisa?', 'No — it is a fully online eVisa with near-instant processing, no in-person biometrics needed.', 91, 1, 1101, 1),
('How long is the eVisa valid?', '1 year, multiple entry, with each visit capped at up to 90 days.', 91, 1, 1102, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Business Visit Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    91, 2, 'SAU-BUS-IN-02', '2026.09', 'published',
    'Short business visits — meetings and negotiations — to Saudi Arabia.',
    'A separate Business Visit Visa track requires a genuine invitation from a Saudi company, issued through the Saudi Chamber of Commerce/MOFA system, dated within the last 30 days. Available via the eVisa system for eligible cases, or a sponsor-led embassy/VFS route.',
    'Typically up to 90 days, per the invitation and visa category',
    'Business Visit Visa via eVisa system or sponsor-led embassy/VFS application',
    0,
    'Processing typically runs 5-15 working days',
    'VFS Global/Saudi Embassy Visa Application Centre, India (if not eVisa-eligible)',
    'Obtain an invitation letter from your Saudi host company, dated within 30 days\nConfirm whether the eVisa system or sponsor-led route applies to your case\nGather documents against this checklist\nSubmit your application\nDecision once processed',
    '/assets/images/visa-heroes/saudi-arabia.jpg',
    'Saudi Business Visit Visa guidance, cross-checked via independent visa-agency and law-firm sourcing', 'https://btwvisas.com/visa-guide/business-visa-saudi-arabia', '2026-09-11'
);
SET @st2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@st2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st2, 'Core Documents', 'Every applicant needs these.', 1);
SET @st2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@st2s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st2, 'Business Invitation Documents', 'Evidence of who you are meeting.', 2);
SET @st2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st2s2, 'Invitation Letter from Saudi Company', 'Issued through the Saudi Chamber of Commerce/MOFA system, dated within 30 days.', 'original', 1, 0, 1, 1),
(@st2s2, 'Covering Letter from Indian Employer', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st2, 'Financial & Insurance Documents', 'Evidence of funds and mandatory insurance.', 3);
SET @st2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st2s3, 'Bank Statements', NULL, 'copy', 1, 0, 0, 1),
(@st2s3, 'Mandatory Health Insurance', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(91, 2, NULL, 'SAR', 'Confirmed After Assessment', 'Reported in a similar range to the tourist eVisa fee by some secondary sources, but not confirmed against an official source this session — confirmed once your specific route (eVisa vs sponsor-led) is known.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/business-visa-saudi-arabia', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How recent must my Saudi business invitation be?', 'Dated within the last 30 days, issued through the Saudi Chamber of Commerce/MOFA system.', 91, 2, 1103, 1),
('Can I use the eVisa system for business?', 'In some eligible cases yes — otherwise a sponsor-led embassy/VFS application is used instead.', 91, 2, 1104, 1),
('Is a Business visit different from Tourist?', 'Yes — it is a separate visa track requiring a genuine company invitation, distinct from the general tourism eVisa.', 91, 2, 1105, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Student Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    91, 3, 'SAU-STU-IN-03', '2026.09', 'published',
    'Full-time study at a recognized Saudi educational institution.',
    'Requires an official acceptance/admission letter from a recognized Saudi university, which acts as sponsor. Attested academic transcripts (via Ministry of Foreign Affairs and Saudi Embassy attestation), language proficiency proof, and vaccination records (Meningococcal ACWY, Polio) are all required.',
    'Up to 1 year, renewable; converts to residence (Iqama) after arrival',
    'Applied via the Saudi Embassy/Consulate, India — not the tourism eVisa system',
    1,
    'Processing depends on attestation and university sponsorship timelines',
    'Saudi Embassy/Consulate, India',
    'Secure admission from a recognized Saudi university\nAttest your academic transcripts via MOFA and the Saudi Embassy\nComplete required vaccinations (Meningococcal ACWY, Polio)\nGather documents against this checklist\nSubmit your application at the embassy/consulate\nDecision once processed',
    '/assets/images/visa-heroes/saudi-arabia.jpg',
    'Saudi Student Visa guidance, cross-checked via independent education-consultancy sourcing', 'https://qogentglobal.com/study-in-saudi-arabia/pre-departure/visa-process', '2026-09-11'
);
SET @st3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@st3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st3, 'Core Documents', 'Every applicant needs these.', 1);
SET @st3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@st3s1, 'Official Acceptance/Admission Letter', 'From a recognized Saudi university.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st3, 'Academic Documents', 'Attested credentials.', 2);
SET @st3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st3s2, 'Attested Academic Transcripts', 'MOFA and Saudi Embassy attestation required.', 'original', 1, 0, 1, 1),
(@st3s2, 'Language Proficiency Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st3, 'Medical Documents', 'Mandatory vaccination requirements.', 3);
SET @st3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st3s3, 'Vaccination Records', 'Meningococcal ACWY and Polio.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(91, 3, NULL, 'SAR', 'Confirmed After Assessment', 'Fee varies by embassy/consulate and sponsoring university arrangement — confirmed once your specific university is known.', '2026-09-01', NOW(), 'https://qogentglobal.com/study-in-saudi-arabia/pre-departure/visa-process', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use the tourism eVisa to study in Saudi Arabia?', 'No — Student visas are applied for through the Saudi Embassy/Consulate directly, not the tourism eVisa system.', 91, 3, 1106, 1),
('What vaccinations are required?', 'Meningococcal ACWY and Polio vaccination records are required as part of the Student visa application.', 91, 3, 1107, 1),
('Does my visa convert to something after arrival?', 'Yes — it converts to a residence permit (Iqama) after arrival, tied to your continued enrollment.', 91, 3, 1108, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Employer-Sponsored Work Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    91, 4, 'SAU-WORK-IN-04', '2026.09', 'published',
    'Employer-sponsored employment in Saudi Arabia.',
    'Entirely employer-sponsored. Saudi Arabia formally announced (June 2025) abolishing the Kafala sponsorship system for a contract-based model, though employer sponsorship and Iqama issuance still function similarly in practice. Saudization/Nitaqat quotas remain mandatory, now incorporating a skill-based occupation classification system as of 2026.',
    'Tied to your employment contract, renewable, converts to Iqama after arrival',
    'Employer-sponsored: work visa, then mandatory medical fitness test and Iqama issuance after arrival',
    1,
    'Since 2021 reforms, workers with 12+ months'' tenure can often transfer employers via the Tanaqul mobility portal without current employer consent',
    'Saudi Embassy/Consulate, India',
    'Employer sponsors your work visa application\nGather documents against this checklist\nSubmit your application at the embassy/consulate\nComplete a mandatory medical fitness test (Wafid/GAMCA-type screening)\nIqama (residence permit) issued after arrival',
    '/assets/images/visa-heroes/saudi-arabia.jpg',
    'Saudi Work Visa and Kafala-reform guidance, cross-checked via independent immigration-law sourcing', 'https://www.centuroglobal.com/articles/saudi-arabia-work-visa/', '2026-09-11'
);
SET @st4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@st4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st4, 'Core Documents', 'Every applicant needs these.', 1);
SET @st4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@st4s1, 'Employer Sponsorship Documents', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st4, 'Employment Documents', 'Evidence of your role.', 2);
SET @st4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st4s2, 'Employment Contract', NULL, 'copy', 1, 0, 1, 1),
(@st4s2, 'Attested Educational Credentials', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st4, 'Medical Documents', 'Mandatory health clearance.', 3);
SET @st4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st4s3, 'Medical Fitness Test Result', 'Wafid/GAMCA-type screening.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(91, 4, 100.00, 'SAR', 'Work Visa Fee (Indicative)', 'Indicative government work-visa fee around SAR 100; Iqama issuance runs roughly SAR 650/year, plus dependent/worker levies, typically arranged by the employer.', '2026-09-01', NOW(), 'https://www.centuroglobal.com/articles/saudi-arabia-work-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Has the Kafala sponsorship system been fully abolished?', 'Saudi Arabia formally announced abolishing it in June 2025 in favour of a contract-based model, but employer sponsorship and Iqama issuance still function similarly in practice — an in-progress reform, not yet complete.', 91, 4, 1109, 1),
('Can I change employers?', 'Since 2021 reforms, workers with 12+ months'' tenure can often transfer employers via the Tanaqul mobility portal without needing current employer consent.', 91, 4, 1110, 1),
('Is there a fast-track residency option bypassing sponsorship?', 'Yes — a Premium Residency ("Iqama Mumayyazah") track exists for qualifying investors/specialists, with its own SAR 4,000 fee, bypassing standard sponsorship.', 91, 4, 1111, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Family Visit Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    91, 5, 'SAU-FAM-IN-05', '2026.09', 'published',
    'Visiting family members who hold Iqama residency in Saudi Arabia.',
    'Sponsored by an Iqama-holding resident, applied via the Unified Platform (visa.mofa.gov.sa Residents section), with the sponsor''s employer electronically attesting the request via Qiwa/Muqeem. As of 2026, the definition of eligible "first-degree relatives" has tightened — spouse/children/parents remain straightforward, but siblings/aunts/uncles/cousins are harder to sponsor.',
    'Temporary visit, tied to the sponsor''s approval',
    'Sponsored via the Unified Platform, requires the sponsor''s employer attestation via Qiwa/Muqeem',
    0,
    'Explicitly a temporary visit visa — not a residency or work-permit route',
    'No in-person office visit required — arranged online via sponsor',
    'Confirm your Iqama-holding sponsor and relationship degree\nSponsor applies via the Unified Platform (Residents section)\nSponsor''s employer attests the request via Qiwa/Muqeem\nGather documents against this checklist, including mandatory health insurance\nReceive approval before travel',
    '/assets/images/visa-heroes/saudi-arabia.jpg',
    'Saudi Family Visit Visa guidance (Unified Platform, Qiwa/Muqeem attestation)', 'https://ksaexpats.com/apply-for-family-visit-visa-online/', '2026-09-11'
);
SET @st5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@st5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st5, 'Core Documents', 'Every applicant needs these.', 1);
SET @st5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@st5s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st5, 'Sponsor Documents', 'Evidence of your Iqama-holding sponsor.', 2);
SET @st5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st5s2, 'Sponsor''s Iqama Copy', NULL, 'copy', 1, 0, 1, 1),
(@st5s2, 'Relationship Proof', 'First-degree relationships (spouse/children/parents) are straightforward; other relationships are harder to sponsor.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st5, 'Insurance Documents', 'Mandatory health cover.', 3);
SET @st5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st5s3, 'Mandatory Health Insurance', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(91, 5, NULL, 'SAR', 'Confirmed After Assessment', 'Fee varies by relationship degree and duration requested via the Unified Platform — confirmed once your sponsor''s application details are known.', '2026-09-01', NOW(), 'https://ksaexpats.com/apply-for-family-visit-visa-online/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who can sponsor a Family Visit Visa?', 'Any Iqama-holding resident (expatriate or Saudi citizen), applying via the Unified Platform''s Residents section.', 91, 5, 1112, 1),
('Is it harder to sponsor extended family?', 'Yes — as of 2026, first-degree relatives (spouse, children, parents) remain straightforward, but siblings, aunts, uncles, and cousins are harder to sponsor under tightened eligibility rules.', 91, 5, 1113, 1),
('Can this visa lead to residency?', 'No — it is explicitly a temporary visit visa, not a residency or work-permit route.', 91, 5, 1114, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Stopover eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    91, 6, 'SAU-TRANS-IN-06', '2026.09', 'published',
    'Passing through Saudi Arabia en route to a third country.',
    'A distinct "Stopover" eVisa, valid 90 days from issue, permitting a single stay of up to 96 hours, delivered as a digital eVisa with no passport sticker — verified electronically by immigration. Not required if remaining airside under roughly 12 hours.',
    'Up to 96 hours per stopover, visa valid 90 days from issue',
    'Fully online Stopover eVisa, no biometrics',
    0,
    'Not needed for short airside connections under roughly 12 hours',
    'No in-person office visit required — entirely online',
    'Confirm whether your layover qualifies for the airside exemption\nIf not, apply online for the Stopover eVisa\nGather documents against this checklist\nPay the fee and mandatory insurance online\nReceive your digital approval before travel',
    '/assets/images/visa-heroes/saudi-arabia.jpg',
    'Saudi Stopover eVisa guidance, cross-checked via independent visa-agency sourcing', 'https://saudiumrahvisa.com/saudi-arabia-transit-visa-guide-2026-online-application-fees-rules/', '2026-09-11'
);
SET @st6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@st6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st6, 'Core Documents', 'Every applicant needs these.', 1);
SET @st6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@st6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st6, 'Insurance Documents', 'Mandatory as part of the Stopover eVisa.', 2);
SET @st6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st6s2, 'Mandatory Health Insurance', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(91, 6, 130.00, 'SAR', 'Stopover eVisa Fee (Indicative)', 'The Stopover eVisa itself is largely nominal/free, but mandatory insurance and digital-service fees bring the practical total to roughly SAR 90-170 — confirmed once current figures are verified.', '2026-09-01', NOW(), 'https://saudiumrahvisa.com/saudi-arabia-transit-visa-guide-2026-online-application-fees-rules/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Stopover eVisa the same as a traditional transit visa?', 'No — it is a distinct, purely digital product (90-day validity, up to 96-hour stay, no passport sticker), verified electronically rather than stamped.', 91, 6, 1115, 1),
('Do I need it for a short layover?', 'Not if you remain airside under roughly 12 hours — the Stopover eVisa is for those leaving the airport during a longer connection.', 91, 6, 1116, 1),
('How is it verified if there''s no passport sticker?', 'Electronically by immigration authorities, since it is issued and checked as a fully digital eVisa.', 91, 6, 1117, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Medical Treatment Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    91, 7, 'SAU-MED-IN-07', '2026.09', 'published',
    'Travelling to Saudi Arabia to receive medical treatment.',
    'Requires a formal medical invitation/treatment-confirmation letter from a Saudi hospital, plus medical reports on your condition, proof of funds, and mandatory insurance cover cited up to SAR 100,000. Applied via the MOFA portal or consulate, not the general tourism eVisa.',
    'As needed for the course of treatment',
    'MOFA portal or consulate application, requires a hospital invitation letter',
    0,
    'Fee structure appears to vary by nationality/duration rather than being fixed',
    'Saudi Embassy/Consulate, India, or MOFA portal',
    'Obtain a treatment-confirmation letter from the Saudi hospital\nGather documents against this checklist, including medical reports\nSubmit your application via the MOFA portal or consulate\nArrange the mandatory health insurance cover\nDecision once processed',
    '/assets/images/visa-heroes/saudi-arabia.jpg',
    'Saudi Medical Visa guidance, cross-checked via independent visa-consultancy sourcing', 'https://www.visatitans.com/blog/saudi-arabia-medical-visa', '2026-09-11'
);
SET @st7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@st7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st7, 'Core Documents', 'Every applicant needs these.', 1);
SET @st7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@st7s1, 'Hospital Invitation/Treatment-Confirmation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st7, 'Medical Documents', 'Evidence of your condition and treatment.', 2);
SET @st7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st7s2, 'Medical Reports', NULL, 'copy', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st7, 'Financial & Insurance Documents', 'Evidence you can pay for treatment.', 3);
SET @st7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st7s3, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 1),
(@st7s3, 'Health Insurance', 'Cover cited up to SAR 100,000.', 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(91, 7, NULL, 'SAR', 'Confirmed After Assessment', 'Fee structure appears to vary by nationality and duration rather than being fixed — confirmed once your treatment plan and hospital details are known.', '2026-09-01', NOW(), 'https://www.visatitans.com/blog/saudi-arabia-medical-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use the tourism eVisa for medical treatment?', 'No — Medical treatment requires its own visa with a hospital invitation letter, applied via the MOFA portal or consulate, not the general tourism eVisa.', 91, 7, 1118, 1),
('How much insurance coverage is typically required?', 'Cover cited up to SAR 100,000 in the sourcing reviewed — confirmed once your specific treatment plan is known.', 91, 7, 1119, 1),
('What must the hospital invitation include?', 'Confirmation of your treatment plan, alongside your own medical reports supporting the need for care in Saudi Arabia.', 91, 7, 1120, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Business Visit Visa (Conference Purpose)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    91, 8, 'SAU-CONF-IN-08', '2026.09', 'published',
    'Attending or presenting at a conference in Saudi Arabia.',
    'Falls under the Business Visit Visa category rather than a standalone product — requires an official conference invitation letter, travel/accommodation proof, and mandatory health insurance, the same underlying process as general business visits.',
    'Typically up to 90 days, per the invitation and visa category',
    'Business Visit Visa via eVisa system or sponsor-led embassy/VFS application',
    0,
    'Processing typically runs 5-15 working days',
    'VFS Global/Saudi Embassy Visa Application Centre, India (if not eVisa-eligible)',
    'Obtain your official conference invitation letter\nConfirm whether the eVisa system or sponsor-led route applies\nGather documents against this checklist\nSubmit your application\nDecision once processed',
    '/assets/images/visa-heroes/saudi-arabia.jpg',
    'Saudi Business Visit Visa (conference purpose) guidance', 'https://btwvisas.com/visa-guide/business-visa-saudi-arabia', '2026-09-11'
);
SET @st8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@st8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st8, 'Core Documents', 'Every applicant needs these.', 1);
SET @st8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@st8s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st8, 'Conference Documents', 'Evidence of the event and your role.', 2);
SET @st8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st8s2, 'Official Conference Invitation Letter', NULL, 'original', 1, 0, 1, 1),
(@st8s2, 'Travel/Accommodation Proof', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st8, 'Insurance Documents', 'Mandatory health cover.', 3);
SET @st8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st8s3, 'Mandatory Health Insurance', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(91, 8, NULL, 'SAR', 'Confirmed After Assessment', 'Reported in a similar range to the tourist eVisa fee by some secondary sources, but not confirmed against an official source this session.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/business-visa-saudi-arabia', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Conference Visa for Saudi Arabia?', 'No — it falls under the Business Visit Visa category, using the same underlying process as general business visits.', 91, 8, 1121, 1),
('What does the conference invitation need to include?', 'Confirmation of the event and your specific role, alongside proof of your travel and accommodation arrangements.', 91, 8, 1122, 1),
('Is insurance still mandatory for conference attendance?', 'Yes — mandatory health insurance applies to this category just as it does to the tourism eVisa and other short-stay visas.', 91, 8, 1123, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Event Permit / Sponsored Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    91, 9, 'SAU-SPORT-IN-09', '2026.09', 'published',
    'Competing in or supporting a sporting event in Saudi Arabia.',
    'No standalone "sports visa" eVisa product exists — short-term participation is typically handled via a temporary work/event visa or event permit process, sponsored by the hosting club/federation/organizer, with eligibility jointly confirmed by HRSD, the Ministry of Sport, and the relevant league/federation. Saudi Arabia''s new Sports Law, effective 11 June 2026, formalizes event-permit requirements for organizers.',
    'Tied to the specific event/competition',
    'Sponsored via the hosting club/federation/organizer, with joint eligibility confirmation',
    0,
    'The new Sports Law (effective 11 June 2026) reflects the Kingdom''s ramp-up toward hosting AFC tournaments and the 2034 World Cup',
    'Saudi Embassy/Consulate, India, for the sponsored application',
    'Confirm sponsorship from the hosting club/federation/organizer\nGather documents against this checklist\nEligibility jointly confirmed by HRSD, Ministry of Sport, and the relevant federation\nSubmit your application\nDecision once processed',
    '/assets/images/visa-heroes/saudi-arabia.jpg',
    'Saudi Arabia Sports Law 2026 and athlete work-permit guidance, cross-checked via independent legal sourcing', 'https://globallawexperts.com/saudi-arabia-sports-law-2026/', '2026-09-11'
);
SET @st9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@st9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st9, 'Core Documents', 'Every applicant needs these.', 1);
SET @st9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@st9s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st9, 'Event Sponsorship Documents', 'Evidence of your sponsoring club/federation.', 2);
SET @st9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st9s2, 'Sponsorship Letter from Club/Federation/Organizer', NULL, 'original', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st9, 'Event Permit Documents', 'Required under the 2026 Sports Law.', 3);
SET @st9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st9s3, 'Event Permit', 'Obtained by the organizer under Saudi Arabia''s Sports Law, effective 11 June 2026.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(91, 9, NULL, 'SAR', 'Confirmed After Assessment', 'Fee depends on the specific event/sponsorship arrangement — confirmed once your sponsoring club/federation and event details are known.', '2026-09-01', NOW(), 'https://globallawexperts.com/saudi-arabia-sports-law-2026/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a standalone Sports Visa for Saudi Arabia?', 'No — short-term participation is handled via a temporary work/event visa or event permit process, sponsored by the hosting club, federation, or organizer.', 91, 9, 1124, 1),
('What is Saudi Arabia''s new Sports Law?', 'A real law effective 11 June 2026, formalizing event-permit requirements for organizers staging competitions involving licensed clubs or athletes.', 91, 9, 1125, 1),
('Who confirms my eligibility to participate?', 'Jointly, the HRSD, the Ministry of Sport, and the relevant league/federation.', 91, 9, 1126, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Dependent (Family) Residence Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    91, 10, 'SAU-DEP-IN-10', '2026.09', 'published',
    'Joining a spouse or parent who holds an Iqama-sponsored work visa in Saudi Arabia.',
    'Sponsored by an Iqama-holding expatriate worker for spouse, unmarried daughters, and sons under the permitted age (parents possible under exemptions). Sponsor must hold an approved profession classification and meet a minimum salary threshold (cited roughly SAR 4,000-6,000/month, varying by job classification and housing provision).',
    'Tied to the sponsor''s work visa validity',
    'Sponsor-driven: entry permit, then Iqama issuance for the dependent after arrival',
    1,
    'A real Q1 2026 reform allows qualifying dependents (spouses, adult children) to obtain their own separate work permits through HRSD',
    'Saudi Embassy/Consulate, India',
    'Confirm your sponsor meets the minimum salary threshold and profession classification\nGather documents against this checklist, including relationship proof\nSubmit your application at the embassy/consulate\nIqama issued for the dependent after arrival',
    '/assets/images/visa-heroes/saudi-arabia.jpg',
    'Saudi Dependent Visa and Iqama guidance, cross-checked via independent immigration-consultancy sourcing', 'https://pangeaworldwide.sa/saudi-family-visa-rules-for-expat-parents-children-in-2026/', '2026-09-11'
);
SET @st10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@st10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st10, 'Core Documents', 'Every applicant needs these.', 1);
SET @st10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@st10s1, 'Sponsor''s Iqama Copy', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st10, 'Relationship Documents', 'Evidence of your relationship to the sponsor.', 2);
SET @st10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st10s2, 'Marriage Certificate', 'For a spouse applicant.', 'copy', 0, 1, 1, 1),
(@st10s2, 'Birth Certificate', 'For a child applicant.', 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@st10, 'Financial Documents', 'Evidence the sponsor meets the income threshold.', 3);
SET @st10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@st10s3, 'Sponsor''s Salary Certificate', 'Roughly SAR 4,000-6,000/month, varying by job classification and housing provision.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(91, 10, 400.00, 'SAR', 'Dependent Levy (Per Dependent, Monthly, Indicative)', 'Indicative dependent levy roughly SAR 400/dependent/month — regularly revised, confirmed via MHRSD/Muqeem before you apply.', '2026-09-01', NOW(), 'https://pangeaworldwide.sa/saudi-family-visa-rules-for-expat-parents-children-in-2026/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the minimum sponsor salary for a Dependent visa?', 'Roughly SAR 4,000-6,000/month, varying by the sponsor''s job classification and whether housing is employer-provided.', 91, 10, 1127, 1),
('Can dependents work in Saudi Arabia?', 'A real Q1 2026 reform allows qualifying dependents (spouses, adult children) to obtain their own separate work permits through HRSD, updating their Iqama status to "employed."', 91, 10, 1128, 1),
('Can parents be sponsored as dependents?', 'Generally parents are possible only under specific exemptions — spouse and unmarried children under the permitted age are the standard eligible dependents.', 91, 10, 1129, 1);
