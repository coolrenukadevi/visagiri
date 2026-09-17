-- Romania Visa Checklist Engine content for all 10 visa types — built this
-- session via WebSearch (result snippets and cross-source triangulation).
-- hero_image_url left NULL at authoring time (no photo bundle supplied yet).
--
-- IMPORTANT SOURCING CAVEAT: direct WebFetch of mae.ro, newdelhi.mae.ro,
-- btwvisas.com, lexvisas.in, navigatemigrate.com, and services.vfsglobal.com
-- was BLOCKED by the network egress proxy this session. All content below
-- is triangulated from WebSearch result snippets (official mae.ro/eviza.mae.ro
-- fee-schedule text surfaced in search results, an official embassy circular
-- mirrored at colombo.mae.ro, EU Council/Commission press releases, IGI
-- (Inspectorate General for Immigration) pages, and secondary visa-agency /
-- relocation-consultancy sourcing). Figures are cross-checked across at
-- least two independent snippets where possible; anything not corroborated
-- is explicitly flagged inline as approximate or unconfirmed.
--
-- ROMANIA'S GENUINE, VERIFIED DISTINCTIVE FACTS (this corrects an outdated
-- premise — Romania is NOT a partial Schengen member any more):
--   - Romania became a FULL Schengen member on 1 January 2025, including
--     LAND borders (air/sea borders had already joined in March 2024, per
--     the EU Council's 12 Dec 2024 decision). As of this review, a
--     Romania-issued Schengen visa is a genuine Type C visa valid for
--     travel across the entire 29-country Schengen area, not a Romania-only
--     national short-stay visa. Many older secondary sources still describe
--     Romania as "not fully Schengen" — that is now out of date.
--   - Romania's long-stay (Type D) national visa fee is confirmed to rise
--     to EUR 300 for applications submitted via the eViza online portal to
--     Romanian diplomatic missions/consular posts, EFFECTIVE 27 APRIL 2026
--     — corroborated by an official embassy circular ("Important Update
--     regarding long-stay (D-type) visa fees", mirrored at colombo.mae.ro)
--     and eviza.mae.ro's own fee page. This is a genuine, dated, India-
--     relevant change since it applies to Student, Work, and Dependent
--     (family reunification) applicants alike.
--   - Romania set its 2026 annual non-EU/EEA foreign-worker quota at 90,000
--     permits — 10,000 FEWER than 2025 — despite ongoing shortages in
--     construction, manufacturing/HoReCa, and logistics. The work-visa
--     structure was reorganised into two tracks: D/AM1 (highly qualified,
--     NOT subject to the annual quota) and D/AM2 (general labour, capped by
--     the quota and a government Shortage Occupations List), processed via
--     the WorkinRomania.gov.ro digital platform rolling out April-August
--     2026. Secondary sources describe substantial recent recruitment of
--     Indian workers into Romanian construction/hospitality/agriculture,
--     but specific Indian-worker headcount figures could NOT be
--     independently verified this session and are deliberately omitted
--     rather than invented.
--   - VFS Global's exact multi-city footprint for Romania visas in India
--     could not be fully confirmed this session — one source describes a
--     New Delhi VAC address, another states VFS Global "is not currently
--     providing services for a Romania visa to Delhi residents ... will
--     support Romanian visa applications soon." This conflict is flagged
--     in the application_method field of every category below rather than
--     asserted as settled fact.
--   - Long-stay (D-type) categories — Student (D/SD), Work (D/AM1/D/AM2),
--     and Dependent/family reunification (D/VF) — are Romania's OWN
--     national visa instruments (as with any Schengen state), applied for
--     via the eViza portal and in person at the Embassy of Romania, New
--     Delhi, NOT via VFS Global — mirroring the split channel structure
--     seen in other Schengen countries' checklists on this platform.
--
-- country_id 141 = Romania. visa_type_id: 1=Tourist, 2=Business, 3=Student,
-- 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference, 9=Sports,
-- 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    141, 1, 'ROU-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Romania.',
    'Indian passport holders travelling for tourism. Romania issues a standard Schengen C-type visa, having become a FULL Schengen member (including land borders) on 1 January 2025 — the visa is valid across the entire Schengen area, not just Romania.',
    'Single or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global (New Delhi) or directly at the Romanian Embassy; coverage in other Indian cities is unconfirmed this session',
    1,
    'Standard Schengen processing is typically 15 calendar days, extendable to 30-45 days in complex cases',
    'Embassy of Romania, New Delhi (decision authority), via VFS Global Visa Application Centre',
    'Book an appointment via VFS Global or the embassy\nComplete the online Schengen visa application form\nGather supporting documents\nAttend the appointment and submit biometrics (mandatory for first-time applicants)\nTrack status and collect your passport',
    '/assets/images/visa-heroes/romania.webp',
    'WebSearch-triangulated from mae.ro fee-schedule snippets and EU Council press material on full Schengen accession; direct fetch of mae.ro/newdelhi.mae.ro blocked this session (egress proxy)', 'https://www.consilium.europa.eu/en/press/press-releases/2024/12/12/schengen-council-decides-to-lift-land-border-controls-with-bulgaria-and-romania/', '2026-09-17'
);
SET @rou1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rou1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou1, 'Core Documents', 'Required from every applicant.', 1);
SET @rou1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou1s1, 'Valid Passport (3+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@rou1s1, 'Completed Schengen Visa Application Form', NULL, 'both', 1, 0, 1, 2),
(@rou1s1, 'Schengen Travel Medical Insurance (Min. EUR 30,000 Cover)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @rou1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou1s2, 'Confirmed Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@rou1s2, 'Hotel Booking / Accommodation Proof', NULL, 'copy', 1, 0, 0, 2),
(@rou1s2, 'Bank Statement (Last 6 Months)', 'Roughly EUR 500 minimum balance plus EUR 50/day of stay reported by secondary sources.', 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(141, 1, 90.00, 'EUR', 'Standard Schengen Short-Stay (Type C) Visa Fee', 'Some sources cite EUR 80 for this figure; children aged 6-12 reportedly pay EUR 40 and under-6s are free. A separate VFS Global service charge also applies.', '2026-09-01', NOW(), 'https://www.mae.ro/en/node/2061', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a Romania Tourist visa let me travel elsewhere in Europe?', 'Yes — since Romania became a full Schengen member on 1 January 2025 (including land borders), a Romania-issued Schengen C-type visa is valid across the entire Schengen area, subject to the standard 90-days-in-180 rule.', 141, 1, 14100, 1),
('Is Romania still only a "partial" Schengen member?', 'No — that was true from March 2024 (air/sea borders only) but changed on 1 January 2025, when land-border checks were also lifted. Romania is now a full Schengen member for all border types.', 141, 1, 14101, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    141, 2, 'ROU-BUS-IN-02', '2026.09', 'published',
    'Trade negotiations, meetings, and commercial activity in Romania.',
    'Indian nationals travelling for business — the same Schengen C-type visa as Tourist, differentiated by a company invitation letter and employer sponsorship documentation.',
    'Single, double, or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global (New Delhi) or directly at the Romanian Embassy with a business invitation letter',
    1,
    'Standard Schengen processing is typically 15 calendar days',
    'Embassy of Romania, New Delhi, via VFS Global Visa Application Centre',
    'Obtain an invitation letter from the Romanian host company\nGather Indian employer forwarding/sponsorship letter\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global or the embassy',
    '/assets/images/visa-heroes/romania.webp',
    'WebSearch-triangulated from mae.ro fee-schedule snippets and visa-agency secondary sourcing; direct fetch of mae.ro/newdelhi.mae.ro blocked this session (egress proxy)', 'https://www.mae.ro/en/node/2035', '2026-09-17'
);
SET @rou2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rou2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou2, 'Core Documents', 'Required from every applicant.', 1);
SET @rou2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@rou2s1, 'Invitation Letter from Romanian Host Company', NULL, 'original', 1, 0, 1, 2),
(@rou2s1, 'Schengen Travel Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @rou2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@rou2s2, 'Business Registration / Incorporation Proof', NULL, 'copy', 0, 1, 0, 2),
(@rou2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(141, 2, 90.00, 'EUR', 'Standard Schengen Short-Stay (Type C) Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://www.mae.ro/en/node/2061', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use a Business visa for a single trade fair visit only?', 'The C-type visa covers business generally, not a single event — it is valid for multiple entries up to 90/180 days, provided each visit is backed by a valid invitation.', 141, 2, 14102, 1),
('Does the invitation letter need to be in Romanian?', 'This was not independently confirmed this session — secondary sourcing suggests English is commonly accepted, but confirm the current requirement with your host company or the embassy before applying.', 141, 2, 14103, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Long-Stay Visa (Symbol D/SD)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    141, 3, 'ROU-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Romanian university or accredited institution.',
    'Indian nationals admitted to a Romanian institution, requiring the national long-stay Study visa (symbol D/SD). This is Romania''s own national instrument, not a Schengen product, and converts to a residence permit for the study duration.',
    'Initial visa validity up to 90 days for entry; converts to a residence permit for the full program duration',
    'Apply via the eViza online portal, then in person at the Embassy of Romania, New Delhi — NOT via VFS Global',
    1,
    'Reported at 2-4 weeks for the visa decision itself; the full process from university acceptance can take 2-3 months',
    'Embassy of Romania, New Delhi',
    'Secure admission and a Letter of Acceptance from the Romanian Ministry of Education\nSubmit the application via the eViza portal\nGather proof of funds and health insurance\nAttend an in-person appointment/interview at the embassy (not VFS)\nCollect the D/SD visa, travel, then register for a residence permit in Romania',
    '/assets/images/visa-heroes/romania.webp',
    'WebSearch-triangulated from eviza.mae.ro fee-page snippets and university/education-consultancy secondary sourcing; direct fetch of mae.ro blocked this session (egress proxy)', 'https://eviza.mae.ro/en/VisaFees', '2026-09-17'
);
SET @rou3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rou3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou3, 'Core Documents', 'Required from every applicant.', 1);
SET @rou3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@rou3s1, 'Letter of Acceptance from Romanian Ministry of Education', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @rou3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou3s2, 'Academic Transcripts/Certificates (Apostilled/Notarized Translation)', NULL, 'copy', 1, 0, 0, 1),
(@rou3s2, 'Proof of Funds (Approx. EUR 2,500-5,000/Year)', NULL, 'copy', 1, 0, 0, 2),
(@rou3s2, 'Health Insurance Valid in Romania', NULL, 'original', 1, 0, 0, 3),
(@rou3s2, 'Proof of Tuition Fee Payment', NULL, 'copy', 1, 0, 0, 4),
(@rou3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 5);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(141, 3, 300.00, 'EUR', 'Long-Stay (D-Type) Visa Fee — eViza Portal', 'Confirmed rising to EUR 300 for applications submitted via the eViza portal effective 27 April 2026, per an official embassy circular; older sources cite a lower pre-2026 figure (approx. EUR 120), which no longer applies.', '2026-04-27', NOW(), 'https://eviza.mae.ro/en/VisaFees', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Why did the Student visa fee change in 2026?', 'Romania''s long-stay (D-type) visa fee for applications submitted via the eViza online portal rose to EUR 300, effective 27 April 2026, per an official embassy circular — a genuine, dated fee increase applicants should budget for.', 141, 3, 14104, 1),
('Can international students in Romania work while studying?', 'This was NOT independently confirmed this session — secondary sourcing on part-time work rights for Romanian student-visa holders was not consistently corroborated, so confirm current rules with your institution or the embassy.', 141, 3, 14105, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Long-Stay Employment Visa (D/AM1, D/AM2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    141, 4, 'ROU-WORK-IN-04', '2026.09', 'published',
    'Employment with a Romanian employer via the national long-stay work visa (symbol D/AM).',
    'Indian nationals with a confirmed job offer. Romania''s 2026 annual quota for non-EU/EEA workers is 90,000 permits (10,000 fewer than 2025), split into two tracks: D/AM1 (highly qualified, no quota) and D/AM2 (general labour, capped by the quota and a Shortage Occupations List).',
    'Visa valid for entry; the residence permit tied to the work authorization is typically renewable annually',
    'Employer-driven via WorkinRomania.gov.ro; applicant applies for the D/AM visa via eViza and in person at the Embassy of Romania (not VFS)',
    1,
    'Reported in the range of several weeks to a few months; the WorkinRomania.gov.ro digital platform is rolling out April-August 2026 and may change timelines',
    'Embassy of Romania, New Delhi (decision); residence permit collected from IGI after arrival',
    'Secure a job offer from a Romanian employer\nEmployer obtains work authorization from the Inspectorate General for Immigration (IGI), via WorkinRomania.gov.ro\nApply for the D/AM visa via eViza and attend an in-person appointment at the Embassy of Romania\nTravel to Romania on the D/AM visa\nRegister with IGI for the residence permit tied to your work authorization',
    '/assets/images/visa-heroes/romania.webp',
    'WebSearch-triangulated from relocation-consultancy reporting on the 2026 quota and IGI sourcing; direct fetch blocked this session — Indian-worker headcount figures unverified, omitted', 'https://igi.mai.gov.ro/en/business-activities/', '2026-09-17'
);
SET @rou4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rou4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou4, 'Core Documents', 'Required from every applicant.', 1);
SET @rou4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@rou4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@rou4s1, 'IGI Work Authorization (via WorkinRomania.gov.ro)', 'Obtained by the Romanian employer before the visa application; track D/AM1 (highly qualified, no quota) or D/AM2 (general labour, quota-capped).', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @rou4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@rou4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@rou4s2, 'Proof of Accommodation in Romania', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(141, 4, 300.00, 'EUR', 'Long-Stay (D-Type) Visa Fee — eViza Portal', 'The applicant-side D/AM visa fee rose to EUR 300 via the eViza portal effective 27 April 2026. A separate, RON-denominated work-authorization fee is paid by the employer to IGI and is not captured in this figure.', '2026-04-27', NOW(), 'https://eviza.mae.ro/en/VisaFees', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Romania''s 2026 foreign-worker quota bigger or smaller than 2025?', 'Smaller — the 2026 quota is 90,000 non-EU/EEA work permits, 10,000 fewer than in 2025, despite continued labour shortages in construction, manufacturing, and hospitality.', 141, 4, 14106, 1),
('What is the difference between D/AM1 and D/AM2?', 'D/AM1 covers highly qualified workers and is NOT subject to the annual quota. D/AM2 covers general labour and IS capped by the yearly quota and a government Shortage Occupations List.', 141, 4, 14107, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    141, 5, 'ROU-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Romania for up to 90 days.',
    'Indian nationals visiting family/friends short-term — the same Schengen C-type visa as Tourist, requiring an invitation letter and proof of relationship. Distinct from the Dependent (family reunification, D/VF) category used for joining a sponsor long-term.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global (New Delhi) or directly at the Romanian Embassy with an invitation letter and relationship proof',
    1,
    'Standard Schengen processing is typically 15 calendar days',
    'Embassy of Romania, New Delhi, via VFS Global Visa Application Centre',
    'Obtain an invitation letter from your host in Romania\nGather documents proving the family relationship\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global or the embassy',
    '/assets/images/visa-heroes/romania.webp',
    'WebSearch-triangulated from mae.ro fee-schedule snippets and visa-agency secondary sourcing; direct fetch of mae.ro/newdelhi.mae.ro blocked this session (egress proxy)', 'https://www.mae.ro/en/node/2035', '2026-09-17'
);
SET @rou5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rou5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou5, 'Core Documents', 'Required from every applicant.', 1);
SET @rou5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@rou5s1, 'Invitation Letter from Host in Romania', NULL, 'original', 1, 0, 1, 2),
(@rou5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @rou5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@rou5s2, 'Schengen Travel Medical Insurance', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(141, 5, 90.00, 'EUR', 'Standard Schengen Short-Stay (Type C) Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://www.mae.ro/en/node/2061', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Family Visit visa the same as a Dependent visa?', 'No — Family Visit is a short-stay Schengen C-type visa for visiting relatives up to 90 days. Dependent (family reunification, D/VF) is a long-stay national visa for joining a sponsor permanently, with different eligibility and fees.', 141, 5, 14108, 1),
('Does the host need special Romanian residency status to invite me?', 'This was not independently confirmed this session for Romania specifically — confirm the current invitation-letter requirements (and whether police-verification is needed) with the embassy or your host before applying.', 141, 5, 14109, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Type A Airport Transit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    141, 6, 'ROU-TRAN-IN-06', '2026.09', 'published',
    'Passing through a Romanian airport (e.g. Bucharest Otopeni) airside-to-airside toward a non-Schengen destination.',
    'A distinct Type A Airport Transit Visa, needed only if staying in the international transit zone (up to ~5 days per reports). Exempt if holding a valid Schengen visa/residence permit, or one from Bulgaria, Cyprus, Ireland, the UK (BRP), the USA, Canada, or Japan.',
    'Transit window only; visa itself may be issued for a longer validity/multiple entries',
    'Apply via VFS Global (New Delhi) or directly at the Romanian Embassy, only if a Type A visa is genuinely required for your connection',
    1,
    'Standard Schengen-adjacent processing reported at around 15 calendar days',
    'Embassy of Romania, New Delhi, via VFS Global Visa Application Centre',
    'Confirm whether your specific connection requires a Type A visa (check exemption list first)\nIf required, apply with your onward ticket and itinerary\nSubmit biometrics if required',
    '/assets/images/visa-heroes/romania.webp',
    'WebSearch-triangulated from Romanian Border Police (politiadefrontiera.ro) exemption-list secondary sourcing and visa-agency guidance; direct fetch of primary sites blocked this session (egress proxy)', 'https://www.politiadefrontiera.ro/en/main/pg-conditions-in-which-foreign-citizens-can-transit-through-romania-and-travel-to-romania-without-a-visa-184.html', '2026-09-17'
);
SET @rou6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rou6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou6, 'Core Documents', 'Required if a Type A visa is genuinely needed.', 1);
SET @rou6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@rou6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @rou6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1),
(@rou6s2, 'Proof of Exemption (Valid Schengen/Other Visa or Residence Permit)', 'Only if claiming exemption from the Type A requirement.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(141, 6, 80.00, 'EUR', 'Airport Transit (Type A) Visa Fee (Approximate)', 'Figure surfaced via secondary sourcing alongside the Schengen fee schedule; confirm before applying since some sources bundle it with the C-visa fee.', '2026-09-01', NOW(), 'https://www.mae.ro/en/node/2061', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a Type A visa let me leave the airport in Romania?', 'No — a Type A visa only authorizes remaining in the international transit zone; it does not permit passing through Romanian passport control or entering the country.', 141, 6, 14110, 1),
('Am I exempt from the Romanian Type A visa if I already hold a Schengen visa?', 'Reported yes — holders of a valid Schengen-area visa or residence permit (and a few other listed countries'' permits) are generally exempt from Romania''s airport transit visa requirement. Confirm your specific case with the embassy.', 141, 6, 14111, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen C-Type (D/AS if long-term)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    141, 7, 'ROU-MED-IN-07', '2026.09', 'published',
    'Travel to Romania for medical treatment.',
    'Indian nationals travelling for treatment — the same Schengen C-type visa as Tourist for stays under 90 days, requiring a certificate from the treating Romanian doctor/institution. Treatment expected to exceed 90 days reportedly falls under the D/AS long-stay "other purposes" visa instead.',
    'Up to 90 days within any 180-day period (short-stay C); longer treatment uses the D/AS long-stay route',
    'Apply via VFS Global (New Delhi) or directly at the Romanian Embassy with the medical certificate and insurance',
    1,
    'Standard Schengen processing is typically 15 calendar days; can extend if documentation is incomplete',
    'Embassy of Romania, New Delhi, via VFS Global Visa Application Centre',
    'Obtain a certificate from the treating Romanian doctor/institution\nArrange Schengen-compliant travel insurance (min. EUR 30,000 cover)\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global or the embassy',
    '/assets/images/visa-heroes/romania.webp',
    'WebSearch-triangulated from mae.ro long-stay-visa-symbol snippets (D/AS "other purposes") and visa-agency secondary sourcing; direct fetch of mae.ro blocked this session (egress proxy)', 'https://www.mae.ro/en/node/2054', '2026-09-17'
);
SET @rou7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rou7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou7, 'Core Documents', 'Required from every applicant.', 1);
SET @rou7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@rou7s1, 'Medical Certificate/Institution Confirmation', NULL, 'original', 1, 0, 1, 2),
(@rou7s1, 'Schengen Travel Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @rou7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@rou7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2),
(@rou7s2, 'Attendant/Companion Documents (If Applicable)', NULL, 'if_applicable', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(141, 7, 90.00, 'EUR', 'Standard Schengen Short-Stay (Type C) Visa Fee', 'Same fee structure as Tourist for stays under 90 days; longer treatment under the D/AS long-stay route would instead attract the EUR 300 D-type visa fee (effective 27 Apr 2026).', '2026-09-01', NOW(), 'https://www.mae.ro/en/node/2061', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What if my treatment in Romania will take longer than 90 days?', 'Reported sourcing indicates long-term treatment falls under the D/AS ("other purposes") long-stay national visa rather than the short-stay Schengen C visa — this was not independently confirmed this session, so verify with the embassy before booking treatment.', 141, 7, 14112, 1),
('Do I need a Romania-specific medical certificate format?', 'This was not independently confirmed this session — obtain written confirmation of the required treatment directly from the Romanian hospital/clinic and check the current format with the embassy.', 141, 7, 14113, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    141, 8, 'ROU-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade fairs in Romania.',
    'Indian nationals attending a conference — the same Schengen C-type visa as Tourist/Business, requiring a conference invitation or registration confirmation in place of a hotel-only itinerary.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global (New Delhi) or directly at the Romanian Embassy with a conference invitation/registration confirmation',
    1,
    'Standard Schengen processing is typically 15 calendar days',
    'Embassy of Romania, New Delhi, via VFS Global Visa Application Centre',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global or the embassy',
    '/assets/images/visa-heroes/romania.webp',
    'WebSearch-triangulated from mae.ro fee-schedule snippets and visa-agency secondary sourcing; direct fetch of mae.ro/newdelhi.mae.ro blocked this session (egress proxy)', 'https://www.mae.ro/en/node/2035', '2026-09-17'
);
SET @rou8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rou8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou8, 'Core Documents', 'Required from every applicant.', 1);
SET @rou8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@rou8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @rou8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@rou8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(141, 8, 90.00, 'EUR', 'Standard Schengen Short-Stay (Type C) Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://www.mae.ro/en/node/2061', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Conference visa category under Romanian law?', 'Not as a distinct visa symbol for short stays — Conference attendance is processed under the same short-stay Schengen C-type visa as Tourist/Business, differentiated only by the supporting invitation document.', 141, 8, 14114, 1),
('Can I extend my stay if the conference runs longer than planned?', 'This was not independently confirmed this session for Romania specifically — extensions within Schengen short-stay visas are generally limited; check with the embassy before your trip if you expect this.', 141, 8, 14115, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    141, 9, 'ROU-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Romania.',
    'Indian nationals competing or officiating — the same Schengen C-type visa as Tourist/Conference, typically requiring a letter from the home-country sports association and an invitation from the host event organizer.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global (New Delhi) or directly at the Romanian Embassy with association and organizer letters',
    1,
    'Standard Schengen processing is typically 15 calendar days',
    'Embassy of Romania, New Delhi, via VFS Global Visa Application Centre',
    'Obtain a letter from your resident-country athletic association confirming your role\nObtain an invitation letter from the host event organizer with event details\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global or the embassy',
    '/assets/images/visa-heroes/romania.webp',
    'WebSearch-triangulated from mae.ro fee-schedule snippets and general Schengen sports-event checklist patterns; direct fetch blocked this session — Romania-specific wording unconfirmed', 'https://www.mae.ro/en/node/2035', '2026-09-17'
);
SET @rou9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rou9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou9, 'Core Documents', 'Required from every applicant.', 1);
SET @rou9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@rou9s1, 'Home-Country Sports Association Letter', 'Confirms role and no-employment status.', 'original', 1, 0, 1, 2),
(@rou9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @rou9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1),
(@rou9s2, 'Proof of Funds/Expense Arrangement', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(141, 9, 90.00, 'EUR', 'Standard Schengen Short-Stay (Type C) Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://www.mae.ro/en/node/2061', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the Sports visa require anything beyond a standard invitation letter?', 'Typically yes — in addition to a host-organizer invitation, applicants are commonly asked for a letter from their home-country sports association confirming their competing/officiating role and that they are not being employed locally.', 141, 9, 14116, 1),
('Is there a group/team discount on Sports visa fees?', 'This was not independently confirmed this session for Romania specifically — check with the embassy or VFS Global for any team-delegation processing arrangements before a large group applies.', 141, 9, 14117, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification (Symbol D/VF)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    141, 10, 'ROU-DEP-IN-10', '2026.09', 'published',
    'Spouse, minor children, or other eligible dependants joining an Indian sponsor lawfully resident in Romania.',
    'Family members of an Indian national holding a qualifying temporary residence permit (1+ year), EU Blue Card, ICT/mobile-ICT permit, or long-term residence permit. Sponsor income must reportedly reach at least the national gross minimum wage per sponsored family member.',
    'Tied to the sponsor''s permit validity; converts to a residence permit on arrival',
    'Apply via the eViza online portal, then in person at the Embassy of Romania, New Delhi — the D/VF long-stay route, not VFS Global',
    1,
    'Long-stay processing generally takes longer than short-stay Schengen applications; exact reported timeframe was not independently confirmed this session',
    'Embassy of Romania, New Delhi',
    'Confirm the sponsor holds a qualifying Romanian residence permit and meets the income threshold\nGather relationship proof (marriage/birth certificates, apostilled/translated) and the sponsor''s permit copy\nSubmit the application via the eViza portal\nAttend an in-person appointment at the embassy (not VFS)\nTravel to Romania and register for a residence permit',
    '/assets/images/visa-heroes/romania.webp',
    'WebSearch-triangulated from IGI (Inspectorate General for Immigration) family-reunification pages and eviza.mae.ro fee-page snippets; direct fetch of igi.mai.gov.ro/eviza.mae.ro blocked this session (egress proxy)', 'https://igi.mai.gov.ro/en/family-reunification-2/', '2026-09-17'
);
SET @rou10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rou10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou10, 'Core Documents', 'Required from every applicant.', 1);
SET @rou10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@rou10s1, 'Proof of Relationship to Sponsor (Marriage/Birth Certificate, Apostilled)', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rou10, 'Supporting Documents', 'Evidence tied to the sponsor''s status and finances.', 2);
SET @rou10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rou10s2, 'Sponsor''s Residence Permit/EU Blue Card/ICT Card Copy', NULL, 'copy', 1, 0, 0, 1),
(@rou10s2, 'Proof of Sponsor Income (At Least National Gross Minimum Wage per Dependant)', NULL, 'copy', 1, 0, 0, 2),
(@rou10s2, 'Statement of Cohabitation Intent', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(141, 10, 300.00, 'EUR', 'Long-Stay (D-Type) Visa Fee — eViza Portal', 'Confirmed rising to EUR 300 for D-type long-stay applications (including family reunification) submitted via the eViza portal, effective 27 April 2026, per an official embassy circular.', '2026-04-27', NOW(), 'https://eviza.mae.ro/en/VisaFees', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Which of my sponsor''s Romanian permits qualify me for family reunification?', 'Reported qualifying permits include a temporary residence permit valid for at least one year, an EU Blue Card, an ICT or "mobile ICT" permit, or a long-term residence permit. Confirm your sponsor''s exact permit qualifies before applying.', 141, 10, 14118, 1),
('Can adult children be sponsored as dependants?', 'Reported yes, but only unmarried adult children (and those of the sponsor''s spouse) who are unable to care for themselves due to medical reasons — this is narrower than minor-child eligibility, so verify against your specific circumstances.', 141, 10, 14119, 1);
