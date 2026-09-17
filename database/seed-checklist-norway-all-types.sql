-- Norway Visa Checklist Engine content for all 10 visa types — built this
-- session via web search. hero_image_url is set to the existing shared
-- asset for Norway.
--
-- IMPORTANT SOURCING CAVEAT: norway.no and udi.no could not be directly
-- fetched this session (WebFetch returned EGRESS_BLOCKED for both
-- domains) — all findings below are triangulated from WebSearch result
-- snippets of those same official pages (norway.no visitor-visa pages,
-- udi.no "want to apply" pages, udi.no fee/salary announcement pages)
-- plus secondary sourcing (VFS Global one-pager, visa agencies,
-- relocation/immigration-law blogs). Fee and processing-time figures
-- vary somewhat across secondary sources and are flagged as
-- approximate where a single authoritative figure could not be
-- confirmed. No category below was entirely unresearchable, but the
-- Sports-visa dual-letter convention (common on other Schengen
-- checklists) was NOT separately confirmed for Norway specifically and
-- is flagged as such in that section.
--
-- Norway's real, distinctive, dated facts verified this session:
--   - Norway is an EEA/Schengen-associated country, not an EU member —
--     short-stay Schengen C-type visas (Tourist, Business, Family
--     Visit, Transit, Medical, Conference, Sports) are decided by the
--     Royal Norwegian Embassy, New Delhi, with applications lodged via
--     VFS Global centres in India (search results cite 8 cities:
--     Ahmedabad, Bengaluru, Chennai, Hyderabad, Kolkata, Mumbai, New
--     Delhi, Pune — a couple of secondary sources list additional
--     cities such as Chandigarh/Kochi, so treat the exact city count as
--     approximate).
--   - Work: effective 1 September 2025, UDI raised skilled-worker
--     salary thresholds to NOK 522,600/year (bachelor's-level roles,
--     up from NOK 469,366) and NOK 599,200/year (master's-level roles,
--     up from NOK 513,100) — a genuine, dated 2025 policy change still
--     current in September 2026.
--   - Work: UDI now requires the Norwegian employer to confirm the
--     job/assignment offer before the applicant can submit their
--     residence-permit application — an anti-fraud measure introduced
--     in response to forged offer letters.
--   - Work: vocational-level applications (cooks, mechanics,
--     carpenters, hairdressers, etc.) from a list of 14 countries
--     including India are held in a document-verification queue,
--     because of widespread forged education documents, which UDI
--     reportedly aims to clear only by the end of 2026 — a genuine,
--     dated, India-relevant detail.
--   - Student: the UDI study-permit fee is reported at NOK 5,400, and
--     the 2026-27 financial-means requirement is NOK 170,368/year
--     (NOK 15,488/month) — both genuinely long-stay UDI processes, not
--     a Schengen visa.
--   - Transit: India is on Norway's list of nationalities requiring an
--     Airport Transit Visa (Type A) even for airside-only connections
--     between two non-Schengen countries — a Type A visa does not
--     permit entry into Norway or the wider Schengen area.
--   - Family Visit vs. Dependent are genuinely two different UDI/MFA
--     processes: Family Visit is the short-stay Schengen C-type visa
--     (host typically files a UDI "Sponsor for Visitors" form and,
--     where funding the trip, an endorsed Norwegian Guarantee Form for
--     Visits), while Dependent is the long-stay Family Immigration
--     residence permit (first-time fee reported at NOK 11,900, with a
--     Norway-based sponsor income requirement of NOK 436,957/year
--     pre-tax, adjusted every May).
--
-- country_id 138 = Norway. visa_type_id: 1=Tourist, 2=Business,
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
    138, 1, 'NOR-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Norway, including the fjords, Northern Lights, and other tourist attractions.',
    'Indian passport holders — the standard Schengen C-type visa. Norway is an EEA/Schengen-associated country (not an EU member); applications are decided by the Royal Norwegian Embassy, New Delhi, and lodged via VFS Global centres in India.',
    'Single or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global (centres across India, incl. Ahmedabad, Bengaluru, Chennai, Hyderabad, Kolkata, Mumbai, New Delhi, Pune)',
    1,
    'Standard Schengen processing is typically around 15 working days; apply 4-6 weeks before travel',
    'Royal Norwegian Embassy, New Delhi (decision authority), via VFS Global centres across India',
    'Book a VFS Global appointment\nComplete the online Schengen visa application form\nGather supporting documents and travel insurance\nAttend the appointment and submit biometrics (mandatory for first-time applicants)\nTrack status and collect your passport',
    '/assets/images/visa-heroes/norway.webp',
    'Cross-checked against VFS Global one-pager and Norway MFA visitor-visa guidance via search snippets; norway.no and udi.no direct fetch was blocked this session', 'https://www.norway.no/en/india/services-info/visitors-visa-res-permit/visitors-visa/', '2026-09-17'
);
SET @nor1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nor1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor1, 'Core Documents', 'Required from every applicant.', 1);
SET @nor1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor1s1, 'Valid Passport (3+ Months Beyond Intended Stay)', 'Issued within the last 10 years, with at least 2 blank pages.', 'original', 1, 0, 1, 1),
(@nor1s1, 'Completed Schengen Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@nor1s1, 'Travel/Schengen Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @nor1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor1s2, 'Confirmed Hotel/Accommodation Booking', NULL, 'copy', 1, 0, 0, 1),
(@nor1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@nor1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(138, 1, 80.00, 'EUR', 'Schengen C-Type Visa Fee', 'Standard Schengen visa fee for adults (children 6-11 approx. €40, under 6 free); a separate VFS Global service charge of approximately €20 also applies.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/one-pager/norway/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use a Norway tourist visa to travel elsewhere in Europe?', 'Yes — the Schengen C-type visa is valid for travel across the entire Schengen area, not just Norway, subject to the standard 90-days-in-180 rule.', 138, 1, 13800, 1),
('Is Norway part of the European Union?', 'No — Norway is an EEA/Schengen-associated country, not an EU member state, though it applies the same Schengen visa rules and the same standard C-type visa.', 138, 1, 13801, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    138, 2, 'NOR-BUS-IN-02', '2026.09', 'published',
    'Trade negotiations, meetings, and commercial activity in Norway.',
    'Indian nationals travelling for business — the same Schengen C-type visa as Tourist, with an invitation letter from the Norwegian host company and an Indian employer forwarding letter as the differentiating documents.',
    'Single, double, or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global with a Norwegian company invitation letter and Indian employer sponsorship letter',
    1,
    'Standard Schengen processing is typically around 15 working days',
    'Royal Norwegian Embassy, New Delhi (decision authority), via VFS Global centres across India',
    'Obtain an invitation letter from the Norwegian host company\nGather the Indian employer forwarding/sponsorship letter\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/norway.webp',
    'Cross-checked against VFS Global one-pager and Norway MFA guidance via search snippets; norway.no and udi.no direct fetch was blocked this session', 'https://www.norway.no/en/india/services-info/visitors-visa-res-permit/visitors-visa/', '2026-09-17'
);
SET @nor2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nor2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor2, 'Core Documents', 'Required from every applicant.', 1);
SET @nor2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nor2s1, 'Invitation Letter from Norwegian Host Company', NULL, 'original', 1, 0, 1, 2),
(@nor2s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @nor2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@nor2s2, 'Business Registration Proof', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(138, 2, 80.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge of approximately €20.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/one-pager/norway/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate business registration document?', 'It is conditional — VFS may request proof of your employer''s business registration in addition to the standard invitation and forwarding letters, depending on your case.', 138, 2, 13802, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — UDI Study Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    138, 3, 'NOR-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Norwegian university, university college, or folk high school.',
    'Indian nationals admitted to a recognized Norwegian institution, applying for a UDI study permit (a long-stay residence permit, not a Schengen visa). The 2026-27 financial-means requirement is NOK 170,368/year (NOK 15,488/month).',
    'Covers the full duration of the study programme, subject to annual reporting to UDI',
    'Apply online via the UDI application portal, then submit documents and biometrics at VFS Global / the Royal Norwegian Embassy, New Delhi',
    1,
    'UDI reports 8-10 weeks processing; apply as early as possible, ideally by 1 July for an autumn intake',
    'Royal Norwegian Embassy, New Delhi, via the UDI online portal and VFS Global',
    'Secure admission at a recognized Norwegian institution\nCreate a UDI application (application ID) online and pay the fee\nGather proof of funds (NOK 170,368/year) and health insurance\nBook a VFS Global/embassy appointment to submit documents and biometrics\nAwait the UDI decision and collect the permit',
    '/assets/images/visa-heroes/norway.webp',
    'Cross-checked against UDI study-permit and Study in Norway guidance via search snippets; udi.no direct fetch was blocked this session', 'https://www.udi.no/en/want-to-apply/studies/studietillatelse/', '2026-09-17'
);
SET @nor3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nor3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor3, 'Core Documents', 'Required from every applicant.', 1);
SET @nor3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nor3s1, 'Admission Letter from Norwegian Institution', NULL, 'original', 1, 0, 1, 2),
(@nor3s1, 'UDI Application ID / Online Application Confirmation', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @nor3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@nor3s2, 'Proof of Funds (NOK 170,368/Year)', NULL, 'copy', 1, 0, 0, 2),
(@nor3s2, 'Health Insurance Valid in Norway', NULL, 'original', 1, 0, 0, 3),
(@nor3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(138, 3, 5400.00, 'NOK', 'UDI Study Permit Application Fee', 'Paid online via the UDI portal when submitting the application; generally non-refundable regardless of outcome.', '2026-09-01', NOW(), 'https://www.udi.no/en/want-to-apply/studies/studietillatelse/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can international students work while studying in Norway?', 'Yes — student permit holders are generally permitted to work part-time (up to 20 hours per week) during the semester and full-time during official holiday periods.', 138, 3, 13803, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — UDI Skilled Worker Residence Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    138, 4, 'NOR-WORK-IN-04', '2026.09', 'published',
    'Employment with a Norwegian employer under the UDI skilled worker residence permit scheme.',
    'Indian nationals with a concrete job offer from one specific Norwegian employer, holding higher education or completed vocational training. From 1 Sept 2025, minimum salary is NOK 522,600/year (bachelor''s-level roles) or NOK 599,200/year (master''s-level roles). Employers must now confirm the job offer before the applicant submits, an anti-fraud measure.',
    'Tied to the employment contract length; renewable',
    'Apply online via the UDI portal; submit documents and biometrics at VFS Global / the Royal Norwegian Embassy, New Delhi',
    1,
    'Most skilled worker applications are decided within 1-3 months; vocational-level roles (cooks, mechanics, hairdressers, etc.) from a list of 14 countries incl. India face a document-verification queue UDI aims to clear only by end of 2026',
    'Royal Norwegian Embassy, New Delhi, via the UDI online portal and VFS Global',
    'Secure a concrete job offer from a Norwegian employer\nEmployer confirms the job/assignment offer via UDI''s employer portal\nSubmit the application and fee online via UDI\nBook a VFS Global/embassy appointment for documents and biometrics\nAfter approval and arrival, report to the local police within 7 days to collect the residence card',
    '/assets/images/visa-heroes/norway.webp',
    'Cross-checked against UDI skilled-worker guidance, the September 2025 UDI salary-threshold announcement, and secondary immigration-law reporting via search snippets; udi.no direct fetch was blocked this session', 'https://www.udi.no/en/want-to-apply/work-immigration/skilled-workers/', '2026-09-17'
);
SET @nor4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nor4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor4, 'Core Documents', 'Required from every applicant.', 1);
SET @nor4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nor4s1, 'Employment Contract/Concrete Job Offer', NULL, 'copy', 1, 0, 1, 2),
(@nor4s1, 'Employer Offer Confirmation (via UDI Employer Portal)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @nor4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor4s2, 'Academic/Vocational Certificates', NULL, 'copy', 1, 0, 0, 1),
(@nor4s2, 'CV/Resume', NULL, 'copy', 1, 0, 0, 2),
(@nor4s2, 'Document Verification Proof (Vocational-Level Applicants)', 'For roles such as cook, mechanic, carpenter, or hairdresser, held in a UDI verification queue for applicants from certain countries incl. India.', 'if_applicable', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(138, 4, 6300.00, 'NOK', 'UDI Skilled Worker Residence Permit Fee', 'NOK 6,300 for applicants aged 18+ (NOK 3,150 under 18); figures vary slightly across secondary sources, so confirm the current amount on udi.no before paying.', '2026-09-01', NOW(), 'https://www.udi.no/en/want-to-apply/work-immigration/skilled-workers/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Why are some Indian applicants facing longer work-permit delays?', 'Vocational-level applications (e.g. cooks, mechanics, carpenters, hairdressers) from a list of 14 countries including India are held in a UDI document-verification queue, due to widespread forged education documents, which UDI reportedly aims to clear only by the end of 2026.', 138, 4, 13804, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    138, 5, 'NOR-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Norway.',
    'Indian nationals visiting family/friends in Norway — the same short-stay Schengen C-type visa as Tourist. The Norway-based host typically files a UDI "Sponsor for Visitors" form and, if funding the trip, an endorsed Norwegian Guarantee Form for Visits.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a signed host invitation letter and, if applicable, an endorsed Norwegian Guarantee Form for Visits',
    1,
    'Standard Schengen processing is typically around 15 working days',
    'Royal Norwegian Embassy, New Delhi (decision authority), via VFS Global centres across India',
    'Host in Norway files a UDI Sponsor for Visitors form and signed invitation letter\nGather documents proving the family/personal relationship\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/norway.webp',
    'Cross-checked against Norway MFA visitor-visa guidance and VFS/agency secondary sourcing via search snippets; norway.no direct fetch was blocked this session', 'https://www.norway.no/en/india/services-info/visitors-visa-res-permit/visitors-visa/', '2026-09-17'
);
SET @nor5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nor5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor5, 'Core Documents', 'Required from every applicant.', 1);
SET @nor5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nor5s1, 'Invitation Letter from Host in Norway', NULL, 'original', 1, 0, 1, 2),
(@nor5s1, 'Proof of Relationship to Host', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor5, 'Supporting Documents', 'Evidence of your own means, or the host''s funding guarantee.', 2);
SET @nor5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@nor5s2, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 0, 2),
(@nor5s2, 'Norwegian Guarantee Form for Visits (Host-Funded Trips)', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(138, 5, 80.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge of approximately €20.', '2026-09-01', NOW(), 'https://www.norway.no/en/india/services-info/visitors-visa-res-permit/visitors-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Family Visit visa the same as a Dependent permit?', 'No — Family Visit is the short-stay Schengen C-type visa for visiting relatives in Norway (up to 90 days), while Dependent is a separate, long-stay UDI Family Immigration residence permit for relocating to live with a sponsor.', 138, 5, 13805, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Type A Airport Transit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    138, 6, 'NOR-TRAN-IN-06', '2026.09', 'published',
    'Passing through a Norwegian airport (e.g. Oslo Gardermoen), airside only, between two non-Schengen destinations.',
    'India is on Norway''s list of nationalities requiring an Airport Transit Visa (Type A), even for a connection that never leaves the international transit zone. A Type A visa does not permit entry into Norway or the wider Schengen area; travellers entering Schengen even briefly need a Type C visa instead.',
    'Valid for the transit window; the visa itself may be issued for up to 6 months, single or double entry',
    'Apply via VFS Global with your connecting-flight itinerary and confirmed onward ticket',
    1,
    'Standard Schengen-adjacent processing is typically around 15 working days',
    'Royal Norwegian Embassy, New Delhi (decision authority), via VFS Global centres across India',
    'Confirm whether your connection requires a Type A visa (airside-only, between two non-Schengen countries)\nApply via VFS Global with onward tickets and full itinerary\nSubmit biometrics if a first-time applicant',
    '/assets/images/visa-heroes/norway.webp',
    'Cross-checked against UDI airport-transit-visa word-definition page and Schengen transit guidance via search snippets; udi.no direct fetch was blocked this session', 'https://www.udi.no/en/word-definitions/airport-transit-visa/', '2026-09-17'
);
SET @nor6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nor6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor6, 'Core Documents', 'Required if a Type A visa is genuinely needed.', 1);
SET @nor6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nor6s1, 'Connecting Flight Itinerary/Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @nor6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(138, 6, NULL, 'EUR', 'Confirmed After Assessment', 'Airport Transit (Type A) visas are typically charged at the standard €80 Schengen fee, but this specific figure was not separately confirmed for Norway this session — confirm before applying.', '2026-09-01', NOW(), 'https://www.udi.no/en/word-definitions/airport-transit-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a Type A visa let me leave Oslo Airport?', 'No — a Type A Airport Transit Visa only authorizes remaining in the international transit zone; it does not permit passing through Norwegian passport control or entering Norway.', 138, 6, 13806, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    138, 7, 'NOR-MED-IN-07', '2026.09', 'published',
    'Travel to Norway for medical treatment.',
    'Indian nationals travelling for treatment — the same Schengen C-type visa as Tourist, requiring a certificate from the treating Norwegian doctor/institution confirming the need for specific treatment.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with the medical certificate and Schengen-compliant insurance',
    1,
    'Standard Schengen processing is typically around 15 working days, can extend if documentation is incomplete',
    'Royal Norwegian Embassy, New Delhi (decision authority), via VFS Global centres across India',
    'Obtain a certificate from the treating Norwegian doctor/institution\nArrange Schengen-compliant travel insurance (min. €30,000 cover)\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/norway.webp',
    'Cross-checked against Norway MFA visitor-visa guidance and VFS/agency secondary sourcing via search snippets; norway.no direct fetch was blocked this session', 'https://www.norway.no/en/india/services-info/visitors-visa-res-permit/visitors-visa/', '2026-09-17'
);
SET @nor7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nor7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor7, 'Core Documents', 'Required from every applicant.', 1);
SET @nor7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nor7s1, 'Medical Certificate/Institution Confirmation', NULL, 'original', 1, 0, 1, 2),
(@nor7s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @nor7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@nor7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(138, 7, 80.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge of approximately €20.', '2026-09-01', NOW(), 'https://www.norway.no/en/india/services-info/visitors-visa-res-permit/visitors-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What insurance coverage do I need for a Norway medical visa?', 'Schengen-compliant travel medical insurance covering at least €30,000, valid across the whole Schengen area for your full trip, is mandatory in addition to your medical certificate and funds proof.', 138, 7, 13807, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    138, 8, 'NOR-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, and trade fairs in Norway.',
    'Indian nationals attending a conference — the same Schengen C-type visa as Tourist/Business, requiring a conference invitation or registration confirmation as the differentiating document.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a conference invitation/registration confirmation',
    1,
    'Standard Schengen processing is typically around 15 working days',
    'Royal Norwegian Embassy, New Delhi (decision authority), via VFS Global centres across India',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/norway.webp',
    'Cross-checked against Norway MFA visitor-visa guidance and VFS/agency secondary sourcing via search snippets; norway.no direct fetch was blocked this session', 'https://www.norway.no/en/india/services-info/visitors-visa-res-permit/visitors-visa/', '2026-09-17'
);
SET @nor8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nor8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor8, 'Core Documents', 'Required from every applicant.', 1);
SET @nor8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nor8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @nor8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@nor8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(138, 8, 80.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge of approximately €20.', '2026-09-01', NOW(), 'https://www.norway.no/en/india/services-info/visitors-visa-res-permit/visitors-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need an employer forwarding letter for a Conference visa?', 'It is conditional — VFS/the embassy may request a forwarding letter from your employer alongside the conference invitation, depending on your case.', 138, 8, 13808, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    138, 9, 'NOR-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Norway.',
    'Indian nationals competing or officiating — the same Schengen C-type visa as Tourist/Conference. A host-organizer invitation confirming participation and expense arrangements is typically required; a supporting letter from the applicant''s national sports federation is common Schengen practice, though this exact dual-letter requirement was not separately confirmed for Norway this session.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a host-organizer invitation letter confirming event participation',
    1,
    'Standard Schengen processing is typically around 15 working days',
    'Royal Norwegian Embassy, New Delhi (decision authority), via VFS Global centres across India',
    'Obtain an invitation letter from the host event organizer with event details and expense arrangements\nOptionally obtain a supporting letter from your national sports federation\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/norway.webp',
    'Cross-checked against Norway MFA/VFS Schengen visitor-visa guidance via search snippets; the specific sports-event documentary convention was not separately confirmed for Norway and norway.no direct fetch was blocked this session', 'https://www.norway.no/en/india/services-info/visitors-visa-res-permit/visitors-visa/', '2026-09-17'
);
SET @nor9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nor9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor9, 'Core Documents', 'Required from every applicant.', 1);
SET @nor9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nor9s1, 'Host Event Organizer Invitation Letter', 'Confirms event details and expense arrangements.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @nor9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor9s2, 'National Sports Federation Letter', 'Recommended but not separately confirmed as mandatory for Norway.', 'if_applicable', 0, 1, 0, 1),
(@nor9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(138, 9, 80.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge of approximately €20.', '2026-09-01', NOW(), 'https://www.norway.no/en/india/services-info/visitors-visa-res-permit/visitors-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a national federation letter mandatory for a Norway Sports visa?', 'It strengthens your application and is common Schengen practice, but this session could not separately confirm it as a strict Norway-specific requirement — check with VFS or the embassy before applying.', 138, 9, 13809, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — UDI Family Immigration Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    138, 10, 'NOR-DEP-IN-10', '2026.09', 'published',
    'Spouse, registered partner, or minor children joining a family member who is Norwegian/Nordic or holds a Norwegian residence permit.',
    'Family members of a person who is Norwegian, Nordic, or holds a permanent (or otherwise qualifying) Norwegian residence permit. Both spouses generally must be over 23. The Norway-based sponsor must meet an income requirement, currently NOK 436,957/year pre-tax, adjusted every May.',
    'Tied to the sponsor''s permit validity; renewable',
    'Register online via the UDI portal and pay the fee, then attend a VFS Global appointment in India to submit documents',
    1,
    'Family immigration processing time varies widely by case type and complexity; check current UDI case-type estimates before applying',
    'Royal Norwegian Embassy, New Delhi, via the UDI online portal and VFS Global',
    'Confirm the sponsor meets the income requirement and holds a qualifying status/permit\nRegister the application and pay the fee via the UDI portal\nGather relationship proof (marriage/birth certificates) and the sponsor''s permit copy\nBook a VFS Global appointment to submit documents\nAwait the UDI decision, then register with the police in Norway on arrival',
    '/assets/images/visa-heroes/norway.webp',
    'Cross-checked against UDI family-immigration and income-requirement guidance via search snippets; udi.no direct fetch was blocked this session', 'https://www.udi.no/en/want-to-apply/family-immigration/', '2026-09-17'
);
SET @nor10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nor10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor10, 'Core Documents', 'Required from every applicant.', 1);
SET @nor10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nor10s1, 'Proof of Relationship to Sponsor (Marriage/Birth Certificate)', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nor10, 'Supporting Documents', 'Evidence tied to the sponsor''s status and income.', 2);
SET @nor10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nor10s2, 'Sponsor''s Residence Permit/Citizenship Document Copy', NULL, 'copy', 1, 0, 0, 1),
(@nor10s2, 'Proof of Sponsor''s Income (NOK 436,957/Year)', NULL, 'copy', 1, 0, 0, 2),
(@nor10s2, 'Proof of Sponsor''s Accommodation in Norway', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(138, 10, 11900.00, 'NOK', 'UDI Family Immigration Permit Fee (First-Time Applicant)', 'Fee for a first-time family immigration application; renewal and other family-member fees may differ — confirm the current NOK amount on udi.no.', '2026-09-01', NOW(), 'https://www.udi.no/en/want-to-apply/family-immigration/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a minimum age for spousal family immigration to Norway?', 'Yes — both spouses generally must be over 23 years old for a spousal family immigration application, alongside the sponsor''s income requirement (currently NOK 436,957/year pre-tax).', 138, 10, 13810, 1);
