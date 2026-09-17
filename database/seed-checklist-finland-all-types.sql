-- Finland Visa Checklist Engine content for all 10 visa types — built this
-- session via web search (WebSearch worked; direct WebFetch of migri.fi and
-- finlandabroad.fi was blocked by the network egress proxy both times, so
-- every migri.fi / finlandabroad.fi / enterfinland.fi fact below is drawn
-- from search-indexed snippets of those official pages, or from VFS Global
-- and reputable secondary visa-agency sourcing, not a direct-fetched page).
-- Figures are cross-checked across 2+ sources where possible; anything
-- still uncertain is flagged inline with "reported"/"approximate".
--
-- SOURCING CAVEAT: All 10 categories were researched this session (none
-- skipped), but confidence varies — the Schengen C-type categories
-- (Tourist/Business/Family Visit/Medical/Conference/Sports/Transit) rest on
-- consistent multi-source figures (VFS Global, embassy-adjacent secondary
-- sites). The residence-permit categories (Student/Work/Dependent) rest
-- heavily on Migri's own 2026 fee-change announcement as indexed by search
-- (valtioneuvosto.fi, intermin.fi, migri.fi press release on 2026 fees),
-- which is a first-party source even though not directly fetched.
--
-- Finland's real, distinctive, dated facts verified this session:
--   - Split application channel for residence permits: applicants apply
--     and pay ONLINE via Enter Finland (enterfinland.fi), then book a
--     biometrics appointment at VFS Global's Finland Visa Application
--     Centre in New Delhi (or a Finnish mission) — a two-step online+VFS
--     process, distinct from the short-stay Schengen route which is a
--     single VFS Global application.
--   - India is one of only FOUR global priority countries under Finland's
--     Talent Boost programme (specialist/growth-sector work-permit
--     fast-track) — a genuine, specific India inclusion.
--   - Specialist fast-track: confirmed job offer + salary >= EUR 3,937/
--     month (2026) + higher-education degree (or equivalent experience)
--     gets a decision within 2 weeks, and a D-visa can be requested
--     alongside it so the applicant can travel immediately after approval
--     — well ahead of the standard employed-person (TTOL) route, which
--     can involve a TE Office labour market test.
--   - Migri raised nearly all residence-permit processing fees from
--     1 January 2026: online employed-person (TTOL) first permit rose
--     EUR 590 -> EUR 750; online student first permit rose roughly
--     EUR 450 -> EUR 600 (paper EUR 550 -> EUR 750); permanent residence
--     online fee rose EUR 240 -> EUR 380. Source: Finnish Government /
--     Ministry of the Interior / Migri 2026 fee-change announcements.
--   - A significant, dated (autumn 2026) policy tightening: Finland is
--     advancing legislation letting authorities cancel a non-EU/EEA
--     student's residence permit more easily if the student draws social
--     assistance even once (subject to overall consideration), and a
--     related proposal would let a student's family apply for a residence
--     permit only after the student has been in Finland for one year —
--     both are in-progress 2026-2027 reforms, flagged as such below.
--   - Finland genuinely does not require Indian passport holders to hold a
--     Category A airport transit visa for a pure airside layover that
--     never leaves the international transit zone — most Indian transit
--     travellers only need a Type A/any visa if they must clear Finnish
--     border control or leave the airport during the stopover, in which
--     case a standard Type C Schengen visa applies instead.
--   - Migri-certified "Reliable Employer" (Luotettava työnantaja) status
--     gives an employer's TTOL work-permit applications priority
--     processing of about 9-14 days versus the standard 2-4 weeks.
--   - Family-reunification (Dependent) applications are, as a rule,
--     processed within about 9 months — dramatically longer than any
--     Schengen short-stay category — UNLESS the Finland-based sponsor is
--     using the specialist fast-track service and the family member
--     applies at the same time, in which case the family member can also
--     get a decision within about 2 weeks.
--
-- country_id 117 = Finland. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    117, 1, 'FIN-TOUR-IN-01', '2026.09', 'published',
    'Leisure, sightseeing, and tourism travel to Finland.',
    'Indian passport holders — the standard Schengen C-type visa, applied via VFS Global, valid for travel across the wider Schengen area, not just Finland.',
    'Single or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global Finland Visa Application Centres (New Delhi, Mumbai, Bengaluru, Chennai, Hyderabad, Kolkata)',
    1,
    'Standard Schengen processing is typically around 15 calendar days',
    'Embassy of Finland, New Delhi (decision authority), via VFS Global centres',
    'Book a VFS Global appointment\nComplete the online Schengen visa application form\nGather supporting documents\nAttend the appointment and submit biometrics (mandatory for first-time applicants)\nTrack status and collect your passport',
    '/assets/images/visa-heroes/finland.webp',
    'Cross-checked against VFS Global India listings and embassy-adjacent secondary sourcing (finlandabroad.fi not directly fetchable this session)', 'https://finlandabroad.fi/web/ind/visa-fee', '2026-09-17'
);
SET @fin1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fin1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin1, 'Core Documents', 'Required from every applicant.', 1);
SET @fin1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin1s1, 'Valid Passport (3+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@fin1s1, 'Completed Schengen Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@fin1s1, 'Travel/Schengen Medical Insurance (Min. EUR 30,000 Coverage)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @fin1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin1s2, 'Confirmed Hotel Booking', NULL, 'copy', 1, 0, 0, 1),
(@fin1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@fin1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@fin1s2, 'Day-Wise Travel Itinerary', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(117, 1, 90.00, 'EUR', 'Schengen C-Type Visa Fee (Adult)', 'Children aged 6-12 pay a reduced EUR 45 fee; children under 6 are exempt. A separate VFS Global service charge (reported INR 1,933-3,111) also applies.', '2026-09-01', NOW(), 'https://finlandabroad.fi/web/ind/visa-fee', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a Finland Tourist visa let me travel elsewhere in Europe?', 'Yes — the Schengen C-type visa is valid for travel across the entire Schengen area, not just Finland, subject to the standard 90-days-in-180 rule.', 117, 1, 11700, 1),
('Which Indian cities have a VFS Global centre for Finland visas?', 'Reported centres include New Delhi, Mumbai, Bengaluru, Chennai, Hyderabad, and Kolkata — confirm the nearest current centre when booking your appointment.', 117, 1, 11701, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    117, 2, 'FIN-BUS-IN-02', '2026.09', 'published',
    'Business meetings, negotiations, and commercial visits in Finland.',
    'Indian nationals travelling for business — the same Schengen C-type visa as Tourist, with a free-form invitation letter from the Finnish host organisation or private host as the differentiating document.',
    'Single, double, or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global with a business invitation letter and Indian employer forwarding letter',
    1,
    'Standard Schengen processing is typically around 15 calendar days',
    'Embassy of Finland, New Delhi, via VFS Global centres',
    'Obtain a free-form invitation letter from the Finnish host organisation (with host contact details, purpose, and length of visit)\nGather Indian employer forwarding/sponsorship letter\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/finland.webp',
    'Cross-checked against VFS Global India listings and embassy-adjacent secondary sourcing', 'https://finlandabroad.fi/web/ind/types-of-visa', '2026-09-17'
);
SET @fin2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fin2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin2, 'Core Documents', 'Required from every applicant.', 1);
SET @fin2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@fin2s1, 'Invitation Letter from Finnish Host Organisation', 'Free-form letter with host contact details, applicant details, and purpose/length of visit.', 'original', 1, 0, 1, 2),
(@fin2s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @fin2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@fin2s2, 'Business Registration/Company Proof', NULL, 'copy', 0, 1, 0, 2),
(@fin2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(117, 2, 90.00, 'EUR', 'Schengen C-Type Visa Fee (Adult)', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://finlandabroad.fi/web/ind/visa-fee', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the Finnish invitation letter need a fixed format?', 'No — it is a free-form letter, but it should include the host''s contact details plus the applicant''s name, date of birth, address, passport number, and the purpose and length of the visit.', 117, 2, 11702, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Residence Permit for Studies
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    117, 3, 'FIN-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Finnish university, university of applied sciences, or other recognised institution.',
    'Indian nationals admitted to a Finnish institution, applying for a Residence Permit for Studies. Autumn-2026 reforms make this permit easier to cancel if the student draws social assistance even once, so budget carefully.',
    'Typically issued for the duration of study, up to the length of the programme',
    'Apply and pay online via Enter Finland, then attend a biometrics appointment at VFS Global New Delhi (or a Finnish mission)',
    1,
    'Processed as a normal residence-permit application; typical range reported at several weeks to a few months depending on completeness and season',
    'Finnish Immigration Service (Migri), decision; biometrics at VFS Global Finland Visa Application Centre, New Delhi',
    'Secure admission at a recognised Finnish institution\nCreate an Enter Finland account and submit the online application with fee payment\nBook and attend a VFS Global appointment in India to confirm identity/biometrics\nGather proof of funds and health insurance\nCollect the decision and travel; register your right of residence after arrival',
    '/assets/images/visa-heroes/finland.webp',
    'Cross-checked against Migri/Finnish Government 2026 fee-change announcements and secondary study-abroad sourcing (migri.fi/enterfinland.fi not directly fetchable this session)', 'https://migri.fi/en/-/changes-to-finnish-immigration-service-processing-fees-as-of-1-january-2026', '2026-09-17'
);
SET @fin3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fin3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin3, 'Core Documents', 'Required from every applicant.', 1);
SET @fin3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@fin3s1, 'Admission/Acceptance Letter from Finnish Institution', NULL, 'original', 1, 0, 1, 2),
(@fin3s1, 'Enter Finland Online Application Confirmation', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @fin3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@fin3s2, 'Proof of Funds (Reported ~EUR 800/Month)', NULL, 'copy', 1, 0, 0, 2),
(@fin3s2, 'Health Insurance Valid in Finland', NULL, 'original', 1, 0, 0, 3),
(@fin3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(117, 3, 600.00, 'EUR', 'Residence Permit for Studies — Online Application Fee', 'Effective 1 January 2026, up from roughly EUR 450 in 2025; the paper-application fee is reported at EUR 750. A separate VFS Global service fee (reported ~EUR 20) also applies in India.', '2026-01-01', NOW(), 'https://migri.fi/en/-/changes-to-finnish-immigration-service-processing-fees-as-of-1-january-2026', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Finland tightening student residence permit rules?', 'Yes — legislation advancing for autumn 2026 would let authorities cancel a non-EU/EEA student''s residence permit more easily if the student draws social assistance even once (subject to overall consideration). A related proposal would let a student''s family apply for a residence permit only after the student has been in Finland for one year. Confirm the current status before relying on this.', 117, 3, 11703, 1),
('Do I apply for a Finnish student residence permit at VFS or online?', 'Both — you submit and pay for the application online via Enter Finland, then attend a VFS Global appointment in India to confirm your identity and provide biometrics.', 117, 3, 11704, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Residence Permit for Employed Person / Specialist Fast-Track
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    117, 4, 'FIN-WORK-IN-04', '2026.09', 'published',
    'Employment in Finland via the standard Residence Permit for an Employed Person (TTOL), or the faster Specialist residence permit route.',
    'Indian nationals with a confirmed Finnish job offer. India is one of only four global priority countries under Finland''s Talent Boost programme. Specialists with a degree/equivalent experience and a salary of at least EUR 3,937/month (2026) can use fast-track processing; other roles typically go through a TE Office labour market test.',
    'Specialist first permit up to 2 years (or the contract length if shorter); standard TTOL permit terms vary by role',
    'Apply and pay online via Enter Finland, then attend a biometrics appointment at VFS Global New Delhi (or a Finnish mission)',
    1,
    'Specialist fast-track: decision reported within about 2 weeks. Standard TTOL: reported 2-4 weeks, or 9-14 days if the employer holds Migri''s "Reliable Employer" (Luotettava tyonantaja) status; longer if a TE Office labour market test applies.',
    'Finnish Immigration Service (Migri), decision; biometrics at VFS Global Finland Visa Application Centre, New Delhi',
    'Secure a confirmed job offer from a Finnish employer\nCheck whether the role qualifies for the Specialist fast-track (degree/experience + salary threshold) or needs a standard TE Office labour market test\nSubmit the online application and fee via Enter Finland (optionally request a D-visa alongside a fast-track application)\nAttend a VFS Global appointment in India for biometrics\nReceive the decision and travel; register with local authorities after arrival',
    '/assets/images/visa-heroes/finland.webp',
    'Cross-checked against Migri fast-track/specialist guidance and 2026 fee-change announcements as indexed by search, plus secondary expatriate-employment sourcing (migri.fi not directly fetchable this session)', 'https://migri.fi/en/fast-track-for-specialist', '2026-09-17'
);
SET @fin4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fin4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin4, 'Core Documents', 'Required from every applicant.', 1);
SET @fin4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@fin4s1, 'Employment Contract/Confirmed Job Offer', NULL, 'copy', 1, 0, 1, 2),
(@fin4s1, 'Enter Finland Online Application Confirmation', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin4, 'Supporting Documents', 'Additional applicant- and role-side evidence.', 2);
SET @fin4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin4s2, 'Academic/Professional Certificates', 'Especially relevant for Specialist fast-track eligibility.', 'copy', 1, 0, 0, 1),
(@fin4s2, 'Salary Details Meeting the Applicable Threshold', 'Reported ~EUR 1,600/month for standard TTOL; EUR 3,937/month (2026) for Specialist fast-track.', 'copy', 1, 0, 0, 2),
(@fin4s2, 'TE Office Labour Market Test Confirmation', 'Only if the role does not qualify for fast-track/exemption.', 'copy', 0, 1, 0, 3),
(@fin4s2, 'Police Clearance Certificate', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(117, 4, 750.00, 'EUR', 'Residence Permit for Employed Person — Online Application Fee', 'Effective 1 January 2026, up from roughly EUR 590 in 2025 (also reported as the Specialist permit online fee). Paper applications are more expensive; a separate VFS Global service fee also applies in India.', '2026-01-01', NOW(), 'https://migri.fi/en/-/changes-to-finnish-immigration-service-processing-fees-as-of-1-january-2026', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is India eligible for any fast-track Finnish work-permit scheme?', 'Yes — India is one of only four global priority countries under Finland''s Talent Boost programme, and specialists meeting the degree/salary criteria (EUR 3,937/month in 2026) can use fast-track processing with a decision reported within about 2 weeks, versus the longer standard route.', 117, 4, 11705, 1),
('Can I get a D-visa alongside my work residence permit application?', 'If applying via the Specialist fast-track service, you can request a D-visa at the same time, letting you travel to Finland as soon as a decision is made rather than waiting for the physical residence permit card.', 117, 4, 11706, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    117, 5, 'FIN-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Finland for a short stay (distinct from the long-stay Dependent residence permit).',
    'Indian nationals with family/friends in Finland — the same Schengen C-type visa as Tourist, requiring an invitation letter from the host plus proof of the relationship.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with an invitation letter and relationship proof',
    1,
    'Standard Schengen processing is typically around 15 calendar days',
    'Embassy of Finland, New Delhi, via VFS Global centres',
    'Obtain an invitation letter from your host in Finland\nGather documents proving the family or personal relationship\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/finland.webp',
    'Cross-checked against the VFS Global "Visiting Family and Friends" checklist for Finland and embassy-adjacent secondary sourcing', 'https://www.vfsglobal.com/finland/india/pdf/visting-family-friends.pdf', '2026-09-17'
);
SET @fin5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fin5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin5, 'Core Documents', 'Required from every applicant.', 1);
SET @fin5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@fin5s1, 'Invitation Letter from Host in Finland', NULL, 'original', 1, 0, 1, 2),
(@fin5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @fin5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@fin5s2, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 0, 2),
(@fin5s2, 'Host''s Residence Permit/ID Copy', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(117, 5, 90.00, 'EUR', 'Schengen C-Type Visa Fee (Adult)', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://finlandabroad.fi/web/ind/visa-fee', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What''s the difference between this Family Visit visa and the Dependent residence permit?', 'Family Visit is a short-stay Schengen C-type visa (up to 90 days) for visiting relatives or friends. The Dependent category is a separate long-stay residence permit for family members joining a sponsor who already lives in Finland on a qualifying permit.', 117, 5, 11707, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Category A Airport Transit / Type C Fallback
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    117, 6, 'FIN-TRANS-IN-06', '2026.09', 'published',
    'Passing through a Finnish airport (e.g. Helsinki-Vantaa) en route to a non-Schengen destination.',
    'Indian passport holders are generally NOT required to hold a Category A airport transit visa for a pure airside layover that stays within the international transit zone. A standard Type C Schengen visa is needed instead only if the itinerary requires clearing Finnish border control or leaving the airport.',
    'Valid for the transit window only',
    'Confirm first whether any visa is genuinely required for your specific routing; if leaving the transit zone, apply via VFS Global for a Type C visa',
    1,
    'If a Type C visa is required, standard Schengen processing is typically around 15 calendar days',
    'Embassy of Finland, New Delhi, via VFS Global centres',
    'Check your connecting itinerary to see if you stay airside throughout (no visa needed) or must clear immigration/leave the airport\nIf a visa is required, apply via VFS Global with your onward ticket and itinerary\nSubmit biometrics if required',
    '/assets/images/visa-heroes/finland.webp',
    'Cross-checked against Schengen Category A visa policy sourcing and secondary Finland-transit guidance', 'https://finlandabroad.fi/web/ind/types-of-visa', '2026-09-17'
);
SET @fin6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fin6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin6, 'Core Documents', 'Required only if a visa is genuinely needed for your routing.', 1);
SET @fin6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@fin6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @fin6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1),
(@fin6s2, 'Confirmed Through-Checked Baggage Proof', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(117, 6, NULL, 'EUR', 'Confirmed After Assessment', 'Most Indian travellers staying airside pay no fee at all, since no visa is required; if your specific routing requires a Type C visa, the standard EUR 90 Schengen fee applies instead.', '2026-09-01', NOW(), 'https://finlandabroad.fi/web/ind/types-of-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa to connect through a Finnish airport?', 'Generally no, as long as you remain in the international transit area throughout your layover. You only need a visa (a standard Type C, not a Category A) if your connection requires clearing Finnish border control or leaving the airport, for example for a hotel stay.', 117, 6, 11708, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    117, 7, 'FIN-MED-IN-07', '2026.09', 'published',
    'Travel to Finland for medical treatment.',
    'Indian nationals travelling for treatment — the same Schengen C-type visa as Tourist, requiring a certificate from the treating Finnish doctor/institution confirming the need for specific treatment.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with the medical certificate and Schengen-compliant insurance',
    1,
    'Standard Schengen processing is typically around 15 calendar days, longer if documentation is incomplete',
    'Embassy of Finland, New Delhi, via VFS Global centres',
    'Obtain a certificate/confirmation from the treating Finnish doctor or institution\nArrange Schengen-compliant travel insurance (min. EUR 30,000 cover)\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/finland.webp',
    'Cross-checked against VFS Global India listings and embassy-adjacent secondary sourcing', 'https://finlandabroad.fi/web/ind/types-of-visa', '2026-09-17'
);
SET @fin7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fin7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin7, 'Core Documents', 'Required from every applicant.', 1);
SET @fin7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@fin7s1, 'Medical Certificate/Institution Confirmation', NULL, 'original', 1, 0, 1, 2),
(@fin7s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @fin7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@fin7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2),
(@fin7s2, 'Attendant''s Documents (If Accompanying)', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(117, 7, 90.00, 'EUR', 'Schengen C-Type Visa Fee (Adult)', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://finlandabroad.fi/web/ind/visa-fee', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need Finland-specific medical insurance for a Medical visa?', 'You need Schengen-compliant travel/medical insurance with a minimum of EUR 30,000 coverage, the same requirement as other short-stay Schengen categories — confirm your treating institution''s own requirements as well.', 117, 7, 11709, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    117, 8, 'FIN-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade fairs in Finland.',
    'Indian nationals attending a conference — the same Schengen C-type visa as Tourist/Business, requiring a conference invitation or registration confirmation from the organiser.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a conference invitation/registration confirmation',
    1,
    'Standard Schengen processing is typically around 15 calendar days',
    'Embassy of Finland, New Delhi, via VFS Global centres',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/finland.webp',
    'Cross-checked against VFS Global India listings and embassy-adjacent secondary sourcing', 'https://finlandabroad.fi/web/ind/types-of-visa', '2026-09-17'
);
SET @fin8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fin8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin8, 'Core Documents', 'Required from every applicant.', 1);
SET @fin8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@fin8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @fin8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@fin8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(117, 8, 90.00, 'EUR', 'Schengen C-Type Visa Fee (Adult)', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://finlandabroad.fi/web/ind/visa-fee', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Conference visa different from a Business visa?', 'Both use the same underlying Schengen C-type visa; the key difference is the invitation document — a conference invitation/registration confirmation from the event organiser rather than a business-host invitation letter.', 117, 8, 11710, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    117, 9, 'FIN-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Finland.',
    'Indian nationals competing or officiating — the same Schengen C-type visa as Tourist/Conference, typically requiring a letter from the home-country sports association plus an invitation from the host event organiser.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a home-association letter and host-organizer invitation',
    1,
    'Standard Schengen processing is typically around 15 calendar days',
    'Embassy of Finland, New Delhi, via VFS Global centres',
    'Obtain a letter from your resident-country athletic association confirming your role\nObtain an invitation letter from the host event organiser with event details and expense arrangements\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/finland.webp',
    'Cross-checked against VFS Global India listings and embassy-adjacent secondary sourcing', 'https://finlandabroad.fi/web/ind/types-of-visa', '2026-09-17'
);
SET @fin9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fin9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin9, 'Core Documents', 'Required from every applicant.', 1);
SET @fin9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@fin9s1, 'Home-Country Sports Association Letter', 'Confirms role and no-employment status.', 'original', 1, 0, 1, 2),
(@fin9s1, 'Host Event Organiser Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @fin9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1),
(@fin9s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(117, 9, 90.00, 'EUR', 'Schengen C-Type Visa Fee (Adult)', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://finlandabroad.fi/web/ind/visa-fee', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need two separate invitation letters for a Sports visa?', 'Typically yes — one from your home-country sports association confirming your role, and one from the host event organiser in Finland with event and expense details.', 117, 9, 11711, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Ties Residence Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    117, 10, 'FIN-DEP-IN-10', '2026.09', 'published',
    'Spouse, registered/cohabiting partner, or minor children joining an Indian sponsor holding a valid Finnish residence permit.',
    'Family members of an Indian national holding a qualifying Finnish residence permit (work, specialist, or study). Standard family-ties processing is, as a rule, within about 9 months, but a family member applying alongside a Specialist fast-track sponsor can get a decision within about 2 weeks.',
    'Tied to the sponsor''s permit validity',
    'Apply and pay online via Enter Finland, then attend a biometrics appointment at VFS Global New Delhi (or a Finnish mission)',
    1,
    'Standard route: as a rule within about 9 months, longer if further clarification or an interview is needed. Fast-track route (sponsor is a Specialist applying simultaneously): reported within about 2 weeks.',
    'Finnish Immigration Service (Migri), decision; biometrics at VFS Global Finland Visa Application Centre, New Delhi',
    'Confirm the sponsor holds, or is simultaneously applying for, a qualifying Finnish residence permit\nGather relationship proof (marriage/birth certificates) and the sponsor''s permit details\nSubmit the online application and fee via Enter Finland\nAttend a VFS Global appointment in India for biometrics\nWait through the applicable processing window and collect the decision',
    '/assets/images/visa-heroes/finland.webp',
    'Cross-checked against Migri family-ties/fast-track guidance and reported fee figures as indexed by search (migri.fi/enterfinland.fi not directly fetchable this session)', 'https://migri.fi/en/moving-to-finland-to-be-with-a-family-member', '2026-09-17'
);
SET @fin10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fin10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin10, 'Core Documents', 'Required from every applicant.', 1);
SET @fin10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@fin10s1, 'Proof of Relationship to Sponsor (Marriage/Birth Certificate)', NULL, 'copy', 1, 0, 1, 2),
(@fin10s1, 'Enter Finland Online Application Confirmation', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fin10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit and household income.', 2);
SET @fin10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fin10s2, 'Sponsor''s Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@fin10s2, 'Proof of Household Income Meeting Requirement', NULL, 'copy', 1, 0, 0, 2),
(@fin10s2, 'Sponsor''s Fast-Track Application Confirmation (If Applying Together)', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(117, 10, 220.00, 'EUR', 'Family Ties Residence Permit — Online Application Fee (Approximate)', 'Reported figure for an Enter Finland online application per family-ties applicant; confirm the current amount given Migri''s broader 2026 fee increases, as this specific line was not directly confirmed against the 2026 fee-change notice.', '2026-09-01', NOW(), 'https://migri.fi/en/moving-to-finland-to-be-with-a-family-member', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How long does Dependent/family-ties processing really take?', 'As a rule, about 9 months for the standard route — much longer than any short-stay Schengen category. However, if your Finland-based sponsor applies via the Specialist fast-track service and you apply at the same time, you can also get a decision within about 2 weeks.', 117, 10, 11712, 1),
('Can a student''s family join them in Finland right away?', 'Not necessarily going forward — a proposed 2026-2027 reform would let a student''s family apply for a residence permit only after the student has been in Finland for one year. Confirm the current rule before applying, as this is an in-progress policy change.', 117, 10, 11713, 1);
