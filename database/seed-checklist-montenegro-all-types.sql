-- Montenegro Visa Checklist Engine content for all 10 visa types —
-- built this session via WebSearch (AI-synthesized results citing
-- secondary sources) after direct WebFetch access to primary sources
-- was blocked by the network egress proxy.
--
-- IMPORTANT SOURCING CAVEAT: gov.me (Government of Montenegro),
-- en.wikipedia.org, visa.vfsglobal.com, travunited.com,
-- thebalkanguide.com, and discover.passportindex.org were all BLOCKED
-- for direct fetch this session (EGRESS_BLOCKED). Findings below were
-- triangulated from WebSearch result snippets referencing VFS Global,
-- Wego Travel, VisaGo, embassyinformation.com, allblogs.in,
-- work-in-montenegro.com, Rona Legal, GoMonte, S.A. Accounting,
-- Playroll, and DesiNRI secondary sourcing. Sources sometimes
-- conflicted (e.g. one source claimed 90-day visa-free entry for
-- Indians while the clear majority — and the more recently dated —
-- sources say a visa is required); the majority/most-recent position
-- is used throughout and flagged where uncertain. Government consular
-- fee figures in EUR are flagged as approximate. Student-visa and
-- Transit-visa India-specific processing times could NOT be
-- independently confirmed this session and are explicitly flagged as
-- such in their processing_note/source fields below.
--
-- Montenegro's real, distinctive, cross-source-verified facts:
--   - Montenegro has NO resident embassy or consulate-general in
--     India. Under a Montenegro-Serbia bilateral consular-services
--     agreement, the Embassy of Serbia, New Delhi acts as Montenegro's
--     consular-service provider and visa-decision authority for
--     Indian applicants — a genuinely distinctive arrangement (an
--     honorary consulate in New Delhi exists but has limited/no
--     visa-issuing authority). Application submission itself is
--     routed through VFS Global.
--   - VFS Global runs WALK-IN (no-appointment-required) Montenegro
--     visa application centres in India — New Delhi, Mumbai, Kolkata,
--     and Kochi — an unusually applicant-friendly submission model
--     compared to most European short-stay visa regimes.
--   - Indian ordinary-passport holders generally REQUIRE a Type C
--     visa for Montenegro — there is no e-visa and no visa-on-arrival
--     for India. The one broadly-confirmed exception: a valid
--     multiple-entry Schengen, US, or UK visa/residence permit grants
--     visa-free entry for up to 30 days (or until that visa expires,
--     whichever is sooner); a valid UAE residence permit grants up to
--     10 days visa-free.
--   - Montenegro is an EU-accession candidate (informally targeting
--     membership around 2028) and is actively tightening its
--     visa-free list to align with the EU's common visa list as an
--     accession Chapter 24 benchmark: Armenia, Uzbekistan, Egypt, and
--     Kuwait lost visa-free access on 29 October 2025, and Belarus,
--     China, Russia, Saudi Arabia, and Turkey are set to lose it on 1
--     November 2026. India was already visa-required before both
--     rounds, so it is not directly affected by these specific
--     changes, but they reflect the same policy direction and are
--     worth flagging to travellers as a live, moving target.
--   - Work: the "Single Permit" (Jedinstvena dozvola za boravak i
--     rad) is a genuinely combined biometric work-authorization-plus-
--     residence document (max ~1 year, renewable), not two separate
--     permits. Montenegro's national quota for 2026 is reported at
--     28,988 permits, and India is reported as Montenegro's largest
--     Asian labour-supply corridor.
--   - Family reunification (Dependent) is explicitly SEQUENTIAL, not
--     simultaneous: dependents cannot file until the sponsor already
--     holds the finalized, physical residence card in hand, and
--     dependents typically then enter Montenegro on a short-stay
--     visa to file the reunification application locally with the
--     Ministry of Interior (MUP) — plus a notarized sponsor support
--     guarantee and proof of liquid funds (~€3,650-4,200/dependent/
--     year) are required, and civil documents need apostille or full
--     consular legalization.
--
-- country_id 135 = Montenegro. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical,
-- 8=Conference, 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Type C Short-Stay Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    135, 1, 'MNE-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel along Montenegro''s Adriatic coast and mountain regions.',
    'Indian ordinary-passport holders generally require a Type C short-stay visa — Montenegro offers no e-visa or visa-on-arrival for India. Exception: a valid multiple-entry Schengen, US, or UK visa/residence permit allows visa-free entry for up to 30 days (or until that visa expires, whichever is sooner); a valid UAE residence permit allows up to 10 days.',
    'Single or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global (walk-in accepted; New Delhi, Mumbai, Kolkata, Kochi) — decision by Embassy of Serbia',
    1,
    'Standard processing around 10 working days; can extend to 30 days on review, or 60 days if extra documents are requested',
    'Embassy of Serbia, New Delhi (Montenegro''s designated consular-service provider in India); VFS Global handles submission',
    'Check whether you qualify for the Schengen/US/UK/UAE visa-free exception first\nIf not exempt, walk in to (or book) a VFS Global Montenegro centre\nComplete the application form and gather supporting documents\nSubmit documents and biometrics at VFS Global\nTrack status; the Embassy of Serbia issues the final decision',
    '/assets/images/visa-heroes/montenegro.webp',
    'Cross-checked against VFS Global and Government of Montenegro (gov.me) secondary sourcing; gov.me and VFS Global domains were not directly fetchable this session (network egress blocked)', 'https://www.gov.me/en/article/visa-application-centers-of-montenegro-to-open-in-india-and-kyrgyzstan', '2026-09-17'
);
SET @mne1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mne1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne1, 'Core Documents', 'Required from every applicant.', 1);
SET @mne1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne1s1, 'Valid Passport (3+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@mne1s1, 'Completed Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@mne1s1, 'Travel Medical Insurance (Valid for Montenegro)', NULL, 'original', 1, 0, 1, 3),
(@mne1s1, 'Proof of Schengen/US/UK/UAE Visa or Residence Permit (If Claiming Exemption)', 'Only needed if applying for the visa-free exception instead of a Type C visa.', 'copy', 0, 1, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mne1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne1s2, 'Confirmed Hotel Booking', NULL, 'copy', 1, 0, 0, 1),
(@mne1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@mne1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(135, 1, 35.00, 'EUR', 'Type C Short-Stay Visa Fee (Approximate)', 'Single-entry fee reported around €35; multiple-entry variants reportedly run up to €70. A separate VFS Global service charge (quoted around INR 2,821 inclusive of GST) also applies. Treat as approximate pending direct gov.me confirmation.', '2026-09-01', NOW(), 'https://work-in-montenegro.com/index.php/visas/visa-for-short-term-stay-c-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian passport holders need a visa for Montenegro?', 'Generally yes — Montenegro has no e-visa or visa-on-arrival for Indian ordinary passports. The main exception is holding a valid multiple-entry Schengen, US, or UK visa/residence permit, which allows visa-free entry for up to 30 days.', 135, 1, 13500, 1),
('Where do Indian applicants submit a Montenegro visa application?', 'Montenegro has no resident embassy in India, so applications are submitted via walk-in VFS Global centres in New Delhi, Mumbai, Kolkata, or Kochi, while the actual decision is made by the Embassy of Serbia, New Delhi, under a Montenegro-Serbia consular-services agreement.', 135, 1, 13501, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Type C Short-Stay Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    135, 2, 'MNE-BUS-IN-02', '2026.09', 'published',
    'Trade negotiations, meetings, and commercial activity in Montenegro.',
    'Indian nationals travelling for business use the same Type C visa as Tourist, with a company invitation letter from the Montenegrin host and an employer forwarding letter as the differentiating documents. The Schengen/US/UK 30-day visa-free exception can also apply if it covers a business purpose.',
    'Single, double, or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global with a business invitation letter — decision by Embassy of Serbia, New Delhi',
    1,
    'Standard processing around 10 working days; extendable to 30 or 60 days for review',
    'Embassy of Serbia, New Delhi (Montenegro''s designated consular-service provider in India); VFS Global handles submission',
    'Obtain an invitation letter from the Montenegrin host company\nGather an employer forwarding/sponsorship letter\nComplete the visa application form\nSubmit documents and biometrics at VFS Global\nAwait the Embassy of Serbia''s decision',
    '/assets/images/visa-heroes/montenegro.webp',
    'Cross-checked against VFS Global and work-in-montenegro.com secondary sourcing, triangulated against sources not directly fetchable this session', 'https://work-in-montenegro.com/index.php/visas/visa-for-short-term-stay-c-visa', '2026-09-17'
);
SET @mne2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mne2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne2, 'Core Documents', 'Required from every applicant.', 1);
SET @mne2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mne2s1, 'Invitation Letter from Montenegrin Host Company', NULL, 'original', 1, 0, 1, 2),
(@mne2s1, 'Travel Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @mne2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@mne2s2, 'Business Registration Proof', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(135, 2, 35.00, 'EUR', 'Type C Short-Stay Visa Fee (Approximate)', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://work-in-montenegro.com/index.php/visas/visa-for-short-term-stay-c-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the Montenegro business invitation letter need to be in Montenegrin?', 'This was not independently confirmed this session — treat as unconfirmed and check the current requirement with your host company or VFS Global before applying.', 135, 2, 13502, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Type D Long-Stay Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    135, 3, 'MNE-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Montenegrin university or recognized educational institution.',
    'Indian nationals admitted to a recognized Montenegrin institution apply for a long-stay Type D student visa. Validity is tied to the program duration; after arrival, students must separately register for a temporary residence permit (boravak) with the local police/Ministry of Interior office.',
    'Tied to the academic program duration, renewed via the temporary residence permit',
    'Apply via VFS Global or directly at the Embassy of Serbia, New Delhi, for the Type D student visa',
    1,
    'NOT independently confirmed this session — general long-stay/D-visa applications reportedly take 30+ days; confirm the current timeline before booking travel',
    'Embassy of Serbia, New Delhi (Montenegro''s designated consular-service provider in India)',
    'Secure admission at a recognized Montenegrin institution\nArrange proof of funds, accommodation, and health insurance valid in Montenegro\nApply for the Type D student visa via VFS Global or the Embassy of Serbia\nTravel to Montenegro and register for a temporary residence permit (boravak)\nRenew the residence permit for each subsequent year of the program',
    '/assets/images/visa-heroes/montenegro.webp',
    'Cross-checked against secondary study-abroad guidance and gov.me residence-permit pages; gov.me not directly fetchable this session, so processing time is flagged NOT independently confirmed', 'https://www.gov.me/en/article/temporary-residence', '2026-09-17'
);
SET @mne3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mne3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne3, 'Core Documents', 'Required from every applicant.', 1);
SET @mne3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mne3s1, 'Admission Letter from Montenegrin Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @mne3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@mne3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@mne3s2, 'Health Insurance Valid in Montenegro', NULL, 'original', 1, 0, 0, 3),
(@mne3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(135, 3, NULL, 'EUR', 'Confirmed After Assessment', 'The Type D student visa/residence-permit fee was not independently confirmed this session — figures vary by institution and permit duration; contact us to confirm the current cost.', '2026-09-01', NOW(), 'https://www.gov.me/en/article/temporary-residence', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need to register separately after arriving in Montenegro to study?', 'Yes — beyond the entry visa, students must register for a temporary residence permit (boravak) with the local police/Ministry of Interior office once in Montenegro, and renew it for each year of the program.', 135, 3, 13503, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Single Permit (Work + Residence)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    135, 4, 'MNE-WORK-IN-04', '2026.09', 'published',
    'Employment with a Montenegrin employer under the combined Single Permit (Jedinstvena dozvola za boravak i rad).',
    'Indian nationals with a confirmed job offer apply for the Single Permit — a combined biometric work-and-residence document for a specific sponsoring employer, typically valid up to 1 year and renewable. Employment consumes Montenegro''s national annual permit quota (28,988 for 2026); India is reported as Montenegro''s largest Asian labour-supply corridor.',
    'Up to 1 year, renewable for the contract duration',
    'Employer files with Montenegro''s Ministry of Interior; applicant applies for the entry visa via VFS Global/Embassy of Serbia',
    1,
    'Reported at roughly 30 days standard, up to 60 days for complex cases; overall offer-to-permit process commonly takes 6-10 weeks',
    'Ministry of Interior, Montenegro (Single Permit decision); Embassy of Serbia, New Delhi (entry visa)',
    'Secure a job offer from a Montenegrin employer\nEmployer files the Single Permit application with the Ministry of Interior\nApply for the entry visa via VFS Global/Embassy of Serbia, New Delhi, if required\nTravel to Montenegro and complete biometric registration\nCollect the Single Permit (combined work-and-residence document)',
    '/assets/images/visa-heroes/montenegro.webp',
    'Cross-checked against Rona Legal, S.A. Accounting, GoMonte, and Playroll secondary sourcing on the Single Permit route, triangulated against sources not directly fetchable this session', 'https://gomonte.me/en/blog/post/53/', '2026-09-17'
);
SET @mne4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mne4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne4, 'Core Documents', 'Required from every applicant.', 1);
SET @mne4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mne4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@mne4s1, 'Employer Single Permit Filing Confirmation', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @mne4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@mne4s2, 'Proof of Accommodation in Montenegro', NULL, 'copy', 1, 0, 0, 2),
(@mne4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 3),
(@mne4s2, 'Health Insurance', NULL, 'original', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(135, 4, NULL, 'EUR', 'Confirmed After Assessment', 'Single Permit government fees were not independently confirmed this session; contact the Ministry of Interior or an immigration advisor for the current fee schedule.', '2026-09-01', NOW(), 'https://gomonte.me/en/blog/post/53/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Montenegro work permit a separate document from the residence permit?', 'No — Montenegro issues a single combined biometric document, the "Single Permit" (Jedinstvena dozvola za boravak i rad), that authorizes both employment with the sponsoring employer and residence, rather than two separate permits.', 135, 4, 13504, 1),
('Is there a cap on how many work permits Montenegro issues each year?', 'Yes — employment and seasonal-employment permits draw from a national annual quota, reported at 28,988 for 2026, and India is reported as Montenegro''s largest Asian labour-supply corridor.', 135, 4, 13505, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Type C Short-Stay Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    135, 5, 'MNE-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Montenegro.',
    'Indian nationals with family or friends in Montenegro use the same Type C visa as Tourist, with an invitation letter from the host and documentary proof of the relationship as the differentiating requirement.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with an invitation letter and relationship proof — decision by Embassy of Serbia',
    1,
    'Standard processing around 10 working days; can extend to 30 or 60 days for review',
    'Embassy of Serbia, New Delhi (Montenegro''s designated consular-service provider in India); VFS Global handles submission',
    'Obtain an invitation letter from your host in Montenegro\nGather documents proving the family/personal relationship\nComplete the visa application form\nSubmit documents and biometrics at VFS Global\nAwait the Embassy of Serbia''s decision',
    '/assets/images/visa-heroes/montenegro.webp',
    'Cross-checked against VFS Global secondary sourcing, triangulated against sources not directly fetchable this session', 'https://www.gov.me/en/article/visa-application-centers-of-montenegro-to-open-in-india-and-kyrgyzstan', '2026-09-17'
);
SET @mne5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mne5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne5, 'Core Documents', 'Required from every applicant.', 1);
SET @mne5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mne5s1, 'Invitation Letter from Host in Montenegro', NULL, 'original', 1, 0, 1, 2),
(@mne5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @mne5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@mne5s2, 'Travel Medical Insurance', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(135, 5, 35.00, 'EUR', 'Type C Short-Stay Visa Fee (Approximate)', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://work-in-montenegro.com/index.php/visas/visa-for-short-term-stay-c-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Family Visit visa different from applying for Dependent status?', 'Yes — Family Visit is a short-stay Type C visa for visiting relatives or friends (up to 90 days). Dependent status is a separate, long-term family-reunification residence permit for spouses/children joining a Montenegrin resident or citizen.', 135, 5, 13506, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Type A Airport Transit Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    135, 6, 'MNE-TRAN-IN-06', '2026.09', 'published',
    'Passing through a Montenegrin airport en route to a non-Montenegro destination.',
    'A distinct Type A airport transit visa, valid up to 3 months, for one or more transits through the international transit zone without entering Montenegrin territory. Not required for a purely airside connection completed within that zone; required only if leaving the zone or on layovers the airport doesn''t treat as pure transit.',
    'Valid for the transit window; the visa itself may be issued for up to 3 months',
    'Apply via VFS Global with your itinerary/onward ticket, only if your connection genuinely requires leaving the transit zone',
    1,
    'NOT independently confirmed this session for the Type A category specifically; general short-stay timelines (around 10 working days) likely apply',
    'Embassy of Serbia, New Delhi (Montenegro''s designated consular-service provider in India); VFS Global handles submission',
    'Confirm with your airline whether your specific connection requires a Type A visa\nIf required, apply via VFS Global with your onward ticket and itinerary\nSubmit biometrics if requested\nAwait the Embassy of Serbia''s decision',
    '/assets/images/visa-heroes/montenegro.webp',
    'Cross-checked against secondary transit-visa guidance; India-specific Type A processing time flagged NOT independently confirmed this session', 'https://www.gov.me/en/article/visa-application-centers-of-montenegro-to-open-in-india-and-kyrgyzstan', '2026-09-17'
);
SET @mne6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mne6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne6, 'Core Documents', 'Required if a Type A visa is genuinely needed.', 1);
SET @mne6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mne6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @mne6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(135, 6, NULL, 'EUR', 'Confirmed After Assessment', 'Type A airport transit visa fee not independently confirmed this session; the comparable Type C short-stay fee runs around €35. Contact us to confirm the current transit-visa cost.', '2026-09-01', NOW(), 'https://www.gov.me/en/article/visa-application-centers-of-montenegro-to-open-in-india-and-kyrgyzstan', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a Type A transit visa let me leave the Montenegrin airport?', 'No — a Type A visa only authorizes remaining in the international transit zone; it does not permit passing through Montenegrin passport control or entering the country.', 135, 6, 13507, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Type C Short-Stay Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    135, 7, 'MNE-MED-IN-07', '2026.09', 'published',
    'Travel to Montenegro for medical treatment.',
    'Indian nationals travelling for treatment use the same Type C visa as Tourist, requiring a certificate from the treating Montenegrin doctor/institution confirming the need for specific treatment, plus travel medical insurance.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with the medical certificate and travel insurance — decision by Embassy of Serbia',
    1,
    'Standard processing around 10 working days; can extend to 30 or 60 days for review',
    'Embassy of Serbia, New Delhi (Montenegro''s designated consular-service provider in India); VFS Global handles submission',
    'Obtain a certificate from the treating Montenegrin doctor/institution\nArrange travel medical insurance\nComplete the visa application form\nSubmit documents and biometrics at VFS Global\nAwait the Embassy of Serbia''s decision',
    '/assets/images/visa-heroes/montenegro.webp',
    'Cross-checked against VFS Global secondary sourcing, triangulated against sources not directly fetchable this session', 'https://www.gov.me/en/article/visa-application-centers-of-montenegro-to-open-in-india-and-kyrgyzstan', '2026-09-17'
);
SET @mne7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mne7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne7, 'Core Documents', 'Required from every applicant.', 1);
SET @mne7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mne7s1, 'Medical Certificate/Institution Confirmation', NULL, 'original', 1, 0, 1, 2),
(@mne7s1, 'Travel Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @mne7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@mne7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(135, 7, 35.00, 'EUR', 'Type C Short-Stay Visa Fee (Approximate)', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://work-in-montenegro.com/index.php/visas/visa-for-short-term-stay-c-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Montenegro a common medical-tourism destination for Indians?', 'This was not independently confirmed this session — the checklist uses the standard Type C medical-purpose documentation; confirm current facilities and costs directly with the treating institution before travel.', 135, 7, 13508, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Type C Short-Stay Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    135, 8, 'MNE-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade events in Montenegro.',
    'Indian nationals attending a conference use the same Type C visa as Tourist, with a conference invitation/registration confirmation as the differentiating document.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a conference invitation/registration confirmation — decision by Embassy of Serbia',
    1,
    'Standard processing around 10 working days; can extend to 30 or 60 days for review',
    'Embassy of Serbia, New Delhi (Montenegro''s designated consular-service provider in India); VFS Global handles submission',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nComplete the visa application form\nSubmit documents and biometrics at VFS Global\nAwait the Embassy of Serbia''s decision',
    '/assets/images/visa-heroes/montenegro.webp',
    'Cross-checked against VFS Global secondary sourcing, triangulated against sources not directly fetchable this session', 'https://www.gov.me/en/article/visa-application-centers-of-montenegro-to-open-in-india-and-kyrgyzstan', '2026-09-17'
);
SET @mne8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mne8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne8, 'Core Documents', 'Required from every applicant.', 1);
SET @mne8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mne8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @mne8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@mne8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(135, 8, 35.00, 'EUR', 'Type C Short-Stay Visa Fee (Approximate)', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://work-in-montenegro.com/index.php/visas/visa-for-short-term-stay-c-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Conference and Tourist visas share the same documentary checklist for Montenegro?', 'They share the same Type C visa category; the conference invitation or registration confirmation is the main additional document required beyond the standard Tourist checklist.', 135, 8, 13509, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Type C Short-Stay Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    135, 9, 'MNE-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Montenegro.',
    'Indian nationals competing or officiating use the same Type C visa as Tourist/Conference, requiring a letter from the home-country sports association and an invitation from the host event organizer.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a home-association letter and host-organizer invitation — decision by Embassy of Serbia',
    1,
    'Standard processing around 10 working days; can extend to 30 or 60 days for review',
    'Embassy of Serbia, New Delhi (Montenegro''s designated consular-service provider in India); VFS Global handles submission',
    'Obtain a letter from your resident-country sports association confirming your role and no-employment status\nObtain an invitation letter from the host event organizer with event details\nComplete the visa application form\nSubmit documents and biometrics at VFS Global\nAwait the Embassy of Serbia''s decision',
    '/assets/images/visa-heroes/montenegro.webp',
    'Cross-checked against VFS Global secondary sourcing, triangulated against sources not directly fetchable this session', 'https://www.gov.me/en/article/visa-application-centers-of-montenegro-to-open-in-india-and-kyrgyzstan', '2026-09-17'
);
SET @mne9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mne9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne9, 'Core Documents', 'Required from every applicant.', 1);
SET @mne9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mne9s1, 'Home-Country Sports Association Letter', 'Confirms role and no-employment status.', 'original', 1, 0, 1, 2),
(@mne9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @mne9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(135, 9, 35.00, 'EUR', 'Type C Short-Stay Visa Fee (Approximate)', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://work-in-montenegro.com/index.php/visas/visa-for-short-term-stay-c-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What''s different about the Sports visa documentation vs. a generic invitation letter?', 'It requires two separate specific letters — one from your home-country sports association confirming your role and no-employment status, and one from the host event organizer — rather than just one generic invitation letter.', 135, 9, 13510, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification Residence Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    135, 10, 'MNE-DEP-IN-10', '2026.09', 'published',
    'Spouse or minor children joining an Indian Single Permit holder, or a Montenegrin citizen/resident, via family reunification.',
    'Family members of an Indian national holding a finalized Montenegrin residence permit (or a Montenegrin citizen) may apply for a family-reunification residence permit. Dependents cannot apply simultaneously with the sponsor — the sponsor must already hold the physical, finalized residence card, after which dependents typically enter on a short-stay visa to file locally with the Ministry of Interior.',
    'Tied to the sponsor''s residence permit validity, renewable',
    'Filed in person at the Ministry of Interior (MUP), Montenegro, after the sponsor''s permit is finalized',
    1,
    'Reported at around 40 days from a complete application, per the Ministry of Interior — notably longer than short-stay Type C processing',
    'Ministry of Interior (MUP), Montenegro (decision authority); dependents typically enter via VFS Global/Embassy of Serbia, New Delhi first',
    'Confirm the sponsor holds the finalized, physical Montenegrin residence permit\nGather apostilled/consular-legalized relationship documents (marriage certificate under 6 months old, birth certificates)\nHave the sponsor execute a notarized support guarantee and show proof of liquid funds\nDependent enters Montenegro (commonly on a short-stay visa) and files the family-reunification application with the MUP\nAwait the MUP decision (~40 days) and collect the residence permit',
    '/assets/images/visa-heroes/montenegro.webp',
    'Cross-checked against Rona Legal and GoMonte secondary sourcing on Montenegro family reunification, triangulated against sources not directly fetchable this session', 'https://www.ronalegal.com/en/blog/montenegro-family-reunification-residence-permit-for-spouses-and-children-2026', '2026-09-17'
);
SET @mne10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mne10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne10, 'Core Documents', 'Required from every applicant.', 1);
SET @mne10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mne10s1, 'Proof of Relationship to Sponsor (Apostilled/Legalized)', 'Marriage certificate must be under 6 months old; birth certificates for children.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mne10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit and financial support.', 2);
SET @mne10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mne10s2, 'Sponsor''s Finalized Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@mne10s2, 'Notarized Sponsor Support Guarantee', NULL, 'original', 1, 0, 0, 2),
(@mne10s2, 'Proof of Liquid Funds in a Montenegrin Bank Account', 'Reportedly around €3,650-4,200 per dependent per year.', 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(135, 10, NULL, 'EUR', 'Confirmed After Assessment', 'Family-reunification residence-permit government fee not independently confirmed this session; the sponsor must additionally show proof of liquid funds of roughly €3,650-4,200 per dependent per year.', '2026-09-01', NOW(), 'https://www.ronalegal.com/en/blog/montenegro-family-reunification-residence-permit-for-spouses-and-children-2026', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependents apply for their Montenegro residence permit at the same time as the sponsor?', 'No — dependents can only apply after the sponsor already holds the finalized, physical residence card. They typically then enter Montenegro on a short-stay visa to file the family-reunification application locally.', 135, 10, 13511, 1),
('Does a Dependent residence permit in Montenegro allow the spouse to work?', 'Not automatically — a temporary residence permit granted through family reunification does not by itself grant the right to seek employment with Montenegrin companies; a separate work authorization is generally required.', 135, 10, 13512, 1);
