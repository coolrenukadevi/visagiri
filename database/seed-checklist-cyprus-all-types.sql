-- Cyprus Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search (WebSearch tool was available and
-- used; no direct WebFetch of gov.cy/VFS pages was performed — findings
-- are triangulated from search-result snippets of gov.cy, VFS Global's
-- Cyprus/India one-pager, the High Commission of the Republic of Cyprus
-- in New Delhi's own site, and secondary visa-agency/law-firm sourcing).
-- hero_image_url left NULL at authoring time (no photo bundle supplied).
--
-- IMPORTANT SOURCING CAVEAT: fee, processing-time and centre-count
-- figures come largely from visa-agency aggregator sites rather than a
-- directly-fetched primary gov.cy page, so treat exact numbers as
-- approximate and reconfirm before publishing to end users. The
-- Category D (long-stay) visa fee itself (Student/Work/Dependent) was
-- NOT independently confirmed this session — only the downstream Pink
-- Slip/Temporary Residence Permit fee (~€70, reported for 2026) was
-- found; flagged accordingly in those visa_fees rows.
--
-- Cyprus's real, distinctive, verified facts:
--   - Cyprus is an EU member state but is NOT part of the Schengen
--     Area (confirmed via multiple 2026-dated sources) — it issues its
--     own national visa: Category C (short-stay, up to 90/180 days,
--     covering Tourist/Business/Family Visit/Medical/Conference/Sports)
--     and Category D (long-stay, over 90 days, covering Student/Work/
--     Family Reunification). A Cyprus visa is NOT valid for onward
--     travel to Schengen countries — this is the single most common
--     point of confusion and is called out in every category below.
--   - The relationship runs one way: since a 2014 policy, Cyprus
--     unilaterally recognises a valid double/multiple-entry Schengen
--     C-type visa (or a Schengen state's national visa/residence
--     permit) as sufficient for entry to Cyprus for up to 90 days —
--     but holding a Cyprus visa does not grant the reverse (entry to
--     Schengen states).
--   - Cyprus is actively pursuing full Schengen accession, targeting
--     2026: government sources report "technical readiness" achieved
--     by end of 2025, and an EU evaluation report backed Cyprus's
--     accession in May 2026 (Cyprus Mail, dated reporting). As of this
--     review (September 2026) accession has NOT yet happened — it
--     still requires a unanimous EU Council vote and no confirmed
--     date exists. This is a live, dated, genuinely notable fact for
--     Indian travellers to watch, not yet a completed change.
--   - VFS Global operates Cyprus Visa Application Centres across India,
--     recently expanded to 16 Indian cities (including newly added
--     Thiruvananthapuram, Goa, Gurugram and Jaipur), and offers
--     walk-in submission (no prior appointment needed) for Category C
--     applications — a genuine access improvement for Indian
--     applicants relative to many Schengen-member VACs.
--   - The decision authority is the High Commission of the Republic of
--     Cyprus, New Delhi (Commonwealth-style "High Commission" naming,
--     reflecting both countries' Commonwealth membership), which is
--     also accredited in parallel to Bangladesh, Malaysia, Myanmar,
--     Maldives, Nepal, Sri Lanka, Thailand and Vietnam.
--   - Cyprus has a genuinely growing Indian student population —
--     secondary reporting citing Ministry of External Affairs data
--     puts it at over 1,961 Indian students, drawn mainly to private
--     universities such as the University of Nicosia and European
--     University Cyprus, which run India-specific recruitment/
--     scholarship outreach. (Note: this is distinct from — and not to
--     be confused with — study destinations in the unrecognised
--     Turkish Republic of Northern Cyprus, which is outside the scope
--     of this Republic-of-Cyprus checklist.)
--   - The student route uses a distinctive two-stage document system:
--     an Entry Permit ("Blue Slip") obtained before travel, converted
--     within 7 days of arrival into a Temporary Residence Permit
--     ("Pink Slip") at the Civil Registry and Migration Department.
--   - Work permits use a combined "single permit" (residence + work in
--     one document), employer-sponsored and subject to a Labour Market
--     Test, valid up to 4 years, with long-term residency eligibility
--     after 5 years of continuous legal residence.
--   - Family Reunification (Dependent) applicants must obtain an FR
--     entry visa abroad before travelling — unlike some countries, a
--     dependant cannot arrive on a tourist visa and convert in-country.
--
-- country_id 64 = Cyprus. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Category C Short-Stay (Cyprus-Only)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    64, 1, 'CYP-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to the Republic of Cyprus.',
    'Indian passport holders — Cyprus''s own national Category C short-stay visa. Cyprus is an EU member but NOT part of the Schengen Area, so this visa authorises entry to Cyprus only and is not valid for travel to Schengen countries.',
    'Single or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global (16 Indian cities); Category C applications can be submitted as a walk-in without a prior appointment',
    1,
    'Standard processing is reported at around 10-15 working days',
    'High Commission of the Republic of Cyprus, New Delhi (decision authority), via VFS Global centres in India',
    'Book a VFS Global appointment or use the walk-in Category C window\nComplete the Cyprus visa application form\nGather supporting documents and travel insurance\nSubmit documents and biometrics (mandatory for first-time applicants)\nTrack status and collect your passport',
    '/assets/images/visa-heroes/cyprus.webp',
    'Cross-checked against VFS Global Cyprus (India) and High Commission of the Republic of Cyprus, New Delhi secondary sourcing, triangulated via web search snippets rather than a directly-fetched primary page this session', 'https://www.gov.cy/mfa-highcomnewdelhi/en/', '2026-09-17'
);
SET @cyp1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cyp1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp1, 'Core Documents', 'Required from every applicant.', 1);
SET @cyp1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp1s1, 'Valid Passport (3+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@cyp1s1, 'Completed Cyprus Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@cyp1s1, 'Travel Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @cyp1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp1s2, 'Confirmed Hotel Booking', NULL, 'copy', 1, 0, 0, 1),
(@cyp1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@cyp1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(64, 1, 90.00, 'EUR', 'Category C Short-Stay Visa Fee', 'Children aged 6-12 reportedly pay a reduced €45 fee; children under 6 are exempt. A separate VFS Global service charge also applies; figures are approximate pending direct confirmation.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/ind/en/cyp/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a Cyprus Tourist visa let me travel to other Schengen countries?', 'No — Cyprus is an EU member but is not part of the Schengen Area. Its Category C visa authorises entry to Cyprus only and does not grant Schengen travel rights.', 64, 1, 6400, 1),
('Will a Cyprus visa work differently once Cyprus joins Schengen?', 'Cyprus is targeting Schengen accession, with technical readiness reported by end of 2025 and EU backing reported in May 2026, but as of this review it has not yet acceded — no confirmed accession date exists, and it still requires a unanimous EU Council vote. Until then, apply for Cyprus''s own national visa.', 64, 1, 6401, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Category C Short-Stay
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    64, 2, 'CYP-BUS-IN-02', '2026.09', 'published',
    'Trade, negotiations, and commercial meetings in the Republic of Cyprus.',
    'Indian nationals travelling for business — the same Category C national visa as Tourist, with a company invitation letter as the differentiating document. Not valid for onward Schengen travel, as Cyprus is not a Schengen member.',
    'Single, double, or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global with a business invitation letter and Indian employer sponsorship letter',
    1,
    'Standard processing is reported at around 10-15 working days',
    'High Commission of the Republic of Cyprus, New Delhi, via VFS Global centres in India',
    'Obtain an invitation letter from the Cyprus host company\nGather Indian employer sponsorship/forwarding letter\nComplete the Cyprus visa application form\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/cyprus.webp',
    'Cross-checked against VFS Global Cyprus (India) secondary sourcing, triangulated via web search snippets rather than a directly-fetched primary page this session', 'https://visa.vfsglobal.com/ind/en/cyp/', '2026-09-17'
);
SET @cyp2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cyp2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp2, 'Core Documents', 'Required from every applicant.', 1);
SET @cyp2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@cyp2s1, 'Invitation Letter from Cyprus Host Company', NULL, 'original', 1, 0, 1, 2),
(@cyp2s1, 'Travel Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @cyp2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@cyp2s2, 'Business Registration Proof', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(64, 2, 90.00, 'EUR', 'Category C Short-Stay Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/ind/en/cyp/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use a Schengen business visa to enter Cyprus instead?', 'Sometimes — since 2014, Cyprus unilaterally recognises a valid double/multiple-entry Schengen C-type visa for entry up to 90 days. This works one way only: a Cyprus visa does not grant entry to Schengen states.', 64, 2, 6402, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Category D + Entry/Temporary Residence Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    64, 3, 'CYP-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Cyprus university or registered institution.',
    'Indian nationals admitted to a recognised Cyprus institution. Cyprus has a genuinely growing Indian student population (reported over 1,961, per secondary MEA-sourced reporting), with private universities such as University of Nicosia and European University Cyprus running India-specific outreach.',
    'Entry Permit valid for travel; Temporary Residence Permit ("Pink Slip") issued for 1 year, renewable annually for programme duration',
    'Entry Permit ("Blue Slip") arranged before travel; Temporary Residence Permit applied for in person in Cyprus within 7 days of arrival',
    1,
    'Entry Permit processing timelines vary by institution; the in-Cyprus Temporary Residence Permit step is a separate, additional process after arrival',
    'High Commission of the Republic of Cyprus, New Delhi (Entry Permit/visa); Civil Registry and Migration Department, Cyprus (Temporary Residence Permit)',
    'Secure admission at a recognised Cyprus institution\nApply for the Entry Permit ("Blue Slip") before travel\nGather proof of funds and health insurance\nTravel to Cyprus and, within 7 days, apply in person for the Temporary Residence Permit ("Pink Slip") at the Civil Registry and Migration Department\nRenew the Pink Slip annually for the programme duration',
    '/assets/images/visa-heroes/cyprus.webp',
    'Cross-checked against Cyprus study-visa secondary sourcing (Entry Permit/Pink Slip process) and India-outreach reporting, triangulated via web search snippets, not a directly-fetched primary page', 'https://www.gov.cy/mfa-highcomnewdelhi/en/', '2026-09-17'
);
SET @cyp3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cyp3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp3, 'Core Documents', 'Required from every applicant.', 1);
SET @cyp3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@cyp3s1, 'Admission Letter from Cyprus Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @cyp3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@cyp3s2, 'Bank Statement Showing Sufficient Funds (Reported ~€7,000+)', NULL, 'copy', 1, 0, 0, 2),
(@cyp3s2, 'Health Insurance Valid in Cyprus', NULL, 'original', 1, 0, 0, 3),
(@cyp3s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 4),
(@cyp3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 5);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(64, 3, NULL, 'EUR', 'Confirmed After Assessment', 'The Category D/Entry Permit visa fee was NOT independently confirmed this session. The downstream Temporary Residence Permit ("Pink Slip") is separately reported at around €70 for 2026 — treat both figures as approximate and confirm before applying.', '2026-09-01', NOW(), 'https://www.gov.cy/mfa-highcomnewdelhi/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Cyprus student visa a single document?', 'No — it is a two-stage process. You first obtain an Entry Permit ("Blue Slip") before travelling, then within 7 days of arrival apply in person in Cyprus for a Temporary Residence Permit ("Pink Slip"), which is renewed annually for the programme duration.', 64, 3, 6403, 1),
('How many Indian students study in Cyprus?', 'Secondary reporting citing Ministry of External Affairs data puts the figure at over 1,961 Indian students, with private universities such as University of Nicosia and European University Cyprus running India-specific recruitment and scholarship outreach.', 64, 3, 6404, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Category D Single Permit (Residence + Work)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    64, 4, 'CYP-WORK-IN-04', '2026.09', 'published',
    'Employment with a Cyprus employer via the combined "single permit" (residence and work permit in one document).',
    'Indian nationals with a confirmed job offer; employment is employer-sponsored and generally subject to a Labour Market Test confirming the role cannot be filled locally, administered by the Department of Labour.',
    'Single permit valid up to 4 years; long-term residency reportedly possible after 5 years of continuous legal residence',
    'Employer-driven; applicant applies for the Category D visa/Entry Permit at the High Commission of the Republic of Cyprus, New Delhi',
    1,
    'Timelines vary with employer/Department of Labour processing; not directly comparable to the faster Category C short-stay timeline',
    'High Commission of the Republic of Cyprus, New Delhi (visa); Department of Labour and Civil Registry and Migration Department, Cyprus (permit)',
    'Secure a job offer from a Cyprus employer\nEmployer completes Labour Market Test/Department of Labour registration\nApply for the Category D visa/Entry Permit at the High Commission\nTravel to Cyprus and complete single-permit/residence registration\nRenew as required within the permit''s validity',
    '/assets/images/visa-heroes/cyprus.webp',
    'Cross-checked against Cyprus single-permit/work-visa secondary sourcing, triangulated via web search snippets rather than a directly-fetched primary Department of Labour page this session', 'https://www.gov.cy/mfa-highcomnewdelhi/en/', '2026-09-17'
);
SET @cyp4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cyp4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp4, 'Core Documents', 'Required from every applicant.', 1);
SET @cyp4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@cyp4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@cyp4s1, 'Labour Market Test/Department of Labour Confirmation', 'Confirms the role could not be filled by a local or EU candidate.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @cyp4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@cyp4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@cyp4s2, 'Health Insurance', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(64, 4, NULL, 'EUR', 'Confirmed After Assessment', 'Single-permit and Category D visa fees vary by permit category and employer and were not independently confirmed this session — contact the High Commission or Department of Labour to confirm.', '2026-09-01', NOW(), 'https://www.gov.cy/mfa-highcomnewdelhi/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is Cyprus''s "single permit" for work?', 'It is a combined residence-and-work permit issued in one document, rather than two separate permits. It is employer-sponsored and generally requires a Labour Market Test confirming the role could not be filled locally.', 64, 4, 6405, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Category C Short-Stay
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    64, 5, 'CYP-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in the Republic of Cyprus.',
    'Indian nationals with family/friends in Cyprus — the same Category C national visa as Tourist, requiring an invitation letter from the host plus proof of the relationship. Not valid for onward Schengen travel.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with an invitation letter and relationship proof',
    1,
    'Standard processing is reported at around 10-15 working days',
    'High Commission of the Republic of Cyprus, New Delhi, via VFS Global centres in India',
    'Obtain an invitation letter from your host in Cyprus\nGather documents proving the family relationship\nComplete the Cyprus visa application form\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/cyprus.webp',
    'Cross-checked against VFS Global Cyprus (India) secondary sourcing, triangulated via web search snippets rather than a directly-fetched primary page this session', 'https://visa.vfsglobal.com/ind/en/cyp/', '2026-09-17'
);
SET @cyp5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cyp5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp5, 'Core Documents', 'Required from every applicant.', 1);
SET @cyp5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@cyp5s1, 'Invitation Letter from Host in Cyprus', NULL, 'original', 1, 0, 1, 2),
(@cyp5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @cyp5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@cyp5s2, 'Travel Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(64, 5, 90.00, 'EUR', 'Category C Short-Stay Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/ind/en/cyp/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Family Visit visa different from the Dependent/Family Reunification route?', 'Yes — Family Visit is a short-stay Category C visa for visiting relatives, capped at 90 days. The Dependent category is a separate long-stay Category D route for a spouse or child joining a Cyprus-based sponsor permanently.', 64, 5, 6406, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Category A Airport Transit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    64, 6, 'CYP-TRAN-IN-06', '2026.09', 'published',
    'Passing through a Cyprus airport (Larnaca or Paphos) airside-to-airside toward another destination.',
    'A distinct Category A Airport Transit Visa, separate from the Category C short-stay visa — only needed if leaving the international transit area; not required for a purely airside connection.',
    'Valid for the transit window only',
    'Apply via VFS Global with your itinerary/onward ticket, if a transit visa is genuinely required for your connection',
    1,
    'Processing timelines were not independently confirmed this session; apply with the same lead time as a Category C visa to be safe',
    'High Commission of the Republic of Cyprus, New Delhi, via VFS Global centres in India',
    'Confirm whether your specific connection requires a Category A visa (only if leaving the international transit area)\nIf required, apply via VFS Global with onward ticket and itinerary\nSubmit biometrics if required',
    '/assets/images/visa-heroes/cyprus.webp',
    'Cross-checked against Cyprus airport-transit-visa secondary sourcing, triangulated via web search snippets rather than a directly-fetched primary page this session — fee figure flagged as needing verification', 'https://www.gov.cy/en/information/visas/', '2026-09-17'
);
SET @cyp6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cyp6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp6, 'Core Documents', 'Required if a Category A visa is genuinely needed.', 1);
SET @cyp6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@cyp6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @cyp6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(64, 6, NULL, 'EUR', 'Confirmed After Assessment', 'Reported in the roughly €20-30 range, lower than the standard Category C fee — treat as approximate and confirm with VFS Global/the High Commission before applying.', '2026-09-01', NOW(), 'https://www.gov.cy/en/information/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a Category A transit visa let me leave the airport?', 'No — a Category A visa only authorises remaining within the international transit area; it does not permit passing through Cyprus passport control or entering the country.', 64, 6, 6407, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Category C Short-Stay
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    64, 7, 'CYP-MED-IN-07', '2026.09', 'published',
    'Travel to the Republic of Cyprus for medical treatment.',
    'Indian nationals travelling for treatment — the same Category C national visa as Tourist, requiring a hospital confirmation/appointment letter and a treatment plan from the treating Cyprus facility.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with the medical documentation and required insurance',
    1,
    'Standard processing is reported at around 10-15 working days, can extend if documentation is incomplete',
    'High Commission of the Republic of Cyprus, New Delhi, via VFS Global centres in India',
    'Obtain a detailed medical report from a recognised hospital in India\nSecure a confirmation/appointment letter and treatment plan from the Cyprus hospital\nArrange travel insurance (min. €30,000 cover)\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/cyprus.webp',
    'Cross-checked against Cyprus medical-visa secondary sourcing, triangulated via web search snippets rather than a directly-fetched primary page this session', 'https://visa.vfsglobal.com/ind/en/cyp/', '2026-09-17'
);
SET @cyp7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cyp7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp7, 'Core Documents', 'Required from every applicant.', 1);
SET @cyp7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@cyp7s1, 'Hospital Confirmation Letter and Treatment Plan (Cyprus)', NULL, 'original', 1, 0, 1, 2),
(@cyp7s1, 'Travel Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @cyp7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp7s2, 'Medical Report from Indian Hospital', NULL, 'copy', 1, 0, 0, 1),
(@cyp7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2),
(@cyp7s2, 'Cover Letter Explaining Treatment and Duration', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(64, 7, 90.00, 'EUR', 'Category C Short-Stay Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/ind/en/cyp/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Cyprus medical treatment visa processing different from Northern Cyprus?', 'Yes — this checklist covers the Republic of Cyprus (EU member, country_id 64) only. The unrecognised Turkish Republic of Northern Cyprus operates under a separate, different system not covered here.', 64, 7, 6408, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Category C Short-Stay
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    64, 8, 'CYP-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade fairs in the Republic of Cyprus.',
    'Indian nationals attending a conference — the same Category C national visa as Tourist/Business, with a conference invitation or registration confirmation as the differentiating document.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a conference invitation/registration confirmation',
    1,
    'Standard processing is reported at around 10-15 working days',
    'High Commission of the Republic of Cyprus, New Delhi, via VFS Global centres in India',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nComplete the Cyprus visa application form\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/cyprus.webp',
    'Cross-checked against VFS Global Cyprus (India) secondary sourcing, triangulated via web search snippets rather than a directly-fetched primary page this session', 'https://visa.vfsglobal.com/ind/en/cyp/', '2026-09-17'
);
SET @cyp8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cyp8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp8, 'Core Documents', 'Required from every applicant.', 1);
SET @cyp8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@cyp8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @cyp8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@cyp8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(64, 8, 90.00, 'EUR', 'Category C Short-Stay Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/ind/en/cyp/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I attend a conference in another EU country on this same visa?', 'No — a Cyprus Category C visa is valid for Cyprus only. Because Cyprus is not a Schengen member, you would need a separate visa for any other Schengen-area leg of your trip.', 64, 8, 6409, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Category C Short-Stay
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    64, 9, 'CYP-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in the Republic of Cyprus.',
    'Indian nationals competing or officiating — the same Category C national visa as Tourist/Conference, requiring an invitation/confirmation letter from the host event organiser confirming the sporting purpose.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a host-organiser invitation and event details',
    1,
    'Standard processing is reported at around 10-15 working days',
    'High Commission of the Republic of Cyprus, New Delhi, via VFS Global centres in India',
    'Obtain an invitation letter from the host event organiser with event details and expense arrangements\nGather any home-country sports association confirmation, if available\nComplete the Cyprus visa application form\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/cyprus.webp',
    'Cross-checked against VFS Global Cyprus (India) secondary sourcing; sport-specific documents are inferred from the general Category C event pattern, not independently confirmed line-by-line', 'https://visa.vfsglobal.com/ind/en/cyp/', '2026-09-17'
);
SET @cyp9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cyp9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp9, 'Core Documents', 'Required from every applicant.', 1);
SET @cyp9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@cyp9s1, 'Host Event Organiser Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @cyp9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp9s2, 'Home-Country Sports Association Letter', 'Confirms role and no-employment status, if applicable.', 'if_applicable', 0, 1, 0, 1),
(@cyp9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(64, 9, 90.00, 'EUR', 'Category C Short-Stay Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/ind/en/cyp/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports visa category for Cyprus?', 'Cyprus does not appear to operate a formally separate sports-visa sticker distinct from the general Category C short-stay visa — athletes and officials apply under Category C with an event-specific invitation letter, similar to the Conference/Business route.', 64, 9, 6410, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Category D Family Reunification
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    64, 10, 'CYP-DEP-IN-10', '2026.09', 'published',
    'Spouse or minor children joining an Indian national who holds a qualifying Cyprus residence/work permit.',
    'Family members of an Indian sponsor holding a valid Cyprus residence and/or work permit. The spouse must generally have been married to the sponsor for at least 1 year and be at least 21 years old; dependants must obtain the Family Reunification (FR) entry visa abroad before travelling.',
    'Tied to the sponsor''s permit validity; FR permit renewable annually alongside the sponsor''s status',
    'Apply for the FR entry visa at the High Commission, New Delhi before travelling — cannot be converted in-country from a tourist visa',
    1,
    'Reported at around 2-3 months from a complete application, depending on document preparation and Cyprus authority workload',
    'High Commission of the Republic of Cyprus, New Delhi (FR entry visa); Civil Registry and Migration Department, Cyprus (residence permit registration)',
    'Confirm the sponsor holds a qualifying Cyprus residence/work permit\nGather relationship proof (marriage/birth certificates, apostilled/translated) and the sponsor''s permit copy\nApply for the Family Reunification entry visa at the High Commission (not a tourist visa)\nTravel to Cyprus after the FR visa is issued and register for the residence permit\nRenew alongside the sponsor''s permit status',
    '/assets/images/visa-heroes/cyprus.webp',
    'Cross-checked against Cyprus family-reunification/dependent-residence secondary sourcing (law-firm and immigration-consultancy pages), triangulated via web search snippets, not a directly-fetched primary CRMD page', 'https://www.gov.cy/mfa-highcomnewdelhi/en/', '2026-09-17'
);
SET @cyp10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cyp10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp10, 'Core Documents', 'Required from every applicant.', 1);
SET @cyp10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@cyp10s1, 'Proof of Relationship to Sponsor (Apostilled/Translated)', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cyp10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit and household means.', 2);
SET @cyp10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cyp10s2, 'Sponsor''s Cyprus Residence/Work Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@cyp10s2, 'Proof of Adequate Income and Accommodation in Cyprus', NULL, 'copy', 1, 0, 0, 2),
(@cyp10s2, 'Comprehensive Health Insurance Covering All Family Members', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(64, 10, NULL, 'EUR', 'Confirmed After Assessment', 'FR entry visa and residence-permit fees vary by permit category and were not independently confirmed this session; the general Temporary Residence Permit fee is separately reported at around €70 for 2026 — contact the High Commission to confirm.', '2026-09-01', NOW(), 'https://www.gov.cy/mfa-highcomnewdelhi/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my dependant arrive in Cyprus on a tourist visa and switch to family reunification later?', 'No — dependants must obtain the Family Reunification (FR) entry visa from the High Commission in New Delhi before travelling. Unlike some countries, Cyprus does not permit converting a tourist-visa entry into a family-reunification permit in-country.', 64, 10, 6411, 1),
('Is there a minimum marriage duration for a spouse to qualify?', 'Reported guidance indicates the sponsor and spouse generally must have been married for at least 1 year before the family-reunification application, with the spouse at least 21 years old — confirm current requirements with the High Commission, as rules can be updated.', 64, 10, 6412, 1);
