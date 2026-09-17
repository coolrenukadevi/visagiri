-- Kazakhstan Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- IMPORTANT SOURCING CAVEAT: WebFetch was blocked by the network egress
-- proxy for essentially every domain attempted this session, including
-- the primary official sources (egov.kz, vmp.gov.kz, mfa.gov.kz,
-- indembastana.gov.in, and secondary sites such as blog.wego.com,
-- btwvisas.com, kazakhstan-evisa.com, new.wpk.kz, advantour.com, and
-- even en.wikipedia.org). All findings below are therefore triangulated
-- from WebSearch result snippets only (which quote and paraphrase those
-- same official and secondary sources), never from a directly fetched
-- page. Fee figures in particular vary across secondary sources and are
-- flagged as approximate. No statistics, reference URLs, or dates below
-- were invented — every URL cited is one that genuinely appeared in a
-- WebSearch result this session.
--
-- Kazakhstan's real, distinctive, dated facts verified this session:
--   - Indian passport holders get VISA-FREE entry for tourism, private
--     visits, and short-term business for up to 14 consecutive days per
--     visit (max 42 days within any rolling 180-day period), under
--     Decree No. 464 of the Government of Kazakhstan dated 7 July 2022.
--   - Kazakhstan's Ministry of Foreign Affairs (New Delhi embassy site)
--     names a dedicated "Transit Visa-Free Regime for Indian Passport
--     Holders" — a distinct, India-specific transit policy, separate
--     from the general 14-day visa-free rule.
--   - A new digital entry-authorization platform, QazETA, launched in
--     January 2026 and is running in voluntary pilot mode as of
--     September 2026. Reported rollout: mandatory at airports from
--     1 November 2026, phasing to other entry points by 15 December
--     2026 — relevant to Indian visa-free travelers going forward, who
--     will need to register (72 hours ahead, per current reporting)
--     even though no visa is required. Final implementing regulation
--     was still pending as of the most recent reporting found.
--   - Kazakhstan's e-Visa (official portal: vmp.gov.kz, "Visa and
--     Migration Portal") is genuinely narrow in scope — reported to
--     cover only three category groups: Tourist (B12), Business/
--     Conference/Sports (B1/B2/B3), and Medical/Treatment (C12).
--     Student (C9), Work (C3), Family/Private Visit (B10), and
--     Dependent/Family-Reunification (C2) categories are reported to
--     require an in-person application at the Embassy of Kazakhstan,
--     New Delhi, or the Consulate General of Kazakhstan, Mumbai —
--     Kazakhstan is reported to maintain both a New Delhi embassy and a
--     Mumbai consulate-general for India.
--   - e-Visa holders are reported to be required to arrive via Astana
--     or Almaty International Airport specifically.
--   - Kazakhstan's Work Permit process is a genuine two-step system:
--     an employer-side "Work Permit" (subject to a Labour Market Test
--     that, effective 1 September 2025, requires posting the vacancy on
--     the Electronic Labor Exchange for 15 calendar days) must be
--     secured before the employee applies for the personal C3 visa.
--     The 2026 general foreign-labour quota is reported at 0.25% of
--     Kazakhstan's total labour force, with separate quota bands (0.3%
--     for local-executive-body permits, 2.85% for labour immigrants,
--     2.9% for household employment).
--   - The C2 Dependent/Family-Reunification visa is reported to require
--     the sponsoring relationship to meet specific tests (e.g. a spouse
--     married for at least 1 year; unmarried dependent children,
--     including adult children if still dependent; dependent parents)
--     and can be sponsored either by a Kazakhstani citizen/permanent
--     resident or by a foreigner permanently residing in Kazakhstan.
--   - Business, Conference, and Sports visas are reported to share the
--     same e-Visa category group (B1/B2/B3), covering business
--     meetings, conferences, symposiums, exhibitions, and sporting/
--     cultural events under one overlapping application track —
--     mirrored here in their similar structure.
--
-- country_id 74 = Kazakhstan. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Visa-Free (14 days) / e-Visa (B12)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    74, 1, 'KAZ-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Kazakhstan.',
    'Indian passport holders travel visa-free for up to 14 consecutive days per visit (max 42 days within any rolling 180-day period), under Decree No. 464 of 7 July 2022. For longer or repeat stays, the e-Visa (category B12) is available online for eligible nationalities including India.',
    'Visa-free: up to 14 days/visit (max 42 days per 180 days); e-Visa (B12): reported up to 30 days',
    'Visa-free entry with a passport stamp under 14 days; longer stays need the e-Visa (B12) via the Visa and Migration Portal (vmp.gov.kz)',
    0,
    'e-Visa invitation/approval is reported to average about 5 business days, extendable up to 30 calendar days in some cases',
    'None required for visa-free entry; e-Visa processed online via vmp.gov.kz; Embassy of Kazakhstan, New Delhi handles exceptions',
    'Confirm your trip length — no visa needed if entering and staying under 14 days\nFor longer stays, register on the Visa and Migration Portal (vmp.gov.kz) and apply for the e-Visa (B12)\nPay the consular fee online and print the e-Visa confirmation\nCheck current QazETA registration requirements before departure (pilot as of September 2026)\nArrive via Astana or Almaty International Airport if travelling on the e-Visa',
    '/assets/images/visa-heroes/kazakhstan.webp',
    'Triangulated via WebSearch across visa-agency and immigration-law secondary sources, cross-checked against WebSearch snippets of egov.kz/vmp.gov.kz/mfa.gov.kz pages — direct WebFetch to these official domains was blocked this session',
    'https://www.vmp.gov.kz/en/services/visa-service', '2026-09-17'
);
SET @kaz1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kaz1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz1, 'Core Documents', 'Required from every visa-free or e-Visa traveler.', 1);
SET @kaz1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz1s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@kaz1s1, 'Return or Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2),
(@kaz1s1, 'Proof of Accommodation', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz1, 'e-Visa-Only Documents', 'Only needed if applying for the e-Visa (stays over 14 days).', 2);
SET @kaz1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz1s2, 'e-Visa Application Printout (B12)', NULL, 'copy', 0, 1, 0, 1),
(@kaz1s2, 'Travel Insurance', NULL, 'copy', 0, 1, 0, 2),
(@kaz1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(74, 1, 60.00, 'USD', 'e-Visa (Category B12) Consular Fee', 'Fee applies only if applying for the e-Visa; entry stays under 14 days are visa-free and carry no fee. Figures vary slightly across secondary sources — confirm on vmp.gov.kz before paying.', '2026-09-01', NOW(), 'https://www.vmp.gov.kz/en/services/visa-service', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian tourists need a visa for Kazakhstan?', 'Not for short trips — Indian passport holders can enter visa-free for up to 14 consecutive days per visit (max 42 days within any 180-day period), under a Decree in effect since 7 July 2022. Longer stays need the e-Visa (category B12).', 74, 1, 7400, 1),
('What is QazETA and do I need it as a visa-free Indian traveler?', 'QazETA is Kazakhstan''s new digital entry-authorization platform, launched January 2026 and reported to still be in voluntary pilot mode as of September 2026, with mandatory rollout expected at airports from 1 November 2026. Confirm the current status before travel — it may soon apply even to visa-free entrants.', 74, 1, 7401, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — e-Visa Category B1/B2/B3
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    74, 2, 'KAZ-BUS-IN-02', '2026.09', 'published',
    'Trade negotiations, business meetings, and commercial visits to Kazakhstan.',
    'Indian nationals travelling for business — covered by the e-Visa category group B1/B2/B3, requiring a Kazakhstan-side invitation letter approved through the Migration Service. Short business trips under 14 days may instead qualify for the general visa-free regime.',
    'Single entry up to 90 days (60-day stay); multiple entry up to 180 days (60 days per visit), per secondary reporting',
    'Apply for the e-Visa (B1/B2/B3) via vmp.gov.kz with an approved invitation letter; short (under-14-day) trips may qualify for visa-free entry',
    0,
    'Host-side invitation letter approval by the Migration Service is reported to average about 5 business days, extendable up to 30 calendar days',
    'None required for the e-Visa route (processed on vmp.gov.kz); Embassy of Kazakhstan, New Delhi for in-person or exception cases',
    'Ask your Kazakhstan host company to obtain Migration-Service invitation approval\nRegister on the Visa and Migration Portal (vmp.gov.kz) and apply for the e-Visa (B1/B2/B3)\nPay the consular fee online\nGather your own employer/sponsorship documents\nArrive via Astana or Almaty International Airport',
    '/assets/images/visa-heroes/kazakhstan.webp',
    'Triangulated via WebSearch across visa-agency and immigration-law secondary sources, cross-checked against WebSearch snippets of egov.kz/vmp.gov.kz pages — direct WebFetch to these official domains was blocked this session',
    'https://www.vmp.gov.kz/en/services/visa-service', '2026-09-17'
);
SET @kaz2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kaz2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz2, 'Core Documents', 'Required from every applicant.', 1);
SET @kaz2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kaz2s1, 'Kazakhstan Host-Company Invitation Letter', 'Migration-Service-approved.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @kaz2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz2s2, 'Forwarding/Sponsorship Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@kaz2s2, 'Business Registration Proof', NULL, 'copy', 0, 1, 0, 2),
(@kaz2s2, 'Travel Insurance', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(74, 2, 80.00, 'USD', 'e-Visa (Category B1/B2/B3) Consular Fee', 'Reported figure for the business/conference/sports e-Visa group — confirm on vmp.gov.kz before paying, as amounts can vary by entry type.', '2026-09-01', NOW(), 'https://www.vmp.gov.kz/en/services/visa-service', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travelers always need a visa?', 'Not necessarily — short business trips under 14 days may qualify for Kazakhstan''s general visa-free regime, since short-term business is a named covered purpose. Longer or invitation-based business travel needs the e-Visa (B1/B2/B3).', 74, 2, 7402, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Category C9
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    74, 3, 'KAZ-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Kazakhstani educational institution.',
    'Indian nationals admitted to a Kazakhstani institution, requiring the C9 education-purpose visa. The institution requests a Migration Service invitation letter on the student''s behalf; this category is reported to sit outside the e-Visa system entirely.',
    'Tied to course duration; renewed/extended within Kazakhstan for multi-year programs',
    'Apply in person at the Embassy of Kazakhstan, New Delhi, or the Consulate General, Mumbai — C9 is reported to sit outside the e-Visa system',
    1,
    'University-requested Migration Service invitation letter is reported to take about 14 working days; embassy visa processing then reportedly takes a further 20-30 working days',
    'Embassy of Kazakhstan, New Delhi, or Consulate General of Kazakhstan, Mumbai',
    'Secure admission at a Kazakhstani institution\nHave the institution request a Migration Service invitation letter on your behalf\nPay the university-side migration processing fee (reported at KZT 1,412.5)\nBook an embassy/consulate appointment and gather supporting documents\nSubmit in person, including any required interview, and collect the C9 visa',
    '/assets/images/visa-heroes/kazakhstan.webp',
    'Triangulated via WebSearch across university and immigration-law secondary sources — direct WebFetch to the embassy and egov.kz was blocked this session',
    'https://egov.kz/cms/en/articles/for_foreigners/visa_classification', '2026-09-17'
);
SET @kaz3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kaz3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz3, 'Core Documents', 'Required from every applicant.', 1);
SET @kaz3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kaz3s1, 'Admission Letter from Kazakhstani Institution', NULL, 'original', 1, 0, 1, 2),
(@kaz3s1, 'Migration Service Invitation Letter', 'Requested by the institution on your behalf.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @kaz3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@kaz3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@kaz3s2, 'Health Insurance', NULL, 'original', 1, 0, 0, 3),
(@kaz3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(74, 3, NULL, 'USD', 'Confirmed After Assessment', 'Reported range roughly USD 60-80 for single entry, up to about USD 200 for multi-entry, plus a separate university-side migration processing fee (reported at KZT 1,412.5) — figures vary across sources, contact us to confirm.', '2026-09-01', NOW(), 'https://egov.kz/cms/en/articles/for_foreigners/visa_classification', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for the Kazakhstan student visa online?', 'No — the C9 student visa is reported to fall outside the e-Visa system. Indian applicants must apply in person at the Embassy of Kazakhstan, New Delhi, or the Consulate General of Kazakhstan, Mumbai, after the institution arranges a Migration Service invitation letter.', 74, 3, 7403, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Work Permit + Category C3
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    74, 4, 'KAZ-WORK-IN-04', '2026.09', 'published',
    'Employment with a Kazakhstani employer under a Work Permit and the C3 personal work visa.',
    'Indian nationals with a confirmed job offer. This is a two-step system: the employer must first secure a Work Permit, subject to a Labour Market Test that, effective 1 September 2025, requires posting the vacancy on the Electronic Labor Exchange for 15 calendar days; the employee then applies for the C3 visa. The 2026 general foreign-labour quota is reported at 0.25% of Kazakhstan''s total labour force.',
    'C3 visa reported valid single-entry up to 90 days (sometimes 1 year) or multiple-entry up to 3 years (5 years for AIFC-registered employers)',
    'Employer-driven: the employer secures the Work Permit first, then the applicant applies for the C3 visa at the Embassy of Kazakhstan, New Delhi',
    1,
    'Work Permit stage reported at roughly 1-1.5 months; C3 visa processing then reportedly averages about 10 business days, extendable up to 30 calendar days',
    'Embassy of Kazakhstan, New Delhi',
    'Secure a job offer from a Kazakhstani employer\nEmployer posts the vacancy on the Electronic Labor Exchange for 15 calendar days (Labour Market Test) and applies for the Work Permit\nOnce the Work Permit is granted, apply for the C3 visa at the Embassy of Kazakhstan, New Delhi\nAttend the interview and submit supporting documents\nReceive the C3 visa and travel to Kazakhstan',
    '/assets/images/visa-heroes/kazakhstan.webp',
    'Triangulated via WebSearch across immigration-law firm and Kazakhstani government-notice secondary sources — direct WebFetch to egov.kz and gov.kz was blocked this session',
    'https://egov.kz/cms/en/articles/workpermit', '2026-09-17'
);
SET @kaz4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kaz4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz4, 'Core Documents', 'Required from every applicant.', 1);
SET @kaz4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kaz4s1, 'Employment Contract/Job Offer Letter', NULL, 'copy', 1, 0, 1, 2),
(@kaz4s1, 'Employer''s Work Permit Approval', 'Obtained by the employer via the Electronic Labor Exchange/Labour Market Test process.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @kaz4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@kaz4s2, 'Proof of Financial Means', NULL, 'copy', 1, 0, 0, 2),
(@kaz4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 3),
(@kaz4s2, 'Medical Fitness Certificate', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(74, 4, NULL, 'USD', 'Confirmed After Assessment', 'Fees vary by C3 entry-type tier (single/multiple/AIFC) and by Work Permit category; secondary sources do not consistently publish a single figure — contact us to confirm current amounts.', '2026-09-01', NOW(), 'https://egov.kz/cms/en/articles/workpermit', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Kazakhstan work visa a single application?', 'No — it is genuinely a two-step process. The employer must first secure a Work Permit (including a 15-calendar-day Electronic Labor Exchange vacancy posting since 1 September 2025), and only after that is granted can the employee apply for the personal C3 visa.', 74, 4, 7404, 1),
('Is there a cap on how many foreign workers Kazakhstan allows?', 'Yes — the 2026 general foreign-labour quota is reported at 0.25% of Kazakhstan''s total labour force, with separate bands for local-executive-body permits (0.3%), labour immigrants (2.85%), and household employment (2.9%).', 74, 4, 7405, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Visa-Free / Category B10
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    74, 5, 'KAZ-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or close contacts residing in Kazakhstan.',
    'Private visits are a named covered purpose under Kazakhstan''s 14-day visa-free regime for Indian nationals. Longer stays require the B10 Private Visit Visa, which needs a Migration-Police-endorsed invitation naming the host''s details and residence-permit/passport copy.',
    'Visa-free: up to 14 days/visit (max 42/180 days); B10 visa: single entry up to 90 days, multiple entry reported up to 3 years (90 days/visit)',
    'Visa-free for private visits under 14 days; longer visits need the B10 visa at the Embassy of Kazakhstan, New Delhi, with a host invitation',
    0,
    'Host-side invitation petition is reported to be filed between 5 and 90 days before the visitor''s expected entry date',
    'Embassy of Kazakhstan, New Delhi',
    'Confirm whether a 14-day visa-free visit is enough, or if you need the longer B10 visa\nAsk your host in Kazakhstan to file a Migration-Police-endorsed invitation petition\nGather documents proving the family/personal relationship\nApply for the B10 visa at the Embassy of Kazakhstan, New Delhi, if required\nTravel with your passport, invitation, and relationship proof',
    '/assets/images/visa-heroes/kazakhstan.webp',
    'Triangulated via WebSearch across visa-agency secondary sources, cross-checked against WebSearch snippets of egov.kz invitation-procedure pages — direct WebFetch to egov.kz was blocked this session',
    'https://egov.kz/cms/en/articles/invitation_of_foreigners', '2026-09-17'
);
SET @kaz5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kaz5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz5, 'Core Documents', 'Required from every applicant.', 1);
SET @kaz5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kaz5s1, 'Proof of Relationship to Host', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz5, 'B10 Visa Documents (If Exceeding 14 Days)', 'Only needed for stays beyond the visa-free window.', 2);
SET @kaz5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz5s2, 'Migration-Police-Endorsed Invitation Letter', NULL, 'original', 0, 1, 0, 1),
(@kaz5s2, 'Host''s Residence Permit/Passport Copy (Notarised)', NULL, 'copy', 0, 1, 0, 2),
(@kaz5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(74, 5, NULL, 'USD', 'Confirmed After Assessment', 'Visa-free visits under 14 days carry no fee. The B10 visa fee is not consistently published across sources but is reported comparable to the roughly USD 60 single-entry consular fee for other short-stay categories — confirm directly with the embassy.', '2026-09-01', NOW(), 'https://egov.kz/cms/en/articles/invitation_of_foreigners', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to visit family in Kazakhstan for two weeks?', 'No — private visits are a named covered purpose under the 14-day visa-free regime for Indian passport holders, so a two-week family visit generally needs no visa at all, just your passport.', 74, 5, 7406, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Category B13 / India-Specific Free Regime
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    74, 6, 'KAZ-TRAN-IN-06', '2026.09', 'published',
    'Passing through Kazakhstan (commonly Almaty or Astana) en route to a third country.',
    'Kazakhstan''s Ministry of Foreign Affairs names a dedicated Transit Visa-Free Regime specifically for Indian passport holders, distinct from the general 14-day visa-free rule. Purely airside transit needs no visa; the B13 Transit Visa applies only if leaving the transit zone or exceeding the typical connection window.',
    'Airside transit: visa-free; B13 visa (if required): reported up to 5 days per entry',
    'No visa needed for airside-only transit; if a B13 visa is genuinely required, apply at the Embassy of Kazakhstan, New Delhi, with your onward ticket',
    0,
    'Secondary sourcing reports no consular fee charged to Indian nationals under this transit regime',
    'Embassy of Kazakhstan, New Delhi',
    'Confirm whether your connection stays airside (no visa needed) or requires leaving the transit zone\nIf a B13 visa is required, gather your onward flight ticket and next destination''s visa (if applicable)\nApply at the Embassy of Kazakhstan, New Delhi, if needed\nCheck current QazETA requirements before departure',
    '/assets/images/visa-heroes/kazakhstan.webp',
    'Triangulated via WebSearch, including a snippet of the Kazakhstan MFA New Delhi embassy page explicitly titled "Transit Visa-Free Regime for Indian Passport Holders" — direct WebFetch to mfa.gov.kz was blocked this session',
    'http://mfa.gov.kz/en/delhi/content-view/transit-visa-free-regime-for-indian-passport-holders', '2026-09-17'
);
SET @kaz6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kaz6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz6, 'Core Documents', 'Required if leaving the transit zone or if immigration requests proof.', 1);
SET @kaz6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kaz6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz6, 'B13 Visa Documents (If Genuinely Required)', 'Only if your itinerary requires leaving the transit zone.', 2);
SET @kaz6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(74, 6, 0.00, 'USD', 'Transit Visa Fee — Reported Free for Indian Nationals', 'Secondary sourcing reports no fee charged to Indian citizens under Kazakhstan''s India-specific transit visa-free regime; confirm with the embassy if your specific itinerary requires the B13 visa.', '2026-09-01', NOW(), 'http://mfa.gov.kz/en/delhi/content-view/transit-visa-free-regime-for-indian-passport-holders', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a special transit rule just for Indian travelers?', 'Yes — Kazakhstan''s Ministry of Foreign Affairs names a dedicated "Transit Visa-Free Regime for Indian Passport Holders," separate from the general 14-day visa-free rule, reported to carry no consular fee.', 74, 6, 7407, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — e-Visa Category C12
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    74, 7, 'KAZ-MED-IN-07', '2026.09', 'published',
    'Travel to Kazakhstan for medical treatment, examination, or consultation.',
    'Indian nationals travelling for treatment — covered by e-Visa category C12, requiring an invitation from a Kazakhstan-licensed medical institution. Also covers accompanying persons and those visiting a close relative under treatment in Kazakhstan.',
    'Reported up to 180 days, single or multiple entry',
    'Apply for the e-Visa (C12) via vmp.gov.kz with an invitation from a Kazakhstan-licensed medical institution; arrive via Astana or Almaty airport',
    0,
    'The treating institution''s invitation is reported to take about 5 business days to issue',
    'None required for the e-Visa route (processed on vmp.gov.kz); Embassy of Kazakhstan, New Delhi for in-person or exception cases',
    'Obtain an invitation from a Kazakhstan-licensed medical institution\nRegister on the Visa and Migration Portal (vmp.gov.kz) and apply for the e-Visa (C12)\nPay the consular fee online\nArrange travel insurance and gather medical records\nArrive via Astana or Almaty International Airport',
    '/assets/images/visa-heroes/kazakhstan.webp',
    'Triangulated via WebSearch across visa-agency and immigration-law secondary sources, cross-checked against WebSearch snippets of egov.kz visa-classification pages — direct WebFetch to egov.kz was blocked this session',
    'https://www.vmp.gov.kz/en/services/visa-service', '2026-09-17'
);
SET @kaz7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kaz7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz7, 'Core Documents', 'Required from every applicant.', 1);
SET @kaz7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kaz7s1, 'Invitation from Kazakhstan-Licensed Medical Institution', NULL, 'original', 1, 0, 1, 2),
(@kaz7s1, 'Travel Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @kaz7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@kaz7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2),
(@kaz7s2, 'Accompanying-Person Relationship Proof', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(74, 7, 80.00, 'USD', 'e-Visa (Category C12) Consular Fee', 'Reported figure for medical/treatment e-Visas — confirm on vmp.gov.kz before paying.', '2026-09-01', NOW(), 'https://www.vmp.gov.kz/en/services/visa-service', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Which airport should I use for a Kazakhstan medical e-Visa?', 'e-Visa holders, including the C12 medical category, are reported to be required to arrive via Astana or Almaty International Airport specifically — confirm this applies to your treating institution''s location before booking.', 74, 7, 7408, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — e-Visa Category B1/B2/B3
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    74, 8, 'KAZ-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, symposiums, forums, and exhibitions in Kazakhstan.',
    'Indian nationals attending a conference — reported to share the same e-Visa category group (B1/B2/B3) as Business and Sports events. An invitation letter approved through the Migration Service is required, especially for multi-entry visas or stays beyond 30 days.',
    'Single entry up to 90 days (60-day stay); multiple entry up to 180 days (60 days per visit), per secondary reporting',
    'Apply for the e-Visa (B1/B2/B3) online via vmp.gov.kz using a conference invitation/registration confirmation approved through the Migration Service',
    0,
    'Host-side invitation letter approval by the Migration Service is reported to average about 5 business days, extendable up to 30 calendar days',
    'None required for the e-Visa route (processed on vmp.gov.kz); Embassy of Kazakhstan, New Delhi for in-person or exception cases',
    'Obtain a conference invitation/registration confirmation, Migration-Service-approved\nRegister on the Visa and Migration Portal (vmp.gov.kz) and apply for the e-Visa (B1/B2/B3)\nPay the consular fee online\nGather proof of accommodation and return travel\nArrive via Astana or Almaty International Airport',
    '/assets/images/visa-heroes/kazakhstan.webp',
    'Triangulated via WebSearch across the reported bundled B1/B2/B3 Business/Conference/Sports e-Visa category — direct WebFetch to egov.kz and vmp.gov.kz was blocked this session',
    'https://www.vmp.gov.kz/en/services/visa-service', '2026-09-17'
);
SET @kaz8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kaz8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz8, 'Core Documents', 'Required from every applicant.', 1);
SET @kaz8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kaz8s1, 'Conference Invitation/Registration Confirmation', 'Migration-Service-approved.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @kaz8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@kaz8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(74, 8, 80.00, 'USD', 'e-Visa (Category B1/B2/B3) Consular Fee', 'Reported figure for the business/conference/sports e-Visa group — confirm on vmp.gov.kz before paying.', '2026-09-01', NOW(), 'https://www.vmp.gov.kz/en/services/visa-service', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Conference and Business visas share the same category?', 'Yes — secondary reporting indicates Kazakhstan bundles Business, Conference, and Sports purposes under the same e-Visa category group (B1/B2/B3), so requirements are similar across these purposes.', 74, 8, 7409, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — e-Visa Category B1/B2/B3
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    74, 9, 'KAZ-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Kazakhstan.',
    'Indian nationals competing or officiating — reported to share the same e-Visa category group (B1/B2/B3) as Business and Conference purposes. A host-event invitation letter, Migration-Service-approved, is required alongside proof of the sporting purpose.',
    'Single entry up to 90 days (60-day stay); multiple entry up to 180 days (60 days per visit), per secondary reporting',
    'Apply for the e-Visa (B1/B2/B3) online via vmp.gov.kz using a Migration-Service-approved invitation from the host event organizer',
    0,
    'Host-side invitation letter approval by the Migration Service is reported to average about 5 business days, extendable up to 30 calendar days',
    'None required for the e-Visa route (processed on vmp.gov.kz); Embassy of Kazakhstan, New Delhi for in-person or exception cases',
    'Obtain a letter from your home-country sports association confirming your role\nObtain a Migration-Service-approved invitation from the host event organizer\nRegister on the Visa and Migration Portal (vmp.gov.kz) and apply for the e-Visa (B1/B2/B3)\nPay the consular fee online\nArrive via Astana or Almaty International Airport',
    '/assets/images/visa-heroes/kazakhstan.webp',
    'Triangulated via WebSearch across the reported bundled B1/B2/B3 Business/Conference/Sports e-Visa category — direct WebFetch to egov.kz and vmp.gov.kz was blocked this session',
    'https://www.vmp.gov.kz/en/services/visa-service', '2026-09-17'
);
SET @kaz9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kaz9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz9, 'Core Documents', 'Required from every applicant.', 1);
SET @kaz9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kaz9s1, 'Home-Country Sports Association Letter', 'Confirms role and no-employment status.', 'original', 1, 0, 1, 2),
(@kaz9s1, 'Host Event Organizer Invitation Letter', 'Migration-Service-approved.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @kaz9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(74, 9, 80.00, 'USD', 'e-Visa (Category B1/B2/B3) Consular Fee', 'Reported figure for the business/conference/sports e-Visa group — confirm on vmp.gov.kz before paying.', '2026-09-01', NOW(), 'https://www.vmp.gov.kz/en/services/visa-service', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do athletes need a separate visa category from business travelers?', 'Not by category — sporting events reportedly fall under the same e-Visa group (B1/B2/B3) as Business and Conference visas, though you will still need a distinct host-event invitation and, typically, a home-association letter.', 74, 9, 7410, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification, Category C2
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    74, 10, 'KAZ-DEP-IN-10', '2026.09', 'published',
    'Spouse, dependent children, or dependent parents joining a family member residing long-term in Kazakhstan.',
    'Category C2 family reunification. Eligible relations reported to include a spouse married at least 1 year, unmarried dependent children (including adult children if still dependent), and dependent parents. The sponsor may be a Kazakhstani citizen/permanent resident or a foreigner permanently residing in Kazakhstan (e.g. a C3 work-visa holder who has settled there).',
    'Single entry up to 90 days; multiple entry reported up to 1 year',
    'Apply in person at the Embassy of Kazakhstan, New Delhi, with a Migration-Service-endorsed sponsor invitation — C2 sits outside the e-Visa system',
    1,
    'Sponsor-side invitation and Migration Service processing is reported to take several weeks; confirm current timelines directly with the embassy',
    'Embassy of Kazakhstan, New Delhi',
    'Confirm the sponsor''s status qualifies (citizen, permanent resident, or long-term-resident foreigner)\nGather relationship proof (marriage/birth certificates) and the sponsor''s residence documents\nHave the sponsor file a Migration-Service-endorsed invitation\nBook an embassy appointment and submit in person\nCollect the C2 visa and register in Kazakhstan on arrival if required',
    '/assets/images/visa-heroes/kazakhstan.webp',
    'Triangulated via WebSearch across immigration-law secondary sources on the C2 family-reunification category — direct WebFetch to egov.kz was blocked this session',
    'https://egov.kz/cms/en/articles/for_foreigners/visa_classification', '2026-09-17'
);
SET @kaz10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kaz10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz10, 'Core Documents', 'Required from every applicant.', 1);
SET @kaz10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kaz10s1, 'Proof of Relationship to Sponsor', 'Marriage or birth certificate.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kaz10, 'Supporting Documents', 'Evidence tied to the sponsor''s status.', 2);
SET @kaz10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kaz10s2, 'Sponsor''s Residence Permit/C3 Work Visa Copy', NULL, 'copy', 1, 0, 0, 1),
(@kaz10s2, 'Migration-Service-Endorsed Invitation', NULL, 'original', 1, 0, 0, 2),
(@kaz10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(74, 10, NULL, 'USD', 'Confirmed After Assessment', 'C2 fees vary by single-entry (90-day) vs multiple-entry (up to 1 year) tiers; secondary sources do not consistently publish a single figure — contact us to confirm.', '2026-09-01', NOW(), 'https://egov.kz/cms/en/articles/for_foreigners/visa_classification', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can any Kazakhstan work-visa holder sponsor family reunification?', 'Reported eligibility centers on Kazakhstani citizens/permanent residents and foreigners permanently residing in Kazakhstan — a C3 work-visa holder still on a short-term entry is unlikely to qualify as sponsor until their residence status is more settled. Confirm your specific case with the embassy.', 74, 10, 7411, 1),
('Does the spouse need to have been married for a minimum period?', 'Yes — secondary sourcing reports a minimum marriage duration of at least 1 year for a spouse to qualify under the C2 family-reunification category.', 74, 10, 7412, 1);
