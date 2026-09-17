-- Moldova Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url left NULL at
-- authoring time (no photo bundle supplied yet).
--
-- IMPORTANT SOURCING CAVEAT: the official portals evisa.gov.md,
-- e-visa.md, and india.mfa.gov.md (Embassy of the Republic of Moldova,
-- New Delhi — confirmed to genuinely exist at 174 Jor Bagh Colony Road)
-- were all blocked from direct fetch by the network egress proxy this
-- session. All findings below are triangulated across multiple
-- web-search-indexed secondary sources (VFS Global's own 2024 media
-- release, visa-agency guidance, and Moldova's General Inspectorate for
-- Migration / igm.gov.md invitation-letter guidance as indexed by
-- search). Fee figures conflict across sources by roughly 2x (~€40 vs.
-- a ~$80 equivalent for the short-stay e-Visa) and are flagged as
-- approximate throughout — confirm exact amounts on evisa.gov.md before
-- paying. The 21 July 2026 "documentary waiver" regulation change and
-- the September 2025 Digital Nomad Visa are each sourced from a single
-- blog-level secondary source and are flagged as NOT independently
-- confirmed this session; they are included only as FAQ-level pointers,
-- not load-bearing checklist facts.
--
-- Moldova's real, distinctive facts (as found this session):
--   - Moldova is NOT in the EU or Schengen area — it has its own
--     independent visa policy, separate from any Schengen requirement.
--     Indian passport holders generally DO need a Moldovan visa, but a
--     genuinely distinctive exemption applies: holders of a valid
--     MULTIPLE-ENTRY Schengen visa, or a valid US or UK visa/residence
--     permit, may enter Moldova visa-free for up to 90 days in any
--     180-day period, without a separate Moldovan visa at all.
--   - Short-stay (Type C, incl. C/A business sub-type) and transit
--     (Type B) visas are available as a fully self-service e-Visa via
--     evisa.gov.md — no embassy visit, no passport submission, no
--     biometrics; the approved visa arrives as a PDF by email. This is
--     a materially different (lighter) process than a Schengen C-visa.
--   - VFS Global was separately appointed (per its own 2024 media
--     release) to also accept Moldova visa applications from India,
--     expanding beyond New Delhi to Jalandhar, Mumbai, Kolkata, Chennai,
--     and Kochi from December 2024 — so applicants genuinely have two
--     channels (pure self-service e-Visa, or an in-person VFS option).
--   - Long-stay Type D visas (student, work, family reunification,
--     research) are explicitly NOT available online or via VFS — they
--     must be submitted in person directly at the Embassy of the
--     Republic of Moldova, New Delhi, which is a real, staffed mission
--     (not a case routed through a third country).
--   - Moldova is a long-standing budget MBBS destination for Indian
--     students, centred on Nicolae Testemițanu State University of
--     Medicine and Pharmacy (USMF) in Chișinău — reported tuition in
--     the $4,000-5,500/year range (~₹40-45 lakh across the 6-year
--     program), English-medium teaching, and reported NMC/WHO
--     eligibility (verify current recognition status directly before
--     enrolling, as this changes periodically).
--   - Work visas (D/AM) are employer-driven and paired with a separate
--     work permit from the Ministry of Labour, Social Protection and
--     Family, with employers generally expected to first attempt to
--     fill the role with a Moldovan/EU national.
--   - Family reunification (D/VF) explicitly requires apostilled
--     relationship documents translated by a certified Romanian
--     translator — a genuinely distinctive procedural detail tied to
--     Moldova's Romanian-language administration.
--
-- country_id 133 = Moldova. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Type C Short-Stay e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    133, 1, 'MDA-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to the Republic of Moldova.',
    'Indian passport holders generally need a Moldovan visa; holders of a valid multiple-entry Schengen visa, or a valid US or UK visa/residence permit, may enter Moldova visa-free for up to 90 days in any 180-day period. Otherwise, apply for the short-stay Type C e-Visa, a fully self-service online process with no embassy visit or biometrics required.',
    'Up to 90 days within any 180-day period (Type C e-Visa)',
    'Self-service online via evisa.gov.md; VFS Global centres (6 Indian cities) also accept applications',
    0,
    'Reported at around 10 working days for a complete e-Visa application; some secondary sources cite up to 15-20 working days, so apply well ahead of travel.',
    'Embassy of the Republic of Moldova, New Delhi (policy authority); e-Visa self-service or VFS Global centres in New Delhi, Jalandhar, Mumbai, Kolkata, Chennai, and Kochi',
    'Check whether a valid multiple-entry Schengen, US, or UK visa/residence permit already exempts you\nIf not exempt, apply online at evisa.gov.md with passport, photo, and travel details\nUpload supporting documents (itinerary, accommodation, funds, insurance)\nPay the e-Visa fee online\nReceive the approved e-Visa as a PDF by email and carry a printed copy',
    '/assets/images/visa-heroes/moldova.webp',
    'Cross-checked against VFS Global''s 2024 media release on Moldova visa delivery from India and multiple visa-agency secondary sources; official evisa.gov.md and india.mfa.gov.md pages could not be directly fetched this session', 'https://www.evisa.gov.md/', '2026-09-17'
);
SET @mda1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mda1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda1, 'Core Documents', 'Required from every applicant.', 1);
SET @mda1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda1s1, 'Valid Passport (3+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@mda1s1, 'Passport-Size Photograph (Digital, Per e-Visa Spec)', NULL, 'copy', 1, 0, 1, 2),
(@mda1s1, 'Confirmed Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda1, 'Supporting Documents', 'Evidence of your travel plans, funds, and cover.', 2);
SET @mda1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda1s2, 'Confirmed Hotel Booking or Host Invitation', NULL, 'copy', 1, 0, 0, 1),
(@mda1s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 2),
(@mda1s2, 'Travel Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 0, 3),
(@mda1s2, 'Valid Multiple-Entry Schengen/US/UK Visa or Residence Permit', 'If claiming the Moldova visa-waiver exemption instead of applying for a Moldovan visa.', 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(133, 1, 40.00, 'EUR', 'Type C e-Visa Fee (Approximate)', 'Reported at roughly €40 by several visa-agency sources; other sources cite a figure closer to a $80 equivalent — treat as approximate and confirm the exact amount on evisa.gov.md before paying.', '2026-09-01', NOW(), 'https://www.evisa.gov.md/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a Moldovan visa if I already have a Schengen visa?', 'Not necessarily — a valid multiple-entry Schengen visa (or a valid US or UK visa/residence permit) lets Indian passport holders enter Moldova visa-free for up to 90 days in any 180-day period, without a separate Moldovan visa.', 133, 1, 13300, 1),
('Do I need to visit an embassy or give biometrics for a Moldova Tourist e-Visa?', 'No — the Type C e-Visa is a fully self-service online process through evisa.gov.md; no embassy visit or biometrics is required for this short-stay category, unlike many Schengen-area visas.', 133, 1, 13301, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Type C/A Short-Stay e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    133, 2, 'MDA-BUS-IN-02', '2026.09', 'published',
    'Trade, negotiations, and commercial activity in the Republic of Moldova.',
    'Indian nationals travelling for business use the same Type C short-stay e-Visa as Tourist, sub-classified C/A for economic and commercial purposes — contract negotiations, inspecting goods under commercial/industrial cooperation agreements, or business meetings. The same Schengen/US/UK visa exemption applies.',
    'Up to 90 days within any 180-day period (Type C/A e-Visa)',
    'Self-service online via evisa.gov.md with a business invitation letter; VFS Global centres also accept applications',
    0,
    'Reported at around 10 working days for a complete e-Visa application; allow longer if the invitation letter needs verification.',
    'Embassy of the Republic of Moldova, New Delhi (policy authority); e-Visa self-service or VFS Global centres in New Delhi, Jalandhar, Mumbai, Kolkata, Chennai, and Kochi',
    'Obtain an invitation letter from the Moldovan host company confirming purpose, dates, and expense arrangements\nGather an Indian employer forwarding/sponsorship letter\nApply online at evisa.gov.md or via VFS Global with supporting documents\nPay the e-Visa fee online\nReceive the approved e-Visa as a PDF by email',
    '/assets/images/visa-heroes/moldova.webp',
    'Cross-checked against Moldova''s General Inspectorate for Migration (igm.gov.md) invitation-letter guidance and VFS Global secondary sourcing; official evisa.gov.md and india.mfa.gov.md pages could not be directly fetched this session', 'https://www.evisa.gov.md/', '2026-09-17'
);
SET @mda2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mda2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda2, 'Core Documents', 'Required from every applicant.', 1);
SET @mda2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mda2s1, 'Business Invitation Letter (Original + Copy, Naming Purpose/Dates)', NULL, 'both', 1, 0, 1, 2),
(@mda2s1, 'Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @mda2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@mda2s2, 'Business Registration Proof (If Self-Employed)', NULL, 'copy', 0, 1, 0, 2),
(@mda2s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@mda2s2, 'Travel Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(133, 2, 40.00, 'EUR', 'Type C/A e-Visa Fee (Approximate)', 'Reported at roughly €40, same fee structure as Tourist — some sources cite a higher $80 equivalent, so confirm the exact amount on evisa.gov.md before paying.', '2026-09-01', NOW(), 'https://www.evisa.gov.md/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What must a Moldovan business invitation letter include?', 'Per Moldova''s General Inspectorate for Migration guidance, an invitation from a Moldovan legal entity should include the inviting company''s and invitee''s identification details plus documents confirming the business purpose, such as a contract or meeting agenda.', 133, 2, 13302, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Type D/ST Long-Stay Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    133, 3, 'MDA-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Moldovan university or institution, including medical programs in Chișinău.',
    'Indian nationals admitted to a Moldovan institution apply for the Type D long-stay student visa (D/ST), valid up to 12 months and renewable toward a residence permit. Moldova is a long-standing budget MBBS destination for Indian students; Nicolae Testemițanu State University (USMF) Chișinău is reported as NMC-eligible, WHO-listed, English-medium — verify current recognition status directly before enrolling.',
    'Up to 12 months on the D/ST visa, renewable for the program duration via a residence permit',
    'In person at the Embassy of the Republic of Moldova, New Delhi — NOT available via evisa.gov.md or VFS Global, unlike short-stay categories',
    1,
    'Long-stay D-type processing is reported to take longer than short-stay e-Visa applications; apply well ahead of the academic term start date.',
    'Embassy of the Republic of Moldova, New Delhi',
    'Secure admission at a recognized Moldovan institution (e.g., USMF Chișinău for medical programs)\nGather any inter-institutional exchange agreement copy and proof of accommodation/maintenance\nObtain parental/guardian consent if a minor\nBook an appointment directly with the Embassy of Moldova, New Delhi (not VFS)\nSubmit documents in person and pay the consular fee\nCollect the D/ST visa, travel, and register for a residence permit in Moldova',
    '/assets/images/visa-heroes/moldova.webp',
    'Cross-checked against MBBS-in-Moldova admission-consultancy secondary sourcing and general Type D visa guidance; official evisa.gov.md/india.mfa.gov.md pages blocked this session — NMC recognition needs direct verification', 'https://india.mfa.gov.md/en/content/long-stay-visa-requirements-and-supporting-documents-type-d', '2026-09-17'
);
SET @mda3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mda3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda3, 'Core Documents', 'Required from every applicant.', 1);
SET @mda3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mda3s1, 'Admission/Enrollment Letter from Moldovan Institution', NULL, 'original', 1, 0, 1, 2),
(@mda3s1, 'Proof of Accommodation and Maintenance Commitment', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @mda3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@mda3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@mda3s2, 'Travel Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 0, 3),
(@mda3s2, 'Parental/Guardian Consent', 'Required if the applicant is a minor.', 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(133, 3, 80.00, 'EUR', 'Type D Long-Stay Visa Consular Fee (Approximate)', 'Reported at roughly €80 for Type D applications generally, alongside a mandatory minimum €30,000 medical insurance requirement — confirm the exact figure with the Embassy of Moldova, New Delhi before applying.', '2026-09-01', NOW(), 'https://india.mfa.gov.md/en/content/long-stay-visa-requirements-and-supporting-documents-type-d', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Moldova a recognized destination for MBBS study by Indian students?', 'Yes — Moldova, particularly Nicolae Testemițanu State University of Medicine and Pharmacy (USMF) in Chișinău, is a long-established budget MBBS destination for Indian students, reported as NMC-eligible and WHO-listed with English-medium teaching. Verify current NMC recognition status directly with the university and NMC before enrolling, as this can change.', 133, 3, 13303, 1),
('Can I apply for a Moldova student visa through VFS Global or online?', 'No — unlike the short-stay Tourist/Business e-Visa, the long-stay Type D student visa must be submitted in person directly at the Embassy of the Republic of Moldova, New Delhi.', 133, 3, 13304, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Type D/AM Long-Stay Visa + Work Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    133, 4, 'MDA-WORK-IN-04', '2026.09', 'published',
    'Employment with a Moldovan employer under the Type D work visa (D/AM), paired with a Ministry of Labour work permit.',
    'Indian nationals with a confirmed job offer from a Moldova-registered employer. The employer generally must first attempt to fill the role with a Moldovan/EU national and hold a registered legal entity before the Ministry of Labour, Social Protection and Family issues the work permit; the applicant then applies for the D/AM visa at the Embassy.',
    'D/AM visa valid up to 12 months, renewable via a work-based residence permit',
    'Employer-driven; applicant applies in person for the D/AM visa at the Embassy of the Republic of Moldova, New Delhi — not via e-Visa or VFS',
    1,
    'Work permit issuance is reported to take roughly 2-4 weeks once the employer''s application is complete; the subsequent D/AM visa adds further processing time.',
    'Embassy of the Republic of Moldova, New Delhi (visa); Ministry of Labour, Social Protection and Family, Chișinău (work permit)',
    'Secure a job offer from a Moldova-registered employer\nEmployer applies to the Ministry of Labour, Social Protection and Family for the work permit (labour-market check unless exempt)\nOnce the permit is granted, apply for the D/AM visa in person at the Embassy of Moldova, New Delhi\nAttend the consular appointment with supporting documents\nCollect the D/AM visa, travel, and register for a residence permit in Moldova',
    '/assets/images/visa-heroes/moldova.webp',
    'Cross-checked against Moldova work-permit secondary sourcing (employer-of-record and immigration-guide sites); official evisa.gov.md and india.mfa.gov.md pages could not be directly fetched this session', 'https://india.mfa.gov.md/en/content/long-stay-visa-requirements-and-supporting-documents-type-d', '2026-09-17'
);
SET @mda4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mda4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda4, 'Core Documents', 'Required from every applicant.', 1);
SET @mda4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mda4s1, 'Employment Contract/Job Offer Letter', NULL, 'copy', 1, 0, 1, 2),
(@mda4s1, 'Work Permit Approval from Ministry of Labour, Social Protection and Family', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @mda4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@mda4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@mda4s2, 'Travel Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 0, 3),
(@mda4s2, 'Proof of Accommodation in Moldova', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(133, 4, 80.00, 'EUR', 'Type D Work Visa Consular Fee (Approximate)', 'Reported at roughly €80 for the D/AM visa itself; the separate Ministry of Labour work-permit fee (paid by the employer) was not independently confirmed this session.', '2026-09-01', NOW(), 'https://india.mfa.gov.md/en/content/long-stay-visa-requirements-and-supporting-documents-type-d', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there an alternative to a full work visa for remote workers?', 'A Moldova Digital Nomad Visa was reportedly launched in September 2025 (around two years, renewable) for people working remotely for employers outside Moldova — this appears to be a separate route from the employer-sponsored D/AM work visa. This was sourced from a single secondary reference this session and was NOT independently confirmed; verify directly with the Embassy of Moldova before relying on it.', 133, 4, 13305, 1),
('Does the employer need to prove no Moldovan could fill the role?', 'Reported guidance says yes — employers are generally expected to first attempt to fill the position with a Moldovan or EU national before the Ministry of Labour, Social Protection and Family issues a work permit for a non-EU hire such as an Indian applicant, unless the role is otherwise exempt.', 133, 4, 13306, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Type C Short-Stay e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    133, 5, 'MDA-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or close friends resident in Moldova.',
    'Indian nationals visiting family or friends use the same Type C short-stay e-Visa as Tourist, with an invitation letter proving the relationship and the host''s legal status in Moldova. The same Schengen/US/UK visa exemption applies for holders of those documents.',
    'Up to 90 days within any 180-day period (Type C e-Visa)',
    'Self-service online via evisa.gov.md with a relationship-based invitation letter; VFS Global centres also accept applications',
    0,
    'Reported at around 10 working days for a complete e-Visa application; some secondary sources cite up to 15-20 working days.',
    'Embassy of the Republic of Moldova, New Delhi (policy authority); e-Visa self-service or VFS Global centres in New Delhi, Jalandhar, Mumbai, Kolkata, Chennai, and Kochi',
    'Obtain an invitation letter from your host in Moldova, including their ID/residence details\nGather documents proving the family or personal relationship\nApply online at evisa.gov.md or via VFS Global\nPay the e-Visa fee online\nReceive the approved e-Visa as a PDF by email',
    '/assets/images/visa-heroes/moldova.webp',
    'Cross-checked against Moldova''s General Inspectorate for Migration invitation-letter guidance and VFS Global secondary sourcing; official evisa.gov.md and india.mfa.gov.md pages could not be directly fetched this session', 'https://www.evisa.gov.md/', '2026-09-17'
);
SET @mda5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mda5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda5, 'Core Documents', 'Required from every applicant.', 1);
SET @mda5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mda5s1, 'Invitation Letter from Host in Moldova', NULL, 'original', 1, 0, 1, 2),
(@mda5s1, 'Proof of Relationship (Marriage/Birth Certificates or Equivalent)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda5, 'Supporting Documents', 'Evidence of your own means and your host''s status.', 2);
SET @mda5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda5s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@mda5s2, 'Travel Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 0, 2),
(@mda5s2, 'Host''s Moldovan ID/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(133, 5, 40.00, 'EUR', 'Type C e-Visa Fee (Approximate)', 'Same fee structure as Tourist; reported at roughly €40, some sources cite a higher $80 equivalent — confirm the exact amount on evisa.gov.md before paying.', '2026-09-01', NOW(), 'https://www.evisa.gov.md/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What proves my relationship to my host in Moldova?', 'Reported requirements include marriage or birth certificates, or other documents establishing the family or personal tie, alongside the host''s own identification and residence status in Moldova — confirm the exact accepted document list with the Embassy or evisa.gov.md before applying.', 133, 5, 13307, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Type B (Online) / Type A (Embassy)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    133, 6, 'MDA-TRAN-IN-06', '2026.09', 'published',
    'Passing through Moldova (Chișinău Airport or overland) en route to a third country.',
    'Moldova has no direct flights from India, so transit typically routes through hubs such as Istanbul, Dubai, or European cities. A Moldovan Type B transit visa (available online) or Type A airport transit visa (embassy-only) is needed only if leaving the international transit zone; onward Schengen connections may separately require a Schengen Airport Transit Visa.',
    'Transit window only; the visa itself may be issued for up to 6 months, 1-2 entries',
    'Type B online via evisa.gov.md if required; Type A airport transit only via the Embassy of Moldova, New Delhi',
    0,
    'Confirm first whether your specific connection needs a Moldovan transit visa at all — purely airside transfers without leaving the international zone typically do not require one.',
    'Embassy of the Republic of Moldova, New Delhi (Type A only); e-Visa self-service for Type B via evisa.gov.md',
    'Confirm whether your itinerary requires leaving the international transit zone in Moldova\nIf a Type B transit visa is needed, apply online at evisa.gov.md with your onward ticket\nIf a Type A airport transit visa is needed, apply in person at the Embassy of Moldova, New Delhi\nCheck separately whether any Schengen hub leg needs its own Schengen Airport Transit Visa\nCarry onward tickets and any required third-country visas',
    '/assets/images/visa-heroes/moldova.webp',
    'Cross-checked against Moldova transit-visa secondary sourcing and routing analysis given the lack of direct India-Moldova flights; official evisa.gov.md/india.mfa.gov.md pages blocked this session', 'https://www.evisa.gov.md/', '2026-09-17'
);
SET @mda6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mda6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda6, 'Core Documents', 'Required if a transit visa is genuinely needed.', 1);
SET @mda6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mda6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2),
(@mda6s1, 'Visa/Approval for Final Destination Country', 'Only if your destination requires one.', 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @mda6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda6s2, 'Approval to Enter Transit Hub Country (e.g. Schengen Airport Transit Visa)', 'If your routing changes terminals or requires baggage re-check in a Schengen hub.', 'copy', 0, 1, 0, 1),
(@mda6s2, 'Recent Passport Photograph', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(133, 6, 30.00, 'EUR', 'Type B Transit Visa Fee (Approximate)', 'Reported at roughly €30 for the Type B transit visa; the Type A airport transit visa fee was not independently confirmed this session — contact the Embassy of Moldova, New Delhi to verify.', '2026-09-01', NOW(), 'https://www.evisa.gov.md/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a Moldovan visa just to change planes in Chișinău?', 'Generally no — a purely airside transfer that does not require leaving the international transit zone typically does not need a separate Moldovan transit visa; a visa is needed only if you must pass through passport control.', 133, 6, 13308, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Type C (Short-Stay) / Type D (Longer)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    133, 7, 'MDA-MED-IN-07', '2026.09', 'published',
    'Travel to Moldova for medical treatment or consultation.',
    'Indian nationals travelling for treatment generally use the Type C short-stay e-Visa (same as Tourist) for visits under 90 days, with a certificate from the treating institution; longer or repeat treatment courses may require the Type D long-stay route via the Embassy instead.',
    'Up to 90 days within any 180-day period on the Type C e-Visa; longer treatment needs the Type D route',
    'Self-service online via evisa.gov.md for short-stay treatment; Embassy of Moldova, New Delhi in person for longer Type D treatment stays',
    0,
    'Reported at around 10 working days for a complete short-stay e-Visa application; the Type D route for longer treatment takes materially longer.',
    'Embassy of the Republic of Moldova, New Delhi (policy authority and Type D route); e-Visa self-service via evisa.gov.md for short-stay treatment',
    'Obtain a certificate/invitation from the treating Moldovan doctor or institution\nArrange travel medical insurance covering at least €30,000\nApply online at evisa.gov.md for stays under 90 days, or at the Embassy of Moldova, New Delhi for longer treatment\nPay the e-Visa/consular fee\nReceive the approved visa and travel with your medical records',
    '/assets/images/visa-heroes/moldova.webp',
    'Cross-checked against Moldova e-Visa secondary sourcing and general Type C/D visa-purpose guidance; official evisa.gov.md and india.mfa.gov.md pages could not be directly fetched this session', 'https://www.evisa.gov.md/', '2026-09-17'
);
SET @mda7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mda7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda7, 'Core Documents', 'Required from every applicant.', 1);
SET @mda7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mda7s1, 'Medical Certificate/Institution Invitation', NULL, 'original', 1, 0, 1, 2),
(@mda7s1, 'Travel Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @mda7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda7s2, 'Medical Records/Referral from India', NULL, 'copy', 1, 0, 0, 1),
(@mda7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2),
(@mda7s2, 'Attendant''s Own Visa Documents', 'If travelling with an accompanying family member/companion.', 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(133, 7, 40.00, 'EUR', 'Type C e-Visa Fee (Approximate)', 'Reported at roughly €40 for the short-stay route; a longer Type D treatment stay would instead carry the ~€80 Type D consular fee — confirm the applicable figure with the Embassy or evisa.gov.md.', '2026-09-01', NOW(), 'https://www.evisa.gov.md/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can a family member accompany me on a Moldova Medical visa?', 'An accompanying attendant would generally need their own qualifying visa (e.g., a Family Visit or Tourist e-Visa) rather than being automatically covered under the patient''s Medical visa — confirm the accepted approach with the Embassy of Moldova or evisa.gov.md before applying.', 133, 7, 13309, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Type C Short-Stay e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    133, 8, 'MDA-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, training, and cultural events in Moldova.',
    'Indian nationals attending a conference use the same Type C short-stay e-Visa as Tourist/Business. Per Moldova''s General Inspectorate for Migration guidance, the invitation must state the event''s name, place, and time, submitted in original and copy.',
    'Up to 90 days within any 180-day period (Type C e-Visa)',
    'Self-service online via evisa.gov.md with the event invitation letter; VFS Global centres also accept applications',
    0,
    'Reported at around 10 working days for a complete e-Visa application.',
    'Embassy of the Republic of Moldova, New Delhi (policy authority); e-Visa self-service or VFS Global centres in New Delhi, Jalandhar, Mumbai, Kolkata, Chennai, and Kochi',
    'Obtain a conference/event invitation stating name, place, and time (original and copy)\nGather proof of accommodation and return travel\nApply online at evisa.gov.md or via VFS Global\nPay the e-Visa fee online\nReceive the approved e-Visa as a PDF by email',
    '/assets/images/visa-heroes/moldova.webp',
    'Cross-checked against Moldova''s General Inspectorate for Migration (igm.gov.md) invitation-letter guidance; official evisa.gov.md and india.mfa.gov.md pages could not be directly fetched this session', 'https://www.evisa.gov.md/', '2026-09-17'
);
SET @mda8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mda8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda8, 'Core Documents', 'Required from every applicant.', 1);
SET @mda8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mda8s1, 'Conference/Event Invitation Letter (Name, Place, Time)', NULL, 'both', 1, 0, 1, 2),
(@mda8s1, 'Registration Confirmation', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda8, 'Supporting Documents', 'Additional employer-side and financial evidence.', 2);
SET @mda8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda8s2, 'Forwarding Letter from Employer', 'If travelling on employer sponsorship.', 'copy', 0, 1, 0, 1),
(@mda8s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(133, 8, 40.00, 'EUR', 'Type C e-Visa Fee (Approximate)', 'Same fee structure as Tourist; reported at roughly €40 — confirm the exact amount on evisa.gov.md before paying.', '2026-09-01', NOW(), 'https://www.evisa.gov.md/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What must a Moldova conference invitation letter show?', 'Per Moldova''s General Inspectorate for Migration guidance, it should state the event''s name, place, and time, and be presented in both original and copy form alongside your application.', 133, 8, 13310, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Type C Short-Stay e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    133, 9, 'MDA-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Moldova.',
    'Indian nationals competing or officiating use the same Type C short-stay e-Visa as Conference/Business, requiring an event invitation stating name, place, and time, generally alongside confirmation from the home-country sports association.',
    'Up to 90 days within any 180-day period (Type C e-Visa)',
    'Self-service online via evisa.gov.md with the event/federation invitation; VFS Global centres also accept applications',
    0,
    'Reported at around 10 working days for a complete e-Visa application.',
    'Embassy of the Republic of Moldova, New Delhi (policy authority); e-Visa self-service or VFS Global centres in New Delhi, Jalandhar, Mumbai, Kolkata, Chennai, and Kochi',
    'Obtain an invitation from the host event organizer/federation stating name, place, and time (original and copy)\nGather confirmation of your role from your home-country sports association\nApply online at evisa.gov.md or via VFS Global\nPay the e-Visa fee online\nReceive the approved e-Visa as a PDF by email',
    '/assets/images/visa-heroes/moldova.webp',
    'Cross-checked against Moldova''s General Inspectorate for Migration (igm.gov.md) invitation-letter guidance; official evisa.gov.md and india.mfa.gov.md pages could not be directly fetched this session', 'https://www.evisa.gov.md/', '2026-09-17'
);
SET @mda9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mda9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda9, 'Core Documents', 'Required from every applicant.', 1);
SET @mda9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mda9s1, 'Host Event/Federation Invitation Letter (Name, Place, Time)', NULL, 'both', 1, 0, 1, 2),
(@mda9s1, 'Home-Country Sports Association Confirmation', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @mda9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda9s2, 'Team/Delegation List', 'If travelling as part of a group.', 'copy', 0, 1, 0, 1),
(@mda9s2, 'Travel Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(133, 9, 40.00, 'EUR', 'Type C e-Visa Fee (Approximate)', 'Same fee structure as Tourist/Conference; reported at roughly €40 — confirm the exact amount on evisa.gov.md before paying.', '2026-09-01', NOW(), 'https://www.evisa.gov.md/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Sports visa process different from the Conference visa?', 'Not substantially — both are processed under the same Type C short-stay e-Visa category, differing mainly in the type of invitation letter (event/federation invitation vs. conference/registration confirmation) and any additional delegation documents you provide.', 133, 9, 13311, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Type D/VF Family Reunification
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    133, 10, 'MDA-DEP-IN-10', '2026.09', 'published',
    'Spouse, minor children, or other qualifying family members joining an Indian work-permit, student, or residence-permit holder in Moldova.',
    'Family members of an Indian national holding a qualifying Moldovan work permit, student visa, or residence permit apply for the Type D family reunification visa (D/VF). Eligible family generally includes spouse, minor children, and persons under tutorship/guardianship; the sponsor must show sufficient funds and accommodation in Moldova.',
    'D/VF visa tied to the sponsor''s permit validity, up to 12 months initially, renewable via residence permit',
    'In person at the Embassy of the Republic of Moldova, New Delhi — NOT available via evisa.gov.md or VFS Global',
    1,
    'Long-stay D/VF processing is reported to take longer than short-stay e-Visa applications; apostilled relationship documents and certified Romanian translations add lead time.',
    'Embassy of the Republic of Moldova, New Delhi',
    'Confirm the sponsor holds a qualifying Moldovan work permit, student visa, or residence permit\nGather apostilled marriage/birth certificates with certified Romanian translation proving the relationship\nGather the sponsor''s proof of funds and accommodation in Moldova\nBook an appointment directly with the Embassy of Moldova, New Delhi (not VFS)\nSubmit documents in person and pay the consular fee\nCollect the D/VF visa, travel, and register for a residence permit in Moldova',
    '/assets/images/visa-heroes/moldova.webp',
    'Cross-checked against Moldova residence-permit and family-reunification secondary sourcing (incl. Moldova''s General Inspectorate for Migration); official evisa.gov.md/india.mfa.gov.md pages blocked this session', 'https://india.mfa.gov.md/en/content/long-stay-visa-requirements-and-supporting-documents-type-d', '2026-09-17'
);
SET @mda10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mda10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda10, 'Core Documents', 'Required from every applicant.', 1);
SET @mda10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mda10s1, 'Proof of Relationship to Sponsor (Apostilled + Certified Romanian Translation)', NULL, 'original', 1, 0, 1, 2),
(@mda10s1, 'Sponsor''s Work/Student Permit or Residence Permit Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mda10, 'Supporting Documents', 'Evidence tied to the sponsor''s means and status.', 2);
SET @mda10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mda10s2, 'Proof of Sponsor''s Funds and Accommodation', NULL, 'copy', 1, 0, 0, 1),
(@mda10s2, 'Travel Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 0, 2),
(@mda10s2, 'Sponsor''s Passport Copy', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(133, 10, 80.00, 'EUR', 'Type D Family Reunification Visa Consular Fee (Approximate)', 'Reported at roughly €80, in line with other Type D long-stay categories — confirm the exact figure with the Embassy of Moldova, New Delhi before applying.', '2026-09-01', NOW(), 'https://india.mfa.gov.md/en/content/long-stay-visa-requirements-and-supporting-documents-type-d', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Which family members qualify for Moldova''s family reunification visa?', 'Reported eligible categories include the sponsor''s spouse, minor children, and persons under tutorship/guardianship, plus parents in some cases — the exact list and required documentary proof should be confirmed directly with the Embassy of Moldova, New Delhi.', 133, 10, 13312, 1),
('Do relationship documents need special certification?', 'Yes — reported guidance says marriage and birth certificates generally need to be apostilled in India and translated into Romanian by a certified translator before submission.', 133, 10, 13313, 1);
