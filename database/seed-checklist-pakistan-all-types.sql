-- Pakistan Visa Checklist Engine content for all 10 visa types — built
-- this session via web search. hero_image_url left NULL (no photo bundle
-- supplied yet for this batch).
--
-- IMPORTANT SOURCING CAVEAT: india.org.pk (High Commission of India,
-- Islamabad), fragomen.com, and unanswered.io were NOT directly
-- fetchable this session (network egress blocked) — findings are
-- triangulated from WebSearch-indexed reporting (EY, Gulf News, Al
-- Jazeera, India TV News, ESPNcricinfo, Chatham House, DD News,
-- newsonair.gov.in) and cross-checked across multiple outlets where
-- possible. Historical/pre-2025 documentary requirements (city-specific
-- permits, police reporting, etc.) reflect general background knowledge
-- of the 1974 bilateral Visa Agreement and are NOT independently
-- re-verified as currently in force, since the categories they'd apply
-- to are themselves currently suspended.
--
-- Flagged as NOT independently confirmed this session (treat with extra
-- caution, do not assume the negative finding is exhaustive):
--   - Medical (visa_type_id 7): no evidence found this session of an
--     active humanitarian medical-visa exception for INDIANS travelling
--     TO Pakistan (the well-documented case-by-case humanitarian flow
--     runs the other way — Pakistani patients travelling to India).
--   - Student, Work, Dependent (visa_type_id 3, 4, 10): this session
--     found no evidence of a standing, active pathway in either
--     direction even before the 2025 suspension; flagged as under-
--     sourced rather than asserted as definitively nonexistent.
--
-- CURRENT BILATERAL CONTEXT (as verified this session, September 2026):
--   - On 22 April 2025, a terror attack in Pahalgam, Jammu & Kashmir
--     killed 26 civilians. India responded by suspending all visa
--     services to Pakistani nationals and revoking existing Indian
--     visas held by Pakistanis (effective 27 April 2025), with a narrow
--     carve-out for existing Long-Term Visas held by Hindu Pakistani
--     nationals already in India.
--   - Pakistan reciprocated: it cancelled visas issued to Indian
--     nationals, revoked the SAARC Visa Exemption Scheme for Indians,
--     closed the Attari-Wagah land border to general traffic, closed
--     its airspace to Indian-origin/Indian-owned aircraft, and
--     suspended trade — explicitly carving out an exception only for
--     Sikh religious pilgrims.
--   - A US-brokered military ceasefire has held since May 2025, but
--     trade, people-to-people contact, and diplomatic relations have
--     remained suspended. As of September 2026, sources indicate the
--     visa suspension remains in effect with no confirmed reversal; a
--     7 September 2026 Pakistani Foreign Office statement still
--     rejected India's position on Kashmir, showing no normalization.
--   - A brief, informal handshake between India's EAM S. Jaishankar and
--     Pakistan National Assembly Speaker Ayaz Sadiq occurred at a
--     funeral in Dhaka on 31 December 2025 — a noted diplomatic
--     gesture, but not evidence of resumed visa or dialogue channels.
--
-- GENUINELY DISTINCTIVE, VERIFIED FACTS USED IN THIS FILE:
--   - The Kartarpur Corridor (the visa-free pilgrim corridor to Gurdwara
--     Darbar Sahib) itself REMAINED CLOSED through the period covered by
--     this research. Despite that, Pakistan issued 2,800+ (reports
--     range up to 6,700+ with extra approvals) 10-day visas to Indian
--     Sikh pilgrim jathas (organized via SGPC/DSGMC/HSGMC) for Baisakhi
--     in April 2026, travelling via the Attari-Wagah land route under
--     police escort — under the separate, older 1974 Bilateral Protocol
--     on Visits to Religious Shrines. This is the one clearly-documented
--     channel that kept functioning through the general suspension, and
--     it is explicitly NOT the same as an individual family-visit or
--     tourist application.
--   - India-Pakistan cricket: India has not toured Pakistan to play
--     cricket since 2008, and a "hybrid model" agreed in December 2024
--     (i.e. BEFORE the April 2025 crisis) routes all India-Pakistan
--     fixtures at ICC events through neutral venues (India's 2025
--     Champions Trophy matches were all played in Dubai) through 2027 —
--     a separately-negotiated, longer-standing arrangement, not merely
--     a byproduct of the current suspension.
--   - Even before April 2025, the bilateral regime was already unusually
--     restrictive versus a typical country pair: no visa-on-arrival, no
--     e-visa, and (per general background knowledge of the 1974
--     Agreement) historically city-specific permits with mandatory
--     police reporting within 24 hours of arrival for visit-category
--     travel — this was never a routine, open tourism/business market.
--
-- BOTTOM LINE: as of September 2026, general Tourist, Business, Student,
-- Work, Conference, Sports, Dependent, and Transit routes are suspended
-- with no confirmed exceptions found. Family Visit is suspended for
-- general/individual applicants, with the sole documented exception
-- being organized religious-pilgrim group travel (not an individual
-- family-visit application). Medical is suspended and additionally
-- under-sourced for this direction of travel. This file documents that
-- reality honestly rather than presenting Pakistan as a routine
-- destination.
--
-- country_id 87 = Pakistan. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Currently Suspended
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    87, 1, 'PAK-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Pakistan for Indian passport holders.',
    'General tourist visas for Indian nationals are not currently being issued. Pakistan suspended and revoked visas for Indians (with a narrow exception for organized Sikh pilgrim groups) after the April 2025 Pahalgam attack, and the pre-existing 1974 bilateral regime never offered visa-on-arrival, e-visa, or open tourism access to Indians in any case.',
    'Not applicable — general tourist-visa service is currently suspended',
    'Currently suspended; no application route exists for general Indian tourists as of September 2026',
    1,
    'No processing occurs; tourist applications are not being accepted under the current suspension',
    'High Commission for Pakistan, New Delhi (not accepting general tourist applications)',
    'Do not assume travel is possible — confirm current status directly with the High Commission for Pakistan, New Delhi\nMonitor Indian MEA and Pakistani MOFA travel advisories for any change in policy\nIf the route reopens, expect a sponsor-based, city-specific process historically required under the 1974 bilateral Visa Agreement',
    '/assets/images/visa-heroes/pakistan.webp',
    'Cross-checked against Gulf News and EY reporting on the April 2025 mutual visa suspension, triangulated against sources not directly fetchable this session (india.org.pk blocked)', 'https://gulfnews.com/world/asia/pakistan/pahalgam-attack-pakistan-suspends-all-visas-for-indians-closes-airspace-to-indian-airlines-1.500104483', '2026-09-17'
);
SET @pak1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pak1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak1, 'Current Service Status', 'Confirm eligibility before making any plans — this category is not being routinely processed.', 1);
SET @pak1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak1s1, 'Valid Indian Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pak1s1, 'Written Confirmation of Eligibility from High Commission for Pakistan, New Delhi', 'Tourist visas are not being routinely issued under the current suspension; obtain this directly before applying.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak1, 'Historical Requirements (Not Currently Accepted)', 'Documents historically required under the 1974 bilateral Visa Agreement route; retained for reference only, not confirmed as currently accepted.', 2);
SET @pak1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak1s2, 'Local Sponsor/Invitation Letter (Pakistan Resident)', NULL, 'original', 0, 1, 0, 1),
(@pak1s2, 'Confirmed Return Ticket', NULL, 'copy', 0, 1, 0, 2),
(@pak1s2, 'Proof of Funds', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(87, 1, NULL, 'PKR', 'Service Currently Suspended', 'Historical fee structure not independently re-verified this session and not applicable while the tourist-visa route is suspended.', '2026-09-01', NOW(), 'https://gulfnews.com/world/asia/pakistan/pahalgam-attack-pakistan-suspends-all-visas-for-indians-closes-airspace-to-indian-airlines-1.500104483', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens currently get a Pakistan tourist visa?', 'No — Pakistan suspended and revoked visas for Indian nationals after the April 2025 Pahalgam attack and the crisis that followed. As of September 2026 this suspension remains in effect and no routine tourist-visa channel exists. Confirm directly with the High Commission for Pakistan, New Delhi before making any plans.', 87, 1, 8700, 1),
('Did India and Pakistan ever have visa-free or on-arrival tourism?', 'No — even before the 2025 suspension, the two countries operated under the restrictive 1974 bilateral Visa Agreement, which never included visa-on-arrival or e-visa access for each other''s citizens. Tourism between the two has effectively never been an open, routine travel category.', 87, 1, 8701, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Currently Suspended
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    87, 2, 'PAK-BUS-IN-02', '2026.09', 'published',
    'Trade, commercial meetings, and business travel to Pakistan for Indian nationals.',
    'Business visas for Indian nationals are not currently available. Pakistan suspended visa issuance for Indians after the April 2025 Pahalgam attack, alongside a broader suspension of India-Pakistan trade; direct trade had already been curtailed since 2019, so this category had little practical use even before 2025.',
    'Not applicable — service currently suspended',
    'Currently suspended; no application route exists as of September 2026',
    1,
    'No processing occurs under the current suspension',
    'High Commission for Pakistan, New Delhi (not accepting business-visa applications)',
    'Confirm current status directly with the High Commission for Pakistan, New Delhi\nNote that India-Pakistan trade has been suspended since April 2025, on top of curbs dating to 2019\nMonitor official advisories for any change in policy',
    '/assets/images/visa-heroes/pakistan.webp',
    'Cross-checked against Gulf News/EY reporting on the April 2025 mutual visa and trade suspension, triangulated against sources not directly fetchable this session', 'https://gulfnews.com/world/asia/pakistan/pahalgam-attack-pakistan-suspends-all-visas-for-indians-closes-airspace-to-indian-airlines-1.500104483', '2026-09-17'
);
SET @pak2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pak2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak2, 'Current Service Status', 'Confirm eligibility before making any plans — this category is not being routinely processed.', 1);
SET @pak2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak2s1, 'Valid Indian Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pak2s1, 'Written Confirmation of Eligibility from High Commission for Pakistan, New Delhi', 'Business visas are not being routinely issued under the current suspension; obtain this directly before applying.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak2, 'Historical Requirements (Not Currently Accepted)', 'Documents historically required under the 1974 bilateral Visa Agreement route; retained for reference only, not confirmed as currently accepted.', 2);
SET @pak2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak2s2, 'Invitation Letter from Pakistani Company/Chamber of Commerce', NULL, 'original', 0, 1, 0, 1),
(@pak2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 0, 1, 0, 2),
(@pak2s2, 'Company Registration Proof', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(87, 2, NULL, 'PKR', 'Service Currently Suspended', 'Historical fee structure not independently re-verified this session and not applicable while the business-visa route is suspended.', '2026-09-01', NOW(), 'https://gulfnews.com/world/asia/pakistan/pahalgam-attack-pakistan-suspends-all-visas-for-indians-closes-airspace-to-indian-airlines-1.500104483', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Pakistan business visa available to Indian companies right now?', 'No — general visa services for Indians, including business travel, have been suspended since April 2025 alongside a broader suspension of India-Pakistan trade. There is currently no application route.', 87, 2, 8702, 1),
('Was bilateral trade active before the 2025 suspension?', 'No — India had already curtailed Most Favoured Nation trade treatment and significant direct trade with Pakistan following the 2019 Pulwama attack; the April 2025 crisis further formalized the halt on both sides.', 87, 2, 8703, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Currently Suspended / Under-Sourced
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    87, 3, 'PAK-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Pakistani educational institution as an Indian national.',
    'Not currently available. Indian nationals are not being issued student visas under the present suspension. This session found no evidence of an active or historically routine student-visa pathway between the two countries even before April 2025 — flagged as under-sourced beyond the general suspension.',
    'Not applicable — service currently suspended',
    'Currently suspended; no confirmed application route as of September 2026',
    1,
    'No processing occurs under the current suspension',
    'High Commission for Pakistan, New Delhi (not accepting student-visa applications)',
    'Confirm current status directly with the High Commission for Pakistan, New Delhi\nBe aware this category is not well documented even outside the current suspension\nMonitor official advisories for any change in policy',
    '/assets/images/visa-heroes/pakistan.webp',
    'Cross-checked against Gulf News/EY reporting on the April 2025 suspension; a standing India-Pakistan student-visa pathway was NOT independently confirmed this session', 'https://gulfnews.com/world/asia/pakistan/pahalgam-attack-pakistan-suspends-all-visas-for-indians-closes-airspace-to-indian-airlines-1.500104483', '2026-09-17'
);
SET @pak3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pak3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak3, 'Current Service Status', 'Confirm eligibility before making any plans — this category is not being routinely processed.', 1);
SET @pak3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak3s1, 'Valid Indian Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pak3s1, 'Written Confirmation of Eligibility from High Commission for Pakistan, New Delhi', 'Student visas are not being routinely issued under the current suspension; obtain this directly before applying.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak3, 'Historical Requirements (Not Currently Accepted, Not Fully Verified)', 'General background documents that would typically apply to a study-purpose visa; not confirmed against a verified current or historical Pakistan-specific process.', 2);
SET @pak3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak3s2, 'Admission Letter from Pakistani Institution', NULL, 'original', 0, 1, 0, 1),
(@pak3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 0, 1, 0, 2),
(@pak3s2, 'Proof of Funds', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(87, 3, NULL, 'PKR', 'Service Currently Suspended', 'Fee structure not independently confirmed this session and not applicable while the student-visa route is suspended.', '2026-09-01', NOW(), 'https://gulfnews.com/world/asia/pakistan/pahalgam-attack-pakistan-suspends-all-visas-for-indians-closes-airspace-to-indian-airlines-1.500104483', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can an Indian student study in Pakistan right now?', 'No — general visa services, including for study purposes, remain suspended for Indian nationals as of September 2026, and this was already a very uncommon path even before the suspension.', 87, 3, 8704, 1),
('Is there a confirmed precedent for Indian students studying in Pakistan?', 'This session could not independently confirm an active or historical Pakistan student-visa pathway for Indian nationals — flagged as not independently confirmed pending further verification.', 87, 3, 8705, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Currently Suspended / Under-Sourced
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    87, 4, 'PAK-WORK-IN-04', '2026.09', 'published',
    'Employment with a Pakistani employer for Indian nationals.',
    'Not currently available. General visa services for Indians are suspended, and this session found no evidence of a standing India-Pakistan labour-migration corridor in either direction even before the 2025 suspension — flagged as under-sourced beyond the general suspension.',
    'Not applicable — service currently suspended',
    'Currently suspended; no confirmed application route as of September 2026',
    1,
    'No processing occurs under the current suspension',
    'High Commission for Pakistan, New Delhi (not accepting work-visa applications)',
    'Confirm current status directly with the High Commission for Pakistan, New Delhi\nBe aware this category is not well documented even outside the current suspension\nMonitor official advisories for any change in policy',
    '/assets/images/visa-heroes/pakistan.webp',
    'Cross-checked against Gulf News/EY reporting on the April 2025 suspension; a standing India-Pakistan work-visa pathway was NOT independently confirmed this session', 'https://gulfnews.com/world/asia/pakistan/pahalgam-attack-pakistan-suspends-all-visas-for-indians-closes-airspace-to-indian-airlines-1.500104483', '2026-09-17'
);
SET @pak4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pak4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak4, 'Current Service Status', 'Confirm eligibility before making any plans — this category is not being routinely processed.', 1);
SET @pak4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak4s1, 'Valid Indian Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pak4s1, 'Written Confirmation of Eligibility from High Commission for Pakistan, New Delhi', 'Work visas are not being routinely issued under the current suspension; obtain this directly before applying.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak4, 'Historical Requirements (Not Currently Accepted, Not Fully Verified)', 'General background documents that would typically apply to an employment-purpose visa; not confirmed against a verified current or historical Pakistan-specific process.', 2);
SET @pak4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak4s2, 'Employment Contract/Offer Letter', NULL, 'copy', 0, 1, 0, 1),
(@pak4s2, 'Ministry of Interior Work-Permit Clearance', NULL, 'copy', 0, 1, 0, 2),
(@pak4s2, 'Police Clearance Certificate', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(87, 4, NULL, 'PKR', 'Service Currently Suspended', 'Fee structure not independently confirmed this session and not applicable while the work-visa route is suspended.', '2026-09-01', NOW(), 'https://gulfnews.com/world/asia/pakistan/pahalgam-attack-pakistan-suspends-all-visas-for-indians-closes-airspace-to-indian-airlines-1.500104483', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can an Indian national work in Pakistan right now?', 'No — general visa services, including for employment purposes, remain suspended for Indian nationals as of September 2026.', 87, 4, 8706, 1),
('Was there ever a standing India-Pakistan work-visa route?', 'This session could not independently confirm a standing labour-migration pathway between the two countries even before the 2025 suspension — flagged as not independently confirmed.', 87, 4, 8707, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Suspended for General Applicants;
-- Distinct Religious-Pilgrimage Channel Continues
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    87, 5, 'PAK-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives resident in Pakistan as an Indian national.',
    'General family-visit visas for Indians have been suspended since April 2025 — Pakistan''s own statement revoked visas for Indians "except Sikh pilgrims." Historically this was the most substantive bilateral category under the 1974 Visa Agreement, requiring a Pakistan-resident sponsor, city-specific permits, and mandatory police reporting on arrival.',
    'Not applicable to general applicants — historical permits were city-specific and time-bound',
    'Currently suspended for general family visits; a separate organized religious-pilgrimage channel exists but is distinct',
    1,
    'No processing occurs for general family-visit applications under the current suspension',
    'High Commission for Pakistan, New Delhi (not accepting general family-visit applications)',
    'Confirm current status directly with the High Commission for Pakistan, New Delhi — general family-visit applications are not being accepted\nNote that only organized religious-pilgrim groups (e.g. Sikh jathas via SGPC/DSGMC/HSGMC) have travelled, under a separate 1974 pilgrimage protocol — 2,800+ visas were issued for Baisakhi in April 2026\nDo not conflate this pilgrimage channel with an individual family-visit application',
    '/assets/images/visa-heroes/pakistan.webp',
    'Cross-checked against the April 2025 Pakistan suspension statement (Gulf News) and verified April 2026 Baisakhi pilgrim-visa reporting (India TV News); general family-visit status not separately confirmed beyond the blanket suspension', 'https://www.indiatvnews.com/news/world/pakistan-issues-over-2800-visas-to-indian-sikh-pilgrims-for-baisakhi-celebrations-latest-updates-2026-04-07-1036660', '2026-09-17'
);
SET @pak5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pak5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak5, 'Current Service Status', 'Confirm eligibility before making any plans — general family-visit applications are not being routinely processed.', 1);
SET @pak5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak5s1, 'Valid Indian Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pak5s1, 'Written Confirmation of Eligibility from High Commission for Pakistan, New Delhi', 'General family-visit visas are not being routinely issued under the current suspension; obtain this directly before applying.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak5, 'Religious Pilgrimage — A Separate, Distinct Channel', 'Organized Sikh pilgrim jathas have continued travelling under a distinct 1974 bilateral religious-shrines protocol even during the general suspension — this is NOT a personal family-visit route.', 2);
SET @pak5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak5s2, 'Pilgrim Jatha Registration via SGPC/DSGMC/Recognized Pilgrim Committee', 'Organized centrally, not an individual application; contact the relevant Sikh gurdwara management committee, not this checklist, for pilgrimage travel.', 'original', 0, 1, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak5, 'Historical Requirements for General Family Visits (Not Currently Accepted)', 'Documents historically required under the 1974 bilateral Visa Agreement''s visit-visa route; retained for reference only, not confirmed as currently accepted.', 3);
SET @pak5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak5s3, 'Invitation/Sponsorship Letter from Pakistan-Resident Relative', NULL, 'original', 0, 1, 0, 1),
(@pak5s3, 'Proof of Relationship (Birth/Marriage Certificates)', NULL, 'copy', 0, 1, 0, 2),
(@pak5s3, 'Sponsor''s Pakistani CNIC/Domicile Copy', NULL, 'copy', 0, 1, 0, 3),
(@pak5s3, 'City-Specific Police-Reporting Itinerary', 'Historically required reporting to a local police station within 24 hours of arrival in each named city.', 'if_applicable', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(87, 5, NULL, 'PKR', 'Service Currently Suspended (General Applicants)', 'Historical fee structure not independently re-verified this session; the organized religious-pilgrimage channel is administered separately by pilgrim committees, not via an individual fee here.', '2026-09-01', NOW(), 'https://www.indiatvnews.com/news/world/pakistan-issues-over-2800-visas-to-indian-sikh-pilgrims-for-baisakhi-celebrations-latest-updates-2026-04-07-1036660', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I currently get a Pakistan visa to visit family?', 'No — general family-visit applications for Indian nationals are suspended, along with all other general visa categories, since April 2025. Only organized Sikh pilgrim groups have continued travelling, under a separate 1974 religious-shrines protocol — this is not available for an individual family visit.', 87, 5, 8708, 1),
('What did family-visit visas require before the suspension?', 'Under the 1974 bilateral Visa Agreement, family-visit visas were historically city-specific (commonly limited to a small number of named cities), required a Pakistan-resident sponsor, and obligated the visitor to report to a local police station within 24 hours of arrival in each city — a distinctly more restrictive process than most countries'' family-visit categories.', 87, 5, 8709, 1),
('Is the Kartarpur Corridor open for visa-free pilgrimage right now?', 'No — the visa-free Kartarpur Corridor itself remained closed through the period covered by this research. The 2,800+ pilgrim visas issued for Baisakhi in April 2026 travelled via the traditional Attari-Wagah route under a separate visa-based pilgrimage protocol, not the visa-free corridor.', 87, 5, 8710, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Currently Suspended
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    87, 6, 'PAK-TRAN-IN-06', '2026.09', 'published',
    'Transiting through Pakistan en route to another destination as an Indian national.',
    'Not currently available. Pakistan closed its airspace to Indian-origin and Indian-owned/operated aircraft after April 2025, and the Attari-Wagah land crossing — the only official land border point — is closed to general civilian traffic; no transit route currently exists for Indian passport holders.',
    'Not applicable — airspace and the land crossing are both closed to general Indian civilian traffic',
    'Currently suspended; airspace and the Attari-Wagah land crossing are both closed to general traffic',
    1,
    'No processing occurs; transit is not currently possible for Indian nationals',
    'High Commission for Pakistan, New Delhi (not accepting transit-visa applications)',
    'Confirm current status directly with the High Commission for Pakistan, New Delhi\nNote that airlines have rerouted around closed Pakistani airspace since April 2025\nMonitor official advisories for any change in policy',
    '/assets/images/visa-heroes/pakistan.webp',
    'Cross-checked against Gulf News reporting on the April 2025 airspace and border closures, triangulated against sources not directly fetchable this session', 'https://gulfnews.com/world/asia/pakistan/pahalgam-attack-pakistan-suspends-all-visas-for-indians-closes-airspace-to-indian-airlines-1.500104483', '2026-09-17'
);
SET @pak6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pak6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak6, 'Current Service Status', 'Confirm eligibility before making any plans — this category is not currently possible.', 1);
SET @pak6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak6s1, 'Valid Indian Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pak6s1, 'Written Confirmation of Eligibility from High Commission for Pakistan, New Delhi', 'Transit is not currently possible under the airspace/border closures; obtain this directly before assuming otherwise.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak6, 'Historical Requirements (Not Currently Accepted)', 'Documents historically required for transit purposes; retained for reference only, not confirmed as currently accepted.', 2);
SET @pak6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak6s2, 'Onward Flight Ticket', NULL, 'copy', 0, 1, 0, 1),
(@pak6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(87, 6, NULL, 'PKR', 'Service Currently Suspended', 'Not applicable while Pakistani airspace and the Attari-Wagah land crossing remain closed to general Indian civilian traffic.', '2026-09-01', NOW(), 'https://gulfnews.com/world/asia/pakistan/pahalgam-attack-pakistan-suspends-all-visas-for-indians-closes-airspace-to-indian-airlines-1.500104483', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I transit through a Pakistani airport right now?', 'No — Pakistan closed its airspace to Indian-origin and Indian-registered aircraft after April 2025 as part of the broader suspension. Airlines have rerouted around Pakistani airspace, and no transit-visa route currently applies to Indian passport holders.', 87, 6, 8711, 1),
('Is the Attari-Wagah land border open for transit?', 'No — it is the only official India-Pakistan land crossing and has been closed to general civilian traffic since April 2025; it has been used only by organized, escorted religious-pilgrim groups.', 87, 6, 8712, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Currently Suspended / Under-Sourced
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    87, 7, 'PAK-MED-IN-07', '2026.09', 'published',
    'Seeking medical treatment in Pakistan as an Indian national.',
    'Not currently available, and not independently confirmed this session as an active route in this direction. Pakistan is not a typical medical-tourism destination for Indian patients, and this session found no evidence of an operating humanitarian exception for Indians travelling to Pakistan during the current suspension.',
    'Not applicable — service currently suspended and unconfirmed for this direction',
    'Currently suspended; no confirmed exception found for Indians travelling to Pakistan for treatment',
    1,
    'No processing occurs; no confirmed humanitarian channel exists for this direction of travel',
    'High Commission for Pakistan, New Delhi (not accepting medical-visa applications)',
    'Confirm current status directly with the High Commission for Pakistan, New Delhi\nBe aware this specific direction of medical travel is not well documented\nMonitor official advisories for any case-specific humanitarian exception',
    '/assets/images/visa-heroes/pakistan.webp',
    'Cross-checked against Gulf News/EY reporting on the general April 2025 suspension; an Indian-to-Pakistan medical-visa exception was NOT independently confirmed this session', 'https://gulfnews.com/world/asia/pakistan/pahalgam-attack-pakistan-suspends-all-visas-for-indians-closes-airspace-to-indian-airlines-1.500104483', '2026-09-17'
);
SET @pak7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pak7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak7, 'Current Service Status', 'Confirm eligibility before making any plans — this category is not confirmed as available.', 1);
SET @pak7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak7s1, 'Valid Indian Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pak7s1, 'Written Confirmation of Eligibility from High Commission for Pakistan, New Delhi', 'No confirmed humanitarian medical-visa channel exists for Indians travelling to Pakistan; obtain case-specific confirmation directly.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak7, 'Historical Requirements (Not Currently Accepted, Not Fully Verified)', 'General background documents that would typically apply to a medical-purpose visa; not confirmed against a verified current or historical Pakistan-specific process.', 2);
SET @pak7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak7s2, 'Hospital Invitation/Treatment Confirmation Letter', NULL, 'original', 0, 1, 0, 1),
(@pak7s2, 'Medical Records/Referral', NULL, 'copy', 0, 1, 0, 2),
(@pak7s2, 'Proof of Funds for Treatment', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(87, 7, NULL, 'PKR', 'Service Currently Suspended', 'Fee structure not independently confirmed this session; no confirmed humanitarian channel exists for Indians travelling to Pakistan for treatment.', '2026-09-01', NOW(), 'https://gulfnews.com/world/asia/pakistan/pahalgam-attack-pakistan-suspends-all-visas-for-indians-closes-airspace-to-indian-airlines-1.500104483', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can an Indian patient get a Pakistan medical visa right now?', 'This session found no evidence of an active humanitarian medical-visa exception for Indians travelling to Pakistan; general visa services remain suspended, and this specific direction is flagged as not independently confirmed. Contact the High Commission for Pakistan, New Delhi directly for any case-specific guidance.', 87, 7, 8713, 1),
('Is cross-border medical travel between India and Pakistan documented in the other direction?', 'Most of the publicly reported cross-border medical-visa activity has been Pakistani patients travelling TO India, handled case-by-case for life-threatening conditions since April 2025 — not the reverse. This checklist covers Indian nationals travelling to Pakistan, which is a distinct and far less documented flow.', 87, 7, 8714, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Currently Suspended
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    87, 8, 'PAK-CONF-IN-08', '2026.09', 'published',
    'Attending conferences or official meetings in Pakistan as an Indian national.',
    'Not currently available. Track 1.5/track-2 dialogue and conference travel between India and Pakistan has been effectively paused since April 2025; a December 2025 handshake between officials at a funeral in Dhaka was a diplomatic gesture, not evidence of a resumed conference-visa channel.',
    'Not applicable — service currently suspended',
    'Currently suspended; no application route exists as of September 2026',
    1,
    'No processing occurs under the current suspension',
    'High Commission for Pakistan, New Delhi (not accepting conference-visa applications)',
    'Confirm current status directly with the High Commission for Pakistan, New Delhi\nDo not read the December 2025 Dhaka handshake as evidence of resumed conference travel\nMonitor official advisories for any change in policy',
    '/assets/images/visa-heroes/pakistan.webp',
    'Cross-checked against Al Jazeera reporting on the December 2025 Dhaka handshake and the ongoing suspension context, triangulated against sources not directly fetchable this session', 'https://www.aljazeera.com/news/2026/1/2/handshake-in-dhaka-can-india-and-pakistan-revive-ties-in-2026', '2026-09-17'
);
SET @pak8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pak8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak8, 'Current Service Status', 'Confirm eligibility before making any plans — this category is not being routinely processed.', 1);
SET @pak8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak8s1, 'Valid Indian Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pak8s1, 'Written Confirmation of Eligibility from High Commission for Pakistan, New Delhi', 'Conference visas are not being routinely issued under the current suspension; obtain this directly before applying.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak8, 'Historical Requirements (Not Currently Accepted)', 'Documents historically required for conference-purpose visas; retained for reference only, not confirmed as currently accepted.', 2);
SET @pak8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak8s2, 'Conference Invitation/Registration Confirmation', NULL, 'original', 0, 1, 0, 1),
(@pak8s2, 'Forwarding Letter from Employer/Institution', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(87, 8, NULL, 'PKR', 'Service Currently Suspended', 'Historical fee structure not independently re-verified this session and not applicable while the conference-visa route is suspended.', '2026-09-01', NOW(), 'https://www.aljazeera.com/news/2026/1/2/handshake-in-dhaka-can-india-and-pakistan-revive-ties-in-2026', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the 2025-26 India-Pakistan diplomatic thaw include conference travel?', 'Not confirmed — a brief handshake between India''s foreign minister and a Pakistani official occurred at a funeral in Dhaka in December 2025, but this reflects a diplomatic gesture, not a resumed conference-visa or dialogue channel; visa services remain suspended as of September 2026.', 87, 8, 8715, 1),
('Was conference travel routine between India and Pakistan before 2025?', 'It existed on a limited, invitation-driven basis under the same restrictive 1974 bilateral regime as other categories, but was never a high-volume or routine channel even before the current suspension.', 87, 8, 8716, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Currently Suspended; Also Separately
-- Routed to Neutral Venues Under the ICC Hybrid Model
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    87, 9, 'PAK-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff travelling to compete in Pakistan.',
    'Not currently available. Beyond the general 2025 visa suspension, India has not sent cricket teams to play in Pakistan since 2008, and a "hybrid model" agreed in December 2024 — before the current crisis — routes all India-Pakistan ICC fixtures through neutral venues (Dubai hosted India''s 2025 Champions Trophy matches) through 2027.',
    'Not applicable — service currently suspended',
    'Currently suspended; separately, India-Pakistan cricket fixtures are routed to neutral venues under the ICC hybrid-model arrangement',
    1,
    'No processing occurs under the current suspension',
    'High Commission for Pakistan, New Delhi (not accepting sports-visa applications)',
    'Confirm current status directly with the High Commission for Pakistan, New Delhi\nNote the ICC hybrid-model arrangement (agreed December 2024, predating the 2025 crisis) already keeps India-Pakistan cricket fixtures at neutral venues through 2027\nMonitor official advisories for any change in policy',
    '/assets/images/visa-heroes/pakistan.webp',
    'Cross-checked against ESPNcricinfo reporting on the December 2024 hybrid-model agreement and Gulf News/EY reporting on the April 2025 suspension', 'https://www.espncricinfo.com/story/champions-trophy-2025-dubai-to-host-all-india-matches-including-the-knockouts-if-india-qualify-1466411', '2026-09-17'
);
SET @pak9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pak9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak9, 'Current Service Status', 'Confirm eligibility before making any plans — this category is not being routinely processed.', 1);
SET @pak9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak9s1, 'Valid Indian Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pak9s1, 'Written Confirmation of Eligibility from High Commission for Pakistan, New Delhi', 'Sports visas are not being routinely issued under the current suspension; obtain this directly before applying.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak9, 'Historical Requirements (Not Currently Accepted)', 'Documents historically required for sports-purpose visas; retained for reference only, not confirmed as currently accepted.', 2);
SET @pak9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak9s2, 'Home-Country Sports Association Letter', NULL, 'original', 0, 1, 0, 1),
(@pak9s2, 'Host Event Organizer Invitation Letter', NULL, 'original', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(87, 9, NULL, 'PKR', 'Service Currently Suspended', 'Not applicable while the general suspension is in effect; separately, ICC cricket fixtures between India and Pakistan are routed to neutral venues through 2027 regardless of visa status.', '2026-09-01', NOW(), 'https://www.espncricinfo.com/story/champions-trophy-2025-dubai-to-host-all-india-matches-including-the-knockouts-if-india-qualify-1466411', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Will Indian teams travel to Pakistan for cricket matches?', 'No — since 2008, and formalized by a December 2024 hybrid-model agreement (predating the current 2025 crisis) that routes all India-Pakistan fixtures at ICC events through neutral venues (Dubai hosted India''s 2025 Champions Trophy matches) through 2027, India does not send cricket teams to play in Pakistan. This is separate from, and predates, the current visa suspension.', 87, 9, 8717, 1),
('Is a Pakistan sports visa available to individual Indian athletes right now?', 'No — general visa services for Indian nationals, including for sporting purposes, remain suspended as of September 2026.', 87, 9, 8718, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Currently Suspended / Under-Sourced
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    87, 10, 'PAK-DEP-IN-10', '2026.09', 'published',
    'Spouse or dependent children joining a family member settled in Pakistan.',
    'Not currently available. General visa services for Indian nationals are suspended, and this session found no evidence of an active, standing India-Pakistan dependent/family-settlement pathway even before 2025, given the restrictive, reciprocity-based bilateral visa regime.',
    'Not applicable — service currently suspended',
    'Currently suspended; no confirmed application route as of September 2026',
    1,
    'No processing occurs under the current suspension',
    'High Commission for Pakistan, New Delhi (not accepting dependent-visa applications)',
    'Confirm current status directly with the High Commission for Pakistan, New Delhi\nBe aware this category is not well documented even outside the current suspension\nMonitor official advisories for any change in policy',
    '/assets/images/visa-heroes/pakistan.webp',
    'Cross-checked against Gulf News/EY reporting on the April 2025 suspension; a standing India-Pakistan dependent-visa pathway was NOT independently confirmed this session', 'https://gulfnews.com/world/asia/pakistan/pahalgam-attack-pakistan-suspends-all-visas-for-indians-closes-airspace-to-indian-airlines-1.500104483', '2026-09-17'
);
SET @pak10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pak10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak10, 'Current Service Status', 'Confirm eligibility before making any plans — this category is not being routinely processed.', 1);
SET @pak10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak10s1, 'Valid Indian Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pak10s1, 'Written Confirmation of Eligibility from High Commission for Pakistan, New Delhi', 'Dependent visas are not being routinely issued under the current suspension; obtain this directly before applying.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pak10, 'Historical Requirements (Not Currently Accepted, Not Fully Verified)', 'General background documents that would typically apply to a dependent-purpose visa; not confirmed against a verified current or historical Pakistan-specific process.', 2);
SET @pak10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pak10s2, 'Proof of Relationship to Sponsor', NULL, 'copy', 0, 1, 0, 1),
(@pak10s2, 'Sponsor''s Residence/Work Permit Copy', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(87, 10, NULL, 'PKR', 'Service Currently Suspended', 'Fee structure not independently confirmed this session and not applicable while the dependent-visa route is suspended.', '2026-09-01', NOW(), 'https://gulfnews.com/world/asia/pakistan/pahalgam-attack-pakistan-suspends-all-visas-for-indians-closes-airspace-to-indian-airlines-1.500104483', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can a dependent join a family member in Pakistan right now?', 'No — general visa services are suspended for Indian nationals as of September 2026, and this session could not independently confirm a standing dependent/settlement visa pathway between India and Pakistan even before the current crisis; flagged as under-sourced pending direct confirmation.', 87, 10, 8719, 1),
('Does India''s exemption for Hindu Pakistani Long-Term Visa holders create a matching dependent route for Indians?', 'No — India kept a narrow exemption from its own visa revocation for existing Long-Term Visas held by Hindu Pakistani nationals already in India. That is a reverse-direction exception and does not create any dependent-visa pathway for Indians travelling to Pakistan.', 87, 10, 8720, 1);
