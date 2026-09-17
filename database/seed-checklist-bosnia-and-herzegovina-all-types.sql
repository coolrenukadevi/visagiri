-- Bosnia and Herzegovina Visa Checklist Engine content for all 10 visa
-- types. hero_image_url left NULL at authoring time.
--
-- IMPORTANT SOURCING CAVEAT (read before publishing to end users):
-- Live web research could NOT be performed this session. WebSearch
-- reported its per-session quota already exhausted before any query
-- returned results, and WebFetch was blocked by network egress-proxy
-- policy for every single domain attempted: www.mfa.gov.ba (BiH Ministry
-- of Foreign Affairs), en.wikipedia.org, www.vfsglobal.com,
-- www.schengenvisainfo.com, and www.gov.uk. No live page was fetched.
--
-- Per the task's fallback instructions, this file was built entirely
-- from general pre-existing knowledge, NOT session-specific
-- verification. EVERY category below carries a "NOT INDEPENDENTLY
-- CONFIRMED THIS SESSION" caveat in its `source` field, and no fee
-- amount, processing-day figure, or specific consular address has been
-- invented — every visa_fees row uses amount=NULL / 'Confirmed After
-- Assessment' rather than a guessed number, and every consular_office
-- field says plainly that the accredited mission for India could not be
-- confirmed this session rather than naming one.
--
-- Facts treated as reasonably reliable general knowledge (still
-- UNVERIFIED this session, but low-risk/well-established):
--   - Bosnia and Herzegovina is NOT an EU member and NOT part of the
--     Schengen Area. It has held EU candidate-country status since
--     December 2022, but is not expected to adopt the Schengen visa
--     regime before accession.
--   - Because it sits outside Schengen, Bosnia and Herzegovina issues
--     its own national visas (distinct from the Schengen C/D-type visa
--     used by neighbouring EU states) and sets its own visa-waiver
--     list, which does not include India, so Indian passport holders
--     need a visa for entry.
--   - The currency is the Bosnia and Herzegovina convertible mark (BAM),
--     pegged to the euro.
-- Facts that could NOT be verified this session and are flagged
-- explicitly wherever relevant rather than guessed:
--   - Whether Bosnia and Herzegovina maintains any resident embassy in
--     India, and if not, which regional BiH mission is accredited to
--     process Indian applications.
--   - Exact visa fee amounts (in BAM or EUR) for any category.
--   - Exact processing-time figures for any category.
--   - Any specific 2025-2026 Bosnia and Herzegovina visa-policy change
--     affecting Indian applicants — none is claimed in this file.
-- This file should be re-reviewed against live sources (BiH MFA,
-- Foreigners' Affairs Service / Služba za poslove sa strancima, and the
-- accredited mission) before being treated as authoritative for end
-- users.
--
-- country_id 111 = Bosnia and Herzegovina. visa_type_id: 1=Tourist,
-- 2=Business, 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical,
-- 8=Conference, 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — National Short-Stay Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    111, 1, 'BIH-TOUR-IN-01', '2026.09', 'published',
    'Leisure, sightseeing, and personal travel to Bosnia and Herzegovina.',
    'Bosnia and Herzegovina is not an EU/Schengen state (EU candidate since Dec 2022); India is not on its visa-waiver list, so Indian passport holders need a national short-stay visa for tourism, applied for at the nearest accredited Bosnian mission.',
    'Short-stay national visa, commonly up to 90 days within a 180-day period — confirm exact validity with the mission',
    'Apply in person at the Bosnian embassy/consulate accredited for India applications',
    1,
    'Processing time not independently confirmed this session; budget several weeks and confirm directly with the mission',
    'No resident BiH embassy confirmed in India this session — verify the current accredited mission with the BiH Ministry of Foreign Affairs before applying',
    'Identify the Bosnian mission currently accredited to process Indian applications\nComplete the national visa application form\nGather supporting documents (passport, photos, itinerary, insurance, funds proof)\nBook an appointment and attend in person, including biometrics if required\nTrack the decision and collect your passport',
    '/assets/images/visa-heroes/bosnia-and-herzegovina.webp',
    'Not independently verified this session — WebSearch quota was exhausted and WebFetch was blocked by egress-proxy policy for every domain attempted; reflects general prior knowledge only, verify directly with the BiH MFA before applying.', 'https://www.mfa.gov.ba/', '2026-09-17'
);
SET @bih1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bih1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih1, 'Core Documents', 'Required from every applicant.', 1);
SET @bih1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih1s1, 'Valid Passport', 'Recommended at least 6 months validity beyond intended stay, with blank pages.', 'original', 1, 0, 1, 1),
(@bih1s1, 'Completed National Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@bih1s1, 'Passport-Size Photographs', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @bih1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih1s2, 'Confirmed Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@bih1s2, 'Hotel Booking/Accommodation Proof', NULL, 'copy', 1, 0, 0, 2),
(@bih1s2, 'Travel Medical Insurance', NULL, 'original', 1, 0, 0, 3),
(@bih1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(111, 1, NULL, 'EUR', 'Confirmed After Assessment', 'Fee schedule could not be verified this session — contact the accredited Bosnian mission for the current national visa fee in BAM or EUR.', '2026-09-17', NOW(), 'https://www.mfa.gov.ba/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Bosnia and Herzegovina use the Schengen visa?', 'No — Bosnia and Herzegovina is not part of the Schengen Area or the EU. It issues its own national visa, separate from the Schengen C-type visa used by neighbouring EU states, and a Bosnian visa alone does not grant entry to Schengen countries.', 111, 1, 11100, 1),
('Is there a Bosnian embassy in India that Indian applicants can use?', 'This could not be independently confirmed this session. Check directly with the Bosnia and Herzegovina Ministry of Foreign Affairs for the mission currently accredited to handle Indian applications before starting the process.', 111, 1, 11101, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — National Short-Stay Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    111, 2, 'BIH-BUS-IN-02', '2026.09', 'published',
    'Trade meetings, negotiations, and commercial activity in Bosnia and Herzegovina.',
    'Same non-EU/non-Schengen national visa regime as Tourist; Indian business travellers need a Bosnian national visa, generally supported by an invitation letter from the host company plus an employer forwarding letter from India.',
    'Short-stay national visa, commonly up to 90 days within a 180-day period — confirm with the mission',
    'Apply in person at the accredited Bosnian mission with a business invitation letter',
    1,
    'Processing time not independently confirmed this session; contact the mission for current timelines',
    'No resident BiH embassy confirmed in India this session — verify the current accredited mission with the BiH Ministry of Foreign Affairs before applying',
    'Obtain an invitation letter from the Bosnian host company\nGather an employer forwarding/sponsorship letter from India\nComplete the national visa application form\nBook an appointment and attend in person\nTrack the decision and collect your passport',
    '/assets/images/visa-heroes/bosnia-and-herzegovina.webp',
    'Not independently verified this session — WebSearch quota was exhausted and WebFetch was blocked by egress-proxy policy for every domain attempted; reflects general prior knowledge only, verify directly with the BiH MFA before applying.', 'https://www.mfa.gov.ba/', '2026-09-17'
);
SET @bih2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bih2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih2, 'Core Documents', 'Required from every applicant.', 1);
SET @bih2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bih2s1, 'Invitation Letter from Bosnian Host Company', NULL, 'original', 1, 0, 1, 2),
(@bih2s1, 'Employer Forwarding Letter (India)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih2, 'Supporting Documents', 'Evidence of the host company and your own means.', 2);
SET @bih2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih2s2, 'Host Company Registration Proof', NULL, 'copy', 0, 1, 0, 1),
(@bih2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2),
(@bih2s2, 'Travel Medical Insurance', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(111, 2, NULL, 'EUR', 'Confirmed After Assessment', 'Fee schedule could not be verified this session — contact the accredited Bosnian mission for the current national visa fee in BAM or EUR.', '2026-09-17', NOW(), 'https://www.mfa.gov.ba/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a Business visa let me also do tourism activities?', 'Not independently confirmed this session — treat the visa as issued for the stated business purpose and check with the mission before adding unrelated tourist activity to the same trip.', 111, 2, 11102, 1),
('Should the invitation letter be translated?', 'Not independently confirmed this session — check with the mission whether translation into a local Bosnian/Croatian/Serbian language is required.', 111, 2, 11103, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Long-Stay Visa + Residence for Study
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    111, 3, 'BIH-STU-IN-03', '2026.09', 'published',
    'Enrolling in a recognized Bosnia and Herzegovina educational institution.',
    'Indian students admitted to a BiH institution generally need a long-stay national visa for study purposes, followed by registering for a temporary residence permit for study with the Foreigners'' Affairs Service after arrival.',
    'Initial long-stay visa tied to the academic term, renewable via temporary residence for study — confirm with the mission',
    'Apply in person at the accredited Bosnian mission with an admission letter; register residence after arrival',
    1,
    'Processing time not independently confirmed this session',
    'No resident BiH embassy confirmed in India this session — verify the current accredited mission with the BiH Ministry of Foreign Affairs before applying',
    'Secure admission at a recognized BiH institution\nGather proof of funds and health insurance\nComplete the national long-stay visa application\nBook an appointment and attend in person\nTravel and register your residence with the Foreigners'' Affairs Service (Sluzba za poslove sa strancima) after arrival',
    '/assets/images/visa-heroes/bosnia-and-herzegovina.webp',
    'Not independently verified this session — WebSearch quota was exhausted and WebFetch was blocked by egress-proxy policy for every domain attempted; reflects general prior knowledge only, verify directly with the BiH MFA before applying.', 'https://www.mfa.gov.ba/', '2026-09-17'
);
SET @bih3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bih3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih3, 'Core Documents', 'Required from every applicant.', 1);
SET @bih3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bih3s1, 'Admission/Enrollment Letter from BiH Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @bih3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bih3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@bih3s2, 'Health Insurance Valid in Bosnia and Herzegovina', NULL, 'original', 1, 0, 0, 3),
(@bih3s2, 'Guardian Consent (Minors)', NULL, 'if_applicable', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(111, 3, NULL, 'EUR', 'Confirmed After Assessment', 'Fee schedule could not be verified this session — contact the accredited Bosnian mission for the current long-stay visa fee in BAM or EUR.', '2026-09-17', NOW(), 'https://www.mfa.gov.ba/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can international students work while studying in Bosnia and Herzegovina?', 'Not independently confirmed this session — check current student work-rights rules with the Foreigners'' Affairs Service before taking up any part-time work.', 111, 3, 11104, 1),
('Do I need to register with authorities after I arrive?', 'Generally yes — long-stay entrants typically must register their residence with the Foreigners'' Affairs Service (Sluzba za poslove sa strancima) after arrival, though the exact deadline was not independently confirmed this session.', 111, 3, 11105, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Work Permit + Temporary Residence
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    111, 4, 'BIH-WORK-IN-04', '2026.09', 'published',
    'Employment with a Bosnia and Herzegovina employer.',
    'Indian nationals with a confirmed BiH job offer generally need the employer to obtain a work permit from the relevant Employment Service before the applicant applies for a combined work-and-residence temporary permit.',
    'Tied to the work permit/residence permit validity, commonly renewable — confirm with the mission',
    'Employer-driven; applicant then applies for a work-based visa/temporary residence permit',
    1,
    'Processing time not independently confirmed this session',
    'No resident BiH embassy confirmed in India this session — verify the current accredited mission with the BiH Ministry of Foreign Affairs before applying',
    'Secure a job offer from a BiH employer\nEmployer applies for a work permit with the relevant Employment Service\nApplicant applies for the entry visa/temporary residence for work\nAttend the appointment and submit biometrics if required\nRegister residence with the Foreigners'' Affairs Service after arrival',
    '/assets/images/visa-heroes/bosnia-and-herzegovina.webp',
    'Not independently verified this session — WebSearch quota was exhausted and WebFetch was blocked by egress-proxy policy for every domain attempted; reflects general prior knowledge only, verify directly with the BiH MFA before applying.', 'https://www.mfa.gov.ba/', '2026-09-17'
);
SET @bih4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bih4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih4, 'Core Documents', 'Required from every applicant.', 1);
SET @bih4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bih4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@bih4s1, 'Employer Work Permit Confirmation', 'From the relevant BiH Employment Service.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @bih4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bih4s2, 'Proof of Accommodation in Bosnia and Herzegovina', NULL, 'copy', 1, 0, 0, 2),
(@bih4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(111, 4, NULL, 'EUR', 'Confirmed After Assessment', 'Fee schedule could not be verified this session — contact the accredited Bosnian mission or Employment Service for the current work-permit and visa fees.', '2026-09-17', NOW(), 'https://www.mfa.gov.ba/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who applies for the work permit — me or my employer?', 'Generally the BiH employer applies for the work permit first, and the applicant then applies for the visa/residence permit. This sequence reflects standard regional practice but was not independently re-confirmed this session.', 111, 4, 11106, 1),
('Is the work permit and residence permit a single combined document?', 'Not independently confirmed this session — some Balkan-region systems combine these, others issue them separately; confirm the current BiH process with the Employment Service or mission.', 111, 4, 11107, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — National Short-Stay Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    111, 5, 'BIH-FAM-IN-05', '2026.09', 'published',
    'Visiting family or friends resident in Bosnia and Herzegovina.',
    'Same national visa regime as Tourist; applicants generally need an invitation letter from their host in Bosnia and Herzegovina plus documentary proof of the relationship.',
    'Short-stay national visa, commonly up to 90 days within a 180-day period — confirm with the mission',
    'Apply in person at the accredited Bosnian mission with a host invitation letter and relationship proof',
    1,
    'Processing time not independently confirmed this session',
    'No resident BiH embassy confirmed in India this session — verify the current accredited mission with the BiH Ministry of Foreign Affairs before applying',
    'Obtain an invitation letter from your host in Bosnia and Herzegovina\nGather documents proving the family/personal relationship\nComplete the national visa application form\nBook an appointment and attend in person\nTrack the decision and collect your passport',
    '/assets/images/visa-heroes/bosnia-and-herzegovina.webp',
    'Not independently verified this session — WebSearch quota was exhausted and WebFetch was blocked by egress-proxy policy for every domain attempted; reflects general prior knowledge only, verify directly with the BiH MFA before applying.', 'https://www.mfa.gov.ba/', '2026-09-17'
);
SET @bih5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bih5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih5, 'Core Documents', 'Required from every applicant.', 1);
SET @bih5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bih5s1, 'Invitation Letter from Host in Bosnia and Herzegovina', NULL, 'original', 1, 0, 1, 2),
(@bih5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @bih5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@bih5s2, 'Travel Medical Insurance', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(111, 5, NULL, 'EUR', 'Confirmed After Assessment', 'Fee schedule could not be verified this session — contact the accredited Bosnian mission for the current national visa fee.', '2026-09-17', NOW(), 'https://www.mfa.gov.ba/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the host need to notarize the invitation letter?', 'Not independently confirmed this session — check with the mission whether a notarized or police-registered invitation is required for a Family Visit application.', 111, 5, 11108, 1),
('What counts as acceptable proof of relationship?', 'Not independently confirmed this session — typically marriage/birth certificates or equivalent documents are expected; confirm the accepted list with the mission before applying.', 111, 5, 11109, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — National Transit/Short-Stay Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    111, 6, 'BIH-TRAN-IN-06', '2026.09', 'published',
    'Passing through Bosnia and Herzegovina en route to a third country.',
    'Bosnia and Herzegovina has limited direct long-haul air connections (Sarajevo is the main international gateway), so transit needs are uncommon; if a visa is required for your specific routing, the same national visa regime as Tourist applies.',
    'Limited to the transit window; exact validity terms not independently confirmed this session',
    'Apply in person at the accredited Bosnian mission only if your routing genuinely requires it',
    1,
    'Processing time not independently confirmed this session',
    'No resident BiH embassy confirmed in India this session — verify the current accredited mission with the BiH Ministry of Foreign Affairs before applying',
    'Confirm with your airline and the mission whether your specific routing requires a Bosnian transit or short-stay visa\nIf required, complete the national visa application with your itinerary and onward ticket\nBook an appointment and attend in person\nTrack the decision and collect your passport',
    '/assets/images/visa-heroes/bosnia-and-herzegovina.webp',
    'Not independently verified this session — WebSearch quota was exhausted and WebFetch was blocked by egress-proxy policy for every domain attempted; reflects general prior knowledge only, verify directly with the BiH MFA before applying.', 'https://www.mfa.gov.ba/', '2026-09-17'
);
SET @bih6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bih6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih6, 'Core Documents', 'Required if a transit visa is genuinely needed.', 1);
SET @bih6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bih6s1, 'Onward/Connecting Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @bih6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih6s2, 'Visa for Final Destination Country (If Required)', NULL, 'if_applicable', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(111, 6, NULL, 'EUR', 'Confirmed After Assessment', 'Fee schedule could not be verified this session — contact the accredited Bosnian mission before assuming a transit visa is needed or what it costs.', '2026-09-17', NOW(), 'https://www.mfa.gov.ba/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa just to change planes in Bosnia and Herzegovina?', 'This depends on your specific routing and whether you must clear passport control, which could not be independently confirmed this session — check with your airline and the Bosnian mission before travelling.', 111, 6, 11110, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — National Short-Stay Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    111, 7, 'BIH-MED-IN-07', '2026.09', 'published',
    'Travel to Bosnia and Herzegovina for medical treatment.',
    'Same national visa regime as Tourist; applicants generally need a letter from the treating BiH hospital/doctor confirming the planned treatment, plus valid medical/travel insurance.',
    'Tied to the treatment plan, commonly up to 90 days — confirm with the mission',
    'Apply in person at the accredited Bosnian mission with a medical invitation/treatment confirmation letter',
    1,
    'Processing time not independently confirmed this session',
    'No resident BiH embassy confirmed in India this session — verify the current accredited mission with the BiH Ministry of Foreign Affairs before applying',
    'Obtain a treatment confirmation letter from the BiH hospital/doctor\nArrange travel/medical insurance\nComplete the national visa application form\nBook an appointment and attend in person\nTrack the decision and collect your passport',
    '/assets/images/visa-heroes/bosnia-and-herzegovina.webp',
    'Not independently verified this session — WebSearch quota was exhausted and WebFetch was blocked by egress-proxy policy for every domain attempted; reflects general prior knowledge only, verify directly with the BiH MFA before applying.', 'https://www.mfa.gov.ba/', '2026-09-17'
);
SET @bih7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bih7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih7, 'Core Documents', 'Required from every applicant.', 1);
SET @bih7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bih7s1, 'Medical Treatment Confirmation Letter', NULL, 'original', 1, 0, 1, 2),
(@bih7s1, 'Travel/Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @bih7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@bih7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(111, 7, NULL, 'EUR', 'Confirmed After Assessment', 'Fee schedule could not be verified this session — contact the accredited Bosnian mission for the current national visa fee.', '2026-09-17', NOW(), 'https://www.mfa.gov.ba/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can a family member accompany a patient on the same visa route?', 'Not independently confirmed this session — an accompanying attendant would typically need to apply separately, generally under the Family Visit or Tourist category; confirm with the mission.', 111, 7, 11111, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — National Short-Stay Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    111, 8, 'BIH-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, trade fairs, and professional events in Bosnia and Herzegovina.',
    'Same national visa regime as Tourist; applicants generally need a conference invitation or registration confirmation from the BiH host/organizer.',
    'Short-stay national visa, commonly up to 90 days within a 180-day period — confirm with the mission',
    'Apply in person at the accredited Bosnian mission with a conference invitation/registration confirmation',
    1,
    'Processing time not independently confirmed this session',
    'No resident BiH embassy confirmed in India this session — verify the current accredited mission with the BiH Ministry of Foreign Affairs before applying',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nComplete the national visa application form\nBook an appointment and attend in person\nTrack the decision and collect your passport',
    '/assets/images/visa-heroes/bosnia-and-herzegovina.webp',
    'Not independently verified this session — WebSearch quota was exhausted and WebFetch was blocked by egress-proxy policy for every domain attempted; reflects general prior knowledge only, verify directly with the BiH MFA before applying.', 'https://www.mfa.gov.ba/', '2026-09-17'
);
SET @bih8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bih8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih8, 'Core Documents', 'Required from every applicant.', 1);
SET @bih8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bih8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @bih8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih8s2, 'Employer Forwarding Letter', NULL, 'if_applicable', 0, 1, 0, 1),
(@bih8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(111, 8, NULL, 'EUR', 'Confirmed After Assessment', 'Fee schedule could not be verified this session — contact the accredited Bosnian mission for the current national visa fee.', '2026-09-17', NOW(), 'https://www.mfa.gov.ba/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Conference visa different from the Business visa?', 'The documentary core is likely similar, with the main difference being the invitation source (event organizer vs. host company) — but this was not independently re-confirmed this session; check with the mission for the current categorisation.', 111, 8, 11112, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — National Short-Stay Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    111, 9, 'BIH-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in events hosted in Bosnia and Herzegovina.',
    'Same national visa regime as Tourist/Conference; applicants generally need a letter from their home-country sports association plus an invitation from the host event organizer in Bosnia and Herzegovina.',
    'Short-stay national visa, commonly up to 90 days within a 180-day period — confirm with the mission',
    'Apply in person at the accredited Bosnian mission with an association letter and host-organizer invitation',
    1,
    'Processing time not independently confirmed this session',
    'No resident BiH embassy confirmed in India this session — verify the current accredited mission with the BiH Ministry of Foreign Affairs before applying',
    'Obtain a letter from your home-country sports association confirming your role\nObtain an invitation letter from the host event organizer in Bosnia and Herzegovina\nComplete the national visa application form\nBook an appointment and attend in person\nTrack the decision and collect your passport',
    '/assets/images/visa-heroes/bosnia-and-herzegovina.webp',
    'Not independently verified this session — WebSearch quota was exhausted and WebFetch was blocked by egress-proxy policy for every domain attempted; reflects general prior knowledge only, verify directly with the BiH MFA before applying.', 'https://www.mfa.gov.ba/', '2026-09-17'
);
SET @bih9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bih9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih9, 'Core Documents', 'Required from every applicant.', 1);
SET @bih9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bih9s1, 'Home-Country Sports Association Letter', 'Confirms role and no-employment status.', 'original', 1, 0, 1, 2),
(@bih9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @bih9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih9s2, 'Team/Delegation List', NULL, 'if_applicable', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(111, 9, NULL, 'EUR', 'Confirmed After Assessment', 'Fee schedule could not be verified this session — contact the accredited Bosnian mission for the current national visa fee.', '2026-09-17', NOW(), 'https://www.mfa.gov.ba/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do team officials need separate letters from athletes?', 'Not independently confirmed this session — typically each traveller needs their own supporting documentation; confirm the exact requirement with the mission or event organizer.', 111, 9, 11113, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    111, 10, 'BIH-DEP-IN-10', '2026.09', 'published',
    'Spouse, minor children, or dependents joining an Indian national who holds a valid Bosnia and Herzegovina work or residence permit.',
    'Family members of an Indian sponsor holding a valid BiH temporary/permanent residence permit generally apply for family reunification via the accredited Bosnian mission, followed by residence registration with the Foreigners'' Affairs Service.',
    'Tied to the sponsor''s residence permit validity — confirm with the mission',
    'Apply in person at the accredited Bosnian mission with the sponsor''s permit and relationship proof',
    1,
    'Processing time not independently confirmed this session; family reunification cases are commonly longer than short-stay visas region-wide',
    'No resident BiH embassy confirmed in India this session — verify the current accredited mission with the BiH Ministry of Foreign Affairs before applying',
    'Confirm the sponsor holds a valid BiH residence/work permit\nGather relationship proof (marriage/birth certificates) and the sponsor''s permit copy\nComplete the national visa application form\nBook an appointment and attend in person\nRegister residence with the Foreigners'' Affairs Service after arrival',
    '/assets/images/visa-heroes/bosnia-and-herzegovina.webp',
    'Not independently verified this session — WebSearch quota was exhausted and WebFetch was blocked by egress-proxy policy for every domain attempted; reflects general prior knowledge only, verify directly with the BiH MFA before applying.', 'https://www.mfa.gov.ba/', '2026-09-17'
);
SET @bih10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bih10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih10, 'Core Documents', 'Required from every applicant.', 1);
SET @bih10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bih10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bih10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @bih10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bih10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@bih10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(111, 10, NULL, 'EUR', 'Confirmed After Assessment', 'Fee schedule could not be verified this session — contact the accredited Bosnian mission for the current family-reunification visa fee.', '2026-09-17', NOW(), 'https://www.mfa.gov.ba/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How long must the sponsor hold their permit before applying for dependents?', 'Not independently confirmed this session — minimum prior-residence requirements vary by country and were not verifiable this session; confirm the current rule with the mission.', 111, 10, 11114, 1);
