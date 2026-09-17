-- Lithuania Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search (WebSearch tool). WebFetch to the
-- Lithuanian Embassy in India (in.mfa.lt) was blocked by the network
-- egress proxy, so all findings are triangulated from VFS Global's own
-- India one-pager, workinlithuania.com, migration.lt, micenter.lt,
-- Fragomen/Newland Chase immigration-advisory reporting, and
-- visa-agency secondary sourcing (BTW, Y-Axis, OneVasco, Studee).
-- Fee figures vary across sources and are flagged approximate where
-- this happened. No statistics, dates, or URLs below were invented.
--
-- Lithuania's real, distinctive facts verified this session:
--   - Lithuania is a full Schengen member; Tourist, Business, Transit
--     (Airport Type A), Conference, Sports, and Medical purposes all
--     use the standard Schengen C-type visa (~EUR 90 fee + ~EUR 17.90
--     VFS Global service charge), applied for via VFS Global centres
--     in India on behalf of the Embassy of Lithuania, New Delhi.
--   - MOST DISTINCTIVE 2025-2026 FINDING: multiple secondary sources
--     report that VFS Global service centres in India (along with the
--     UAE, Jordan, Lebanon, Sri Lanka, and Nepal) STOPPED accepting
--     visa applications filed for employment purposes at some point in
--     2025-2026. This is reflected in the Work visa's application_method
--     field below (route via employer/MIGRIS + direct embassy contact,
--     not VFS) — flag this for a follow-up confirmation call to the
--     Embassy of Lithuania, New Delhi, as it could not be independently
--     re-verified against a primary government source this session.
--   - Lithuania runs an annual, hard-capped work-permit quota for
--     non-highly-qualified third-country nationals — reduced to 24,830
--     for 2025 and reported at roughly 24,706 for 2026, with foreign
--     workers statutorily capped at 1.4% of Lithuania's population.
--     Highly Qualified Professionals (broadly, EU Blue Card-track roles)
--     are exempt from the quota entirely.
--   - A national Shortage Occupation List (updated every January; ~110
--     roles for 2026, spanning IT, construction, manufacturing, and
--     healthcare) lets employers skip the standard local job-posting
--     requirement, and lets the applicant qualify as a Highly Qualified
--     Professional at a lower salary threshold (1.2x national average
--     wage, ~EUR 2,416.56) instead of the standard 1.5x (~EUR 3,020.70).
--   - Work-permit and EU Blue Card applications route through MIGRIS
--     (the Migration Department's online e-service system), not VFS —
--     the employer files a Mediation Letter, then the applicant submits
--     biometrics and original documents in person within 4 months.
--   - Family reunification sponsors must generally have held a
--     Lithuanian residence permit for at least 2 years before they can
--     sponsor a spouse/dependent, and processing is reported at up to
--     2-4 months (far longer than short-stay Schengen processing).
--   - Student (National D) visa applicants must show funds equal to at
--     least 1 Lithuanian minimum monthly wage (reported at EUR 1,153 for
--     2026) per month of stay, plus return-journey funds of one more
--     minimum wage, and Schengen-compliant medical insurance of at
--     least EUR 30,000 cover.
--
-- country_id 130 = Lithuania. visa_type_id: 1=Tourist, 2=Business,
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
    130, 1, 'LTU-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Lithuania.',
    'Indian passport holders — the standard Schengen C-type visa, applied for via VFS Global, valid for travel across the wider Schengen area, not just Lithuania.',
    'Single or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global centres in India on behalf of the Embassy of Lithuania, New Delhi',
    1,
    'Standard Schengen processing is typically reported at 10-15 working days, extending to 30-45 days for complex cases',
    'Embassy of the Republic of Lithuania, New Delhi, via VFS Global centres',
    'Book a VFS Global appointment\nComplete the online Schengen visa application form\nGather supporting documents\nAttend the appointment and submit biometrics (mandatory for first-time applicants)\nTrack status and collect your passport',
    '/assets/images/visa-heroes/lithuania.webp',
    'Cross-checked against VFS Global''s India one-pager and visa-agency secondary sourcing; the Embassy of Lithuania''s in.mfa.lt site was not directly fetchable this session (network egress blocked)', 'https://visa.vfsglobal.com/one-pager/lithuania/india/english/', '2026-09-17'
);
SET @ltu1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ltu1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu1, 'Core Documents', 'Required from every applicant.', 1);
SET @ltu1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu1s1, 'Valid Passport (3+ Months Beyond Intended Stay)', 'Must have at least 2 blank visa pages.', 'original', 1, 0, 1, 1),
(@ltu1s1, 'Completed Schengen Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@ltu1s1, 'Travel/Schengen Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @ltu1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu1s2, 'Confirmed Hotel Booking', NULL, 'copy', 1, 0, 0, 1),
(@ltu1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@ltu1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(130, 1, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Plus a separate VFS Global service charge reported at roughly €17.90. Reduced fee of €45 reported for children 6-12; children under 6 exempt.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/one-pager/lithuania/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a Lithuania Tourist visa let me travel elsewhere in Europe?', 'Yes — the Schengen C-type visa is valid for travel across the entire Schengen area, not just Lithuania, subject to the standard 90-days-in-180 rule.', 130, 1, 13000, 1),
('Is the VFS Global service charge included in the €90 visa fee?', 'No — secondary sourcing reports a separate VFS Global service charge of roughly €17.90 on top of the standard €90 Schengen fee. Confirm the exact current charge at your VFS appointment.', 130, 1, 13001, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    130, 2, 'LTU-BUS-IN-02', '2026.09', 'published',
    'Trade, negotiations, and commercial meetings in Lithuania.',
    'Indian nationals travelling for business — the same Schengen C-type visa as Tourist, with a company invitation letter and proof of your own employment as the differentiating documents.',
    'Single, double, or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global with a business invitation letter and Indian employer sponsorship letter',
    1,
    'Standard Schengen processing is typically reported at 10-15 working days',
    'Embassy of the Republic of Lithuania, New Delhi, via VFS Global centres',
    'Obtain an invitation letter from the Lithuanian host company\nGather forwarding letter from your Indian employer\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/lithuania.webp',
    'Cross-checked against VFS Global''s India one-pager and visa-agency secondary sourcing, triangulated against sources not directly fetchable this session', 'https://visa.vfsglobal.com/one-pager/lithuania/india/english/', '2026-09-17'
);
SET @ltu2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ltu2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu2, 'Core Documents', 'Required from every applicant.', 1);
SET @ltu2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ltu2s1, 'Invitation Letter from Lithuanian Host Company', NULL, 'original', 1, 0, 1, 2),
(@ltu2s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @ltu2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@ltu2s2, 'Business Registration Proof', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(130, 2, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge (~€17.90).', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/one-pager/lithuania/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I attend a business meeting in Lithuania without an invitation letter?', 'It is strongly recommended to have one — VFS Global and embassy guidance both list an invitation letter from the Lithuanian host company as a core Business-visa document.', 130, 2, 13002, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — National Visa D (Long-Stay)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    130, 3, 'LTU-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Lithuanian university or higher-education institution.',
    'Indian nationals admitted to a recognized Lithuanian institution for a course longer than 90 days, requiring the National Visa D, generally followed by a temporary residence permit for multi-year programs.',
    'Up to 1 year on the D-visa/initial permit, renewable for the program duration',
    'Apply in person at the Embassy of the Republic of Lithuania, New Delhi (or the Lithuanian Consulate in Mumbai, per some sources)',
    1,
    'National Visa D applications are reported to take longer than the standard Schengen C-type window; confirm current timelines with the embassy',
    'Embassy of the Republic of Lithuania, New Delhi',
    'Secure admission at a recognized Lithuanian institution\nGather proof of funds and Schengen-compliant health insurance\nBook an embassy appointment\nSubmit in person, including biometrics\nCollect the visa and travel; apply for a temporary residence permit in Lithuania if the program exceeds 1 year',
    '/assets/images/visa-heroes/lithuania.webp',
    'Cross-checked against leverageedu.com, studee.com, and visa-agency secondary sourcing on the National Visa D student route; the Embassy of Lithuania''s own fee page could not be directly fetched this session', 'https://micenter.lt/en/visa-d', '2026-09-17'
);
SET @ltu3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ltu3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu3, 'Core Documents', 'Required from every applicant.', 1);
SET @ltu3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu3s1, 'Valid Passport (2+ Blank Visa Pages)', NULL, 'original', 1, 0, 1, 1),
(@ltu3s1, 'Admission Letter from Lithuanian Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @ltu3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@ltu3s2, 'Proof of Funds (1 Minimum Monthly Wage per Month of Stay, Plus Return Funds)', 'Reported at €1,153/month for 2026; confirm the current figure.', 'copy', 1, 0, 0, 2),
(@ltu3s2, 'Health Insurance Valid in Lithuania (Min. €30,000 Cover)', NULL, 'original', 1, 0, 0, 3),
(@ltu3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(130, 3, NULL, 'EUR', 'Confirmed After Assessment', 'Sources vary: the National Visa D fee is reported at either €140 (VFS Global one-pager) or €120 plus a further €120 residence-permit fee for longer programs. A standard VFS/consular service fee of roughly €17.90-€33.80 may also apply. Confirm the exact current figure with the embassy.', '2026-09-01', NOW(), 'https://micenter.lt/en/visa-d', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How much money do I need to show for a Lithuania Student visa?', 'Reported guidance requires funds equal to at least one Lithuanian minimum monthly wage (around €1,153 for 2026) for each month of your planned stay, plus a further one month''s wage in return-journey funds — confirm the current minimum wage figure before applying.', 130, 3, 13003, 1),
('Can international students work while studying in Lithuania?', 'Secondary sourcing indicates Student visa/residence-permit holders are generally permitted limited part-time work; confirm the current weekly-hours limit and any registration steps with the Migration Department.', 130, 3, 13004, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — National Visa D / Work Permit / EU Blue Card
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    130, 4, 'LTU-WORK-IN-04', '2026.09', 'published',
    'Employment with a Lithuanian employer, via a standard Work Permit, National Visa D, or the EU Blue Card for Highly Qualified Professionals.',
    'Indian nationals with a confirmed job offer. Non-HQP roles fall under Lithuania''s annual capped work-permit quota (~24,706 for 2026); Highly Qualified Professionals and roles on the Shortage Occupation List (~110 roles for 2026) are quota-exempt or fast-tracked, and may qualify at a lower salary threshold (1.2x vs. the standard 1.5x national average wage).',
    'Work permit/D-visa typically up to 1-2 years initially, renewable; EU Blue Card longer-term',
    'Employer files via MIGRIS; VFS centres in India reportedly stopped taking employment-visa filings in 2025-2026 — confirm with the embassy',
    1,
    'Reported realistic timeline of 8-14 weeks from signed job offer to start date, assuming no quota bottleneck and a complete first submission; EU Blue Card processing reported at 1-2 months once filed',
    'Migration Department (MIGRIS) for the permit; Embassy of the Republic of Lithuania, New Delhi, for the visa/biometrics stage',
    'Secure a job offer from a Lithuanian employer\nEmployer checks Shortage Occupation List eligibility and files a Mediation Letter via MIGRIS\nEmployer completes any required local job-posting/labour-market test (unless exempt)\nApplicant submits biometrics and original documents in person within 4 months of the MIGRIS application\nCollect the National Visa D/residence permit and travel',
    '/assets/images/visa-heroes/lithuania.webp',
    'Cross-checked against workinlithuania.com, migration.lt, and Fragomen/Newland Chase advisory reporting on 2025-2026 quota changes; the VFS employment-visa-suspension claim is secondary sourcing, NOT confirmed against a primary government source', 'https://workinlithuania.com/blog/lithuania-work-permit/', '2026-09-17'
);
SET @ltu4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ltu4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu4, 'Core Documents', 'Required from every applicant.', 1);
SET @ltu4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ltu4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@ltu4s1, 'Employer Mediation Letter (Filed via MIGRIS)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @ltu4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu4s2, 'Academic/Professional Certificates (Apostilled)', NULL, 'copy', 1, 0, 0, 1),
(@ltu4s2, 'Proof of Salary Meeting Threshold (1.2x or 1.5x National Average Wage)', 'Lower threshold applies to Shortage-Occupation-List and HQP roles.', 'copy', 1, 0, 0, 2),
(@ltu4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 3),
(@ltu4s2, 'Local Job-Posting/Labour-Market-Test Confirmation', 'Not required for Shortage Occupation List roles.', 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(130, 4, NULL, 'EUR', 'Confirmed After Assessment', 'National Visa D fee reported around €120-€140 plus a residence-permit fee reported around €120; EU Blue Card fees are reported separately. Figures vary across sources — contact us to confirm the current fee for your specific route.', '2026-09-01', NOW(), 'https://workinlithuania.com/blog/lithuania-work-permit/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a cap on how many Indian workers Lithuania can hire each year?', 'Yes for non-Highly-Qualified roles — Lithuania runs an annual capped work-permit quota (reported at roughly 24,706 for 2026, down from prior years), with foreign workers statutorily limited to 1.4% of the population. Highly Qualified Professionals and Shortage Occupation List roles are quota-exempt or prioritized.', 130, 4, 13005, 1),
('Can I still apply for a Lithuania work visa through VFS Global in India?', 'Secondary sourcing reports that VFS Global centres in India stopped accepting employment-purpose visa applications for Lithuania during 2025-2026, with applications instead routed through the employer via MIGRIS and the Embassy directly. This could not be independently confirmed against a primary government source this session — verify the current channel before starting your application.', 130, 4, 13006, 1),
('What is the Shortage Occupation List and how does it help?', 'It is an annually updated list (around 110 roles for 2026, spanning IT, construction, manufacturing, and healthcare) that lets employers skip the standard local job-posting requirement and lets applicants qualify as Highly Qualified Professionals at a lower salary threshold (1.2x vs. 1.5x the national average wage).', 130, 4, 13007, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    130, 5, 'LTU-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Lithuania.',
    'Indian nationals with family/friends in Lithuania — the same Schengen C-type visa as Tourist, requiring an invitation letter plus proof of the relationship.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with an invitation letter and relationship proof',
    1,
    'Standard Schengen processing is typically reported at 10-15 working days',
    'Embassy of the Republic of Lithuania, New Delhi, via VFS Global centres',
    'Obtain an invitation letter from your host in Lithuania\nGather documents proving the family relationship\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/lithuania.webp',
    'Cross-checked against VFS Global''s India one-pager and visa-agency secondary sourcing, triangulated against sources not directly fetchable this session', 'https://visa.vfsglobal.com/one-pager/lithuania/india/english/', '2026-09-17'
);
SET @ltu5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ltu5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu5, 'Core Documents', 'Required from every applicant.', 1);
SET @ltu5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ltu5s1, 'Invitation Letter from Host in Lithuania', NULL, 'original', 1, 0, 1, 2),
(@ltu5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @ltu5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@ltu5s2, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(130, 5, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge (~€17.90).', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/one-pager/lithuania/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need proof of relationship for a Family Visit visa, and what counts?', 'Yes — documents such as marriage or birth certificates showing your relationship to the host in Lithuania are expected alongside the invitation letter.', 130, 5, 13008, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Airport Transit Type A
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    130, 6, 'LTU-TRAN-IN-06', '2026.09', 'published',
    'Passing through a Lithuanian airport (e.g. Vilnius) airside-to-airside toward a non-Schengen destination.',
    'Indian nationals are not on the EU''s list of nationalities requiring a mandatory Airport Transit Visa for the Schengen area by default, but should confirm current requirements — a distinct Type A visa is only needed if leaving the international transit zone, not for a purely airside connection.',
    'Valid for the transit window; issued for up to 6 months, 1 or 2 entries where required',
    'Apply via VFS Global with your itinerary/onward ticket, only if a transit visa is genuinely required for your connection',
    1,
    'Standard Schengen-adjacent processing reported at around 10-15 working days',
    'Embassy of the Republic of Lithuania, New Delhi, via VFS Global centres',
    'Confirm whether your specific connection requires a visa (check both Lithuania''s and any connecting Schengen country''s rules)\nIf required, apply via VFS Global with onward ticket and itinerary\nSubmit biometrics if required',
    '/assets/images/visa-heroes/lithuania.webp',
    'Cross-checked against general Schengen Airport Transit Visa rules and VFS Global secondary sourcing; Lithuania-specific transit fee could not be independently confirmed this session', 'https://visa.vfsglobal.com/one-pager/lithuania/india/english/', '2026-09-17'
);
SET @ltu6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ltu6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu6, 'Core Documents', 'Required if a Type A visa is genuinely needed.', 1);
SET @ltu6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ltu6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @ltu6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(130, 6, NULL, 'EUR', 'Confirmed After Assessment', 'Not independently confirmed this session — likely at or below the standard €90 Schengen C-visa fee if a transit visa is genuinely required; verify before applying.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/one-pager/lithuania/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian passport holders always need an Airport Transit Visa for Lithuania?', 'Not necessarily — Indian nationals are not automatically on the EU''s list of nationalities requiring a mandatory Schengen Airport Transit Visa, but requirements can depend on your full itinerary. Confirm your specific case before travel.', 130, 6, 13009, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    130, 7, 'LTU-MED-IN-07', '2026.09', 'published',
    'Travel to Lithuania for medical treatment.',
    'Indian nationals travelling for treatment — the same Schengen C-type visa as Tourist, requiring a certificate from the treating doctor/institution confirming the need for specific treatment.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with the medical certificate and Schengen-compliant insurance',
    1,
    'Standard Schengen processing is typically reported at 10-15 working days, can extend if documentation is incomplete',
    'Embassy of the Republic of Lithuania, New Delhi, via VFS Global centres',
    'Obtain a certificate from the treating Lithuanian doctor/institution\nArrange Schengen-compliant travel insurance (min. €30,000 cover)\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/lithuania.webp',
    'Cross-checked against VFS Global''s India one-pager and standard Schengen medical-visa requirements, triangulated against sources not directly fetchable this session', 'https://visa.vfsglobal.com/one-pager/lithuania/india/english/', '2026-09-17'
);
SET @ltu7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ltu7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu7, 'Core Documents', 'Required from every applicant.', 1);
SET @ltu7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ltu7s1, 'Medical Certificate/Institution Confirmation', NULL, 'original', 1, 0, 1, 2),
(@ltu7s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @ltu7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@ltu7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(130, 7, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge (~€17.90).', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/one-pager/lithuania/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a fee waiver for medical treatment visas to Lithuania?', 'Not independently confirmed this session — the standard €90 Schengen fee is assumed to apply unless the treating institution or embassy confirms an exemption for your specific case.', 130, 7, 13010, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    130, 8, 'LTU-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade fairs in Lithuania.',
    'Indian nationals attending a conference — the same Schengen C-type visa as Tourist, requiring a conference invitation/registration confirmation from the Lithuanian host organization.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a conference invitation/registration confirmation',
    1,
    'Standard Schengen processing is typically reported at 10-15 working days',
    'Embassy of the Republic of Lithuania, New Delhi, via VFS Global centres',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/lithuania.webp',
    'Cross-checked against VFS Global''s India one-pager and standard Schengen business/conference documentary requirements, triangulated against sources not directly fetchable this session', 'https://visa.vfsglobal.com/one-pager/lithuania/india/english/', '2026-09-17'
);
SET @ltu8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ltu8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu8, 'Core Documents', 'Required from every applicant.', 1);
SET @ltu8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ltu8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @ltu8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@ltu8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(130, 8, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge (~€17.90).', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/one-pager/lithuania/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Conference visa different from a Business visa for Lithuania?', 'Both use the same Schengen C-type visa framework; the main difference is the supporting document — a conference invitation/registration confirmation rather than a company business-meeting invitation.', 130, 8, 13011, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    130, 9, 'LTU-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Lithuania.',
    'Indian nationals competing or officiating — the same Schengen C-type visa as Tourist/Conference, generally requiring a letter from the home-country sports association and an invitation from the host event organizer.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a home-association letter and host-organizer invitation',
    1,
    'Standard Schengen processing is typically reported at 10-15 working days',
    'Embassy of the Republic of Lithuania, New Delhi, via VFS Global centres',
    'Obtain a letter from your resident-country athletic association confirming your role and no-employment status\nObtain an invitation letter from the host event organizer with event details and expense arrangements\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/lithuania.webp',
    'Cross-checked against VFS Global''s India one-pager and standard Schengen sport-event documentary requirements, triangulated against sources not directly fetchable this session', 'https://visa.vfsglobal.com/one-pager/lithuania/india/english/', '2026-09-17'
);
SET @ltu9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ltu9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu9, 'Core Documents', 'Required from every applicant.', 1);
SET @ltu9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ltu9s1, 'Home-Country Sports Association Letter', 'Confirms role and no-employment status.', 'original', 1, 0, 1, 2),
(@ltu9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @ltu9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(130, 9, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge (~€17.90).', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/one-pager/lithuania/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a letter from my sports association even as a support-staff member?', 'Yes, generally — a letter confirming your role (athlete, coach, or support staff) and no-employment status is expected alongside the host organizer''s invitation letter.', 130, 9, 13012, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification Residence Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    130, 10, 'LTU-DEP-IN-10', '2026.09', 'published',
    'Spouse, minor children, or dependent parents joining an Indian national holding a Lithuanian residence permit, Work Permit, or EU Blue Card.',
    'Family members of an Indian national holding a qualifying Lithuanian residence permit. The sponsor generally must have legally resided in Lithuania for at least 2 years, hold a permit valid for at least 1 more year, and show reasonable prospects of permanent residence.',
    'Tied to the sponsor''s permit validity; typically 1-2 years initially, renewable',
    'Apply at a Migration Service office in Lithuania, or at the Embassy of the Republic of Lithuania, New Delhi',
    1,
    'Reported at up to 2 months on an urgent basis, or up to 4 months under the usual procedure — notably longer than short-stay Schengen processing',
    'Migration Department (via Migration Service or the Embassy of the Republic of Lithuania, New Delhi)',
    'Confirm the sponsor meets the 2-year prior-residence and remaining-permit-validity requirements\nGather relationship proof (marriage/birth certificates) and the sponsor''s permit copy\nSubmit the application at a Migration Service office or the Embassy\nWait through the 2-4 month processing window\nCollect the visa/residence permit and register in Lithuania',
    '/assets/images/visa-heroes/lithuania.webp',
    'Cross-checked against migration.lt, micenter.lt, and EU Migration and Home Affairs portal guidance on Lithuanian family reunification, triangulated against sources not directly fetchable this session', 'https://www.migration.lt/a-residence-permit-for-an-alien-whose-spouse-is-a-citizen-of-lithuania-that-lives-in-lithuania', '2026-09-17'
);
SET @ltu10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ltu10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu10, 'Core Documents', 'Required from every applicant.', 1);
SET @ltu10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ltu10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ltu10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @ltu10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ltu10s2, 'Sponsor''s Residence Permit/Work Permit/EU Blue Card Copy', NULL, 'copy', 1, 0, 0, 1),
(@ltu10s2, 'Proof of Funds/Sponsor Income', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(130, 10, NULL, 'EUR', 'Confirmed After Assessment', 'Residence-permit fees reported around €120 in adjacent Lithuanian permit categories, but a family-reunification-specific figure was not independently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.migration.lt/a-residence-permit-for-an-alien-whose-spouse-is-a-citizen-of-lithuania-that-lives-in-lithuania', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How long must my sponsor have lived in Lithuania before I can join them?', 'Guidance reports the sponsor must have legally resided in Lithuania for at least 2 years, hold a residence permit valid for at least 1 more year, and show reasonable prospects of acquiring permanent residence — confirm the current requirement for your sponsor''s specific permit type.', 130, 10, 13013, 1),
('Can I stay in Lithuania as long as my sponsoring family member does?', 'Generally yes — EU family-reunification guidance indicates you may remain as long as your sponsor remains in Lithuania, unless you obtain a residence permit on other grounds.', 130, 10, 13014, 1);
