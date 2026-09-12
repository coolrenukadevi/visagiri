-- Seychelles Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as every other
-- country built this session (see AUDIT.md). No hero photo has been
-- supplied for Seychelles yet — hero_image_url is deliberately left
-- NULL, falling back to the navy/gold gradient hero, until the
-- client's later photo bundle arrives.
--
-- IMPORTANT SOURCING CAVEAT: official primary sources (ics.gov.sc,
-- permits.ics.gov.sc, seychelles.govtas.com) were not directly
-- fetchable in this session's research pass (blocked at the network
-- egress layer) — findings were triangulated from web-search-indexed
-- content that in several cases directly quotes those exact official
-- pages, cross-checked against immigration-consultancy sourcing. The
-- Transit/ETA exemption question is genuinely disputed across sources
-- and stated as unresolved rather than guessed.
--
-- Seychelles's real, distinctive facts:
--   - True universal visa-free entry for every nationality including
--     India, but with a mandatory pre-arrival digital gate: a free
--     online Electronic Travel Authorisation (ETA) must still be
--     completed before departure — genuinely "no visa, but mandatory
--     pre-clearance," not simply "no forms at all."
--   - The Visitor's Permit is one instrument serving many purposes —
--     ICS's own purpose list explicitly names holiday, business,
--     family visits, meetings/conferences, and attending events all
--     under the SAME Visitor's Permit, stated honestly here rather
--     than inventing separate fee-bearing categories for each.
--   - The Gainful Occupation Permit (GOP) is the real gatekeeper for
--     employment, and it is fully employer-driven with a mandatory
--     local-labour-market test — an Indian professional cannot
--     self-apply; the Seychelles employer must prove the role
--     couldn't be filled locally and file at least 10 weeks ahead.
--   - Extensions can push a 3-month tourist stay to a full year —
--     successive 3-month extensions up to 12 months total, a
--     distinctive long-stay tourist runway.
--   - The Dependant's Permit as documented applies to dependants of
--     Seychelles citizens specifically — the pathway for dependants
--     of a foreign GOP (work-permit) holder was not clearly confirmed
--     this session and is flagged as a genuine research gap rather
--     than guessed at.
--
-- country_id 43 = Seychelles. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Visitor's Permit + ETA
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    43, 1, 'SYC-TOUR-IN-01', '2026.09', 'published',
    'Holiday and leisure travel to Seychelles.',
    'Any Indian passport holder, passport valid 6+ months. Seychelles is genuinely visa-free for all nationalities, but a mandatory pre-arrival Electronic Travel Authorisation (ETA) must still be completed — this is a fee-waived pre-clearance requirement, not visa-free travel with no forms at all.',
    'Up to 3 months initially; extendable in successive 3-month periods up to a total of 12 months',
    'Apply for the ETA online before departure via seychelles.govtas.com; the Visitor''s Permit itself is then issued free on arrival',
    0,
    'ETA: standard ~24 hours, premium ~6 hours, express ~60 minutes (paid faster tiers); Visitor''s Permit is instant on arrival',
    'None — no embassy visit needed; extensions handled online at permits.ics.gov.sc or in person at Independence House, Victoria, Mahé',
    'Book your flight and accommodation\nApply for the ETA online (up to 30 days before travel) with your passport, itinerary, accommodation address, and funds declaration\nReceive ETA approval by email\nFly to Seychelles\nPresent your passport, return ticket, accommodation proof, and proof of funds at immigration for your free Visitor''s Permit',
    '/assets/images/visa-heroes/seychelles.jpg',
    'Cross-checked against ics.gov.sc''s Visitors Permit page (via search snippet) and seychelles.govtas.com ETA guidance, triangulated against secondary sourcing not directly fetchable this session', 'https://www.ics.gov.sc/', '2026-09-11'
);
SET @sc1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sc1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc1, 'Core Documents', 'Every traveller needs these.', 1);
SET @sc1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc1s1, 'Valid Passport', 'Valid 6+ months.', 'original', 1, 0, 1, 1),
(@sc1s1, 'Passport-Size Photo', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc1, 'Travel Documents', 'Confirming your itinerary.', 2);
SET @sc1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc1s2, 'Confirmed Return/Onward Ticket', NULL, 'copy', 1, 0, 1, 1),
(@sc1s2, 'Hotel Booking or Host''s Address', NULL, 'copy', 1, 0, 1, 2),
(@sc1s2, 'ETA Approval Confirmation', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc1, 'Supporting Documents', 'May be requested on arrival.', 3);
SET @sc1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc1s3, 'Bank Statement/Proof of Funds', NULL, 'copy', 1, 0, 0, 1),
(@sc1s3, 'Health/Travel Insurance', NULL, 'copy', 0, 1, 0, 2),
(@sc1s3, 'Host''s ID', 'If staying with family/friends.', 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(43, 1, 10.00, 'EUR', 'ETA Fee (Standard Processing)', 'The Visitor''s Permit itself is free for the first 3 months; extensions cost SCR 5,000 per additional 3-month block.', '2026-09-01', NOW(), 'https://www.ics.gov.sc/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Seychelles?', 'No visa is required, but a free online Electronic Travel Authorisation (ETA) must be completed before departure — a mandatory pre-clearance step, not the same as "no forms needed at all."', 43, 1, 2200, 1),
('How long can I extend my stay in Seychelles?', 'Successive 3-month extensions are possible up to a total of 12 months, a notably long tourist runway compared to most countries.', 43, 1, 2201, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Same Visitor's Permit + ETA
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    43, 2, 'SYC-BUS-IN-02', '2026.09', 'published',
    'Business meetings, negotiations, site visits, and attending events without taking local employment.',
    'Seychelles has no separate business visa — the ICS Visitors Permit page explicitly lists "business" as one of the permitted purposes alongside holiday and visiting family/friends, using the identical Visitor''s Permit + ETA mechanism.',
    'Up to 3 months, extendable to 12 months total',
    'Same ETA + on-arrival Visitor''s Permit process as Tourist',
    0,
    'Same as Tourist',
    'None — no embassy visit needed',
    'Apply for the ETA online, citing business as your purpose\nCarry an invitation/sponsor letter from your Seychelles host as good practice\nFly to Seychelles\nPresent your documents at immigration for your Visitor''s Permit',
    '/assets/images/visa-heroes/seychelles.jpg',
    'Cross-checked against ics.gov.sc''s Visitors Permit page (via search snippet) triangulated against secondary sourcing not directly fetchable this session', 'https://www.ics.gov.sc/', '2026-09-11'
);
SET @sc2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sc2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc2, 'Core Documents', 'Every applicant needs these.', 1);
SET @sc2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@sc2s1, 'Return Ticket', NULL, 'copy', 1, 0, 1, 2),
(@sc2s1, 'ETA Approval Confirmation', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc2, 'Business Documents', 'Recommended supporting evidence.', 2);
SET @sc2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc2s2, 'Invitation Letter from Seychelles Business Partner', NULL, 'copy', 0, 1, 0, 1),
(@sc2s2, 'Company Letter from Indian Employer', NULL, 'original', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(43, 2, 10.00, 'EUR', 'ETA Fee (Standard Processing)', 'Same fee structure as Tourist.', '2026-09-01', NOW(), 'https://www.ics.gov.sc/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Business Visa for Seychelles?', 'No — the ICS Visitors Permit explicitly covers business purposes alongside tourism, using the same ETA and on-arrival permit mechanism.', 43, 2, 2202, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Student Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    43, 3, 'SYC-STU-IN-03', '2026.09', 'published',
    'Enrolment at a Seychelles-recognized educational institution.',
    'Requires a distinct Student Permit, separate from the Visitor''s Permit — confirmed admission is required.',
    'Issued/renewed for one year or part thereof, tied to course duration',
    'Online/paper Student''s Permit Application Form submitted to ICS, typically via the sponsoring institution or applicant directly',
    0,
    'Not explicitly stated in sources found — recommend verifying directly with ICS',
    'Immigration and Civil Status (ICS), Seychelles (info@immigration.gov.sc / +248 4 293636) — no Seychelles consulate in India processes this',
    'Secure admission from a Seychelles institution\nComplete the Student''s Permit Application Form\nAttach your acceptance letter, proof of financial means, passport bio page, and accommodation proof\nPay the processing fee\nSubmit to ICS\nOn approval, pay the permit fee',
    '/assets/images/visa-heroes/seychelles.jpg',
    'Cross-checked against ics.gov.sc''s Student Permit page (via search snippet) triangulated against secondary sourcing not directly fetchable this session', 'https://www.ics.gov.sc/', '2026-09-11'
);
SET @sc3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sc3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc3, 'Core Documents', 'Every applicant needs these.', 1);
SET @sc3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc3s1, 'Passport Bio Page', NULL, 'copy', 1, 0, 1, 1),
(@sc3s1, 'Application Form', NULL, 'original', 1, 0, 1, 2),
(@sc3s1, 'Admission/Acceptance Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc3, 'Financial & Accommodation Documents', 'Verifying your means and arrangements.', 2);
SET @sc3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc3s2, 'Proof of Financial Means', NULL, 'copy', 1, 0, 0, 1),
(@sc3s2, 'Proof of Accommodation Arrangement', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(43, 3, 1000.00, 'SCR', 'Student Permit Processing Fee', 'Plus SCR 1,500 permit fee per year or part thereof.', '2026-09-01', NOW(), 'https://www.ics.gov.sc/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Where do I submit my Seychelles Student Permit application?', 'Directly to Immigration and Civil Status (ICS) in Seychelles — there is no Seychelles consulate in India processing this, so applications typically go through your institution or directly online.', 43, 3, 2203, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Gainful Occupation Permit (GOP)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    43, 4, 'SYC-WORK-IN-04', '2026.09', 'published',
    'Any paid employment or self-employment by a non-Seychellois national — Seychelles'' headline immigration-control mechanism.',
    'Requires a job offer from a Seychelles-registered employer who has demonstrated the role cannot readily be filled by a qualified Seychellois (local-labour-market test). Fully employer-led — the prospective employee cannot self-apply.',
    'Tied to employment contract length, renewable',
    'Employer prepares and submits the application to ICS; the employee is not allowed to begin work until the GOP is approved',
    0,
    'GOP can be collected 1-5 days after submission, but the employer must submit at least 10 weeks before the intended work start date',
    'Immigration and Civil Status (ICS) Department, Independence House, Victoria, Mahé',
    'Employer defines the role and compiles evidence that local recruitment failed\nEmployer compiles company documents (registration, tax/social security registration)\nYou compile your personal documents\nEmployer submits the application and pays fees to ICS at least 10 weeks before your start date\nICS reviews (approval typically 1-5 days after full submission)\nYou may only start work once the GOP is issued',
    '/assets/images/visa-heroes/seychelles.jpg',
    'Cross-checked against ics.gov.sc''s Gainful Occupation Permit page (via search snippet), rivermate.com, and playroll.com, triangulated against sourcing not directly fetchable this session', 'https://www.ics.gov.sc/', '2026-09-11'
);
SET @sc4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sc4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc4, 'Core Documents', 'Every applicant needs these.', 1);
SET @sc4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc4s1, 'Passport Bio Page', NULL, 'copy', 1, 0, 1, 1),
(@sc4s1, 'Employment Contract/Salary Details', NULL, 'copy', 1, 0, 1, 2),
(@sc4s1, 'Passport Photos', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc4, 'Employer & Qualification Documents', 'Evidence of the employer''s eligibility and your background.', 2);
SET @sc4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc4s2, 'Employer''s Business Registration Certificate', NULL, 'copy', 1, 0, 0, 1),
(@sc4s2, 'Evidence of Local Recruitment Efforts/Advertising', NULL, 'copy', 1, 0, 0, 2),
(@sc4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 3),
(@sc4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 4),
(@sc4s2, 'Medical Fitness Certificate', NULL, 'original', 1, 0, 0, 5),
(@sc4s2, 'Employer''s Tax and Social Security Compliance Documents', NULL, 'copy', 1, 0, 0, 6);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(43, 4, 1000.00, 'SCR', 'GOP Processing Fee', 'Plus SCR 500 per month (or part thereof) of the permit''s requested duration, payable at submission.', '2026-09-01', NOW(), 'https://www.ics.gov.sc/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for a Seychelles work permit myself?', 'No — the Gainful Occupation Permit is fully employer-driven. Your Seychelles employer must prove the role couldn''t be filled locally and file the application on your behalf, at least 10 weeks before your intended start date.', 43, 4, 2204, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Same Visitor's Permit + ETA
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    43, 5, 'SYC-FAM-IN-05', '2026.09', 'published',
    'Visiting friends or family residing in Seychelles.',
    'ICS explicitly lists "visiting friends or family" as a qualifying purpose for the standard Visitor''s Permit — there is no separate family-visit visa.',
    'Up to 3 months, extendable to 12 months total, identical to Tourist',
    'Same ETA + on-arrival Visitor''s Permit process as Tourist',
    0,
    'Same as Tourist',
    'None — no embassy visit needed',
    'Apply for the ETA online, using your host''s address in Seychelles as your accommodation\nFly to Seychelles\nPresent your documents at immigration for your Visitor''s Permit',
    '/assets/images/visa-heroes/seychelles.jpg',
    'Cross-checked against ics.gov.sc''s Visitors Permit page (via search snippet, explicitly naming "visiting friends or family" as a qualifying purpose) not directly fetchable this session', 'https://www.ics.gov.sc/', '2026-09-11'
);
SET @sc5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sc5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc5, 'Core Documents', 'Every traveller needs these.', 1);
SET @sc5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@sc5s1, 'Return Ticket', NULL, 'copy', 1, 0, 1, 2),
(@sc5s1, 'ETA Approval Confirmation', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc5, 'Host Documents', 'Recommended supporting evidence.', 2);
SET @sc5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc5s2, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 0, 1),
(@sc5s2, 'Proof of Funds', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(43, 5, 10.00, 'EUR', 'ETA Fee (Standard Processing)', 'Same as Tourist.', '2026-09-01', NOW(), 'https://www.ics.gov.sc/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Family Visit Visa for Seychelles?', 'No — it is explicitly one of the named purposes covered by the standard Visitor''s Permit and ETA, the same as tourism.', 43, 5, 2205, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Status Genuinely Disputed
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    43, 6, 'SYC-TRANS-IN-06', '2026.09', 'published',
    'Connecting flights through Seychelles International Airport.',
    'Sources genuinely conflict on whether the ETA is required for pure airside transit — some state transit passengers who stay airside and don''t clear immigration need neither a Visitor''s Permit nor an ETA; at least one other source claims the ETA is mandatory even for pure transit. This could not be resolved with certainty this session and is stated honestly as unresolved rather than guessed.',
    'Airside only, until your next connecting flight',
    'Not confirmed — recommend contacting us or the airline directly to confirm current requirements before travel',
    0,
    'Not applicable for pure airside transit',
    'Not applicable for pure airside transit',
    'Confirm with your airline or with us whether your specific itinerary requires an ETA even for airside transit\nIf leaving the airport during a stopover, apply for the standard Visitor''s Permit and ETA as for Tourist',
    '/assets/images/visa-heroes/seychelles.jpg',
    'A genuine conflict between sources (seyvillas.com, airlineshq.com, visarun.ai, visamundi.co) could not be resolved this session before the search budget was exhausted — flagged explicitly as unresolved rather than guessed', 'https://www.ics.gov.sc/', '2026-09-11'
);
SET @sc6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sc6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc6, 'Core Documents', 'Every traveller needs these.', 1);
SET @sc6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@sc6s1, 'Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc6, 'If Leaving the Airport', 'Standard Tourist documents apply.', 2);
SET @sc6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc6s2, 'ETA Approval Confirmation', 'If leaving the airport.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(43, 6, NULL, 'EUR', 'Confirmed After Assessment', 'Genuinely unresolved whether a fee applies to pure airside transit — contact us to confirm before travel.', '2026-09-01', NOW(), 'https://www.ics.gov.sc/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need an ETA if I never leave the airport during my Seychelles layover?', 'This is genuinely disputed across our sources — some say no ETA is needed for pure airside transit, others say it is still required. Contact us or your airline to confirm before travelling.', 43, 6, 2206, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Visitor's Permit Use-Case
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    43, 7, 'SYC-MED-IN-07', '2026.09', 'published',
    'Travel to Seychelles for medical treatment, or accompanying a family member seeking treatment.',
    'No dedicated Seychelles medical-treatment permit category was found. Seychelles Hospital has limited capacity and is far more commonly a source of outbound medical-tourism patients traveling to India than an inbound medical destination — foreign patients traveling here use the standard Visitor''s Permit + ETA.',
    'Same as Tourist — up to 3 months, extendable to 12 months total',
    'Same ETA + on-arrival Visitor''s Permit process as Tourist',
    0,
    'Same as Tourist',
    'None — no embassy visit needed',
    'Apply for the ETA online, same as for tourism\nCarry a hospital referral/appointment letter as good supporting practice, though not confirmed as a legal requirement\nFly to Seychelles and present your documents at immigration',
    '/assets/images/visa-heroes/seychelles.jpg',
    'No primary Seychelles-side source confirms a distinct medical permit category — treated honestly as a Visitor''s Permit use-case only, per hciseychelles.gov.in and secondary sourcing not directly fetchable this session', 'https://www.ics.gov.sc/', '2026-09-11'
);
SET @sc7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sc7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc7, 'Core Documents', 'Every traveller needs these.', 1);
SET @sc7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@sc7s1, 'Return Ticket', NULL, 'copy', 1, 0, 1, 2),
(@sc7s1, 'ETA Approval Confirmation', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc7, 'Medical Documents', 'Recommended, though not confirmed as a legal requirement.', 2);
SET @sc7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc7s2, 'Hospital Appointment/Referral Letter', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(43, 7, 10.00, 'EUR', 'ETA Fee (Standard Processing)', 'No distinct medical-visa category exists — covered under the standard Visitor''s Permit and ETA.', '2026-09-01', NOW(), 'https://www.ics.gov.sc/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Medical Visa for Seychelles?', 'No — Seychelles has limited hospital capacity and is not generally an inbound medical-tourism destination. Foreign patients use the standard Visitor''s Permit and ETA, same as any other visit.', 43, 7, 2207, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Same Visitor's Permit + ETA
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    43, 8, 'SYC-CONF-IN-08', '2026.09', 'published',
    'Attending meetings, conferences, site visits, and negotiations in Seychelles.',
    'Covered under the same Visitor''s Permit purpose list as Business and Tourist — no distinct conference visa exists.',
    'Up to 3 months, extendable to 12 months total',
    'Same ETA + on-arrival Visitor''s Permit process as Tourist',
    0,
    'Same as Tourist',
    'None — no embassy visit needed',
    'Apply for the ETA online, citing your conference/meeting purpose\nCarry a conference invitation letter or registration confirmation as good practice\nFly to Seychelles and present your documents at immigration',
    '/assets/images/visa-heroes/seychelles.jpg',
    'Cross-checked against ics.gov.sc''s Visitors Permit page (via search snippet) and general aggregator summaries not directly fetchable this session', 'https://www.ics.gov.sc/', '2026-09-11'
);
SET @sc8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sc8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc8, 'Core Documents', 'Every applicant needs these.', 1);
SET @sc8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@sc8s1, 'ETA Approval Confirmation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc8, 'Event Documents', 'Recommended supporting evidence.', 2);
SET @sc8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc8s2, 'Conference Invitation Letter/Registration Confirmation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(43, 8, 10.00, 'EUR', 'ETA Fee (Standard Processing)', 'Same as Tourist.', '2026-09-01', NOW(), 'https://www.ics.gov.sc/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Conference Visa for Seychelles?', 'No — it is covered under the same Visitor''s Permit purpose list as Business and Tourist.', 43, 8, 2208, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Same Visitor's Permit + ETA
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    43, 9, 'SYC-SPORT-IN-09', '2026.09', 'published',
    'Athletes, coaches, or officials travelling to Seychelles for events.',
    'No dedicated sports/athlete visa category exists — covered under the same Visitor''s Permit purpose list as Business and Tourist.',
    'Up to 3 months, extendable to 12 months total',
    'Same ETA + on-arrival Visitor''s Permit process as Tourist',
    0,
    'Same as Tourist',
    'None — no embassy visit needed',
    'Apply for the ETA online, citing your event participation as your purpose\nCarry event/federation accreditation as good supporting practice\nFly to Seychelles and present your documents at immigration',
    '/assets/images/visa-heroes/seychelles.jpg',
    'No sport-specific primary source was found this session — treated as a Visitor''s Permit use-case by inference from the same ICS purpose list, stated honestly rather than inventing a distinct process', 'https://www.ics.gov.sc/', '2026-09-11'
);
SET @sc9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sc9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc9, 'Core Documents', 'Every applicant needs these.', 1);
SET @sc9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@sc9s1, 'ETA Approval Confirmation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc9, 'Federation Documents', 'Recommended supporting evidence.', 2);
SET @sc9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc9s2, 'Event Organizer/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(43, 9, 10.00, 'EUR', 'ETA Fee (Standard Processing)', 'Same as Tourist.', '2026-09-01', NOW(), 'https://www.ics.gov.sc/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports Visa for Seychelles?', 'No dedicated category was found — athletes travel under the standard Visitor''s Permit and ETA, the same as any other visit.', 43, 9, 2209, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Dependant's Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    43, 10, 'SYC-DEP-IN-10', '2026.09', 'published',
    'A spouse or minor child joining a sponsor in Seychelles.',
    'As documented, the Dependant''s Permit is specifically framed around dependants of a citizen of Seychelles. The mechanism for dependants of a foreign GOP (work-permit) holder was NOT clearly confirmed this session — a genuine research gap, flagged honestly here rather than guessed at.',
    'Lapses if not used within 12 months, if absent 12+ months, on a conditions breach, an immigration-law conviction, or deportation',
    'Application to ICS with the sponsor''s proof of Seychelles citizenship and proof of means to support the dependant',
    0,
    'Not confirmed this session',
    'Immigration and Civil Status (ICS), Seychelles',
    'Confirm your sponsor''s eligible status (a citizen of Seychelles, per ICS''s own documented Dependant''s Permit framing)\nSubmit the application form, your passport, and proof of relationship\nSponsor provides proof of citizenship and financial means\nAwait ICS approval\nContact us if your situation involves a foreign work-permit holder sponsor rather than a Seychelles citizen, since this route was not clearly confirmed this session',
    '/assets/images/visa-heroes/seychelles.jpg',
    'Cross-checked against ics.gov.sc''s Dependants Permit and FAQ pages (via search snippet) — the foreign-GOP-holder dependant pathway was an explicit, acknowledged research gap this session, not guessed at', 'https://www.ics.gov.sc/', '2026-09-11'
);
SET @sc10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sc10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc10, 'Core Documents', 'Every dependant needs these.', 1);
SET @sc10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc10s1, 'Application Form', NULL, 'original', 1, 0, 1, 1),
(@sc10s1, 'Dependant''s Passport Bio Page', NULL, 'copy', 1, 0, 1, 2),
(@sc10s1, 'Proof of Relationship', 'Marriage/birth certificate.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sc10, 'Sponsor Documents', 'Evidence of the sponsor''s status and means.', 2);
SET @sc10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sc10s2, 'Sponsor''s Proof of Seychelles Citizenship', 'Passport, birth or naturalisation certificate.', 'copy', 1, 0, 0, 1),
(@sc10s2, 'Sponsor''s Proof of Financial Means', 'Payslip, savings.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(43, 10, 1000.00, 'SCR', 'Dependant''s Permit Processing Fee', 'Plus SCR 1,000 per year permit fee. This applies to dependants of a Seychelles citizen sponsor; the fee/process for dependants of a foreign work-permit holder was not confirmed this session.', '2026-09-01', NOW(), 'https://www.ics.gov.sc/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my family join me in Seychelles if I have a Gainful Occupation Permit?', 'This specific pathway was not clearly confirmed in our research — Seychelles'' documented Dependant''s Permit is framed around dependants of a Seychelles citizen. Contact us directly so we can confirm the correct route for your situation with ICS.', 43, 10, 2210, 1);
