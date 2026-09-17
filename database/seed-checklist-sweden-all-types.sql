-- Sweden Visa Checklist Engine content for all 10 visa types — built fresh
-- this session via WebSearch. hero_image_url set to the existing
-- /assets/images/visa-heroes/sweden.webp bundle for all 10 rows.
--
-- SOURCING CAVEATS:
--   - Direct WebFetch of visa.vfsglobal.com (the VFS Global Sweden visa
--     portal, including its "Business and Conference Visa Checklist" and
--     "Checklist for Culture or Sports Visa" one-pager PDFs) was BLOCKED
--     by the network egress proxy this session (EGRESS_BLOCKED). Those
--     two VFS one-pager filenames/titles were confirmed to exist via
--     WebSearch indexing, but their full document lists were not read
--     directly — Business/Conference and Sports section content below is
--     built from secondary-sourced document norms plus the confirmed
--     "bundled checklist" fact, not a verbatim read of the PDFs. Flagged
--     inline in those two categories' purpose/eligibility text.
--   - All other facts below were cross-checked against WebSearch results
--     drawing on official migrationsverket.se and swedenabroad.se
--     (Embassy of Sweden / Sweden Abroad) pages, plus immigration-law
--     secondary sources (Newland Chase, KPMG Flash Alert, Jobbatical,
--     Zalaris, etc.) reporting on Sweden's 2026 reforms. No category was
--     entirely unconfirmed, but see per-field notes for figures where
--     sources disagree.
--   - Two genuine numeric conflicts found and flagged rather than
--     silently resolved: (1) the 2026 work-permit salary floor is
--     reported as both SEK 33,390 and SEK 34,470/month across sources
--     (likely different snapshot dates of the underlying median-wage
--     statistic); (2) the family-reunification application fee is
--     reported as both SEK 1,530/750 (adult/child) and SEK 2,000/1,000
--     across sources. Both are surfaced as "Confirmed After Assessment"
--     or dual-figure notes rather than picked arbitrarily.
--
-- SWEDEN'S GENUINELY DISTINCTIVE / NOTABLE FACTS VERIFIED THIS SESSION:
--   - Work-permit salary threshold reform: effective 1 June 2026, the
--     minimum monthly salary for a standard work permit rose from 80% to
--     90% of the Swedish median wage — reported as a floor in the
--     SEK 33,390-34,470/month range (up from ~SEK 29,680 previously).
--     27 named shortage occupations (per Migrationsverket's published
--     list, e.g. IT operations/support technicians, chemistry/chemical
--     engineering technicians) remain at a reduced 75% threshold.
--     Transitional rule: extensions filed 1 June-1 December 2026 for
--     permits granted before 1 June 2026 still use the old 80% rule;
--     the 90% rule applies to all extensions from 2 December 2026.
--   - Family Visit sponsorship genuinely uses a named official form:
--     Migrationsverket Invitation Form 241011 ("Inbjudan" / "Invitation
--     - Before application for Schengen visa"), which the Swedish-based
--     host must complete, sign, and send to the Indian applicant before
--     the VFS application is lodged.
--   - Student work-hours liberalization: new rules effective 11 June
--     2026 cap higher-education residence-permit holders at 15 working
--     hours/week during academic terms (unlimited in June-August), with
--     exemptions for work tied to education, traineeships, research, or
--     student-union representation. Permits issued before 11 June 2026
--     are grandfathered until their next extension. A related academic-
--     progress rule requires 37.5 credits in year one and 45 credits per
--     year thereafter to qualify for a permit extension.
--   - Dependents of work/study permit holders in Sweden are explicitly
--     allowed to apply for their own residence permit AFTER the main
--     applicant already holds theirs ("family members who apply
--     afterwards"), not only as a simultaneous joint filing — confirmed
--     directly on migrationsverket.se.
--   - Sweden/VFS bundle Business and Conference visas under one shared
--     documentary checklist, and separately bundle Culture and Sports
--     visas under another shared checklist (per VFS one-pager titles),
--     mirroring the pattern seen in other Nordic/EU checklist batches.
--   - A genuine visa-vs-work-permit carve-out exists for professional
--     athletes: an athlete does not need a separate Swedish work permit
--     to compete if staying no more than 3 months within a 12-month
--     period without a contract with a Swedish club — though a Schengen
--     visa to enter the country may still be required.
--   - Most residence-permit categories (Student, Work, Dependent) are
--     decided by Migrationsverket itself (the Swedish Migration Agency,
--     based in Sweden) via its online e-service, NOT by the Embassy of
--     Sweden in India — the Embassy/VFS/Consulate role for these is
--     limited to biometrics collection, distinct from the short-stay
--     Schengen C-type categories where the Embassy of Sweden, New Delhi
--     is itself the decision authority.
--
-- country_id 149 = Sweden. visa_type_id: 1=Tourist, 2=Business,
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
    149, 1, 'SWE-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Sweden.',
    'Indian passport holders — the standard Schengen C-type visa, applied via VFS Global (9 Indian cities), valid for travel across the wider Schengen area, not just Sweden.',
    'Single or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global (New Delhi, Mumbai, Pune, Kolkata, Chennai, Bengaluru, Hyderabad, Lucknow, Ahmedabad)',
    1,
    'Standard Schengen processing is around 15 calendar days from a complete application reaching the Embassy',
    'Embassy of Sweden, New Delhi (decision authority), via VFS Global centres',
    'Book a VFS Global appointment\nComplete the online Schengen visa application form\nGather supporting documents\nAttend the appointment and submit biometrics (mandatory for first-time applicants)\nTrack status and collect your passport',
    '/assets/images/visa-heroes/sweden.webp',
    'Cross-checked against Sweden Abroad (Embassy of Sweden) and VFS Global secondary sourcing', 'https://www.swedenabroad.se/en/about-sweden-non-swedish-citizens/india/going-to-sweden/visiting-sweden/fees/', '2026-09-17'
);
SET @swe1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swe1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe1, 'Core Documents', 'Required from every applicant.', 1);
SET @swe1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe1s1, 'Valid Passport (3+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@swe1s1, 'Completed Schengen Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@swe1s1, 'Travel/Schengen Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @swe1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe1s2, 'Confirmed Hotel/Accommodation Booking', NULL, 'copy', 1, 0, 0, 1),
(@swe1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@swe1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@swe1s2, 'Cover Letter/Day-Wise Travel Itinerary', NULL, 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(149, 1, 80.00, 'EUR', 'Schengen C-Type Visa Fee', 'Paid in INR equivalent at the VFS centre; a separate VFS Global service charge of roughly INR 1,750-2,200 also applies.', '2026-09-01', NOW(), 'https://www.swedenabroad.se/en/about-sweden-non-swedish-citizens/india/going-to-sweden/visiting-sweden/fees/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a Sweden Tourist visa let me travel elsewhere in Europe?', 'Yes — the Schengen C-type visa is valid for travel across the entire Schengen area, not just Sweden, subject to the standard 90-days-in-180 rule.', 149, 1, 14900, 1),
('Which Indian cities have a VFS Global centre for Sweden visas?', 'Nine centres: New Delhi, Mumbai, Pune, Kolkata, Chennai, Bengaluru, Hyderabad, Lucknow, and Ahmedabad. The Embassy of Sweden, New Delhi remains the sole decision authority.', 149, 1, 14901, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    149, 2, 'SWE-BUS-IN-02', '2026.09', 'published',
    'Trade negotiations, meetings, and commercial activity in Sweden.',
    'Indian nationals travelling for business — the same Schengen C-type visa as Tourist. VFS Global lists Business under a shared "Business and Conference Visa" documentary checklist (PDF title confirmed; full contents not directly fetchable this session).',
    'Single, double, or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global with a company invitation letter on Swedish host letterhead',
    1,
    'Standard Schengen processing is around 15 calendar days',
    'Embassy of Sweden, New Delhi (decision authority), via VFS Global centres',
    'Obtain an invitation letter from the Swedish host company (purpose, dates, contact details, cost coverage)\nGather Indian employer forwarding/sponsorship letter\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/sweden.webp',
    'Cross-checked against VFS Global secondary sourcing; the VFS one-pager PDF itself was not directly fetchable this session (network egress blocked)', 'https://visa.vfsglobal.com/one-pager/sweden/india/english/index.html', '2026-09-17'
);
SET @swe2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swe2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe2, 'Core Documents', 'Required from every applicant.', 1);
SET @swe2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@swe2s1, 'Invitation Letter from Swedish Host Company', 'On company letterhead, stating purpose, dates, and whether costs are covered by the host.', 'original', 1, 0, 1, 2),
(@swe2s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @swe2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe2s2, 'Forwarding/NOC Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@swe2s2, 'Business Registration Proof', NULL, 'copy', 0, 1, 0, 2),
(@swe2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(149, 2, 80.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/one-pager/sweden/india/english/index.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Business and Conference visas share the same checklist?', 'Yes — VFS Global lists a combined "Business and Conference Visa" checklist for Sweden, so document requirements largely overlap between the two purposes.', 149, 2, 14902, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Residence Permit for Studies
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    149, 3, 'SWE-STU-IN-03', '2026.09', 'published',
    'Enrolling in higher-education studies at a Swedish university or institution.',
    'Indian nationals admitted to a recognized Swedish institution, needing a residence permit for studies decided by Migrationsverket. Must show funds of ~SEK 9,450/month (up to 10 months). Since 11 June 2026, term-time work is capped at 15 hours/week (unlimited June-August), with an academic-progress rule of 37.5 credits in year one and 45/year thereafter for extension.',
    'Permit tied to program duration (or up to 1 year, renewable); 15 hrs/week term-time work cap since 11 June 2026, unlimited Jun-Aug',
    'Apply online via Migrationsverket e-service; biometrics at VFS Global or Embassy of Sweden, New Delhi',
    1,
    'Migrationsverket reports ~75% of recent cases decided within 2 months; apply 3-4 months ahead of the program start',
    'Migrationsverket (decision authority, Sweden); biometrics via Embassy of Sweden, New Delhi / Consulate General, Mumbai',
    'Secure admission at a recognized Swedish institution\nPay the application fee and apply online via Migrationsverket\nArrange proof of funds (~SEK 9,450/month) and any required insurance\nAttend the Embassy of Sweden or Consulate General for biometrics\nAwait Migrationsverket''s decision and collect your residence permit card',
    '/assets/images/visa-heroes/sweden.webp',
    'Cross-checked against migrationsverket.se residence-permit-for-studies guidance and the 11 June 2026 study-permit reform announcement', 'https://www.migrationsverket.se/en/you-want-to-apply/study/higher-education.html', '2026-09-17'
);
SET @swe3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swe3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe3, 'Core Documents', 'Required from every applicant.', 1);
SET @swe3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@swe3s1, 'Admission/Acceptance Letter from Swedish Institution', NULL, 'original', 1, 0, 1, 2),
(@swe3s1, 'Proof of Paid Tuition Fee', 'Non-EU/EEA students unless covered by a scholarship.', 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe3, 'Supporting Documents', 'Evidence of your funds and academic background.', 2);
SET @swe3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe3s2, 'Proof of Funds (~SEK 9,450/Month, Up to 10 Months)', NULL, 'copy', 1, 0, 0, 1),
(@swe3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 2),
(@swe3s2, 'Passport-Size Photograph', NULL, 'original', 1, 0, 0, 3),
(@swe3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(149, 3, 1500.00, 'SEK', 'Residence Permit for Studies Fee', 'Non-refundable even if the application is rejected.', '2026-09-01', NOW(), 'https://www.migrationsverket.se/en/you-want-to-apply/study/higher-education.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How many hours can I work while studying in Sweden?', 'Since 11 June 2026, higher-education residence-permit holders are capped at 15 hours/week during academic terms, with unlimited work allowed in June, July, and August. Permits issued before that date keep the old (unlimited) rule until their next extension.', 149, 3, 14904, 1),
('What academic progress do I need to extend my study permit?', 'From 11 June 2026, extensions require showing at least 37.5 completed credits in your first year and 45 credits per academic year after that.', 149, 3, 14905, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Work Permit (Arbetstillstånd)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    149, 4, 'SWE-WORK-IN-04', '2026.09', 'published',
    'Employment with a Swedish employer under a standard work permit (arbetstillstand).',
    'From 1 June 2026 the minimum salary threshold rose from 80% to 90% of the Swedish median wage, reported in the SEK 33,390-34,470/month range; ~27 shortage occupations remain at a reduced 75% threshold. A mandatory trade union opinion on employment terms applies to every application.',
    'Permit tied to the job offer, typically up to 2 years, renewable',
    'Employer applies via Migrationsverket e-service; applicant attends VFS Global or Embassy of Sweden, New Delhi for biometrics',
    1,
    'Standard processing reported at 2-4 months; certified employers may access a ~4-week fast-track lane',
    'Migrationsverket (decision authority, Sweden); via VFS Global / Embassy of Sweden, New Delhi',
    'Secure a job offer meeting the current salary threshold (or a listed shortage-occupation exemption)\nEmployer obtains a trade union opinion on the employment terms\nEmployer/applicant apply online via Migrationsverket\nAttend biometrics at VFS Global or the Embassy of Sweden\nReceive the decision and, once approved, the residence permit card',
    '/assets/images/visa-heroes/sweden.webp',
    'Cross-checked against Migrationsverket''s May 2026 exempt-occupations announcement and Newland Chase/KPMG/Jobbatical reform reporting', 'https://www.migrationsverket.se/en/you-want-to-apply/work/employee-or-self-employed/employees.html', '2026-09-17'
);
SET @swe4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swe4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe4, 'Core Documents', 'Required from every applicant.', 1);
SET @swe4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@swe4s1, 'Signed Employment Contract/Offer', NULL, 'copy', 1, 0, 1, 2),
(@swe4s1, 'Trade Union Opinion (Fackligt Yttrande) on Employment Terms', 'Obtained by the employer; mandatory for every application, no exceptions.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @swe4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe4s2, 'Proof of Salary Meeting the Current Threshold', 'Or documentation of shortage-occupation exemption at the reduced 75% threshold.', 'copy', 1, 0, 0, 1),
(@swe4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 2),
(@swe4s2, 'Health Insurance (If Permit Under 1 Year)', NULL, 'original', 0, 1, 0, 3),
(@swe4s2, 'Police Clearance Certificate', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(149, 4, 2200.00, 'SEK', 'General Work Permit Fee (Approximate)', 'Some sources cite SEK 2,000 for applications filed through Migrationsverket''s online e-service; confirm the current figure before applying.', '2026-09-01', NOW(), 'https://www.migrationsverket.se/en/you-want-to-apply/work/employee-or-self-employed/employees.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Did the Sweden work-permit salary threshold really change in 2026?', 'Yes — effective 1 June 2026 it rose from 80% to 90% of the Swedish median wage, reported at roughly SEK 33,390-34,470/month, up from about SEK 29,680 previously. About 27 shortage occupations stay at a reduced 75% threshold.', 149, 4, 14906, 1),
('Is a trade union opinion always required?', 'Yes — a trade union statement (fackligt yttrande) on the offered employment terms is mandatory for every Swedish work-permit application, with no exceptions reported.', 149, 4, 14907, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    149, 5, 'SWE-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Sweden.',
    'Indian nationals with family/friends in Sweden — the same Schengen C-type visa as Tourist, requiring Migrationsverket''s official Invitation Form 241011, completed and signed by the Swedish host and sent to the Indian applicant before the visa application is lodged.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a completed Invitation Form 241011 from your Swedish host',
    1,
    'Standard Schengen processing is around 15 calendar days',
    'Embassy of Sweden, New Delhi (decision authority), via VFS Global centres',
    'Ask your Swedish host to complete and sign Migrationsverket Invitation Form 241011\nHave the host send you the form and supporting attachments\nGather proof of your relationship to the host\nComplete the online Schengen visa application and submit at VFS Global',
    '/assets/images/visa-heroes/sweden.webp',
    'Cross-checked directly against migrationsverket.se''s "Invite family, friends or partners" page and the published Form 241011 PDF', 'https://www.migrationsverket.se/en/you-want-to-apply/visiting-sweden/invite-family-friends-or-partners.html', '2026-09-17'
);
SET @swe5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swe5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe5, 'Core Documents', 'Required from every applicant.', 1);
SET @swe5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@swe5s1, 'Migrationsverket Invitation Form 241011 (Signed by Host)', NULL, 'original', 1, 0, 1, 2),
(@swe5s1, 'Proof of Relationship to Host', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @swe5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@swe5s2, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(149, 5, 80.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://www.migrationsverket.se/en/you-want-to-apply/visiting-sweden/invite-family-friends-or-partners.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What exactly is Invitation Form 241011?', 'It is Migrationsverket''s official "Invitation - Before application for Schengen visa" form. Your Swedish-based host completes it, signs it, and sends it (with attachments such as ID/residence-permit copy and proof of accommodation) to you in India before you apply.', 149, 5, 14908, 1),
('Can Form 241011 be used to invite a friend, not just a relative?', 'Yes — the form explicitly covers inviting either a relative or a friend for a visit of up to 90 days within a 180-day period.', 149, 5, 14909, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Type A Airport Transit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    149, 6, 'SWE-TRAN-IN-06', '2026.09', 'published',
    'Passing through a Swedish airport airside-to-airside toward a non-Schengen destination.',
    'A distinct Type A Airport Transit Visa, only needed if leaving the international transit zone (changing terminals, clearing immigration, or collecting baggage) — not required for a purely airside connection.',
    'Valid for the transit window; issued for up to 6 months, 1 or 2 entries',
    'Apply via VFS Global with your onward ticket and itinerary, only if a transit visa is genuinely required',
    1,
    'Reported at around 10-15 working days',
    'Embassy of Sweden, New Delhi (decision authority), via VFS Global centres',
    'Confirm with your airline/itinerary whether you must leave the international transit zone\nIf required, apply via VFS Global with your onward ticket and itinerary\nSubmit biometrics if requested',
    '/assets/images/visa-heroes/sweden.webp',
    'Cross-checked against Type A visa secondary sourcing; the exact fee figure varies across sources and is flagged below', 'https://www.swedenabroad.se/en/about-sweden-non-swedish-citizens/india/going-to-sweden/visiting-sweden/apply-for-a-visa/', '2026-09-17'
);
SET @swe6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swe6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe6, 'Core Documents', 'Required if a Type A visa is genuinely needed.', 1);
SET @swe6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@swe6s1, 'Onward Flight Ticket/Boarding Pass', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @swe6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1),
(@swe6s2, 'Proof of Layover Accommodation (If Applicable)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(149, 6, NULL, 'EUR', 'Confirmed After Assessment', 'Sources report figures between €80 (same as the standard C-type fee) and €90 for the Type A transit visa — treat as approximate and confirm before applying.', '2026-09-01', NOW(), 'https://www.swedenabroad.se/en/about-sweden-non-swedish-citizens/india/going-to-sweden/visiting-sweden/apply-for-a-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a Sweden transit visa if I never leave the airport?', 'No — Indian passport holders staying entirely within the international transit area (airside connection) do not need a separate transit visa. It is only required if you must clear immigration, change terminals, or collect baggage.', 149, 6, 14910, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    149, 7, 'SWE-MED-IN-07', '2026.09', 'published',
    'Travel to Sweden for medical treatment.',
    'Indian nationals travelling for treatment — the same Schengen C-type visa as Tourist, requiring a certificate from the treating Swedish doctor/institution and Schengen-approved medical insurance (min. €30,000); treatment beyond 90 days needs a different, longer-stay route.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with the medical certificate and Schengen-approved insurance',
    1,
    'Around 15 calendar days from a complete application reaching the Embassy',
    'Embassy of Sweden, New Delhi (decision authority), via VFS Global centres',
    'Obtain a certificate from the treating Swedish doctor/institution\nArrange Schengen-approved travel medical insurance (min. €30,000 cover)\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/sweden.webp',
    'Cross-checked against Sweden Abroad''s medical travel insurance guidance and VFS Global secondary sourcing', 'https://www.swedenabroad.se/en/about-sweden-non-swedish-citizens/india/going-to-sweden/visiting-sweden/medical-travel-insurance/', '2026-09-17'
);
SET @swe7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swe7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe7, 'Core Documents', 'Required from every applicant.', 1);
SET @swe7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@swe7s1, 'Medical Certificate/Institution Confirmation', NULL, 'original', 1, 0, 1, 2),
(@swe7s1, 'Schengen-Approved Medical Insurance (Min. €30,000)', 'Insurance from an Indian insurer not approved by the Schengen representation is not accepted — confirm approved insurers before purchasing.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @swe7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe7s2, 'Medical Records/Referral Letter from India', NULL, 'copy', 1, 0, 0, 1),
(@swe7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(149, 7, 80.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://www.swedenabroad.se/en/about-sweden-non-swedish-citizens/india/going-to-sweden/visiting-sweden/medical-travel-insurance/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use any Indian travel insurance policy for a Sweden medical visa?', 'Not automatically — Sweden Abroad states that travel medical insurance from Indian insurers not approved by the Schengen representation is not accepted for the visa procedure, so confirm your insurer is on the approved list first.', 149, 7, 14912, 1),
('What if my treatment needs more than 90 days in Sweden?', 'A standard Schengen C-type medical visa only covers stays up to 90 days within 180 days — treatment expected to run longer requires a different, longer-stay application route.', 149, 7, 14913, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    149, 8, 'SWE-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade fairs in Sweden.',
    'Indian nationals attending a conference — the same Schengen C-type visa as Tourist. VFS Global lists Conference under a shared "Business and Conference Visa" checklist (PDF title confirmed; full contents not directly fetchable this session).',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a conference invitation/registration confirmation',
    1,
    'Standard Schengen processing is around 15 calendar days',
    'Embassy of Sweden, New Delhi (decision authority), via VFS Global centres',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/sweden.webp',
    'Cross-checked against VFS Global''s bundled Business/Conference checklist listing; the PDF itself was not directly fetchable this session (network egress blocked)', 'https://visa.vfsglobal.com/one-pager/sweden/india/english/index.html', '2026-09-17'
);
SET @swe8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swe8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe8, 'Core Documents', 'Required from every applicant.', 1);
SET @swe8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@swe8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @swe8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@swe8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(149, 8, 80.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/one-pager/sweden/india/english/index.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a formal employer forwarding letter mandatory for a Conference visa?', 'It is typically required only where your employer is sponsoring the trip or covering costs — carry it if applicable, alongside the conference invitation/registration confirmation, to strengthen the application.', 149, 8, 14914, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    149, 9, 'SWE-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, coaches, and officials competing or participating in sporting events hosted in Sweden.',
    'Indian nationals competing/officiating — the same Schengen C-type visa as Tourist. VFS Global lists Sports under a shared "Culture or Sports Visa" checklist (PDF title confirmed; full contents not directly fetchable this session). A separate work-permit exemption applies to athletes competing up to 3 months/year without a Swedish club contract.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a host-organizer invitation and home-federation letter',
    1,
    'Standard Schengen processing is around 15 calendar days',
    'Embassy of Sweden, New Delhi (decision authority), via VFS Global centres',
    'Obtain an invitation letter from the host event organizer in Sweden\nObtain a letter from your home-country sports federation/association confirming your role\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/sweden.webp',
    'Cross-checked against VFS Global''s bundled Culture/Sports checklist listing and Migrationsverket''s athlete work-permit guidance; the VFS PDF itself was not directly fetchable this session', 'https://www.migrationsverket.se/en/you-want-to-apply/work/employee-or-self-employed/athletes-and-coaches.html', '2026-09-17'
);
SET @swe9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swe9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe9, 'Core Documents', 'Required from every applicant.', 1);
SET @swe9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@swe9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 2),
(@swe9s1, 'Home-Country Sports Federation/Association Letter', 'Confirms role and, where relevant, no-employment status.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @swe9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe9s2, 'Team/Delegation List (If Applicable)', NULL, 'copy', 0, 1, 0, 1),
(@swe9s2, 'No-Objection Certificate from Employer (If Applicable)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(149, 9, 80.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://www.migrationsverket.se/en/you-want-to-apply/work/employee-or-self-employed/athletes-and-coaches.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do professional athletes always need a Swedish work permit to compete?', 'No — Migrationsverket confirms an athlete does not need a separate work permit if staying in Sweden only to compete in an international competition for up to 3 months within a 12-month period without a contract with a Swedish club. A Schengen visa to enter may still be required.', 149, 9, 14916, 1),
('Do Sports and Culture visas share the same checklist?', 'Yes — VFS Global lists a combined "Culture or Sports Visa" checklist for Sweden, so document requirements largely overlap between the two purposes.', 149, 9, 14917, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification Residence Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    149, 10, 'SWE-DEP-IN-10', '2026.09', 'published',
    'Spouse, partner, or children joining an Indian national holding a Swedish work or study residence permit.',
    'Family of a work/study/EU Blue Card/ICT/self-employed permit holder — spouse, cohabiting or registered partner, and unmarried children under 21 (older children in some proven-dependency cases). Migrationsverket explicitly allows family members to apply for their own permit AFTER the main applicant already holds theirs, not only as a joint simultaneous filing.',
    'Tied to the sponsor''s permit validity, normally an initial 2 years',
    'Apply via Migrationsverket e-service (may be filed after the sponsor''s permit is granted); biometrics at VFS Global or Embassy of Sweden, New Delhi',
    1,
    'Reported median ~9 months for spouses/children (6-12 month range); certified-employer cases may see 4-8 months',
    'Migrationsverket (decision authority, Sweden); via VFS Global / Embassy of Sweden, New Delhi',
    'Confirm the sponsor already holds (or is applying for) a qualifying Swedish work/study permit\nGather relationship proof (marriage/birth certificates) and the sponsor''s permit copy\nApply online via Migrationsverket, at the same time as or after the sponsor\nAttend biometrics at VFS Global or the Embassy of Sweden, New Delhi\nAwait the decision and collect the residence permit card',
    '/assets/images/visa-heroes/sweden.webp',
    'Cross-checked directly against migrationsverket.se''s "family members who apply afterwards" guidance for employees', 'https://www.migrationsverket.se/en/you-want-to-apply/work/employee-or-self-employed/family-of-an-employee-or-self-employed-person-who-apply-afterwards.html', '2026-09-17'
);
SET @swe10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@swe10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe10, 'Core Documents', 'Required from every applicant.', 1);
SET @swe10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@swe10s1, 'Proof of Relationship to Sponsor (Marriage/Birth Certificate)', NULL, 'copy', 1, 0, 1, 2),
(@swe10s1, 'Sponsor''s Swedish Work/Study Permit Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@swe10, 'Supporting Documents', 'Evidence tied to the sponsor''s means.', 2);
SET @swe10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@swe10s2, 'Proof of Sponsor''s Financial Means', NULL, 'copy', 1, 0, 0, 1),
(@swe10s2, 'Proof of Accommodation in Sweden', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(149, 10, NULL, 'SEK', 'Confirmed After Assessment', 'Sources disagree on the exact figure: SEK 1,530/adult + SEK 750/child in one set of sources, vs. SEK 2,000/adult + SEK 1,000/child (under 18) in another — confirm the current fee before applying.', '2026-09-01', NOW(), 'https://www.migrationsverket.se/en/you-want-to-apply/work/employee-or-self-employed/family-of-an-employee-or-self-employed-person-who-apply-afterwards.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my family only join me at the same time I move to Sweden?', 'No — Migrationsverket explicitly allows family members of a work, study, EU Blue Card, ICT, or self-employed permit holder to submit their own application afterwards, once the sponsor already holds their permit, not only as one joint simultaneous filing.', 149, 10, 14918, 1),
('Who counts as a "family member" for Swedish dependent permits?', 'Spouses, cohabiting partners, and registered partners, plus unmarried children under 21. Unmarried children 21 or older may still qualify in specific cases where financial dependency on the sponsor or their partner can be shown.', 149, 10, 14919, 1);
