-- Luxembourg Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url left NULL at authoring
-- time (no photo bundle supplied yet).
--
-- IMPORTANT SOURCING CAVEAT: newdelhi.mae.lu (Embassy of Luxembourg, New
-- Delhi), vfsglobal.com, guichet.public.lu, and home-affairs.ec.europa.eu
-- were all blocked to direct live fetch this session (network egress
-- proxy). Findings below were triangulated via web-search-indexed excerpts
-- of those same official pages plus secondary sourcing (VFS Global
-- one-pagers, Luxtoday.lu, immigration-law alerts from Vialto Partners
-- and Arendt, education-agency visa guides). Fee figures in particular
-- vary slightly across secondary sources and are flagged "Approximate"
-- where a single authoritative figure could not be confirmed. No category
-- below is fabricated from nothing, but Medical, Conference, and Sports
-- rely more heavily on generic Schengen-visa analogs than on
-- Luxembourg-specific primary text, since dedicated secondary coverage of
-- those three purposes was thinner than for Tourist/Business/Work/Student
-- — treat their processing notes as reasonable estimates pending direct
-- confirmation, not as officially quoted figures.
--
-- Luxembourg's real, distinctive, dated facts verified this session:
--   - Luxembourg maintains its OWN Embassy in New Delhi (84, Jor Bagh)
--     and decides Indian visa applications directly — it does not route
--     representation through another Schengen country's mission in
--     India. (Indian diplomatic coverage of Luxembourg runs the other
--     way: the Indian Embassy in Brussels, Belgium is accredited to
--     Luxembourg.) Short-stay Schengen applications are lodged via VFS
--     Global, which operates centres in 16 Indian cities for Luxembourg.
--   - The EU Blue Card salary threshold has been raised twice in quick
--     succession and documented with exact effective dates: EUR 58,968
--     (2024) -> EUR 63,408 from 18 March 2025 -> EUR 65,652 from
--     3 March 2026, per Ministerial Regulation of 23 February 2026. This
--     is a genuine, recent (2025-2026) policy change specific to
--     Luxembourg. Since June 2024 Luxembourg no longer applies a reduced
--     shortage-occupation threshold, and Blue Card applicants skip the
--     ADEM labour market test entirely (unlike the standard Salaried
--     Worker Permit route, where ADEM testing is reported to take ~7
--     working days and is waived only for shortage-listed roles).
--   - Family Visit applicants commonly use a distinctive Luxembourg
--     instrument — the "Engagement de prise en charge" (certificate of
--     support) — instead of, or alongside, an informal invitation
--     letter. The Luxembourg-resident host signs it at their commune of
--     residence and must have it stamped by the Ministry of Foreign and
--     European Affairs (MAEE), which makes the host formally financially
--     responsible for the visitor's accommodation, healthcare, and
--     return travel.
--   - India is not on the Schengen Annex IV list of nationalities
--     requiring a Type A Airport Transit Visa, so Indian passport
--     holders can normally connect airside through Luxembourg-Findel
--     Airport without any visa at all — a genuinely distinctive
--     exemption reflected in the Transit category below.
--   - The Student route is a two-step process: a Temporary Authorisation
--     to Stay (ATS) from the Immigration Directorate first, then a Type
--     D long-stay visa to travel, followed by an in-country student
--     residence permit application — reportedly 3-4 months end to end,
--     longer than the Type D visa step alone.
--
-- country_id 131 = Luxembourg. visa_type_id: 1=Tourist, 2=Business,
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
    131, 1, 'LUX-TOUR-IN-01', '2026.09', 'published',
    'Leisure, sightseeing, and short personal travel to Luxembourg and the wider Schengen area.',
    'Indian passport holders apply for the standard Schengen C-type visa via VFS Global (16 Indian cities) or the Embassy of Luxembourg, New Delhi, which decides every application. Luxembourg maintains its own embassy in India rather than relying on another Schengen state for representation here.',
    'Single or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global (16 Indian cities); the Embassy of Luxembourg, New Delhi decides every application',
    1,
    'Standard Schengen processing is up to 15 calendar days from a complete file, extending to 45 days if extra documents are requested; apply 15 days to 6 months ahead',
    'Embassy of Luxembourg, New Delhi (84, Jor Bagh) — decision authority, via VFS Global visa application centres across India',
    'Book a VFS Global appointment\nComplete the online Schengen visa application form\nGather supporting documents including travel insurance\nAttend the appointment and submit biometrics (mandatory for first-time applicants)\nTrack status and collect your passport',
    '/assets/images/visa-heroes/luxembourg.webp',
    'Cross-checked against Embassy of Luxembourg (New Delhi) and VFS Global secondary sourcing; direct fetch of embassy/VFS pages was blocked this session, so triangulated via search-indexed excerpts', 'https://newdelhi.mae.lu/en/service_citoyens/visa-immigration/short-term-schengen-visa.html', '2026-09-17'
);
SET @lux1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lux1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux1, 'Core Documents', 'Required from every applicant.', 1);
SET @lux1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux1s1, 'Valid Passport (3+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@lux1s1, 'Completed and Signed Schengen Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@lux1s1, 'Travel/Schengen Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 1, 3),
(@lux1s1, 'Two Recent Passport-Size Photographs', NULL, 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lux1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux1s2, 'Confirmed Hotel Booking/Accommodation Proof', NULL, 'copy', 1, 0, 0, 1),
(@lux1s2, 'Return/Onward Flight Reservation', NULL, 'copy', 1, 0, 0, 2),
(@lux1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@lux1s2, 'Cover Letter Explaining Travel Purpose and Itinerary', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(131, 1, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Adult fee; children aged 6-11 pay EUR 45, under-6s are exempt. A separate non-refundable VFS Global service charge also applies.', '2026-09-01', NOW(), 'https://newdelhi.mae.lu/en/service_citoyens/visa-immigration/short-term-schengen-visa.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a Luxembourg Tourist visa let me travel elsewhere in the Schengen area?', 'Yes — the Schengen C-type visa is valid for travel across the entire Schengen area, not just Luxembourg, subject to the standard 90-days-in-180 rule.', 131, 1, 13100, 1),
('Does Luxembourg have its own embassy in India, or does another country represent it?', 'Luxembourg operates its own Embassy in New Delhi and decides visa applications directly — it does not rely on another Schengen country''s mission in India. India''s reciprocal diplomatic coverage of Luxembourg, however, runs through the Indian Embassy in Brussels, Belgium.', 131, 1, 13101, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    131, 2, 'LUX-BUS-IN-02', '2026.09', 'published',
    'Trade meetings, negotiations, and commercial visits to companies based in Luxembourg.',
    'Indian nationals travelling for business use the same Schengen C-type visa as Tourist, differentiated by a company invitation letter from the Luxembourg host (purpose, itinerary, cost-sponsorship) plus a forwarding/sponsorship letter from the applicant''s Indian employer.',
    'Single, double, or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global with a Luxembourg host company invitation letter and an Indian employer forwarding letter',
    1,
    'Standard Schengen processing is up to 15 calendar days from a complete file, extending to 45 days if extra documents are requested',
    'Embassy of Luxembourg, New Delhi, via VFS Global visa application centres across India',
    'Obtain an invitation letter from the Luxembourg host company\nGather an employer forwarding/sponsorship letter from India\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/luxembourg.webp',
    'Cross-checked against VFS Global one-pager and business-visa secondary sourcing; direct fetch of embassy/VFS pages was blocked this session', 'https://newdelhi.mae.lu/en/service_citoyens/visa-immigration/short-term-schengen-visa.html', '2026-09-17'
);
SET @lux2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lux2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux2, 'Core Documents', 'Required from every applicant.', 1);
SET @lux2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@lux2s1, 'Invitation Letter from Luxembourg Host Company', 'Should state purpose, itinerary, and who is sponsoring costs.', 'original', 1, 0, 1, 2),
(@lux2s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @lux2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux2s2, 'Forwarding/Sponsorship Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@lux2s2, 'Host Company Registration/Bank Statements (If Host Is Paying)', NULL, 'copy', 0, 1, 0, 2),
(@lux2s2, 'Applicant Salary Slips and Bank Statements (If Self-Funding)', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(131, 2, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://newdelhi.mae.lu/en/service_citoyens/visa-immigration/short-term-schengen-visa.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Whose bank statements are required if the Luxembourg host company is paying my costs?', 'If the inviting organization is covering costs, its own bank statements for the last three months are required alongside the invitation letter; if you''re self-funding, your personal salary slips and bank statements for the last three months are required instead.', 131, 2, 13102, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — ATS + Type D Long-Stay Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    131, 3, 'LUX-STU-IN-03', '2026.09', 'published',
    'Enrolling full-time at a Luxembourg university or other recognized higher-education institution.',
    'Indian nationals admitted to a Luxembourg institution for a program exceeding 90 days must obtain a Temporary Authorisation to Stay (ATS) from the Immigration Directorate, then a Type D long-stay visa to travel, followed by a residence permit after arrival. Monthly funds of roughly 80% of the social inclusion income (REVIS) — about EUR 1,517-1,555 for 2026 — must be shown.',
    'Type D visa valid 90 days to travel; residence permit then issued for the program duration',
    'Apply for the Temporary Authorisation to Stay via the Immigration Directorate, then the Type D visa via VFS Global or the Embassy',
    1,
    'ATS plus Type D visa reportedly takes 3-4 months overall; the Type D visa step alone is commonly cited at 15-45 days, longer in peak admission season',
    'Embassy of Luxembourg, New Delhi, via VFS Global for the Type D visa; Immigration Directorate, Luxembourg for the ATS approval',
    'Secure admission at a recognized Luxembourg institution\nApply for the Temporary Authorisation to Stay (ATS) with the Immigration Directorate\nGather proof of funds (~EUR 1,517-1,555/month) and Schengen health insurance\nBook a Type D visa appointment via VFS Global or the Embassy\nTravel, then register and apply for a student residence permit in Luxembourg',
    '/assets/images/visa-heroes/luxembourg.webp',
    'Cross-checked against education-agency secondary sourcing (Leverage Edu, Yocket, Luxtoday.lu) on the ATS-then-Type-D student route; live fetch of guichet.public.lu was blocked this session', 'https://leverageedu.com/learn/student-visa-luxembourg/', '2026-09-17'
);
SET @lux3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lux3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux3, 'Core Documents', 'Required from every applicant.', 1);
SET @lux3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux3s1, 'Valid Passport (10+ Years Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@lux3s1, 'Admission Letter from Luxembourg Institution', NULL, 'original', 1, 0, 1, 2),
(@lux3s1, 'Temporary Authorisation to Stay (ATS) Approval', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @lux3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@lux3s2, 'Proof of Funds (~EUR 1,517-1,555/Month)', NULL, 'copy', 1, 0, 0, 2),
(@lux3s2, 'Health Insurance Valid in Luxembourg', NULL, 'original', 1, 0, 0, 3),
(@lux3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(131, 3, 50.00, 'EUR', 'Type D Long-Stay Visa Fee (Approximate)', 'Payable at the consulate; a separate approximately EUR 80 residence-permit fee applies after arrival for the student residence permit application. Confirm current figures before applying.', '2026-09-01', NOW(), 'https://leverageedu.com/learn/student-visa-luxembourg/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can international students work while studying in Luxembourg?', 'Yes, subject to limits — non-EU/EEA students are commonly cited at up to 10-15 hours per week during term time, with full-time work permitted during official university holidays. Confirm the current limit tied to your residence permit.', 131, 3, 13103, 1),
('Is the Type D visa the final step, or is something needed after arriving?', 'The Type D visa only gets you into Luxembourg — after arrival you must declare your address at the local commune, complete a medical check, and apply for the actual student residence permit (titre de séjour), which is the document that lets you legally stay.', 131, 3, 13104, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — EU Blue Card / Salaried Worker Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    131, 4, 'LUX-WORK-IN-04', '2026.09', 'published',
    'Employment with a Luxembourg employer, via the EU Blue Card for highly qualified roles or the Salaried Worker Permit for other roles.',
    'Indian nationals with a job offer of at least 6 months and a degree (or 5 years'' specialised experience) qualify for the EU Blue Card once salary meets the threshold — EUR 65,652/year from 3 March 2026 (raised from EUR 63,408 in March 2025) — with no ADEM labour market test. Below that, a Salaried Worker Permit applies, requiring an ADEM test (waived for shortage-listed roles) and a minimum monthly wage around EUR 2,570.',
    'Blue Card/permit typically issued for up to 1-2 years initially, renewable',
    'Employer-driven application to the Immigration Directorate; applicant then applies for the Type D visa via VFS Global or the Embassy',
    1,
    'ADEM labour market test (Salaried Worker Permit route only) is reported at around 7 working days, waived for shortage-listed occupations; overall Immigration Directorate review typically runs several weeks',
    'Immigration Directorate, Luxembourg (permit decision); Embassy of Luxembourg, New Delhi and VFS Global for the Type D visa',
    'Secure a qualifying job offer from a Luxembourg employer\nEmployer/applicant applies to the Immigration Directorate for the EU Blue Card or Salaried Worker Permit\nComplete the ADEM labour market test if applicable (Salaried Worker Permit route)\nApply for the Type D visa via VFS Global or the Embassy of Luxembourg\nTravel, then declare arrival and collect the residence permit in Luxembourg',
    '/assets/images/visa-heroes/luxembourg.webp',
    'Cross-checked against the European Commission EU Immigration Portal Blue Card page and immigration-law alerts (Vialto Partners, Arendt) on the March 2026 threshold increase; live fetch of home-affairs.ec.europa.eu was blocked this session', 'https://home-affairs.ec.europa.eu/policies/migration-and-asylum/eu-immigration-portal/eu-blue-card/eu-blue-card-luxembourg_en', '2026-09-17'
);
SET @lux4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lux4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux4, 'Core Documents', 'Required from every applicant.', 1);
SET @lux4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@lux4s1, 'Signed Employment Contract/Job Offer Letter', NULL, 'copy', 1, 0, 1, 2),
(@lux4s1, 'Degree Certificate or Proof of 5 Years'' Specialised Experience', NULL, 'copy', 1, 0, 1, 3),
(@lux4s1, 'ADEM Labour Market Test Confirmation', 'Salaried Worker Permit route only; not needed for the EU Blue Card.', 'copy', 0, 1, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @lux4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux4s2, 'Proof of Salary Meeting the Applicable Threshold', NULL, 'copy', 1, 0, 0, 1),
(@lux4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@lux4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(131, 4, NULL, 'EUR', 'Confirmed After Assessment', 'Type D visa fee reported around EUR 50 plus a roughly EUR 80 residence-permit/Blue-Card application fee, billed separately at different stages; total varies by permit type — confirm current amounts with the Immigration Directorate.', '2026-09-01', NOW(), 'https://home-affairs.ec.europa.eu/policies/migration-and-asylum/eu-immigration-portal/eu-blue-card/eu-blue-card-luxembourg_en', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Did the EU Blue Card salary threshold in Luxembourg just change?', 'Yes — by Ministerial Regulation of 23 February 2026, the minimum gross annual salary for the EU Blue Card rose to EUR 65,652 effective 3 March 2026, up from EUR 63,408 (itself raised from EUR 58,968 in 2024). Applications submitted on or after the effective date must meet the new threshold.', 131, 4, 13105, 1),
('Is the EU Blue Card genuinely easier than a standard work permit for Indians?', 'For most Indian professionals meeting the salary threshold, yes — the Blue Card skips the ADEM labour market test entirely, grants free access to the Luxembourg labour market after 12 months, and eases intra-EU mobility and family reunification, unlike the standard Salaried Worker Permit route.', 131, 4, 13106, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    131, 5, 'LUX-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or close friends resident in Luxembourg for up to 90 days.',
    'Indian nationals visiting family/friends use the same Schengen C-type visa as Tourist, but the invitation letter is commonly replaced by an "Engagement de prise en charge" (certificate of support) that the Luxembourg-resident host signs at their commune and gets stamped by the Ministry of Foreign and European Affairs, making the host financially responsible for the stay.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with the MAEE-stamped "prise en charge" certificate of support from your Luxembourg host',
    1,
    'Getting the prise en charge stamped inside Luxembourg has its own lead time (hosts advised to start 3-4 weeks ahead); the visa itself follows the standard ~15-day Schengen timeline, longer if extra documents are requested',
    'Embassy of Luxembourg, New Delhi, via VFS Global visa application centres across India',
    'Ask your Luxembourg host to initiate the "Engagement de prise en charge" at their local commune\nHave the host get it stamped by the Ministry of Foreign and European Affairs (MAEE)\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/luxembourg.webp',
    'Cross-checked against Luxtoday.lu guidance on the prise en charge process and VFS Global secondary sourcing; live fetch of the relevant government portals was blocked this session', 'https://luxtoday.lu/en/knowledge/invitation-letter-for-visa-luxembourg', '2026-09-17'
);
SET @lux5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lux5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux5, 'Core Documents', 'Required from every applicant.', 1);
SET @lux5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@lux5s1, 'MAEE-Stamped "Prise en Charge" Certificate of Support', 'Signed by the host at their commune, then stamped by the Ministry of Foreign and European Affairs.', 'original', 1, 0, 1, 2),
(@lux5s1, 'Proof of Relationship to Host', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux5, 'Supporting Documents', 'Evidence of your own means and travel plans.', 2);
SET @lux5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 0, 1, 0, 1),
(@lux5s2, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 0, 2),
(@lux5s2, 'Return/Onward Flight Reservation', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(131, 5, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://newdelhi.mae.lu/en/service_citoyens/visa-immigration/short-term-schengen-visa.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is a "prise en charge" and how is it different from a normal invitation letter?', 'It''s a formal certificate of support that your Luxembourg host signs at their commune and gets stamped by the Ministry of Foreign and European Affairs — unlike an informal invitation letter, it makes the host legally and financially responsible for your accommodation, healthcare costs, and return travel during your stay.', 131, 5, 13107, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Airport Transit / Type C if Required
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    131, 6, 'LUX-TRAN-IN-06', '2026.09', 'published',
    'Passing through Luxembourg — most commonly via Luxembourg-Findel Airport — en route to a non-Schengen destination.',
    'India is not on the Schengen Annex IV list requiring a Type A Airport Transit Visa, so Indian passport holders normally transit airside through Luxembourg-Findel without any visa, given a valid onward ticket. A short-stay Type C visa is required only if leaving the international transit area or transiting by land.',
    'No visa needed for airside-only transit; if a Type C visa is required, standard 90/180-day terms apply',
    'No application needed for airside airport transit; apply via VFS Global for a Type C visa only if leaving the transit area',
    1,
    'Confirm your specific itinerary first — most Indian travellers connecting through Findel Airport airside need no visa or appointment at all',
    'Embassy of Luxembourg, New Delhi, via VFS Global centres (only if a Type C visa is genuinely required)',
    'Confirm whether your connection stays entirely airside at Luxembourg-Findel (no visa needed for Indian passport holders in that case)\nIf you must leave the international transit area or transit by land, apply for a Type C short-stay visa via VFS Global\nGather your onward ticket and full itinerary\nSubmit biometrics only if a visa application is required',
    '/assets/images/visa-heroes/luxembourg.webp',
    'Cross-checked against Schengen Annex IV exemption listings and the Embassy of Luxembourg short-term Schengen visa page; live fetch of the embassy page was blocked this session', 'https://newdelhi.mae.lu/en/service_citoyens/visa-immigration/short-term-schengen-visa.html', '2026-09-17'
);
SET @lux6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lux6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux6, 'Core Documents', 'Needed only if a Type C visa is genuinely required for your itinerary.', 1);
SET @lux6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@lux6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux6, 'Supporting Documents', 'Additional evidence for the connecting itinerary, if a visa is required.', 2);
SET @lux6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(131, 6, NULL, 'EUR', 'Not Applicable — No Visa Required for Airside Transit', 'Indian nationals transiting airside at Luxembourg-Findel need no visa or fee; if a Type C visa is genuinely required for your itinerary, the standard EUR 90 Schengen fee applies instead.', '2026-09-01', NOW(), 'https://newdelhi.mae.lu/en/service_citoyens/visa-immigration/short-term-schengen-visa.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian travellers need a transit visa to connect through Luxembourg-Findel Airport?', 'No, generally not — India is not on the Schengen Annex IV list requiring an Airport Transit Visa, so a valid onward ticket is normally enough for an airside connection. You would only need a Type C visa if your itinerary requires leaving the international transit area.', 131, 6, 13108, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    131, 7, 'LUX-MED-IN-07', '2026.09', 'published',
    'Travel to Luxembourg for scheduled medical treatment.',
    'Indian nationals travelling for treatment use the same Schengen C-type visa as Tourist, requiring a certificate from the treating Luxembourg hospital or doctor confirming the diagnosis, treatment plan, and estimated cost, plus proof of funds to cover it.',
    'Up to 90 days within any 180-day period, extendable for treatment reasons via the Immigration Directorate',
    'Apply via VFS Global with the medical certificate and Schengen-compliant insurance covering the treatment',
    1,
    'Standard Schengen processing up to 15 calendar days; incomplete medical documentation is a commonly cited cause of delay',
    'Embassy of Luxembourg, New Delhi, via VFS Global visa application centres across India',
    'Obtain a certificate from the treating Luxembourg hospital/doctor confirming diagnosis, treatment plan, and cost\nArrange Schengen-compliant travel insurance (min. €30,000 cover)\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/luxembourg.webp',
    'Cross-checked against generic Schengen medical-visa requirements and VFS Global secondary sourcing; Luxembourg-specific primary text for this category was thinner than for Tourist/Business, so treat processing notes as estimates', 'https://newdelhi.mae.lu/en/service_citoyens/visa-immigration/short-term-schengen-visa.html', '2026-09-17'
);
SET @lux7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lux7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux7, 'Core Documents', 'Required from every applicant.', 1);
SET @lux7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@lux7s1, 'Medical Certificate/Treating Institution Confirmation', NULL, 'original', 1, 0, 1, 2),
(@lux7s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @lux7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux7s2, 'Medical Records/Referral from India', NULL, 'copy', 1, 0, 0, 1),
(@lux7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(131, 7, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://newdelhi.mae.lu/en/service_citoyens/visa-immigration/short-term-schengen-visa.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Luxembourg require special insurance for medical-treatment visits?', 'Yes — beyond the standard EUR 30,000 minimum Schengen travel insurance, you''ll typically need proof of funds or insurance specifically covering the estimated treatment cost quoted by the Luxembourg hospital or doctor.', 131, 7, 13109, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    131, 8, 'LUX-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, trade fairs, and professional events in Luxembourg.',
    'Indian nationals attending a conference use the same Schengen C-type visa as Business, requiring an invitation letter from the inviting organizer/company/fair naming the purpose, program, and sponsorship arrangements, addressed to the Embassy of Luxembourg.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a conference invitation/registration confirmation and employer leave-confirmation letter',
    1,
    'Standard Schengen processing up to 15 calendar days; lodge at least 15 days before travel, not more than 6 months ahead',
    'Embassy of Luxembourg, New Delhi, via VFS Global visa application centres across India',
    'Obtain a conference/event invitation or registration confirmation naming the program and sponsorship arrangements\nGather an employer covering letter confirming your role and approved leave\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/luxembourg.webp',
    'Cross-checked against Schengen conference/business invitation-letter requirements referenced across secondary visa-agency sourcing; Luxembourg-specific primary text for this category was thinner than for Tourist/Business', 'https://newdelhi.mae.lu/en/service_citoyens/visa-immigration/short-term-schengen-visa.html', '2026-09-17'
);
SET @lux8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lux8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux8, 'Core Documents', 'Required from every applicant.', 1);
SET @lux8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@lux8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2),
(@lux8s1, 'Employer Covering Letter Confirming Role and Approved Leave', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux8, 'Supporting Documents', 'Additional financial evidence.', 2);
SET @lux8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@lux8s2, 'Proof of Sponsorship Arrangement', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(131, 8, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://newdelhi.mae.lu/en/service_citoyens/visa-immigration/short-term-schengen-visa.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What must the conference invitation letter include?', 'It should come from the inviting company, fair, congress, or organizer in Luxembourg, name the purpose of the visit with a complete program of activities/meetings, carry a signature, designation, company stamp, and contact details, and be addressed to the Embassy of Luxembourg.', 131, 8, 13110, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    131, 9, 'LUX-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments or sporting events hosted in Luxembourg.',
    'Indian nationals competing or officiating use the same Schengen C-type visa as Business/Conference, requiring an invitation letter from the host event organizer/sport federation in Luxembourg plus confirmation from the applicant''s home sports association of their role and no-employment status.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a host-organizer invitation and a home sports association letter',
    1,
    'Standard Schengen processing up to 15 calendar days',
    'Embassy of Luxembourg, New Delhi, via VFS Global visa application centres across India',
    'Obtain an invitation letter from the host event organizer/sport federation in Luxembourg\nObtain a letter from your home-country sports association confirming your role and no-employment status\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/luxembourg.webp',
    'Cross-checked against Schengen sports/event-visa invitation-letter requirements referenced across secondary visa-agency sourcing; Luxembourg-specific primary text for this category was thinner than for Tourist/Business', 'https://newdelhi.mae.lu/en/service_citoyens/visa-immigration/short-term-schengen-visa.html', '2026-09-17'
);
SET @lux9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lux9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux9, 'Core Documents', 'Required from every applicant.', 1);
SET @lux9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@lux9s1, 'Host Event Organizer/Sport Federation Invitation Letter', NULL, 'original', 1, 0, 1, 2),
(@lux9s1, 'Home-Country Sports Association Letter', 'Confirms role and no-employment status.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @lux9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1),
(@lux9s2, 'Proof of Funds or Sponsorship', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(131, 9, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://newdelhi.mae.lu/en/service_citoyens/visa-immigration/short-term-schengen-visa.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the sports event organizer need to cover my costs for the visa to be approved?', 'Not necessarily — either the organizer''s letter confirms it is covering costs (with the organization''s recent bank statements attached), or you must show your own salary slips and bank statements for the last three months as proof of self-funding.', 131, 9, 13111, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification Residence Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    131, 10, 'LUX-DEP-IN-10', '2026.09', 'published',
    'Spouse, minor children, or other eligible family members joining an Indian national legally resident in Luxembourg (e.g. EU Blue Card or Salaried Worker Permit holder).',
    'Family reunification requires the Luxembourg-resident sponsor to hold a qualifying residence permit; the family member applies for a Temporary Authorisation to Stay from the Immigration Directorate, then a Type D visa. The sponsor''s resources must meet at least the average monthly minimum wage of an unskilled worker over the prior 12 months.',
    'Initial 90-day temporary residence permit, converted after arrival into a renewable family-member permit tied to the sponsor''s status',
    'Family member applies for the Temporary Authorisation to Stay via the Immigration Directorate, then the Type D visa via VFS Global or the Embassy',
    1,
    'Family reunification processing timelines are reported as notably longer than short-stay Schengen visas; confirm current estimates with the Immigration Directorate for your sponsor''s specific permit type',
    'Immigration Directorate, Luxembourg (ATS decision); Embassy of Luxembourg, New Delhi and VFS Global for the Type D visa',
    'Confirm the Luxembourg-resident sponsor holds a qualifying permit and meets the minimum-wage resource threshold\nApply for the Temporary Authorisation to Stay (ATS) via the Immigration Directorate\nGather relationship proof (marriage/birth certificates) and the sponsor''s permit copy\nApply for the Type D visa via VFS Global or the Embassy\nTravel, declare arrival at the commune, and apply for the family-member residence permit',
    '/assets/images/visa-heroes/luxembourg.webp',
    'Cross-checked against Guichet.lu (Luxembourg government citizen portal) family reunification guidance; live fetch of guichet.public.lu was blocked this session, so cross-referenced against search-indexed excerpts of the same page', 'https://guichet.public.lu/en/citoyens/immigration/plus-3-mois/ressortissant-tiers/membre-famille/regroupement-familial.html', '2026-09-17'
);
SET @lux10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lux10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux10, 'Core Documents', 'Required from every applicant.', 1);
SET @lux10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@lux10s1, 'Proof of Relationship to Sponsor (Marriage/Birth Certificate)', NULL, 'copy', 1, 0, 1, 2),
(@lux10s1, 'Sponsor''s Residence Permit/EU Blue Card Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lux10, 'Supporting Documents', 'Evidence tied to the sponsor''s income and accommodation.', 2);
SET @lux10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lux10s2, 'Proof of Sponsor''s Income Meeting the Minimum-Wage-Equivalent Threshold', NULL, 'copy', 1, 0, 0, 1),
(@lux10s2, 'Proof of Accommodation in Luxembourg', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(131, 10, 80.00, 'EUR', 'Residence Permit Application Fee (Approximate)', 'Plus a separate approximately EUR 50 Type D visa fee at the consulate; sources don''t consistently distinguish the family-reunification route fee from the general long-stay fee, so confirm the current figure.', '2026-09-01', NOW(), 'https://guichet.public.lu/en/citoyens/immigration/plus-3-mois/ressortissant-tiers/membre-famille/regroupement-familial.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How is the financial threshold for sponsoring family reunification calculated?', 'It''s assessed against the average monthly minimum wage of an unskilled worker in Luxembourg over the preceding 12 months, rather than a fixed fee-schedule amount — so the exact figure moves with wage indexation and should be confirmed with the Immigration Directorate.', 131, 10, 13112, 1);
