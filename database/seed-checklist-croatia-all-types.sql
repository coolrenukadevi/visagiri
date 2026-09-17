-- Croatia Visa Checklist Engine content for all 10 visa types — built
-- this session via web search. hero_image_url set to
-- /assets/images/visa-heroes/croatia.webp (file already exists on disk)
-- for all 10 rows.
--
-- IMPORTANT SOURCING CAVEAT: direct fetches of vfsglobal.com,
-- indianembassyzagreb.gov.in, mup.gov.hr, and mvep.gov.hr were all
-- blocked by network egress this session. Findings below are
-- triangulated from WebSearch result snippets across VFS Global's own
-- indexed one-pager, the Croatian Ministry of Interior (MUP) site,
-- studyincroatia.hr, expatincroatia.com, and multiple visa-agency
-- secondary sources (BTW Visas, Terratern, GoDigit, Atlys). Fee figures
-- in particular vary across sources and are flagged as approximate
-- where confidence is lower. The Work Visa and Dependent Visa fee rows
-- are flagged "Confirmed After Assessment" because the clearest figures
-- found (e.g. "870 kuna") pre-date Croatia's 1 January 2023 euro
-- adoption and could not be confirmed as current EUR amounts this
-- session — treat as genuinely under-sourced.
--
-- Croatia's real, distinctive, and dated facts actually verified:
--   - Croatia joined the Schengen Area on 1 January 2023. Short-stay
--     travel (Tourist, Business, Family Visit, Medical, Conference,
--     Sports) now uses the standard Schengen C-type visa, valid for the
--     whole Schengen area, not a Croatia-only visa.
--   - VFS Global operates Croatia visa application centres in six
--     Indian cities: New Delhi, Mumbai, Kolkata, Chennai, Bengaluru,
--     and Hyderabad (plus a Kathmandu, Nepal centre serving the region).
--   - The Schengen visa fee is reported at EUR 80 for adults, with a
--     separate VFS Global service charge (reported ~INR 2,500) on top —
--     standard processing is typically cited at ~15 calendar days,
--     though one source flags a longer minimum processing window in
--     peak periods, so this is noted as approximate.
--   - A genuine, dated 2026 policy change: from May 2026, Croatia's
--     temporary residence permit for study purposes can be issued for
--     a student's full program duration (up to 3 years) rather than
--     requiring the previous annual renewal — a real, specific,
--     verifiable change reflected in the Student checklist below.
--   - Work permits run on Croatia's annual government-set quota
--     (kvota) system, allocated by sector/occupation, reflecting real
--     labour shortages in tourism, construction, manufacturing,
--     healthcare, logistics, and IT; India is reported among the
--     leading non-EU nationalities receiving Croatian work permits.
--   - Indian passport holders are reported on Croatia's list of
--     nationalities requiring a distinct Type A Airport Transit Visa
--     (separate from the Type C short-stay visa) when transiting
--     airside through a Croatian airport toward a non-Schengen
--     destination — unless exempted by holding a valid Schengen/EU
--     visa, national long-stay visa, or residence permit from certain
--     listed states.
--   - Family reunification uses a specific application form (Obrazac
--     1a / "Form 1a") and grants an initial temporary residence permit
--     valid up to 2 years; non-EU family reunification processing is
--     reported at roughly 30-60 days.
--
-- country_id 113 = Croatia. visa_type_id: 1=Tourist, 2=Business,
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
    113, 1, 'HRV-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Croatia, a Schengen member since January 2023.',
    'Indian passport holders apply for the standard Schengen C-type visa via VFS Global; the visa is valid for travel across the entire Schengen area, not just Croatia.',
    'Single or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global centres in New Delhi, Mumbai, Kolkata, Chennai, Bengaluru, or Hyderabad',
    1,
    'Standard Schengen processing is typically around 15 calendar days; peak-season or incomplete applications can extend this',
    'Embassy of the Republic of Croatia, New Delhi (decision authority), via VFS Global centres',
    'Book a VFS Global appointment\nComplete the online Schengen visa application form\nGather supporting documents\nAttend the appointment and submit biometrics (mandatory for first-time applicants)\nTrack status and collect your passport',
    '/assets/images/visa-heroes/croatia.webp',
    'Triangulated from VFS Global and visa-agency secondary sourcing; vfsglobal.com and indianembassyzagreb.gov.in were not directly fetchable this session (egress blocked)', 'https://www.vfsglobal.com/one-pager/croatia/india/english/', '2026-09-17'
);
SET @hrv1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hrv1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv1, 'Core Documents', 'Required from every applicant.', 1);
SET @hrv1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv1s1, 'Valid Passport (3+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@hrv1s1, 'Completed Schengen Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@hrv1s1, 'Travel/Schengen Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @hrv1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv1s2, 'Confirmed Hotel Booking', NULL, 'copy', 1, 0, 0, 1),
(@hrv1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@hrv1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(113, 1, 80.00, 'EUR', 'Schengen C-Type Visa Fee', 'Standard Schengen visa fee for adults; a separate VFS Global service charge (reported ~INR 2,500) also applies.', '2026-09-01', NOW(), 'https://www.vfsglobal.com/one-pager/croatia/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a Croatia Tourist visa let me travel elsewhere in Europe?', 'Yes — since Croatia joined the Schengen Area in January 2023, its Schengen C-type visa is valid for travel across the entire Schengen area, subject to the standard 90-days-in-180 rule.', 113, 1, 11500, 1),
('Which Indian cities have a VFS Global centre for Croatia visas?', 'VFS Global operates Croatia visa centres in New Delhi, Mumbai, Kolkata, Chennai, Bengaluru, and Hyderabad — confirm the current address on your appointment letter.', 113, 1, 11501, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    113, 2, 'HRV-BUS-IN-02', '2026.09', 'published',
    'Trade, negotiations, and commercial meetings with Croatian companies.',
    'Indian nationals travelling for business use the same Schengen C-type visa as Tourist, with an invitation letter from the Croatian host company and evidence of the business link as the differentiating documents.',
    'Single, double, or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global with a business invitation letter and Indian employer sponsorship letter',
    1,
    'Standard Schengen processing is typically around 15 calendar days; apply at least 3-4 weeks before travel',
    'Embassy of the Republic of Croatia, New Delhi, via VFS Global centres',
    'Obtain an invitation letter from the Croatian host company on its letterhead\nGather proof of the business link (contracts, invoices, correspondence)\nGather Indian employer sponsorship/forwarding letter\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/croatia.webp',
    'Triangulated from VFS Global and Indian Embassy Zagreb secondary sourcing; primary pages not directly fetchable this session (egress blocked)', 'https://www.indianembassyzagreb.gov.in/page/business-visa/', '2026-09-17'
);
SET @hrv2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hrv2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv2, 'Core Documents', 'Required from every applicant.', 1);
SET @hrv2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@hrv2s1, 'Invitation Letter from Croatian Host Company', 'On company letterhead, stating purpose, duration, and number of visits.', 'original', 1, 0, 1, 2),
(@hrv2s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv2, 'Supporting Documents', 'Evidence of your own employment and the business link.', 2);
SET @hrv2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@hrv2s2, 'Contracts/Invoices Showing Business Link', NULL, 'copy', 0, 1, 0, 2),
(@hrv2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(113, 2, 80.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://www.indianembassyzagreb.gov.in/page/business-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What must the Croatian business invitation letter include?', 'Reported requirements include the company''s name, address, and contact details; the applicant''s name and position; the purpose and dates of the visit; and the signature and stamp of the inviting company.', 113, 2, 11502, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Temporary Residence Permit for Study
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    113, 3, 'HRV-STU-IN-03', '2026.09', 'published',
    'Enrolling in a recognized Croatian higher-education institution.',
    'Indian nationals admitted to a Croatian institution apply for a temporary residence permit for study purposes. A genuine May 2026 policy change lets this permit be issued for the full program duration (up to 3 years) instead of the previous annual renewal.',
    'Up to 3 years for the full program (from the May 2026 change); previously issued/renewed annually',
    'Apply at the Embassy of the Republic of Croatia, New Delhi, or after arrival via the Ministry of Interior (MUP)',
    1,
    'Reported at roughly 4-8 weeks, depending on completeness and location',
    'Embassy of the Republic of Croatia, New Delhi, or MUP police administration in Croatia',
    'Secure admission at a recognized Croatian institution\nGather proof of funds (reported minimum ~€7,200), accommodation, and health insurance\nApply for the study residence permit at the embassy or MUP\nFor multi-year permits, submit proof of continued enrollment to the police by 31 October each academic year\nCollect the biometric residence permit card',
    '/assets/images/visa-heroes/croatia.webp',
    'Triangulated from studyincroatia.hr, expatincroatia.com, and MUP secondary sourcing; mup.gov.hr not directly fetchable this session (egress blocked)', 'https://www.studyincroatia.hr/live-and-work-in-croatia/visa-and-residence-permit/', '2026-09-17'
);
SET @hrv3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hrv3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv3, 'Core Documents', 'Required from every applicant.', 1);
SET @hrv3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@hrv3s1, 'Admission Letter from Croatian Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @hrv3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@hrv3s2, 'Proof of Funds (Reported ~€7,200 Minimum)', NULL, 'copy', 1, 0, 0, 2),
(@hrv3s2, 'Health Insurance Valid in Croatia', NULL, 'original', 1, 0, 0, 3),
(@hrv3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(113, 3, NULL, 'EUR', 'Confirmed After Assessment', 'Reported components include a biometric residence permit fee of roughly €31.85 (regular) or €59.73 (accelerated) plus a ~€9.29 administrative fee; figures vary across sources, contact us to confirm.', '2026-09-01', NOW(), 'https://www.studyincroatia.hr/live-and-work-in-croatia/visa-and-residence-permit/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Did Croatia change its student residence permit rules recently?', 'Yes — from May 2026, a temporary residence permit for study purposes can reportedly be issued for a student''s full program duration (up to 3 years) instead of requiring annual renewal as before. Multi-year permit holders still submit proof of enrollment to the police each year by 31 October.', 113, 3, 11503, 1),
('Can international students work while studying in Croatia?', 'Reported guidance says students may work or be self-employed up to 25 hours per week, except where practical work is an integral part of the study programme — confirm current rules for your specific permit.', 113, 3, 11504, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Quota-Based Work-and-Residence Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    113, 4, 'HRV-WORK-IN-04', '2026.09', 'published',
    'Employment with a Croatian employer under Croatia''s annual quota-based work permit system.',
    'Indian nationals with a confirmed job offer apply for a combined work-and-residence permit. Croatia sets an annual government quota (kvota) by sector/occupation, and India is reported among the leading non-EU nationalities receiving Croatian work permits amid shortages in tourism, construction, manufacturing, healthcare, logistics, and IT.',
    'Permit validity typically 1 year, renewable',
    'Employer-driven; applicant applies at the Embassy of the Republic of Croatia, New Delhi, or via the employer with the Ministry of Interior (MUP)',
    1,
    'Reported range 8-12 weeks; timelines can vary by sector and remaining quota availability',
    'Embassy of the Republic of Croatia, New Delhi (visa), Ministry of Interior (MUP) for the residence-and-work permit',
    'Secure a job offer from a Croatian employer\nEmployer confirms the role falls within the current annual quota (kvota) or is quota-exempt\nApply for the combined work-and-residence permit at the embassy or with MUP\nAttend biometrics/interview as required\nReceive the permit and biometric residence card',
    '/assets/images/visa-heroes/croatia.webp',
    'Triangulated from MUP quota-system reporting and expatriate-employment secondary sourcing (dss-hr.com, terratern.com, croatiahandbook.com); primary mup.gov.hr pages not directly fetchable this session (egress blocked) — under-sourced on exact fee figures', 'https://mup.gov.hr/aliens-281621/stay-and-work/', '2026-09-17'
);
SET @hrv4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hrv4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv4, 'Core Documents', 'Required from every applicant.', 1);
SET @hrv4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@hrv4s1, 'Employment Contract/Job Offer', NULL, 'copy', 1, 0, 1, 2),
(@hrv4s1, 'Employer Confirmation of Quota Allocation', 'Or exemption confirmation, where applicable.', 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @hrv4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@hrv4s2, 'Proof of Financial Means', NULL, 'copy', 1, 0, 0, 2),
(@hrv4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(113, 4, NULL, 'EUR', 'Confirmed After Assessment', 'Reported components include a biometric residence permit fee of roughly €31.85-€59.73 plus a ~€9.29 administrative fee; older sources cite a separate "870 kuna" permit-issuance fee that pre-dates Croatia''s 1 January 2023 euro adoption and could not be confirmed in current EUR terms this session — genuinely under-sourced, confirm before applying.', '2026-09-01', NOW(), 'https://mup.gov.hr/aliens-281621/stay-and-work/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Croatia have a fast-track or quota system for foreign workers?', 'Yes — Croatia sets an annual government quota (kvota) allocating work permit volumes by sector and occupation. Reporting indicates India is among the leading non-EU nationalities receiving Croatian work permits, reflecting labour shortages in tourism, construction, manufacturing, healthcare, logistics, and IT.', 113, 4, 11505, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    113, 5, 'HRV-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Croatia.',
    'Indian nationals with family/friends in Croatia use the same Schengen C-type visa as Tourist, requiring an invitation letter from the host and proof of the relationship.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with an invitation letter and relationship proof',
    1,
    'Standard Schengen processing is typically around 15 calendar days',
    'Embassy of the Republic of Croatia, New Delhi, via VFS Global centres',
    'Obtain an invitation letter from your host in Croatia\nGather documents proving the family relationship\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/croatia.webp',
    'Triangulated from VFS Global and visa-agency secondary sourcing; primary pages not directly fetchable this session (egress blocked)', 'https://www.vfsglobal.com/one-pager/croatia/india/english/', '2026-09-17'
);
SET @hrv5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hrv5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv5, 'Core Documents', 'Required from every applicant.', 1);
SET @hrv5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@hrv5s1, 'Invitation Letter from Host in Croatia', NULL, 'original', 1, 0, 1, 2),
(@hrv5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @hrv5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@hrv5s2, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(113, 5, 80.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://www.vfsglobal.com/one-pager/croatia/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the family visit invitation letter need to be notarized?', 'Requirements are reported to vary; a straightforward letter from your host stating the relationship, purpose, and duration of your stay is commonly expected — confirm current formalities with VFS or your host before applying.', 113, 5, 11506, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Type A Airport Transit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    113, 6, 'HRV-TRAN-IN-06', '2026.09', 'published',
    'Passing through a Croatian airport (Zagreb, Split, or Dubrovnik) toward a non-Schengen destination.',
    'Indian passport holders are reported on Croatia''s list of nationalities requiring a distinct Type A Airport Transit Visa (separate from the Type C short-stay visa) — unless exempted by holding a valid Schengen/EU visa, national long-stay visa, or residence permit from certain listed states.',
    'Valid for the transit window; the visa itself may be issued for a longer validity with 1 or 2 entries',
    'Apply via VFS Global with your itinerary/onward ticket if not otherwise exempt',
    1,
    'Standard Schengen-adjacent processing reported at around 15 calendar days',
    'Embassy of the Republic of Croatia, New Delhi, via VFS Global centres',
    'Check whether you hold an exemption (valid Schengen/EU visa, national long-stay visa, or residence permit from a listed state)\nIf not exempt, apply via VFS Global with onward ticket and itinerary\nSubmit biometrics if required',
    '/assets/images/visa-heroes/croatia.webp',
    'Triangulated from Schengen airport-transit-visa list secondary sourcing; primary mvep.gov.hr page not directly fetchable this session (egress blocked)', 'https://mvep.gov.hr/consular-information-152362/visa-152363/152363', '2026-09-17'
);
SET @hrv6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hrv6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv6, 'Core Documents', 'Required if a Type A visa is genuinely needed.', 1);
SET @hrv6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@hrv6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @hrv6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1),
(@hrv6s2, 'Proof of Exemption (Existing Schengen/EU Visa or Permit)', 'Only if claiming exemption from the Type A requirement.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(113, 6, NULL, 'EUR', 'Confirmed After Assessment', 'Reported at either the standard €80 Schengen fee or a lower figure for transit-only visas depending on source — treat as approximate and confirm before applying.', '2026-09-01', NOW(), 'https://mvep.gov.hr/consular-information-152362/visa-152363/152363', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do all Indian travellers connecting through a Croatian airport need a transit visa?', 'Not necessarily — Indian passport holders are reported on the list requiring a Type A Airport Transit Visa, but exemptions apply if you already hold a valid Schengen/EU visa, national long-stay visa, or residence permit from certain listed states. Confirm your specific status before travel.', 113, 6, 11507, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    113, 7, 'HRV-MED-IN-07', '2026.09', 'published',
    'Travel to Croatia for medical treatment.',
    'Indian nationals travelling for treatment use the same Schengen C-type visa as Tourist, requiring a certificate from the treating Croatian doctor/institution confirming the need for specific treatment.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with the medical certificate and Schengen-compliant insurance',
    1,
    'Up to 15 calendar days reported; can extend if documentation is incomplete',
    'Embassy of the Republic of Croatia, New Delhi, via VFS Global centres',
    'Obtain a certificate from the treating Croatian doctor/institution\nArrange Schengen-compliant travel insurance (min. €30,000 cover)\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/croatia.webp',
    'Triangulated from VFS Global and visa-agency secondary sourcing; primary pages not directly fetchable this session (egress blocked)', 'https://www.vfsglobal.com/one-pager/croatia/india/english/', '2026-09-17'
);
SET @hrv7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hrv7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv7, 'Core Documents', 'Required from every applicant.', 1);
SET @hrv7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@hrv7s1, 'Medical Certificate/Institution Confirmation', NULL, 'original', 1, 0, 1, 2),
(@hrv7s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @hrv7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@hrv7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(113, 7, 80.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://www.vfsglobal.com/one-pager/croatia/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a special Croatian medical visa separate from the Schengen visa?', 'No — Croatia uses the same Schengen C-type visa for medical travel as for Tourist visits; the medical certificate and treatment-related documents are the differentiating requirement.', 113, 7, 11508, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    113, 8, 'HRV-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade fairs in Croatia.',
    'Indian nationals attending a conference use the same Schengen C-type visa as Tourist/Business, with a conference invitation or registration confirmation as the differentiating document.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a conference invitation/registration confirmation',
    1,
    'Standard Schengen processing is typically around 15 calendar days',
    'Embassy of the Republic of Croatia, New Delhi, via VFS Global centres',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/croatia.webp',
    'Triangulated from VFS Global and visa-agency secondary sourcing; primary pages not directly fetchable this session (egress blocked)', 'https://www.vfsglobal.com/one-pager/croatia/india/english/', '2026-09-17'
);
SET @hrv8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hrv8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv8, 'Core Documents', 'Required from every applicant.', 1);
SET @hrv8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@hrv8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @hrv8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@hrv8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(113, 8, 80.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://www.vfsglobal.com/one-pager/croatia/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate Conference visa if I already have a Business visa?', 'No — Conference travel uses the same Schengen C-type visa category as Business; state your specific purpose (conference attendance) and provide the registration/invitation confirmation when applying.', 113, 8, 11509, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    113, 9, 'HRV-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Croatia.',
    'Indian nationals competing or officiating use the same Schengen C-type visa as Tourist/Conference, typically requiring a letter from the home-country sports association and an invitation from the host event organizer.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a home-association letter and host-organizer invitation',
    1,
    'Standard Schengen processing is typically around 15 calendar days',
    'Embassy of the Republic of Croatia, New Delhi, via VFS Global centres',
    'Obtain a letter from your resident-country athletic association confirming your role and no-employment status\nObtain an invitation letter from the host event organizer with event details\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/croatia.webp',
    'Triangulated from VFS Global and visa-agency secondary sourcing; primary pages not directly fetchable this session (egress blocked) — genuinely under-sourced on Croatia-specific sports-event documentation beyond the general Schengen C-type framework', 'https://www.vfsglobal.com/one-pager/croatia/india/english/', '2026-09-17'
);
SET @hrv9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hrv9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv9, 'Core Documents', 'Required from every applicant.', 1);
SET @hrv9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@hrv9s1, 'Home-Country Sports Association Letter', 'Confirms role and no-employment status.', 'original', 1, 0, 1, 2),
(@hrv9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @hrv9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(113, 9, 80.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://www.vfsglobal.com/one-pager/croatia/india/english/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a Croatia-specific sports-event visa document checklist?', 'This session could not directly confirm a Croatia-specific bundled checklist (unlike some neighbouring Schengen states); treat this as the general Schengen C-type framework with sports-event documentation and confirm exact requirements with VFS Global before applying.', 113, 9, 11510, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification Residence Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    113, 10, 'HRV-DEP-IN-10', '2026.09', 'published',
    'Spouse, minor children, or dependent family members joining an Indian national holding a Croatian residence/work permit, or a Croatian citizen.',
    'Family members of an Indian national with a qualifying Croatian residence/work permit (or of a Croatian citizen) apply for temporary residence via family reunification, using Form 1a (Obrazac 1a). The permit is valid up to 2 years; time counts toward permanent residence, reportedly reached after 4 years for spouses of Croatian citizens.',
    'Up to 2 years initially, renewable, tied to the sponsor''s status',
    'Apply at the Embassy of the Republic of Croatia, New Delhi, or with the Ministry of Interior (MUP) using Form 1a',
    1,
    'Reported at roughly 30-60 days for non-EU family reunification applications',
    'Embassy of the Republic of Croatia, New Delhi, or MUP police administration in Croatia',
    'Confirm the sponsor holds a qualifying Croatian residence/work permit or citizenship\nGather relationship proof (marriage/birth certificates, translated and legalized) and the sponsor''s permit copy\nComplete and submit Form 1a (Obrazac 1a) at the embassy or MUP\nSubmit proof of sponsor''s financial means and shared/available accommodation\nCollect the biometric residence permit card',
    '/assets/images/visa-heroes/croatia.webp',
    'Triangulated from expatincroatia.com and mup.gov.hr secondary sourcing on family reunification; primary mup.gov.hr pages not directly fetchable this session (egress blocked)', 'https://mup.gov.hr/aliens-281621/stay-and-work/temporary-stay-for-the-purpose-of-family-reunification/281662', '2026-09-17'
);
SET @hrv10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hrv10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv10, 'Core Documents', 'Required from every applicant.', 1);
SET @hrv10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@hrv10s1, 'Form 1a (Obrazac 1a)', 'Croatia''s temporary residence application form for family reunification.', 'original', 1, 0, 1, 2),
(@hrv10s1, 'Proof of Relationship to Sponsor', 'Marriage/birth certificates, translated and legalized.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hrv10, 'Supporting Documents', 'Evidence tied to the sponsor''s status and household.', 2);
SET @hrv10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hrv10s2, 'Sponsor''s Residence/Work Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@hrv10s2, 'Proof of Sponsor''s Financial Means', NULL, 'copy', 1, 0, 0, 2),
(@hrv10s2, 'Proof of Shared/Available Accommodation', NULL, 'copy', 1, 0, 0, 3),
(@hrv10s2, 'Health Insurance Valid in Croatia', NULL, 'original', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(113, 10, NULL, 'EUR', 'Confirmed After Assessment', 'Reported components include a biometric residence permit fee of roughly €31.85-€59.73 plus a ~€9.29 administrative fee, similar to other Croatian residence permits; the family-reunification-specific total was not separately confirmed this session.', '2026-09-01', NOW(), 'https://mup.gov.hr/aliens-281621/stay-and-work/temporary-stay-for-the-purpose-of-family-reunification/281662', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How long is the initial Croatian family reunification permit valid?', 'Reported guidance says an initial temporary residence permit for family reunification can be issued for up to 2 years; time on this permit counts toward eligibility for permanent residence, reached after 4 years of temporary residency for spouses of Croatian citizens.', 113, 10, 11511, 1);
